Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24C424D6D
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188350; cv=none; b=u1nPNN+KTC+9QgmA1ivRdpulEQrFzXAnyWJP9IC2E0VvyE8JGx8zsGFlu+0aEAzm1gKaetFCSh5skfr/n3WzBBdNUOGjQDQbisQtkuii8LIJFWr6TH0xB3juLQ4VX0P4FOEvrYhNQjUpG0VnZyl8Eox068crnwo6UpLzNgy/zcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188350; c=relaxed/simple;
	bh=jEzuVELufYj161plCbbUGc6uBNX1NHsfseIN9RpwxPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IYRWWnukpXNv9BZIhCR6j8/qIoUSXMwmO0zfDLhnf4hKQXJyaByTgazjZTFcOU2D/o9H5t2U13ClwIRrkk9oMTeblQqR+e8xBHdVqFWjQd6vZuHWluDMTHn9/K8HFYj3fGt7iUX0seScIn4mRol+eq0izE1xdyJGcVFJDm1EJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVILbyxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVILbyxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804591F000FF;
	Wed, 23 Sep 2026 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188346;
	bh=/6ezjAFn/5U52ZK41Wv7WJB4PNNOfz56H92eHrCgaoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XVILbyxrNdk1GBh/nGef86BLM3fOtnNBGLsT6tb4X/NjENNVAtIlLTU0bMK6MA4AM
	 GT2JUPy2OSJcTD5OkGPkhVMOW92CBz7Qihbnhll5/4/6W+tlWD3eJA08Hug5WCnp+k
	 ORLtCa4suc2oAdfN4Ch6VcnezrEKNhez9+BUOdG/K/hXKpsQTa9jyPCotwCGC/WQtP
	 4PoXNdTGF1OHD8AAOlEuXjTfFbhLQgCFeESbsNccGHcxjq9oNyxm948NuPUKXz4R/b
	 njn3uOSH7IL8+KmL1rrulmICg6VvMU6iaT6jdEnrr1xKB5O21cj5HOZ+QVSJWGXzvB
	 fYtQ1PHiiLnkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/49] perf python: Port event_analyzing_sample to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-22-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:32:26 +0000
Message-Id: <20260923183226.804591F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D21

