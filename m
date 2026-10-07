Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1653624A9
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370963; cv=none; b=kVmyZA0uC0Ww1gPSs4DuDrihFbAQBRAS7HD7ljjdbAKzl1xVJoTlOM5zsJBvgX5XxgCUfFgI5816ad8T+0EarYjhz7nHk3Ijn+yCtfwoo7z57wPFUAyNtcnq/XXZWFyn0UG94tkSoc6ZL+3+/OEAbKmHvCBjxDj/foNLEAiTAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370963; c=relaxed/simple;
	bh=vl/Sy8c9BAiIytzm2kvQMtZfiIlnL1wPnbaTbozEOTQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VU1rRNrl3gUjnn91AOXICpCN22VgSNa0GV3AHpdiCyvWKJddMmvUQ1Pr/+cUSw0zFoGbthhG9gxnHPWfJASXLgFAXMeW5ndQvjAKzVbY+nMnZSqaN1vaeseEdTCXG+Qpm4Ve0LOPOKglDBp1YWAw8JZgKbpX6Y39JkSQu8njiB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqPy84gz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqPy84gz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948511F0089F;
	Wed,  7 Oct 2026 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791370939;
	bh=ptcGsITDXeQhg1SOLgJ5jX7fc7df5TAr/DmVs/uZoN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gqPy84gzrT0jovd/ynt1pepAvlV7hHcoYyUQie0xIV0Yh/QyNi3M6liiB0abkp1Ds
	 GR4gZjbmzCosjPOGqzgdT+QS1wAdGzrO07MV5UchjsLYZsexQ7rB6xlcGoUiTL9QQB
	 SGWmpqwSjJjHrtGnRJIAd08RVbdLGIU8fXLe1aY/bJRNSXB3XIM+lGXosqT1i9ZIEJ
	 GfGLCpZqZuLq/K086JSzfRkOPdmSXt4pv1RbQOAGkU8AMS+dqtg8mZXdr4xuQuQLoK
	 hMQM6u79IRhgQz2rej2Umt0xzFI6v97nw/HwS+okGSTcWkAbrhfE4gCmvuxpGay+Op
	 6mxzSwX0pcKNg==
Message-ID: <sashiko-outbox-162902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf tests: mmap-basic: fix user rdpmc detection
 logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261007-rdpmc-detection-logic-v6-2-d7ed6a85f864@linaro.org>
References: <20261007-rdpmc-detection-logic-v6-0-d7ed6a85f864@linaro.org>
 <20261007-rdpmc-detection-logic-v6-2-d7ed6a85f864@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:02:19 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf tests: CPU affinity reset to all CPUs on early skip
--

commit 2dbb7615f7e3bec6f5e3a6ddba0d0fa138ec8fc9
Author: James Clark <james.clark@linaro.org>

perf tests: mmap-basic: fix user rdpmc detection logic

This commit introduces a fallback in set_user_read() to handle user counter
access on RISC-V and Arm through /proc/sys/kernel/perf_user_access. It also
refactors how the user_read_state is verified, adding early test skips when
these sysfs files return permission errors. Finally, it simplifies the
checks around cap_user_rdpmc to ensure the state matches what was requested.

> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 208cd889f23db..2d892a51a7f43 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -256,8 +289,28 @@ static int test_stat_user_read(u64 event, enum user_=
read_state enabled)
>  		bool mapped =3D false, opened =3D false, rdpmc_supported;
>  		struct perf_counts_values counts =3D { .val =3D 0 };
> =20
> +		if (__is_defined(__aarch64__) && enabled =3D=3D USER_READ_ENABLED)
> +			attr.config1 =3D 0x2;  /* Request user access */
> =20
>  		pr_debug("User space counter reading for PMU %s\n", pmu->name);
> +
> +		if (saved_user_read_state =3D=3D USER_READ_ERR_PERM) {
> +			pr_debug("User space counter reading for PMU %s [Failed to get user r=
ead state]\n",
> +				 pmu->name);
> +			ret =3D TEST_SKIP;
> +			goto cleanup;
> +		}
> +
> +		/* Check value is in the expected range */
> +		if (saved_user_read_state !=3D USER_READ_ERR_NO_FILE &&
> +		    (saved_user_read_state < USER_READ_DISABLED ||
> +		     saved_user_read_state >=3D USER_READ_MAX)) {
> +			pr_err("User space counter reading for PMU %s [Unexpected current sta=
te %d]\n",
> +				pmu->name, saved_user_read_state);
> +			ret =3D TEST_FAIL;
> +			goto cleanup;
> +		}
> +
>  		/*
>  		 * Restrict scheduling to only use the rdpmc on the CPUs the
>  		 * event can be on. If the test doesn't run on the CPU of the

[ ... ]

> @@ -363,7 +413,8 @@ static int test_stat_user_read(u64 event, enum user_r=
ead_state enabled)
>  			perf_evsel__munmap(evsel);
>  		if (opened)
>  			perf_evsel__close(evsel);
> -		perf_evsel__delete(evsel);
> +		if (evsel)
> +			perf_evsel__delete(evsel);
> =20
>  		/* If the affinity was changed, then put it back to all CPUs. */
>  		if (pmu->cpus !=3D NULL) {

[Severity: Low]
Does this code inadvertently broaden the process's CPU affinity when the PMU
iteration is skipped early?

When test_stat_user_read() jumps to cleanup due to a permission error or
invalid state, the thread's affinity was never narrowed to the PMU's CPUs
since the narrowing happens further down in the loop.

However, since the cleanup block unconditionally resets the CPU affinity to
all online CPUs if pmu->cpus is not NULL, could this override any
pre-existing affinity constraints the test process might have had?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-rdpmc-dete=
ction-logic-v6-0-d7ed6a85f864@linaro.org?part=3D2
