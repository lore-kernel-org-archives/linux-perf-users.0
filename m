Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309BD35A387
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404390; cv=none; b=IZWqCXHowMqvpDj0Rz4vKI7T11CMyeIcMNvU7HtaMMsDhoQDPYvhoIddPmtNHJKEF7F59bZxUJLhDL/8oQVIkXGmQkjgUhGdB8G4dlP5hJHsUYQpQJqf+CWYiGszLw7bGW0kyR1X5aU9Q/c8Ro1J4pKj6MXHz5Zp8Mr2PzsUOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404390; c=relaxed/simple;
	bh=7r1+PMm18PSiQLpNhxT5WIDYrqSQmY7/j58nCklerE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LsMHgzh7Lwl0mOtv5Te2SXOeCJUwD/nFjCWaki+eFPVysZi/fjmzgA93s5NHtFpcLJeBw6iEC3gZPWnmsglGDirCBgjez4UM25KuvphoJzwz40r6I0ZKCYwLjpSbJdAbyt9H3TWS4173SprYisTGvQsc7f9PzNeoL9k88lzqUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvK5a/Eo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvK5a/Eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E51F00893;
	Sat, 26 Sep 2026 06:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404388;
	bh=7r1+PMm18PSiQLpNhxT5WIDYrqSQmY7/j58nCklerE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MvK5a/Eox24jrrWzioBsGzwIc/HALzg0DI67vNCa04g/DFnO8PoMPHWuIhcY6IHe7
	 DHzJXMZARTjgLV1ukBostMqSsjcIz4ANOArnlbDeKB6p0jflLoLL4XeTXFr3m2bi8g
	 0nBHazCAh0bUf/HGHaZckjg8MJty7lQ3bgHy7tHOgU/DmL/0yQktyLTGyYK1bHzlFk
	 7jWxWXzh3QJYbWnZvkuCvOCWh4NZhKUkjdDMy6EwLJM1ICKtcI4jIvpEY5vFxQ1AcE
	 CncpLbI6g1qEPaac87HqygWoEuRkxymUFPB2OtttZ1B3ykgbSt3kuW83bK0nvzZyYx
	 tt5uOGgZm/rkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/49] perf build: Make mypy build test opt-out
 (NO_MYPY=1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-14-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:33:08 +0000
Message-Id: <20260926063308.A16E51F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D13

