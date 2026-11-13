Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600851;
	b=T2+t/Tk/7I3Spp88653lnBiVfrbl0Q3gCjajhhz6naHJp1omUYPfVEhkOHPSNjskpuUz
	 tbgHTFwiAVzdKLdjpOLskwmHL1aCNZfVxyMQ5ljvd74qnQdDHgIDDvStsOSwtIQEmbcHv
	 ESnnX5HqHEz91gtb8ql45b1LNdohNMLs05CEKMMQYNr4ahlErAPaVZN54un0ic+MhOWP+
	 eB/hjZFZc42NNjP+wIJGR6OXB/qx8RuZILT14uPgoFe6HbIPdOBlo7lmT/OYfK6bC01a/
	 Db8KKpe3j/48WnmvRGTqoks6tKgF65psp/KynQDN4aFHMmVlG5ofLgucAP60jL2jPVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JPXKNmmx+tfa1R4B6RsI2TpHUP+hrkjn+C7u8Y6eLjk=;
	b=K4h8a8RSCz/1FBLyJi0ievBMsZLc+RVELwMqmeN92APS96FVKsMXHH8nw8cbZ1nt1lNh
	 N3EA1ssSmicLRqDob9Q7gUTBsSglW0yAIIOtff1A94616kx+Dzbkqq3bkxuKYvFv6Jsxq
	 pNFcoBHjqxznp8p4cRMPDPpAXEMTGYO/gVCYGnoUkGSe7glbygJ0lRbalUp6tqcnxz36c
	 +055JyTsgDDeZ1puzYbLfZjaDLjn7+0FPzNGaA1RpH0CSytoFttDNMVyWbudQcviHw8Nj
	 SUpGOnhMJUrkfEBB8Q8BjcnD/63qGLsVCxSLRmHaOXwMMgFEQq7EOlUmetjvRnd3EpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ST9wHOse;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A2606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ST9wHOse
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918891F000C4;
	Fri, 13 Nov 2026 20:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600850;
	bh=JPXKNmmx+tfa1R4B6RsI2TpHUP+hrkjn+C7u8Y6eLjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ST9wHOsesJWt0cZpxNj9Cj+YICx7MY2GwmfB2C2/ejizpHTG+aC3Wjh2nX8V6QMZO
	 hqwnFco/Ix2izM1suAv2zPjtCqjHOSxHirRDGecACYtv8RTRTSAfMREpUs5G19FwMM
	 VwraAw+K2XgMjRbG4JAjFVrj/zIt3OVSO/YdqHxf6tE5mJZ8HO6aEUzVFxbxO/bFka
	 lIeNUJp0R3RGxP+dqzfhl1HgXGRVpRR5r3/pGABM5GVHPgqTj718LvaE89D4Dt5B3o
	 mZFf51DZY/87WRCZKZ1CPhHhSVo3e+Wtkio7uA0ClRAlTfn0xmA5Mp9ElQrwya3BMq
	 tBN2SwDFRVlRg==
Message-ID: <sashiko-outbox-213629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 30/30] perf test: Add stat record metrics test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-31-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:14:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Test that metrics measured by perf stat record are displayed by perf
> stat report and perf script, and that events recorded with -e only
> display matching JSON metrics in perf stat report and perf script when
> --all-metrics, stat.all-metrics=3Dtrue, or -M is used.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D30

