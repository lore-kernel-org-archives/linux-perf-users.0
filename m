Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F5C47082
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 12:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290E1613BC
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 12:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhEZMfm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 08:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233344AbhEZMfi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 08:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622032446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/M4Zi1UD0F4y7iC9n27EXxdTv0jPB/LjVTE/VRiZvQ=;
        b=SEFDAW12WKrWay21eOxK+TVXRjqtwssfUkDzx6QOBsfeMJ7B4n7PKbMOUuRfNLFkhB8HsN
        z1FtWxys6i81oNiccBwoOZJ4fDYL4x9v59s/CyfSaQxiwIuHBzLlge99HqPNnwbS8FTgVR
        dVn+RPjOiWfUgj+Zc5sFzawBehCGaaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-twY8WkrSOACUVVWzQT69EQ-1; Wed, 26 May 2021 08:34:02 -0400
X-MC-Unique: twY8WkrSOACUVVWzQT69EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7675B80ED8E;
        Wed, 26 May 2021 12:33:59 +0000 (UTC)
Received: from krava (unknown [10.40.195.164])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5AFC45044F;
        Wed, 26 May 2021 12:33:56 +0000 (UTC)
Date:   Wed, 26 May 2021 14:33:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Fabian Hemmer <copy@copy.sh>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: iterate over shell tests in alphabetical order
Message-ID: <YK5AM07ex5/OIm7R@krava>
References: <20210525230521.244553-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525230521.244553-1-rickyman7@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 26, 2021 at 01:05:17AM +0200, Riccardo Mancini wrote:
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

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index c4b888f18e9ca..cbbfe48ab8029 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -510,8 +510,8 @@ static const char *shell_test__description(char *description, size_t size,
>  	return description ? strim(description + 1) : NULL;
>  }
>  
> -#define for_each_shell_test(dir, base, ent)	\
> -	while ((ent = readdir(dir)) != NULL)	\
> +#define for_each_shell_test(entlist, nr, base, ent)	                \
> +	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
>  		if (!is_directory(base, ent) && ent->d_name[0] != '.')
>  
>  static const char *shell_tests__dir(char *path, size_t size)
> @@ -538,8 +538,9 @@ static const char *shell_tests__dir(char *path, size_t size)
>  
>  static int shell_tests__max_desc_width(void)
>  {
> -	DIR *dir;
> +	struct dirent **entlist;
>  	struct dirent *ent;
> +	int n_dirs;
>  	char path_dir[PATH_MAX];
>  	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
>  	int width = 0;
> @@ -547,11 +548,11 @@ static int shell_tests__max_desc_width(void)
>  	if (path == NULL)
>  		return -1;
>  
> -	dir = opendir(path);
> -	if (!dir)
> +	n_dirs = scandir(path, &entlist, NULL, alphasort);
> +	if (n_dirs == -1)
>  		return -1;
>  
> -	for_each_shell_test(dir, path, ent) {
> +	for_each_shell_test(entlist, n_dirs, path, ent) {
>  		char bf[256];
>  		const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
>  
> @@ -563,7 +564,8 @@ static int shell_tests__max_desc_width(void)
>  		}
>  	}
>  
> -	closedir(dir);
> +	free(entlist);
> +
>  	return width;
>  }
>  
> @@ -589,8 +591,9 @@ static int shell_test__run(struct test *test, int subdir __maybe_unused)
>  
>  static int run_shell_tests(int argc, const char *argv[], int i, int width)
>  {
> -	DIR *dir;
> +	struct dirent **entlist;
>  	struct dirent *ent;
> +	int n_dirs;
>  	char path_dir[PATH_MAX];
>  	struct shell_test st = {
>  		.dir = shell_tests__dir(path_dir, sizeof(path_dir)),
> @@ -599,14 +602,14 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
>  	if (st.dir == NULL)
>  		return -1;
>  
> -	dir = opendir(st.dir);
> -	if (!dir) {
> +	n_dirs = scandir(st.dir, &entlist, NULL, alphasort);
> +	if (n_dirs == -1) {
>  		pr_err("failed to open shell test directory: %s\n",
>  			st.dir);
>  		return -1;
>  	}
>  
> -	for_each_shell_test(dir, st.dir, ent) {
> +	for_each_shell_test(entlist, n_dirs, st.dir, ent) {
>  		int curr = i++;
>  		char desc[256];
>  		struct test test = {
> @@ -623,7 +626,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
>  		test_and_print(&test, false, -1);
>  	}
>  
> -	closedir(dir);
> +	free(entlist);
>  	return 0;
>  }
>  
> @@ -722,19 +725,20 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  
>  static int perf_test__list_shell(int argc, const char **argv, int i)
>  {
> -	DIR *dir;
> +	struct dirent **entlist;
>  	struct dirent *ent;
> +	int n_dirs;
>  	char path_dir[PATH_MAX];
>  	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
>  
>  	if (path == NULL)
>  		return -1;
>  
> -	dir = opendir(path);
> -	if (!dir)
> +	n_dirs = scandir(path, &entlist, NULL, alphasort);
> +	if (n_dirs == -1)
>  		return -1;
>  
> -	for_each_shell_test(dir, path, ent) {
> +	for_each_shell_test(entlist, n_dirs, path, ent) {
>  		int curr = i++;
>  		char bf[256];
>  		struct test t = {
> @@ -747,7 +751,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
>  		pr_info("%2d: %s\n", i, t.desc);
>  	}
>  
> -	closedir(dir);
> +	free(entlist);
>  	return 0;
>  }
>  
> -- 
> 2.31.1
> 

