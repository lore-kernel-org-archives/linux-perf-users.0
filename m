Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1CA7E9
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753510068; cv=none; b=c26l7FZdHswYoLu7HenHyPBZk1ApdgjW61pnAWUQNWQOzd24YawhMEVeibnBBq60qHe/Er0QLYaeOPj5Dh1Ru1qqcR4GuNw+eyQu53QjQSFE1uWI9WrJlV+H5zJBOG4/L8G0nZesEk+Oh6v765x2NdNNZRHfiXTaOlR9nVQuk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753510068; c=relaxed/simple;
	bh=K7TqohkCUnQ3TJZtiKS471f1LdO8ACGT0T/hv7omKes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekyJ8eqF74Cfx+K/YA/nYB/+GpN311a9/KqV1FiobTXZD3be6lPKq+4M6o7ZsGWEmY+Z+f8ornmNK8XfpQHDc/2PALChh95DePlLLabX/tYqVW0kD3ca0ePmXzM/wDg50KGCadzVwrY2rgYJKesLVuuakLQUod1PfutaeGI/UlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kymZsb5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kymZsb5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437B6C4CEED;
	Sat, 26 Jul 2025 06:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753510067;
	bh=K7TqohkCUnQ3TJZtiKS471f1LdO8ACGT0T/hv7omKes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kymZsb5voRyNVdIvrv0Zw9CI5wJJdP+DzY9JAii99Dp3PKCPPWm6RMyiO1hI+0yR2
	 Bgi3J6bIAMYaj9bHhEE0prlGnEZ1EIvBKVFHpaqWs60ZtY1c74YBiQL8d6Z5mBwHWa
	 EPswApAlXabgUj1ittjZIskV9EffXQbrG6s4oloA0Mfd8vZd9Scocu2kR7JLEWNS3b
	 Q5B2n5UhpDbAP+AtOmEPS5Nwl1srqkv9REDfy1abB5tCeXMtyKD+3L2y4+smQghqZH
	 RIUfvlZuR0mfYhlBVSKoGjVJmg2aWyls8aoElY4M6XTL1+Rk84FxcCMBIzPjmEJnM/
	 +l90HaGUn9z8A==
Date: Fri, 25 Jul 2025 23:07:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jakub Brnak <jbrnak@redhat.com>
Cc: vmolnaro@redhat.com, acme@kernel.org, acme@redhat.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com
Subject: Re: [PATCH v3 3/7] perf test: Provide setup for the shell test suite
Message-ID: <aIRwscmIfCHQkeVS@google.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
 <20250721132642.40906-4-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721132642.40906-4-jbrnak@redhat.com>

On Mon, Jul 21, 2025 at 03:26:38PM +0200, Jakub Brnak wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
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

Looks like better to be documented somewhere.  Maybe you can add a
section like "Add a new (shell) test" in the perf-test man page or so.

Thanks,
Namhyung

> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c  | 30 +++++++++++++++++++++-------
>  tools/perf/tests/tests-scripts.c | 34 ++++++++++++++++++++++++++++++--
>  tools/perf/tests/tests-scripts.h | 10 ++++++++++
>  tools/perf/tests/tests.h         |  8 +++++---
>  4 files changed, 70 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 85142dfb3e01..4e3d2f779b01 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -258,6 +258,22 @@ static test_fnptr test_function(const struct test_suite *t, int test_case)
>  	return t->test_cases[test_case].run_case;
>  }
>  
> +/* If setup fails, skip all test cases */
> +static void check_shell_setup(const struct test_suite *t, int ret)
> +{
> +	struct shell_info* test_info;
> +
> +	if (!t->priv)
> +		return;
> +
> +	test_info = t->priv;
> +
> +	if (ret == TEST_SETUP_FAIL)
> +		test_info->has_setup = FAILED_SETUP;
> +	else if (test_info->has_setup == RUN_SETUP)
> +		test_info->has_setup = PASSED_SETUP;
> +}
> +
>  static bool test_exclusive(const struct test_suite *t, int test_case)
>  {
>  	if (test_case <= 0)
> @@ -347,10 +363,8 @@ static int run_test_child(struct child_process *process)
>  	return -err;
>  }
>  
> -#define TEST_RUNNING -3
> -
> -static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
> -			     int result, int width, int running)
> +static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case, int result, int width,
> +			     int running)
>  {
>  	if (test_suite__num_test_cases(t) > 1) {
>  		int subw = width > 2 ? width - 2 : width;
> @@ -367,7 +381,8 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
>  	case TEST_OK:
>  		pr_info(" Ok\n");
>  		break;
> -	case TEST_SKIP: {
> +	case TEST_SKIP:
> +	case TEST_SETUP_FAIL:{
>  		const char *reason = skip_reason(t, curr_test_case);
>  
>  		if (reason)
> @@ -482,6 +497,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
>  	}
>  	/* Clean up child process. */
>  	ret = finish_command(&child_test->process);
> +	check_shell_setup(t, ret);
>  	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
>  		fprintf(stderr, "%s", err_output.buf);
>  
> @@ -503,8 +519,8 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
>  			pr_debug("--- start ---\n");
>  			err = test_function(test, curr_test_case)(test, curr_test_case);
>  			pr_debug("---- end ----\n");
> -			print_test_result(test, curr_suite, curr_test_case, err, width,
> -					  /*running=*/0);
> +			print_test_result(test, curr_suite, curr_test_case, err, width, /*running=*/0);
> +			check_shell_setup(test, err);
>  		}
>  		return 0;
>  	}
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
> index 21a6ede330e9..d680a878800f 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -138,6 +138,11 @@ static bool is_test_script(int dir_fd, const char *name)
>  	return is_shell_script(dir_fd, name);
>  }
>  
> +/* Filter for scandir */
> +static int setup_filter(const struct dirent *entry){
> +	return strcmp(entry->d_name, SHELL_SETUP);
> +}
> +
>  /* Duplicate a string and fall over and die if we run out of memory */
>  static char *strdup_check(const char *str)
>  {
> @@ -175,6 +180,7 @@ static void free_suite(struct test_suite *suite) {
>  
>  static int shell_test__run(struct test_suite *test, int subtest)
>  {
> +	struct shell_info *test_info = test->priv;
>  	const char *file;
>  	int err;
>  	char *cmd = NULL;
> @@ -187,6 +193,22 @@ static int shell_test__run(struct test_suite *test, int subtest)
>  		file = test->test_cases[0].name;
>  	}
>  
> +	/* Run setup if needed */
> +	if (test_info->has_setup == RUN_SETUP){
> +		char *setup_script;
> +		if (asprintf(&setup_script, "%s%s%s", test_info->base_path, SHELL_SETUP, verbose ? " -v" : "") < 0)
> +			return TEST_SETUP_FAIL;
> +
> +		err = system(setup_script);
> +		free(setup_script);
> +
> +		if (err)
> +			return TEST_SETUP_FAIL;
> +	}
> +	else if (test_info->has_setup == FAILED_SETUP) {
> +		return TEST_SKIP; /* Skip test suite if setup failed */
> +	}
> +
>  	if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
>  		return TEST_FAIL;
>  
> @@ -228,6 +250,7 @@ static struct test_suite* prepare_test_suite(int dir_fd)
>  	}
>  
>  	test_info->base_path = strdup_check(dirpath);		/* Absolute path to dir */
> +	test_info->has_setup = NO_SETUP;
>  
>  	test_suite->priv = test_info;
>  	test_suite->desc = NULL;
> @@ -309,7 +332,7 @@ static void append_scripts_in_subdir(int dir_fd,
>  	int n_dirs, i;
>  
>  	/* List files, sorted by alpha */
> -	n_dirs = scandirat(dir_fd, ".", &entlist, NULL, alphasort);
> +	n_dirs = scandirat(dir_fd, ".", &entlist, setup_filter, alphasort);
>  	if (n_dirs == -1)
>  		return;
>  	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
> @@ -404,7 +427,14 @@ static void append_suits_in_dir(int dir_fd,
>  			continue;
>  		}
>  
> -		test_suite->desc = strdup_check(ent->d_name);	/* If no setup, set name to the directory */
> +		if (is_test_script(fd, SHELL_SETUP)) {	/* Check for setup existance */
> +			char *desc = shell_test__description(fd, SHELL_SETUP);
> +			test_suite->desc = desc;	/* Set the suite name by the setup description */
> +			((struct shell_info*)(test_suite->priv))->has_setup = RUN_SETUP;
> +		}
> +		else {
> +			test_suite->desc = strdup_check(ent->d_name);	/* If no setup, set name to the directory */
> +		}
>  
>  		append_suite(result, result_sz, test_suite);
>  		close(fd);
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
> index 60a1a19a45c9..da4dcd26140c 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -4,8 +4,18 @@
>  
>  #include "tests.h"
>  
> +#define SHELL_SETUP "setup.sh"
> +
> +enum shell_setup {
> +	NO_SETUP     = 0,
> +	RUN_SETUP    = 1,
> +	FAILED_SETUP = 2,
> +	PASSED_SETUP = 3,
> +};
> +
>  struct shell_info {
>  	const char *base_path;
> +	enum shell_setup has_setup;
>  };
>  
>  struct test_suite **create_script_test_suites(void);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 97e62db8764a..0545c9429000 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -6,9 +6,11 @@
>  #include "util/debug.h"
>  
>  enum {
> -	TEST_OK   =  0,
> -	TEST_FAIL = -1,
> -	TEST_SKIP = -2,
> +	TEST_OK         =  0,
> +	TEST_FAIL      	= -1,
> +	TEST_SKIP       = -2,
> +	TEST_RUNNING	= -3,
> +	TEST_SETUP_FAIL = -4,
>  };
>  
>  #define TEST_ASSERT_VAL(text, cond)					 \
> -- 
> 2.50.1
> 
