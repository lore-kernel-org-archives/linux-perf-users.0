Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52C5C47089
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 13:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE96613E6
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 13:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhEZOAU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 10:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhEZOAT (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 10:00:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 108CE6101E;
        Wed, 26 May 2021 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622037528;
        bh=TuPjYm63AEIX3xKPK7LaeAgYr240A8QnqaHp5LUvUDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTGGYN+DAshEM8KkRCLuqifVp0nz/Ax0mkUa301X8W44+37x6M151ruaWV15yK7KK
         hk4Nk0ofAtXH8vag8n9cgnNPAxErab+LISere42byVsqlL2c2j/ZVxTGYnmQtygyjz
         tGpQ9ubNjZ9Nq6NX1W0p09fgKjUSESkGbpn/zZVcuVVZNBHpi3BaVTVvXs3/jtmtv6
         m1/G29XkjCcw4SE1bQnEbI2RHeOJbM3k/LLiGAm18s/xHZ67N19m+1NCubyJSVLzMX
         Nnulo8FX1jZqLiXvbZH+lpFkIX2cF+Hh2gNv7pQEh15oUZe6hlVMz5QXSoArhI1AsN
         rxOWd4uRJUC1A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5116B4011C; Wed, 26 May 2021 10:58:45 -0300 (-03)
Date:   Wed, 26 May 2021 10:58:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
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
Subject: Re: [PATCH] perf test: iterate over shell tests in alphabetical order
Message-ID: <YK5UFUH2FnNHr1Vk@kernel.org>
References: <20210525230521.244553-1-rickyman7@gmail.com>
 <CAP-5=fUMeTC8za5wMy4syb4e_Kng9KMm2xUahm=zYkR4vb6Dfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUMeTC8za5wMy4syb4e_Kng9KMm2xUahm=zYkR4vb6Dfw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, May 25, 2021 at 04:25:48PM -0700, Ian Rogers escreveu:
> On Tue, May 25, 2021 at 4:08 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> >
> > for_each_shell_test macro iterated over all shell tests in the directory
> > using readdir, which does not guarantee any ordering, causing
> > problems on certain fs. However, the order in which they are visited
> > determines the id of the test, in case one wants to run a single test.
> >
> > This patch replaces readdir with scandir using alphabetical sorting.
> > This guarantees that, given the same set of tests, all machines will
> > see the tests in the same order, and, thus, that test ids are
> > consistent.
> >
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied and also added this, which I think it appropriate in
this case, no?

Reported-by: Ian Rogers <irogers@google.com>

- Arnaldo
 
> > ---
> >  tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++---------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index c4b888f18e9ca..cbbfe48ab8029 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -510,8 +510,8 @@ static const char *shell_test__description(char *description, size_t size,
> >         return description ? strim(description + 1) : NULL;
> >  }
> >
> > -#define for_each_shell_test(dir, base, ent)    \
> > -       while ((ent = readdir(dir)) != NULL)    \
> > +#define for_each_shell_test(entlist, nr, base, ent)                    \
> > +       for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)      \
> 
> I think this declaration of __i is okay as C99 allows declarations
> here, but generally I don't see this style in the kernel.
> 
> Thanks,
> Ian
> 
> >                 if (!is_directory(base, ent) && ent->d_name[0] != '.')
> >
> >  static const char *shell_tests__dir(char *path, size_t size)
> > @@ -538,8 +538,9 @@ static const char *shell_tests__dir(char *path, size_t size)
> >
> >  static int shell_tests__max_desc_width(void)
> >  {
> > -       DIR *dir;
> > +       struct dirent **entlist;
> >         struct dirent *ent;
> > +       int n_dirs;
> >         char path_dir[PATH_MAX];
> >         const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
> >         int width = 0;
> > @@ -547,11 +548,11 @@ static int shell_tests__max_desc_width(void)
> >         if (path == NULL)
> >                 return -1;
> >
> > -       dir = opendir(path);
> > -       if (!dir)
> > +       n_dirs = scandir(path, &entlist, NULL, alphasort);
> > +       if (n_dirs == -1)
> >                 return -1;
> >
> > -       for_each_shell_test(dir, path, ent) {
> > +       for_each_shell_test(entlist, n_dirs, path, ent) {
> >                 char bf[256];
> >                 const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
> >
> > @@ -563,7 +564,8 @@ static int shell_tests__max_desc_width(void)
> >                 }
> >         }
> >
> > -       closedir(dir);
> > +       free(entlist);
> > +
> >         return width;
> >  }
> >
> > @@ -589,8 +591,9 @@ static int shell_test__run(struct test *test, int subdir __maybe_unused)
> >
> >  static int run_shell_tests(int argc, const char *argv[], int i, int width)
> >  {
> > -       DIR *dir;
> > +       struct dirent **entlist;
> >         struct dirent *ent;
> > +       int n_dirs;
> >         char path_dir[PATH_MAX];
> >         struct shell_test st = {
> >                 .dir = shell_tests__dir(path_dir, sizeof(path_dir)),
> > @@ -599,14 +602,14 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
> >         if (st.dir == NULL)
> >                 return -1;
> >
> > -       dir = opendir(st.dir);
> > -       if (!dir) {
> > +       n_dirs = scandir(st.dir, &entlist, NULL, alphasort);
> > +       if (n_dirs == -1) {
> >                 pr_err("failed to open shell test directory: %s\n",
> >                         st.dir);
> >                 return -1;
> >         }
> >
> > -       for_each_shell_test(dir, st.dir, ent) {
> > +       for_each_shell_test(entlist, n_dirs, st.dir, ent) {
> >                 int curr = i++;
> >                 char desc[256];
> >                 struct test test = {
> > @@ -623,7 +626,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
> >                 test_and_print(&test, false, -1);
> >         }
> >
> > -       closedir(dir);
> > +       free(entlist);
> >         return 0;
> >  }
> >
> > @@ -722,19 +725,20 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> >
> >  static int perf_test__list_shell(int argc, const char **argv, int i)
> >  {
> > -       DIR *dir;
> > +       struct dirent **entlist;
> >         struct dirent *ent;
> > +       int n_dirs;
> >         char path_dir[PATH_MAX];
> >         const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
> >
> >         if (path == NULL)
> >                 return -1;
> >
> > -       dir = opendir(path);
> > -       if (!dir)
> > +       n_dirs = scandir(path, &entlist, NULL, alphasort);
> > +       if (n_dirs == -1)
> >                 return -1;
> >
> > -       for_each_shell_test(dir, path, ent) {
> > +       for_each_shell_test(entlist, n_dirs, path, ent) {
> >                 int curr = i++;
> >                 char bf[256];
> >                 struct test t = {
> > @@ -747,7 +751,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
> >                 pr_info("%2d: %s\n", i, t.desc);
> >         }
> >
> > -       closedir(dir);
> > +       free(entlist);
> >         return 0;
> >  }
> >
> > --
> > 2.31.1
> >

-- 

- Arnaldo
