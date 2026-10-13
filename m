Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC451CF7C
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923038; cv=none; b=NXZJ3XnrBb+3GC2zZKh6/5FNxHvfFq/DustwyG8GSC98Bf3upHFcrWilHAxEuLQliqahb2Uu/r8KkryxVQbrv+DFTjAh9cOwyWE65ZA6fsBhjJxdMJpU4kWqdl1F+gnJVh2gsvo3LAfddqeCX1qtP6Ks0caIwJn5ZEKSkQEByPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923038; c=relaxed/simple;
	bh=qZIEfRCqT9iaUrsXbKU7shlfcBaER20Bwkg65SOD3gk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uXgqewTh4fUngm0zRcQHSNN6MNq9jUGwnzCKyi1TLUhbVJO95IjsyduHP2n9x046jlXUVTkGSs37jfhjeneyQkpWmiRwWHuGY7b0UZGVwOicLr+JBqvVYOaTEVPyiUG+vZcOMjxdMnume/qA88PRFIMoBxn7/UZJ5Ui/c9G5iZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTWiApBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTWiApBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471E81F000FF;
	Tue, 13 Oct 2026 20:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923037;
	bh=22+Xx/PqFlaPVXiLMuHSCDq6aARqRtl4TaCPZoH7fgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTWiApBcXqW1U7j13/lm0OMuBcdAQV/cJJQMOS3vu19AzpeuNcUkZNnVsMbTs37U8
	 yUD+EIKd8xHjH0Tk5lxCodKyDt78swOWd/5P+DRHwGOIa8m9ougRQWa9I31hEQVlph
	 k3OO3bBph08v6BBDrAoEigVBpppzlFZ4qboOufRiX5epQFE2N41gio+h2nGLfiUWpd
	 8ntMNMADO11mnWk1Oes+koCCgMpYlzlXwc20oyovYmyFpkE/GCStk6509XAkIpMbgK
	 MlWmHCsOEUH1llKpf0n3sXjc+MbN9AZu0jOwwg38T881RxZf2G4HFKYX95mi7VE+Xw
	 DpAWApKqvdzOQ==
Message-ID: <sashiko-outbox-170454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/19] perf tests: Introduce a 'needs_mlock' suite
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-16-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:23:56 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Each perf instance maps one ring buffer per CPU, all charged to the same
> per user budget set in kernel.perf_event_mlock_kb, so suites that map
> them need to be told apart from the ones that don't, to later have them
> take turns using that budget while the other tests keep running in
> parallel.
>=20
> Add the flag to 'struct test_suite' and a DEFINE_SUITE_NEEDS_MLOCK()
> variant for the suites using the DEFINE_SUITE() form.
>=20
> Shell tests run perf, that maps ring buffers, so they are taken to need
> room in that budget by default; the ones that don't map them waive it in
> the requisites, a comma separated list in the parens ending their
> description line, e.g.:
>=20
>   # perf stat tests (no_mlock)
>=20
> "exclusive" is the catch-all that keeps a test from running alongside
> any other, so it runs alone, in sequence, and implies every other
> requisite, "no_mlock" waives the default, and more keywords are to come,
> each stating what a test needs, till the catch-all isn't needed anymore.
>=20
> 'perf test requisites' lists what each test needs, reusing the listing
> routine and taking the same test name fragments and numbers as 'list'.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D15

