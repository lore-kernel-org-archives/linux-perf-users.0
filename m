Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20D3630A8;
	Mon,  4 May 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938658; cv=none; b=hamxre4XiAqyyEwqWDTJt8H38kNm9fXgzBKp4eGyyUeTrPQMd24EcbwRc10FQTkFehD2BDAbzk1QmkohE6BDJn6pYlSx4kajpy+g+85s3N7uzzxV7CcByzBUio+Hv4kuQdZBv8mUC8I3SFtoVlCfQydicq4uzlG6DRswE7bbWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938658; c=relaxed/simple;
	bh=dFRME/22edpSTjSevRNUh8PNn+6SrsKAsemw8TwDENQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRNH/xNvuXGqHRaVB3MauXyrysW1+qNfhur5Kd3A8tgWpiXi/mnYEMvQqehQA6D9KTwfmeS0C9/keyJUIQ6mxpQAdMS/OZRyDVZDighS1NYXqnHqLtFw5hsuyYWBc/P5a7rvrUrDSbY3ZuQShuSNtgtLv1kLUyMaSze3a2BhyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esyd1KUv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esyd1KUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DFCC2BCB8;
	Mon,  4 May 2026 23:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777938658;
	bh=dFRME/22edpSTjSevRNUh8PNn+6SrsKAsemw8TwDENQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Esyd1KUvHPUSqAfAdwBEz2nFoTt4c0lRL6XY+f5gOBLssYVD6Ara/KIq3bfm4wn/O
	 TVNsMHibsyHNYpgyvxUF2eYFQ3V8Sbl7Ansf5EnVBYkduYVvms+0v+BuhXbE3WFfTU
	 /VZbuOD4Ji5uvjGnZRTN1mZpgMJTcag0IYb6lno21mxWMLCAd0PaUJmubC/Jnm0g1u
	 xPZCC753AxrQqnRZbjgSD0iq+4/ofZedS3sNg6nh6x10UiPn+6rBOpAIVd27YSh/cF
	 XE4QRO4hD6bMzEmQ5WoOlEZw/sov70r8XAai4bNeuvBVIEMNSngHUQdhWXxPMX3adQ
	 O2i5tDYkd4etw==
Date: Mon, 4 May 2026 16:50:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] [PATCH v5 0/9] perf DWARF: Fix libdw API contract
 violations and crashes
Message-ID: <afkw4MARqVAYOB2p@google.com>
References: <20260503171032.1559338-1-irogers@google.com>
 <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>

Hi Ian,

Just updated Masami's email address.  Please use it for later.

Thanks,
Namhyung

On Mon, May 04, 2026 at 01:12:18AM -0700, Ian Rogers wrote:
> This patch series addresses a number of DWARF/libdw error-handling
> bugs and contract violations, preventing several real Userspace
> segmentation faults and memory/FD leaks.
> 
> In v5, the series has been extensively restructured and polished based on 
> comprehensive review feedback on v4, focusing on history granularity, 
> bisectability, and defensive styling:
> 
>  - **Commit Splitting for Review Granularity**: Split the previously large 
>      libdw contract fix patch into 4 granular commits to cleanly isolate 
>      independent improvements: introducing clear_frames refactoring, fixing 
>      ORDER_CALLER parent update corruption, adding line 0 support, and 
>      consolidating core contract/leak cleanups.
>  
>  - **Bisectability & Correctness Hardening**: 
>      - Fixed an unused variable compilation failure (-Werror) in the split 
>        history to guarantee perfect git bisectability.
>      - Fixed a line 0 fallback regression to ensure that if an optional call 
>        line is missing but the call file is valid, we fallback to line 0 
>        to preserve the filename rather than discarding the caller info entirely.
> 
>  - **Style & Robustness Polish**:
>      - Standardized all newly introduced C++ style (//) comments to 
>        preferred C style (/* ... */) comments.
>      - Implemented explicit safe string duplication style fix in annotate-data.
>      - Corrected CU DIE propagation context inside probe-finder.
>      - Enhanced the Patch 2 commit message to explicitly detail the removal 
>        of strict optional attribute aborts (decf) to clarify review queries.
> 
>  - **Tags Collected**: Integrated Acked-by tags from Namhyung Kim for Patch 1 
>      and Patch 9.
> 
> v5:
>  - Restructured series from 6 to 9 patches by splitting the libdw commit.
>  - Fixed compilation bisectability and DWARF line 0 filename preservation regressions.
>  - Standardized comment styles and applied safe duplication formatting fixes.
>  - Updated commit messages with detailed optional attribute justifications.
> 
> v4:
>  - Localized and squashed robust error handling, memory/FD cleanup
>    paths, and safe DWARF printing.
> https://lore.kernel.org/linux-perf-users/20260503171032.1559338-1-irogers@google.com/
> 
> v3:
>  - Minor formatting fixes.
> https://lore.kernel.org/linux-perf-users/20260503003552.1063540-1-irogers@google.com/
> 
> v2:
> https://lore.kernel.org/lkml/20260502155656.478642-1-irogers@google.com/
> 
> v1:
> https://lore.kernel.org/linux-perf-users/20260502064839.282422-1-irogers@google.com/
> 
> Ian Rogers (9):
>   perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
>   perf dwarf-aux: Fix libdw API contract violations
>   perf srcline: Introduce inline_node__clear_frames()
>   perf libdw: Fix callchain parent update in ORDER_CALLER mode
>   perf libdw: Support DWARF line 0 in inline list
>   perf libdw: Fix libdw API contract violations and memory leaks
>   perf probe-finder: Fix libdw API contract violations
>   perf annotate-data: Fix libdw API contract violations
>   perf debuginfo: Fix libdw API contract violations
> 
>  tools/perf/util/annotate-data.c |  27 +++++----
>  tools/perf/util/debuginfo.c     |   9 ++-
>  tools/perf/util/dwarf-aux.c     |  39 ++++++------
>  tools/perf/util/dwarf-aux.h     |   5 ++
>  tools/perf/util/libdw.c         |  72 +++++++++++++++++-----
>  tools/perf/util/probe-finder.c  | 102 ++++++++++++++++++++------------
>  tools/perf/util/srcline.c       |   9 ++-
>  tools/perf/util/srcline.h       |   1 +
>  8 files changed, 179 insertions(+), 85 deletions(-)
> 
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
