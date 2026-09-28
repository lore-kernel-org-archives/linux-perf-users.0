Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369544F6468
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616119; cv=none; b=VqqpOZfLEwo2i+z4CgTQOhwNGAmClFLrnN2a8lR231aKsnASkkjwRPT/1uTE4LagVYAR4RU1Aghtvl7R5UCfs9oz/NEhdYQFI5FX6GEaD1H41LAgAxlw5n12gPhhBPrZz+wMajGJXCfoBhAKT1L3oxprAok77YHEZnbnmXFZl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616119; c=relaxed/simple;
	bh=wtd8V9C862z+167slTsO6ubKEC7VjkzY+7bTvx1TIfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eWAF/ON1cdRlhoQxJ0M/371DzMwB7RL6fgnTmjzROVXYR9pdWxyfp59Fd02zeJ98uonRBFP+q24A0iMz/9ifsEwbfftZII2T1wxDpom80G0ut6fg/7sE0LlK5vHtmTNCD2L8aagtxsS+WblKmV+6gwPu9+qovmoxN3leDcugqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG7DJo5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG7DJo5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3051F000FF;
	Mon, 28 Sep 2026 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616109;
	bh=UoBXH3SZWmaz7c5xbfMbMw8PyNCWBYsZK/C86Nsja9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eG7DJo5Aljw4wgelDaCct4BvlOdN5n3lbEBMvxSoC4FejJh4mQhcWdvw05uTZL6sG
	 Fp6cgb2K406/sNtU05n6+R0In1sasenjQNDOwH20CoebZtWoap4beXnDtqofTQMPIq
	 2J9yTVmjiIsBHt4KY2SEq8Lu5wKmzulXPzcG1JGiKeQ0RLSH+y/eSNAy7a1sfnjVG8
	 9wEsb0h7e20dGHILUDv17anWcXRml+Ef2p6bg9CWtSnpQT4akTPAp/qGGoIzRvGu1x
	 gjgYGcAjQCPGaKG9/fVkznae28t17OAFI/0eT9pdLM4tvsVhu7ys87c8x1NY6ILnHK
	 tBGlAMd1EfpKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928171244.2437283-3-acme@kernel.org>
References: <20260928171244.2437283-1-acme@kernel.org>
 <20260928171244.2437283-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:21:49 +0000
Message-Id: <20260928172149.8B3051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: ui_progress updates are
> only shown by the TUI.  Add --progress, installing a stdio backend
> (ui/stdio/progress.c) that prints the phase title, percentage and
> counts:
>=20
>   Processing events... [42.3%] 317M / 746M
>=20
> Phases can be nested, so the backend tracks the ones started to
> complete the right one on ui_progress__finish(); that requires
> init()/finish() pairs, fixed in ordered-events.c and the pipe and
> directory event processing.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928171244.2437=
283-1-acme@kernel.org?part=3D2

