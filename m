Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0938F630
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712162; cv=none; b=Nf1Yfvrm2eFiyN5+OVxGIaWfm+ZW38Lu8FQBPspOFXBosuJbGdUzRYOPDt/1wBqUQ6C5s808s72HfWbpPeLaNOXYXW6yZf4lFNAb+BmJF6aM6FG3wIia4q75fy6lH5TcQFdKZbmNhz/3uBDmWiqiekPcpK/tEBaSGhWfEk2xFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712162; c=relaxed/simple;
	bh=izNZ7qTCX/Ae0oOd8SKrfRCI3xDKHl5QPY/FJqq9aHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JwdfG8Tf2/kp+ixyuZCsvv4bgqc9aUUhPjhD0Wptl6J3JNleanVs/z5qkq3h45fBsWIbySgV/1g4uiLniw0huWjciJao9MoK5m2uSIJPyQQkmQ+6LfSbhjz7yrXUQSldLWzpYfybvFkSPSr++fU2L6nxYZJl2V3gYkKqqhTLlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjpg12nW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjpg12nW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC18C2BCB3;
	Wed, 13 May 2026 22:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778712162;
	bh=izNZ7qTCX/Ae0oOd8SKrfRCI3xDKHl5QPY/FJqq9aHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Hjpg12nW9fnDs19mt8iPq7JKO/IjE+aSMyPPd6oi+f/fSY8PjPnbbi1+xN87xpx+R
	 3ArrXB69CVfPYjMSsLduyB4oq9wzt+eLnp1rWA/WLmpRIVWxV56G1N+1A3MotYBRkb
	 KJtKrzMYfW1LGoMF/B5JK/cz43Thp52JtDgkR4RQKzsgRzEuoPwia010Jtp819Kgac
	 5ZqN3ERTQuc8aZIhMJbWFkHB4SgDLMXBGGsGcoT6Z6GoPuRKURc7/Flh37Q+HZy7Hd
	 ZP29HW2DDpBD8aRevpO4qUhdIcWEgtkwX75DkPnqYCIrKP3lm6kNe8tixB0VGFavJB
	 kVP0ll3ur554Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] selftests/perf_events: Add test for refresh limit
 signals
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512-arm_cs_clean_perf_handle-v1-1-75ff373ecd22@arm.com>
References: <20260512-arm_cs_clean_perf_handle-v1-1-75ff373ecd22@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:42:41 +0000
Message-Id: <20260513224242.7EC18C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Using ASSERT_EQ inside FIXTURE_TEARDOWN leads to infinite recursio=
n and masks test failures.
- [Medium] The assertion EXPECT_GT(count.in, 0) will deterministically fail=
 on architectures without fast irq_work support.
--

commit b2c9c1a07e0f0b3e81140a87060db6e67e7d721a
Author: Leo Yan <leo.yan@arm.com>

selftests/perf_events: Add test for refresh limit signals

This commit adds a test to verify PERF_EVENT_IOC_REFRESH with a task-clock
software event. Each iteration sets the refresh count to 5 and waits for a
POLL_HUP notification after 5 task-clock overflows at a 1 microsecond inter=
val.
The sequence is repeated 100 times to verify exactly one POLL_HUP is delive=
red
per iteration.

> diff --git a/tools/testing/selftests/perf_events/refresh_signal.c b/tools=
/testing/selftests/perf_events/refresh_signal.c
> new file mode 100644
> index 0000000000000..9bf05bcd88878
> --- /dev/null
> +++ b/tools/testing/selftests/perf_events/refresh_signal.c
[ ... ]
> +FIXTURE_TEARDOWN(refresh_signal)
> +{
> +	ASSERT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);

Will this lead to infinite recursion if the test fails during setup?

Under kselftest_harness.h, a failing ASSERT_* macro invokes __bail(), which
calls the test's teardown function. If this ioctl fails (e.g., if self->fd =
is
invalid because perf_event_open failed during setup), the ASSERT_EQ will in=
voke
teardown again, causing an infinite recursion that crashes the test.

Should EXPECT_EQ be used here instead to ensure cleanup continues and the
original error is properly reported?

> +
> +	close(self->fd);
> +	sigaction(RT_SIG, &self->old_sa, NULL);
> +}
[ ... ]
> +	/*
> +	 * Events before EVENT_LIMIT are reported as POLL_IN. When the limit
> +	 * is reached, the final event is reported as POLL_HUP. The total
> +	 * number of events is scaled by the number of iterations.
> +	 *
> +	 * Events are delivered via irq_work. If timers expire too close to
> +	 * each other, irq_work may not run before the next timer fires,
> +	 * causing some POLL_IN events to be missed. Therefore, use a
> +	 * less-or-equal comparison for POLL_IN.
> +	 *
> +	 * The last event stops the timer, so the POLL_HUP signal must be
> +	 * observed once per iteration when the limit is reached.
> +	 */
> +	EXPECT_LE(count.in, (EVENT_LIMIT - 1) * ITERATIONS);
> +	EXPECT_GT(count.in, 0);

Can this deterministically fail on architectures without fast irq_work supp=
ort?

On architectures where arch_irq_work_has_interrupt() is false or self-IPI
is not supported, irq_work is executed during the timer tick. Because this
test uses a 1 microsecond hrtimer period, all 5 hrtimer callbacks could fire
within the first ~5 microseconds of the iteration, before the next timer ti=
ck.

The final callback would overwrite the pending signal to POLL_HUP before the
irq_work has a chance to run. When the tick finally executes the irq_work,
only the POLL_HUP signal is delivered. This would cause count.in to remain 0
across all iterations, failing this assertion.

> +	EXPECT_EQ(count.hup, ITERATIONS);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512-arm_cs_cle=
an_perf_handle-v1-0-75ff373ecd22@arm.com?part=3D1
