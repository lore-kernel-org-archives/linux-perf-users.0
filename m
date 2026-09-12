Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFC7E0FF
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183456; cv=none; b=POEFTHmquEnxhLBG/0RRGgNJJ4Iz/ypT9Iuhulv2Tukhwa5Ix1U3Od1G5/cfdM8DYdy42gXPu0JLWlJZqmggRhFNb9w/V1NDcnt+KfHE7HORjPXShGS5PG4Gcg+V9xYhwI2pL56fyv38lDeeTsi5RYs0RJJPo1iim6PlWFK9NO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183456; c=relaxed/simple;
	bh=Q53x+8SZ58WKNOecsUceds4SVhKSKrLYZMpIoD2Q/Sc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r5ckTpy4y6SOsvM4aJOdMlFB5RoA9cAZhwgdoN8zHrx/pwouCYNw1wKGTFsWj1lL4UfjeB9tRqNpZTvmVcg9uN9yPe8+iWBDKPsKAVx7ixELEp8KFxgLUjl6eZHlfmqbkapX302SVzTvi3UYwl1uiXN9IUWXVRvyB9Nni8r98vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7w7d2S3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7w7d2S3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B991F000FF;
	Sat, 12 Sep 2026 03:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183455;
	bh=SaRwoX7qAbHOXWR72Vz8cfvZkD8R6aQlJKkQsbiYHSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E7w7d2S3WvYZ2BhqNvfsIIOMnGZteCqEmUyvDmQBjfNCHJQoVCFvU75vZAA02CYzW
	 a3quHZmh4BE+sMy8ZXGYIhOaV+lfI3VMEIvcYvkF2WulbKYLWw9YuKaSPLytk7nefm
	 itiMXYvln2jPegXgDmBoSWPY8XOh8DDM1Ef02HlD1cnMAGSulsTDq/SVghLxCrNbeK
	 SRRMRfEJ1XbWQsJJZjit1Tsmq0tbOka+PpaRMQ0jvtr6ufpxTGkumoVJypGtjFIZnX
	 FygDeo6CcC3xQc7vWMzh09giL2pCnxs2UTISZFLTsMTz+OjSl75F2/aChBBiDjojHt
	 FypSuMnGd0d6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf evsel: Restrict incremental open error unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912031112.1814574-1-sh_def@163.com>
References: <20260912031112.1814574-1-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:24:14 +0000
Message-Id: <20260912032415.20B991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> evsel__open_cpu(), evsel__tool_pmu_open() and
> evsel__hwmon_pmu_open() support opening a subrange of a CPU map, bounded
> by [start_cpu_map_idx, end_cpu_map_idx).
>=20
> Their error paths, however, unwind using "while (--idx >=3D 0)" all the w=
ay
> back to CPU index 0 regardless of start_cpu_map_idx. If lower CPU indices
> were opened by an earlier invocation, a later incremental open failure
> therefore closes those existing file descriptors and overwrites their
> slots with -1.
>=20
> Before this fix, running the new incremental open test demonstrates this
> corruption:
>=20
>   $ perf test -v "Tool PMU"
>    12: Tool PMU:
> [ ... ]
>=20
> Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
> Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PM=
U")
> Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from=
 hwmon in sysfs")
> Signed-off-by: Hui Su <sh_def@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912031112.1814=
574-1-sh_def@163.com?part=3D1

