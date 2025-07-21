Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A361885A5
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126787; cv=none; b=H9sDZc9hoZRmj18iA0U7v7s2AUtT8k5WN/OpFEV6dBv5QnZiJKVBJpTBxDpiJMmz+CqXCvS/RTd19Ns9E/TOoYyKEBzoZctRowNPQKcBYqOMOkEkvA0Jiso2imXRG1B1mNRPfBsTAiPDvzn/flSSt6K/2c7i/veepyyowF9era0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126787; c=relaxed/simple;
	bh=x5LZGXhLbpGeyzUtGbT/+cc4IbeCv57ccykjPoW0urE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmKNmt38N8eyVlzA4UxCGiLqmHXi85ns54NNu61MA+ABGERsdeZd9u2nNjAS3bogpd7gHNcmfG8+AIag7XwBQblU5Hp1RUwj9sd1ALq/3xxDU0UBq1EB/XTIz0/JUTvwXuc8V6D/yzXQnKIKgInoIOzIT0CSbryYhq86ZNd5Rn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eelIQ4Nj; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eelIQ4Nj"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso107551cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753126783; x=1753731583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMDxE5yVXs32fSBbhKB23sEmo/mrn+3rLKr8j1b1TMA=;
        b=eelIQ4NjlBDzebGRx+wjQCMEmy7smkbfDIlC4eUhERSG7I4Sp2UtFBVqSOrIwV5w5a
         zT4uPDMMqWVDpJvcpCZBo4uDymghPpcMXx9QkHt9Ejj5zqPE9jR0+xsrOMWD7EOIXyUM
         eJ7nNCd3BzlpTTIUGoJkBfcMl4TbfmsvcHYrJ5Z56h9sDi3JH+Ns9tjFZXmjZ7T/DC7S
         9SyhW7Q/4cWpe1rxwW9HJMEryAe2n/2Zz6mqr23TJ7TbTSvOMzSDVEqtOewKaxLz9+Tc
         +ojxNHJUyeoj/H8YiH9QQvq/wjSKEgpunnCdSapmemFCiTcYCnlxSYebwBsn3FR3DxnA
         SN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753126783; x=1753731583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMDxE5yVXs32fSBbhKB23sEmo/mrn+3rLKr8j1b1TMA=;
        b=IJIT3Bf5PtVNIzhuYXF/LVkVKzgkqxKvgwOXmBEfYhOcdVNTcQPP3W6NO48OdrRKH2
         F/KYmIu+39kXs7U1Y/NlGDO2B+AMcVDZqQ5F7Kxb3C9TuFHFbafClWNZEiuqMJOvyA2Q
         ODIiLSPMktUtL387JTbW/5kmLG8YyvRtmdfbXquzOfTV7pZjAGZACFx/M85PXhSSC3sp
         vAIz+wcCNi0yN5aJtzNp68rSkn+fbyWVs6tz1cOI47lQ19YUjOiOE8DmdHkofU5gw4Ek
         N2PFIgmDXCaJua56W0kG62z2Hq3tzhu0cAePVvMONHnHPq7rMiK4bNcVfuljiFO+9Eay
         y/WA==
X-Forwarded-Encrypted: i=1; AJvYcCX8SLnlj7o+Xpen585rYmZ2zXGiD8ciNC55a5YFWThLY/aV+A7+GEOJqbZnfzyJC9jeBbVPAaWxy9MgYNiM21CP@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxV6NQzi8qLMYSe6RURJgLPU3bAIxuSX04qEXDG7GfPgpfTT+
	5mA7xwaXtQLUlWeWTX0SmB8aUvEUjib2RATnrWJUVK0LI6en1UGCRJGgsYVS3k5tYVHcQQ0V2vn
	Zmwi4e0tlwL/4jjXxO0lb5BLcm6+cwbbPTpkhp/nq
X-Gm-Gg: ASbGncukp3ueO8cdzLRGNfTvkl4Igce11mMVntJmAzm15i/E1ZEAzWROwHNURJK+Ymx
	xek3asAOeIM9EPL2FJzZ/nzvmwaCgfeqMWhuKCQSY+CQjdJZ70mSL/NdsR+VCE+Q/NJpkkG0WTV
	AZqmg4cUlzA3lHlNbNGsxDvlIBVtUCJFyljPSIvOdwTz7ZHHibram/DAYcc30M3KTpTPcv1AvF+
	p/fq23Fdt4BPTtfsUEDshi7llNuCVitTvfl
X-Google-Smtp-Source: AGHT+IFFKUC9w5CKciJEXjqr1C4+URw7nTeWcNaXVO9be6SeriFU8SR/jgMS5Uhm3IJ8BIPoHlpAqzssItOKKWrAM1c=
X-Received: by 2002:ac8:7f13:0:b0:4a9:d3e7:56bf with SMTP id
 d75a77b69052e-4ae5d20a0ecmr492691cf.27.1753126782371; Mon, 21 Jul 2025
 12:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113182605.130719-1-vmolnaro@redhat.com> <20250721132642.40906-1-jbrnak@redhat.com>
 <20250721132642.40906-3-jbrnak@redhat.com>
In-Reply-To: <20250721132642.40906-3-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Jul 2025 12:39:31 -0700
X-Gm-Features: Ac12FXzDf6TXkbWi0xconazT4KPEyZubhjdkOV4WyI29KzgFzWkiFdhzkQKPb2o
Message-ID: <CAP-5=fU0tkj52M2moPT2XjmXy750-NKK+o+T_EGq7LEjXfDdOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] perf tests: Create a structure for shell tests
To: Jakub Brnak <jbrnak@redhat.com>
Cc: vmolnaro@redhat.com, acme@kernel.org, acme@redhat.com, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 6:26=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
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
>  tools/perf/tests/tests-scripts.c | 223 +++++++++++++++++++++++++------
>  tools/perf/tests/tests-scripts.h |   4 +
>  2 files changed, 189 insertions(+), 38 deletions(-)
>
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index f18c4cd337c8..21a6ede330e9 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -151,14 +151,45 @@ static char *strdup_check(const char *str)
>         return newstr;
>  }
>
> -static int shell_test__run(struct test_suite *test, int subtest __maybe_=
unused)
> +/* Free the whole structure of test_suite with its test_cases */
> +static void free_suite(struct test_suite *suite) {
> +       if (suite->test_cases){
> +               int num =3D 0;
> +               while (suite->test_cases[num].name){ /* Last case has nam=
e set to NULL */
> +                       free((void*) suite->test_cases[num].name);
> +                       free((void*) suite->test_cases[num].desc);
> +                       num++;
> +               }
> +               free(suite->test_cases);
> +       }
> +       if (suite->desc)
> +               free((void*) suite->desc);
> +       if (suite->priv){
> +               struct shell_info *test_info =3D suite->priv;
> +               free((void*) test_info->base_path);
> +               free(test_info);
> +       }
> +
> +       free(suite);
> +}
> +
> +static int shell_test__run(struct test_suite *test, int subtest)
>  {
> -       const char *file =3D test->priv;
> +       const char *file;
>         int err;
>         char *cmd =3D NULL;
>
> +       /* Get absolute file path */
> +       if (subtest >=3D 0) {
> +               file =3D test->test_cases[subtest].name;
> +       }
> +       else {          /* Single test case */
> +               file =3D test->test_cases[0].name;
> +       }
> +
>         if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
>                 return TEST_FAIL;
> +
>         err =3D system(cmd);
>         free(cmd);
>         if (!err)
> @@ -167,63 +198,154 @@ static int shell_test__run(struct test_suite *test=
, int subtest __maybe_unused)
>         return WEXITSTATUS(err) =3D=3D 2 ? TEST_SKIP : TEST_FAIL;
>  }
>
> -static void append_script(int dir_fd, const char *name, char *desc,
> -                         struct test_suite ***result,
> -                         size_t *result_sz)
> +static struct test_suite* prepare_test_suite(int dir_fd)
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
> +       tests[(*tc_count)].name =3D strdup_check(file_name);      /* Get =
path to the script from base dir */
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

Note: we have io_dir that have a io_dir__is_dir that does something
similar to this:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/lib/api/io_dir.h?h=3Dperf-tools-next#n89
but scandirat is used here for the extra effect of alphabetic sorting.

> +                               continue;
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
> +static void append_suits_in_dir(int dir_fd,

nit: typo "suits" should be "suites"

Thanks,
Ian

>                                   struct test_suite ***result,
>                                   size_t *result_sz)
>  {
> @@ -237,16 +359,27 @@ static void append_scripts_in_dir(int dir_fd,
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
> +                               test_suite =3D prepare_test_suite(dir_fd)=
; /* Create a test suite with a single test case */
> +                               append_script_to_suite(dir_fd, ent->d_nam=
e, desc, test_suite, &cases_count);
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
> @@ -258,8 +391,22 @@ static void append_scripts_in_dir(int dir_fd,
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
> +               if (cases_count =3D=3D 0){
> +                       free_suite(test_suite);
> +                       continue;
> +               }
> +
> +               test_suite->desc =3D strdup_check(ent->d_name);   /* If n=
o setup, set name to the directory */
> +
> +               append_suite(result, result_sz, test_suite);
>                 close(fd);
>         }
>         for (i =3D 0; i < n_dirs; i++) /* Clean up */
> @@ -278,7 +425,7 @@ struct test_suite **create_script_test_suites(void)
>          * length array.
>          */
>         if (dir_fd >=3D 0)
> -               append_scripts_in_dir(dir_fd, &result, &result_sz);
> +               append_suits_in_dir(dir_fd, &result, &result_sz);
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
> +       const char *base_path;
> +};
> +
>  struct test_suite **create_script_test_suites(void);
>
>  #endif /* TESTS_SCRIPTS_H */
> --
> 2.50.1
>
