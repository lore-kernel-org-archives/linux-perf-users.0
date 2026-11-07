Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048886;
	b=WJFr8m2BVYFLrDj1R+u1Gn1WPPKNU6yY6wTa+3JoL//EZT/o1wTGSiO8o0CDbcm55Eo6
	 SM+x52f0qy5tDavJ9GCvarHvC684f4XXE9RsuIA3NAjB9oIFnzUzlGYZTngroZ5Lp0va/
	 wZfv5UjBP8P4ijxqrNJKY5tA8EOIIHxFQLCAluhOYASvWQeQuFDnboqifpJsPUNE9acgP
	 HXm/ogb+5UXe2MAhaMiLYXLq1bZSG00VkYovMOWT4xYd9juwYQfPNn2rbHOGBThe/slPL
	 CraZwCt1+Z/IjzBueoLAn4Fi9sHlYfeUl2w7q1jpeSGWR+6sdxuMoqvWw6PC6fYsvYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048886;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5qnevHOp+Aj+f84iY6R0igUKclW+nX6FAaidiCGV+E0=;
	b=j4SCt7iud6LZuJ0uctw356+j8ZSiHOhqt9TV2ULVzWaAbCXIi91QS9V64Thr+/3BacQx
	 P6v6A/dtzhkh+qaPmwhfg4Ydowvr58Nbfss+eS2yspBN6taohdfhZDk55xxGydP6wR8n9
	 XW7P9W6WthmxQryy+L5dcULoS35x+zCMOfLvsKna4S5yRaAzAiHOz9DeCnEcNHCBCCltn
	 jfDxLLmEjmUu6nPhx2zV+Mvad8Dwxnn/XeXXP4r1JFqqly9ZVPjm4YCMRBw4tmytgWrOw
	 D7qYR+cDgR45pTZWYP0k/haARUcFoXRLNhBuPL5EuOF4R2+B+nURjoX0wo1PyEUwcsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAnIRS84;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F3606A32E
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAnIRS84
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5AF1F008A1;
	Sat,  7 Nov 2026 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048886;
	bh=5qnevHOp+Aj+f84iY6R0igUKclW+nX6FAaidiCGV+E0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RAnIRS84NQNutdzPF5YUAomYSrhlq/kakl9Fdf2Y+hU8FBnI4X+NDoPPbRaxb1oH5
	 nccpuiP2BmsXuVZpcJ9iorKiwMTiBwyeahBMsmkzyCi7CFPMtYbFZDdMfrZvN5S6Vy
	 kzcZFZVb+Q7pMqeOWvFPApZUIdtA3/w3Tjp2F97cacu0vUgUpaYPHilqTzLmJatW0e
	 QxYXden4gt51vke3n6V4wXYK4Q6qkKIV4QCyQkr1XG+ck4uLtDmCKNOHqWytud3gTf
	 h4N5a6IRNmpOg+Pau9rpgW1lohMEYsGr18E4ZnnFUtWikB9jXMUDyl+sydT0xFINwN
	 bRsa6bq/yfzGQ==
Message-ID: <sashiko-outbox-202830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/15] arm64: dts: apple: t8122: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-12-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-12-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:54:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> Adds the PMU nodes to all t8122 devices.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D12

