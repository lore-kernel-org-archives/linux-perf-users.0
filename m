Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578C54A7D0;
	Tue, 29 Sep 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710010; cv=none; b=Q7iB4osB4zwtcy4th6veXbqHnTHs0QTPGFnfl10FbKScR4uLCjdBkHeAFVHI6gjLc1GpIrrQ5kYMKqUTba+EN1WBblCnPsEWpa0kliM1VDcRbJcw2cYABX6D2MBtsRUYoRphuC1imyZa5gvxJLGpXnByYt6LR3zuAAAVBPNu0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710010; c=relaxed/simple;
	bh=vIytM0bSrSvlOpspfJLA9lPCg56r6wyLT5IliUH7Brw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/ke82mGM4HoQlpASMQkfSq+ui5rlQXg+qMvxmQjkh8d8AXLRpNS9UkkjfmmA5Ph8zv2TOtQxEGFertocJ1QUVyDYnmifTeRn6i0pemz8LUf3XomKRAUYqVhagmHKVJFl5SXgo90EiwM3YSMsts8IxG6a0k4i8F1Ibnw8ocf2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGa4r9ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGa4r9ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206631F000FF;
	Tue, 29 Sep 2026 19:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710009;
	bh=GtPDZlzOUwrO+1RJinr6p359dFR2sI5vkzijrv2qoSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZGa4r9ze3aJJN+yUfFOlDXemrBLFmetUjaaqRhoC/SVZ2gTMzcMqHHIeNRTx2tfZc
	 g5vxEDhQlUDDWnH2j9WriqL4lEgAZnoUg868FNDNGu/t/HYNQC5qAHdt7v/m09CB3d
	 0eG5IVLumtSFsM+J4GUs/JlFYC7YB6uuAazslLuUiG2KRGCMGq+iDr1n1BjK2SSHMG
	 Ah8WAVeIHNvr0XHZjqGxYSE29ULZetLJXG36FzHHb8gLPFwSeD9CZ8D9h4flP8jwog
	 1BSyJGT7/A9q8rtTYEpbthPwqKOslouEwjt8NLnXSsnGXRH72N4l7eLaNfvwnOqjxt
	 5b2K31dKPLZFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.1 1/2] perf tools: Fix a asan issue in
 parse_events_multi_pmu_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260929191834.266354-2-florian.fainelli@broadcom.com>
References: <20260929191834.266354-1-florian.fainelli@broadcom.com>
 <20260929191834.266354-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:26:48 +0000
Message-Id: <20260929192649.206631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Namhyung Kim <namhyung@kernel.org>
>=20
> commit 66c9598bd8916c6c1319d0100ac916cac89d4b0e upstream
>=20
> In the parse_events_multi_pmu_add() it passes the 'config' variable
> twice to parse_events_term__num() - one for config and another for
> loc_term.  I'm not sure about the second one as it's converted to
> YYLTYPE variable.  Asan reports it like below:
>=20
>   In function =E2=80=98parse_events_term__num=E2=80=99,
>       inlined from =E2=80=98parse_events_multi_pmu_add=E2=80=99 at util/p=
arse-events.c:1602:6:
>   util/parse-events.c:2653:64: error: array subscript =E2=80=98YYLTYPE[0]=
=E2=80=99 is partly outside
>                                       array bounds of =E2=80=98char[8]=E2=
=80=99 [-Werror=3Darray-bounds]
>    2653 |                 .err_term  =3D loc_term ? loc_term->first_colum=
n : 0,
>         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
^~~
> [ ... ]
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20230331202949.810326-2-namhyung@kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929191834.2663=
54-2-florian.fainelli@broadcom.com?part=3D1

