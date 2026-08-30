Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26821429D
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788118645; cv=none; b=KKBTa9dCnDO1VJ24awiW/KeBZ7Z07OgGsyef0uS274LEDYil5kZkrnPTD+jzahCobALWukTYUF88VSWN31ZO7EiMZziwxxTQiYjY3pkKUctlOVfnMPAx3TXCiGEtHSg2n58w0DSn9TDs32tsInEXtZ91BCgSs8Adt7DiQD52D30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788118645; c=relaxed/simple;
	bh=2ePKoyv1YJYrPTv9F7RhA/pdOT9FLaCStqBji5As45E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LiTYVb9FfNo+zuyUjUaJKdMqkSf3AaY4S01PMlkFOegzEwtgCjQFsnN1zyxA1DHSyO2DOAetWlY425vy/bPehBuKatVIAcWLdcYFxnbbgYgMpjbMRzTpvVevVNQ7/pfAxyCiU0LOGjzqTw4yr3rURhleZGVRli9yi8j9F5oaFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NupCYHf+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NupCYHf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C29A1F000E9;
	Sun, 30 Aug 2026 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788118644;
	bh=2ePKoyv1YJYrPTv9F7RhA/pdOT9FLaCStqBji5As45E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NupCYHf+5z0xImToCsFmtJO/XpvDu6VMWgHrxSZe5i3kQr+laeDJHx9gU8t2f4HY5
	 uZ6s4EhcLlhhsaIsT4j0/h7jBLuRYk+PU1+NwBJ0ECv7C8AUAvwNzLzSjxUB5Qmt4z
	 fOZtKzLr1neynsOUwsGWuyyWn+/oCPFFNZBVk3H8FJYKc0TJ2a+8q8LgAIhS9771+6
	 MMZ1FTSLBQcmydbQ/cb2dKpXx2Gk4eusHEjplxxjFKgyxFlXz1dxOGijB/N6W4JxSl
	 SWd5ZW8ptKfKSDnnmd9dV5h7kPtkWfqRCO1gxypBMX2B2QLFHxQh0u3DVp9aXnIsDq
	 FHQK4FwbycthQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] perf tools record: Modernize -W man page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260830193459.2840519-2-ak@linux.intel.com>
References: <20260830193459.2840519-1-ak@linux.intel.com>
 <20260830193459.2840519-2-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 19:37:23 +0000
Message-Id: <20260830193724.4C29A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Modernize the -W / --weight description in the manpage to cover more
> cases that are supported now.
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830193459.2840=
519-1-ak@linux.intel.com?part=3D1

