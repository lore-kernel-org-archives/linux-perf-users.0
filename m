Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87741A563;
	Thu,  1 Oct 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871286; cv=none; b=E6qNFDjtKiQq+PR/4ebWL7KWTT03PkR90eHPsfq5SJDdSJXdnsNgEkn8hOWpU1jz3MgN4oJcUINqV3hexUXfObXaaGWgU9auUaAsW0mLVdxyemXxQ9cSJakMsw1TDk0nimOTzYOLirfkgFjcLpxQfxFpmZNYfHlnonBwRSvEJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871286; c=relaxed/simple;
	bh=4/XEJlCshPEE1UZzYkFFLkH8Ye5gLd/8WTQVA7ft79A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=doBlqDnNmcMaPgUHtpjj71SMA22YZdZiGbYJ7S0IrSKuSw2MtzLAy5EulAFTyj76QkhL/Nv+Ym8/DZgc6pBg7lq+7nh6MQdgfCOWeC/nx6NwG02nJJv5uVBAIeGx9HeGSWgFyR9L3LSrExR61wZM+XG247g633e5H7h7+qT1syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+WiUn2g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+WiUn2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F061F00899;
	Thu,  1 Oct 2026 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871285;
	bh=h0/rt03vJwp2ZMgygKhy8tvF5bxosZr/J/M+lDpSQZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+WiUn2g5Ppu2ovTPcF37elAC1wiNn5SHXdlA3sLeEuMMwzTY781CtLOM/6UipRQb
	 SycJ6ZYJdP50olDjGkHZnFBCnJblMfv0oBMx2r+BmohpiSzXJBcYnd71e2/AK9V853
	 2aDorT4UUGFMKUeFD2lubV1nmZwqLD4mSkQUgucdRntCsRVfIiWcoO/3o0+gQLxeUH
	 Ee1kpLXsL909G8jR1hcrNS+0T1frP5IOL7kovzthaDmR0UAws/o02AHtGjcVG6g4r4
	 LKMGYEAnmsgv0SEPXAZlGoI/jo9w0f4tMRREwo5gEh8ZlcjRnzrZ4bMvcityeWswf0
	 WfP0LOzJfak6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 5.10 1/2] perf tools: Fix a asan issue in
 parse_events_multi_pmu_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001160114.801948-2-florian.fainelli@broadcom.com>
References: <20261001160114.801948-1-florian.fainelli@broadcom.com>
 <20261001160114.801948-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:14:44 +0000
Message-Id: <20261001161444.85F061F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Namhyung Kim <namhyung@kernel.org>
>=20
> commit 66c9598bd8916c6c1319d0100ac916cac89d4b0e upstream.
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
> Link: https://lore.kernel.org/r/20230331202949.810326-2-namhyung@kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> [florian: Resolve conflict in parse_events_multi_pmu_add() where term
>  initialization is located inside the PMU scan loop in 5.10.y]
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001160114.8019=
48-1-florian.fainelli@broadcom.com?part=3D1

