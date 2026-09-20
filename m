Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFBF3C8C55
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882517; cv=none; b=ICpGcTrlfJqxwqwiHffuj5cpSk6nfG3zxDoLLKTS9QEJBHXe6SIlAuggwKVbC9HTIdZk5CHYASem2cEPSSqdrZSEiFqJRkh0GycjsiLm6uBIDFiVvQKvs0w4fV7vownraaut9UzFYOL893v7QKu5N0am+e15sZsXOBuxkeTyXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882517; c=relaxed/simple;
	bh=2PadLi1+yu+QIKZJEO14S/Iitd/CJ0FEbv+hLv86dI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DvoqxorNW1MIAJ6S1OB1BUfsqXG6yG1vjE07cvz9xouXLlLv3zAWjTYyguiaLCkfCGEcFM2O8e+EjaQTxOWZcr8of3TXrjQmBqoDKRV4I3qI7sD6UL/+d2hI8V59tLePK+A/21M9YDckcKqTjxYoNMFm5xIUVRIMdLNdCS7+S1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYncfget; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYncfget"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D40E1F000FF;
	Sun, 20 Sep 2026 05:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882516;
	bh=8xLbeT4G7910WrqTVjgCtGEQVZRUmfUEuEE1o3fwgi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYncfgetxYr+vBsy+3hPI3/Xkx2DrKkMltS+0GWkOmbbmSj7qESr+WWCw6T2vTcGu
	 4IRlef03GGMOjPHSJe/7gevqlMAmrmNOMUvBuEXrtcw+YcUJ8YSfAWaU4KWupmYWnm
	 7a78DI3MowtmHUwm23biNd10zq6Cu9qu9ZyOFaPI6/J+m38RJbaYeMgIEfn2IcbSgb
	 qP+rV5F5rXXLDlLANZqCP/03esG8+c4QbPNJPfHCUPia36/E0Sojnnn6nKjvN4+a4p
	 l/xftSM+DXCirQ5Sxoyp78hmmKd00SBWXRMjzjAosy1Ve7d5Y1FIIQUCBJ1eHIQ0q+
	 xzDcfj+xN+74g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 21/49] perf python: Port event_analyzing_sample to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <97754cb1ec24d266ce6dc2fa6359535f93f8e581.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <97754cb1ec24d266ce6dc2fa6359535f93f8e581.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:35:15 +0000
Message-Id: <20260920053516.2D40E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port event_analyzing_sample.py to a standalone script in
> tools/perf/python/ using the perf module and standard library sqlite3
> module.
>=20
> Improvements compared to the legacy script:
> - Encapsulate database state in a _DB container instead of mutating
>   module-level globals, and ensure temporary SQLite database files are
>   cleaned up on exit.
> - Add argparse CLI options (-i/--input and -d/--db) while preserving
>   PerfEvent, PebsEvent, and PebsNHM binary raw_buf unpacking and
>   symbol/DSO histogram reporting.
> - Remove Python 2 compatibility code and add type annotations.
>=20
> Add a shell test (test_event_analyzing_sample_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D21

