Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5C3191C8
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216418; cv=none; b=EKwGaR60lDB1BJiocN409tZimZ3L4vZ2LWvTc9/vpLGcGrI/S4dE/kiVMVSEJQoCx7gzJsYuqi36x4oW1LLdu4lPDKbbbF3vIcqUlZ1kXC+HzcfAnQrwaqUW2+Lwti+J7tvzAnpMKZ++6QNqbNblaQqqPGb8P+XALoaTt0D9JTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216418; c=relaxed/simple;
	bh=3F8LqtRrnSxFt+CJV2xvf0dpTxd/b1iAsH+PGc9Hky0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NvWc4zKT/pg7QdBw83TIzthhcBICzEt2fTebftZpeN/ov5j7uSxfjYJFwtgUehmxcQDNe9BY6k1HaZFPB0D20wS2gExZ2PsRd8FE5nVVBuxd6pO0u5P7ok/CISbWMdRa8K5aq8LjVGOARqAnhlfY182xrkaokEid33mhDMiiaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br2j8sek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br2j8sek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728551F00893;
	Sun, 31 May 2026 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780216417;
	bh=mR1vNhGOOBlN7ubi/qYrxqCYhHIpcTY6oEoJTgky/Gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Br2j8sekB2XImZ6nzPVPaCl4BBOI8UO8ZtXGvZrb+qKeud6d5QOEbWY50NkLDdzIe
	 FAcddeGB2sCBDRltRDMfKfzMnnjjkhQGa45xK3/BjqMYM+L4a81WGW7IQmxK8wQ1F4
	 Nh4oTW+GVkaBM7oxhn3ukofrbqwG32eplS7xAAPKpbWcg9cqj/R4HRL/Mpd355nOBS
	 ro/ga6SudWfHmM6+CbM4HlY8mOfow3gKvFyTNGVgXV20EGtoHUWW0Uuo2d0PIAfc1T
	 IiNoMYZ4SKYsqcVaa/9SALcawabYjNYJN7Rmy0efedQCpp82pOYaoYLXqTObqsb9j0
	 FGqSYP2+oDfhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/15] perf test: Add summary reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531082235.940833-10-irogers@google.com>
References: <20260531082235.940833-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 08:33:37 +0000
Message-Id: <20260531083337.728551F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Deadlock and Use-After-Free due to async-signal-unsafe operation=
s in signal-handling exit path.
--

commit 1fcb991e36afddc8078cf7b1052220591400728e
Author: Ian Rogers <irogers@google.com>

perf test: Add summary reporting

This commit introduces an automated global execution summary printed at the
end of the perf test run. It tracks passed, skipped, and failed test cases
using a global strbuf to accumulate the descriptions of failed tests.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -393,6 +403,15 @@ static int print_test_result(struct test_suite *t, i=
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

[Severity: Medium]
Is it safe to use strbuf_addf() here, considering the signal handling in th=
is
test harness?

Since strbuf_addf() can dynamically allocate memory, it is not
async-signal-safe. If a SIGINT or SIGTERM arrives while the allocator lock =
is
held, the signal handler cmd_test_sig_handler() will siglongjmp() out,
leaving the lock permanently held.

>  		color_fprintf(stderr, PERF_COLOR_RED, " FAILED!\n");
>  		break;
>  	}

[ ... ]

> @@ -963,6 +982,23 @@ static void cmd_test_sig_handler(int sig)
>  	siglongjmp(cmd_test_jmp_buf, sig);
>  }
> =20
> +static void print_tests_summary(void)
> +{
> +	pr_info("\n=3D=3D=3D Test Summary =3D=3D=3D\n");

[ ... ]

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

[ ... ]

> @@ -1075,6 +1114,7 @@ static int __cmd_test(struct test_suite **suites, i=
nt argc, const char *argv[],
>  		for (size_t x =3D 0; x < num_tests; x++)
>  			finish_test(child_tests, x, num_tests, width);
>  	}
> +	print_tests_summary();
>  	free(global_pfds);
>  	free(global_pfd_indices);
>  	global_pfds =3D NULL;

[Severity: Medium]
Could this cause a deadlock or a use-after-free if triggered by a signal?

If a signal interrupts strbuf_addf() during an allocation:

tools/perf/tests/builtin-test.c:print_test_result()
    strbuf_addf(&summary_failed_tests_buf, ...)
    /* interrupted during memory allocation */
    cmd_test_sig_handler()
    siglongjmp(cmd_test_jmp_buf, sig);

Execution resumes at the sigsetjmp() site, branches to the err_out label,
and then calls print_tests_summary().

Calling strbuf_release() from print_tests_summary() could attempt to acquire
the same memory allocator lock, causing a deadlock.

Additionally, if the interrupted allocation had just freed the old memory
block but not yet updated the buffer pointer, accessing it here would result
in reading and double-freeing freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531082235.9408=
33-1-irogers@google.com?part=3D9
