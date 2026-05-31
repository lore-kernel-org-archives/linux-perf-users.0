Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC38C1F
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205931; cv=none; b=aBP6c31FpxiMMIv10Lpeai6gobOVEZDETZP8mgRPpjVebBkJ9W0+KBgJuqwUVS+K4YY5AaeRzBZwkfGYlSmpbEDhxoejT4499x3IIbAG3TMEJuCNDNLgPu/xPv2caLxlSBbRqqjtxtuqfHdM9LZM67Ga5RiuXkK3hk7wWaR5zM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205931; c=relaxed/simple;
	bh=ae0dTTIP+kwy9VfFNGQLaritbDH9Vajlk0H+ZmjIR8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sznoK8FuqAsdBNTZZwHnbwTLMv0nPmjN9EGMOTHj8F3qWm8tVI6FNtWC17DZPgJ1T0X1e/XJ6MN3PJvC3JJeTI7O8Z1thQ2ChWylZD5453+chzEqfw6xCSfOfZt+XXPrH99CTR3E32dazueS5/7YMGy+auvJs4XWg6RuJ+f7aiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwY8/Qai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwY8/Qai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C7F1F00893;
	Sun, 31 May 2026 05:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780205930;
	bh=72Y+kDv1XF4l52QKLE3Xk3we+dWgVEOJChadTg/faTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WwY8/QaiFc1/FRW60u+RNOow+/K6gGw2+cmNLbyNvjlBvgKOafatxQc+G5VuUujCq
	 Zn9AnbTjZXz64bjM2JX4WW3/XiS/UA6CtBZZ9CjeR/2Cdn1ml8fpc7OoyOWNLHhjTz
	 6pkPb5dZdtob1ny5ybe6768txmTv2Rf70KiySuWX8vA0NJln+gDq+nF7XZ8FanuSEr
	 tQgrS8gftHyQ45bur+WOrGRqRamGwH099Bn9qp76uzj7XK7uFfjimCqH/+4C+C9j3G
	 IiD2zMqExiwVBL+A7jO/aBvKSHF/eazV5ldqgk+Hr+vRejopSoR3B+It1NQEGEeLMV
	 uVU5gequkpZXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/14] perf test: Add summary reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-9-irogers@google.com>
References: <20260531052740.796087-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:38:49 +0000
Message-Id: <20260531053849.D4C7F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Modifying the global `summary_failed_tests_buf` via `strbuf_addf=
()` introduces a heap deadlock and Use-After-Free vulnerability due to sign=
al-interrupted cleanup via `siglongjmp`.
--

commit 2b32c6daec27a49430e06f9134f86bb7cdbad39c
Author: Ian Rogers <irogers@google.com>

perf test: Add summary reporting

This commit introduces an automated global execution summary printed at the
end of a perf test run. It tracks test completion metrics and accumulates
the descriptions of all failed test cases into a global string buffer for
reporting.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -390,6 +401,15 @@ static int print_test_result(struct test_suite *t, i=
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
Is it safe to mutate the global summary_failed_tests_buf here using
strbuf_addf()?

The perf test harness installs a signal handler for SIGINT/SIGTERM
(cmd_test_sig_handler) that abruptly exits the current execution frame via
siglongjmp().

If a user interrupts the tool precisely when strbuf_addf() is executing, the
siglongjmp() will abandon the call mid-flight. Because strbuf_addf() relies
on realloc(), which is not async-signal-safe, this could leave the heap lock
acquired and the global buffer in a corrupted state.

The cleanup path at err_out then unconditionally calls print_tests_summary(=
),
which accesses and frees the buffer:

print_tests_summary() {
    ...
    pr_info("%s", summary_failed_tests_buf.buf);
    strbuf_release(&summary_failed_tests_buf);
}

Could this lead to a deadlock or a use-after-free crash during the emergency
cleanup?

>  		color_fprintf(stderr, PERF_COLOR_RED, " FAILED!\n");
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D8
