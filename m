Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896EE33CEA7;
	Mon,  7 Sep 2026 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760599; cv=none; b=dzXFuubXGsZ4x5E0Abih29Z8YrTMzKdarzK/BpE1l/cd0HMfGeVILZ/hV7eiwUWDI6BakEa5NnrZVgXcw+lgkRwju2h1RSseVdmR1gbYOBFKU9p8bdx/FqGv3ovuJF63Zgb8ChNehq5sSogDHHwX2BI0qlYAI6ez8oQ0OaC85Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760599; c=relaxed/simple;
	bh=o0ZLyztK3EGAktd06xrqYTHG9CXpjBqhazGSPBdIv+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=giadA7t6I9DudPXcBeCFXKQ8YsUjYTN4khqtTWeq+QCiTPa66iVFzT+6KTgZY1DOuqyghxJ4MDyNPwwUeXF4GYXyB4hfQ9FyMKr075wtPCNsLppxayk1XMiP/ZoQAPKpg/nG6TwzLPC1ZTN38VxMu7mknLrd1Ls6CSQo4yQtgOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUvGaIa6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUvGaIa6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359AC1F00A3A;
	Mon,  7 Sep 2026 05:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760598;
	bh=o0ZLyztK3EGAktd06xrqYTHG9CXpjBqhazGSPBdIv+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cUvGaIa6m4anucruPyjZQtuniYVVX2SuzU80+kuRv3mdOjTzpQ0VJjSvZlq7Huu1o
	 rrRaGVlUQmVgQr8uxealNyoWy7VC0uZR+QiUb/BMTicDjQpkO0Ym7ToUYiB6CSIf6S
	 xf9lJ5Ir2vkjLWevBH6M16u5uMJ1cKGNgf9vemh3k5JjepTvaOl9bmQ9MrZzolEPQf
	 rERiFtYo12PgLlb5J6yHDwD2rMFImeftA/L6omWuqbyzmU6mkrOidnwzC7WYAu5OXR
	 5rrfmhCDtpnDG9+BSDqG5csjvxji6iRN+JxBnJc5i4poPeBntg6PAX08XgZXguZFRD
	 NUWTnjwUBpwEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Use __DEVICE_ATTR() macro to initialize
 dev_ext_attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260907-sysfs-const-attr-dev_ext_attr-v2-1-bf53afe57071@weissschuh.net>
References: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
 <20260907-sysfs-const-attr-dev_ext_attr-v2-1-bf53afe57071@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:56:37 +0000
Message-Id: <20260907055638.359AC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The upcoming constification of the device_show_int() and
> device_show_bool() signatures requires the users to handle the
> transition automatically.
>=20
> Switch to the __DEVICE_ATTR() macro which can do this.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-sysfs-cons=
t-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net?part=3D1

