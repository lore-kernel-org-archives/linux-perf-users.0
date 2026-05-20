Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916E34572F
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305498; cv=none; b=Ik6/vB31s3g7iwH7OqTTbe141Mf1Udf7kMECpgapoKDFqG3shAQ569C42jUlnoy2oBWHIrTch1RS9eUtM4hsaPPbJ+bcqbsx3KMNSaXIa2U0NBT+qCP4kufdn20Ph/eltyPdsnbBkoDOLNpPZdeJlJcrc9yX8ytZ4j8wmVt5ZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305498; c=relaxed/simple;
	bh=7VhUKrVPTa1/CyF11GO6xvqY0pCgTVAfSkCBA5pdTOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uVGsPrrXfnTK7+GOpJTJu7882lyeOsGOc+DN5S/bb2WiuL2j92lQvRMOv/UlA80HMJhDNGIxaO3zdJRXIjFAzSNI/4H6F6h6fxOUlscxjisTi5jXjXSBVrmOaDi88oWFHD9NutroaFJAL38+p1IK0+asrMBTJ2r5G1hlrygZMh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5YV46u9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5YV46u9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3CA1F000E9;
	Wed, 20 May 2026 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779305495;
	bh=7VhUKrVPTa1/CyF11GO6xvqY0pCgTVAfSkCBA5pdTOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5YV46u9x7hPN0Y8c2MW6s1I4U0dq0nTLHLgHtSPc49iHoMC/DM1Xghai3sk8nSeb
	 OPSHhmeFwtrUSDLePed9XrIutQ9FioXVR8YvecjGonFGfhkH6uyOVxTaV5mjqCFons
	 4lBg5x/XZB+0W/8nHevJdC2T7rxc0sI0iMHZb/YNW1DLOtHRzwO7Co15caO5gBwnAL
	 hgDLN2WZPy+Zc+VZguUAaV6hIPPbLA1r3/e1wRUQM2S4LG91CRU9/4jSOFhR0897gI
	 Rve+vn/MGrW696mEx+o8MPwfO769h3mfPGH/oOXnT2khQ0sHiuBnWwjSbkJFTmUF8j
	 jI509ZNg1wWCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 18/32] perf evlist: Try to avoid computing evsel
 from sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520190538.142018-19-irogers@google.com>
References: <20260520190538.142018-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:31:34 +0000
Message-Id: <20260520193135.3C3CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to 'Remove the redundant evsel paramet=
er from evlist-specific handlers and structures... simplif[ying] the API si=
gnatures', but the provided patch does not remove any `evsel` parameters or=
 change any function signatures. It only updates local variable assignments=
 in three files to opportunistically use `sample.evsel`.
--

commit eb9b929e5a0b2b55ad4f0c2af1f0f2627d324f83
Author: Ian Rogers <irogers@google.com>

perf evlist: Try to avoid computing evsel from sample

This commit updates multiple tools to use the resolved evsel pointer
directly from the perf_sample struct when available, falling back to
evlist__id2evsel when it is not.

> Remove the redundant evsel parameter from evlist-specific handlers and
> structures, ensuring the tool always directly accesses the evsel bound to=
 the
> sample. This simplifies the API signatures and eliminates the risk of pas=
sing
> an inconsistent evsel.

[Severity: Medium]
Does the commit message accurately reflect the changes in the patch?

The patch updates local variable assignments to opportunistically use
sample.evsel, but it does not appear to remove any evsel parameters from
handlers or change any function API signatures.

Could the commit message be updated to better match the actual code
changes, or are there missing hunks that perform the described refactoring?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520190538.1420=
18-1-irogers@google.com?part=3D18
