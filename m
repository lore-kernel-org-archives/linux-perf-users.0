Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE08F64
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927799; cv=none; b=IZ6psYQzoRRkfaLpGDiZJ7ccx3oT0CLvnRKOST+b7ECf0KOdNRxtpHApWQyFPBaqatytyP12wxI7fgKPHT/2GWp6WObB/HlVdIkI2mrE+Jl09zxWLqE4XrdBhDuoxVJGgnN+rIDKeSyf59VdhdxfVWgbPf8Lcva1GI75wLOSxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927799; c=relaxed/simple;
	bh=OSasaQe116lFDU9PKraI9EVMOCCCqghXYmMmz0fe+48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BZLnMgN94D6P0l4PsgEqjXeki6qeYM9XOAcJVXSOnkTZSoUS3tDz7sbAuGuEEkuP6/0UQFdIfvfSpI5UJdLNxOTvy9ijc6iFvHMVOvf6kBWNgpgN9gmfJJ17Am3zWfZqP8c9je9qFqgm40GS3tes8vBCkJZtobB3TxbWzDdNgIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZyOhDmn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZyOhDmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237B1C4CEC3;
	Mon, 14 Oct 2024 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728927797;
	bh=OSasaQe116lFDU9PKraI9EVMOCCCqghXYmMmz0fe+48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pZyOhDmnWNp81UMfMMp4uiLcoiH93kFGcgZ2Wlzs9XHTJROAWcPSTUoZqE2Ny6Hxc
	 0n2IMhuu8jLL07i1awliZyyEO9yYqcn6wisO6MYam8ldVvtjbfhAhKPOCXbHeq7QVA
	 Cq8jlZQi+Kq3PEKwME6IDh81nZWkmRHNJf2aajSczYS28bDs8eyNCbXg5mjhu+N2yd
	 iEnEWYB0oFI+iq2w1BAsW/jL0YPFmVm7tl3rgwWRTDnufOVCXZTtYO+NOFQrmw+LCq
	 aLepYL5nvzJwAXh6QJX/Zc7CfwjfmwgRH+YZcXXTEe8cuhzN5nYiMBX49/jFhBwjjW
	 DuFKWfdob6FFg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com, 
 disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
In-Reply-To: <20241013173742.71882-1-atrajeev@linux.vnet.ibm.com>
References: <20241013173742.71882-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/perf/tests: Fix compilation error with strncpy
 in tests/tool_pmu
Message-Id: <172892779710.897882.14949543082561189584.b4-ty@kernel.org>
Date: Mon, 14 Oct 2024 10:43:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 13 Oct 2024 23:07:42 +0530, Athira Rajeev wrote:

> perf fails to compile on systems with GCC version11
> as below:
> 
> In file included from /usr/include/string.h:519,
>                  from /home/athir/perf-tools-next/tools/include/linux/bitmap.h:5,
>                  from /home/athir/perf-tools-next/tools/perf/util/pmu.h:5,
>                  from /home/athir/perf-tools-next/tools/perf/util/evsel.h:14,
>                  from /home/athir/perf-tools-next/tools/perf/util/evlist.h:14,
>                  from tests/tool_pmu.c:3:
> In function ‘strncpy’,
>     inlined from ‘do_test’ at tests/tool_pmu.c:25:3:
> /usr/include/bits/string_fortified.h:95:10: error: ‘__builtin_strncpy’ specified bound 128 equals destination size [-Werror=stringop-truncation]
>    95 |   return __builtin___strncpy_chk (__dest, __src, __len,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    96 |                                   __glibc_objsize (__dest));
>       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

