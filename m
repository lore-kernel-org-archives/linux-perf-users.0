Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832E34846A
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210220; cv=none; b=rKZ0kfWJ9nAVO1/VyRoOITVNNv6+oeCx1RDew6CZjHZck0Ft96LqwVvxfjoDjNA+MwnZGTCYVSDEVU0aspxNjMcuCnFxoBzFM1NSZ905XdzdMFFfBBXgEP4+9bCp4fZib5D7FKF0xMWeXPY8Bobf+DQSecm3q/GR4PmbbdXjqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210220; c=relaxed/simple;
	bh=pIsidJYnISsPIa1X317p4gFW37DAGkPq333RY3hcj7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hlVd5mXD6NoPyCdh84RdNFSszsnWbBan/RKfuKfaXsrE5I2/2pflt1RSNAZOaJLQKUYlkDyTPkpKsoZAJS8xSAtRLdvmjgvImINQOPZ6JU5V+eVQVZs8kRNs9n+coQzTgxQZQHKI6HZAmkUY+/0m9/H9ONAGJep1gjqHsvbIz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtXwXjOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtXwXjOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D073F1F00898;
	Sun, 31 May 2026 06:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210214;
	bh=kFdd8LcccDMYOnPZwFJZHwl0qWV73KpPvNGatB08Cuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PtXwXjOzrF0mvbAoxg7tmJBmSMbVuVYc+UTF6x/ASH0i5a+jOLdDoSwiCRa244b4K
	 dQbGrs7lRzfhzkt0da45HD2nZWwuSOwGpj9+e/s6QuXFeSojGJl3uVYVcAUhijErjk
	 IHB3jltgKtBGjuPeWsjAmZAR3U2uVneMTdme/zIxQkDvndPQkkVlOMD6zuSBY+sEpG
	 hAHDxlhrNtDic2p1RVjscmqe4McGqPC/bRjKkcKXlkWgH1+cjjppweN8GJ6JnWcJ6X
	 DRdncW9R44O2RovQBisA7HIeNbkBidEzZn+AAd+QVqT5a03UDfw5a9F6TVRmEuY6W7
	 KQyRz3yNf7Shg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/14] perf test: Add summary reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531063736.871777-9-irogers@google.com>
References: <20260531063736.871777-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 06:50:13 +0000
Message-Id: <20260531065013.D073F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The emergency signal cleanup path is vulnerable to heap corrupti=
on and deadlocks due to non-async-signal-safe string buffer operations. `pr=
int_tests_summary()` is explicitly called on the signal abort path (`err_ou=
t`) and both reads from `summary_failed_tests_buf` and calls `strbuf_releas=
e()` on it. Since `strbuf_addf()` allocates memory using the heap lock duri=
ng normal execution, a signal (e.g., SIGINT) interrupting it will cause `si=
glongjmp()` to leave the heap lock held. Calling `strbuf_release()` will th=
en re-enter `free()`, attempting to acquire the same heap lock, causing an =
irreversible deadlock. Additionally, the buffer may be left in an inconsist=
ent state, leading to a crash when its contents are read.
--

commit 15adcea6916685e103e56321c61c30c9432f83d1
Author: Ian Rogers <irogers@google.com>

perf test: Add summary reporting

This commit introduces an automated execution summary printed at the end
of a perf test run. It tracks the pass, skip, and fail counts, along with
descriptions of failed tests accumulated in a string buffer. The summary is
printed just before freeing the test array, ensuring it is displayed even
if an internal signal cleanup occurs.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index a29925656865b..bd356249c70ba 100644
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
If a signal like SIGINT interrupts execution while strbuf_addf() is dynamic=
ally
allocating memory (and holding the heap lock), will siglongjmp() leave the
heap lock held?

>  		color_fprintf(stderr, PERF_COLOR_RED, " FAILED!\n");
>  		break;
>  	}
> @@ -975,6 +994,23 @@ static void cmd_test_sig_handler(int sig)
[ ... ]
> +static void print_tests_summary(void)
> +{
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

[Severity: Medium]
Can reading from summary_failed_tests_buf and calling strbuf_release() cause
a crash or deadlock if called after a signal interrupt?

If the signal interrupted strbuf_addf(), the buffer might be left in an
inconsistent state causing a crash when read.

Similarly, strbuf_release() calls free(), which could attempt to acquire
the heap lock that was already held when the signal fired, resulting in a
deadlock.

> +}
> +
>  static int __cmd_test(struct test_suite **suites, int argc, const char *=
argv[],
>  		      struct intlist *skiplist)
>  {
[ ... ]
> @@ -1087,6 +1126,7 @@ static int __cmd_test(struct test_suite **suites, i=
nt argc, const char *argv[],
>  		for (size_t x =3D 0; x < num_tests; x++)
>  			finish_test(child_tests, x, num_tests, width);
>  	}
> +	print_tests_summary();

[Severity: Medium]
Does invoking print_tests_summary() here on the emergency signal abort path
make the tool vulnerable to the deadlock and crash mentioned above?

>  	free(global_pfds);
>  	free(global_pfd_indices);
>  	global_pfds =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531063736.8717=
77-1-irogers@google.com?part=3D8
