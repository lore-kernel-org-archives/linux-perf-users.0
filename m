Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C728505E
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272205; cv=none; b=UQPN0awMonxEjmhzOtMb/HnDMxvTuKTBGJA0trUiUagTgwObMBRyEVjk8gwTasiUYnrYs8TgWN3oUtHgtWX0uXS6hHncuegwIyO3q8RBdLEoH1LrSVSLO6qFRPReAC7ZBrD+jnBCfC2Pj+b2dxv/AKWZlzcep2JTt17MnYHD1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272205; c=relaxed/simple;
	bh=zsBOctPdA6Mx62pY55efn38jgMUJrhoM3J4JwXo5+jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXYw3XMMjtXIIK2cAaxd39NDN3BgFqIX9gpJSNQvBimTysDd8/VHxZJHarGIQkqs0KKNNCO8yAuecdrhFwF/E9HWVj/BLcKEcExZEy37S4H1pGBQmS3on+D1Duv8wD7rOfMUSKpBkRA+A/Z8/SAJImdTAPBmjc+1sqRVIgyRRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLlSu+km; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLlSu+km"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396791F000E9;
	Fri, 21 Aug 2026 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787272204;
	bh=YOAZZrcfdOfWdMpLyOb85eBfeaneGNHIbgYEKYbGlWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lLlSu+kmxxEEH6dBGIKTMZ3HburdUyHTHrmbQHBuHYWG/VlBUGbJxP/1LYRSZEnln
	 vnfm5M4rbTvBUmWghb9AxsQYo4+Mm1nbhVdMI1FBiwzaUDZkESB0SM5+AxvWVOgqN/
	 /I9wFKqljMXNQ0eLQyXV3HSY67z3vyxIBWfQ6LIalj9/q9338eQI98Ea8VcOwu/i8l
	 sgAxKS8HKTr5G+zuZluZGGzkchitjKRIXsULmWzHUeZeVm9MlYqXZOPxIMakhK/v8f
	 qZH2oug1ESZ+tcKcRigaOQ5lO1dEjyvj4nj9MDN72ngQOUDeMBVNMVt8IZW9DWkpNy
	 IlYk7FPgpg4xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821001819.162277-5-thomas.falcon@intel.com>
References: <20260821001819.162277-1-thomas.falcon@intel.com>
 <20260821001819.162277-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 00:30:03 +0000
Message-Id: <20260821003004.396791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Add memory region field to the cacheline list view to help users
> identify the memory region to which the cacheline belongs. The memory
> region field was included with the introduction of support for the
> Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
> Nova Lake architectures.
>=20
> An example of the new perf c2c output including the memory region
> field is shown below:
>=20
> Shared Data Cache Line Table     (112 entries, sorted on Total HITMs)
>        --------------- Cacheline --------------      Tot  ------- Load Hi=
tm -------    Total    Total    Total
> Index             Address  Region  Node  PA cnt     Hitm    Total  LclHit=
m  RmtHitm  records    Loads   Stores
>     0  0xff1b7032a1e8c5c0  N/A        1      47    2.25%       50       4=
4        6     1024     1023        1
> [ ... ]
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821001819.1622=
77-1-thomas.falcon@intel.com?part=3D4

