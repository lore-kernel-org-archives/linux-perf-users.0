Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C84A35
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000714; cv=none; b=ULI39nwKvgvGW7pna/YWDh+ghJrlNaHVP7pEj21JXuS5vP3oIQBvzVZghW/6Cm536GrsaDZ4GfkcqsXU3Zi67CsRSlngepqdAcgY27x90dL8Mhlj7jyM+66QASHZ17QoE4rjSyosWuZFO8qiIl7C5Erp+ufjfvGaBUA3tuitxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000714; c=relaxed/simple;
	bh=PiCql3NbdJZW6sWA0EMX/twKYJLkp1ditq7MB+ysCuc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=J2llO6piaOnFZxaZqx2IjwuoKFL4A/SjHEvIT787zN2mNjntHOFSPnqmKl2k3348T5cTfcQRi8ZYNIEi+efoFTB5npoSiK1io1d+JllAh4r+xnurEBXZq/fzYgW3brwbGXgz2BBSGvaxwNpzt0L8DrSSGcHzQmaLQR4vcPjtUUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3Rghub6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3Rghub6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EC11F000C4;
	Wed, 14 Oct 2026 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792000711;
	bh=WimBkJQ9hHcM+9p13t+qOUMOakUihAt3qznpF4GXOXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3Rghub6ZdATgOnECN+9J+OQ50HwMdv/Nt2hZymgokygMGd2zZtfzG9mPeh/SuHn9
	 h0AEZk8SwIFYIvvE/hrv5bbed0Drk4ApGp8n+YxycRatxrAnYs7I3vpi1QiuvFm34j
	 V59pxX5BcrKeYhUjc81eS3f4dsk5OHAANvD3nj81eap6BIWES6n6s2Ubgy8mKgroY9
	 i5D32oscmmLOCn8eLN3e2O9qciJedal9zAGFczfjc60gdq9AkfRtlaNj97AnR4m0rt
	 43+qfEGLMXM8EpNYszVFLsHMUPNjYm+g5Hb899MzgQxQFAocUS/dOCl2Yt2GRUtzXL
	 d2cVHSq9mIhsQ==
Message-ID: <sashiko-outbox-171638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf: support zstd-compressed kernel modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ivan Shapovalov" <intelfx@intelfx.name>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014-perf-zstd-v1-4-9652727886fa@intelfx.name>
References: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
 <20261014-perf-zstd-v1-4-9652727886fa@intelfx.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:58:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: Incorrect pointer arithmetic breaks gzip/xz module detection
--

commit db2ed0262b65a0b2dfef65f9c73099d856ec9244
Author: Ivan Shapovalov <intelfx@intelfx.name>

perf: support zstd-compressed kernel modules

This commit adds support for handling zstd-compressed DSOs in perf. It allo=
ws
perf to load zstd-compressed kernel modules by identifying the .zst extensi=
on.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 42bfe30a3b518..0e8886172e239 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
[ ... ]
> @@ -460,7 +463,7 @@ int __kmod_path__parse(struct kmod_path *m, const cha=
r *path,
> =20
>  	m->comp =3D is_supported_compression(ext + 1);
>  	if (m->comp > COMP_ID__NONE)
> -		ext -=3D 3;
> +		ext -=3D strlen(compressions[m->comp].fmt);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this pointer arithmetic break the detection of gzip and xz compressed
modules?

When parsing a compressed module path like foo.ko.gz, ext initially points
to the last dot (for example, the dot before gz).

To check for the .ko extension, the code must shift the pointer backward by
3 bytes to point to the dot in .ko. The original code subtracted 3 because
the string .ko is exactly 3 bytes long.

By subtracting the length of the compression format string instead, this
now subtracts 2 for gz and xz formats. This shifts the pointer to the
character o in .ko rather than the dot.

The subsequent check in __kmod_path__parse():

	if (ext > name)
		m->kmod =3D !strncmp(ext, ".ko", 3);

will then compare o.g or o.x to .ko, which fails. This causes perf to
silently ignore .ko.gz and .ko.xz files and incorrectly flag them as not
being kernel modules.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-perf-zstd-=
v1-0-9652727886fa@intelfx.name?part=3D4
