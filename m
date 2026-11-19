Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110877;
	b=F7mSVNzkKqPssWvup29zspQRN92K9H5ARm2i5l7gt/MC2MthvplVf02/EoE42REU2blg
	 z2u0Uanak1PaI1Ve3j68HVkv1KoaCkiNjCXFKD6HlCNd2QtTP5+KkPsk2vXNvVMNLTsvw
	 GyOv1shQVoFC+GO7hixedK2z8Y2f5m6oExgp0m+iikQUvOHrZu7P6Ygx+8cLbHrR3Pxqx
	 1IrJfrNtta1Jk9aeJOkPyWUIfL+s9iE7pIWd/R0pwmj+Snf08k/Gar5pSGNio55iXwBxT
	 jbioYkUEkBsb2c3c5n95TovXnMEX2K7bbrZj425NMpO6GvobyA55/EOWOck83CCrj5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110877;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jqZvBIDdZraIQLbqgnelavg5sJ6qPuSk8maUzk6kekk=;
	b=XRBULoKvHnZRIuLaSNBz7TsXjPBlvxbPfuysiZaYlaH1AOvGaBfJGpMiIWBgjZ3+C5F9
	 uitlgstglmG/uDvHo6uZFG4lHArhnyfurG1yRI9YMLub8bc1JnZTcnKeYuoX/Dh6BYrh5
	 wpCzQy/nvPHhp5s1IAlx6C94pO7bqqQm85Ny++10VfY9A+Z6JuRj//7Jc3aC7mvIfc9WC
	 tcjUwJlZ7pwN7qxpGiim+WarFBdHNR19KUMT6Kkq63wt2mKQ452jvZV5EEP7nmQpd+tUm
	 PcqvZx7xEBFZCn38G9/ptjjYsKMeZDbWLrpFBCzJmpRi5bihJQYitSIJeWa7tTCmR+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mobyHp4A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6A606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mobyHp4A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CA51F000C5;
	Thu, 19 Nov 2026 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795110876;
	bh=jqZvBIDdZraIQLbqgnelavg5sJ6qPuSk8maUzk6kekk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mobyHp4ARTKupnqwAOWCrGpKfHg5fFh0c6Q/fz6bUMp1IsMbTShopfBaoucrgT7zO
	 2vQyLzNKkJuvfvhI9oqGDpxOItU6QLGFlREfMiF8Qtl/wevwNBG8B68IgRyiD9QkWH
	 6UytNHlU4wGpt/cdAClc04ERlfO367KZ7FMU+ogqZJpIpFfYdVfhxiCpbj227GYxi3
	 kcAdCO1riJlQFZ/7ZMB9sYKCfheSDh1iXKRIyU4xac20xw6X66DBPsvQxrrTw/SQEj
	 zFwFI0odmdGR4qh1AQfW8ZOfIdNcJ5mouE3Nn0Z+c2vA3i6dEZiC33Idxzl/TezOmG
	 8wN4kgqusjXjA==
Message-ID: <sashiko-outbox-223731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] MIPS: CM: add CM3 performance counter GCR
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119-i6500-cm3-pmu-v3-2-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
 <20261119-i6500-cm3-pmu-v3-2-c86410934b51@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 17:54:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The CM3 implements two programmable 32-bit performance counters and a
> 32-bit cycle counter, controlled through registers in the GCR global
> debug block (GCR_DB_PC_*, offset 0x6100..0x61a8 from GCR_BASE).
>=20
> Add GCR_DB_ACCESSOR_{RO,RW} helpers for the debug block and define the
> control, overflow status, event select, cycle counter, qualifier and
> counter registers along with their fields, as described in the I6500
> register reference (MD01189).
>=20
> Each accessor comes in two flavours, as the CPC ones do: db_<reg> for
> the local cluster and redir_db_<reg> for the debug block of another
> cluster through the redirect block. GCR_Cx_OTHER.BLOCK value 2 selects
> the debug block in the GCR, where the existing _BLOCK_USER name only
> describes its GIC meaning; add CM_GCR_Cx_OTHER_BLOCK_DEBUG for it.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-i6500-cm3-=
pmu-v3-0-c86410934b51@mobileye.com?part=3D2

