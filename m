Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D61D5CFE
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329266; cv=none; b=r0pyCcZHGrP1xwc2soQzE7md8OehFQ2Lx0uRGMlex6WUWuIdmT8YfSbcDivlbSejtVvi6x6os3Kk1x7Nu1m2hIP+b9HKmwfxA8jrOWctBrjmusaTCxacmD47hdM7mSBAk+ariM2i1vPpcbQaySv5H8UukM+0rEBmB/BDHBJhz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329266; c=relaxed/simple;
	bh=VU6JbaR09IbhZK1nhjbajS6yNXmJWx2u8Y4dZHMAP7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E10k9huyCqDGY5iAK1NdYxgjTkSz3iEjRgrVyLoIkdVBKkEqUjNO3/j6lVWvJKCpVptA/D/E0mHsNeRfoIOhmbdnf+1l61aUeu3DIV0xuTo9rne0iPkML6AZ91AhOz2EffbwUlJjSEIFOGTLQirKiKNL90erTanNqPO4NT6gLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAZzwao/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAZzwao/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A091F000E9;
	Sat, 13 Jun 2026 05:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781329265;
	bh=/ukzWwQhrnwiBH5swfEoo+TMnQBFKWoPg5m4Konn7U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAZzwao/7zERZU+aEEVyTVJYywS3ZQoAJOJNvrftzwho/mWeyepVAAeGlYLPHrt9V
	 PiCB6eLQa5+ExhuKgZhyuF7yVPPY7Edg/ANR7Yu8Xq+2vB7b0ugBahApQNS3CIicX2
	 JpoAchDlS7xv2hLa+2p0VDuUiQz0tVCxklT+6n0TvQcWDHMCqpCMf66MCF5mJ4Xz8a
	 T3FjpwH7P9i124v4Ez5JeIrL9kLWlZ9wXAMu5Vis9lNUIz4HFHZ5AcM2D6ZdpLALuc
	 mpWBr1W3kuNe/Ty5uUEJLvMQPSmv6RpsbCq19dssfMm9ja6/NilgpclyAL2QFtfZvF
	 1RRSeTFD5Lz3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 02/20] perf python: Add missed explicit dependencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613052722.1424093-3-irogers@google.com>
References: <20260613052722.1424093-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 05:41:04 +0000
Message-Id: <20260613054105.49A091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Type mismatch in `PyArg_ParseTupleAndKeywords` format string cause=
s severe logic errors on big-endian architectures.
--

commit 5f219de4611e34d146886cd2113bb847c538df26
Author: Ian Rogers <irogers@google.com>

perf python: Add missed explicit dependencies

This commit fixes a missing include of pmus.h and sorts headers. It also
defines PY_SSIZE_T_CLEAN for modern Python 3 C-API compatibility and
introduces initialization check macros for future use.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index cc1019d29a5d0..98a8dd9b673de 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but there is a type mismatch in
pyrf_evsel__init() that causes logic errors on big-endian architectures.

The format string for PyArg_ParseTupleAndKeywords() uses i (expecting a
32-bit int pointer) for attr.sample_freq and attr.read_format, which are
both 64-bit __u64 fields:

tools/perf/util/python.c:pyrf_evsel__init() {
    ...
	if (!PyArg_ParseTupleAndKeywords(args, kwargs,
					 "|iKiKKiiiiiiiiiiiiiiiiiiiiiiKK", kwlist,
					 &attr.type, &attr.config, &attr.sample_freq,
					 &sample_period, &attr.sample_type,
					 &attr.read_format, &disabled, &inherit,
    ...
}

Writing a 32-bit integer into a 64-bit variable on big-endian systems
modifies the upper 32 bits, leaving the lower 32 bits as zero. For example,
a sample_freq of 1000 would be parsed as 1000 << 32.

While the missing specifier for idx is fixed later in this patch series, the
type mismatches for sample_freq and read_format remain unresolved.

Could the format string be updated to use the correct 64-bit specifier for
these __u64 fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613052722.1424=
093-1-irogers@google.com?part=3D2
