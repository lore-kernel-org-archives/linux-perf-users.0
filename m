Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0043161BF
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627955; cv=none; b=pM723+0W9laj1Srkt7wJ3MWEB3PYHZecZ0SR0oxx+H+HKAvalpRNzc7ZEaGDQynslNlO7afIyXFAJApU8PS2zXvGO+QCcGm3X+Gzr65rRn44D3oMrNKVpvRuqNB1GQjaZygFTbcshD1UkKv09Gh8iQ1lgh2rgHbGf7hnXY7ZSOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627955; c=relaxed/simple;
	bh=Myu6lP1aXCcBrCpTrusC/jB17LTN5oRGt44rQPHkIho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sm495LLUQiiKYwesQJBEDgSnPK7L+DoPqImKE6ZTB0uF2sHLTlf8Dpxuok6KLuu6LlAzvHaKe0hJRoBI9HDFE+JtfNyYXDfWlvaEpef5UX7TJTAWzIxAkd6rsPs6jvZhM1ZwFD0j4ugf0ANKS9lGrMVg6lwvEyeigt2Copu06fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7+RryIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7+RryIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192751F000FF;
	Thu, 17 Sep 2026 06:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627954;
	bh=UAmTHDT8e5KFs06qofU9uvzqa67hk2tOXx3Lc+mW4LQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7+RryIEoGQ0AqXFh8jR1jLR2NXJJj0nPOXxxgVhqBt0Hjvno2LKUZu+uWDJHMXIt
	 x4VF2vsFSkDtMmAROm0eXPvJ+fDOMop2Gyj6ZUjNVK9AktxjWL5feqBZ5D8ubvye1U
	 a/QLA2PZyLHcxl7VmASp0IW4jWyQej9el/FTfzp939gFpFhwVqsgkVLsO8El0QK8tQ
	 qdGTHnc4KYPGOOm0BTYG39JJaxMMxJN74TxTbsTiZ6xQynmixzbEw9K6S3Rc3DhQUV
	 FyGZ6DaXZvV3WnBMx8yIVO//Zwd0q63Ki7KMCKw+J/8nUhPAniUGf0CcJ/UdWySmI7
	 aA+3BFEcT9u6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/13] perf test uprobe_from_different_cu: Scope
 probe name to PID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <80beb357d1eebd77f99982fbf4741e8b5fefbafe.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <80beb357d1eebd77f99982fbf4741e8b5fefbafe.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:52:33 +0000
Message-Id: <20260917065234.192751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The test builds a binary in a per-run temporary directory and probes
> its foo function. The directory name is unique, but perf probe derives
> the event name from the probed function and the group name from the
> binary's basename, so every run registers the same probe_testfile:foo
> event.
>=20
> Running the test concurrently with itself, as 'perf test -r3' does,
> therefore fails in all but one of the runs with:
>=20
>   Error: event "foo" already exists.
>    Hint: Remove existing event by 'perf probe -d'
>=20
> and a losing run's cleanup goes on to delete the winning run's probe
> out from under it.
>=20
> Name the event after the pid, foo_$$, so that parallel runs no longer
> collide. This lets the test stay in the parallel pass rather than
> having to be marked (exclusive).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D13

