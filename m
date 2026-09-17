Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83871265621
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610718; cv=none; b=snbsnzNqQQtLYi/trYdhMDGpupcUrOs/b/a52L/dCo406gKHFP7P5i0S0OS6jBCRIEphMmG/1MZc3YHABfYNFDFHhl52GvC6BqPlE8cam4wOEQ5oJvrb6M59bwde3l9VyfvqdjwZUmE0e3MS7UZDmv6q1Yakqta2wrrJm/Pfu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610718; c=relaxed/simple;
	bh=TvVje1nagSpbeXHQr56kmtPdrcsaX/4JlcXCyVq4nho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gu+xFprX1Kd4rm68DxdBMo8kL9+eILaQVBLksdR7sHefyns6olWURE1TaXHov7MfiSQXnO05ZXZvFFq1tIiWaHmyWnYbXUJ0PB4XIPnaf12OL7zmcr2lOtOk/z3cPu+sxbxhWMjpjTTEgM6u6zMr986WhKPLvWR+IQxSkBb5FWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2zTNPhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2zTNPhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64321F000FF;
	Thu, 17 Sep 2026 02:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610717;
	bh=TvVje1nagSpbeXHQr56kmtPdrcsaX/4JlcXCyVq4nho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R2zTNPhKUt5L1yR3sDAPryV6/fQ2sChFsrBzkgK/imM9TZddPb7ps0tBcBixol2mj
	 lnudvBkRCWNNYjb78utis/80tahXXu0oSeCLwdrOMmDLTCIEdB8u4jdkzJNWMpbrCv
	 D6MsYOyiqs2ZXtImBYYUCIWpSgdKrXTrZwpYF0Z5QDE6k3E4/vRmS09sQShUTN2Sqy
	 awPlHN/WBop5c1kL7TmmmADcwn+GdguXB+uil8onFXpT7ew3jtonr3GDSXd4WnXIOE
	 CFUstuZJhnSMq1HwarcKbrShrYa2GIakFRatcWvdkUQBQH2yW4Kmyj2t0USp4qrsqR
	 PBICcfxoubUiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] perf/x86/intel: Correct Panther cove data source
 snoop states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-8-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:05:16 +0000
Message-Id: <20260917020516.E64321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> For Panthercove, the snoop states for the data source encodings
> "Prefetch Promotion" and "Cross Core Prefetch Promotion" should be
> SNOOP_NONE instead of SNOOP_MISS.
>=20
> Correct the incorrect snooping states for Panther cove.
>=20
> Fixes: d2bdcde9626c ("perf/x86/intel: Add support for PEBS memory auxilia=
ry info field in DMR")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D7

