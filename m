Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970BD4963BF
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020802; cv=none; b=ZdaiRI64X8dpYO/diohPpVwOGoTx7Q4r85WcDdC80+P2po8LSG6o+/RKD5rAx9CbCCXHyVByIlsMW/DzRTucOQkZuhZ12MahmBIbgYccpRZlkG+tnewY3NrnsXOQ7LeqnSjOW+gjUXA9QR+CLpxJY0eJ8+asu4cTvPbRLDIuHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020802; c=relaxed/simple;
	bh=KEvVQzHCnu7e54qpgZyC/8yp666/iL/shR5KH76sUzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWe8xh6wzZPzIR7jWR3aSJmRpScxRuisas6ihmKv1wiz8o93M6a1RvpgY4I0Wj56S4JNY3Oth7fK/S8AutvleBxm4U5x9BOjsoVsW9O0PvmdIhpsm+q0aWKVkh0VrY+gWp5RdfyjRxW9mQWM6+HERhliu5BjqPWed8Gav7khqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYZ2dDS1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYZ2dDS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2739E1F00893;
	Tue,  9 Jun 2026 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020801;
	bh=INiizFLKT7LRBkRGCR5vOTzYGpcUIRIvA2Uca0LAxCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jYZ2dDS1lJTtpbao8ntzNpLX4VI61Ub1dd26CbKs0xhZ8grPmEenpZI2QRPL2yO1E
	 2PHnips/hd2VEalBYX3pIlp12vmW/iBN7jbsS/D+qsb/WwUQO2cRtCvoLLzbmiXgDW
	 eeKsZdFiYTRKWNtQJqsZtvCaTDzVk0lsHpWtFZaj189fS/no78uehuvuHKIzn2ELVr
	 7PPQhIg7TJUFfPtArlWQmw9cAA78q7ZJSOwykknZ405MFVTehyh8eWMXD3noiAZqnc
	 aaOGGOAuXshs8v3RkIjqkv5JeTkGNe9F/TYRCgJLi7W2DZFyQJSyc7tCfPRWPWg8n/
	 HPreWor6tNthw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/19] perf test: Add named_threads workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-9-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-9-d53a7d096a19@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:00:00 +0000
Message-Id: <20260609160001.2739E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test workload loop is optimized away by the compiler, contai=
ns a C11 data race on a shared variable, and contradicts its commit message.
--

commit dcd726ac63da1e487f029b2a3e5128fec278becd
Author: James Clark <james.clark@linaro.org>

perf test: Add named_threads workload

This commit adds a new workload to perf tests that runs multiple threads,
each executing a unique function that loops and sets its thread name. It
is intended to test processor trace decoding for concurrent threads.

> perf test: Add named_threads workload
>=20
> Add a workload that runs X threads that run a unique function named
> "named_threads_thread[x]" which performs a multiplication in a loop for

[Severity: Low]
The commit message mentions performing a multiplication, but the
implementation uses addition. Is this the intended behavior?

> Y loops. Each thread sets its name to "thread[x]".

[ ... ]

> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workload=
s/Build
> index 90f2d8aa4941f..75b377934a0e6 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -2,6 +2,7 @@
> =20
>  perf-test-y +=3D noploop.o
>  perf-test-y +=3D thloop.o
> +perf-test-y +=3D named_threads.o

[Severity: Medium]
In tools/perf/tests/workloads/Build, unlike other loop workloads in this
directory, there is no CFLAGS_named_threads.o =3D -O0 override.

Without this, will the compiler optimize the loop away into a single
arithmetic operation and remove the branch instructions this test relies on?

>  perf-test-y +=3D leafloop.o

[ ... ]

> diff --git a/tools/perf/tests/workloads/named_threads.c b/tools/perf/test=
s/workloads/named_threads.c
> new file mode 100644
> index 0000000000000..d051d41a3cfe4
> --- /dev/null
> +++ b/tools/perf/tests/workloads/named_threads.c

[ ... ]

> +#define DEFINE_THREAD(n)						\
> +noinline void *named_threads_thread##n(void *arg __maybe_unused)	\
> +{									\
> +	pthread_setname_np(pthread_self(), "thread" #n);		\
> +	for (int i =3D 0; i < iterations; i++)				\
> +		named_threads_work +=3D 3;				\

[Severity: Medium]
In DEFINE_THREAD() within tools/perf/tests/workloads/named_threads.c,
named_threads_work is a shared global variable accessed concurrently by
multiple threads.

Without atomic operations or locks, does this introduce a data race?

This might trigger ThreadSanitizer test failures during execution.

> +									\
> +	return NULL;							\
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v5-0-d53a7d096a19@linaro.org?part=3D9
