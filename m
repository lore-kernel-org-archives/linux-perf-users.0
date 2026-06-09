Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7C35AC31
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016658; cv=none; b=lUNNkWRU8beij/ZpH+5KWyuAmuCG/1lzNClyw04OhDbYd15txVJB4aU9s6ImR1v2lVn4Egroth4PfyDK554xsyGeOGnxYS851gqODi+XW1rjYlDeKOBfafGTIdMbSG9vvPbCEnEcPWmEJaoUPXpey6rjLkyFb9qJtZj/kQ77jaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016658; c=relaxed/simple;
	bh=ZzWoPCBiF1fAukx6i/iqlrbu9WETfegH6TN7T3HfQVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kga3MwtYcDGjeaMZZOzkF4v7S3wAWPODsZG83FQKZZ3xcfNEvppWl7JoNkarHEYXJ2nCt9NGXjTg1sUsEUmJz8IPEe0TTkuM7rQgRrXTlnOaXziOWvkHSft/Zsue5zZHerJB7mZ+cfHYzlXotuO1hOg3Q8pMrsf+Iz5lxy1P4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXrxE9Ez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXrxE9Ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276961F00893;
	Tue,  9 Jun 2026 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016647;
	bh=QZaTM4DDkeuAoh+arh+QkobKDqi0dCt3AiR+Nrh/BlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VXrxE9Ez0GzgnMQ6EGibyL4dIzZ/kmrgadAKBrCc1s6Fa9DKYGKhg4kuUL74DFyoa
	 mipYeJd1U7o79rHjUhp4O9ugIWjImRIecXJ9FsyBYggREQH+B1x9MyKxVMbEevBo0V
	 huncFgj04FSnwdMR7V/0aLa0MJ4vcgxeFlGF+23Psn1Fxk1jGpqrJDZRY2UcilCW7i
	 pOteC1aJr1Y+nRULiIveICf8iF4RrPteJkgX/gHaPIfLYGnbiGnn5TeeHLlMaYoeCy
	 qCidmDZ1GWjKh+bPPOlREW6mGCcrNSNRaVCFCH6pJ/MZqsWmYQiAxmHA1tQA95ukIt
	 idRw3J12toUaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/19] perf test: Add named_threads workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-9-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-9-44f9fb9e5c42@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:50:46 +0000
Message-Id: <20260609145047.276961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The thread work loop is completely optimized away by the compile=
r, introduces a C11 data race on a shared global variable, and performs add=
ition instead of the documented multiplication.
--

commit af99f4d30611866956b89fbc6d9ae547214d6310
Author: James Clark <james.clark@linaro.org>

perf test: Add named_threads workload

This commit adds a new named_threads test workload to perf, intended to spa=
wn
multiple concurrent threads to verify processor trace decoding handles them
properly.

>     Add a workload that runs X threads that run a unique function named
>     "named_threads_thread[x]" which performs a multiplication in a loop f=
or
>     Y loops. Each thread sets its name to "thread[x]".

[Severity: Medium]
The commit message states the workload performs a multiplication in a loop,
but the code performs an addition. Should the implementation be updated to
match the description?

> diff --git a/tools/perf/tests/workloads/named_threads.c b/tools/perf/test=
s/workloads/named_threads.c
> new file mode 100644
> index 0000000000000..d051d41a3cfe4
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
> +		named_threads_work +=3D 3;				\
> +									\
> +	return NULL;							\
> +}

[Severity: Medium]
Does updating the shared global named_threads_work concurrently across
multiple threads without atomics or locks cause an unintended data race?

Additionally, because this loop lacks memory barriers or volatile qualifier=
s,
will the compiler optimize it away under -O3 compilation?=20

If it gets optimized into a single operation, the threads might exit almost
instantaneously, preventing the workload from generating the overlapping
processor trace samples it was designed to test.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v4-0-44f9fb9e5c42@linaro.org?part=3D9
