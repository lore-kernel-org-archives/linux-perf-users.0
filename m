Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6696D36C9E4
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490005; cv=none; b=oeu/+ngNT7n3a/cDcj1foQbFYg6DJQ+VWEL+i+ATHhMp3JNSEO/o9xGIwiRvGvL9d0gf+T9GsFIF6ngHgA/mSKONnRUclAHVnOuVy+oOUm7bbarCaOR3qxOx119JQBUr0hnK/IL8+c8XGd/a8Vp0HdckXpOUUlTivXbnHUJmhY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490005; c=relaxed/simple;
	bh=RpWvF5fpTsPUTXEY79u5HFHm0BqpyLg7UT/qqWNF9Ug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GUlNxx/KBt5DZ87rTvLPYNjRi/X2cZiSOq6YPytx8ouF+Nv/i0MOcywfm1VJmtgpOYwhDeRiFS91djDEy9fZASXnhsaRIVp/hidZvcebfmK7wvLzgXbO+dpETlEyOV19cqyJqgG09tArLg+A4C8FbXnNZAfkmiKSi6NoPREZLPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxxNbF2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxxNbF2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F401B1F000E9;
	Fri, 22 May 2026 22:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779490004;
	bh=RpWvF5fpTsPUTXEY79u5HFHm0BqpyLg7UT/qqWNF9Ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AxxNbF2YuuVJ+k73ps7MOAtc07ILb59258mvuatghkhaAROi3wc0Cby7Mfg36fQ/E
	 rFNpyxQ2V6Hd9vgz59VH3RtzRtPu9Bo9C0yBMQ2d7ClVGeB0sPxj8brVNxYGO/D2dB
	 Mrlc49TrALrHg1EgyrOc09KEqYHBmQSGNeOeLKclm5Oa89vqA6KnKX3xrf6lpERyXH
	 vUGL+wMh66WQUPva2SCXIgT+T9l2lmDw0nfoRJJgJ/5mwAA7qNHK/Y90kiy0ytlu1Q
	 vKu17TxaCFQOEQEUVGtm2jNjWLomMJ0VJAzHnDdytz0AgrGyFezRO9iUrTYV5P2fEs
	 S2569lNQP3tVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/23] perf evsel: Add reference count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-11-irogers@google.com>
References: <20260522220435.2378363-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:46:43 +0000
Message-Id: <20260522224643.F401B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] An unbalanced `evsel__put()` on a borrowed reference in `evlist__d=
eliver_deferred_callchain()` causes a use-after-free.
- [Medium] Python bindings for `perf.evsel` fail to protect against uniniti=
alized objects, allowing trivial NULL pointer dereferences that crash the t=
ool.
--

Note: The format of this report has been altered to a free-form summary
without direct code quotes due to recitation restrictions.

commit 29ffdfbf96c8b534064a1d8cc8529de746fdc594
Author: Ian Rogers <irogers@google.com>
perf evsel: Add reference count

This commit adds a reference count to the evsel structure, primarily to
improve memory management for the python code. The python wrapper is
updated to use the reference count rather than cloning the evsel object.

[Severity: High]
In the tools/perf/util/session.c file within the function
evlist__deliver_deferred_callchain(), the code now calls evsel__put() on
sample->evsel. However, sample->evsel is assigned using evlist__id2evsel(),
which returns a borrowed pointer to an event in the evlist without
incrementing its reference count.

Does this unbalanced put result in prematurely dropping the reference count?
Since the object remains linked in the evlist, this looks like it might
lead to a use-after-free when the evlist or other subsystems later try to
access or free the same evsel.

[Severity: Medium]
In the python wrapper (tools/perf/util/python.c), the pyrf_evsel structure
dynamically allocates the internal evsel pointer and initializes it to null.
While pyrf_evsel__getattro is provided to intercept read accesses and
prevent issues, other paths seem to lack this protection.

For example, property setters like pyrf_evsel__set_tracking, class methods
like pyrf_evsel__str, and pyrf_evlist__add appear to directly dereference
the internal evsel pointer without checking if it has been initialized. If
an uninitialized evsel object is created directly via the python __new__
method, could this result in a null pointer dereference and crash the python
interpreter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D10
