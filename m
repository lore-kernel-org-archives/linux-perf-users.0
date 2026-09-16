Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D982393DD3
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522838; cv=none; b=aExejyuWHpMEymCrXcpo+1aI/8M5su0rUjPZvzTurbxbkVxx5NA8uwVuNCrAm1DcWKO3NZh0BAMiV5G2P1wxD8HjfI89qxRHCWWTiXzeSa3XrasuMU5tb/Yy3iTLIKnCbV2d1FlT75pSIN+ZnkB2dAaPPZ2nd2F/AaqdLpOKQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522838; c=relaxed/simple;
	bh=6KBpefd8GvWNV+ezs7fHxvzguUBbPDGnlhGLk0ap6ME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mJ4Iwrgzt83z2Q2rtHvh8AYMXmZFZjMCoeqolJq4fz8mTc20OFekUiMCe3V7xoi2WW7eUHriL8Sr/TrjKjE8K0I0IOenmt0KlRCKfXPyvCO9f6LBkhBBSosLWCvqLXj6+t1SlpQBIlTH3WA7TvA7F9/t+k6XDeKeSNRCPNom2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ8nteIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ8nteIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C5E1F000FF;
	Wed, 16 Sep 2026 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522826;
	bh=XanN7ZUq1tmbokZOFpI+3AMgCYkrvc1Xd2KAEantpxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PQ8nteIXE1/yKwdPNsw1bFiq1Kgh44h3bTkrLsGaO4mJAn5GJvwiGW91AddlTlwHY
	 8zZQenF0v9aj2PrzBFL3kxcIuRZvknrsKJG0nuX+y2EhKPvROhhHRXvmyBaC/uW8pg
	 92W9y0kWzw7WgA0fHA/6FNH3Mc4kNgVjgMeJZXwS5MTPihvulfdb2rCLVn7lDb6rv8
	 f2kooEPHUWFQP3sGg0w1eOyB1bOpeVAh46x2XT/T1AahXQe/al7Lbzvg8KoxQCgseY
	 ICMrdB/KjjepB3lfCZ3HOvJSZLEjZUnaextuF7WYJK3/3R24KDfyP5NCdZbHIJPSbW
	 1fEym0sVsOydg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/26] perf annotate: Default to --itrace=i1i for
 data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <3d2b93b84d7059024f40528153dc6b6a20461c77.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <3d2b93b84d7059024f40528153dc6b6a20461c77.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:40:25 +0000
Message-Id: <20260916014026.10C5E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> ARM SPE-based sampling can synthesize multiple events on a single
> instruction, as shown below. This would affect data type profiling
> statistics:
>=20
>   Available samples
>   0 arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,store_filter=3D=
1,min_latency=3D30/
>   0 dummy:u
>   84K l1d-miss
>   95K l1d-access
>   77K llc-miss
>   58K llc-access
>   9K tlb-miss
>   108K tlb-access
>   0 branch
>   13K remote-access
> [ ... ]
> use this flag to default to synthesizing at most one event per IP (equiva=
lent
> to --itrace=3Di1i) to prevent duplicate sample counts.
>=20
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D10

