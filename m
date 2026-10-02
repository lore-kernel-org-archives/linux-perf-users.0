Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B634D93B
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932380; cv=none; b=iMId1lqF1v5IOKg8zquRtgKiFES4aDVeKc+AyJ+eoMWg9uP0jGl9HONBUQUT+/fuzbVqL1a6BHaKPaGhJVSD8D1sbTVcGulh6uhYkG0owNSMYL+LnBg8vsCpsxAzkDif6HvHs/oXtEVrvHEOPUju2DXNH/kpN3iNKl9OERGhD48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932380; c=relaxed/simple;
	bh=FcxZB56B3Psj0HAi9rHR9MSyaJU5hyed+/oZQIL9QvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZWAoHFT4OtcVNddEqZbZ6Vo/+unkyFkkeX2gEbFjD/Fok83B/7GDMG4WSgOaGu2o1dQ4Xtu9PC7EOxGaWE12wX7RP5xu+gbQ/SKU+mt44stvYC3DVzU4Xc2BiZ+6P484BXqYAM737m6t7mjCMLcO/9ZaxfMcF/BEqN/N+CSbVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ899HpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ899HpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AED1F000FF;
	Fri,  2 Oct 2026 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932378;
	bh=FcxZB56B3Psj0HAi9rHR9MSyaJU5hyed+/oZQIL9QvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GQ899HpP4MyJfrfcbvYeeByd+SzqigM5knccbcp+o01skHlkeAsb8c9SCkViAdoVt
	 aOdlksCAhqp/lDZ0YM/3+jAxlJ1GsLMYJ2omV+NKrEIeXJ5MotRoZCVPVKlUkiJ0iU
	 iNTe4DdoSKy8a5Jc3DhuPyS1r++gJIZyjkW4q7Sf0y7U5bpRM1nGPaY5QxtcHm0NOn
	 JT7DEtF93r/uzNBlBCV1uBJy6nUKMVD875jzCzPtZNHNzZu8fluv4UWomZneEEATGW
	 Ug/kSfHJR3j0V1V9svEWEavJqNVGdnz4xMR2/iHAsIlYdcHeRciHTdWf6SpkW54/pd
	 hAfrgj6GbMp+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tools: perf: add perf_input_name() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stephen Brennan" <stephen.s.brennan@oracle.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001182004.1160406-2-stephen.s.brennan@oracle.com>
References: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
 <20261001182004.1160406-2-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:12:52 +0000
Message-Id: <20261002091258.49AED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The perf scripting API does not expose the name of the input file being
> processed. Some scripts, like flamegraph.py, assume that the "-i" option
> will be passed through, but when perf actually processes "-i", it does
> not keep it on the command line for the script. (This could break some
> scripts which do not expect it.)
>=20
> To allow scripts to know what file they're processing, add a new helper
> perf_input_name(), which returns either the filename being processed, or
> None for an unnamed pipe.
>=20
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001182004.1160=
406-1-stephen.s.brennan@oracle.com?part=3D1

