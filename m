Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693714;
	b=F2tq7CHvJ8cJovOItcxDDBH3f4VerIuwclcHVSZ6wCLpMakHjNyO4y6HXjx35SPkhvaK
	 ROc7raqThljHTjHQN2xhsPuwC/1Jc3v+lXFPA4jlUGapU8nTPkmEZLoJNfHcSSV1MA99w
	 Mf9njvCUN8+GQbazfn8ryusFdCXfLPpqphIlD+Sfztu2mSF4v3NdJL4n4jZsIVJ+GCEro
	 Us9V3xh/aqvTD0TZXgPI4h/wn0lZ/i6ZTagozbPpnQX9bWhFJ8pDxA7k/EuOR4rSjl1qw
	 mvYk5DKhAHZC2+KI9y8G2Uk38FjdThWzGo1wF+/JeTNtNZGG5mKpw5oDBQzdhmQsOaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693714;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dsfQXIFPZ0qwWZFRjxiMDjfIuZoo/qr+h4rVbZQVMpM=;
	b=t9pdCgnq0UObH3iCU6MXk5S1+39NrjhoCpMFov1zVzhR1TWMcPHku2onAJxp6rpYXMO6
	 ZRpoPm6B50vnfZQPyjCMTYqKhaUkQhoyc0Yed4zZDqU00qvAELCouDZnnMh6gx9JrJlVK
	 /mm2rVQundZlPC7BZsrLOHGKsCRxjl38aogX5Arc6dri5tpB1TKZIcKzCSIrNkilIcDzg
	 P1PF3ux4TF0rFmc1QdLU1AUaelw1jYEPj5fXOcAGha3MBDzWg3go0VISur5GGw892Rf4X
	 NU7tTa5bcELg75F7MmmvQ9z8RMMWelK9/BUZPCvDKLv+B1rfg3GGoON9NPtDJK6+K4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzYjaFmd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AE606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzYjaFmd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888C81F01825;
	Thu, 22 Oct 2026 18:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693713;
	bh=dsfQXIFPZ0qwWZFRjxiMDjfIuZoo/qr+h4rVbZQVMpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bzYjaFmdKX3ibn9wgbPWlJXakDv1FsjIZ/VguHf8AvfYZ9KJK41S2uhflnrrTB/pS
	 IRVsTnxHKYxB7sslhCphFYM0EvtC5+Law6ht4CcTqo1twtdzm4II6dGdsaBuLDxYiM
	 E+uBaOHZXxzeVE9iHAYCtH4Og5JXiHVpTQSPezM24OIgD5FgbcDzeDP7D07FXxNTSL
	 kODCBy0VaWy47swhPgSszAxi6ygLVkhuUWC707FktKg7Vg8ACJ5luV6tc24lVpqTnI
	 6xxQzcT0uy7Ur5q2cZe8pXWlXQkUdThP6+maSHggjFAuM4c/+WDcxkuNnQo/GSo/Ob
	 wYz9CpUXPyi+w==
Message-ID: <sashiko-outbox-181917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] tools headers: Sync UAPI sound/asound.h with
 the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-10-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:28:33 +0000
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
clude/uapi/sound > before.txt
>   $ cp include/uapi/sound/asound.h tools/perf/trace/beauty/include/uapi/s=
ound/asound.h
>   $ tools/perf/trace/beauty/sndrv_ctl_ioctl.sh tools/perf/trace/beauty/in=
clude/uapi/sound > after.txt
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D9

