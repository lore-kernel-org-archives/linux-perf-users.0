Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610135;
	b=Z/VnUhMmGVk+HM4tQM6Guk7JPsVNXMWOQy9S8Ik+fHFYTqkXUwxSki612edrx/1cRIMD
	 c0E0vonuHDEbchSarQn2VY0xei+1Z8zax7zH1ADUTQ3vvGkqNlH1ZybwXlaCvLBJa4adW
	 oAuZjRCDz88KLy9FVsbah+qpLCpgjNUIUeZC6R9z1ea7hKlfYEPKba72fERhv94P4sIW7
	 sxFpcQI3MLmx514cyLSDB3LGl9aAiTY2ZhAzZOw9wtGWijEyyhOPl4V1dve7XiXy3NsUS
	 OoeJ4xdKZ57oZ1OHkpgsK5Uf2oP59wbpraGVmqbnbXijG0fu2q44nwZirL0+1jYDdkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610135;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XWSIyiOCCz8E/9eIm4cAC8qZiIXSXtYrrU5+VvzqFFY=;
	b=RQoqJw463Qz0pKwOkDOJ3Ku15PCuLjFYVJC4rhNYUrt2VeWinmxEDtizorn5kRuaUgqD
	 aISLRQKdwXXf2M3IYh6ulLKkvMlddoOZ4I9wcQOtI+j3FEl+mfIjBlqLUneY1GIjnrUot
	 wEMC95TOj/syCo9JaSLeLOpzeNwERYa09PCkPKW1zvWyOmh1fD61EO6S8Wc91phtpPg3i
	 L4gxR1w2svrP8b8FQzeRPlozOHD4nKYVtAe4kYnDPiQafnvdtVR6TK9u6wKOaZpt3iV1p
	 Yrk3G7PV8kD+FWeR9nxkgXFjla+aoZHE/h2HUyMvHqeVOntFsJ/SwcXdGpmS94R7JgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LO4Bays7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36B606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LO4Bays7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF621F000C1;
	Mon,  2 Nov 2026 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793610135;
	bh=XWSIyiOCCz8E/9eIm4cAC8qZiIXSXtYrrU5+VvzqFFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LO4Bays7l7SgQWVm6H34+voExV4n6SETNg4sD52BPMw7n7CIDQcbOdnCG7A2I5ORr
	 viKJXjc9qW1quYHp+vfessEacQNq3xmYwa/yCY/xNJGYYREKtGGzcdDD7ojZtEdz1N
	 P3wiikknScdzRShX+0FZuUAMVBb2Fqb4OD881PRVnSGMFRHfXm3X8+ubTkRXeWlw+M
	 zVfouoP4RMWbevV/+W+b4mJGV7uRtGvbFN/8B1Uo385akRiUSUzdSABn9JMw+n8op2
	 /8MBUuPlXzG/cuUjroPsRrKPxYZphDS1AVcuo/SvujXjzU28R1v0MRMMa1H9lwadxU
	 yGDhR5zBxS8lg==
Message-ID: <sashiko-outbox-193150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf: arm_pmu: Accept a per-device CPU mask from
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: Johnny.Fan <johnny.fan@cixtech.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102084153.3975282-2-johnny.fan@cixtech.com>
References: <20261102084153.3975282-1-johnny.fan@cixtech.com>
 <20261102084153.3975282-2-johnny.fan@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 09:02:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: "Johnny.Fan" <Johnny.Fan@cixtech.com>
>=20
> Synthetic platform devices created from ACPI data have no fwnode, so
> platform_get_irq_affinity() cannot tell which CPUs implement the
> feature and falls back to cpu_possible_mask.
>=20
> Add an optional CPU mask to the platform data and make both the SPE and
> the TRBE drivers prefer it over the firmware-described IRQ affinity.
> Device tree devices have no platform data and keep using the affinity.
>=20
> TRBE must also pass a stable copy of the mask to
> request_percpu_irq_affinity(), because supported_cpus is pruned as CPUs
> are probed, while the IRQ action keeps a pointer to the mask.
>=20
> This is a preparatory change: no ACPI device carries platform data yet,
> so behaviour is unchanged.
>=20
> Signed-off-by: Johnny.Fan <Johnny.Fan@cixtech.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102084153.3975=
282-1-johnny.fan@cixtech.com?part=3D1

