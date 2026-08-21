Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3313B71D2
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306638; cv=none; b=RPtGOV5ywCASF0mgmGTFlDxIAC6rDliQi6NTRpE7cCGHclLqcarkwFPtj4G2D8UqoxayC3eqRBuhGhuXuYlMTXJH4WDAxd8y7p5lOVXseyuxmJzxdQraBqJt88xI4wPxVcbS45I+9itglV8whxYlmloh7fZfmGmosNNbLUv/ADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306638; c=relaxed/simple;
	bh=DptXHC0SOhG0sKiuHi3Ur+78kIAAvL9NsmJ8hRY4s60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eFeBqzG7mipf0gjmBBtC5NbcqtY5FNA/waiPagILWi/ArPmlXDIjPkHRVNwwAX4YnVV+L7BaHlAlgx/n309rYalGD7+MkXyCHpkJwofX/CWEOKa3TmGAHBzMfjPfWFt+EQyESaiNWxO+y3Pd1npi/i1BQot+CJ1Nsf/GKOSes2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxmza5io; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxmza5io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42DC1F00A3A;
	Fri, 21 Aug 2026 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306623;
	bh=w8PWYeE6LSmutXq56y0NI+Hwm1pLyfrWChZNZrIyurM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gxmza5ioIo/muGBBH+xkTW34S+NgxNXVT/MYoxheO7b/J5j/gjncuqMqYamq+fE1o
	 64cvfKsszsZRHOB3vVW/mjHWIt+KvfG3IsDZteSgPN9wvStYLfd0HMGYlTJlnj+vSQ
	 GJQuF0wxYvEA7MRAnItX4qvd7axbTIagOg0Ddg9q28rGtrdWoQTSbWBzhhR9iGGGNh
	 qtX5v/0vNtNuvCcJIi2B8m2UXgzrSyMDqIkSWQzmWvkakGqMyDcgWwhhg2jLNSRSCl
	 Pg5vzxe0iq7AxE+zaTBRu9NOyDpJS4R0JJc5r2N9AMHQKfEXhfWD6XcYp1phXVi6WX
	 ZHguYt96AoL0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/14] perf test: Allow infinite named_thread loops
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-12-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-12-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:03:43 +0000
Message-Id: <20260821100343.C42DC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The intentional infinite loop in test threads can be optimized a=
way by the compiler, violating the requirement that they run forever.
--

--- Patch [12]: [PATCH v2 12/14] perf test: Allow infinite named_thread loo=
ps ---
commit 53c8a5e547e7365781e369ccbc9c9f225381027d
Author: James Clark <james.clark@linaro.org>

perf test: Allow infinite named_thread loops

This commit modifies the named_threads workload in perf tests to run
infinitely when 0 is passed for the loop count. It also converts the loop
counter and work variable to unsigned integers to prevent undefined behavior
from signed overflow.

> diff --git a/tools/perf/tests/workloads/named_threads.c b/tools/perf/test=
s/workloads/named_threads.c
> index d051d41a3cfe4..6672c2f776840 100644
> --- a/tools/perf/tests/workloads/named_threads.c
> +++ b/tools/perf/tests/workloads/named_threads.c
[ ... ]
> @@ -19,7 +19,8 @@ typedef void *(*thread_fn_t)(void *);
>  noinline void *named_threads_thread##n(void *arg __maybe_unused)	\
>  {									\
>  	pthread_setname_np(pthread_self(), "thread" #n);		\
> -	for (int i =3D 0; i < iterations; i++)				\
> +	for (unsigned int i =3D 0;					\
> +	     i < (unsigned int) iterations || iterations =3D=3D 0; i++)	\
>  		named_threads_work +=3D 3;				\

[Severity: Medium]
Will this loop in DEFINE_THREAD() be optimized away by the compiler when
iterations =3D=3D 0?

Because named_threads_work is not volatile and the loop lacks a compiler ba=
rrier
or cpu_relax(), the compiler might assume the loop terminates and eliminate=
 it
entirely.

Could this cause the test threads to exit immediately instead of generating
continuous CPU cycles as intended?

>  									\
>  	return NULL;							\
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D12
