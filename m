Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8C2E7637
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155170; cv=pass; b=AueubNQrrNVyGn5IhihZYCj3ofknT14Pi6NBc5LW0TlRiwh5ZJ/AS+FZ5gX5Ukn+N+BdHnTov1uXGTJmOp6MA25kTbSIX4NVLCuKKQTlxRgV1ascQ5E4HbjR6YekYu2w4yXy3lfUrsvOBX68/Kguy2avukabD/zGhMxaTglg91Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155170; c=relaxed/simple;
	bh=D1cIhhbgAfNXgwbtlaktW0N5IXOLng4MsZtpIJfjeaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/YDi2Pb+KqTJpc3Fg6Eg0JR/pJhozgbUCl1eMDWwjB64dnkstZMNlhWA+o0hNm69d102F0oQ4W6BsA6eNaXm5FkzLOfAYNpnvuuxrEByCqXHhSeGXIg5aKrZhYxG9yueSC8lIKZhFSuqSHTFZ45NyxKKBXsMrHmLJa9or9rKyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GmG4ddRN; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GmG4ddRN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aea4ebb048so86035ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 08:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773155168; cv=none;
        d=google.com; s=arc-20240605;
        b=TRSrj8OCdkKejbY99FecsV5TGrTDl/UggAbecBdhEfv3spqxIelmFxcPfpTgL3kcm8
         w7rLg/T5jkewAmgsHuXFSvyn5s7i3Lybl8AeAnlH5fcj+ZoTMy/G0IJ5D6jxPxN1Zz0G
         oAIuZ7YDHdyd2NfZuZHf+8aB/dqT2XYn1m5RbB9o7n4XfSKSNR2qK1uRCg+f9uqYlOui
         dy/hOrMf8CvbJmcEoSfnxqKmgVGa3dmbgdXc5/CNIhBtJbzPTdFa7KJNTLLcdxtsqWMw
         vBuUqLy5SZwx/fS/U2AGe2hjntXJf1NKQxV5GNMvKv5Hd9t4nBxLFfUwjXPPR+y+BiNu
         tFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q5PYBd81MhgocLmD34ML4aXYZFT64ZDloZh4hUwvx1U=;
        fh=xljB46KWXYXgYGD0Ljd6XshXeEiAPv7ZlG4dQVGMcrA=;
        b=PLaHfu8cBEAamiQ92o4n75ZC55dKJ83HQEB8seKrZDQSo+CR0WlRRcb1qE26vEgKGC
         qjun5//Xfhe+OkFzLWpJRmPN6WP/Q9lM4JNqjV8WBLwpoUs5ughQnf3Bq3j5I+18JLCU
         q6KvBQmjvIAlF9/oTFAzRZ8PeD1efm5SZr0+tj7rO1TMAu+LWrzmv6Rd+gGHwknqlawO
         aKo7DB8npq479TswV4pAiQzlpWDOD6eqnJt/IasDDMt3DHRzjP+UbgYqqWwcgX0Ho2mk
         9dmtsR7aEjOKQsT6yrbz/Qw+56+vPKSdGmF5ANBvq+aUaYA15a8RrUtCBIEe6W2mbbXN
         S6+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773155168; x=1773759968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5PYBd81MhgocLmD34ML4aXYZFT64ZDloZh4hUwvx1U=;
        b=GmG4ddRNdpr5neoGZjrIJIgYR3pyhWOQKw2e7wxQ8jLhw+o6naFsYYCZ3HKC/BUbvD
         Lu9/2+UjnagGegu0w3fUK48+FVsoaCTG1o5wxlHup2N2C0enLaiCIbbNh3kpX3sKhspS
         NKJV7m8jbOowjndP9ZYg0H9Pfhjt4jSFd0bTZbUEgsfXc39Q/2IUd5rj134AwM97GeP6
         qGo/HaQ64oyucr+IBYzr+wadWy+/pJy9zoqe6OlJ4zu6YGE5ucf4CDdc1p7hi3jqKayM
         4BPzEMguGZDe1cS0Byg6UgBDQLgqzPZgkMpxA8qLEHD7NYOFOx7sXPbWQ2jSAtHxdAxX
         Eebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155168; x=1773759968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5PYBd81MhgocLmD34ML4aXYZFT64ZDloZh4hUwvx1U=;
        b=i9/r/oGjNVX/HGHpMLxxJVjuLJJ0UC6f7xrFIq5/Cab1L86arTip8f30sybe9t8Ia+
         NKxOu2LLNUrjt1exDq+PtkEadNi4a/d0qHjvf3Df/uGzaPiHwOfeOtFPMoUhyxsILctR
         7ALW4755/COgxrnICLqUuKUD+NdicZoVF6Jw21FwJ3p6LXx/HRPA7yciwMoQr4li0AUx
         7+9Nw0E/22o6Uze9TtDJh3c8D0wkKc2i8YKr4NOIshcfXf33s74lxWxrsp3jueCevPO1
         VUxcf1lKbqKrIlmLSBXhpOTAHFAVdxxZMwD7b70lARTwuG78OCq9rOfkHtUCZPmHzFMT
         Y01w==
X-Forwarded-Encrypted: i=1; AJvYcCUBfGJuYc9CCQ4rPY0uqj51/DednitJvEnHxPwPVOkyIUzcVZuXcqSxxqCIEqmM+LdUUQDXojOohX93D9ZSXFYn@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdtdRXq+macdPmrk+1AEb+0cc64nuV4kyAxtv4lYUy0euLMIG
	nh+qbZNlymF0RufHrvkbpuJg17aqVjyJx5ZVGViisQx89zpJQMjoJblXYKHEAtkcSsv8rQp30d+
	6eydHGPrTW77Z+1XvfElH44ktW0KtPc3f8xxk20IB
X-Gm-Gg: ATEYQzyTv1GoQdBpv0uaLHiEO7iHQfv40arPwOml1/oZqBZALSQF7C71lVFhxfDPqNv
	3kePPRv8iQDFLXvn5jpkx3V8WB8WNEEz2vSfKmR1oEfIFT0MFsgLpCf+5zVTYkiPX71c8MkyrVZ
	4RGFGY45pcsnh89q356Knkj9emQSeygJaVxxu7p8nli8f2gfMU4ZVNeAIwrUzSYIy13C1k3ZyzM
	zBfvCHU0q665qEG+xudS7mmm+0JvYXtxskAOD7SM1TBfX4IhEjt3uNTbcSkSfSJigrsB+3H8Uga
	qrkChKUkSMXK9919Nnqhop+Bvfk7xWw7/uc=
X-Received: by 2002:a17:902:f650:b0:2ae:45cc:aeb6 with SMTP id
 d9443c01a7336-2aea3035ba1mr3097155ad.6.1773155167952; Tue, 10 Mar 2026
 08:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155728.98026-1-jbrnak@redhat.com> <20260309155728.98026-2-jbrnak@redhat.com>
In-Reply-To: <20260309155728.98026-2-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Mar 2026 08:05:55 -0700
X-Gm-Features: AaiRm50JbRaaGu1zzB10kZcxYtDZZPMJVUxmx7ANZrK7vzHWdLoGoy1mYqV38IE
Message-ID: <CAP-5=fWt6b7cnN3=ssDzDSq6H9BcxrhJJ-wgEkPeEjBDY5XayA@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] perf tests: Create a structure for shell tests
To: Jakub Brnak <jbrnak@redhat.com>
Cc: acme@kernel.org, acme@redhat.com, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, mpetlan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:57=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wrot=
e:
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
> Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/tests-scripts.c | 251 +++++++++++++++++++++++++------
>  tools/perf/tests/tests-scripts.h |   5 +
>  2 files changed, 209 insertions(+), 47 deletions(-)
>
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index f18c4cd337c8..0f167365fb05 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -151,14 +151,64 @@ static char *strdup_check(const char *str)
>         return newstr;
>  }
>
> -static int shell_test__run(struct test_suite *test, int subtest __maybe_=
unused)
> +/* Check if dirent entry is a directory using file descriptor, handling =
DT_UNKNOWN case */
> +static bool is_directory_fd(int dir_fd, struct dirent *ent)
>  {
> -       const char *file =3D test->priv;
> +       struct stat st;
> +
> +       if (ent->d_type =3D=3D DT_DIR)
> +               return true;
> +
> +       if (ent->d_type !=3D DT_UNKNOWN)
> +               return false;
> +
> +       /* Need to stat the file to determine if it's a directory */
> +       if (fstatat(dir_fd, ent->d_name, &st, 0) !=3D 0)
> +               return false;
> +
> +       return S_ISDIR(st.st_mode);
> +}
> +
> +/* Free the whole structure of test_suite with its test_cases */
> +static void free_suite(struct test_suite *suite)
> +{
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
> +               struct shell_test_info *test_info =3D suite->priv;
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
> +       if (subtest >=3D 0)
> +               file =3D test->test_cases[subtest].name;
> +       else    /* Single test case */
> +               file =3D test->test_cases[0].name;
> +
>         if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
>                 return TEST_FAIL;
> +
>         err =3D system(cmd);
>         free(cmd);
>         if (!err)
> @@ -167,65 +217,112 @@ static int shell_test__run(struct test_suite *test=
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
> +       struct shell_test_info *test_info;
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
> -                                 struct test_suite ***result,
> -                                 size_t *result_sz)
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
>  {
>         struct dirent **entlist;
>         struct dirent *ent;
> @@ -244,22 +341,82 @@ static void append_scripts_in_dir(int dir_fd,
>                         char *desc =3D shell_test__description(dir_fd, en=
t->d_name);
>
>                         if (desc) /* It has a desc line - valid script */
> -                               append_script(dir_fd, ent->d_name, desc, =
result, result_sz);
> +                               append_script_to_suite(dir_fd, ent->d_nam=
e, desc, suite, tc_count);
>                         continue;
>                 }
> -               if (ent->d_type !=3D DT_DIR) {
> -                       struct stat st;
> -
> -                       if (ent->d_type !=3D DT_UNKNOWN)
> -                               continue;
> -                       fstatat(dir_fd, ent->d_name, &st, 0);
> -                       if (!S_ISDIR(st.st_mode))
> -                               continue;
> +
> +               if (!is_directory_fd(dir_fd, ent))
> +                       continue;
> +
> +               fd =3D openat(dir_fd, ent->d_name, O_PATH);
> +
> +               /* Recurse into the dir */
> +               append_scripts_in_subdir(fd, suite, tc_count);

Is there a missed close of fd here?

> +       }
> +       for (i =3D 0; i < n_dirs; i++) /* Clean up */
> +               zfree(&entlist[i]);
> +       free(entlist);
> +}
> +
> +static void append_suites_in_dir(int dir_fd,
> +                                 struct test_suite ***result,
> +                                 size_t *result_sz)
> +{
> +       struct dirent **entlist;
> +       struct dirent *ent;
> +       int n_dirs, i;
> +
> +       /* List files, sorted by alpha */
> +       n_dirs =3D scandirat(dir_fd, ".", &entlist, NULL, alphasort);

Is entlist freed?

> +       if (n_dirs =3D=3D -1)
> +               return;
> +       for (i =3D 0; i < n_dirs && (ent =3D entlist[i]); i++) {
> +               int fd;
> +               struct test_suite *test_suite;
> +               size_t cases_count =3D 0;
> +
> +               if (ent->d_name[0] =3D=3D '.')
> +                       continue; /* Skip hidden files */
> +               if (is_test_script(dir_fd, ent->d_name)) { /* It's a test=
 */
> +                       char *desc =3D shell_test__description(dir_fd, en=
t->d_name);
> +
> +                       if (desc) { /* It has a desc line - valid script =
*/
> +                               /* Create a test suite with a single test=
 case */
> +                               test_suite =3D prepare_test_suite(dir_fd)=
;

prepare_test_suite will return NULL on error, should there be a check
and early exit if that happens?

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
> +                       continue;
>                 }
> +
> +               if (!is_directory_fd(dir_fd, ent))
> +                       continue;
> +
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

Does the fd need closing before the continue?

> +                       continue;
> +
> +               append_scripts_in_subdir(fd, test_suite, &cases_count);
> +               if (cases_count =3D=3D 0) {
> +                       free_suite(test_suite);

Similarly, does fd need closing?

Thanks,
Ian

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
> @@ -278,7 +435,7 @@ struct test_suite **create_script_test_suites(void)
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
> index b553ad26ea17..1b849d4e70f4 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -4,6 +4,11 @@
>
>  #include "tests.h"
>
> +/* Additional information attached to shell tests */
> +struct shell_test_info {
> +       const char *base_path;
> +};
> +
>  struct test_suite **create_script_test_suites(void);
>
>  #endif /* TESTS_SCRIPTS_H */
> --
> 2.52.0
>
