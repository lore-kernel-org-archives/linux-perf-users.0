Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B13185B67
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258188; cv=none; b=kp+J0nzNqCkuluHiC6XA1wZabz0gblZ5MNTvNL0V8nNty/daHomgwVgdPPwUlou5yNPp2On6o86hfssmE9fLA0MO1ySFmoE/WFyoaxO1qfEmcgVCcmBPBA6kHnHknJ9tiu5WtkRYXRB35mLrbwoeoqojKrm5u6SjSBBLNN57h2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258188; c=relaxed/simple;
	bh=rrvTmiQHoLbY6GA247cXqaP5ruHIrd218zwwJ6z88rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upzEES+1asC976zo+/baNuwEC8mEiVS+1+pKbxvwTJScxrpdlIAPznHIqCY2ULLrJ6mhSCC1C20Ytf+iTu/vwTRVI2yzxf+ZcndJS6wUe7RYB1oPzwTuRNkgEXwsnJ4vwr2eiF4cibHhApfvFWVq3sgV5DOabt8UzI5TExK5XiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yb/QlUam; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yb/QlUam"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2731ff54949so30475ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759258186; x=1759862986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CafYW9JCVHk3LRqVoUK8T+mfYpIQDIKvvil2TcyFbUc=;
        b=yb/QlUamEzloGdMwJY2WOjMKgzOSHAKlBSZeYiGgbzHgEatsvHVeNC4DtSJqEI2iuy
         RnBTirEIX1C4JqaX6cXJUSz6MvVMiQuunT1UR4azPnJlCBxbDrVa17c2ah6DYDHSZZlJ
         Sh01rS7lj0ooDf/wai8Iky3NJxf/KdhnFMJyEVQPxvB6AF/bQNdn0AT2HbIv9eYslsHE
         NAO9fo3l/Bz/sun9AaNzk6Gnob4juUEK2JtIZqNPWVLyk8zdYdF+xway+0DquU64rIuJ
         tvZbleQAqeO2ErgZJTjEqald1c4WCx9/uXQC5rOvogsAsAooEKfJYrje31SR8uqcpH5n
         eT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258186; x=1759862986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CafYW9JCVHk3LRqVoUK8T+mfYpIQDIKvvil2TcyFbUc=;
        b=GV0emn/t11MH6RibFEYEyUUelQQ9drcjOzRpWJCGo+WiCDU+0M3H0RaWbe+dlGGGLw
         oepbGuMK5flVy+ONhVxgWYCFAmiIWVkY0ytk2NLNgLGDuk+uAK3vyLrrbyw8pH6rBmxo
         Wm5WZzMgBOrzLY//dIWJgMEFgUAxz2FqHsjc5zitnImaFB8Gi5uD/ankmZQnU+Unk3Xa
         VR/OCM6C0/FLxklS/N42QlxmjxpF/Rm1UKcMd91UE2yCtWvC7T252X6zbzKTsN3Zm9PY
         q3HIx5XGL0UXcxSukTzOSBDrjHRXDelPEIIkyoCHbZ6FLs1Mj/aEek6rWDFAJcx6I2ds
         7mPg==
X-Forwarded-Encrypted: i=1; AJvYcCVkCpJ5lpE6Wqw+p7cyMtPl28lqT+0Mxl/olanPkffSRhUiVJvflpmfrNne792lVtnu+s5KRhVzXk/tJVQfkxsr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy88hHGarN6njRL3bFaCd/ncGEfzxj1ctdYMUOO+Kpbi7WXmbt6
	Go4rEQU0aDpVxSGGhzXOKrxzDDtkFjxWPa9Un+asSr91RhPPpgR5K9U0q+3CHrIEVrLhqREjiad
	TblxYFyV0q8uX879OusjyT5jNeKbUFzXgZjrSBToe
X-Gm-Gg: ASbGnctBQ3GzvBqUiYZoZUjBzBn43KCLae8J8oBwZ2F9eT+MlyxhDdIn6BIVO20ixNd
	rrjETTUkrGjFbNPoXvLgXBtLOVT+bDUr6r0EgU4WeB22AJZ8QTPdpiyXUePw8Tqj3lRUSbvFjNE
	+nDNvMU3grIEiZbFNJ5AjSSS9CXF99O5Qk7C4S+3TSttOm4fob5j49gEmFgyJHYocYweL20vDLD
	YlqhP2dYyQazSRTUOi8yCBYknrduhWBSXLBMb+a1R9QglWaLGwZiSq8q99VWEbwDNmSstkFD/r/
	UBs=
X-Google-Smtp-Source: AGHT+IEXBJF+xqUmFBZ/VkdEejKOIhuu6z2ZpMuSeK93GDYBnUxia/ginTZLE1vRR5tQniZZW/A/OIhr76qlTCdUu1w=
X-Received: by 2002:a17:903:4b0c:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-28e80054ba7mr664965ad.16.1759258185251; Tue, 30 Sep 2025
 11:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930160923.13728-1-jbrnak@redhat.com> <20250930160923.13728-3-jbrnak@redhat.com>
In-Reply-To: <20250930160923.13728-3-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 11:49:34 -0700
X-Gm-Features: AS18NWAJbF4pTEfMFJyW-IDqe73ageLGnp9T9EFs2Z3aQFn6v_HwbcT4ACbqbdY
Message-ID: <CAP-5=fWvNOhPA7JnzdraF-VWDsBUKJYREx4WbOdFC4piq75KfQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] perf tests: Create a structure for shell tests
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
> The general structure of test suites with test cases has been implemented
> for C tests for some time, while shell tests were just all put into a lis=
t
> without any possible structuring.
>
> Provide the same possibility of test suite structure for shell tests. The
> suite is created for each subdirectory located in the 'perf/tests/shell'
> directory that contains at least one test script. All of the deeper level=
s
> of subdirectories will be merged with the first level of test cases.
> The name of the test suite is the name of the subdirectory, where the tes=
t
> cases are located. For all of the test scripts that are not in any
> subdirectory, a test suite with a single test case is created as it has
> been till now.
>
> The new structure of the shell tests for 'perf test list':
>     77: build id cache operations
>     78: coresight
>     78:1: CoreSight / ASM Pure Loop
>     78:2: CoreSight / Memcpy 16k 10 Threads
>     78:3: CoreSight / Thread Loop 10 Threads - Check TID
>     78:4: CoreSight / Thread Loop 2 Threads - Check TID
>     78:5: CoreSight / Unroll Loop Thread 10
>     79: daemon operations
>     80: perf diff tests
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/tests-scripts.c | 229 ++++++++++++++++++++++++++-----
>  tools/perf/tests/tests-scripts.h |   4 +
>  2 files changed, 195 insertions(+), 38 deletions(-)
>
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index f18c4cd337c8..e47f7eb50a73 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -151,14 +151,47 @@ static char *strdup_check(const char *str)
>         return newstr;
>  }
>
> -static int shell_test__run(struct test_suite *test, int subtest __maybe_=
unused)
> +/* Free the whole structure of test_suite with its test_cases */
> +static void free_suite(struct test_suite *suite)
>  {
> -       const char *file =3D test->priv;
> +       if (suite->test_cases) {
> +               int num =3D 0;
> +
> +               while (suite->test_cases[num].name) { /* Last case has na=
me set to NULL */
> +                       free((void *) suite->test_cases[num].name);
> +                       free((void *) suite->test_cases[num].desc);
> +                       num++;
> +               }
> +               free(suite->test_cases);
> +       }
> +       if (suite->desc)
> +               free((void *) suite->desc);
> +       if (suite->priv) {
> +               struct shell_info *test_info =3D suite->priv;
> +
> +               free((void *) test_info->base_path);
> +               free(test_info);
> +       }
> +
> +       free(suite);
> +}
> +
> +static int shell_test__run(struct test_suite *test, int subtest)
> +{
> +       const char *file;
>         int err;
>         char *cmd =3D NULL;
>
> +       /* Get absolute file path */
> +       if (subtest >=3D 0) {
> +               file =3D test->test_cases[subtest].name;
> +       } else {                /* Single test case */
> +               file =3D test->test_cases[0].name;
> +       }

nit: I think style wise the curlies shouldn't be here:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-bra=
ces-and-spaces

> +
>         if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
>                 return TEST_FAIL;
> +
>         err =3D system(cmd);
>         free(cmd);
>         if (!err)
> @@ -167,63 +200,155 @@ static int shell_test__run(struct test_suite *test=
, int subtest __maybe_unused)
>         return WEXITSTATUS(err) =3D=3D 2 ? TEST_SKIP : TEST_FAIL;
>  }
>
> -static void append_script(int dir_fd, const char *name, char *desc,
> -                         struct test_suite ***result,
> -                         size_t *result_sz)
> +static struct test_suite *prepare_test_suite(int dir_fd)
>  {
> -       char filename[PATH_MAX], link[128];
> -       struct test_suite *test_suite, **result_tmp;
> -       struct test_case *tests;
> +       char dirpath[PATH_MAX], link[128];
>         ssize_t len;
> -       char *exclusive;
> +       struct test_suite *test_suite =3D NULL;
> +       struct shell_info *test_info;
>
> +       /* Get dir absolute path */
>         snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> -       len =3D readlink(link, filename, sizeof(filename));
> +       len =3D readlink(link, dirpath, sizeof(dirpath));
>         if (len < 0) {
>                 pr_err("Failed to readlink %s", link);
> -               return;
> +               return NULL;
>         }
> -       filename[len++] =3D '/';
> -       strcpy(&filename[len], name);
> +       dirpath[len++] =3D '/';
> +       dirpath[len] =3D '\0';
>
> -       tests =3D calloc(2, sizeof(*tests));
> -       if (!tests) {
> -               pr_err("Out of memory while building script test suite li=
st\n");
> -               return;
> -       }
> -       tests[0].name =3D strdup_check(name);
> -       exclusive =3D strstr(desc, " (exclusive)");
> -       if (exclusive !=3D NULL) {
> -               tests[0].exclusive =3D true;
> -               exclusive[0] =3D '\0';
> -       }
> -       tests[0].desc =3D strdup_check(desc);
> -       tests[0].run_case =3D shell_test__run;
>         test_suite =3D zalloc(sizeof(*test_suite));
>         if (!test_suite) {
>                 pr_err("Out of memory while building script test suite li=
st\n");
> -               free(tests);
> -               return;
> +               return NULL;
>         }
> -       test_suite->desc =3D desc;
> -       test_suite->test_cases =3D tests;
> -       test_suite->priv =3D strdup_check(filename);
> +
> +       test_info =3D zalloc(sizeof(*test_info));
> +       if (!test_info) {
> +               pr_err("Out of memory while building script test suite li=
st\n");
> +               return NULL;
> +       }
> +
> +       test_info->base_path =3D strdup_check(dirpath);           /* Abso=
lute path to dir */
> +
> +       test_suite->priv =3D test_info;
> +       test_suite->desc =3D NULL;
> +       test_suite->test_cases =3D NULL;
> +
> +       return test_suite;
> +}
> +
> +static void append_suite(struct test_suite ***result,
> +                         size_t *result_sz, struct test_suite *test_suit=
e)
> +{
> +       struct test_suite **result_tmp;
> +
>         /* Realloc is good enough, though we could realloc by chunks, not=
 that
>          * anyone will ever measure performance here */
>         result_tmp =3D realloc(*result, (*result_sz + 1) * sizeof(*result=
_tmp));
>         if (result_tmp =3D=3D NULL) {
>                 pr_err("Out of memory while building script test suite li=
st\n");
> -               free(tests);
> -               free(test_suite);
> +               free_suite(test_suite);
>                 return;
>         }
> +
>         /* Add file to end and NULL terminate the struct array */
>         *result =3D result_tmp;
>         (*result)[*result_sz] =3D test_suite;
>         (*result_sz)++;
>  }
>
> -static void append_scripts_in_dir(int dir_fd,
> +static void append_script_to_suite(int dir_fd, const char *name, char *d=
esc,
> +                                       struct test_suite *test_suite, si=
ze_t *tc_count)
> +{
> +       char file_name[PATH_MAX], link[128];
> +       struct test_case *tests;
> +       size_t len;
> +       char *exclusive;
> +
> +       if (!test_suite)
> +               return;
> +
> +       /* Requires an empty test case at the end */
> +       tests =3D realloc(test_suite->test_cases, (*tc_count + 2) * sizeo=
f(*tests));
> +       if (!tests) {
> +               pr_err("Out of memory while building script test suite li=
st\n");
> +               return;
> +       }
> +
> +       /* Get path to the test script */
> +       snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> +       len =3D readlink(link, file_name, sizeof(file_name));
> +       if (len < 0) {
> +               pr_err("Failed to readlink %s", link);
> +               return;
> +       }
> +       file_name[len++] =3D '/';
> +       strcpy(&file_name[len], name);
> +
> +       /* Get path to the script from base dir */
> +       tests[(*tc_count)].name =3D strdup_check(file_name);
> +       tests[(*tc_count)].exclusive =3D false;
> +       exclusive =3D strstr(desc, " (exclusive)");
> +       if (exclusive !=3D NULL) {
> +               tests[(*tc_count)].exclusive =3D true;
> +               exclusive[0] =3D '\0';
> +       }
> +       tests[(*tc_count)].desc =3D desc;
> +       tests[(*tc_count)].skip_reason =3D NULL;  /* Unused */
> +       tests[(*tc_count)++].run_case =3D shell_test__run;
> +
> +       tests[(*tc_count)].name =3D NULL;         /* End the test cases *=
/
> +
> +       test_suite->test_cases =3D tests;
> +}
> +
> +static void append_scripts_in_subdir(int dir_fd,
> +                                 struct test_suite *suite,
> +                                 size_t *tc_count)
> +{
> +       struct dirent **entlist;
> +       struct dirent *ent;
> +       int n_dirs, i;
> +
> +       /* List files, sorted by alpha */
> +       n_dirs =3D scandirat(dir_fd, ".", &entlist, NULL, alphasort);
> +       if (n_dirs =3D=3D -1)
> +               return;
> +       for (i =3D 0; i < n_dirs && (ent =3D entlist[i]); i++) {
> +               int fd;
> +
> +               if (ent->d_name[0] =3D=3D '.')
> +                       continue; /* Skip hidden files */
> +               if (is_test_script(dir_fd, ent->d_name)) { /* It's a test=
 */
> +                       char *desc =3D shell_test__description(dir_fd, en=
t->d_name);
> +
> +                       if (desc) /* It has a desc line - valid script */
> +                               append_script_to_suite(dir_fd, ent->d_nam=
e, desc, suite, tc_count);
> +                       continue;
> +               }
> +
> +               if (ent->d_type !=3D DT_DIR) {
> +                       struct stat st;
> +
> +                       if (ent->d_type !=3D DT_UNKNOWN)
> +                               continue;
> +                       fstatat(dir_fd, ent->d_name, &st, 0);
> +                       if (!S_ISDIR(st.st_mode))
> +                               continue;

Fwiw, there is already logic doing something like this here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/api/io_dir.h?h=3Dperf-tools-next#n89
but iodir and not scandir so not suitably sorted. I wonder if we
should add a helper as this test seems to be common in this code?

> +               }
> +
> +               fd =3D openat(dir_fd, ent->d_name, O_PATH);
> +
> +               /* Recurse into the dir */
> +               append_scripts_in_subdir(fd, suite, tc_count);
> +       }
> +       for (i =3D 0; i < n_dirs; i++) /* Clean up */
> +               zfree(&entlist[i]);
> +       free(entlist);
> +}
> +
> +static void append_suites_in_dir(int dir_fd,
>                                   struct test_suite ***result,
>                                   size_t *result_sz)
>  {
> @@ -237,16 +362,29 @@ static void append_scripts_in_dir(int dir_fd,
>                 return;
>         for (i =3D 0; i < n_dirs && (ent =3D entlist[i]); i++) {
>                 int fd;
> +               struct test_suite *test_suite;
> +               size_t cases_count =3D 0;
>
>                 if (ent->d_name[0] =3D=3D '.')
>                         continue; /* Skip hidden files */
>                 if (is_test_script(dir_fd, ent->d_name)) { /* It's a test=
 */
>                         char *desc =3D shell_test__description(dir_fd, en=
t->d_name);
>
> -                       if (desc) /* It has a desc line - valid script */
> -                               append_script(dir_fd, ent->d_name, desc, =
result, result_sz);
> +                       if (desc) { /* It has a desc line - valid script =
*/
> +                               /* Create a test suite with a single test=
 case */
> +                               test_suite =3D prepare_test_suite(dir_fd)=
;
> +                               append_script_to_suite(dir_fd, ent->d_nam=
e, desc,
> +                                                              test_suite=
, &cases_count);
> +                               test_suite->desc =3D strdup_check(desc);
> +
> +                               if (cases_count)
> +                                       append_suite(result, result_sz, t=
est_suite);
> +                               else /* Wasn't able to create the test ca=
se */
> +                                       free_suite(test_suite);
> +                       }
>                         continue;
>                 }
> +
>                 if (ent->d_type !=3D DT_DIR) {
>                         struct stat st;
>
> @@ -258,8 +396,23 @@ static void append_scripts_in_dir(int dir_fd,
>                 }
>                 if (strncmp(ent->d_name, "base_", 5) =3D=3D 0)
>                         continue; /* Skip scripts that have a separate dr=
iver. */
> +
> +               /* Scan subdir for test cases*/
>                 fd =3D openat(dir_fd, ent->d_name, O_PATH);
> -               append_scripts_in_dir(fd, result, result_sz);
> +               test_suite =3D prepare_test_suite(fd);    /* Prepare a te=
stsuite with its path */
> +               if (!test_suite)
> +                       continue;
> +
> +               append_scripts_in_subdir(fd, test_suite, &cases_count);
> +               if (cases_count =3D=3D 0) {
> +                       free_suite(test_suite);
> +                       continue;
> +               }
> +
> +               /* If no setup, set name to the directory */
> +               test_suite->desc =3D strdup_check(ent->d_name);
> +
> +               append_suite(result, result_sz, test_suite);
>                 close(fd);
>         }
>         for (i =3D 0; i < n_dirs; i++) /* Clean up */
> @@ -278,7 +431,7 @@ struct test_suite **create_script_test_suites(void)
>          * length array.
>          */
>         if (dir_fd >=3D 0)
> -               append_scripts_in_dir(dir_fd, &result, &result_sz);
> +               append_suites_in_dir(dir_fd, &result, &result_sz);
>
>         result_tmp =3D realloc(result, (result_sz + 1) * sizeof(*result_t=
mp));
>         if (result_tmp =3D=3D NULL) {
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-sc=
ripts.h
> index b553ad26ea17..60a1a19a45c9 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -4,6 +4,10 @@
>
>  #include "tests.h"
>
> +struct shell_info {

Maybe shell_test_info with a comment saying that this is the
additional information attached to shell tests?

Thanks,
Ian

> +       const char *base_path;
> +};
> +
>  struct test_suite **create_script_test_suites(void);
>
>  #endif /* TESTS_SCRIPTS_H */
> --
> 2.50.1
>
