Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048782;
	b=r1UFdWWva+5ejlGi86SBLzeGe1J9pzuQp/m9VytPP5vCwDxBnSXiuJKG7afW35YCx7j2
	 VlF8M8B1NsGM2XJrjBdcfXgxDJgiSJAqX+aXtst7FrsqKxbtoODjfys+yaR4Zu5eDvedF
	 t/h+tGwuh/oltIhCZvC0+4FdK4QpIvPsmzFhPOpR5fERKNhpFnVChHb5Wrr5UXGr3Ob/0
	 LdHS7aa1wHhOuGaVEpZC3intCoqBgyeCuAvwW+1Ah6KNFtdcmEk9a41BqERGgc+O5nZlu
	 X5OokytnAOMt7UodPVwQBYPHLV5QVzoSB1u6TNzWrLWZHeXLMABIyWZu6T1oqXU+3Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dfX9kC9pvodoXckge7CDk6HPAZMcBdiBNuMiJIjK2Bo=;
	b=IZAz2CrHsu+CKjNs2woA7GJOD6+NO0QPeV3y/AnriwnEgFpksL7qoMd8MV7kXlvM0nJD
	 iQf2ZkaDbKGqeTewNXSu+ohhHWqTJGBqn2H106u1AEDNncqdDkQ/4+ya9NFvtcaWhB46W
	 N5+5EvjFtj9kPF3AgVszd2gVZ0BiAw4Fv8zjChvAp4XFEyq1qgfrnbx1guve9gjRxZRPs
	 n0UDHSAJnwcPSGm0xJQwY5dmAWZHE/UTH2fIeQXfVje6CeOeYXAhaxKs4+mC5hJ4omVyw
	 8DfMvOYcEvraxRKQYDZ3HD+TBRN/APlqorY6LAzp5BniYXgdp04veWu7SNZzCKfuMMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oS1pG75C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B701606A32C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oS1pG75C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325621F008A2;
	Sat,  7 Nov 2026 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048782;
	bh=dfX9kC9pvodoXckge7CDk6HPAZMcBdiBNuMiJIjK2Bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oS1pG75C0KNYkCTd5nkrEfGubH2/Zm3BZMh9V9qtanhcOd8hRzqK6JXHuY1i/b6Bc
	 N1Wc6u8EGGiOgwak1IjRxdEJ6fxiYK3V+WYEvAla5yG+5NRpdt7Ji4DA8985K9T50R
	 KGpGDft5+6Qvg2Anbu1QyNNAc8XTRtqMXCrMOHNFH0ljsKzrd+lFs+nmQj382j83wU
	 bHurt88kArN52nfW857Hc8o9BxtpPOEAS7rENIqk4pY1gUtDTBAclxd2gFBCDK0r0d
	 4D1ECeDWXL7CHqmFzppKE6Vgam/rTF+EYRYjjeEqaytlvOEi7TohvNUG7F85siceVT
	 0bpZ+hrDsQwqA==
Message-ID: <sashiko-outbox-202824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/15] drivers/perf: apple_m1: Support
 per-implementation event tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-3-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-3-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:53:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Nick Chan <towinchenmi@gmail.com>
>=20
> Use per-implementation event tables to allow supporting implementations
> with a different list of events and event affinities.
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> Co-developed-by: Myria Sarvay <myrialsarvay@gmail.com>
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D3

