Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622348;
	b=1DLpBDdMxAPkEY/Qw6F4ArckNniuXqrsYhn6BqjoUX4lXx+BjiR7wmDW8oxH6Sx66URM
	 UoVyGkXlP22qzNGifSBFtMvJvGoIc/qOQtaCMJynQlxcdB4+MftjsGyclA/vUcvaSpc18
	 RsluUxZShBJlXfx5FV2X4P0JixG9MCHgVRqZ4q5qWt/jHH+EjS18Ko4g9j6lhtW1Xk2zD
	 TgXZf7ovmAYPgczoZisRj4WPZZu9+lYmiacATqdnlYNcKhNuGAKa8Y/9hQQg6ApDnHLs9
	 Z5ixwtHazl7nGLnkoBcq2iWaABrXBVx83X1BA8YAQufcmi/tbj7srDFDKw2F0yYDqTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622348;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zMV9OqC7Udh5F4G0LrgBbM4X321LnW7hY4/YU5gDxxU=;
	b=Q4yTc+Tbc0HKuLkABrgFb7hGHRG8u4DwcnidWx5H5jMbPgO81X82ebD/xc4bEGV7RlhR
	 l25FYfmN28Mfr5PSzypNPNa0Sry0tWTo8oKdqvn+wcBSCZ+Jz8BOLda37vJg5uAvUotqp
	 LGOBxbVHxBsVlPDDSaTG+SAUXZJd5mFumpKReFg7r8Kg706oqnGxOR2d2ljNtpFqFttz0
	 slaGykbsgdB7tpkDuEn6PSIJPwIoTdXvu6S1eKQRqlquBHMNfx0NaZ8EMMMsjG7EK8gF7
	 FyAn/mxbaUkYRu1FDZjVeiI3bqkmfmAGQpTANQtZivdcdPYMoQ/s/+8N4Z34cZaqDEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAsdEkCB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DDB606A31F
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAsdEkCB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE071F000C2;
	Wed, 21 Oct 2026 22:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622348;
	bh=zMV9OqC7Udh5F4G0LrgBbM4X321LnW7hY4/YU5gDxxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gAsdEkCBBCN/d2Z0vr3qWcMqRuuGnN0S9rBa+qtamF9HJYd0owu5sV+F1S1jRY4N0
	 L/Rt9ZE1yRogLiQyd4vyYZITy7jsqikgAx3SgXTde9scju/iHCO73f7S6oPR6fpcWp
	 IGwV/uOh+rIgkviZwoRB2tylIQykFney+WHPEN5ZsEwisH11nafD3B3tDc5hNsF8BH
	 TJq9Sz1EIlS1rY6jfXqCItzpBw52OEtk7kea+S8546ymCmlp1u+ln7fV7U8ciaKVUD
	 6E+rAUyXmUcKbj3smwV2oH9lQ0HjpWE3yHe96JOjbm+YB1t9CSG1ngNFquk/B0fj5n
	 SQzz8L06+k/hQ==
Message-ID: <sashiko-outbox-180726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] tools headers: Sync UAPI sound/asound.h with
 kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-12-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:39:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> To pick up the changes in:
>=20
>   91415225fbfb ("ALSA: uapi: Drop __bitwise and __force prefix")
>   86cac980c966 ("ALSA: control: add ioctl to retrieve full card component=
s")
>=20
> That introduce these new entries in the string tables:
>=20
>   $ tools/perf/trace/beauty/sndrv_ctl_ioctl.sh tools/perf/trace/beauty/in=
clude/uapi/sound/ > before.txt
>   $ cp include/uapi/sound/asound.h tools/perf/trace/beauty/include/uapi/s=
ound/asound.h
>   $ tools/perf/trace/beauty/sndrv_ctl_ioctl.sh tools/perf/trace/beauty/in=
clude/uapi/sound/ > after.txt
>   $ diff -u before.txt after.txt
>=20
>   @@ -1,6 +1,7 @@
> [ ... ]
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D11

