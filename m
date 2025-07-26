Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142547E9
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753509842; cv=none; b=Ghx9xzdy9JGpIXfjAWg4qNic2O5qB4AULEww+FJE3fMWqPh1O7pd0gmPPS5THgwSGgfEVKtuF7c7k+7rSy9AG9qW5NYDDgfXYFGxSNAzs79cGXO+mo8qMkuLt0OWYpxip0Nr5HywXMs+B0mKxMVGuTWvkpnZq5MUX79BbFhXpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753509842; c=relaxed/simple;
	bh=D8af6WDIAxGvOX/Wp0YMb8XLmkELvWlTXIEMBeWl4Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIPhrlrqwzoXM4uMxfO2qh10rOWCDYkEdzxKY76jZyDetvZgfBLBRVaSwyP5JBbLJF+Pinvq2pcQxiuhFBwYotTKhl5DIHF7x8hUIafHFk6L7JrOX+vQjz0geBZ/O/f5wJHSRxGAhG+sLpSfqkOQOlitkwDYn0f20Zb1I/pjyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu1ap+Ie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu1ap+Ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C5AC4CEED;
	Sat, 26 Jul 2025 06:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753509841;
	bh=D8af6WDIAxGvOX/Wp0YMb8XLmkELvWlTXIEMBeWl4Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qu1ap+IeD382+zELz2rPniV0nJNN7gMfcvCdQ4Xk9GW6v61HHgjkQIMapZPJPaedw
	 8LK/CtQnVQ0g+qcY+ULzMNzWNwqnH1ccm/xKX4e4/UM+00xa4Xlbbul3Jf5k0MD3/8
	 lY8GsxGSXq4MQW6UfhFBOb1xVYGARtHVpKCpiX1EVl5up+IOwjWqqkhyalZZAGFwqI
	 2Mh0ShxBwLOjgxlp9JTXY7XI53piY3TxaZeDttUvsTherVVaCJSmltDfp7Ewkj87bI
	 8At5nz2e4l5JVNSed5DRZd0xvLog/nSVukdkqP0K8G+IifR/KhY6cVsW9DTAqSgE9q
	 N7W40LlSm84dw==
Date: Fri, 25 Jul 2025 23:03:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jakub Brnak <jbrnak@redhat.com>
Cc: vmolnaro@redhat.com, acme@kernel.org, acme@redhat.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com
Subject: Re: [PATCH v3 2/7] perf tests: Create a structure for shell tests
Message-ID: <aIRvz9ZfK2rnblQt@google.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
 <20250721132642.40906-3-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721132642.40906-3-jbrnak@redhat.com>

On Mon, Jul 21, 2025 at 03:26:37PM +0200, Jakub Brnak wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> The general structure of test suites with test cases has been implemented
> for C tests for some time, while shell tests were just all put into a list
> without any possible structuring.
> 
> Provide the same possibility of test suite structure for shell tests. The
> suite is created for each subdirectory located in the 'perf/tests/shell'
> directory that contains at least one test script. All of the deeper levels
> of subdirectories will be merged with the first level of test cases.
> The name of the test suite is the name of the subdirectory, where the test
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

I like the idea!  But there are too many coding style issues.  Can you
please follow the style for the kernel?

Thanks,
Namhyung

> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/tests-scripts.c | 223 +++++++++++++++++++++++++------
>  tools/perf/tests/tests-scripts.h |   4 +
>  2 files changed, 189 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
> index f18c4cd337c8..21a6ede330e9 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -151,14 +151,45 @@ static char *strdup_check(const char *str)
>  	return newstr;
>  }
>  
> -static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
> +/* Free the whole structure of test_suite with its test_cases */
> +static void free_suite(struct test_suite *suite) {
> +	if (suite->test_cases){
> +		int num = 0;
> +		while (suite->test_cases[num].name){ /* Last case has name set to NULL */
> +			free((void*) suite->test_cases[num].name);
> +			free((void*) suite->test_cases[num].desc);
> +			num++;
> +		}
> +		free(suite->test_cases);
> +	}
> +	if (suite->desc)
> +		free((void*) suite->desc);
> +	if (suite->priv){
> +		struct shell_info *test_info = suite->priv;
> +		free((void*) test_info->base_path);
> +		free(test_info);
> +	}
> +
> +	free(suite);
> +}
> +
> +static int shell_test__run(struct test_suite *test, int subtest)
>  {
> -	const char *file = test->priv;
> +	const char *file;
>  	int err;
>  	char *cmd = NULL;
>  
> +	/* Get absolute file path */
> +	if (subtest >= 0) {
> +		file = test->test_cases[subtest].name;
> +	}
> +	else {		/* Single test case */
> +		file = test->test_cases[0].name;
> +	}
> +
>  	if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
>  		return TEST_FAIL;
> +
>  	err = system(cmd);
>  	free(cmd);
>  	if (!err)
> @@ -167,63 +198,154 @@ static int shell_test__run(struct test_suite *test, int subtest __maybe_unused)
>  	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
>  }
>  
> -static void append_script(int dir_fd, const char *name, char *desc,
> -			  struct test_suite ***result,
> -			  size_t *result_sz)
> +static struct test_suite* prepare_test_suite(int dir_fd)
>  {
> -	char filename[PATH_MAX], link[128];
> -	struct test_suite *test_suite, **result_tmp;
> -	struct test_case *tests;
> +	char dirpath[PATH_MAX], link[128];
>  	ssize_t len;
> -	char *exclusive;
> +	struct test_suite *test_suite = NULL;
> +	struct shell_info *test_info;
>  
> +	/* Get dir absolute path */
>  	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> -	len = readlink(link, filename, sizeof(filename));
> +	len = readlink(link, dirpath, sizeof(dirpath));
>  	if (len < 0) {
>  		pr_err("Failed to readlink %s", link);
> -		return;
> +		return NULL;
>  	}
> -	filename[len++] = '/';
> -	strcpy(&filename[len], name);
> +	dirpath[len++] = '/';
> +	dirpath[len] = '\0';
>  
> -	tests = calloc(2, sizeof(*tests));
> -	if (!tests) {
> -		pr_err("Out of memory while building script test suite list\n");
> -		return;
> -	}
> -	tests[0].name = strdup_check(name);
> -	exclusive = strstr(desc, " (exclusive)");
> -	if (exclusive != NULL) {
> -		tests[0].exclusive = true;
> -		exclusive[0] = '\0';
> -	}
> -	tests[0].desc = strdup_check(desc);
> -	tests[0].run_case = shell_test__run;
>  	test_suite = zalloc(sizeof(*test_suite));
>  	if (!test_suite) {
>  		pr_err("Out of memory while building script test suite list\n");
> -		free(tests);
> -		return;
> +		return NULL;
>  	}
> -	test_suite->desc = desc;
> -	test_suite->test_cases = tests;
> -	test_suite->priv = strdup_check(filename);
> +
> +	test_info = zalloc(sizeof(*test_info));
> +	if (!test_info) {
> +		pr_err("Out of memory while building script test suite list\n");
> +		return NULL;
> +	}
> +
> +	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
> +
> +	test_suite->priv = test_info;
> +	test_suite->desc = NULL;
> +	test_suite->test_cases = NULL;
> +
> +	return test_suite;
> +}
> +
> +static void append_suite(struct test_suite ***result,
> +			  size_t *result_sz, struct test_suite *test_suite)
> +{
> +	struct test_suite **result_tmp;
> +
>  	/* Realloc is good enough, though we could realloc by chunks, not that
>  	 * anyone will ever measure performance here */
>  	result_tmp = realloc(*result, (*result_sz + 1) * sizeof(*result_tmp));
>  	if (result_tmp == NULL) {
>  		pr_err("Out of memory while building script test suite list\n");
> -		free(tests);
> -		free(test_suite);
> +		free_suite(test_suite);
>  		return;
>  	}
> +
>  	/* Add file to end and NULL terminate the struct array */
>  	*result = result_tmp;
>  	(*result)[*result_sz] = test_suite;
>  	(*result_sz)++;
>  }
>  
> -static void append_scripts_in_dir(int dir_fd,
> +static void append_script_to_suite(int dir_fd, const char *name, char *desc,
> +					struct test_suite *test_suite, size_t *tc_count)
> +{
> +	char file_name[PATH_MAX], link[128];
> +	struct test_case *tests;
> +	size_t len;
> +	char *exclusive;
> +
> +	if (!test_suite)
> +		return;
> +
> +	/* Requires an empty test case at the end */
> +	tests = realloc(test_suite->test_cases, (*tc_count + 2) * sizeof(*tests));
> +	if (!tests) {
> +		pr_err("Out of memory while building script test suite list\n");
> +		return;
> +	}
> +
> +	/* Get path to the test script */
> +	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> +	len = readlink(link, file_name, sizeof(file_name));
> +	if (len < 0) {
> +		pr_err("Failed to readlink %s", link);
> +		return;
> +	}
> +	file_name[len++] = '/';
> +	strcpy(&file_name[len], name);
> +
> +	tests[(*tc_count)].name = strdup_check(file_name);	/* Get path to the script from base dir */
> +	tests[(*tc_count)].exclusive = false;
> +	exclusive = strstr(desc, " (exclusive)");
> +	if (exclusive != NULL) {
> +		tests[(*tc_count)].exclusive = true;
> +		exclusive[0] = '\0';
> +	}
> +	tests[(*tc_count)].desc = desc;
> +	tests[(*tc_count)].skip_reason = NULL;	/* Unused */
> +	tests[(*tc_count)++].run_case = shell_test__run;
> +
> +	tests[(*tc_count)].name = NULL;		/* End the test cases */
> +
> +	test_suite->test_cases = tests;
> +}
> +
> +static void append_scripts_in_subdir(int dir_fd,
> +				  struct test_suite *suite,
> +				  size_t *tc_count)
> +{
> +	struct dirent **entlist;
> +	struct dirent *ent;
> +	int n_dirs, i;
> +
> +	/* List files, sorted by alpha */
> +	n_dirs = scandirat(dir_fd, ".", &entlist, NULL, alphasort);
> +	if (n_dirs == -1)
> +		return;
> +	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
> +		int fd;
> +
> +		if (ent->d_name[0] == '.')
> +			continue; /* Skip hidden files */
> +		if (is_test_script(dir_fd, ent->d_name)) { /* It's a test */
> +			char *desc = shell_test__description(dir_fd, ent->d_name);
> +
> +			if (desc) /* It has a desc line - valid script */
> +				append_script_to_suite(dir_fd, ent->d_name, desc, suite, tc_count);
> +			continue;
> +		}
> +
> +		if (ent->d_type != DT_DIR) {
> +			struct stat st;
> +
> +			if (ent->d_type != DT_UNKNOWN)
> +				continue;
> +			fstatat(dir_fd, ent->d_name, &st, 0);
> +			if (!S_ISDIR(st.st_mode))
> +				continue;
> +		}
> +
> +		fd = openat(dir_fd, ent->d_name, O_PATH);
> +
> +		/* Recurse into the dir */
> +		append_scripts_in_subdir(fd, suite, tc_count);
> +	}
> +	for (i = 0; i < n_dirs; i++) /* Clean up */
> +		zfree(&entlist[i]);
> +	free(entlist);
> +}
> +
> +static void append_suits_in_dir(int dir_fd,
>  				  struct test_suite ***result,
>  				  size_t *result_sz)
>  {
> @@ -237,16 +359,27 @@ static void append_scripts_in_dir(int dir_fd,
>  		return;
>  	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
>  		int fd;
> +		struct test_suite *test_suite;
> +		size_t cases_count = 0;
>  
>  		if (ent->d_name[0] == '.')
>  			continue; /* Skip hidden files */
>  		if (is_test_script(dir_fd, ent->d_name)) { /* It's a test */
>  			char *desc = shell_test__description(dir_fd, ent->d_name);
>  
> -			if (desc) /* It has a desc line - valid script */
> -				append_script(dir_fd, ent->d_name, desc, result, result_sz);
> +			if (desc) { /* It has a desc line - valid script */
> +				test_suite = prepare_test_suite(dir_fd); /* Create a test suite with a single test case */
> +				append_script_to_suite(dir_fd, ent->d_name, desc, test_suite, &cases_count);
> +				test_suite->desc = strdup_check(desc);
> +
> +				if (cases_count)
> +					append_suite(result, result_sz, test_suite);
> +				else /* Wasn't able to create the test case */
> +					free_suite(test_suite);
> +			}
>  			continue;
>  		}
> +
>  		if (ent->d_type != DT_DIR) {
>  			struct stat st;
>  
> @@ -258,8 +391,22 @@ static void append_scripts_in_dir(int dir_fd,
>  		}
>  		if (strncmp(ent->d_name, "base_", 5) == 0)
>  			continue; /* Skip scripts that have a separate driver. */
> +
> +		/* Scan subdir for test cases*/
>  		fd = openat(dir_fd, ent->d_name, O_PATH);
> -		append_scripts_in_dir(fd, result, result_sz);
> +		test_suite = prepare_test_suite(fd);	/* Prepare a testsuite with its path */
> +		if (!test_suite)
> +			continue;
> +
> +		append_scripts_in_subdir(fd, test_suite, &cases_count);
> +		if (cases_count == 0){
> +			free_suite(test_suite);
> +			continue;
> +		}
> +
> +		test_suite->desc = strdup_check(ent->d_name);	/* If no setup, set name to the directory */
> +
> +		append_suite(result, result_sz, test_suite);
>  		close(fd);
>  	}
>  	for (i = 0; i < n_dirs; i++) /* Clean up */
> @@ -278,7 +425,7 @@ struct test_suite **create_script_test_suites(void)
>  	 * length array.
>  	 */
>  	if (dir_fd >= 0)
> -		append_scripts_in_dir(dir_fd, &result, &result_sz);
> +		append_suits_in_dir(dir_fd, &result, &result_sz);
>  
>  	result_tmp = realloc(result, (result_sz + 1) * sizeof(*result_tmp));
>  	if (result_tmp == NULL) {
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
> index b553ad26ea17..60a1a19a45c9 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -4,6 +4,10 @@
>  
>  #include "tests.h"
>  
> +struct shell_info {
> +	const char *base_path;
> +};
> +
>  struct test_suite **create_script_test_suites(void);
>  
>  #endif /* TESTS_SCRIPTS_H */
> -- 
> 2.50.1
> 
