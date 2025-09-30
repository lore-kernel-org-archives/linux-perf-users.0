Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0758D1FF7B3
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258311; cv=none; b=o/QzBMs7+3KuPN7uXM8T8G0kjazPLn+bRctv0TxRRUB8wWi/c/o8Iy3LFDdeB/HYKPCJ3NUg6kv9pinwdayjeWjlj71+XCZL2x1sY8j2NU3rwJHkeqKu0oWJ6DqBjW7eLYCKdy1VofoE2SgEO7CwJHhhLBuWWOPzSNqZEbDwPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258311; c=relaxed/simple;
	bh=c6aARP6HySPNXZHWxDWZYoOp62KGXVGBclbtnOkB+SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLRrhHNbgvRAW9vSt37thZ5ICq/qmOLKLDPbI0S6fm9b/lC9I3AMn9Y47rNWqPocUVYsu8cxQqVwVug+/vqeoI1Oxb8uFUAwOWNGkdR5VEc94CAaMSvEpz1LEMb4qoVAB8TEPd38jI62bMev61UGUA8zmLZ9Gp/pHJqV0YMFC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zq8VQV5K; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zq8VQV5K"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d67abd215so36915ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759258309; x=1759863109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLdWbyUPTqYGHrb/St2KHAyIDNInCGbWMUFwK1oXl8o=;
        b=zq8VQV5KwxbmBP4C4VTd5WzrXwAlPvlb3cbE3tEz4HxJ6YYfPeQycbJodq9vyZ1PyS
         wYQguGLEgE06Msk+fMPF+GFvSxnz9oatC5u6sFrk3fkV2SnhOMC2JyPi/FHWmQ76OOUh
         hwB0qJcSVSvlMDmsM6lYsaK605X9Cut2Q+zek4DQ5IOlV2uKnnKgD82B/3P/S4RBfTCO
         2g7xDg0TGTeQtvc8wZrBImwZatcLmI7Ss/oamtrfNsRcSluqDO58ZEw6bvQZDiPZhcCI
         DIIHPrKJ8D33c/nPwSkg3vWlm9foKG4yK7zEENHXwABET8j/nFmHlq8EOFDfauJMYIPn
         VSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258309; x=1759863109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLdWbyUPTqYGHrb/St2KHAyIDNInCGbWMUFwK1oXl8o=;
        b=qsZAy4y0qc8N6yr52OeD8ZmcBbv08dgjVK22ciHd6UJVU1C1lY/+t9cliqF5Uhe2eo
         P/EVNDkduWLsJZkSaX8Vai98bmQucn/38kvTFgMsy8O9q2PhJR0NYuNKrBneUCMF9o9l
         SjiWtdi517iu29RCIOT9Vtmq68ESl9Pyo2+ZWUBgi0o/7flVu5DWtqmmKuqv8Hwk+ZTD
         p4558r7pXv+if8mI+fSKwTGuDjlhXr3mSxfAZOhjCh/xOxbwERp9JooAlGaSUE3WGJgZ
         rE6Lhcr53yOF9DFA9XZaijoRyb9mITIRiEwt79KELjiebi+3dFePdc31KlwqBfWM6ujH
         bw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLHEWTkG6xymBsktcDgo/B+K4xgk77LjVZVLvQ6eDtcSw+ZrMOU9SmvsKy39rYKQnLt8nr0V2WOUKQD8DCMYk+@vger.kernel.org
X-Gm-Message-State: AOJu0YzqyS5A0hDZKHoRy7hPtQWrnY/kIA55khdK2+lVKfgL2LLMulbU
	gRR/TU4tQT6GeHgRzB70TgXhj7K+qy2xvRZ6lrh9VEEMDkEwk2b3AgM8eXuSQJjrKOY5QtfV7jB
	gdfCs7UDZdtuG5eTaGJVPIMyB6XfXA/+wYSLBEkQA
X-Gm-Gg: ASbGnct/2TWGo1fNmF/jM7C3/COkqOO79BspExGeM5fisUjaMT+Z1tjzfdlbLaiYHgR
	cRA6YL4cwvQeJEu2rtg+5g3UiKUcPOXcTaRtwAnxDjb9Q3Df9mcsNSh8jOQTPN+OD8asFBbXwVJ
	7fBNJtEUX2zkq2WHIoUHhKXYbYXHQ8dAhC3t06fpCApyeLVCsFz4CR4eaUYM/QF7XteqjlnrZno
	b1t8TtefQ2AKiuBtHlw2Qk4o62z+MnwIcvfLv+f22F1zU+2Q3X2AZMqIu3FAAJokffTUxE+XgeE
	8/Y=
X-Google-Smtp-Source: AGHT+IH7WBu2TUGx6L1UvhEZ/Mf/fmyBmuHhmcq8hsw5GO5D9bshjy3cON7R/5sjqA2IcO3qfD5J3K9LZKs6PSJ4XUE=
X-Received: by 2002:a17:903:2c08:b0:26e:ac44:3b44 with SMTP id
 d9443c01a7336-28e8003dd19mr706455ad.10.1759258308768; Tue, 30 Sep 2025
 11:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930160923.13728-1-jbrnak@redhat.com> <20250930160923.13728-4-jbrnak@redhat.com>
In-Reply-To: <20250930160923.13728-4-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 11:51:36 -0700
X-Gm-Features: AS18NWA7MniDWOIWbuZ-mHI7kz8knvh-AeH5S7raZp-WfIrQPmLDLPhbd97xgD4
Message-ID: <CAP-5=fWrdQy750vhuZ204Q6PJjhuy2Gg_OEPs+2h21bkfceMgQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] perf test: Provide setup for the shell test suite
To: Jakub Brnak <jbrnak@redhat.com>
Cc: namhyung@kernel.org, acme@kernel.org, acme@redhat.com, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:09=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
te:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> Some of the perftool-testsuite test cases require a setup to be done
> beforehand as may be recording data, setting up cache or restoring sample
> rate. The setup file also provides the possibility to set the name of
> the test suite, if the name of the directory is not good enough.
>
> Check for the existence of the "setup.sh" script for the shell test
> suites and run it before the any of the test cases. If the setup fails,
> skip all of the test cases of the test suite as the setup may be
> required for the result to be valid.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/builtin-test.c  | 30 +++++++++++++++++++-----
>  tools/perf/tests/tests-scripts.c | 39 +++++++++++++++++++++++++++++---
>  tools/perf/tests/tests-scripts.h | 10 ++++++++
>  tools/perf/tests/tests.h         |  8 ++++---
>  4 files changed, 75 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 85142dfb3e01..6fc031ef50ea 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -258,6 +258,22 @@ static test_fnptr test_function(const struct test_su=
ite *t, int test_case)
>         return t->test_cases[test_case].run_case;
>  }
>
> +/* If setup fails, skip all test cases */
> +static void check_shell_setup(const struct test_suite *t, int ret)
> +{
> +       struct shell_info *test_info;
> +
> +       if (!t->priv)
> +               return;
> +
> +       test_info =3D t->priv;
> +
> +       if (ret =3D=3D TEST_SETUP_FAIL)
> +               test_info->has_setup =3D FAILED_SETUP;
> +       else if (test_info->has_setup =3D=3D RUN_SETUP)
> +               test_info->has_setup =3D PASSED_SETUP;
> +}
> +
>  static bool test_exclusive(const struct test_suite *t, int test_case)
>  {
>         if (test_case <=3D 0)
> @@ -347,10 +363,9 @@ static int run_test_child(struct child_process *proc=
ess)
>         return -err;
>  }
>
> -#define TEST_RUNNING -3
> -
> -static int print_test_result(struct test_suite *t, int curr_suite, int c=
urr_test_case,
> -                            int result, int width, int running)
> +static int print_test_result(struct test_suite *t, int curr_suite,
> +                            int curr_test_case, int result, int width,
> +                            int running)
>  {
>         if (test_suite__num_test_cases(t) > 1) {
>                 int subw =3D width > 2 ? width - 2 : width;
> @@ -367,7 +382,8 @@ static int print_test_result(struct test_suite *t, in=
t curr_suite, int curr_test
>         case TEST_OK:
>                 pr_info(" Ok\n");
>                 break;
> -       case TEST_SKIP: {
> +       case TEST_SKIP:
> +       case TEST_SETUP_FAIL:{
>                 const char *reason =3D skip_reason(t, curr_test_case);
>
>                 if (reason)
> @@ -482,6 +498,7 @@ static void finish_test(struct child_test **child_tes=
ts, int running_test, int c
>         }
>         /* Clean up child process. */
>         ret =3D finish_command(&child_test->process);
> +       check_shell_setup(t, ret);
>         if (verbose > 1 || (verbose =3D=3D 1 && ret =3D=3D TEST_FAIL))
>                 fprintf(stderr, "%s", err_output.buf);
>
> @@ -504,7 +521,8 @@ static int start_test(struct test_suite *test, int cu=
rr_suite, int curr_test_cas
>                         err =3D test_function(test, curr_test_case)(test,=
 curr_test_case);
>                         pr_debug("---- end ----\n");
>                         print_test_result(test, curr_suite, curr_test_cas=
e, err, width,
> -                                         /*running=3D*/0);
> +                                 /*running=3D*/0);
> +                       check_shell_setup(test, err);
>                 }
>                 return 0;
>         }
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index e47f7eb50a73..10aab7c19ffe 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -138,6 +138,12 @@ static bool is_test_script(int dir_fd, const char *n=
ame)
>         return is_shell_script(dir_fd, name);
>  }
>
> +/* Filter for scandir */
> +static int setup_filter(const struct dirent *entry)
> +{
> +       return strcmp(entry->d_name, SHELL_SETUP);
> +}
> +
>  /* Duplicate a string and fall over and die if we run out of memory */
>  static char *strdup_check(const char *str)
>  {
> @@ -178,6 +184,7 @@ static void free_suite(struct test_suite *suite)
>
>  static int shell_test__run(struct test_suite *test, int subtest)
>  {
> +       struct shell_info *test_info =3D test->priv;
>         const char *file;
>         int err;
>         char *cmd =3D NULL;
> @@ -189,6 +196,23 @@ static int shell_test__run(struct test_suite *test, =
int subtest)
>                 file =3D test->test_cases[0].name;
>         }
>
> +       /* Run setup if needed */
> +       if (test_info->has_setup =3D=3D RUN_SETUP) {
> +               char *setup_script;
> +
> +               if (asprintf(&setup_script, "%s%s%s", test_info->base_pat=
h,
> +                            SHELL_SETUP, verbose ? " -v" : "") < 0)
> +                       return TEST_SETUP_FAIL;
> +
> +               err =3D system(setup_script);
> +               free(setup_script);
> +
> +                       if (err)
> +                               return TEST_SETUP_FAIL;
> +       } else if (test_info->has_setup =3D=3D FAILED_SETUP) {
> +               return TEST_SKIP; /* Skip test suite if setup failed */
> +       }
> +
>         if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
>                 return TEST_FAIL;
>
> @@ -230,6 +254,7 @@ static struct test_suite *prepare_test_suite(int dir_=
fd)
>         }
>
>         test_info->base_path =3D strdup_check(dirpath);           /* Abso=
lute path to dir */
> +       test_info->has_setup =3D NO_SETUP;
>
>         test_suite->priv =3D test_info;
>         test_suite->desc =3D NULL;
> @@ -312,7 +337,7 @@ static void append_scripts_in_subdir(int dir_fd,
>         int n_dirs, i;
>
>         /* List files, sorted by alpha */
> -       n_dirs =3D scandirat(dir_fd, ".", &entlist, NULL, alphasort);
> +       n_dirs =3D scandirat(dir_fd, ".", &entlist, setup_filter, alphaso=
rt);
>         if (n_dirs =3D=3D -1)
>                 return;
>         for (i =3D 0; i < n_dirs && (ent =3D entlist[i]); i++) {
> @@ -409,8 +434,16 @@ static void append_suites_in_dir(int dir_fd,
>                         continue;
>                 }
>
> -               /* If no setup, set name to the directory */
> -               test_suite->desc =3D strdup_check(ent->d_name);
> +               if (is_test_script(fd, SHELL_SETUP)) {  /* Check for setu=
p existence */
> +                       char *desc =3D shell_test__description(fd, SHELL_=
SETUP);
> +
> +                       /* Set the suite name by the setup description */
> +                       test_suite->desc =3D desc;
> +                       ((struct shell_info *)(test_suite->priv))->has_se=
tup =3D RUN_SETUP;
> +               } else {
> +                       /* If no setup, set name to the directory */
> +                       test_suite->desc =3D strdup_check(ent->d_name);
> +               }
>
>                 append_suite(result, result_sz, test_suite);
>                 close(fd);
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-sc=
ripts.h
> index 60a1a19a45c9..da4dcd26140c 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -4,8 +4,18 @@
>
>  #include "tests.h"
>
> +#define SHELL_SETUP "setup.sh"
> +
> +enum shell_setup {
> +       NO_SETUP     =3D 0,
> +       RUN_SETUP    =3D 1,
> +       FAILED_SETUP =3D 2,
> +       PASSED_SETUP =3D 3,
> +};
> +
>  struct shell_info {
>         const char *base_path;
> +       enum shell_setup has_setup;
>  };
>
>  struct test_suite **create_script_test_suites(void);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 97e62db8764a..9f3e3b90f1ac 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -6,9 +6,11 @@
>  #include "util/debug.h"
>
>  enum {
> -       TEST_OK   =3D  0,
> -       TEST_FAIL =3D -1,
> -       TEST_SKIP =3D -2,
> +       TEST_OK         =3D  0,
> +       TEST_FAIL               =3D -1,
> +       TEST_SKIP       =3D -2,
> +       TEST_RUNNING    =3D -3,
> +       TEST_SETUP_FAIL =3D -4,
>  };
>
>  #define TEST_ASSERT_VAL(text, cond)                                     =
\
> --
> 2.50.1
>
