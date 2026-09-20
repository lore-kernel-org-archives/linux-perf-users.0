Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54F3D25D7
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882186; cv=none; b=RMVxiRsjWB2WEObx9BxutiPtpkpk0Bo4NfeApjyj+E5Xw4DUnchD2QX7JKIAjkvI28yCRd89woI2Zxu1Ou5OzD7Q/loUBjeeKZsdtjh+j06NY9V37XKnfC2F0xeB2d5sWsehxLoNDDgiBIVafi47B+Q65v5vbNKpAHIwwkJ9BME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882186; c=relaxed/simple;
	bh=RFGXhlRqAFie1c9bIuUUrXxUuAcZ/NmapauxgguF2n8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d7CisfRlhPO1iGjJSTDAUc4bLglinA9ZEIlNwSUUkqveOnjhf46ZpNxcibksv7OP9VAl1KZ+sSvEEW8fc6Y0sKZ/Hg8g+n2XYYDdPgP65CwWfc2gev2eHIO0rjdyD9tuzsh6ucG3agOx5/TjXiXJNvJ1RD+t4vXULEguSCdSpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNCpcqCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNCpcqCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D17C1F000FF;
	Sun, 20 Sep 2026 05:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882185;
	bh=1a8CynuuFDkFZjLrkffBxeV9KOBmWm4p4A+IiIy0NSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XNCpcqCJYGwEld4PAL76ec/kBuR6EukJzR35WgZVlHoGcCqYOQHjI4Ci5oLmxjqa4
	 OlHb21awLuOgH5PJMFRvWZtKrs/nmE8NR2LCkhu7ax1rbZ3GTltvjvw9jWlpiVOyoD
	 ERFE4lfoFwoko5K1qfbo6QkGUrV080LjJADeXDusllHfin8qjP7UbrgJHWQB1G3fuy
	 1z5TYDkmwrmGs4ddpykkcB04WhCU2CEhyEf3A9Z4sWkGa2O+vFpHn5EnlVCiOzj43z
	 nEvX+oG+N3fTWnwUtz4V5dVkch7PWo6ibKBiC8Gt+0jw6nV1zDmWXN3U0RPQpsdrIr
	 p0Lha+HCY0kAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 17/49] perf python: Port mem-phys-addr to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <48bc7067e83cf9b5f3d619e0ee0ff636fa8d151d.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <48bc7067e83cf9b5f3d619e0ee0ff636fa8d151d.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:29:44 +0000
Message-Id: <20260920052945.2D17C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port mem-phys-addr.py to a standalone script in tools/perf/python/
> using the perf.session API to read perf.data files and profile physical
> memory access types against /proc/iomem.
>=20
> Improvements compared to the legacy script:
> - Parse the full indentation hierarchy of /proc/iomem into a parent-child
>   tree of frozen IomemEntry dataclasses (instead of only top-level
>   indent-0 ranges), resolving physical addresses to the most specific
>   sub-range (such as Kernel code/data/bss inside System RAM) and rolling
>   child counts up into parent totals.
> - Support profiling multiple memory events in a single perf.data session
>   (keyed by evsel name) instead of assuming a single global event.
> - Add argparse CLI options (-i/--input and --iomem to allow supplying an
>   offline /proc/iomem snapshot from a target system).
>=20
> Add a shell test (test_mem_phys_addr_python.sh) to verify the standalone
> script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D17

