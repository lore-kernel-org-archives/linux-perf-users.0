Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC381E9B1A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648712; cv=none; b=WMU5Za7BGaqkn3xM8/17BV2moKpVTvys0+9fwnQUtmnwaqifZ+fuJqHwTtFczUq8r30HCiNDTIxk7ruy0KvUrqRmt/ejmlJQGSz4acVcvQJw7X4AS6zvv9vRsxPpW+uuT7cQ+Z4rGCt4wkiSQ43yo4BCwFfj5Af+ss+EREir92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648712; c=relaxed/simple;
	bh=XeNwiZGHJ/3bfin99uygj0TLWUMrQJX6QtrtYc8PAr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQqgtl3nUpiLxmvhI39hAyACw+W/kRcNvJuFBGsazf0yHyEhsE8tCu8uGFhzjPz78YT4OQzKWFa0lM1Sr09oGaYn6XFvtBncxRMlL+e58tJSiOC9qH7c8Csrw2lSD46hRol0ffFMfTGUa60iRCqTmJiNoZyTNksM4V5Gpp8hMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVA1WgN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVA1WgN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99C71F000FF;
	Tue, 29 Sep 2026 02:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790648710;
	bh=XeNwiZGHJ/3bfin99uygj0TLWUMrQJX6QtrtYc8PAr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVA1WgN52rnXbw32KdWbyiyPA9EoP3XMubdz5JJg4WpDa+xt8NxeO4MF5T18AaWGG
	 vusz6scKhOjcy+0Qs/4akG8ohsZaTWWz402ScsIFmQozznvIFgjwCbr9aSnTK3W1VI
	 YdiHvs0buKgsv/55/ewW1l+f57KkmtNyAAbfhCqoMCKIh8YZ+Cq2uGbsrvrxOIBNMz
	 M3osN100TWo1Ya74ZbPypKy3/d2ubH7XBWAUriG3kgK/QxBJMmpT83P9hKD4YxaWdI
	 J4SIJmxy2j7gxpYhWYUdC5M4Ri7R6lapdY5N7lxHccpG4O9gBScM3O44criqXMlDtk
	 1N8FyP1WGKUXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/9] perf python stat-cpi: Fix live mode signal races
 and test flakiness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929021913.56010-4-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929021913.56010-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:25:10 +0000
Message-Id: <20260929022510.B99C71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In test_stat_cpi_python.sh, 'perf test -w noploop &' defaults to a
> 1-second duration and can exit under heavy parallel load before
> 'perf stat -p' and 'perf script stat-cpi' finish starting up. In
> addition, the fixed 'sleep 0.5' before sending SIGINT can fire before
> Python finishes importing the perf module, opening the live evlist, and
> flushing the first interval.
>=20
> In stat-cpi.py, register SIGINT and SIGTERM handlers before calling
> _open_live_evlist() and pass flush=3DTrue when printing live output so
> redirected stdout is flushed immediately after each interval.
>=20
> In test_stat_cpi_python.sh, run 'perf test -w noploop 60 &' so the
> target workload stays alive until killed, and poll the output file for
> 'cpi' (up to 5 seconds) before sending SIGINT.
>=20
> Fixes: 4425182d426b ("perf python: Port stat-cpi to perf module")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929021913.5601=
0-1-irogers@google.com?part=3D3

