Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966800;
	b=nw5T3tzzyCksrXtzpBO5OC67Zhr3pD4iug54YjDLEvcgmC0BaHspjTMpLfeZA0V7VOCK
	 HgqoB6RM3e/kyPAipSCky/s6+5j4jk2/qG5XLBkcbJ+hbtrcLWul2JI12Poewn7HZIH+E
	 tI5KpTzK9KIcg/F1aQfTecv7TLS5bcJ144d6q4I26Pi9uMmH04wEhf6UGKYkaGod4kFGT
	 Vhxh6tL7QyloiZ5cYu8yqb0p4xzt2rmNAI+YX+Hsbk7GW9zeZA4NpyGhjGZ/7izgYO3wW
	 r/ncP8AXYjMh4NMCJAJ1vZrmu2xlU40rMhI8QD5O24vWKCPimxPexE1Ov2wP2/621Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966800;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y8UaXvt+WIrv4Fr2u02/LDEZC4dQpKn679RuVMRvCMc=;
	b=0V8msHTfBK2u/IRLnDCyTsup7EJg8cAE0naSX7jhS/MmHYct6rTaszObDtygJEsvKBpY
	 MFJmyRI7gLDjub7grO7Ncs83GUG80hI/QAa7sZdVVzZBbBSkv9GFQPBSvcwmrrYOaaGR1
	 lLafCde6UA4cmdhpDHsRn41qBEQg9+oCnyaZ35geB6eWUpDroSNv1NAsJo8bEVpVhV0tr
	 ojEq2l/saM0DRF3KJ9xXV82UJwN1nzME/zfcQe1yvRqOAXNPNz/mu2EER8RCfK9Z2AZZY
	 RFxdaygPdvjmVf2kWgIH5RMoTershcJ0yeoXF/3aKLP1XG2GZz0RdE5+l3hwAlD3wbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ol9nPuW1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D23606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ol9nPuW1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C9F1F01825;
	Sun, 25 Oct 2026 22:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792966800;
	bh=y8UaXvt+WIrv4Fr2u02/LDEZC4dQpKn679RuVMRvCMc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ol9nPuW1OWZWysCxoj2WIzoGSNFMN2Qp634+UKp9KJHVg78MbOXh/64betbWEzN+E
	 RZVls77bt+gNoa81q79jS8haKvzoJzLemLj87lI5hiydOWSaXrsxQockto5oENMS0v
	 50DK/gqq212T0zUctC90FbpSkCrPtCEDSiM4fRJQA9glYEjgU3QddzcijOZRla6uJK
	 WiuutIVS5SsWSj4jlCVqgb0MUN/eVPWVunNAc3oLUxw8rA8jaqDnpgQkzJtD/F4yoA
	 ccZkrFrmI4oRkw1eSgsksZkI3jVDWDT/DVh5bMiw5fNDmX5LteWZTV2OGPu4QCSXB2
	 YnVWQ+rkRTjuQ==
Message-ID: <sashiko-outbox-184471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf/core: Include attr.defer_output in
 is_sb_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025215508.1237480-1-irogers@google.com>
References: <20261025215508.1237480-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:19:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Events configured with attr.defer_output =3D 1 receive deferred callchain
> sideband records (PERF_RECORD_CALLCHAIN_DEFERRED) via perf_iterate_sb().
> Include attr->defer_output in is_sb_event() so that such events are
> attached to the sideband event list even when no other sideband flags
> (such as mmap or comm) are enabled on the event.
>=20
> Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025215508.1237=
480-1-irogers@google.com?part=3D1

