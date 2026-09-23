Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8CE34D929
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148400; cv=none; b=BGZdSF2oNVBxF4uTIUTh+praOgJv1/7EOxDnDIRfsHkpEzwGPUNJfQZnlcZrhSkUjiM7nzNgxF7Qbyw+A413ml9Z3UA0gHLpj2iGN4qYuNBWYqXAP/ybaBwXrlGBjsz3OoWpDvIqB13ysY2v2+zsdTu2sfld47bgRn+8TrgCQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148400; c=relaxed/simple;
	bh=2E3npsAhd0aHa/qq0q4VdGVR3fcuAi5+LR59P1dFBo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JObANQH9w+PixBm6KYP8ek47IhdbPEVdjCenJYb/IPzzHiO/Oi8DhFIrG37w4Pi90wlRlNRR1BbP74G8wCNrsDgDmjMmTC0Doym6paEmYOWNutKMovGQqs5pdepqpPLj4xRLFPB7B200TM0vG4jZBYzcj6DidKDGI1W22+8zYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idoX6r6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idoX6r6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD331F000FF;
	Wed, 23 Sep 2026 07:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148399;
	bh=5GI9unZMZ+cmSc0oOFDo/cyeN4X/KYsyfl8ixqDkuoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idoX6r6d6850SduBAoaQFsrLgTZuTQJTqa4uJEe+1TQ7uuMQc3GCYeMuGCx1NhR2/
	 SfoMu0rhfi+7tftElBgqOHZmDhKnXiLmRbXfi4Lu4GQJttd2CvZuSBYNZ+zvjzPsAP
	 IxGvPu1KEDB61gqvKfwcGHk8CpR937w0qLka/8BXYv4aXQxMTjmNdcmUIO0crFQZD+
	 rFZiFuOiWEcsK9fwjIAWEvtGVTQaVCYcy/J4wocz7EhQkmag75G20SMpcYnP/rLNn1
	 kewutfks1W+rvurShmQXE0uD5MXKIjOIxtvV6PZXTqhKsUsxx8qf+4GUYfkpY0OUzt
	 rDdpd/Fo7n1ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 23/23] perf test uprobe_from_different_cu: Scope
 probe name to PID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <0cb69731888e5d32afa9b517d3456d66a99dedb5.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <0cb69731888e5d32afa9b517d3456d66a99dedb5.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:26:38 +0000
Message-Id: <20260923072639.2AD331F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D23

