# Quiz Management (Rails)

This Rails 7 application provides a simple quiz management system:

- Admin UI (ActiveAdmin) to create quizzes, questions and options.
- Devise-based authentication for both site users and admin users.
- Users can view quizzes and submit answers; submissions and per-question answers are recorded.

**Quick summary**
- **Ruby:** 3.2.2 (see `Gemfile`)
- **Framework:** Rails ~> 7.0.10
- **DB:** PostgreSQL (`pg` gem)
- **Auth:** `devise` (for `User` and `AdminUser`)
- **Admin:** `activeadmin`

**Project layout (important files)**
- `app/models/quiz.rb`, `question.rb`, `option.rb` — quiz structure and nested models
- `app/models/quiz_submission.rb`, `submission_answer.rb` — submission tracking
- `app/controllers/quizzes_controller.rb` — public index/show and `submit` action
- `app/controllers/quiz_submissions_controller.rb` — user submissions index/show
- `app/admin/*` — ActiveAdmin resources (quizzes, quiz_submissions)
- `app/views/quizzes/show.html.erb` — quiz page where users submit answers
- `config/routes.rb` — public routes and submission endpoints

**Schema highlights** (from `db/schema.rb`)
- `quizzes` — `title:string`, `description:text`
- `questions` — `quiz_id:bigint`, `content:string`, `question_type:string`, `correct_answer:string`
- `options` — `question_id:bigint`, `text:string`
- `quiz_submissions` — `user_id:bigint`, `quiz_id:bigint`, `score:integer`
- `submission_answers` — `quiz_submission_id:bigint`, `question_id:bigint`, `user_anser:string`, `correct:boolean`

Note: the submission answer column is named `user_anser` in the schema (typo). Code and views currently use the same name, so be careful if you rename this column.

**Local setup**
Prerequisites:
- Ruby 3.2.2 and Bundler
- PostgreSQL server

Commands to get running locally:
```bash
# install gems
bundle install

# create & migrate the database
bin/rails db:create db:migrate db:seed

# start the app
bin/rails server
```

Visit `http://localhost:3000` to see the quizzes index. ActiveAdmin is mounted at `/admin`.

Default development admin user (created by `db/seeds.rb`):
- email: `admin@example.com`
- password: `password`

**Authentication & Usage**
- Users: can sign up / sign in using Devise (routes provided via `devise_for :users`). After signing in, users can view a quiz and submit answers.
- Admins: manage quizzes/questions/options and view submissions via ActiveAdmin at `/admin` (AdminUser with Devise).

Submitting a quiz
- The quiz `show` view posts answers as `answers[QUESTION_ID]` to the `submit` action (route: `POST /quizzes/:quiz_id/submit`).
- The `QuizzesController#submit` action compares the submitted answer (string) to the `question.correct_answer` string and stores a `submission_answer` with `user_anser` (string) and `correct` (boolean).

Notes & gotchas
- The app compares answer strings directly. If you prefer to store correct answers as option IDs (safer for MCQs), update the questions/options flow and submission comparison logic accordingly.
- The admin uses nested forms (`accepts_nested_attributes_for`) to create questions and options inline from ActiveAdmin.
- If you rename `user_anser` to `user_answer`, update the model, migration, and views accordingly.

**Testing**
- Basic Rails tests can be run with:
```bash
bin/rails test
```

**Common tasks**
- Create a new admin user (Rails console):
```ruby
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
```
- Recreate DB (dangerous — will wipe data):
```bash
bin/rails db:drop db:create db:migrate db:seed
```

If you'd like, I can:
- Add a `README` section describing the admin UI (screenshots or example flows).
- Convert the submission comparison to use option IDs for MCQs.
- Add a small system test demonstrating quiz submission.

---
Generated from the repository structure on 2025-11-29.
