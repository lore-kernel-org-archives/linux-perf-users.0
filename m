Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072ED370AFC
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482384; cv=none; b=c2xBYCXigIFMoNW6juWzB6hGQHshQotmG3Y4hqxL+QupIcLltZfucTqIFvluy1sM4n92t6gKEAO46YGpUYt74nws9KX3trvrJS+5MQBx5PLbf4O3mj2KRuEmB7tbT4C46nwEd0HgsVUMn6ML2OWSbPHZP/uY3kA4d+JDksFz64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482384; c=relaxed/simple;
	bh=QHK8QFNl9sNwvvjGjSxSZLprFEpue6WHlN7Rqg8+zC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d/k8z/nwXkwEpR/A7zopdNpdDQy7He91gREI7aBptJ+axJGYtuBe88uv6vEzxDOx1PMv4wmr/a+P5cHYp+yzDqnpGjdXZ+g00u6STGrce2J/wXV0BuVJ/SSSO0TFLTLSovotxLwJ8QNbe6M1TuYcXSl6wTBkv7176gNsExpsVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jcl46tin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jcl46tin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A04D1F00893;
	Wed,  3 Jun 2026 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482382;
	bh=DbIL3oW6hVQ7hZXaRdPe3rCHquucCRHMxryN750G4SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jcl46tinYJUkbFH/X2KAEZ5aHxgEGGCn6vxrezbW5hXkLSqxCUA8V7qlr53J5+kb2
	 NekZ8ZfaLDREQG9NlvnEDio7Iz4MSdKR8FwZI0Q0rJ5VDown+cJvlq3MGAO1/L0IMW
	 UohbV7aHDAh3yH8zRWls5fOs4ys+dGyTOaVcY83xXApSi9VebGTb/Ub2LZDhPN6E8v
	 R4cIy4fi54RwgVpoHm6Il/vR2wRmZAK1128c5LLDQWVl7Hg4OAXwSru3B4jD9t6W5V
	 uZOgUWy2twefHeVc5vcpwJj6dOveqt5Yb87EfNRk9HlsiYqbJlJbFs75brIdOfn9Bc
	 h7dX5XWEFxaTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/19] perf test: Add named_threads workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-9-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-9-c392945d9ed5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:26:22 +0000
Message-Id: <20260603102622.8A04D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Data race and signed integer overflow on the global `named_threa=
ds_work` variable leading to Undefined Behavior.
- [Medium] Lack of synchronization barriers guarantees sequential execution=
 instead of concurrent thread execution.
- [Medium] Background threads are leaked on the `pthread_create` error path.
--

commit d8bc49305dcacce453a6a52dcb27371073bfc5b0
Author: James Clark <james.clark@linaro.org>

perf test: Add named_threads workload

Add a workload that runs X threads executing a unique function to perform
multiplication in a loop. This is intended to test that processor trace
decoding handles concurrent threads correctly.

> diff --git a/tools/perf/tests/workloads/named_threads.c b/tools/perf/test=
s/workloads/named_threads.c
> new file mode 100644
> index 0000000000000..dc8070a98df4c
> --- /dev/null
> +++ b/tools/perf/tests/workloads/named_threads.c
> @@ -0,0 +1,109 @@
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
Does this loop trigger undefined behavior due to data races and signed
integer overflow?=20

Multiple threads concurrently modify the global named_threads_work without=
=20
synchronization. Additionally, multiplying 1234 by 3 for 500 iterations=20
will overflow the signed integer.=20

Could modern C compilers optimize this loop out entirely due to the UB,=20
preventing the generation of the processor trace samples this test relies=20
on?

> +									\
> +	return NULL;							\
> +}
[ ... ]
> +static int named_threads(int argc, const char **argv)
> +{
[ ... ]
> +	for (int i =3D 0; i < nr_threads; i++) {
> +		int ret;
> +
> +		ret =3D pthread_create(&threads[i], NULL, thread_fns[i], NULL);

[Severity: Medium]
Will these threads actually run concurrently as intended?

The overhead of pthread_create is typically longer than the time it takes
for the thread to execute its workload, especially since the loop only=20
executes 500 simple multiplications.=20

Without a synchronization barrier (like pthread_barrier_wait), earlier=20
threads might complete their loops and exit before the main thread finishes=
=20
spawning the remaining threads, resulting in sequential execution rather=20
than overlapping concurrent tasks.

> +		if (ret) {
> +			fprintf(stderr, "Error: failed to create thread%d: %s\n",
> +				i + 1, strerror(ret));
> +			return 1;

[Severity: Medium]
Does this error path leak previously created background threads?

If pthread_create fails for any thread index greater than 0, the function
returns 1 immediately. It doesn't join the successfully created threads from
earlier iterations.=20

If perf test is run in non-forking mode (e.g., with --dont-fork), these=20
leaked background threads could persist and interfere with subsequent tests.

> +		}
> +	}
> +
> +	for (int i =3D 0; i < nr_threads; i++)
> +		pthread_join(threads[i], NULL);
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-james-cs-c=
ontext-tracking-fix-v3-0-c392945d9ed5@linaro.org?part=3D9
