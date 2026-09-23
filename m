Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4238DC71
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187618; cv=none; b=R/QbrRiT5wECYPqAzTmzWhrAwR0zFrHYMmXxhyTZ3+r40ey2j+cWNJypqei06Rh4/8pEoWDfg67rSuMcBjHkwXOYsLWLJP1aVQrXbT16rei6iyuhdrSIoebcx9ajyVyhyyZsjqA1iHZS3FIKk26FjRUg6E21qvNhi9x8+DXRDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187618; c=relaxed/simple;
	bh=5KNjSDQfIFM8coZru++HqGBD1lomvSNNBp0FypohBBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z5/aLxpQRiE++bCtgqJg5Vi9MW3k0RcMwXBDynM42+ONxXNi37Po+5NDvDvNUMRhZ0FdixjxpF8C4DUBMLmw2YVuNZBFgTich0T3z/vWxaY9ohRkp9t89VBRrP8IV3cZrFe20xTOD0lCis8VXBGTr+EBYWimAkwYc6pvD8hQboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuyKpoz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuyKpoz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2881F000FF;
	Wed, 23 Sep 2026 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187616;
	bh=naKzVDATCdw7VePoNVy58NGbCuhDTdfOVh8vP1Bt1MY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GuyKpoz7gxoK+YGEVZFquY7cQv50SfNPpxJ5a5JddpxwRoh8bV9NykiA48zUakArp
	 dCHPRVbPunZSPb9tHrCMIJSUY4Jswn2f9twnzE6J4UnJU7F1vFGp3MXtkf2mYABBly
	 eVFDSmTVINeQqH4B/iH+OYYPYEc4EsArP1KTDI4tILPCcHvSFIEjp+Mv8rRfvIIeaj
	 oQ1KOS7zZlLzcxITETxjRLHFNrSxqrzSCccG8D5jQn8pku+PEEqNlo0OhIPv+w0yAe
	 mA7bs+irY5eNiAVWh1Mll7Idn2kxXRyawUrMKGXe5tqiBkelLivRnsnMJkp9gbp0PB
	 Er3uldcFQdD4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/49] perf python: Improve perf script -l
 descriptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-8-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:20:16 +0000
Message-Id: <20260923182016.8E2881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add module docstrings to counting.py, tracepoint.py, and twatch.py. This
> satisfies pylint's missing-module-docstring check and prepares these
> existing standalone scripts in tools/perf/python/ for the later commit
> in this series ("perf script: Support standalone scripts and remove
> embedded scripting"), which updates 'perf script -l' to scan
> tools/perf/python/ and display each script's module docstring:
>=20
> ```
> $ perf script -l
> List of available scripts:
> ...
>   counting
>     Example for counting perf events.
> ...
>   tracepoint
>     Example showing how to enable a tracepoint and access its fields.
>   twatch
>     Example to show how to enable a software event and track
>     context switches.
> ...
> ```
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D7

