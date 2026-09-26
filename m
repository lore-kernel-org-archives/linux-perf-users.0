Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116238DC60
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404449; cv=none; b=BZfqJUgmCU9kCS9TneaWuQwVDre/+SgtFIBtTFJZt2lMS32ceTqiEUMnNfaPrby/8W0qF3RBnP5jzmHC38lWrpGzjv1kIQm5K6+/fCMorHzCLcSrmm45Wsze75T6eC5S35pJWiwepFjiTaRdDgj+EecYST+S9qdz89PNMxfjMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404449; c=relaxed/simple;
	bh=vm0WE9eUtOVVJkLzvMdXrhyWJ1X6luxv6+1ugvXG4oY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPEP+ktPrneN+8cJXYV63uiNPUgAn5yRc3lsKaYNZvro94wOe0rkAn2a6+19IUlRmReec0edf9naxQdnhiWfCXxg3uorysiZYNs003kS7JeLU+Vl61gIf6ofuZaAhqAH0h3jfhfVer9ZL5hxBqI+Dpf4Pu3wMQQtZkc8qTu0A4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z72cqdyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z72cqdyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7D11F000FF;
	Sat, 26 Sep 2026 06:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404447;
	bh=Xu2UUpRa1fjX+59xKEX0GfjLAkK+uuFX+dWk2hMDcpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z72cqdykvuuWbOwkkX3N/sslwZde3zS6B8msejTqf79WaqJKRip48NezttzOyp7uM
	 YLW+jXFFuLgXhNZzMWlTKotoO36ZK9jivAzYbi8OfN5Nzn3U3Ao8247nI8ZqT5cMTj
	 CIzg0iAWk/6ruTtewcwLWlTdKAfgzcOqWXo0/fRxHv/TKUA9Q4nFqua3yceRp1E5Mb
	 t3p6IMEMI0X/4Ut60H9N2cWSmPXdlI5Lhh4kSxGlw6CVJp6OgAQm0eeeMiwMnXPaij
	 zF6vc9O85uDyRzO27N+KMc7rnTUTN5Pe6Eto9UMM7Xh+vctyKxZ7CBu/ZPim/bc8L0
	 y1Y8tj8BHp5SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 32/49] perf python: Port sched-migration and SchedGui
 to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-33-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-33-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:34:07 +0000
Message-Id: <20260926063407.7F7D11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port sched-migration.py and SchedGui.py from tools/perf/scripts/python/
> to standalone modules in tools/perf/python/:
> - Refactor sched-migration.py into a SchedMigrationAnalyzer class using
>   perf.session for event processing and add argparse CLI support
>   (-i/--input, -v/--verbose, --gui, --no-gui).
> - Port SchedGui.py to tools/perf/python/ as a local module dependency.
> - Load wxPython dynamically via importlib only when GUI mode (--gui) is
>   requested so text-mode analysis, testing on headless systems, and
>   static analysis (mypy/pylint) succeed without wx installed.
> - Remove Python 2 compatibility code.
>=20
> Add a shell test (test_sched_migration_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D32

