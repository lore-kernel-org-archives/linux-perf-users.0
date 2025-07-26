Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C61DF256
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753510628; cv=none; b=uN5F6kDh8jUEkwY3UzGsLwrf0hrK2qTWklOBATkorjlp/WnrN1Z7xuoxobq1wQriG3e/jPH2Buxn0tAiiAhxNDdwz/0aQoQFZTsusGvJOCbJUx/GDGqGaYEME1gf98xprNmfVBvEeHYweEb7SN0Ppg4dmO8JgWaknjqAIev89gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753510628; c=relaxed/simple;
	bh=SiRlHs0+NoKNQsVLLMKTpCWtKfZNlzLu+tcexyaYYag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsKYCzd9q0AZ7FhAETlC1Vxnzn8ysBIbV/4ftp2pcybwDnwyt7vPLLCzp79datUqfRGf4Z1g+RdjI5ZM/Pbvih0ePI3mh/IvBKXIoyktYujaBswmA8Ss8BzfqsYOESfRncoWbLSZlf0FtKuD5AqVvyGNUpfLaSwOCZO+e/z8cb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDnRe6gM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDnRe6gM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3ACC4CEED;
	Sat, 26 Jul 2025 06:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753510627;
	bh=SiRlHs0+NoKNQsVLLMKTpCWtKfZNlzLu+tcexyaYYag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDnRe6gMBEbW29puRlD71eLzsQQjlTbLIpRLK7MsaANSzCruDUv063fqXggZ7VuEq
	 n1zKkAZoPdb+K0VzhiSGzgol5BtSIlcD6XagxXrIRvlW8GwdVt+ZzZRaeMuFQi5SMu
	 +8TdS7y+rfRjbItQrFlLrkZJl/64t7HsTofxD1z0dttnNlDRH374i3aWUzJIVC186C
	 3+Nemc7IV7H97ZES6Y2LALAEusfLQNR2cc6Wa7TPrs0D4qRoodpFmUfYRkcAKqA1Pe
	 5l1BFZEeB1jOiHa+nDrzAU9CygVaTki2de9w5e7TmgDbp+VCoOMM1Lw/WrdGsyBLv5
	 gP+gdxr7mpRYA==
Date: Fri, 25 Jul 2025 23:17:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jakub Brnak <jbrnak@redhat.com>
Cc: vmolnaro@redhat.com, acme@kernel.org, acme@redhat.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com
Subject: Re: [PATCH v3 5/7] perf test: Introduce storing logs for shell tests
Message-ID: <aIRy4qcHaUNxpomu@google.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
 <20250721132642.40906-6-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721132642.40906-6-jbrnak@redhat.com>

On Mon, Jul 21, 2025 at 03:26:40PM +0200, Jakub Brnak wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Create temporary directories for storing log files for shell tests
> that could help while debugging. The log files are necessary for
> perftool testsuite test cases also. If the variable KEEP_TEST_LOGS

Looks like you meant PERFTEST_KEEP_LOGS.

Thanks,
Namhyung


> is set keep the logs, else delete them.
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c  | 90 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests-scripts.c |  3 ++
>  tools/perf/tests/tests-scripts.h |  1 +
>  3 files changed, 94 insertions(+)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 4e3d2f779b01..89b180798224 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -6,6 +6,7 @@
>   */
>  #include <ctype.h>
>  #include <fcntl.h>
> +#include <ftw.h>
>  #include <errno.h>
>  #ifdef HAVE_BACKTRACE_SUPPORT
>  #include <execinfo.h>
> @@ -282,6 +283,86 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
>  	return t->test_cases[test_case].exclusive;
>  }
>  
> +static int delete_file(const char *fpath, const struct stat *sb __maybe_unused,
> +						 int typeflag, struct FTW *ftwbuf)
> +{
> +	int rv = -1;
> +
> +	/* Stop traversal if going too deep */
> +	if (ftwbuf->level > 5) {
> +		pr_err("Tree traversal reached level %d, stopping.", ftwbuf->level);
> +		return rv;
> +	}
> +
> +	/* Remove only expected directories */
> +	if (typeflag == FTW_D || typeflag == FTW_DP){
> +		const char *dirname = fpath + ftwbuf->base;
> +
> +		if (strcmp(dirname, "logs") && strcmp(dirname, "examples") &&
> +			strcmp(dirname, "header_tar") && strncmp(dirname, "perf_", 5)) {
> +				pr_err("Unknown directory %s", dirname);
> +				return rv;
> +			 }
> +	}
> +
> +	/* Attempt to remove the file */
> +	rv = remove(fpath);
> +	if (rv)
> +		pr_err("Failed to remove file: %s", fpath);
> +
> +	return rv;
> +}
> +
> +static bool create_logs(struct test_suite *t, int pass){
> +	bool store_logs = t->priv && ((struct shell_info*)(t->priv))->store_logs;
> +	if (pass == 1 && (!test_exclusive(t, 0) || sequential || dont_fork)) {
> +		/* Sequential and non-exclusive tests run on the first pass. */
> +		return store_logs;
> +	}
> +	else if (pass != 1 && test_exclusive(t, 0) && !sequential && !dont_fork) {
> +		/* Exclusive tests without sequential run on the second pass. */
> +		return store_logs;
> +	}
> +	return false;
> +}
> +
> +static char *setup_shell_logs(const char *name)
> +{
> +	char template[PATH_MAX];
> +	char *temp_dir;
> +
> +	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name) < 0) {
> +		pr_err("Failed to create log dir template");
> +		return NULL; /* Skip the testsuite */
> +	}
> +
> +	temp_dir = mkdtemp(template);
> +	if (temp_dir) {
> +		setenv("PERFSUITE_RUN_DIR", temp_dir, 1);
> +		return strdup(temp_dir);
> +	}
> +	else {
> +		pr_err("Failed to create the temporary directory");
> +	}
> +
> +	return NULL; /* Skip the testsuite */
> +}
> +
> +static void cleanup_shell_logs(char *dirname)
> +{
> +	char *keep_logs = getenv("PERFTEST_KEEP_LOGS");
> +
> +	/* Check if logs should be kept or do cleanup */
> +	if (dirname) {
> +		if (!keep_logs || strcmp(keep_logs, "y") != 0) {
> +			nftw(dirname, delete_file, 8, FTW_DEPTH | FTW_PHYS);
> +		}
> +		free(dirname);
> +	}
> +
> +	unsetenv("PERFSUITE_RUN_DIR");
> +}
> +
>  static bool perf_test__matches(const char *desc, int suite_num, int argc, const char *argv[])
>  {
>  	int i;
> @@ -626,6 +707,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>  		for (struct test_suite **t = suites; *t; t++, curr_suite++) {
>  			int curr_test_case;
>  			bool suite_matched = false;
> +			char *tmpdir = NULL;
>  
>  			if (!perf_test__matches(test_description(*t, -1), curr_suite, argc, argv)) {
>  				/*
> @@ -655,6 +737,13 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>  			}
>  
>  			for (unsigned int run = 0; run < runs_per_test; run++) {
> +				/* Setup temporary log directories for shell test suites */
> +				if (create_logs(*t, pass)) {
> +					tmpdir = setup_shell_logs((*t)->desc);
> +
> +					if (tmpdir == NULL)  /* Couldn't create log dir, skip test suite */
> +						((struct shell_info*)((*t)->priv))->has_setup = FAILED_SETUP;
> +				}
>  				test_suite__for_each_test_case(*t, curr_test_case) {
>  					if (!suite_matched &&
>  					    !perf_test__matches(test_description(*t, curr_test_case),
> @@ -667,6 +756,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>  						goto err_out;
>  				}
>  			}
> +			cleanup_shell_logs(tmpdir);
>  		}
>  		if (!sequential) {
>  			/* Parallel mode starts tests but doesn't finish them. Do that now. */
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
> index d680a878800f..d4e382898a30 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -251,6 +251,7 @@ static struct test_suite* prepare_test_suite(int dir_fd)
>  
>  	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
>  	test_info->has_setup = NO_SETUP;
> +	test_info->store_logs = false;
>  
>  	test_suite->priv = test_info;
>  	test_suite->desc = NULL;
> @@ -427,6 +428,8 @@ static void append_suits_in_dir(int dir_fd,
>  			continue;
>  		}
>  
> +		/* Store logs for testsuite is sub-directories */
> +		((struct shell_info*)(test_suite->priv))->store_logs = true;
>  		if (is_test_script(fd, SHELL_SETUP)) {	/* Check for setup existance */
>  			char *desc = shell_test__description(fd, SHELL_SETUP);
>  			test_suite->desc = desc;	/* Set the suite name by the setup description */
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
> index da4dcd26140c..41da0a175e4e 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -16,6 +16,7 @@ enum shell_setup {
>  struct shell_info {
>  	const char *base_path;
>  	enum shell_setup has_setup;
> +	bool store_logs;
>  };
>  
>  struct test_suite **create_script_test_suites(void);
> -- 
> 2.50.1
> 
