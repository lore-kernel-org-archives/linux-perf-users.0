Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3152340260
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833692; cv=none; b=kKdVTZX8VG1zpvdHHZGo7MoOmfTmsasjlKqfQ1kJlqdIcF/JI3PeKuOutSZPaTtycyb3MHXAEg9Wpek+IRuwRxdP98dVE4jZi09UkbkqORD4dNSrk7e4BPbJzQGmm+lfPM5Fo6JcShq3yfcCNTMDrE1dpIq5HuNbizHdjosth0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833692; c=relaxed/simple;
	bh=EeN3zzbrSHpzXzbra7Ogcpw6sxfJkSj5DStUSVaCB3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=afC4Qxi6AX1zi+M4vMbPIpIY9EYLalRrWwtia2eBiXq7Ie4p4jLDPypZ/4dsuqWK1OoBOSsJVk84NQgZfmFnOTU+73/MIhqOc3JHvz8VQST2eu4rTNCDJbhDryAndmlmnjgnOLssrHQE88k5mTFJd9V5AnIjdJQfjfL+7UBrxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKCILfQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKCILfQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112661F000FF;
	Thu,  1 Oct 2026 05:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790833691;
	bh=EeN3zzbrSHpzXzbra7Ogcpw6sxfJkSj5DStUSVaCB3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UKCILfQm1V89Pdhu4jV61/Ba1VtsgBeuD6/09KNA4VPWO2RMEJsYBawunPcXmAwcC
	 lN0UcSWSYX3m6ogvaD+fqvX/CoXMV/ak9cOV74flrJUP6KKougDnfrFM9VIlRI5Drm
	 RSR6LQELcOI5lz/d5u8rBOKaj3zeOFLEhsjzWjh9lD35kJQD5holjvpCNcqhJgZ+vn
	 u3VLSGip+kLX3hveb7d1GORlAiHjJTdXjSo+bWTtB0PToIDZHk0d/QDiuU6B9gOhzv
	 WZVGxfLKFQnk5A2CvbjQFGoWTBjcjvh2vU9pSSHHm0OH/D+yHyxOEr/xRpLIOxMA2t
	 GWzZ1UOkoL1bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf build: Run shellcheck, mypy, and remaining
 pylint checks in parallel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001054120.1570943-3-irogers@google.com>
References: <20261001023423.1225713-1-irogers@google.com>
 <20261001054120.1570943-1-irogers@google.com>
 <20261001054120.1570943-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 05:48:10 +0000
Message-Id: <20261001054811.112661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Following the approach used for pylint on standalone scripts and tests,
> move the shellcheck and mypy checks in tools/perf/Build and
> tools/perf/tests/Build, as well as the mypy and pylint checks in
> tools/perf/util/Build and tools/perf/pmu-events/Build, into dedicated
> phony targets invoked as top-level sub-makes from Makefile.perf.
>=20
> Also add 'perf' to pylint's --ignored-modules (leaving perf module
> type-checking to mypy via perf.pyi), since astroid's ImportlibFinder
> only resolves .pyi stubs for package directories (__init__.pyi) rather
> than single-file stubs like perf.pyi and does not introspect C
> extensions by default. This removes the need for pylint to wait on
> building $(LANG_BINDINGS).
>=20
> This avoids blocking jevents code generation, archive creation
> (libperf-util.a, libperf-test.a, libpmu-events.a), and final linking of
> the perf binary and Python extension on linter execution.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001054120.1570=
943-1-irogers@google.com?part=3D2

