Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC6F390226
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404489; cv=none; b=jdiCbdDDXFmIY3sLoqNf1yhKg9VEEP8ml3B2aMppJ5MJgkmJnaY4QqEgjrPZwVfTZ6d3I1RqwRdvrM6dlTIYceqCWzw2HSQlehS6xpp53kFpGLYd5ExC3xGu5e+YGPIWlB5U1zoPy7LwWWyTeHTM5uOyDTB1rLo7leRC2Xm3c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404489; c=relaxed/simple;
	bh=eibHxD/DnzwzeOdL3X9SnpjaTLr0rxO4r6AJM5mzXL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ec0+mH6cxfSxjGnfH8Bu31GprkEmew73UYRBi5NDfDTaEEOlKbrnohVy0GQKF68Td3wITXbHWzWeCw7Qh7N/vdLkGxaDt/ksbbghPp40ihJ6pAK0Ovgd4os9t4YoAc8HcauJED7wRiD5s5fxGVMVC9Wc7b5lGEgb4WJXQYay6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us3aABNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us3aABNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19AA1F00893;
	Sat, 26 Sep 2026 06:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404486;
	bh=XWgJfeWcA/9dE6AXX3Bt+7FUbZH0ViXvxAR889U7AY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Us3aABNruF6ToOqSvGO6gjrZrZpYUtrkQ7imUabCiYleooM0RjGjUTX0JA4HkDd3X
	 Q2yxY5S+ILMGAwCeGYyxTDVoJOwfwr3b4K+d7C4ruyEuR7RUwkggG25yNB35YlzvU8
	 F7yZxMOt+4nLc2oafpmRRGGbTq1A67/NQJ/Lh7+uMIEUqlXx2lnN9bOB3AIZ2WyH4n
	 GjcY4GEWH9e7DXvOvltPf1DUO9A0CMGmuOni876NPluO9WGoQ9QFS8obdG0CCbmwgI
	 TuYfSaljJURlRCqsK6/saaFlU4CWJPTgzssHmBqIgQUC7oHYBcMxMY/m72GM4z9eK8
	 O2yiM6QFBhGew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 31/49] perf python: Port task-analyzer to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-32-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:34:46 +0000
Message-Id: <20260926063446.B19AA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port task-analyzer.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/ refactored into a class-based architecture.
>=20
> Improvements compared to the legacy script:
> - Support both offline perf.data file analysis (using perf.session) and
>   live trace capture (using evlist.read_on_cpu), accessing
>   sched:sched_switch tracepoint fields directly from sample objects.
> - Automatically disable ANSI terminal color escape sequences when --csv
>   or --csv-summary is enabled so CSV column headers ('Comm,',
>   'Time Out-Out,', etc.) are never polluted by color codes when running
>   interactively on a TTY (e.g. as root).
> - Sanitize non-printable characters and leading CSV formula characters
>   (=3D, +, -, @) in task comm strings.
> - Emit a one-time warning to stderr if sched:sched_switch samples are
>   missing tracepoint fields (such as when recorded without libtraceevent
>   support).
>=20
> Update test_task_analyzer.sh to invoke the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D31

