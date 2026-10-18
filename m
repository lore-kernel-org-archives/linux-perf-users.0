Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F4277026
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302654; cv=none; b=RQsODoHdYHGLmrtcRKBgjyNwKGa0LviGq9nebYkTofc3TD26htbhvFlKGhnp5s2A9X7FuDBFPQaGQ5kH45oZI6O0c3WvDqOJhAFb3ywXVZ1OO3BYlzJeKnxWoegCakKtrWzoLuTXSbkwJL9GMKIPMut9QeVzr12Ap76DI9Wdaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302654; c=relaxed/simple;
	bh=UxVsrwKjiCWtj3vlfyP4GlNw+uGuIdWioIFd1Nhvpb0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DJuHLgPOLB7X8EGPdLNcrYl6gCt3efhOF88ED4X2eVjzbW2YVjqfA02XARisTPRaT54SFHognexpBzSYfcYvV1IbCwsULxcEJwGWY1XDOJ/huXt1Xo+2NVAmnJytiSTl65WMF5YZLtq2MTlq0S+k5WvnbSD2+jvxM4rbF2utnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKiwA9Mf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKiwA9Mf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAA21F000C4;
	Sun, 18 Oct 2026 05:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792302652;
	bh=M7SQxm2Eo0PqD50qzb8EbQaHG3D00K113WIRBjWvEYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nKiwA9MfXuI3zg8BBUYt7jFZEufxsY9M9A3bRNepmcw8afe++kpcPJfWcwoh76o3W
	 nZqo9LbmqBiiQwMyGS4FCaFZCcSfiBi0JLP+dBpIAuDFRQnwYTDhHyxprXaL+VDSgg
	 Ed214VkqEEo4pWAkTWanyIdNyKFZ8/ft9IMoSd4TvdWhGtjejMQSDDTZnNniP9++SU
	 WfoVX2iXUxzHeLroI4pG8bMeiZFhmJ4Jl1jn6BBZhjU1AcpNfgj98ErZxwlZOfd6DJ
	 xQnRCy5y1/Kdi/nJoL5yjZFwJqkMb2lR5c4bACC5bmFU0nE6FMBmRV93qh1iYPRSZl
	 Axawd3bEczssA==
Message-ID: <sashiko-outbox-175957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] perf lock contention: Share common BPF and lock
 type definitions in lock_data.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018053710.2572636-2-irogers@google.com>
References: <20261017171437.2066343-1-irogers@google.com>
 <20261018053710.2572636-1-irogers@google.com>
 <20261018053710.2572636-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 05:50:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf lock: missing CO-RE flavor struct for mutex in get_lock_owner()
--

commit 93be88d7858bcce932211b385210b6872f154e7a
Author: Ian Rogers <irogers@google.com>

perf lock contention: Share common BPF and lock type definitions in lock_da=
ta.h

This commit moves lock_type_table, LCB_F_* flags, common BPF lock helpers,
and shared CO-RE structs into tools/perf/util/bpf_skel/lock_data.h so they
can be reused by BPF sample filtering. It also extends get_lock_owner() to
support rt_mutex and check the mutex handoff flag.

> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_s=
kel/lock_data.h
> index 652e114e6b877..8cf24f07204c5 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h

[ ... ]

> +static __always_inline struct task_struct *get_lock_owner(__u64 lock, __=
u32 flags)
> +{
> +	struct task_struct *task;
> +	__u64 owner =3D 0;
> +
> +	if (flags & LCB_F_MUTEX) {
> +		struct mutex *mutex =3D (void *)lock;
> +
> +		if (bpf_core_field_exists(mutex->owner.counter)) {
> +			owner =3D BPF_CORE_READ(mutex, owner.counter);
> +			if (owner & 0x4UL)
> +				return NULL;
> +		} else if (bpf_core_type_exists(struct rt_mutex_base)) {
> +			struct rt_mutex_base *rtm =3D (void *)lock;
> +
> +			owner =3D (__u64)BPF_CORE_READ(rtm, owner);
> +			return (void *)(owner & ~1UL);
> +		}

[Severity: Low]
When building perf with GEN_VMLINUX_H=3D1 against a CONFIG_PREEMPT_RT=3Dy
kernel, vmlinux.h is generated from the kernel BTF where struct mutex is
defined as:

include/linux/mutex_types.h:
context_lock_struct(mutex) {
	struct rt_mutex_base	rtmutex;
#ifdef CONFIG_DEBUG_LOCK_ALLOC
	struct lockdep_map	dep_map;
#endif
};

Because struct mutex has no owner member in that configuration, and
bpf_core_field_exists(mutex->owner.counter) and BPF_CORE_READ(mutex,
owner.counter) expand to C member accesses on struct mutex, will this fail
to compile?

Should this use a CO-RE flavor struct (similar to struct rw_semaphore___new
and struct mm_struct___new above) to access owner.counter?

[ ... ]

>
>
>
>

[]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018053710.2572=
636-1-irogers@google.com?part=3D1
