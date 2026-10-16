Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34362D0C89
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110262; cv=none; b=m+jijh+rdTQNL8xHeLZRY9Sr4VDsdlxTJbgJgbknXfEqoWRWEMGT3JQ5mO1THqHsQH9joK2Mq6punmDI9VEOSBTYNa+J/S//uPQqYm8VcTZhNaIM3RSQ1ixR9T4+NT3KkOJL573SV1Yx9E8DcM3SFoiRFvQB5/nD2XpA6xQnS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110262; c=relaxed/simple;
	bh=YHxp0tvJBHVZGWBoVvBZKGDmjPkij+yCg5qdppW8b4g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=coWUbJIHBIxuXbE3BBh+WDje+A7LHaoifF3HWs7N0Ne8icIhl5ZL5rJB7XFI0+RE7SXYvJrPQrhMH/OrKuxYntMoJBBB9E/c9Irk8A5sFaKj62D/wS2w8YpJmuA1cBeOQl7WncDODksNLLloHRmyXvMJ1uXEhFj7C1UKlRpAQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDBHyzxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDBHyzxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD81B1F000C4;
	Fri, 16 Oct 2026 00:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110256;
	bh=zy+3heeTfp0eG756h2LOUiYYY1r3ILu8twWyx3rNq1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aDBHyzxZQ8FCIez6zG5jTZSIr0KSHpPSQQqaGzPVrkM7WssGBfOWFul9ZZci99XaF
	 Jf9bcs5F221fBN6FsZylZ5vzJSHtRFMXqncUZCUjahXvZc8MqqbntaSup6GQAbxJAt
	 CytmhoakYkRGZ85jea9OQT9sOILgfjCy3EDy1Vc/uYEqtJsemOyq0HQOw4OmUlwUFH
	 SzvMGQX62iLndMwCLCL4A7hB2YidwPP8MGcWOFJwNemIi0jg7i5mI0b6PUsa6T+zbn
	 jAjNA8Zn0vxTTHca9JoPK3M1l6qy9TiXF+MCTmiN3s9V1tfn3Uiev7VfN8sJvhlIxe
	 lOglwIg7zElyg==
Message-ID: <sashiko-outbox-173518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/19] perf test attr: State, spelled out in a line,
 why a test is skipped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-15-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-15-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:24:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Per skip the default output shows a self contained one liner:
>=20
>   unsupp  'test-record-branch-filter-any' exit 255, expected 1, no attrs =
recorded to verify
>   skipped [kernel newer than 6.12] 'test-record-group-sampling'
>   skipped [arch =3D !aarch64, machine =3D aarch64] 'test-record-graph-def=
ault'
>=20
> The extra notes explaining the reason, with a copy pasteable command to
> observe the failure, come in the very same stream when the verbosity is
> bumped, at -vvv, nothing is written to a separate place for later
> consultation, it is just the logging ladder:
>=20
>   detail: '/root/bin/perf record -o /dev/null --no-bpf-event -j any kill'
>   exited with 255, the expectations want the workload's 1 exit, so there
> [ ... ]
> The command suggested to observe the failure writes to /dev/null, so it
> doesn't leave a perf.data in the directory it is run from.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D14

