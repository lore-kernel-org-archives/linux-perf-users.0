Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5893164DF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775782718; cv=none; b=WyPkXJdkIN5oQFG4XgATLsP6I1x+pbTkRislJtMHrwAokTGA0EAdiYG+ko6zBAswDkubvANr5NXoRrWY5sVjfxAHWy0Lw+s7E4CsZFysmX9l1p7+oBrVkE/caWYnfOI9CxWjkone2+GUD74j8tmAhcfiqB6Zg7Xc5VzbkxEoyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775782718; c=relaxed/simple;
	bh=lNKEtd+AWZ5H9HbPcPwWTw53H68E/RqQZkSbhbrDpmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pz7UtD6BJoS8IK3jRS/svjTvnAc0Dj8N51Fgq1oy2WmzIN07qmnt6Qb7LQZV1cyBcUlXyBNS3YpMLCeazJO4nmj/UP8Q15BjKj1r7oUglGHjAceTwtWcvnxyoO71a7pcVbCDGPHWZAkxP3unVOGSnuFFowhbCDWkgDseKcJi2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ6GNOt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ6GNOt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3516C4CEF7;
	Fri, 10 Apr 2026 00:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775782717;
	bh=lNKEtd+AWZ5H9HbPcPwWTw53H68E/RqQZkSbhbrDpmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bZ6GNOt0+i+VyUxEaibL2oamrJx6lF1nwrQzLrlm3lsFy9Bq5TkiUOtFX6/+a2LGo
	 yOPrjwon1j8PSWzJF7V5pmBr8Vqivk2c0+Wm7OXjUBf9iwPv3CXwIPIe7G3ayp7zF6
	 oU193X37kZmT4JEqVycnCJ2EjCG7zhUdBqXzokFgckdYwFGW+MQBn3bObsAWqEUN7y
	 UtHalK0oAnKvJMSUBUynSjiOCW9VZZBsnxKHKqSLS/w0MkgS7FKUaoqnWFIe7Db464
	 E2lkhf+zSrZ5gR/RSDLRYLf7Qy6DcSKGB8dCiy2acnjDUkSm7QQTC9e26u0YmJW0j0
	 ZoeO7Br6ws3jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] perf header: Sanity check HEADER_HYBRID_TOPOLOGY
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410004000.148138-11-acme@kernel.org>
References: <20260410004000.148138-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 00:58:37 +0000
Message-Id: <20260410005837.D3516C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The MAX_PMU_MAPPINGS macro is defined locally inside process_pmu_ma=
ppings() but reused in process_hybrid_topology().
--

commit b5af27fec41475de3166cc72abe94ddc329689cc
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_HYBRID_TOPOLOGY

This commit adds an upper bound check on nr_nodes in
process_hybrid_topology() to harden against malformed perf.data files by
reusing the MAX_PMU_MAPPINGS limit.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3448,6 +3448,18 @@ static int process_hybrid_topology(struct feat_fd =
*ff,
>  	if (do_read_u32(ff, &nr))
>  		return -1;
> =20
> +	if (nr > MAX_PMU_MAPPINGS) {

This isn't a bug, but could this cause build failures if the functions are
reordered in the future?

MAX_PMU_MAPPINGS is currently defined locally inside process_pmu_mappings():

tools/perf/util/header.c:process_pmu_mappings() {
    ...
#define MAX_PMU_MAPPINGS 4096
	if (pmu_num > MAX_PMU_MAPPINGS) {
    ...
}

While the C preprocessor doesn't respect function block scope, allowing it
to be used here, this relies on process_pmu_mappings() always appearing
lexically before process_hybrid_topology() in this file.

Should this macro be hoisted to file scope to prevent accidental breakage
during future refactoring?

> +		pr_err("Invalid HEADER_HYBRID_TOPOLOGY: nr_nodes (%u) > %u\n",
> +		       nr, MAX_PMU_MAPPINGS);
> +		return -1;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410004000.1481=
38-1-acme@kernel.org?part=3D10
