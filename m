Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163676;
	b=XqEYPlDqa9hq88A0v6Y9avD3p7w6FP57LuznUst632n9GzKlUQqpK1CTg6FZ7QECBnbm
	 3EaizWmPniit7QdXu61puRMcHXxNjLK9vnpKDNVHEKw6fk1QMzseriDSxT9nvv1O6cXCC
	 GcGCV43Min9dfDDD/aN8kspvV+mqBgERHSDC4OI+NEmqle5UqtlQ5/Dw7e50+Muw93tUD
	 ikre8oLLULwLrqpK7E/IUOxu/Qcew/Y+H/H86tpNtIEcTXOpDpm/8knfbPf239hDrvfFw
	 qvPyA9fJWlBN45aVIBAqbiYb/XqxQ34JCU4hn8Lx/zueYdzggy9IaQp17CvaVcXBMtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163676;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D7vX/0ljEmlIdz0QMbhaaT2QpyBGnB8+95xI/bRmcXE=;
	b=o0HtOdg1Y9W5pAJfN5Z05yx3zWFRutwJq+Gwl0Ebn8cWp/mdjAvErwmvAWN8rpWY6Ucc
	 zjQALUWOFq7p8Pfrr46nbTc2V7y+bRf5CJsgVbhEYp+Qg4xUtfs+l/SZkHdvWwqLqX6BY
	 5f9lZukB25AQCzWTh/j7cKsTof7DrJq5V+Qv1TUEFrYWW7ZSctdNnqdYCLVqg6jwq9UXI
	 jvqjrybXw1SPajUkUvS6UbDBoXIkBT6+DLP4VaEzZSdpEhSywPesYR/KUg2TXVsIaEwIF
	 RWT9AH1C9rtSuGI5xnIRQwX+khqpxxLmCNWrhiXJ4KKcpHMBaA3E3uv66DDqjG2egbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlJZKNnQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7E606A31C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlJZKNnQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6E71F0089F;
	Sun,  8 Nov 2026 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794163675;
	bh=D7vX/0ljEmlIdz0QMbhaaT2QpyBGnB8+95xI/bRmcXE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mlJZKNnQDtQsoedAXr9TEbVJGdyatMbpTkk8wFO4+xIH+4UazNdYMoLl5/jQ8PcSn
	 fnvVez/6JDz5YknJ89rkWUYprQ4r43Z1b8GGJ9QGuNSfFwzJWkIpUB79jbQURvBUC4
	 4gx+KaLDg/Kjr97rtbDsli8UnUkAz6viDfg/kMZM0GCs4tcskEaai4Zuv4NwZ9SajM
	 O8vJOCIc8dnJzVhwd2fIg8ZZGPGMErUP9LIbbku1jLKv8c6+/xTkC9GfVxqsPNEOfc
	 v2UHCZLZFkKRLA44oPnMe6bukkMMZS9Rz2gPqRZ9CxehUOx5/t9WIv0IDc4iP2wUpe
	 ECXCP2hJ25Brg==
Message-ID: <sashiko-outbox-203913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf vendor events amd: Fix a misspelled JSON key
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261108184600.3810059-1-takano32@gmail.com>
References: <20261108184600.3810059-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 18:47:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ls_inef_sw_pref.all is listed without a description on Zen 4, Zen 5 and
> Zen 6.  Its three JSON entries spell BriefDescription as
> "BriefDescript6ion", and jevents.py reads the keys it knows by name, so
> the text is dropped and the generated table ends up with an empty
> description field.
>=20
> Spell the key correctly.  Only the key changes; the text, event names,
> codes, umasks and expressions are untouched.
>=20
> Fixes: 658448281d19 ("perf vendor events amd: Add Zen 4 core events")
> Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
> Fixes: 2f42fb0661d9 ("perf vendor events amd: Add Zen 6 core events")
>=20
> Written with Hermes Agent, an LLM assistant.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108184600.3810=
059-1-takano32@gmail.com?part=3D1

