Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794750019;
	b=ghP0nLJzMt9cIZvpFuc1I6z0rsTZ8FrGOwZ731vrUi9akHvctWN6v0uN/BbzJR9/RtiD
	 NiBa/GRT807qaFdZD2BDUxmeKphW4p7DcwC6q+G+HZXS/UjZSh3mN0NB5VJAAa5c7Nw6N
	 kQEPkeaw8XT0A9evjYdEeZ56qR+ISphnmGOo3kj38DRoq1VntoOtMg4kRbbXP78woV1qe
	 CCIayVytibcRCvuxabMZ2k+Qir5kgAOfhW6Er+WWSnJlclkh2NtP0FhpgtfLxyMXBzxpz
	 Q4hrbmIFQhi3Lv/+BpYbvnpMKUFtbcjigaNGVXwnX6N2QczPqFWkCl7943u3aHdIkDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794750019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ljS3ijySaQu04FzbDxL88CTOlP3Brd0mv3M6od36avE=;
	b=WZz9HV/02Hnk9WQd+1PxrbEZOHQEGcYwvbW3++tmup/EecIfh6HMRY34Szik1d3jjv0N
	 NdXRcJSei/0gngiL7LoFrB9I+MvwkaGQdmSaCY8ObHNpAaMeA2kCxeNBs153hC17OgssU
	 mbIGImg3ht5ySwFvLV8ZQU2CFf7qC3v2A7uiCYaco/HXzFH9ZmK6Myu30uxx3a6NWAL1d
	 UhaSrncAjT7mF+lRuLte/Lkz1gx7xl3kh/ZBOk2ly2DB1M9JLBJax4w6Ks5E1TZho12eH
	 7VU19/ouJ/76S3FizDnZPzoYIT8j5jpOkmnNgMChiP+vpekqJHT58PtjePCuylRYeSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKIl7kja;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBD606A31F
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKIl7kja
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696121F000C4;
	Sun, 15 Nov 2026 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794750018;
	bh=ljS3ijySaQu04FzbDxL88CTOlP3Brd0mv3M6od36avE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HKIl7kjax443QFS9c5ThZqaG4GtoKX4w7AFhh1Ns91Spryb2UAoC9WjV3vSn/VvZU
	 o/W5zZTZmkbBtTdKX3VUbI4kjyMtM6EhFxI3PwWmaeKDLPguxGxZgOpkBOAHhOXtSu
	 cf7xe+yjZhgJlYFVUyJK3mGK87Z/J5zMDgnrBtER3Ho5i7YV5h8czWTWX4adiQRXb4
	 x1a4hUzM5h1qsYKTYSaPkzSmubFXdOm+D/1B3h0ywB+g2V1MBRaJVurtF1PbieV7ES
	 UmKaMsDvLMv2RYvLPZH6n0huzDGzUKMnWbDr23vZy2TTvr3Va6bRDj/JWpxWdKkux5
	 Ume6YnKCnCeaA==
Message-ID: <sashiko-outbox-215540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf test: Cover multi-record thread map synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115-perf_fix_large_threads-v1-3-69c9b86b9ae5@arm.com>
References: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
 <20261115-perf_fix_large_threads-v1-3-69c9b86b9ae5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 13:40:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend the thread-map synthesis test with empty maps and sizes around
> the one-record and two-record limits.
>=20
> Check record sizes, entry counts, continuation flags and entry order.
> Reassemble each map and verify PIDs and command names, including missing
> names and full-width names without a terminating NUL.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-perf_fix_l=
arge_threads-v1-0-69c9b86b9ae5@arm.com?part=3D3

