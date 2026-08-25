Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F681A23A6;
	Tue, 25 Aug 2026 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633992; cv=none; b=oIoms1Xnt9SFCs5iXwKiM9OQEgdLAY8gzfz9xUwNrZqBqaoOxuHArWi9Prlmox8NiITTFQempBeRTZ4/C2ywOs388izZrB6y82IrtV0b2kFcNo4zjLWTxn0pocG9Irp0qQ4BtNI/FABY0wYWpMILXw5yTC+zHZnUazJJbMyRPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633992; c=relaxed/simple;
	bh=io0kW5534eDF+L+RpRgvD2AWXMbPz+j32qnU717fNzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shV5pQWDf5Hn21/Lkl2FOpFDTFsAnnSXZfXW+5wdlDFp6+XlhVzcBrxVUNCoEymicdIox2ocGfiboornYpJORCX5EaCy+9LQBKxWywFJW0RYJP7LDPWMc0ylv781f7mUaqU9uPaq5juU8xT6tro8tgC9nvil7QiOgRFvgdlk2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMqy+EsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMqy+EsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237741F000E9;
	Tue, 25 Aug 2026 04:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787633991;
	bh=lHfDie5F5max9MKzz+gxrCgxFZP2trMABvlkqsnVMnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMqy+EsOSVLu7w1NDIvqmDEXNCbsC9j+LDLRr12dQ2rFTr8PzeW5UB5//M1wqo8ir
	 ytBWqhOhamq2+M/yvdepN1hkSHhv0sDX+nfrOLTp+BCg8bvdo4hYGwq1C5PjsVzt9d
	 HsCp/SgaIqboSuWaDCYgQYsAz2RtiwfZIETIZJbg6Y1vWSheMxbzi36dVJ2uCe/rVH
	 i17JEtXZcFH25Wdq865NwKX6N3sxzt0Nq2a8QrQNk3RDCKMSXr20GKDML4PVYfV2NK
	 H/43i5DjVlM9C4pS76RAkUDAoOH3FnKmmFhQmdiVdGff16fSg2qfYtDjyFIk6UNzKv
	 fZt2QDkVWD4JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/bpf: Fix lockless access to parent_event->prog
 in perf_event_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260825044507.15217-1-kartikey406@gmail.com>
References: <20260825044507.15217-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:59:50 +0000
Message-Id: <20260825045951.237741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing RCU read lock around the lockless read and increment o=
f `parent_event->prog` allows a Use-After-Free.
- [High] The BPF program reference is leaked on error paths of `perf_event_=
alloc()`.
--

--- Patch [1]: [PATCH v2] perf/bpf: Fix lockless access to parent_event->pr=
og in perf_event_alloc() ---
commit 14870f355d1ed182bbc1e31accf43918dde6051a
Author: Deepanshu Kartikey <kartikey406@gmail.com>

perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()

This commit attempts to fix a race condition during fork() where
perf_event_alloc() locklessly reads parent_event->prog. It updates the code
to use READ_ONCE() and bpf_prog_inc_not_zero() to safely increment the
reference count without locks.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..9d456b03c4969 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13465,11 +13465,13 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>  		overflow_handler =3D parent_event->overflow_handler;
>  		context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -		if (parent_event->prog) {
> -			struct bpf_prog *prog =3D parent_event->prog;
> =20
> -			bpf_prog_inc(prog);
> -			event->prog =3D prog;
> +		struct bpf_prog *prog;
> =20
> +		prog =3D READ_ONCE(parent_event->prog);
> +		if (prog) {
> +			prog =3D bpf_prog_inc_not_zero(prog);

[Severity: Critical]
This isn't a bug introduced by this patch, but since it aims to fix a race
here, does this code still leave a use-after-free window?

Because perf_event_alloc() executes in a sleepable context, the RCU grace
period could expire between reading parent_event->prog and calling
bpf_prog_inc_not_zero().

If a concurrent thread detaches the BPF program by closing the bpf_link fd,
it can locklessly release the program before the atomic increment happens.

Should this section be protected by an rcu_read_lock() and rcu_read_unlock()
block to ensure the memory isn't freed before the atomic increment
completes?

> +			if (!IS_ERR(prog))
> +				event->prog =3D prog;

[Severity: High]
This is a pre-existing issue, but does this increment leak the BPF program
reference if perf_event_alloc() fails later on?

If a subsequent initialization step like attach_perf_ctx_data() or
perf_cgroup_connect() fails, perf_event_alloc() returns an error pointer
and triggers the cleanup via __free_event().

Unlike _free_event() which calls perf_event_free_bpf_prog(), the
__free_event() error cleanup path doesn't appear to release the acquired
bpf_prog reference.

Could an unprivileged user systematically exhaust memory by forcing failures
during fork() on an inherited perf event?

>  		}
>  #endif
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825044507.1521=
7-1-kartikey406@gmail.com?part=3D1
