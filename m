Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA931B837
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775010; cv=none; b=RxQDGk0/c064hFdAPecV/IaO62dN8Q4SOGlB7IY20Yv+Z6SGgmeDAH3MQMaAK/kBSvYHd6QxM0mEM/HNgL16D1AnZTVqH3J/ClmdVdW3vZP9FjuP+ZLIzxsOUeMAHj4qfiScIzwQ8TXXGwGIY3kKCB+jB/R8axIdVM5678WZZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775010; c=relaxed/simple;
	bh=WLYFGOImniX0YyDO1tXAcZB2rym7cag1MUhTG59babg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dKL3nwyYQEpfXkRNgi+b7Oy5bzLfkbmN9Ri4kidROjR6UuIrzas/5yreCb9WyK5pPZrPiqDEvf5FW+aiwCALwUrXE+k5WJXPcInDoq7V/7c1ITqQjN81mciTXIPtde1IfxOQpYKybWL0kbM7Cs2jzclFmgZV6bzUpCkrp738nHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T88GOFby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T88GOFby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD743C2BCB7;
	Thu, 14 May 2026 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778775010;
	bh=WLYFGOImniX0YyDO1tXAcZB2rym7cag1MUhTG59babg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=T88GOFbyzKzzErnI5qlXNqkQH6xBidUgTadRiinbapPgQY+2MyOE8bx4wunMl8EQR
	 CACchVX0mAsVX8OFJPH4iC/X3kn4Cldi3AbDVjp4FymT5sRzg0oZKOZpP7h8q/IzRu
	 Qri1jBZ69Nxi3sOfjCqv3tGfkkK4hWvldYzPgIoO+LRMPvLXrLFfnFrngLwcFvSKfp
	 OB47Ju/biWsaEYzz3L93rmfLSubUA1Jsj3NFzys0A3J8klIHXdWotbeWneuBrBoxIP
	 mRUxiXv26jWKBmJZ6Arbd2d2yINu1FQpUO2xPTuU26ETCf2S9/gYpcvpmtsZqjmiz/
	 1L7NzDzdPNq0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/14] perf test: Add summary reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513230450.529380-9-irogers@google.com>
References: <20260513230450.529380-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 16:10:09 +0000
Message-Id: <20260514161009.CD743C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Test summary is bypassed on error paths, leaking memory and cont=
radicting the commit message.
- [Medium] User-overridden skipped tests are double-counted in the summary =
statistics.
- [Medium] Async-signal-safety deadlock due to `strbuf_addf` allocations in=
 signal-interrupted paths.
--

commit 6ba5c5902b4731354e1e3209d7b4d55a0a3bc650
Author: Ian Rogers <irogers@google.com>

perf test: Add summary reporting

This commit introduces a global execution summary for perf tests, tracking
pass, skip, and fail counts and printing them at the end of the run. It also
records failed test descriptions into a buffer for easy cross-referencing.

> 4. Invoke the summary printer right before freeing the test array at the
>    absolute tail of __cmd_test(), guaranteeing that the summary is
>    successfully printed even if an internal emergency signal cleanup occu=
rs
>    or if the user interrupts the run early.

Is this description accurate? Looking at __cmd_test(), print_tests_summary()
is placed inside an else block that is bypassed if err is set.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 45c1afb9ad333..193a7dec6d5f3 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -389,6 +400,15 @@ static int print_test_result(struct test_suite *t, i=
nt curr_suite, int curr_test
>  		break;
>  	case TEST_FAIL:
>  	default:
> +		summary_tests_failed++;
> +		if (test_suite__num_test_cases(t) > 1)
> +			strbuf_addf(&summary_failed_tests_buf, "  %3d.%1d: %s\n",
> +				    curr_suite + 1, curr_test_case + 1,
> +				    test_description(t, curr_test_case));
> +		else
> +			strbuf_addf(&summary_failed_tests_buf, "  %3d: %s\n",
> +				    curr_suite + 1,
> +				    test_description(t, curr_test_case));
>  		color_fprintf(stderr, PERF_COLOR_RED, " FAILED!\n");

If a signal interrupts the main thread while it holds the libc heap lock,
could this lead to a deadlock? The cleanup path triggered by the signal
handler calls:

cmd_test_sig_handler() -> siglongjmp() -> finish_test() ->
print_test_result() -> strbuf_addf()

which can invoke realloc() while the heap lock is already held.

[ ... ]

> @@ -1045,6 +1081,7 @@ static int __cmd_test(struct test_suite **suites, i=
nt argc, const char *argv[],
>  				pr_info("%3d: %-*s:", curr_suite + 1, width,
>  					test_description(*t, -1));
>  				color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
> +				summary_tests_skipped++;
>  				continue;
>  			}

Since this code runs inside the for (int pass =3D 1; pass <=3D 2; pass++) l=
oop,
will this increment summary_tests_skipped twice for each user-skipped
test suite?

[ ... ]

> @@ -1076,6 +1113,8 @@ static int __cmd_test(struct test_suite **suites, i=
nt argc, const char *argv[],
>  		pr_err("Internal test harness failure. Completing any started tests:\n=
:");
>  		for (size_t x =3D 0; x < num_tests; x++)
>  			finish_test(child_tests, x, num_tests, width);
> +	} else {
> +		print_tests_summary();
>  	}
>  	free(child_tests);
>  	return err;

Since print_tests_summary() is only called in the else branch, does this
leak summary_failed_tests_buf when err is non-zero (for instance, when
handling an internal emergency signal cleanup)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513230450.5293=
80-1-irogers@google.com?part=3D8
