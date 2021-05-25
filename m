Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E412CC4707F
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 23:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B786C6142C
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 23:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhEYX1d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 19:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhEYX1d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 19:27:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94267C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 25 May 2021 16:26:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so7517804wmq.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 May 2021 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KR0O3txO0CCB46xDwYHSd9MjmF5UvaHMgy/5ImmK0PM=;
        b=EBKuTPj4tISe2fE5rDzWLYvGgHvwDZG7ch4klcXIkscyapuocUNTJKNSy5zuLV+Wcy
         Gxj5bydz2I1aNrCpjC7QAIlM3POcGwWGutd++o3TKKskdsOpDTM4JEiCL3MtRuQPNFWn
         V7RXEdLrZhIfz696wEyjMZwSJpac/wrUOLEMytDSrGC28ktkvkXgkPfwgPG+CHODoN0I
         Jnmw/7WGRJoN4BGiOd+sKzzRi8gtddEMvKnJttUvq7WL62EaqAvECHdXKsmvriNbiB86
         lWKU3iyCRj4CtOMH2eiBDwFIN5qqewtEV7KOI/LymZ8PHq3KFvYY1gvN5b8ILe/+4dXU
         LyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KR0O3txO0CCB46xDwYHSd9MjmF5UvaHMgy/5ImmK0PM=;
        b=e5Y5AOen53VHxCynGjLyVFRjNUbENs7uKfbxtpFvrwV/3o0IfEzpjnVBirKQbw4G5T
         GLvCahcwtAoArm0SsHtrDpUgU10CEQy8zFR57IvKSngUpx8HkunLMsuXW+K8uWsrKiOl
         8OPyME3MiqtezHTGJJKoGVZIVOaNFmAVpRelEysXBl+TF7PfYCC44b8io/HZKUIV0AH/
         OaUpYa1hxqpHNk3yldLW0bZ4cqbj6V8Fe+JfdnJzbr3TS+oWlrsPljR874R8sf8g1/Yt
         O7UMJCbcQGv9dEXXrhqhktK0L2x1Rqd0Mix8E90+uvZOR/oMp3+RcdeLwZY4Pw++/7gU
         5bSA==
X-Gm-Message-State: AOAM530OCzkXBw1J/iccNNN5SIjZzg6r/c5+oaBuIWYsqySEv/Gf3JhE
        LcNXGfxAt7QCEIRGPFMFylDdaRr4wCGPp4lpZ3k5QA==
X-Google-Smtp-Source: ABdhPJwuB+c4PUpADJwJbZ0/wrI41Eh0JqwYztfq8PJ4NnH3V40KZZX0d9BUnoxWI/XOMbFLlZtmnTjjwVEfmEXDwjE=
X-Received: by 2002:a1c:2743:: with SMTP id n64mr605352wmn.76.1621985159978;
 Tue, 25 May 2021 16:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210525230521.244553-1-rickyman7@gmail.com>
In-Reply-To: <20210525230521.244553-1-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 25 May 2021 16:25:48 -0700
Message-ID: <CAP-5=fUMeTC8za5wMy4syb4e_Kng9KMm2xUahm=zYkR4vb6Dfw@mail.gmail.com>
Subject: Re: [PATCH] perf test: iterate over shell tests in alphabetical order
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Fabian Hemmer <copy@copy.sh>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 25, 2021 at 4:08 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> for_each_shell_test macro iterated over all shell tests in the directory
> using readdir, which does not guarantee any ordering, causing
> problems on certain fs. However, the order in which they are visited
> determines the id of the test, in case one wants to run a single test.
>
> This patch replaces readdir with scandir using alphabetical sorting.
> This guarantees that, given the same set of tests, all machines will
> see the tests in the same order, and, thus, that test ids are
> consistent.
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index c4b888f18e9ca..cbbfe48ab8029 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -510,8 +510,8 @@ static const char *shell_test__description(char *description, size_t size,
>         return description ? strim(description + 1) : NULL;
>  }
>
> -#define for_each_shell_test(dir, base, ent)    \
> -       while ((ent = readdir(dir)) != NULL)    \
> +#define for_each_shell_test(entlist, nr, base, ent)                    \
> +       for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)      \

I think this declaration of __i is okay as C99 allows declarations
here, but generally I don't see this style in the kernel.

Thanks,
Ian

>                 if (!is_directory(base, ent) && ent->d_name[0] != '.')
>
>  static const char *shell_tests__dir(char *path, size_t size)
> @@ -538,8 +538,9 @@ static const char *shell_tests__dir(char *path, size_t size)
>
>  static int shell_tests__max_desc_width(void)
>  {
> -       DIR *dir;
> +       struct dirent **entlist;
>         struct dirent *ent;
> +       int n_dirs;
>         char path_dir[PATH_MAX];
>         const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
>         int width = 0;
> @@ -547,11 +548,11 @@ static int shell_tests__max_desc_width(void)
>         if (path == NULL)
>                 return -1;
>
> -       dir = opendir(path);
> -       if (!dir)
> +       n_dirs = scandir(path, &entlist, NULL, alphasort);
> +       if (n_dirs == -1)
>                 return -1;
>
> -       for_each_shell_test(dir, path, ent) {
> +       for_each_shell_test(entlist, n_dirs, path, ent) {
>                 char bf[256];
>                 const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
>
> @@ -563,7 +564,8 @@ static int shell_tests__max_desc_width(void)
>                 }
>         }
>
> -       closedir(dir);
> +       free(entlist);
> +
>         return width;
>  }
>
> @@ -589,8 +591,9 @@ static int shell_test__run(struct test *test, int subdir __maybe_unused)
>
>  static int run_shell_tests(int argc, const char *argv[], int i, int width)
>  {
> -       DIR *dir;
> +       struct dirent **entlist;
>         struct dirent *ent;
> +       int n_dirs;
>         char path_dir[PATH_MAX];
>         struct shell_test st = {
>                 .dir = shell_tests__dir(path_dir, sizeof(path_dir)),
> @@ -599,14 +602,14 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
>         if (st.dir == NULL)
>                 return -1;
>
> -       dir = opendir(st.dir);
> -       if (!dir) {
> +       n_dirs = scandir(st.dir, &entlist, NULL, alphasort);
> +       if (n_dirs == -1) {
>                 pr_err("failed to open shell test directory: %s\n",
>                         st.dir);
>                 return -1;
>         }
>
> -       for_each_shell_test(dir, st.dir, ent) {
> +       for_each_shell_test(entlist, n_dirs, st.dir, ent) {
>                 int curr = i++;
>                 char desc[256];
>                 struct test test = {
> @@ -623,7 +626,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
>                 test_and_print(&test, false, -1);
>         }
>
> -       closedir(dir);
> +       free(entlist);
>         return 0;
>  }
>
> @@ -722,19 +725,20 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>
>  static int perf_test__list_shell(int argc, const char **argv, int i)
>  {
> -       DIR *dir;
> +       struct dirent **entlist;
>         struct dirent *ent;
> +       int n_dirs;
>         char path_dir[PATH_MAX];
>         const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
>
>         if (path == NULL)
>                 return -1;
>
> -       dir = opendir(path);
> -       if (!dir)
> +       n_dirs = scandir(path, &entlist, NULL, alphasort);
> +       if (n_dirs == -1)
>                 return -1;
>
> -       for_each_shell_test(dir, path, ent) {
> +       for_each_shell_test(entlist, n_dirs, path, ent) {
>                 int curr = i++;
>                 char bf[256];
>                 struct test t = {
> @@ -747,7 +751,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
>                 pr_info("%2d: %s\n", i, t.desc);
>         }
>
> -       closedir(dir);
> +       free(entlist);
>         return 0;
>  }
>
> --
> 2.31.1
>
