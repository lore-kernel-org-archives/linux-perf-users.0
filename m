Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E919E819
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145912; cv=none; b=mvhP3CWFz3ToQhbYrxp7d8dkj/4kVYB7fvWCVgzFuSBMbZQFU2dkydV5R3PYaZIX0LSwzLK21NGrDB1+dNS1MsRzb+a2M90xOCLRFj9U8ExVt1543WHc4rLFVQy9WXbdRzH1+nhsrckRmDYIIsLeEr5cfmCUTsrJyzXvBJnVTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145912; c=relaxed/simple;
	bh=HKq39yjj/1hGpebFgKppxF1Ayyyj/0R11+aZsPzuKWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j+2dAUAO5gRBRC4q2zX1VcU57l1iieSQwVEAoMYTbY6zlBn3KZAt8fc5KV+KFTLhnplfyMzxS2FGJrMwRVRvyczC9EC/G/Was6474GQs3E1Cd2D0ToLNuzpeUBEQPe7lN5odFK2nZuUHdZe4n/kfsSoMH4fXQoZ3b1Y19GpRauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2QakQE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2QakQE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AA8C2BCB7;
	Mon, 18 May 2026 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779145911;
	bh=HKq39yjj/1hGpebFgKppxF1Ayyyj/0R11+aZsPzuKWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=a2QakQE3cP1JFv4Juuo1ngb97DhbIpNlATNqmKTDb9L347NPufdEGo4W8eu+EkOj0
	 Mi2V+EL2Q9xvWIqGYK4rIP6XAnAdei2WXufX1WHFMSkpzH9d8NygPM3OJ0Z2hxbx6r
	 o6OsMqa/z45uhL3NU7ITyNkQDrd0EvE+l+6Co0dLQ9iltLQncVnvvry8iVl5PCG8XY
	 h76fiCS8wvmwha0Rw5ojv7yqE4b6g31S2ksI7ZZyY8kFYn58GvmGW0KfK/VC8nj47P
	 5C3HgLSNuH9A4COfSiVcw+qjWIxC2zcgox8rW5wtOIGulDuHh4IzZ+XJ+UGMq3bKDn
	 M73OKyxeiBGIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] perf: Reveal PMU type in fdinfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518224819.1247382-1-ctshao@google.com>
References: <20260518224819.1247382-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 23:11:50 +0000
Message-Id: <20260518231151.50AA8C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Printing `orig_type` in `fdinfo` fails to reveal the actual rese=
rved PMU for generic event types, contrary to the commit message.
- [Medium] Data race and potential torn reads on `event->attr.config1` and =
`event->attr.config2` in `perf_show_fdinfo`.
- [Low] The `perf_event_attr` configuration dump in `fdinfo` is incomplete =
because it omits `config4`.
--

commit 2d51cc413225501aabea03532725af0cfbaf6950
Author: Chun-Tse Shao <ctshao@google.com>

perf: Reveal PMU type in fdinfo

This commit adds a show_fdinfo handler for perf event file descriptors.
It exposes the original perf event type and configuration values to
userspace via the fdinfo interface.

> It gives useful info on knowing which PMUs are reserved by this process.

Does printing the orig_type actually reveal which hardware PMU is reserved?

For generic events like PERF_TYPE_HARDWARE (0), orig_type will just be 0.
On heterogeneous systems with multiple PMUs, like hybrid architectures,
printing the requested type doesn't seem to reveal which specific physical
PMU was actually allocated by the kernel.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -7506,6 +7507,20 @@ static int perf_fasync(int fd, struct file *filp, =
int on)
> +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +	struct perf_event *event =3D f->private_data;
> +
> +	seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
> +	seq_printf(m, "perf_event_attr.config:\t0x%llx\n", (unsigned long long)=
event->attr.config);
> +	seq_printf(m, "perf_event_attr.config1:\t0x%llx\n",
> +		   (unsigned long long)event->attr.config1);
> +	seq_printf(m, "perf_event_attr.config2:\t0x%llx\n",
> +		   (unsigned long long)event->attr.config2);

Can reading event->attr.config1 and config2 locklessly lead to torn reads
on 32-bit architectures?

These fields share a union with bp_addr and bp_len, which can be modified
concurrently by ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) via
perf_event_modify_breakpoint().

Because the fdinfo read path does not acquire the perf_event_ctx_lock used
during modification, could concurrent execution cause split 64-bit values to
be printed?

> +	seq_printf(m, "perf_event_attr.config3:\t0x%llx\n",
> +		   (unsigned long long)event->attr.config3);

Is it intentional to omit config4 here?

The perf_event_attr structure includes config4, so skipping it results in
an incomplete dump of the event configuration.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518224819.1247=
382-1-ctshao@google.com?part=3D1
