Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D638DC48
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404315; cv=none; b=CQGuJ+p12rkeAoUGHwHbBsxFHvXs5icDj2dToExLbwcevPHLCCJcExwWDVkcs6Uu9aCkyyRY8ZzjhepBlbh8/mHVV/fGE+3cmf82nHUW0cltjgwC7bXomASjcsQQy6LrX2EbzumTPObxuVVQbEVebJAW0EnhdT8T75I3ekqnQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404315; c=relaxed/simple;
	bh=01jxgl26jgtwo0ddbnvYGW/isQvCbe2WU/yzIOVmYTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GlmocWBCpgguwHFgeoZLgKOwxTW5ibR0oImtL8UFYDuBU+qLDZcwf+VkdoMA/sZ5XXvrzPH06dDZqCKo5SzPFgZGCcu7XzG5zpYEQIJjdcf1l6DDrpRlSIol1rgzaGk5g4kA37uzHkrS75Wwcw35HrkYVi75TZyGVxJlNvr2PvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/hL9d45; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/hL9d45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80B61F000FF;
	Sat, 26 Sep 2026 06:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404313;
	bh=xAr6Q71i7mIJ4BfFPyQ5326PC0Fr/mCLhuxcmTK5glo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R/hL9d45q/e1WYscG7o1e8obNM1y9ktxDp4Vn863SWyRA7PQnC7sX6B1jxVrU/vXB
	 tPGCg27C3a7tLw60EkJs4sQOHl2GVqgDsRbg8jM+EjvAyHkpEG5fYC1RK+IsFgRj06
	 n/qrdUT37eO1C+6Y1i/uQi1YYII+WRAp7KUgNYJBSoS17/I1mulf6os0T1IiabeGX9
	 qheeeqREHjY6l1o5XiDuYumNuGW5imS4ZFDm90fUEah7pFQ+HG6YUMWI9uu4YktrkL
	 3cA6dKxa9ucNtp7aQFtrPIlpf1BDsdJlUPviFzu6G+HjG4ujeJjbDyyvT2TAPc9iiA
	 tvT7EGnCAMucQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/49] perf python: Port syscall-counts to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-23-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:31:53 +0000
Message-Id: <20260926063153.C80B61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/syscall-counts.py to a standalone script
> in tools/perf/python/ using the perf module. Avoiding the embedded
> interpreter and per-event dictionary allocation overhead improves
> execution speed by ~4x:
>=20
> ```
> $ perf record -e raw_syscalls:sys_enter -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/syscall-counts.py perf
> ...
> real    0m3.887s
> user    0m3.578s
> sys     0m0.308s
> $ time python3 tools/perf/python/syscall-counts.py perf
> ...
> [ ... ]
> temporarily during the transition to maintain bisectability and are
> removed once all scripts are migrated.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D22

