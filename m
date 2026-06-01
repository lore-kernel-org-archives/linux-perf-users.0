Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C411A680A
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273025; cv=none; b=pULqOlRFaoywttfMEEcX8mMre1lZjCl7AtrpmqsPfGTMxr40rezNUksZObu95CVKSGhlqzWrY0Ec+kgSn0iXfJyxG01L4EtjbUTLWOMEmO47h7N3mwgeyQTCaPTwgPDd9M6+OGf5pzM+KBb1HG9QPYY63NzZ2oa52LJ0gp1uKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273025; c=relaxed/simple;
	bh=lERVNMpSyA4xhK0ctlbOtitAymaNT8OxE6fndAvGANA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TkpTMkrVqSy8faphvLsGhemV4wpD3Om7Cmu/wbID2xjmpiyNNBnmX5SAeatMwic8w8rQ9fTxeAIe3j/56dKafXEhTTW4Cs3Ho7Bl88kVkvy93ppnVm8HWe0RhU8ioHYzGNk4qX+vNWY5I5J+BN/tbZTXXJSiH9764MOE8r2zd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9S2tqjg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9S2tqjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60411F00893;
	Mon,  1 Jun 2026 00:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780273024;
	bh=pA1xtZ11nOTx1zjr4XnlCJtkjVj3fEyaiZiybqecYAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R9S2tqjg7A+/8moQe6IiI5RQdYZE9+r0ofkbfGa/bAce+NG+Y/QlnFd8N9wkcFepb
	 Xnb/HxmklIH51q0ayoKqIDju1CLzYMeC6ORiOP/IfZ8Kg8qubJkHSxDe/OrDQ/M8J/
	 9JKZQS0n0c4nQHP+2fYMwf6usjSck5Az9soKWpIDVRb2RIxEqfn7eeElCv/4aPr1bx
	 pnPXOx4nYpWVMogjcRnuYIW63t9W2pyBc4TOouskeVLUv4R3STGZ6tInFs9Q0ctTYR
	 dPrQFkXm8IvsE8Gq0Nx7guVPepsfaTRUzt45y0OdbPhfXLD0JD/e/4JbQjYio9T1lL
	 dNfmde9F8TaqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] perf test: Add summary reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601000548.1195604-10-irogers@google.com>
References: <20260601000548.1195604-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 00:17:03 +0000
Message-Id: <20260601001703.D60411F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a Use-After-Free and Double Free vulnerabil=
ity by attempting to read and release a dynamically allocated string buffer=
 (`summary_failed_tests_buf`) on the emergency signal cleanup path.
--

commit f5ac11752bd41259824d926b27193d632a097f85
Author: Ian Rogers <irogers@google.com>

perf test: Add summary reporting

This commit introduces an automated global execution summary printed at the
tail of the test run, tracking passed, skipped, and failed test cases,
along with descriptions of failed tests.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index e00b0bffa67cf..336d24105c9f9 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -963,6 +982,23 @@ static void cmd_test_sig_handler(int sig)
>  	siglongjmp(cmd_test_jmp_buf, sig);
>  }
> =20
> +static void print_tests_summary(void)
> +{
> +	pr_info("\n=3D=3D=3D Test Summary =3D=3D=3D\n");
> +	pr_info("Passed main tests : %u\n", summary_tests_passed);
> +	pr_info("Passed subtests   : %u\n", summary_subtests_passed);
> +	pr_info("Skipped tests     : %u\n", summary_tests_skipped);
> +	if (summary_tests_failed > 0) {
> +		color_fprintf(stderr, PERF_COLOR_RED, "Failed tests      : %u\n",
> +			      summary_tests_failed);
> +		pr_info("List of failed tests:\n");
> +		pr_info("%s", summary_failed_tests_buf.buf);
> +	} else {
> +		color_fprintf(stderr, PERF_COLOR_GREEN, "Failed tests      : 0\n");
> +	}
> +	strbuf_release(&summary_failed_tests_buf);
> +}
> +
>  static int __cmd_test(struct test_suite **suites, int argc, const char *=
argv[],
>  		      struct intlist *skiplist)
[ ... ]
> @@ -1075,6 +1114,7 @@ static int __cmd_test(struct test_suite **suites, i=
nt argc, const char *argv[],
>  		for (size_t x =3D 0; x < num_tests; x++)
>  			finish_test(child_tests, x, num_tests, width);
>  	}
> +	print_tests_summary();

[Severity: Medium]
Can this sequence lead to a use-after-free and double-free if the test suite
is interrupted by a signal?

If a signal like SIGINT arrives while print_test_result() is dynamically
reallocating the string buffer via strbuf_addf():

print_test_result() {
        ...
        strbuf_addf(&summary_failed_tests_buf, "  %3d.%1d: %s\n", ...);
        ...
}

The signal handler cmd_test_sig_handler() uses siglongjmp() to abort
execution and jumps directly to the err_out path in __cmd_test().

__cmd_test() {
...
err_out:
        ...
        if (err) {
                ...
        }
        print_tests_summary();
...
}

If realloc() had already freed the old memory block but the signal
interrupted execution before the summary_failed_tests_buf.buf pointer could
be updated, would print_tests_summary() dereference a freed pointer when
printing the summary, and then double-free it during strbuf_release()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601000548.1195=
604-1-irogers@google.com?part=3D9
