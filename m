Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA68472F81
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299014; cv=none; b=ER9hBLVfsxkzJ5nIbREmo+ZCv9ebnatvaLh6A7KiCdYPvTkrPsJ6YlWyRN5XyUAAJIFiSef+PbNyL7Hdo58g/nMxFlKgSw7wcOJja06/ncy1J7HzuSj924+PYPpPjfg69xFLzHGhxJPpJBJEQxEaLfQFkujDeHOOw/HrSTuld2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299014; c=relaxed/simple;
	bh=jgAIfCf3cv0gECmzUtBGEQL5+TPUrp8X/vwGcLE+2UY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4NpSMwnz83YYGIeSnE5d547VX3Ezfgf9TVUiuIUDfI+AK74VSnNJfR7y9cAfchc0k1giYo16MK8rH0mrS6oRuSmt5Yyz8+48q5QzT7mVJEp6Ej3INYad4L2YnBujyuzS886BJO0Es9z2tOT7HwbSt14IFX2CDt9/Fjw2POIwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU9ChsWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU9ChsWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB491F0089B;
	Tue,  6 Oct 2026 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299012;
	bh=RY4NdtXMcGdcmz6wCn6uOOks7MGNFa/Cn+Egq2u62Uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GU9ChsWowDVdOOydt3tk2qMlOvCf86WpFYNrg0MlrbOHBerLwdSNHmesaZN1sYh++
	 WpLpO2qY06HnmYIv+9kaP9Jxunumo+Vbo35+PsCu3BkOpm3sUKwTsNH55nyp1zPHSv
	 sklbOKYVBCPah68njgJa0OP51Cqpyyx2MmaQd1uCDtMmgKjiyFExWEqB8bJlmoE+uc
	 PAfjcvikwK1OqT0DTebxvhSbmxGSXklRTSgYNzFXGm4Yefl2z8UXJ9EkDnIyMGt9uj
	 PnTcjn4JGR6hiT91ZOsqok55es2go/GdhJ8101S7Y2P/5JIWJ3gTc3C33c+JRhAFf+
	 4lEmoQBINH8ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006145729.3028247-9-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
 <20261006145729.3028247-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:03:32 +0000
Message-Id: <20261006150332.BFB491F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Add a 'perf test -w false_sharing' workload that hammers one shared
> struct from several CPUs, shaped as a TCP connection: a read-mostly
> identity (five-tuple) shares a cacheline with per-packet rx counters
> (the false-sharing line), a second line has packet-path private tx and
> congestion control counters, and a third the connection config.
>=20
> The packet path runs in the main thread and up to four lookup threads
> sum the five-tuple and pull the config, reading one volatile shared
> instance directly so the accesses are PC-relative and resolvable by the
> data type profiler.
>=20
> Data type profiling of the workload with cacheline info:
>=20
> [ ... ]
>              0.00%   0.01%        struct folio +0x34 (_refcount.counter)
>              0.00%   0.00%        struct folio +0x18 (mapping)
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006145729.3028=
247-1-acme@kernel.org?part=3D8

