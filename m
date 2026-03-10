Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED193064A3
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155689; cv=pass; b=nDHkUj7hBfCctpt44J9Js+5PRNT0RKJRA3eBWsgKJVTQSBUuP8KxFLM7S1Tq6W+nhvT41YkYo/hZdfXxH2j3EKv3LRj8LLqzIvZ9WGNvtt9WmNyb0s96Wri4HnfO2HKLLLUM6h9gm3iTiTNOibLTSxzJcM8dL1dNVd6e/hC3XqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155689; c=relaxed/simple;
	bh=KBcOi7xBnxC2wfgl+SVIrI7Expr5ofwcRAKEJFepSlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJnqOtLgJTMO8Ul7TmVN6v82cGmxrmMALC8RfGPkkqpgoCezdbesUPzkf/Z6iNisvqIVYrG+6HhY6Np9+MUXCFd2aODHl2CSLvleWRVrglQVRQ5yuvmdWldJlDu186UYqXeszSw4lpRPhnE2PIrESxemZAHvFDcxwrEMP3CQ9LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SaJ8cXU2; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaJ8cXU2"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128ce536fe0so12673c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 08:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773155687; cv=none;
        d=google.com; s=arc-20240605;
        b=CfZL0GI0xB+s+FIU8pXT+ozkUHHQlL12OBrMcU+5eUMom4sUwtJZK6HYiiEjfYBqVX
         DiiknyMwdpj4qXTe6Ww8bOs4A0qw5T4lUDzUlp5iCQPWcqKXGc1Kn91V0auc7QZqAqmr
         tfYACqZMhYXcxubi70UudT3waNUi0Xr+wZjV0svmZGxLCfEfOXyd4uL+0ia9nX8Ra1Ik
         RUjVp7grUrFz2G0YeTzhTTTT2f2OYH4YmG4KF5CycFfl8dPjFlBgx7jsUX9CFsf60zzj
         2X+sLjG1cdirIxfXX97+E0L32ea+KfXpNpPJzfPXXWZycu7kjab9KUPd46kVLzsveqog
         W+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QRvANnU2ZU8g5N5SXH34hBwFkah6eGwlIcFTy+QCyKs=;
        fh=11adqFY0sDxesEz9OeA+mo/o6Hj9B1470qPGMOtkdCY=;
        b=i9gRRm7QwvuKnoOZBr4AYZ1hPjvJ7F9EIr+yN/HpoOXY+IKzPwicSL2Sj/vw9hTDes
         eWKTiT3jgh1IW60Qsb97GFgM+LTH4g8UqNomDL9L1vFrML6KP276a82N5r6B2UfYlEMf
         0c9Yiv/VYp9VUK+sSmVDIq81N0u8DIq8UNHnKtrGRgXgebm0hqmOH0hs+P+0iX4LoXwj
         +tUjFx0LrLztFebOeWFhGTxOek1Y5qH6GhvcRrLrXkFvImCDwKVeZdplwAq7QdIz4AVF
         vJ65FJtdEN0Crk4VzQOTWEhUlzEBeF89K7jNmyGHOyHRl7JyHhbPxdG4n2aSDdWdXSDn
         NLBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773155687; x=1773760487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRvANnU2ZU8g5N5SXH34hBwFkah6eGwlIcFTy+QCyKs=;
        b=SaJ8cXU2nLsupsbOG2+XCNoRGEG5xJxBzIOT5HH8joKtGY3hWS5ScNwbuNpVFIPmcF
         y6r/MmbaZ6BXc9ObBc8p4OZVj3KZMDPi6ZMbqfGGnoJZOxtjN3mN3EJwmP8mcnFyCRzJ
         UFZM+Etzp1X0DW9QnJfBXRIRSOy7OQUR2UPQCC1qn8JPDaUnJ9tCJMk3hpY54liLvIuh
         vqnDNsrJ9kKUp1ai0U63d/SJEcOb1+aAIGXoDmKLfJDYoDeJ2W+0hHSqmwKaaWYFi+My
         UPKgJvJRXltGf1l1tYAMm2UqE06WDxllir31VSnAJZoR6FThsUl9wHPcx88ilELiS6bB
         +xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155687; x=1773760487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QRvANnU2ZU8g5N5SXH34hBwFkah6eGwlIcFTy+QCyKs=;
        b=l3AXXqP4e11whKN1U66LmURImcfCcWwgxWeW18yiDLy8Z4qMAFEbYcK2RsIV8sYA3d
         3yjIVomRf4foPQ2SYC8FMZCKNbYLNk8PEzK5dJU1TmcnnF/tgu6x/6pV7ghLLaiXjRhA
         6YxKXHwDYkbLmHjvb5jcMC+TvcqG/3GHDsK5Pzl7LttMsmw15xcEJsd4kWKLb50ssS+o
         NqJUuJZFs6uCBTIzSUpc1FjeWU5rpXc5e2QWWY4Eprx5Ps62TShXfGdjxbhNEpl0ueKM
         StXblsHhrSwS6YhVC3HOlHiqqxmyuPVnLvwxyMBndO2T4uyEcDoTIlwhbXibZS2TnRgU
         Izuw==
X-Forwarded-Encrypted: i=1; AJvYcCWJuH3hWq9BAjRKjtwyqqPaLeP25CcCQquRuwKmfd7FVXJOrc7BMXdmBEUdqurzG2QR+pn6JkK5hZjXN9b7+Kh1@vger.kernel.org
X-Gm-Message-State: AOJu0YzVKQa+yfiYnkKse57QXpdcKU8uGC6Er+zLtxy52HeVt6iIPUYh
	q5cuFly/YvFU7HWhqKzAR6DS9fg/cs6ThEB32871hRRx/bOISSPujgzMJv8MKh1KvIPJvJXuLU1
	v2cstnoPJ7ul3L/6N3uVQRrwKeNJKw+LV8+5aCZfe
X-Gm-Gg: ATEYQzwqEwk/b9oa4Gl6npBHAFvOgZ+tGVLWTr87XG4Ju3bTxLQAO5ZXMSDv9tmHCU4
	CXDb8FVSZU1mybcVfXaqRA80qLDuShxGVayCSt1IJ8Su7J9/Ql6XqcoNvkXFlaIrc8tdpYfJku2
	VLUJT+arzdTNEjvHv2UG99VKYeirQbN04Eac2/GN2fb+DfxmlFVOzi/lq2nhjD2UQMyOBZyeHft
	9DN7gVjSdE9hKOstBFe4UxeaAzMayYdj44eh1NCoakijJn67bGQ1g8XQiJrJSJ4lMFXhP4QxFNh
	sM8Vga936K7oWyFIv+jb1averGg6HI0jfuE=
X-Received: by 2002:a05:701b:240c:b0:124:748c:2ba5 with SMTP id
 a92af1059eb24-128ded303d2mr92041c88.13.1773155685951; Tue, 10 Mar 2026
 08:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155728.98026-1-jbrnak@redhat.com> <20260309155728.98026-3-jbrnak@redhat.com>
In-Reply-To: <20260309155728.98026-3-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Mar 2026 08:14:34 -0700
X-Gm-Features: AaiRm53BPJ0RBiTHtlpMJ4OULdsd8zTunFcO097ILpxH9H75gzAy_u5XLIPIBpk
Message-ID: <CAP-5=fWuirFLnL9PzQbyYSVhtSSXGStNUiOBdtOV4Y4W45v27Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] perf test: Provide setup for the shell test suite
To: Jakub Brnak <jbrnak@redhat.com>
Cc: acme@kernel.org, acme@redhat.com, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, mpetlan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:57=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wrot=
e:
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
> Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c  | 30 +++++++++++++++++++-----
>  tools/perf/tests/tests-scripts.c | 39 +++++++++++++++++++++++++++++---
>  tools/perf/tests/tests-scripts.h | 11 ++++++++-
>  tools/perf/tests/tests.h         |  8 ++++---
>  4 files changed, 75 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 06507066213b..c1515fa8a947 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -264,6 +264,22 @@ static test_fnptr test_function(const struct test_su=
ite *t, int test_case)
>         return t->test_cases[test_case].run_case;
>  }
>
> +/* If setup fails, skip all test cases */
> +static void check_shell_setup(const struct test_suite *t, int ret)
> +{
> +       struct shell_test_info *test_info;
> +
> +       if (!t->priv)
> +               return;
> +
> +       test_info =3D t->priv;
> +
> +       if (ret =3D=3D TEST_SETUP_FAIL)

The line above was flagged by AI review:

  Does `ret` here contain a positive exit status from the child
process? If `setup.sh` fails, `run_test_child()` returns
`TEST_SETUP_FAIL` (-4) negated, which becomes an exit status of 4.
Since `TEST_SETUP_FAIL` is -4, `ret =3D=3D TEST_SETUP_FAIL` will evaluate
to false (4 !=3D -4). This might cause the test suite state to
incorrectly transition to `PASSED_SETUP` instead of `FAILED_SETUP`,
skipping the failure path and causing `print_test_result()` to fall
into the default case instead of skipping the test.

> +               test_info->has_setup =3D FAILED_SETUP;
> +       else if (test_info->has_setup =3D=3D RUN_SETUP)
> +               test_info->has_setup =3D PASSED_SETUP;
> +}
> +
>  static bool test_exclusive(const struct test_suite *t, int test_case)
>  {
>         if (test_case <=3D 0)
> @@ -353,10 +369,9 @@ static int run_test_child(struct child_process *proc=
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
> @@ -373,7 +388,8 @@ static int print_test_result(struct test_suite *t, in=
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
> @@ -488,6 +504,7 @@ static void finish_test(struct child_test **child_tes=
ts, int running_test, int c
>         }
>         /* Clean up child process. */
>         ret =3D finish_command(&child_test->process);
> +       check_shell_setup(t, ret);
>         if (verbose > 1 || (verbose =3D=3D 1 && ret =3D=3D TEST_FAIL))
>                 fprintf(stderr, "%s", err_output.buf);
>
> @@ -510,7 +527,8 @@ static int start_test(struct test_suite *test, int cu=
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
> index 0f167365fb05..3703ad7b3b75 100644
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
> @@ -196,6 +202,7 @@ static void free_suite(struct test_suite *suite)
>
>  static int shell_test__run(struct test_suite *test, int subtest)
>  {
> +       struct shell_test_info *test_info =3D test->priv;
>         const char *file;
>         int err;
>         char *cmd =3D NULL;
> @@ -206,6 +213,23 @@ static int shell_test__run(struct test_suite *test, =
int subtest)
>         else    /* Single test case */
>                 file =3D test->test_cases[0].name;
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

If `perf test` is run in parallel mode (`!sequential`), will
`start_test()` fork a child process for each test case immediately?
Since the parent process hasn't executed the setup, all child
processes will inherit `test_info->has_setup =3D=3D RUN_SETUP` and execute
`setup.sh` concurrently via `system(setup_script)` here. Could this
lead to race conditions if the setup script modifies shared state?

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
> @@ -247,6 +271,7 @@ static struct test_suite *prepare_test_suite(int dir_=
fd)
>         }
>
>         test_info->base_path =3D strdup_check(dirpath);           /* Abso=
lute path to dir */
> +       test_info->has_setup =3D NO_SETUP;
>
>         test_suite->priv =3D test_info;
>         test_suite->desc =3D NULL;
> @@ -329,7 +354,7 @@ static void append_scripts_in_subdir(int dir_fd,
>         int n_dirs, i;
>
>         /* List files, sorted by alpha */
> -       n_dirs =3D scandirat(dir_fd, ".", &entlist, NULL, alphasort);
> +       n_dirs =3D scandirat(dir_fd, ".", &entlist, setup_filter, alphaso=
rt);
>         if (n_dirs =3D=3D -1)
>                 return;
>         for (i =3D 0; i < n_dirs && (ent =3D entlist[i]); i++) {
> @@ -413,8 +438,16 @@ static void append_suites_in_dir(int dir_fd,
>                         continue;
>                 }
>
> -               /* If no setup, set name to the directory */
> -               test_suite->desc =3D strdup_check(ent->d_name);
> +               if (is_test_script(fd, SHELL_SETUP)) {  /* Check for setu=
p existence */
> +                       char *desc =3D shell_test__description(fd, SHELL_=
SETUP);

AI review is flagging that desc may be NULL and lead to a SEGV:
  Can `shell_test__description()` return NULL if `setup.sh` lacks a
description format? If it does, `test_suite->desc` will be assigned
NULL without falling back to the directory name. Later on, could this
trigger a segmentation fault when `__cmd_test()` passes the
description pointer to `strlen()`?

Thanks,
Ian

> +
> +                       /* Set the suite name by the setup description */
> +                       test_suite->desc =3D desc;
> +                       ((struct shell_test_info *)(test_suite->priv))->h=
as_setup =3D RUN_SETUP;
> +               } else {
> +                       /* If no setup, set name to the directory */
> +                       test_suite->desc =3D strdup_check(ent->d_name);
> +               }
>
>                 append_suite(result, result_sz, test_suite);
>                 close(fd);
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-sc=
ripts.h
> index 1b849d4e70f4..013031239883 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -4,9 +4,18 @@
>
>  #include "tests.h"
>
> -/* Additional information attached to shell tests */
> +#define SHELL_SETUP "setup.sh"
> +
> +enum shell_setup {
> +       NO_SETUP     =3D 0,
> +       RUN_SETUP    =3D 1,
> +       FAILED_SETUP =3D 2,
> +       PASSED_SETUP =3D 3,
> +};
> +
>  struct shell_test_info {
>         const char *base_path;
> +       enum shell_setup has_setup;
>  };
>
>  struct test_suite **create_script_test_suites(void);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index f5f1238d1f7f..aa91859aeeb7 100644
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
> 2.52.0
>
