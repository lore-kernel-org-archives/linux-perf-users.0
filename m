Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004489;
	b=HK5VuI8pXWYyfbhq4WPcsOQd73ObDlgC/2OzWEt+y96oqVfkNQbqvZ9XItc2D9ApVWDW
	 9rygqU/6DIxpuwbkltOK+buNfv4zSpyrVXrjIgf23J+hjbFY/ER9t9RfMhhOCEGc9UnAd
	 yAmMObj9/rpER7XlNIvCzp04Qp+TuyUGNBLDNXxGTHB+Y9vcMGDTM2veUZNoh+Er60ol8
	 5rqiB6sBuAty6MivMDq6fezRi3RbXWIywN9Zk/V66d2H43yQc5vncWEr4Tt5kPYrjOZpM
	 39knuTz7V6Ojr1qQkRICRCfyCW5yHNrDPuMCBJ1b7MUU7nZ6FGYCpBatqP4WxTvRoFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004489;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qqvQTFks+3FrcZmbe64FiW4a1FeJaQc8miBaR5NTOuA=;
	b=r+HEolBrrHvR7gwq613EZCweFgYQzyDKmPfHR0BPSTVaJoDhHxWk9XQFJyDPbFvQ38De
	 J/WO1qope4Nr9Wt2mnM1JRI9eXN1oXxOWHQQq21Do+TyyYBovSKuX4zpxeHrkA5o75RnT
	 K/kQfNhqOeicrq4hKh5NqpaeNStQmyqSyXEihYiIKcvJ9GufT5tRdGkKmIt1WPBlAcqz+
	 jk/iKa7DVWMVuS/rS7CqcP6GmBF1Ljq5c6q+sp69bvTSmIXOwWA04bZjG/FHFc1rTCJaw
	 YkgJhDzknCLPgNPGD1XHQzy7pHbUd5+ntXT+xgdDavV2jgOz7LOfC1ySKs+LJkRGLgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lGR9Y/3c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6F606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGR9Y/3c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D051F01828;
	Mon, 26 Oct 2026 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004489;
	bh=qqvQTFks+3FrcZmbe64FiW4a1FeJaQc8miBaR5NTOuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGR9Y/3c8j6Gz92sZETo26YLhklBP/ijz5TieCC+ysDhntGrZBnJHFKy1iYehleSJ
	 vC/emoR40qpjamvm8OQgayYD8y7dRyOmgcpoYjbp/OngCTfVpLBPgth7LGBe6YjLoo
	 hBYGeucOToeT3LWpAmhAChgUglN6eAdJTu+57/jVOJHXjGT5cxbDD1rr3ywT/piODQ
	 wJjaApdxhAhZ/+kM86giUJK1/nl1QPcmwmjNaKGjVyjSjMZP14SaKWtczEdBfl1mMT
	 HtRrg0cSh0cJHNdDA80a/61ZixPKYcUikqmJpSRPQxkyBInRWjOKXKs4UgF1WlLhro
	 /G0QEZRIZEXKA==
Message-ID: <sashiko-outbox-184691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] coresight: syscfg: Fail to enable a
 configuration not loaded on the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <cc6b083f1ece4625e5bed0aa13b1eac7e4d1e274.1792989860.git.aaupov@fb.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <cc6b083f1ece4625e5bed0aa13b1eac7e4d1e274.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:48:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cscfg_csdev_enable_active_config() looks up the selected configuration in
> the device's loaded configurations, and returns success when it is not
> there. A configuration is only loaded on devices that match at least one
> of its features, so a perf session or sysfs enable that selects it on any
> other device runs without the configuration, with no error.
>=20
> Return -EINVAL instead, so enabling the source fails on that device. The
> function is only called with a non-zero configuration hash, so sources
> enabled without a configuration are unaffected.
>=20
> Fixes: f8cce2ff3c04 ("coresight: syscfg: Add API to activate and enable c=
onfigurations")
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792989860.gi=
t.aaupov@fb.com?part=3D2

