Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DF48383C
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064051; cv=none; b=YvcO+0PKGybN2VfH9YhNRKAgKNTJBUinXWESSuwD44u1XDwKg5w4Nx0CLpsRwA+V22C3D3idbYyGHy+2Dywl0hYDmL4z8T7j3IzKIYfY8uTt1MpQIQsOI5n2AuW/RjyIDO76Af9Rc1E5Ih3mxAj679WVvmQ+QMIrVs87bR35NIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064051; c=relaxed/simple;
	bh=juWi6d6sWO4bQ0CVocGe5MqNWOdSu09Asi9Xnl/dN/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CUrwlLdS/3eHgFPdT3ngK52iE+q3VsLkxd8gvfUjbq7UJGFJM2yKMhwaBXHMKud2a4raAYR3GKh0VK35G1ICf99CBQRteWQEvevEdXvN521G24gnTG1xddKeNyZIqrQQvLWaf0SvBXmlrabgg7s4wr9MUxpXe9Mu0XYpVkqHWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmiTtYdp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmiTtYdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F65D1F000FF;
	Thu, 10 Sep 2026 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789064049;
	bh=LfhYXZt9rIWXOKwmEHrF2MdObk4a398dWoSLg/3CYRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmiTtYdp8vSgr5uiEadV70bUfQEWym2ceE4P5eAqqE71/opmt4wXoF4Qq2rCK4v9H
	 9d8CsFPtXkVANuZrPiG2OtG96qGeFE6UpAW5CY2cy76LLWFr15fgtrvgY2NjjnZCat
	 vwQ9wP/X25wP5804LPx1YztniA2YMooKWyh3HQo/hdaONsnJWohWYZKJ2QvgQdRljV
	 P1j5ezyajDsfW8abj56JEDZT6INKaD3OmILbo2WcdMzQDqYpCAbE5kWz1+NRAVN76x
	 k6M1DfsiGjTbNKaiIl4dP3U8n3QUCistTCHs/t9DxJgr+6hifI6xYM6xCfx19HGhfy
	 j1OoKOTri4DvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf header: Fix HEADER_COMPRESSED validation
 for comp_mmap_len
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910175634.3014018-2-irogers@google.com>
References: <20260910173715.2996571-1-irogers@google.com>
 <20260910175634.3014018-1-irogers@google.com>
 <20260910175634.3014018-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 18:14:08 +0000
Message-Id: <20260910181409.3F65D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removal of `../perf.h` leaves `MAX_NR_CPUS` undefined, breaking com=
pilation.
--

commit 6870b0e134392a29ae6d615a0881f18783b3b995
Author: Ian Rogers <irogers@google.com>

perf header: Fix HEADER_COMPRESSED validation for comp_mmap_len

This commit updates process_compressed() to ignore a zero size for=20
comp_mmap_len when validating the compressed header. It also opportunistica=
lly
sorts the header files and fixes a missing string.h inclusion.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 7db7da090a1e0..bdd79d7542ef1 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> -#include "data.h"
> -#include <api/fs/fs.h>
> -#include <api/io_dir.h>
> -#include "asm/bug.h"
> -#include "tool.h"
> -#include "../perf.h"

[Severity: Low]
Does removing the include for perf.h cause a build failure?

It appears perf.h provides the definition for MAX_NR_CPUS, which is used
to size arrays in existing functions like build_cpu_domain_map() within thi=
s=20
same file:

    char dname[DNAME_LEN], cpumask[MAX_NR_CPUS];
    struct domain_info *domain_info;
    struct cpu_domain_map **cd_map;
    char cpulist[MAX_NR_CPUS];

Without an alternative definition for MAX_NR_CPUS, the compiler fails to
resolve the size of these arrays.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910175634.3014=
018-1-irogers@google.com?part=3D2
