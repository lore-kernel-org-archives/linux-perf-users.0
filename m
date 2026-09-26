Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDC35F5E1
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404162; cv=none; b=tVnmVntuJIEcXDXpXSa4pBiC0BMuS3bSkqWt7zCVOp983PFai1IRjO4jlmeZqLpRnLhJX9Gavd15EMCLZcdAXfrLQy80sn4B6Im3a1SRYD0MM1Wkw1tnimuoBuGzDsOBkx8tOJm42joAAteM93TmmKoeMOqJ1c0UW1HnEOLaVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404162; c=relaxed/simple;
	bh=rUQAxzJ8zpwhMn3WBr7/usETs/+m4SqjCTDT6jcyRIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQr4seEWphafbIyw41fE+msDIxtx6fyXcYiY5vS7P7ojHUfhZ7Y2KwmOYdgNj+0TzswF7e+eizs7vwdUtif36rYf0oPaU4je+MXKIQmnI2Q2QmZf8i/9XMli8UUYEXDpf2jrnxIbKT4Bud1K6awfKZJn0AL2Ar1pdP/6n5/cB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ2/k6vJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ2/k6vJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3701F00893;
	Sat, 26 Sep 2026 06:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404161;
	bh=g8mRYM832Ev1T6qYyJ7TkSVjK+Ld+dnOThP5CXD9iv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQ2/k6vJMtQJS/GSeNtcyeZYr4J1zlDnhrbLkUe5fFY+NwzpRZCx46BR1Vsik72rr
	 nuEEXW8nud4D09pBQFSd05zzHM1OpzAbTR9p9sAeRuNe7h2uytFwHi5MKjqwwXqKFp
	 G888W9xiAyhPGqRIy57yF/S8IBy1aW1SWJi9EKkoHfL6pDN2iqoW+G+InrmEt3bF1l
	 bGmaFdP6vqIrh2sVd0r/3/QU9qYBji34dU47Ut7m8dTJNXOAZPP6O2SMZrcdPflBI3
	 Jsegv/G6jTsMoTP+1LuuvsAjs9RDQ5Eke0Q8L8iJP1SveFHe3y+S4mgBjnprNVMwIF
	 gAKS0UiBuvWUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/49] perf test: Clean up mypy and pylint issues in
 shell test libraries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-13-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:29:20 +0000
Message-Id: <20260926062921.2B3701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up mypy type errors and pylint errors/warnings in
> tools/perf/tests/shell/lib/ (attr.py, perf_json_output_lint.py, and
> perf_metric_validation.py):
> - Fix E0606 (possibly-used-before-assignment) in perf_metric_validation.py
>   by importing sys at module level.
> - Add type annotations for stack, second_results, collectlist,
>   get_bounds(), and main() in perf_metric_validation.py.
> - Avoid assigning -1 to list[int] expected_items in
>   perf_json_output_lint.py, rename shadowing variables, and remove
>   redundant lambdas.
> - Remove unnecessary semicolons, use lazy logging arguments, specify
>   exception types and file encodings, and initialize module-level logger
>   in attr.py.
>=20
> Also update tools/perf/tests/shell/lib/setup_python.sh to:
> - Avoid x-prefix string comparisons.
> - Export PYTHON and resolve PYTHONPATH and PERF_EXEC_PATH from
>   BASH_SOURCE[0], ../../../python (for nested test directories such as
>   coresight/), and the directory containing the perf binary so out-of-tree
>   builds and standalone perf python scripts work seamlessly.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D12

