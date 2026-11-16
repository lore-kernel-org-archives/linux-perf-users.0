Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808630;
	b=v4Db1KZlqE2nMYcIti98AJY5794RePmsOQqH5DniP5u4WS2M+zfFFqthJ0avXDZNeWyf
	 HwOiMU0PE91dSJ56amp38EXSdiywlFKxUqOejSwV9IHepLtVzNnPIl9QaGrUkkndO7opN
	 5f1HeoDqqR55Zv0N5WrX73N/bp94AYrvFt2K+DSQuQ7MU1p45PdQtIxjVP3c/BrIEntGt
	 fdVpV2plQYaN6Da1tdT8cHkMYxtiU31wG2NOfmUi14QI83kU8KPT0z6zxFeXKoRUBd558
	 aTZE6rnspZkZsOShZnGdz5ZWrNO27zc304baSoyYUfNQWwqdl81C2s80FR0qcLQJuEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bdSb0XXFB/ytXc4i7kSwG5tKuvQ8028StWzRvalMHko=;
	b=cbkR3oCoif6+yljbLWNfSWeXwm4sB2LiPgW+CFcD+UwaMrTH1VNrAX0Z/E2Ht0gFNjHb
	 D1Ctxg4v6vYr7WBu3FE/oSO4YNioJ6xmhoZ6VRj7Y/whGEBAM16eRG27n9dtos/LUhqAX
	 3FHtj3yojhSLiA/CXm7VSyXbTJxF7BmfKYYTSarui7kW1R6nLfKB/y4iJkmLgSrhGi4j5
	 K68IVyC2t2cgpF3BocLWNinrZvArN6ZFoxKbq7TgnwnlrWZWCQ1DTy21KmTNsOuelUCDL
	 ho4MqCnN4+TnfnLZED9HbutO+LnvuPyeyeAma3qToRXKRMtOxtF4djyZD/sEy6PtcMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKxpAgYc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F7606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKxpAgYc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA53D1F000C4;
	Mon, 16 Nov 2026 05:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808630;
	bh=bdSb0XXFB/ytXc4i7kSwG5tKuvQ8028StWzRvalMHko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iKxpAgYck8fjtYNB+Cg1uFNLhVgGl3hyAm/voujXHzFiozIylnl4JOT16bGosQxu0
	 wsTt+IdQw8a7l1x9jbW3hGAK/w1pmkKwx46hSwlLRZ4+xcx+15q+QxQ62JlrS/9XBA
	 geUSZupdWk+S7Ubw2HXm/DnsKDiw4M5h160cZ5kz+q4TDdp8Vyk7marqo3cY5SHD4o
	 OCWogFVIG+awwIhf9RKLxoXJ2BvUMyR6Wot4/HO0CBjiSAgi4roWx6QaDMZMYorVQO
	 pLp0/SUC+MAIDpBGaxJz0QIP61dIP0jy2jm++Puzz+nVi2M8l75E3BdWE3CAPUjbLl
	 ikvQ1WmhM6K9A==
Message-ID: <sashiko-outbox-216237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 02/11] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179480677551.38065.16911166185560694375.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480677551.38065.16911166185560694375.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:57:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add modify_local_hw_breakpoint_addr() to update only the watched
> address of an installed hardware breakpoint on the local CPU without
> releasing and reserving its hardware slot. This is available when the
> architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.
>=20
> The caller must provide an installed local event and a valid address,
> and update other CPUs separately.
>=20
> Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf9=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D2

