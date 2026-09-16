Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB683EDE7E
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541980; cv=none; b=cYyvOYqAHTLsibcZk/iGAEMCyeJJ6kmc6w/XCHIc5z/IzMR9VGmJiCVtOZzcY+0wUf2cNtbADM9Bi2wXBdjG80nObOw9V1MfsVErBPuA/48awu9rfwDsypRBwjaKCGx25LFfpToUjhoazzWFAwZ97aM47qYtv3QZlvyB4q5JxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541980; c=relaxed/simple;
	bh=ph4nNjxV7p+r37Hj4q04NRSzOok5xmJmxesaMaA07Rg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qaaNCGI+CV2VzHWOKA9I9MVb3LDy0HYVI8zwstskRqGyCUp2kP/rUBDKcfENXYmMwmYNlnUm3GV/NpimFZJZ5QPCRfrwTd3wHykn8omuHxG8bf/SYwqDHXx34cXsgdxFVXdGQhb2dEP6gpiSz+AKqXToSt0bZC359ayMIZAqUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIAxm27J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIAxm27J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA0D1F000FF;
	Wed, 16 Sep 2026 06:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541979;
	bh=ph4nNjxV7p+r37Hj4q04NRSzOok5xmJmxesaMaA07Rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KIAxm27JE08W7nPAsdJrNt5D9FdIEGBRb1SwfdUTZgiFNImH6QaTLw2N6HB2yCxDZ
	 +X2KatpZ/QBCRtu6oz9runNuxi10RYGnD3vMV0NHMVS2lPRU+bV2TzkBejHhhiOcb5
	 DsYm61MFZfsIm6zz+EcDySdM39YAGoZchEdb9HK3r8AHDZpxP7UgRc+LeiuSB9nzy+
	 XchHf7Fu7I76L28ogX16xck9GSWsPIrEQ3ZmxLaEpPaHaF8ll8Ar/TqG8gGBA9+gcg
	 AkzZodECR9GmfjQIGNoCbEBV+14QxwdjuMRXkD0apL9hAeqv+Ql+ECzJlvSiBQFoV3
	 cj2v5Xm3EAZ2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] perf Documentation: Add tip for hybrid event
 merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065248.3153556-5-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916065248.3153556-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:59:38 +0000
Message-Id: <20260916065939.0EA0D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add informative text outlining the IPC imbalances associated with
> merging cross-hybrid core events like cycles.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065248.3153=
556-1-irogers@google.com?part=3D4

