Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446DF389116
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127949; cv=none; b=WPF58egD9OPZb+noWicVZe9gdJ7FEASKmMPrTikmeyiQ4Wol1u5jYojQB++7zOj4BzEotnXFexT/Bon9g+TKE0PtK82xqidyK/obTBkTwRGE7CggRc1UsTRSBHsJ5EKy4S2eX/gxY+ULz8ZxDidjfACdOe2ZRibpDPSCG0DMou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127949; c=relaxed/simple;
	bh=c0dHe3Qs/WPAmWNZhzClNn4ChVpbW0EpjMLpgY0TyFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dn6/ZahPUMcgM4uL3uv056c6HXm3+78eKg+eETsVyzBaRQw++OeetEFZNN0Oa3AVj9s7l3CSu7zmm+VHbHFjWBfZqGfaoQVn6N8dDxeL6esQuhQGZYjTvUeG0X69p/xc4k6vzKWek9+TCv8jfpw1u4+CtNZBBuedDc5jsR5BVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArHSD9wx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArHSD9wx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB80CC2BCC6;
	Mon, 18 May 2026 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779127948;
	bh=c0dHe3Qs/WPAmWNZhzClNn4ChVpbW0EpjMLpgY0TyFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ArHSD9wxM7+DMJYYjPQEDuxic11lXLPLoLbGhNSy+U2v08kPkvBClU8awHwYiIyC1
	 y+U7k6M5uYB+P6L0GLNnopCqgMPA4pHB99Uec8skbaCLLjBg/6/SBvTJR+9JDcVvaq
	 4Cgn4rSV4Xo6lyamf1p2GoIcbhWgsWPnB6KpvFCfVC+zxwloHBhaGJTdQBlj4j5siB
	 9ZFj2sZFiYKIB9VQE/WFDZRRPqtpxr2YbM5/pHI8qoPPczKjMgwxpqzd8cILDjrBV0
	 drEjs0OQ7sr7htnqyjv7K7ZMH2upWWBMFlJq+hT7gJb0r9EYDuurtwRMpzq3IWGIF6
	 ef8hRBJH+6NaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] perf: Reveal PMU type in fdinfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518174159.1177549-1-ctshao@google.com>
References: <20260518174159.1177549-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 18:12:28 +0000
Message-Id: <20260518181228.BB80CC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `perf_show_fdinfo` function omits the `config4` field from t=
he `perf_event_attr` struct.
- [Medium] Lockless read of `event->attr` fields can lead to data tearing a=
nd inconsistent output.
--

commit ec3f500bd8b814c602df062a02b83af7397b6b5d
Author: Chun-Tse Shao <ctshao@google.com>

perf: Reveal PMU type in fdinfo

This commit adds fdinfo output to reveal the PMU configuration for a proces=
s.
It exposes perf_event_attr fields such as type, config, config1, config2,
and config3 through the /proc/*/fdinfo/ interface.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c5..d88947e9f7740 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -7506,6 +7507,20 @@ static int perf_fasync(int fd, struct file *filp, =
int on)
>  	return 0;
>  }
> =20
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

Can these fields be read safely without locking or READ_ONCE()?

Since event->attr.config1 (which aliases bp_addr) and event->attr.config2
(which aliases bp_len) can be concurrently modified via the
PERF_EVENT_IOC_MODIFY_ATTRIBUTES ioctl, there could be data tearing on
32-bit architectures if they are updated locklessly with respect to VFS
readers.

> +	seq_printf(m, "perf_event_attr.config3:\t0x%llx\n",
> +		   (unsigned long long)event->attr.config3);

Does this code need to print config4 as well?

The perf_event_attr struct has been extended to include config4.

By omitting it from the fdinfo output, we might be missing information for
users relying on this interface for events and PMUs that utilize this newer
attribute field.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518174159.1177=
549-1-ctshao@google.com?part=3D1
