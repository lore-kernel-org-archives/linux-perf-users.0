Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC32F3D332A
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767961; cv=none; b=NfD0tAYzC39Ll2eZ3D4lbxz2IbWiz8S32ItsbezT2JiJlo5GRW6HNOfcy/fpdN5UulpRhDTE4vEsRhpy9Gmc9tzSq8+Z4z065JBtSXcFVqD9f6SAwG2fiI3rhEY1CIGBX2ykaR6s3SsFWNAKAirpCQI4dtw6zFtFHLVPHOFif84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767961; c=relaxed/simple;
	bh=F7nJrYCMBKaO9dc8nOsS8t5lHuTntBGZGGjRDJ1kf94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pieD7mdsfGZbnbvEEXsZD+rGa1fTYhtcFHtZFEXrMyybSQkrss8/ISPfEdey89zgoMly8nRhN0nnMAZmvVO4XhzPKLTYay6n1x54sMB9zgx9Nyz1KDzPSuiYy1v+HFont0rsFaGdsTq/Tl9GSCFpbcZCws9vH6W2WBy3S27LQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib9jAdjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib9jAdjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FA11F000FF;
	Wed, 30 Sep 2026 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767960;
	bh=4J/qoZXA6dQAZUeBXjXHF7sr7qTrj85y8H435GmGbYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ib9jAdjPSY1vCm3fPuFdebZ1CY6ywwoErV8IPr87N0ID1R8GVOpaHt/9rLwd9Bd1D
	 VGc56+62uYRpYP8e6+0s9DS//ULgdiSY5dMUIxuJ12oF3r/lItzOCo4o63yi7YG2RU
	 qZIlREEG5JdoImwPcS0IdPMopidMIG+oW1nGYOzlvIoKE79LkkN/D7TVexQZxh91k+
	 Kjm1b0K0+szUrgFKy5Rm77DhxvC/k3zfXVitMo57nZ5cLt3Fx2UxMQy3CvsizS0ra2
	 Mg9NWO5QFrHyNk6R+HWD44sNddmIoXXDVZOZV1zHQ583pi/qnDKVLf4Yqnle9IBstU
	 GZMZ5rTDoJ06g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930112454.16331-5-acme@kernel.org>
References: <20260930112454.16331-1-acme@kernel.org>
 <20260930112454.16331-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 11:32:39 +0000
Message-Id: <20260930113240.36FA11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A perf that takes forever is hard to tell apart from one stuck in a
> loop, and there is no way to see where without attaching gdb.
> perf-stuck.sh samples a running process' /proc entries and its progress
> line at a fixed interval, and with -g runs gdb (perf-stuck.gdb, adding
> the perf-die-chain command) when no progress is made across two
> samples, printing the DIE chain a DWARF type chase is stuck in.
>=20
> It is a prototype: the plan is to turn it into a first class 'perf
> stuck' command.  The process name is resolved with pgrep among the
> caller's own processes only, as root an unscoped one would attach gdb
> to the first process of any user with a matching name.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930112454.1633=
1-1-acme@kernel.org?part=3D4

