Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724C353A7E
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767024; cv=none; b=hZf1PTQvZ9C9CjUtW1wPTrq3h9YK69rjvAe5mb5iEt6EhYEWO05ncm9xG2eS/jTW0QMK36AhzBVG5i9G/JoiNbaCXsLVPGVopfMmh8u8GUySHSJJ2wjzfZldJyILMbvofUF67+2xiKihumV5T4yE6OUDJuqWwDngxJ2G4mivN+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767024; c=relaxed/simple;
	bh=ayzO5Hqyh4dpZJ4WIHRJVTmod7JcLtfL1HmgA3gYzK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J8PalCeOMZmnJMXYMvxi0FXTSeZi0eEysT3jylzW/U0rNALnGZwaAcl/lkM3Qxj00CYNUJJ7wYyNVRpKRubAJhU7yHJMBMonFTrzZacZqHuMp4Za5YXc1kjBLUvOfRJcFc4rri6XnlmfhSjszlz3BoYMsR4V5ZMUZLehgq0E9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/gGxs+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/gGxs+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C211F000FF;
	Fri, 18 Sep 2026 21:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767022;
	bh=PIaKSCxSFaq+xEcsX3psSKE0MQtaFrMS73RJ+Ou0Ikg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/gGxs+SvnXNxiGcjRUlGP3L2YkeC6/wPWzzgu4vhji7yRJQfzIEkRjryhxelPXrv
	 naoYVSIQ8NUH37QWH4H0tQOPhm1BB+Ax4w8YztOCw9sR+tgBF6KFfFvAtx7OTy3Sre
	 0Lq2i3WgnAZFOWVvWtXoS3E3FDCByadpqs5W5hXJB7VzmOjBBRPQxsl9+errR17rrA
	 9y+YAEWJjI/P2l7eTuT6eSMlwzW7hvlsWZwuAZTp4VhxUpRsKVMXtT5Hc6IOAAi6ET
	 m1D+gnlTT3ErN8ADNERs0xYeUuREf+jIv8mS1aD5p6aNghka1lizCa9AAaasOTYHn2
	 yjAn2uuVeo5iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/18] perf test uprobe_from_different_cu: Scope
 probe name to PID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-19-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:30:21 +0000
Message-Id: <20260918213022.07C211F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D18

