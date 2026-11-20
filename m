Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197655;
	b=JmFAZ4CehspghNBbouIQWUB4mtAXSPb9sQqb3AMtOevmFpGbE/7PztudGeAQNyCJlc1n
	 EIyA65M4r/StsID1wlpRrMWX4bzXpsoAyfxEedRzNIEra5wUarKqNdXshJ33IKb6Vla5j
	 x8Q89u4kf35zhqoZMzg/T0gy0CiSLW7uwidJ91UKGrd7VdOA4C19cDjLMfU/VPPPqoEXg
	 nrTsXyJWcp+USjfG7a2RCWepPg/5LIQtiOuIjwzO1/Jd9WiOpjAfoqDpK6B7UNpPjZjpo
	 T0BAWe7OWjvyvenvLlPJspk80H6/nZd2ZFagnSo74wtWmU7dYmE0qvTdBTfYa0Dsk0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197655;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q4Enf95OaU0EHV7f9OLxSaMJb8WdHmXdPEzHEZXZLGY=;
	b=mJkBHCzE+Gl7xNxrORlg1SeOpI88CJAg+8loaAUbprlhZClO0ULtwusYZujWnYN0DR5l
	 VDU77X573hR/dssW2nf1xpgbc6dELT0rh7jVpLDY1FId//uGwhdqfqFjVWjHhjJMdZASf
	 7RCMB8Y/WIOVFt1LBCbw85uokMpMFA/rbMsd4gtdkjPrQ/BB8CPjVS8EpTomB3H6Ls7Xc
	 pYUeCyGdmoQGG8FbCko9CzRjL1JWXHFHPRxjg9Lg2CCgeRP/026GDQ+6c9FgcQWsaMB1y
	 FrWT5wFGgV58h+OK3Xs3a2vmXLVm/NN7JyCidflFmUl9DJpv6usMlmpjNPe2179/KYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rf+9bl69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAB60A261A
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rf+9bl69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C841F000F2;
	Fri, 20 Nov 2026 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197655;
	bh=Q4Enf95OaU0EHV7f9OLxSaMJb8WdHmXdPEzHEZXZLGY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Rf+9bl69kyN8A+yxcV/CRIT7N74BBn36JT6L96P4HGwqR4SVaiG55b8ji2Qbtrhel
	 g1djGao3fHuldz1ydq7m1I5fPXIoJ2XH+CFmGzwTmIviOyOqiEkt9d5c3FAleRfiN0
	 YOGLmdxyrzIommLBt0s/J+JZDeNv0mhKFUeh/F2OpnDGEdwG5Zotykj5G8n+67ucTb
	 z79O5I4c1o4xr0k0jqMMkbyjnPRTzxZMEYEJZbkk7pVzqp3qHWtx09DaWv7i0MFhah
	 k+2Beorq2Ih+g6kposJKv2ozHXp9wB/35fnzr2pRMAy3Ci5NM9imj+GEFRFXtss/D8
	 /XxK74jHJ/rKA==
Message-ID: <sashiko-outbox-225775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf vendor events amd: Fix a misspelling in the
 amdzen3 table
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261120175840.1274637-4-takano32@gmail.com>
References: <20261120175840.1274637-1-takano32@gmail.com>
 <20261120175840.1274637-4-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:00:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> One word is misspelled in the amdzen3 branch table: "Instrcution" instead
> of "Instruction" in the BriefDescription of bp_l1_tlb_fetch_hit.if4k, so
> `perf list` prints the misspelling as it is.
>=20
> Only the description changes.  Regenerating the tables with
>=20
>   jevents.py x86 all tools/perf/pmu-events/arch out.c out-str.c
>=20
> leaves the generated table and the string table identical except for that
> one word: every event name and event code is untouched, and the string
> table does not change size.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120175840.1274=
637-1-takano32@gmail.com?part=3D3

