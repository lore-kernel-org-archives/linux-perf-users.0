Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1C1E7C12
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829930; cv=none; b=p50/2KGoxuUv/og9BF8OyyS/rNwFVVdvZKPO1LbTCACl0Qaw0AY8G78D/T7sqPjy6yD/RmsX+tBz1zy5WNVbpg6xS4HNpvIGVk2aD6LB8nN43naI56Hqk0inDtSenxtms0khEmbsr7L94wUYfkqLGerg0MpN+wgpYxbHYcLCw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829930; c=relaxed/simple;
	bh=xP7LWYHRW6rLzL1ou1Y6tnrQ+8wXQU8/Uv+miCJYX/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IYGxqasqgWT56yxA5HA0kNGQo1XE0KhGH1gymz6emSJh02XB7zV2o04oiLvs4CUnHfKGtbz2UBn3I/Ke+Qea8NkJFNU0SWNnUo/t5YsQAQj+o2ey1mXN+JQiLat//WjltQp1ghDfTeUe7xbB34AMv1ZDulxOHLLtK/af2mCKXNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyZm70ep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyZm70ep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F754C19421;
	Fri, 10 Apr 2026 14:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775829930;
	bh=xP7LWYHRW6rLzL1ou1Y6tnrQ+8wXQU8/Uv+miCJYX/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nyZm70epjm5qOzrEqs2qZsrB4+lx6Ki7Ktkato7E3mZMCI7Q4HjWwxCzSX+OZb7lC
	 z2AauSigPv7kF660rxZ+o2kzFQ231zXS8iWztmdHEOkdqr7Hcy+CIATBYBfIlGkv4q
	 x+dXfFJD0b4UdNz5lZTGJl9UYDnn61mUBUFNf2uZqUQOZWtE1mceGLJjvx1KDclRvZ
	 DkyS+DHHGoVID7e3nKvxHfZvH4DrdzGItaL95sMsqvDWhYNboqDe2K55XHDpTh4XaM
	 plJzxkQKwhrQKUKVMOz4rme+rV9lFkOpFXafoBv93a89yeWqQWx43VBg7a0zjg4SJe
	 C+yVq9r1bZdiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf: enable unprivileged syscall tracing with perf
 trace
Reply-To: sashiko@lists.linux.dev
To: "Anubhav Shelat" <ashelat@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410133529.21947-1-ashelat@redhat.com>
References: <20260410133529.21947-1-ashelat@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 14:05:29 +0000
Message-Id: <20260410140530.4F754C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The kaddr_leak mask in perf_event_open() fails to block PERF_SAMPL=
E_IP and PERF_SAMPLE_REGS_INTR, allowing unprivileged users to bypass KASLR=
 and leak kernel register state.
--

commit d9060ee10098244bcdd4bf26d128fe8ae6f9f578
Author: Anubhav Shelat <ashelat@redhat.com>

perf: enable unprivileged syscall tracing with perf trace

This patch allows unprivileged users to trace their own processes' syscalls
using perf trace by relaxing the perf_allow_kernel() check for task-attached
tracepoint events. It attempts to prevent KASLR bypasses by blocking sample
types that expose kernel addresses.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c5..07d67d95af96f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13833,9 +13833,25 @@ SYSCALL_DEFINE5(perf_event_open,
>  		return err;
> =20
>  	if (!attr.exclude_kernel) {
> -		err =3D perf_allow_kernel();
> -		if (err)
> -			return err;
> +		bool tp_bypass =3D false;
> +
> +		if (attr.type =3D=3D PERF_TYPE_TRACEPOINT && pid !=3D -1) {
> +			/*
> +			 * Block sample types that expose kernel addresses to
> +			 * prevent KASLR bypass
> +			 */
> +			u64 kaddr_leak =3D PERF_SAMPLE_CALLCHAIN |
> +					 PERF_SAMPLE_BRANCH_STACK |
> +					 PERF_SAMPLE_ADDR;

Does this kaddr_leak mask need to include PERF_SAMPLE_IP and
PERF_SAMPLE_REGS_INTR?

If an unprivileged user requests a task-attached tracepoint event with
exclude_kernel=3D0 and specifies PERF_SAMPLE_IP or PERF_SAMPLE_REGS_INTR,
tp_bypass will evaluate to true and the perf_allow_kernel() check will be
skipped.

When the tracepoint fires in kernel mode, won't the user receive samples
containing the kernel instruction pointer and full CPU register state,
allowing a KASLR bypass?

> +
> +			tp_bypass =3D !(attr.sample_type & kaddr_leak);
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410133529.2194=
7-1-ashelat@redhat.com?part=3D1
