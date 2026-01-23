Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62F2D5944
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187132; cv=pass; b=SYPLFza0resszD+QUtB5psO2n3F7qCIHCdx3o62IKgvx4s90f7kTMwyvrwXbTPb3AygweyLom6RzMK9z63GItQyiJbYFgHOko9Kl48QWiLZ+5kvmbZvwqFbCmrrTTmbQhheMIqbfoX1nIJ4T7pJFggCyHJKZqofDa5ByYjdQs6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187132; c=relaxed/simple;
	bh=p4h/8lyxDN0z6C+GfAUp5xmh6IzLlt/xukU2vgXSPTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJgzlxnE3kMXHN6Yu8ShvFO5A3W0FwhU3oSxwJlVOTgTM0FSpL395ZsM3KObnQANwYvqJX4kfaedP3H7mgtxv8v9TGxTG+WbPyIMw6hnXeIJ041h8WnzYhLSWfqxSw6zphRfY+6b4ERs8apjCliDq1HLguwn+D7LG3b0EfdmGaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07Rvirsa; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07Rvirsa"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0d06cfa93so113795ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 08:52:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769187129; cv=none;
        d=google.com; s=arc-20240605;
        b=iyumihlnAaVqmH2XRSNWVd/yRAJSL/toXknV4JR2tTdq5gozZS1GR513EWAyBlRuUm
         sbokjtPojpsM8MvbjwshE1LuKIp5Hzp+r2oS2s2rU0YjxKb3qkcf0ixPf/PXxebkCjDw
         Rh4DJHr9HcpFh4WYr4f7yqd5HpVcaBBHMW81cRuXT1L4cz1BHEGguXgiAAJRk3ivMX9y
         gYZR9a7khH5t4OjEl212tld5v/3Fls/3TI4enP8pmrXhDzFAPHOPUIACdMZrfxeoa/1J
         A45xDLuN/JGj9+d6EtU28sAn2q7GCSaQ8NejuvWPlM8Dgc0mADOAG93gGSp0Gbd34KH2
         kYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yPaWJetIy9nmxFjNSc3KFM6KlhtZOIxjvqKDfBB/o08=;
        fh=fcE4u3OIlBa+b2P9eXJrjlFj6CFuFLBhUhg81NqhlCc=;
        b=elChj6qgn2tp2NQ72WT+asOsLOkUlXv5kxGxHlEzqZQr+KYQc0mA+cmxQi0sGMuLLw
         TL8K4CPoMfFeLEZPcE02r10PBMem9kCGy5GOvdcWeD1xK0jtmBmEx9yPmfPwGBWCh7xb
         Y+0rZYPoo2Ks3QBiDbRlKExsESjeZddlcCUBpYRunHfPpDbL/xdcWeXBiQBx4oDq/oIC
         92Sa0cUEnLZUcrj0Fbeix/g2UA/9cCwoOrG+rCNc1xFGGyfQaJk1lGvj4T+sIjfRM0wt
         DTKMGhphdWCllYlixglVQ17EBNVTDFFwKQViFN79LnEkloVYSuUxCwjaRVBsoJ1yZnNC
         BgTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769187129; x=1769791929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPaWJetIy9nmxFjNSc3KFM6KlhtZOIxjvqKDfBB/o08=;
        b=07RvirsaRXBcNL0m7n94YDxwhc5MKlrmHaPjS1lKB8lhehOF1SNZbgDke+W0/qRrHf
         JUXrjCk6imDlaKp+ESW8bNoSoourSH3jyQi9FVg6XjroneK5ZCABXRiAaczQI2gEP+ep
         LR3So7/HMjcZP99Fno1TtDu8XKSF9RKocR/kStsxGXHx/N5XcPALxebCjmJkSgwctO3/
         5uXVs/r0gYIlWE2g/vXIV0cnJf1nTM8oG9iT9ewB4ReThc3a8mBEUKdfZ0TrKJvewthn
         x90Dbn78IBgnGB3peMljdAg/7vpbZj8+INN6MGnam7GSFvPt/MaGLOWcPvbB1xbmpBzK
         7wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187129; x=1769791929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPaWJetIy9nmxFjNSc3KFM6KlhtZOIxjvqKDfBB/o08=;
        b=NFNCvjXO6989JWAE6jcp9cE89WX3eV3WShfoZolBLI7L5p1fy8eqlKgIkvPkmWW7/n
         cDgsbi6tkTjXP/Z++fV7TOTt3vOpF+Y9tHlYvR6RvUPuOdU/y5TCat3/JI8BooMgC3Eb
         z0q3kyR9TWsKNkfYE/h/VDcIQ+vSy6qw2AVPIIv3u+hxZxSx45PnD4HHTMZG5SLVfaG7
         9r/adfxmZrUknOmG4pGUTXaAw1hOXBtyDvfMEmOahURLpFnXUUDXdsuroBy17jfjhn91
         MgNkbSJC+XHbObDa14/tS6rN0bnx9unNXW1RtDyISNT2dFVHQKMdOY71RXEPY3REE8t/
         Rhig==
X-Forwarded-Encrypted: i=1; AJvYcCXuhhuM2e1g23LCC/fUI8TasVMcVJDP66a9WcSuJSYZToIYBgc+YG7/TkcqxEuuhaMUFKeeRVlcS7HY3t+7mTde@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/Kjjzr52s+4lokjGS2RVSWTqkGa11rJzP2Y3VTPOT73cp6/y
	wImU+RYJ8Wd2MfWpBzvOfjM326DsiEHzJ8A7O3PkCGD8mC6QFa0Mgqwxj7NM1Y+2/K+4zADBJle
	sY7GEXv4CesBh15dwRAN+es0/q5kcGmIZPgMLu37K
X-Gm-Gg: AZuq6aL9LXMtxkOd5XGRWd6mHKc83p15S2ARrWxb5j29w+qWyU3RMMp3HLu2Mai1HhY
	f3iGLzgdBz+vpH8GJBTUjwVs45Yl7R9Gj0xzCEQ5+YBfxds+Q04b5Dhkp4Z125u0GgUSgm1Iisw
	05u579X2L6ScIfwaX4/piWpknjwg5ggE3TgVpEm0+pEi7F8g7deQfTf3DAMCze+jo8qDP6HEHCg
	uM4a8zTsVGBdR8w8y003tRRuyAfJcuGgZJU6yuaNo/MKFPSkFeHCbLU8jEkWkZI5V7jb1K3yt01
	usIM6OiRXehN48/6jwp9KMqPjQ==
X-Received: by 2002:a17:902:d50a:b0:29f:f71:a3b9 with SMTP id
 d9443c01a7336-2a805d137b4mr2264375ad.5.1769187128733; Fri, 23 Jan 2026
 08:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125155648.197527-1-jbrnak@redhat.com> <20251125155648.197527-2-jbrnak@redhat.com>
In-Reply-To: <20251125155648.197527-2-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 Jan 2026 08:51:56 -0800
X-Gm-Features: AZwV_QhqcnI2lXFb8lLSqtf7TWnrvyPfrkcn0gKryRS1v2c1f9R8BLiWcXbMIKI
Message-ID: <CAP-5=fWLf8_vVxsNbmPAeD3n7hBT-1DnrEGXfEaDXMsM40KdXg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] perf tests: Create a structure for shell tests
To: Jakub Brnak <jbrnak@redhat.com>
Cc: acme@kernel.org, acme@redhat.com, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, mpetlan@redhat.com, vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 7:57=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
te:
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

The fd opened above looks like it is leaking here.

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

As fd is open here it should be closed.

> +                       continue;
> +
> +               append_scripts_in_subdir(fd, test_suite, &cases_count);
> +               if (cases_count =3D=3D 0) {
> +                       free_suite(test_suite);

fd should be closed here too I believe.

These are minor issues that I think Arnaldo can fix up.

Reviewed-by: Ian Rogers <irogers@google.com>

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
> 2.51.1
>
