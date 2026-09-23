Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CFD485CE9
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187962; cv=none; b=KO/rb7B7PtPA1FttPvYGFNo/33jgwpC0OjTGTxNEp1S1LAMRYM0Jm/FX1PUa9xj9vcWII0iQJ9kDi+j7cWtnhf5SGt7qu9AON8yxXH5qn8tGFPHqLvG0NYV3iVjdqSZCn9m+XEsk/Xv/HWFzb/tHDR3gEHKZINiK5sJSwrqwGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187962; c=relaxed/simple;
	bh=RJ4LpyVhzcDwAu9WfKnKuAYTSfSe2vNAWN3HGtKw+rw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n9xBrCad8XcD9P0Nh0PI+pLOPWkakCOBZzXzF/zOIPawWOcH68SEE4yYTGyG1iegvYQNx7LwrxZr3iKSmi1BGcaY2k+DRRc4HHUQSRDjhL6tog6wD0NFZOwUe+lFzi+utSQUJL/WhUeCRCdIdEwC8/UgckxAX/Ah5CNo+NBEOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loaPM8QE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loaPM8QE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A9F1F000FF;
	Wed, 23 Sep 2026 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187957;
	bh=RJ4LpyVhzcDwAu9WfKnKuAYTSfSe2vNAWN3HGtKw+rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loaPM8QEbXbkAwIU9FY1Jsh3PNm+NOl3hbyhYqJRwlEcgf6kBR4R+qHqFmwMdImqM
	 VBcvaeBx35uDeORHuc0y29PUp2S2QbHGCxZoOsfjHLM+GmBNE1Ekie838DSmRXkKRy
	 Cxt+z/ZTJ97kkx+WHd4UwToY/NsdbIyV6vmFBUbQjpyl8CYU9UEOd6AV/RbWdgG3lf
	 Xv4M1Q0rVy+hSeoOu0mdULdOovYXrKTIVHcdDjOyyaVcs00+9+HBMeBUnjk9nvV3F9
	 sgZGHfSE8W/mqeVlXf6aw1y5vQZaLTZWsHCzLeZvOsinsqHDeJz+JZlrgxC/9RQxCt
	 OSwDT4g86RqJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/49] perf build: Make mypy build test opt-out
 (NO_MYPY=1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-14-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:25:56 +0000
Message-Id: <20260923182556.E2A9F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Commit 168910d0f937 ("perf build: Add mypy build tests") added a
> compile-time mypy type check for Python files in tools/perf, but left it
> opt-in via MYPY=3D1.
>=20
> Now that mypy issues across tools/perf/python, tools/perf/pmu-events,
> and tools/perf/tests/shell/lib have been cleaned up, enable the mypy
> check by default when mypy is installed on the system, with an opt-out
> via NO_MYPY=3D1 (matching NO_SHELLCHECK=3D1 and other perf build feature
> flags). Also configure MYPYPATH in Makefile.perf so scripts can resolve
> perf.pyi type stubs and local modules, pass --ignore-missing-imports so
> optional third-party packages do not fail default builds, and remove
> *.mypy_log files during `make clean`.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D13

