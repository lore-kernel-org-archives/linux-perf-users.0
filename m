Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED043793CC;
	Thu,  7 May 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142057; cv=none; b=I+n5AzWLjDeYmADDgAg7MQw5a/5fF/cVTJwvIGHaaIAjTIOPsDMvpj1x1iscU+oWf9OZwC+0BWR98Q6UIb07CDT8JyROzzyIkOKw8BMDhXKzwCa5d+C7xRJIqvqvjZgrv3HyEbO1qDqAfSecekBdeV6vbfw4eKIPEs1r4ZEEMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142057; c=relaxed/simple;
	bh=lFb1+oPNnbKA8NN4mjXNojOTIr5Kusi2WlwiI9M4fvo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ijRtP+0U/fO8jEfeoYe5hYNy1+h8fTurrHTr8Fx0A9UMbJYavK8+GkRcfGVl7AnTqhNyTxbVdCf8XzfaF9qc0Ux3ISH8ME9Vp84irR5hlDXD0RZa60wL4lxjedY8r3TpSE7gqFQnxSAlLLQD7HYKNTFxBxKrBdBqHKrP+z2s9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szz0Bmlz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szz0Bmlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93E0C2BCB2;
	Thu,  7 May 2026 08:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778142057;
	bh=lFb1+oPNnbKA8NN4mjXNojOTIr5Kusi2WlwiI9M4fvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=szz0Bmlz2Durkdh1JjIMvadm5zpVWw5ri9Kaki8PiMiToBpO8s9qcdBrdIFtbgHqT
	 E1fdH9gkTxGEPOWPJVUJsqA93tw93kqbGA2AqN6vca3ucH+L4GLe4yIQyrSMhagcDQ
	 0wquHjdlwep5tkT2+ePowrbtxzDUXQoH0HqqF8pN00d7RPd62QlkJ+F7jJPG71vmnD
	 1o1jSfGCgtzvzIYM0sYeVJs12pw9bhi0EpCc6Ee4zGUOjCNflenNi4ErNXmJELoSwC
	 NuZc8uuop3JkE2RRientbPme7SywEIWdXT0juqQJE6/6ZDiqdzJ0C3RxOT3KQk1DGV
	 VkwIe9+Pu67Kg==
Date: Thu, 7 May 2026 17:20:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Zecheng Li
 <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] [PATCH v5 0/9] perf DWARF: Fix libdw API
 contract violations and crashes
Message-Id: <20260507172054.ee574b81492bdad1e18993e1@kernel.org>
In-Reply-To: <CAP-5=fWq1YWg09kaGovUtPaJh9udz5J6rdxL8_tf6N=hA+ewVQ@mail.gmail.com>
References: <20260503171032.1559338-1-irogers@google.com>
	<20260504081227.2203848-1-irogers@google.com>
	<afkw4MARqVAYOB2p@google.com>
	<CAP-5=fWq1YWg09kaGovUtPaJh9udz5J6rdxL8_tf6N=hA+ewVQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks Ian!

On Tue, 5 May 2026 09:29:13 -0700
Ian Rogers <irogers@google.com> wrote:

> On Mon, May 4, 2026 at 4:50 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > Just updated Masami's email address.  Please use it for later.
> 
> Thanks Namhyung, I'll make sure in the future. For Masami's benefit
> here are the LKML posts:
> https://lore.kernel.org/linux-perf-users/afkw4MARqVAYOB2p@google.com/T/#mb887c8aadf50c0371c4cb9273b9a7777591ad99e
> 
> The sashiko reviews (the 1 "critical" issue isn't an issue as
> mentioned in a separate thread [1]):
> https://sashiko.dev/#/patchset/20260504081227.2203848-1-irogers%40google.com
> 
> I think the series is ready to land and given that it fixes crashes we
> may want to cherry-pick it for 7.1.
> 
> Thanks,
> Ian
> 
> [1] https://lore.kernel.org/linux-perf-users/afkw4MARqVAYOB2p@google.com/T/#mc177f9ef695805b013fce3fecbea7d84dfa937fd
> 

Yeah, the series looks good to me and agreed that the "critical"
issue is not a real problem.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for this series.


Thanks,

> > Thanks,
> > Namhyung
> >
> > On Mon, May 04, 2026 at 01:12:18AM -0700, Ian Rogers wrote:
> > > This patch series addresses a number of DWARF/libdw error-handling
> > > bugs and contract violations, preventing several real Userspace
> > > segmentation faults and memory/FD leaks.
> > >
> > > In v5, the series has been extensively restructured and polished based on
> > > comprehensive review feedback on v4, focusing on history granularity,
> > > bisectability, and defensive styling:
> > >
> > >  - **Commit Splitting for Review Granularity**: Split the previously large
> > >      libdw contract fix patch into 4 granular commits to cleanly isolate
> > >      independent improvements: introducing clear_frames refactoring, fixing
> > >      ORDER_CALLER parent update corruption, adding line 0 support, and
> > >      consolidating core contract/leak cleanups.
> > >
> > >  - **Bisectability & Correctness Hardening**:
> > >      - Fixed an unused variable compilation failure (-Werror) in the split
> > >        history to guarantee perfect git bisectability.
> > >      - Fixed a line 0 fallback regression to ensure that if an optional call
> > >        line is missing but the call file is valid, we fallback to line 0
> > >        to preserve the filename rather than discarding the caller info entirely.
> > >
> > >  - **Style & Robustness Polish**:
> > >      - Standardized all newly introduced C++ style (//) comments to
> > >        preferred C style (/* ... */) comments.
> > >      - Implemented explicit safe string duplication style fix in annotate-data.
> > >      - Corrected CU DIE propagation context inside probe-finder.
> > >      - Enhanced the Patch 2 commit message to explicitly detail the removal
> > >        of strict optional attribute aborts (decf) to clarify review queries.
> > >
> > >  - **Tags Collected**: Integrated Acked-by tags from Namhyung Kim for Patch 1
> > >      and Patch 9.
> > >
> > > v5:
> > >  - Restructured series from 6 to 9 patches by splitting the libdw commit.
> > >  - Fixed compilation bisectability and DWARF line 0 filename preservation regressions.
> > >  - Standardized comment styles and applied safe duplication formatting fixes.
> > >  - Updated commit messages with detailed optional attribute justifications.
> > >
> > > v4:
> > >  - Localized and squashed robust error handling, memory/FD cleanup
> > >    paths, and safe DWARF printing.
> > > https://lore.kernel.org/linux-perf-users/20260503171032.1559338-1-irogers@google.com/
> > >
> > > v3:
> > >  - Minor formatting fixes.
> > > https://lore.kernel.org/linux-perf-users/20260503003552.1063540-1-irogers@google.com/
> > >
> > > v2:
> > > https://lore.kernel.org/lkml/20260502155656.478642-1-irogers@google.com/
> > >
> > > v1:
> > > https://lore.kernel.org/linux-perf-users/20260502064839.282422-1-irogers@google.com/
> > >
> > > Ian Rogers (9):
> > >   perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
> > >   perf dwarf-aux: Fix libdw API contract violations
> > >   perf srcline: Introduce inline_node__clear_frames()
> > >   perf libdw: Fix callchain parent update in ORDER_CALLER mode
> > >   perf libdw: Support DWARF line 0 in inline list
> > >   perf libdw: Fix libdw API contract violations and memory leaks
> > >   perf probe-finder: Fix libdw API contract violations
> > >   perf annotate-data: Fix libdw API contract violations
> > >   perf debuginfo: Fix libdw API contract violations
> > >
> > >  tools/perf/util/annotate-data.c |  27 +++++----
> > >  tools/perf/util/debuginfo.c     |   9 ++-
> > >  tools/perf/util/dwarf-aux.c     |  39 ++++++------
> > >  tools/perf/util/dwarf-aux.h     |   5 ++
> > >  tools/perf/util/libdw.c         |  72 +++++++++++++++++-----
> > >  tools/perf/util/probe-finder.c  | 102 ++++++++++++++++++++------------
> > >  tools/perf/util/srcline.c       |   9 ++-
> > >  tools/perf/util/srcline.h       |   1 +
> > >  8 files changed, 179 insertions(+), 85 deletions(-)
> > >
> > > --
> > > 2.54.0.545.g6539524ca2-goog
> > >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
