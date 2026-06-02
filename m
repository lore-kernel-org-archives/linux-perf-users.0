Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FD39184A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412484; cv=none; b=Ciot3TvWAXB3OVk9iaHMuRsarw9OBM59juW1iELA+zbnF5CLgRtmiNOgilw0gyDNqgaMXYHfeLFJGILTBEawENRgEJmKgWEnlPzgQXGTzmY82jB1suvWkZy9Ycr/gUIHdrE63EglVfO3X3Ib0CozY6/WNz1P7jbGFwv3rjjex/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412484; c=relaxed/simple;
	bh=23oBdI50Y9eH6f1Bogq5UGFSutLFWqPr2N6e+KDYU/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qjylTyijfKfMZBzMDj517opd+CFeVdcfIiEQcQpTRchoh/vdQpefvMG6B+g4W+yV9K32HGzb9cDNzKoNB0+x9tF13ogob95OMiC6iQXK/jUzfF0Rl67uKyUFaGx6XZ3LLBFHuNsnphjWZQqvxJtGPXJNzmwdMbxzpMjzyXg+6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fie3dVRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fie3dVRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8BB1F00898;
	Tue,  2 Jun 2026 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412482;
	bh=+Mkophv1GfE5JKtZqbU1nuMt8ZaLDdMMF5vr5vhpCq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fie3dVRhGa6IlpA7g7Kwkv6AWZkbznce2jHXFRZAQcTkutrbR4/EYduKuX41EP8qh
	 +2pAqJqv0bw4lorbMe+R7KlocyrMmhg/rdmKyAYYUPAWfpWOGuuPaLcT1t2xK2dVrh
	 SLA8YSKOMTWy+uaZ720dGTHTni4AiuUp0ARYDQaKNj5J/0SCe5bc9hssgJIc4jbmKK
	 fm2hLaS8dNA/P8/yPiSjNoPYM9AxMQSRhCYzJNunS/z7yAw2pvXHWWI1ooBzBdkFpD
	 E0Lgvn183eLOm0QnkITmWoz13u/ffsr634SP2S9aVOEsosUN91SqOMmImi4P1l0nzm
	 LqyzlzfxWgdRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/18] perf test: Add named_threads workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-9-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-9-85b5ce6f55c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:01:22 +0000
Message-Id: <20260602150122.7F8BB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Signed integer overflow and data races in the test workload loop=
 cause Undefined Behavior (UB), which triggers TSAN/UBSAN failures and allo=
ws the compiler to optimize the loop away.
--

commit 2c5615e29c7533d5597f41700af3d8e8f97a8e97
Author: James Clark <james.clark@linaro.org>

perf test: Add named_threads workload

This commit adds a workload that spawns multiple threads which run a unique
function performing a multiplication loop. Each thread sets its own name,
which is used to test that processor trace decoding handles concurrent
threads correctly.

> diff --git a/tools/perf/tests/workloads/named_threads.c b/tools/perf/test=
s/workloads/named_threads.c
> new file mode 100644
> index 0000000000000..dc8070a98df4c
> --- /dev/null
> +++ b/tools/perf/tests/workloads/named_threads.c

[ ... ]

> +static int iterations =3D 500;
> +int named_threads_work =3D 1234;
> +
> +typedef void *(*thread_fn_t)(void *);
> +
> +#define DEFINE_THREAD(n)						\
> +noinline void *named_threads_thread##n(void *arg __maybe_unused)	\
> +{									\
> +	pthread_setname_np(pthread_self(), "thread" #n);		\
> +	for (int i =3D 0; i < iterations; i++)				\
> +		named_threads_work *=3D 3;				\

[Severity: Medium]
Will this loop trigger undefined behavior due to signed integer overflow and
data races?

Because named_threads_work is a shared global signed integer modified
concurrently without synchronization, this creates a data race.

Furthermore, multiplying 1234 by 3 for 500 iterations will cause a signed
integer overflow after just 14 iterations.

Since both data races and signed integer overflow are undefined behavior,
could the compiler aggressively optimize this loop away entirely, defeating
the purpose of generating trace data for the processor trace test?

Would it be safer to use a thread-local variable or declare it as a
volatile unsigned int, similar to the leafloop workload, to prevent
sanitizer failures and ensure the work is actually simulated?

> +									\
> +	return NULL;							\
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-james-cs-c=
ontext-tracking-fix-v2-0-85b5ce6f55c6@linaro.org?part=3D9
