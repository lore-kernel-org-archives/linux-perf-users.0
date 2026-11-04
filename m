Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783137;
	b=XSQeZp0RBYtdWdlPp/rC4R+absPp3eIxHhLp5Tcx/OvFLE9gH7+XFsoMHknC48oJ2nH7
	 QVN+3k2HihRboAoglqTjKcORiQw/yXBLN/trQWeMqEwHpVHkuMNAVkoBQwA+142omQTFR
	 StHlEDENoiDp92Q0CwqIyiwuDM/cs7RfMQeg3aFMW4eceAGUvwWTzu7IEtmZ3yl3CVslD
	 jqeks++Tl45GfKgYtpYuRiY9KW95DR5VZI8CaH8lD6mTqzcX1vf4PP8Qg/rUtuF02dGcx
	 Vh6kdLIwMT9dRvgoBHyRKStnnl4qcJnCHO6M9B7a1YSh2EGZVZn1B1zS3d56ALg2CoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783137;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hoqb05XI5OJydgZDlJisaCN+X3XMOlI0sE92b5zNDIo=;
	b=kqMiVkHBJAw/cSfC3YLQ5dPLdQ7GfOfANkCEcd0QlP1FNVo8ZaDTTAoI5irW7tJeJplM
	 PCpI4OyAfwkaNEvoU/16jyjEwWGyu8HOf2V3wBhfuU4dusuT8rvTsErE1UlAfs9maV/zz
	 WcvLgz7HHcbL9bM/7UM+OmnIVaiciyjjVsEPmWGp64Dry/Cuxh3RkAtXbM8YLJ2um3PiG
	 S6SucPB2ajeqWHATybbNzAeJxO7nTmCSTMXh325mqiw5d6UYo1vuy9fZYjc+TzH56u6Cs
	 NllYciKLMS0gEg+XPhkgg2quZP7qUgRv7gDokVCmUXdUXnRPWX+pxjnPgAVGeqTx72A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ot1VJtrc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B37606A32D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ot1VJtrc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B7E1F000C1;
	Wed,  4 Nov 2026 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793783137;
	bh=Hoqb05XI5OJydgZDlJisaCN+X3XMOlI0sE92b5zNDIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ot1VJtrc0sRCkGwjEB+x7Gj1+XEJ52HMUNw+dFQSpGaGD//6faYiyScRybk32OK14
	 rJujx6yoloCz+mT7jWwNsY+cadaovncDxAU/VgSkgh0naMczeoiYaAl8/139Tz+CF6
	 /RNoYYbhOOT/oTqupYTR2dDms11aMgL1KRnmoVCgUv/rCfvaL1WZ079PsD0YuLmPKj
	 pK5yqIQiuFX1/D/jpoljqCc3lcufv1Z2OtpOod1oMhf46ZQ9KeryGO04LanyM5CdX1
	 SYB/aGoRfu+11Mk4xTObr/4Bk5VE+MBFw48bI2dI6EiRuVGuRb486wURqn42pu8aB4
	 PkN0RAHBm31ig==
Message-ID: <sashiko-outbox-196920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf hist: Fix branch_info index for sample weight
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104090229.1870-1-gubin@cmss.chinamobile.com>
References: <20261104090229.1870-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:05:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> iter_add_next_branch_entry() is called once per branch and uses &bi[i]
> for the hist entry, but reads the weight from bi->flags.cycles (i.e.
> bi[0]) for every branch, so every entry is weighted with the first
> branch's cycle count. This is incorrect when the branch stack contains
> more than one entry with different cycle counts, as the weight of each
> hist entry fails to reflect the cycles of its own branch.
>=20
> Use bi[i].flags.cycles, as the surrounding code already does.
>=20
> Fixes: 0e332f033a82 ("perf tools: Add support for cycles, weight branch_i=
nfo field")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104090229.1870=
-1-gubin@cmss.chinamobile.com?part=3D1

