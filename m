Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369291;
	b=pYjaLBgFZLgEjLr30dOJgE1SKGuDnaSe9Xrnm1qcqOwCRTZJ05FpJC3lvcz2l2SRlS2y
	 zD/UsuqAApDI/hNl1FWuwpoGbrO12ONdaBWzTlIScVWNDGby4bzS8OpG9CDPom+dX2kFm
	 BP/G7eMgGODG5cnKJS4DOU+jLeb7l8MTzfsF3CRDspsxM1A3hascn+7Tj0Qrke5C5JdNe
	 08r3cujJ1sCglCPlwKToOdzcRhtepuXbbORrdb+2yktBdSDLSSnac/Mu0JqPmsy4wRl9I
	 kBcjk7OYKa7goDwn/lmK5+5Ws35BYDPMhFYsC6++WPwnK7C6iq55iIO9T1T4FRGGY7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369291;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=egYAq4IGoL5GG+RjfTTtdNy8J3GbUxrHi/i0M6IAu1U=;
	b=q0XNaJ5bHeklpntY5NobV35t7yueHgaqcInbyJBnW/nF8Z7toDn2NET/edwR/jp8WLl/
	 PkbB5xIXo2abpZpvVfZ/YDEWsMZzpLxwwC5izQrLbdWaGmTPIpNZZlHqekvvL6e4eTiQA
	 0Jx8tGc6bMEdT5Qpc40jfyKnx1aPNbJaStS+EEBQI+XCydLbahI2X04Z6UaN1Cu7jxO5I
	 +JSNzCCvn5Gvi29GBNPNd3foPx6HsWbFJzFjdIupvNpTBV1xULVubHQB7nygLPcvq38JV
	 x1gOUNhJjsBh26EGrpJwuWiIRfVg4b0KGqxDOPzucXunARAmgoE+QrUwriLJmnoLq8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LljCbO8n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37666606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LljCbO8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA76E1F0089F;
	Wed, 11 Nov 2026 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369291;
	bh=egYAq4IGoL5GG+RjfTTtdNy8J3GbUxrHi/i0M6IAu1U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LljCbO8nnlPMpP0pxjeaaF+VjOoj/5mGAjosed8ehGhV5c12HHcQflcY8Q9u2Rlnp
	 PwSt3w4avE5NR+AYM1e7w5ZSaf8u6TeYZ9uMtxJ0i7EsUxTugE9DsC3zL/FvDdd2Fw
	 6YnXoRru9sQksfWmaqZRnXnSFFuQOlgeP/SqqEv4UQNr/BAA1jzD2BAhWDRtBEx0Lk
	 VuFkA8yv3Ugx3dmsbclQMTs6wxOlmBSHz8ovbFYiwg7+eGYKxlDvnwvL/YvukM2yaR
	 aJ9I+tMVIBGMvUPYcyXsec6t3rOJhPi72FHAwfn46rvY5SoIRlBROWWZDEy0oE1oF+
	 YpsCALNsQNQpw==
Message-ID: <sashiko-outbox-208244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] perf jevents: Name the metric when a MetricExpr
 is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111034333.2019831-2-takano32@gmail.com>
References: <20261111023448.1970467-1-takano32@gmail.com>
 <20261111034333.2019831-1-takano32@gmail.com>
 <20261111034333.2019831-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:54:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> jevents.py reads each field it wants out of a JSON object by name, so a
> MetricExpr key that is missing or spelled another way leaves the object
> with a MetricName and no expression. Two different failures followed,
> neither of which named the metric: the rewrite in _read_json_events_impl()
> raised AttributeError on the None, and a metric that got that far reached
> print_pending_metrics(), whose assert fired on it.
>=20
> Raise in the reader instead, naming the metric, before either of them can
> happen. The check is not inside the '-' test that decides whether a metric
> takes part in the rewrite: a name with a dash in it can lose its
> expression the same way.
>=20
> Two smaller changes on the same path:
>=20
> - An architecture standard table that does not parse now carries the
> [ ... ]
> includes metricgroups.json, whose first pass runs before this point, and
> the string table built from all of them: nothing that parses a file runs
> after the output is opened.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111034333.2019=
831-1-takano32@gmail.com?part=3D1

