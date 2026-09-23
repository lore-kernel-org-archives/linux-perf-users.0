Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325E4457A4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148219; cv=none; b=oYEHHTlgw5y1PCeTueR4wmvODMmm2QougK+KUBWOIvl5jYfCqnw+BtTPFjHYkeRcCyeIiDugSJzzy0Shg+NXvhvIWjcLofqMp8YD/sbUiv946zLXAYrqsUb7BXjnLsJv6Gl+LtXnAdOFaPl6Iy7dy+QhmpYEkCfKrDFAtIkgYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148219; c=relaxed/simple;
	bh=Z0e1dbqqnGHppP/Xrup7sXXyJM7cmN04c850cAYxJzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSVSkbNPx0t/EmuC4XHte54aQl0nJIyx2x//m7WTsmWFR87WToHR8lTyWwzVqMBMKy8wL/dsMxKex29VTcYTnkH96sIBqbzcc5hCvSsrKZn7HTRsRb+Ypg1qSouZTnW4sSD9IRH6ysozjsRFlspJQ2LaDaZxU4arbF7McGWZbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFv6hIsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFv6hIsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AFA1F000FF;
	Wed, 23 Sep 2026 07:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148213;
	bh=AC7aKcacP1DkMTbQxNnKXgZDRA8FMpT5es+wz8mwgBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RFv6hIsVClrdqzSXpYoQHK6bVv7B9Ua9bEvc/ptVdRaexb8E1SwrJz1itGdkk3K0d
	 8nwANczPNFHfY+7W7NKpOExR8mUlNR0OOaJLM074LGHFObWX7Kulr8LFpQvryhMnb6
	 v19yrG1M2C7I7S/9xUpamSdCyLY7MABMg1lqOvyH02jlaZFBLIYtLdTIjTttRhEIRD
	 2CyMtZvEI4tOy1TleEY8OMldlG9o0BWgsbzzpoCj03MqcEwl/BdDWF34R2MAdDKsmj
	 ms4rkuuhCR3RRwcNnHmvyyhCZS/eHklKAPbHFCgWW2cIk4ZUGxHz1CMCAWLtJjnSwZ
	 YG38bIbmUudhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/23] perf evsel: Report an allocation failure as
 ENOMEM when setting filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <89815a65029985761ed8356f8a648ab128fdebbc.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <89815a65029985761ed8356f8a648ab128fdebbc.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:23:32 +0000
Message-Id: <20260923072332.D5AFA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> evsel__set_filter() and evsel__append_filter() return -1 when the strdup()
> or asprintf() that builds the new filter string fails, and
> evlist__set_tp_filter() and evlist__append_tp_filter() do the same when
> handed the NULL that asprintf__tp_filter_pids() returns for the same
> reason. In every case the only thing that can have gone wrong is an
> allocation.
>=20
> Callers all test the result with "< 0" or for being non-zero, so -1 has
> been as good as any other error so far, but it is not an errno and so
> cannot be printed as one. A caller that does, such as
>=20
> 	str_error_r(-err, errbuf, sizeof(errbuf))
>=20
> turns it into EPERM and reports a failure to allocate as "Operation not
> permitted", which is no help to anyone trying to work out what happened.
>=20
> Return -ENOMEM instead, which is what these failures are.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D5

