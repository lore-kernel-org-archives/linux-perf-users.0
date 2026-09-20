Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830A304BB2
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882795; cv=none; b=JXYkoxkqQloqtTCbHFv5HDFJVJyIzbB8dlaGB271XbREkzub7DIoQ/4ovX17cPSDCBwvGrBOg3gTkkArBbpeZgYCc3SxVMFOn8Sd6wgQUa7gaSTFSwTIzhmClxrDKsIhDsMAy8T8y7hIA3wN5QniAKc6FOmFEMuxkdU+9FCC98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882795; c=relaxed/simple;
	bh=rEnb/Mru9zuLvXMBKgtmj19/EWNChPAZ9sWc08kO9Eo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fdVOk18f6GoIPkteaHcCE3iXf4PtQgQz2kFBd7cltiy1BLfYIfp4d3mUFzkesTPPMLdWANimPaoMzZwtIFpGXZPgKk8oNSnDNiyHTU7VEm6JvYfsHOfQbn6WYYy3mKEnJPGOMz+mbQCdGUyp271S3JodEq74xcoULWUMYisdGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVmRaOo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVmRaOo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F591F000FF;
	Sun, 20 Sep 2026 05:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882794;
	bh=isrdv0Ti0HbLgAd6suDOIa61+DDI2rYseB6luulX66o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVmRaOo1nDsdH+81/zznfRw6IAiZLTkFmVVcx1wpSdYvFdNpXX04TWaZQH+mY3GRf
	 BhSZ5G6kq7eBGDxeCoZjnxvSCLf1uxZ5NOHRGkBJFXF2uPCl08Cox8xvD0Mnd036U/
	 zR+qZQaf7q45LIUXtdS4FKrpoBbGr5QymvqHswcWdSpzIarY2H4u8ofsz43c/C23G1
	 ua9B3xKvqMxftW0Pv6FeSwZx4G5uyAHt/s9EfXtLllm5ZKW14grKFmPLS7MtpRrNUB
	 XwMQlMgJOYHDyyfHMY73kf02MNZSSgKjHk0tH5PihUxyxv+Dc4AZWSRcjf454HNy8u
	 863ChKFTc7fUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 33/49] perf python: Port wakeup-latency from Perl to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <82f565299e985e7af24e9031d3d9c62a513897c0.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <82f565299e985e7af24e9031d3d9c62a513897c0.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:39:54 +0000
Message-Id: <20260920053954.99F591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf python: memory leak due to perf.session reference cycle
--

commit 6aadac5b14d7ffc3e11063c58b8e5957fe0a1f3c
Author: Ian Rogers <irogers@google.com>

perf python: Port wakeup-latency from Perl to perf module

This commit replaces the legacy Perl script wakeup-latency.pl with a
standalone Python script using the perf Python module, bringing
improvements such as division-by-zero protection and CLI options.

> diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wake=
up-latency.py
> new file mode 100755
> index 0000000000000..6113fa92b5010
> --- /dev/null
> +++ b/tools/perf/python/wakeup-latency.py

[ ... ]

> +    def run(self, input_file: str) -> None:
> +        """Run the session."""
> +        self.session =3D perf.session(perf.data(input_file), sample=3Dse=
lf.process_event)

[Severity: Medium]
Does this create an unbreakable reference cycle that leaks the perf.session
and its associated file descriptors?

In WakeupLatency.run(), assigning the perf.session to self.session while
also passing the bound method self.process_event as the sample callback
means the instance holds the session, and the session holds the instance.

Since the underlying C extension type for perf.session (pyrf_session) does
not implement Python's cyclic garbage collection (Py_TPFLAGS_HAVE_GC and
tp_traverse are absent), this cycle is invisible to the garbage collector.

If this module is imported or WakeupLatency is executed multiple times in a
long-running process, could it rapidly exhaust memory and file descriptors?

> +        self.session.process_events()
> +        self.print_totals()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D33
