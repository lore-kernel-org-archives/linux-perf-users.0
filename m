Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D4FC12;
	Wed,  3 Jul 2024 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977999; cv=none; b=SYNV9zUPl92O0jHyDuTpG/hgGQmpPCChUntqJKaNQ5SUAlBp+RJAJIYIe7bGklpaoAPocS1EKqgvql6QYJOo/MnI0PL6q4sv59VTKhxgl8ouz3499rODGyAeoY/iBqFKgU8S16pNeAynlaTocm4usUBNOQltgTWZWoS/o9u+Kx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977999; c=relaxed/simple;
	bh=XHjEpxo6pYX52KNc9v2EQAaK5Y5dA48r1Bk6OC1VTc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6TpJf+3VZ8zqq13d3/nDzHvXowjHjW6SMHgBWRi+5Ls/vga8sxO1ZPJlAKfWdCTXqlpm/6pQj/pQQdcDDF2/PGkyrM3PIK6qJ6sUIjgvbJKw+qgqB+2Z42BOT5Gc0ohsLv7QMnE0F56iGbADF9goK0ythgUcsuLMmQriETquMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwECEQm9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwECEQm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3432C116B1;
	Wed,  3 Jul 2024 03:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719977999;
	bh=XHjEpxo6pYX52KNc9v2EQAaK5Y5dA48r1Bk6OC1VTc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwECEQm9j1NRqRCtVf/o5qfAqMTP7Gd2Yv2mw0dQ4ZEijnRZKGw/1k3wCDapvZFED
	 aNMmuuHuyYPfyh34vrIAyX/QmgAVQFCbha9zMepEGb97GHbSEx1pbBphHcZgxO0Ptr
	 E6j35r9+hxUn7lnayFaM4jkUWkAT4mxe1JsWeCrndKfomieMNiDy+aNU7LZUnCVTwC
	 5pgAUICXoZXxeykyPTbo/EBMVrjQXFKjxQx6+kf0WGGYFVykoYB9BoNEWfMZMCUNfq
	 gg+oT4+Ez1YQmdPrL962CzhFPvHjiPcL3CsbBSU8+s/Vxh/cXdvndjv85aYR4BrUcu
	 Y9riT/xVxlJ8w==
Date: Tue, 2 Jul 2024 20:39:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf test: Display number of remaining tests
Message-ID: <ZoTIDCXKZw0bnthC@google.com>
References: <20240701044236.475098-1-irogers@google.com>
 <20240701044236.475098-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701044236.475098-3-irogers@google.com>

On Sun, Jun 30, 2024 at 09:42:36PM -0700, Ian Rogers wrote:
> Before polling or sleeping to wait for a test to complete, print out
> ": Running (<num> remaining)" where the number of remaining tests is
> determined by iterating over the remaining tests and seeing which
> return true for check_if_command_finished. After the delay, erase the
> line and either update it with the new number of remaining tests, or
> print the test's result. This allows a user to know a test is running
> and in parallel mode (default) how many of the tests are waiting to

It's not default anymore. :)


> complete. If color mode is disabled then avoid displaying the
> "Running" message.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 77 ++++++++++++++++++++++-----------
>  tools/perf/util/color.h         |  1 +
>  2 files changed, 53 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index c3d84b67ca8e..23be9139f229 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -241,7 +241,10 @@ static int run_test_child(struct child_process *process)
>  	return -err;
>  }
>  
> -static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
> +#define TEST_RUNNING -3
> +
> +static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
> +			     int remaining)
>  {
>  	if (has_subtests(t)) {
>  		int subw = width > 2 ? width - 2 : width;
> @@ -251,6 +254,9 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
>  		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
>  
>  	switch (result) {
> +	case TEST_RUNNING:
> +		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d remaining)\n", remaining);
> +		break;
>  	case TEST_OK:
>  		pr_info(" Ok\n");
>  		break;
> @@ -272,13 +278,15 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
>  	return 0;
>  }
>  
> -static int finish_test(struct child_test *child_test, int width)
> +static int finish_test(struct child_test **child_tests, int running_test, int child_test_num,
> +		       int width)
>  {
> +	struct child_test *child_test = child_tests[running_test];
>  	struct test_suite *t = child_test->test;
>  	int i = child_test->test_num;
>  	int subi = child_test->subtest;
>  	int err = child_test->process.err;
> -	bool err_done = err <= 0;
> +	bool err_done = false;
>  	struct strbuf err_output = STRBUF_INIT;
>  	int ret;
>  
> @@ -293,7 +301,7 @@ static int finish_test(struct child_test *child_test, int width)
>  	 * Busy loop reading from the child's stdout/stderr that are set to be
>  	 * non-blocking until EOF.
>  	 */
> -	if (!err_done)
> +	if (err > 0)
>  		fcntl(err, F_SETFL, O_NONBLOCK);
>  	if (verbose > 1) {
>  		if (has_subtests(t))
> @@ -307,29 +315,48 @@ static int finish_test(struct child_test *child_test, int width)
>  			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
>  			},
>  		};
> -		char buf[512];
> -		ssize_t len;
> -
> -		/* Poll to avoid excessive spinning, timeout set for 100ms. */
> -		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
> -		if (!err_done && pfds[0].revents) {
> -			errno = 0;
> -			len = read(err, buf, sizeof(buf) - 1);
> -
> -			if (len <= 0) {
> -				err_done = errno != EAGAIN;
> -			} else {
> -				buf[len] = '\0';
> -				if (verbose > 1)
> -					fprintf(stdout, "%s", buf);
> -				else
> +		if (perf_use_color_default) {
> +			int tests_in_progress = running_test;
> +
> +			for (int y = running_test; y < child_test_num; y++) {
> +				if (check_if_command_finished(&child_tests[y]->process))
> +					tests_in_progress++;
> +			}
> +			print_test_result(t, i, subi, TEST_RUNNING, width,
> +					  child_test_num - tests_in_progress);
> +		}
> +
> +		err_done = true;
> +		if (err <= 0) {
> +			/* No child stderr to poll, sleep for 10ms for child to complete. */
> +			usleep(10 * 1000);
> +		} else {
> +			/* Poll to avoid excessive spinning, timeout set for 100ms. */
> +			poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);

When I tested this patch, I saw it refreshes too often in parallel mode.
Maybe 100ms is too short?  I don't know if it's from usleep (10ms) or
here.

Thanks,
Namhyung


> +			if (pfds[0].revents) {
> +				char buf[512];
> +				ssize_t len;
> +
> +				len = read(err, buf, sizeof(buf) - 1);
> +
> +				if (len > 0) {
> +					err_done = false;
> +					buf[len] = '\0';
>  					strbuf_addstr(&err_output, buf);
> +				}
>  			}
>  		}
> +		if (err_done)
> +			err_done = check_if_command_finished(&child_test->process);
> +
> +		if (perf_use_color_default) {
> +			/* Erase "Running (.. remaining)" line printed before poll/sleep. */
> +			fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
> +		}
>  	}
>  	/* Clean up child process. */
>  	ret = finish_command(&child_test->process);
> -	if (verbose == 1 && ret == TEST_FAIL) {
> +	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL)) {
>  		/* Add header for test that was skipped above. */
>  		if (has_subtests(t))
>  			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
> @@ -338,7 +365,7 @@ static int finish_test(struct child_test *child_test, int width)
>  		fprintf(stderr, "%s", err_output.buf);
>  	}
>  	strbuf_release(&err_output);
> -	print_test_result(t, i, subi, ret, width);
> +	print_test_result(t, i, subi, ret, width, /*remaining=*/0);
>  	if (err > 0)
>  		close(err);
>  	return 0;
> @@ -354,7 +381,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
>  		pr_debug("--- start ---\n");
>  		err = test_function(test, subi)(test, subi);
>  		pr_debug("---- end ----\n");
> -		print_test_result(test, i, subi, err, width);
> +		print_test_result(test, i, subi, err, width, /*remaining=*/0);
>  		return 0;
>  	}
>  
> @@ -379,7 +406,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
>  	err = start_command(&(*child)->process);
>  	if (err || !sequential)
>  		return  err;
> -	return finish_test(*child, width);
> +	return finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
>  }
>  
>  #define for_each_test(j, k, t)					\
> @@ -464,7 +491,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  	}
>  	for (i = 0; i < child_test_num; i++) {
>  		if (!sequential) {
> -			int ret  = finish_test(child_tests[i], width);
> +			int ret  = finish_test(child_tests, i, child_test_num, width);
>  
>  			if (ret)
>  				return ret;
> diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
> index 01f7bed21c9b..4b9f8d5d4439 100644
> --- a/tools/perf/util/color.h
> +++ b/tools/perf/util/color.h
> @@ -22,6 +22,7 @@
>  #define MIN_GREEN	0.5
>  #define MIN_RED		5.0
>  
> +#define PERF_COLOR_DELETE_LINE	"\033[A\33[2K\r"
>  /*
>   * This variable stores the value of color.ui
>   */
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
