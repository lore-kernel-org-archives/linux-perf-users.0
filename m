Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EA377AA6
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991218; cv=none; b=F8vm0aDj3P5PRhX39r7Rk9rCUN/ghM9MsLCGfD/pukAL4PSzPhLOGERhm00Z1G5dPEXXM5N4XNcqK0Ucvn8wdpDRfY4oE+qq2B43CKnkzJyLxykdXe5lKe9EM2zvUlwH+R6CmOTdVhFMax6IgzuOlCLKMokz1ejUbRvY3OqZChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991218; c=relaxed/simple;
	bh=a1hP8ukxSJUeCoz25vo78Oo23Vod/s4HzCrpJnH95j0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ngVXPRSGUYJ6VygtQE2X5RcLkx3jGC7RK6Js62v5ZffjjHAu7AX1LhN8QEMUi0Fwno1WJD/1b+//GDs8T9/Em80jXZeJtATXl81YTlAWaXnUm0AZTasPvQRhcKsoRUrLpl6bKUsbb9oBknqJGAnB+/XSWmjTAnkD7ws9S7A82lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr4gE4O5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr4gE4O5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65841F00898;
	Sat,  3 Oct 2026 01:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991216;
	bh=7AWc3nLy8NDyuraw5zIa5kWmlmGDhWunvbVyH2K3qK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cr4gE4O5Jq2+hGYYiZctpfzpHakGiiCJr6AC+j51Btn33+coDASMP1FM7+qTJt7Px
	 JR9Cr5B1Jc/DosE4NEqGxAEAX4gHXZUCwY7Brvc2+0QyDTAYFu+AXODg/1/Q47g23H
	 sycHuFOA7oJ6hBdCDbtiezRjSz/809DoxPSTEyfxJpCqdjLmvzmU6btN6TytfFr0Sc
	 mqNSpVYybVrmsSD3++lhI1uXERWsuS80VN0WRXculEIGiYVT+Mz9quOaZjrLysiFHz
	 pKiV13jBDpoBmJBtdWe3jSgYzE1Kquf1eDVovdkw/QkZn0tcuSUT/HqDdyrL3Yjk8k
	 vwPH236NJA3bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/13] perf python: Lazily copy events and samples
 from process_events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-4-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:36 +0000
Message-Id: <20261003013336.C65841F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When perf.session.process_events() delivers an event to a Python
> callback, pyrf_event__new() previously copied the raw perf_event into a
> 4,160-byte union perf_event embedded in struct pyrf_event and called
> evsel__parse_sample() a second time to re-parse the sample against the
> copied buffer.
>=20
> In the common case, the Python callback inspects the event and returns
> without storing a reference to it. Avoid the event memcpy, the duplicate
> evsel__parse_sample() call, and the large PyObject allocation by:
> 1. Storing pointers to the underlying union perf_event and
>    struct perf_sample in struct pyrf_event (using PyGetSetDef descriptors
>    backed by PyMember_GetOne() to read fields through those pointers),
>    shrinking struct pyrf_event so it fits in CPython's small-object
>    allocator pool.
> 2. Borrowing the event and pre-parsed sample pointers from
>    process_events() for the duration of the Python callback.
> 3. Checking Py_REFCNT(pyevent) > 1 after the callback returns and only
>    allocating event_copy and re-parsing into sample_storage when the
>    Python callback retained a reference to the event object (or immediate=
ly
>    in pyrf_evlist__read_on_cpu() where no pre-parsed sample is passed).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D3

