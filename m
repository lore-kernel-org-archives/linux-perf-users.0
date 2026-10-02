Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60091470E81
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932391; cv=none; b=albDAePJ2HOXfjcGVNOybBK4n42NZU0reiGaP8a8tA/AOiTmXtlhs9YxWx6sgjw0XG1sUUwiOJO1hr6SqM1IUdwn+es2CzdizeVW+5DNhAkjeS5hmi8VcoxkRMubm+pFcPgVdnYdO1YHTjiIMEIZPFCz5cD56XwuMwNDNAwGSsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932391; c=relaxed/simple;
	bh=+Jg7bFhphteMnkg57vMUu0OTwK++Cn1NtKJtB/E7w1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBo49TBRxbWeEdWOEmHT6yXnFaooMQKmDY7UXCJlxP2GXJdotn8CBhXuph6Fgwsvwql5VtmvGsUS4nV+cHyT3AFoUycrng3pAxEa8EFGz9ektIXzp7P5sWAbVowemj/e1i2DUU3GyIbJ6vRuUFdhmDEWWC9bDvKo+8F2gmNx3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOZr1ceY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOZr1ceY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DAA1F00893;
	Fri,  2 Oct 2026 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932390;
	bh=xf6QoQ//e6WSFivzjM92IEJXEpt6EG+9ak3JhK3PSyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOZr1ceYCQ9i/jALOZkuX84JN6cLwDtBR/EZxCIuHEHPk9ixLCEW6C/ExGtTAdntW
	 N/GeSjoVPPYWO9qQ3FklNOBekPw/IPznqElsEdakz25arwtvfy3pyfsiFqy0N3lqGG
	 t/MAtptHP7qxYq8iZThkGnY5tBCIzuib4m8Rzhzl1uVCVnwjMWSZ6l9DBhP3M34pDV
	 qfJkO86D8cd5m+z+c+iyEZkB98gqJk2HJO5PdvPpjhGqAcr6pgksC+a+aHnmGGWdaz
	 sW3rdCwQDh0iULiZ+nE3WhtPU74bh/DTOY19h/udebS0erM8u2RgfNSEYwlIFw4B/r
	 77xNsVL0bmR3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/9] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001185400.2754753-8-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
 <20261001185400.2754753-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:09 +0000
Message-Id: <20261002091310.28DAA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Now that --progress is being added for the stdio case, wire up its
> counterpart for the browsers: the TUI and GTK ones present progress of
> their own and there is no way to turn it off.  Install the no-op
> ui_progress ops, the ones already used until a backend sets theirs,
> after setup_browser() installed the ones of the browser in use.  The
> phases are still counted, nothing is shown for them, and no second
> option is needed for it: parse-options provides --no-progress as the
> negation of --progress, report.progress_set saying that it was asked
> for, report.progress being false both when nothing was asked for and
> when --no-progress was.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001185400.2754=
753-1-acme@kernel.org?part=3D7

