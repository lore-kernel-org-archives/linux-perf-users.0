Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C651E43C
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764016; cv=none; b=Jk7abWlEBVIACuSnKmjOsqEFRReYQpkIFVPadWgEnXSLbPY2+tYS5579wbN2qG9GTQQy7Zvo1SvQ8L0AvUrxUP3n1CFnI3MFG8+7SYync/BlqtMMIE63MUcO7pZxmrjeKbCoo/s4mLbsoQHLt9axS7qLdMWmK5SUEgT0wI2zXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764016; c=relaxed/simple;
	bh=FNtAaR10tdLUo+nExQ8A7/J8wqnbHOIAG5FzAkM9CQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm+k8z0ue2uk4hqifrsRaTA5Jd+dO5RS3Dr91zN5yl0P9Is6r9y+fUf1le3fCP9AKbg5YyItEQsxLQBs3h+bd+d/JIPj+IAc800EZnyRoZ/trT9dEleVUfSzoDc8MVjd5qReAo8TEst2xPLdkNpftunn28yCN6vy/OuEQveWqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHzuAN+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHzuAN+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DD91F000FF;
	Fri, 18 Sep 2026 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789764015;
	bh=ClmbTqYGeK981UajFcQlNEpd/PR8wyMuPN+xttj/Te4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oHzuAN+h1BuqsgOXX0rY5x3W1Acn/LzskHg9vp38UA0Rd7bagd27Xwu8tJwy3a4Bc
	 bkM0Wauz+x3sO+zoltc0tEeAZzRBnUiUFQ43V4WQMmXFDthdObTVERvoqLqyMw8oLs
	 5R2IZ1x0CTX3Tu2MS50FHz2HS8kYu+LWjRnPBvRC7xhPLZo8E14xrmgtXM/r/jtET5
	 s5CwuPC+Sd5EaqywEl162KptcPC93nKFkYtgyOzyC8O3VLmReNEv/qK8aU8l2BDmm/
	 Zsu5gZEOI/olx+TfdmKymS7MJFmq4rQbPHbBI5Su2u2wVdPknscJc788+Z77DVHdUd
	 Cz7gAR9KCOzeA==
Date: Fri, 18 Sep 2026 17:40:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, ak@kernel.org, ak@linux.intel.com,
	andi@firstfloor.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 0/9] perf report/top: Add opt-in --hybrid-merge
Message-ID: <aq2hq_Fw6fn0rGkm@x2>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917050708.704702-1-irogers@google.com>

On Wed, Sep 16, 2026 at 10:06:59PM -0700, Ian Rogers wrote:
> On a hybrid machine a wildcard event expands to one event per core
> PMU, so "perf record -e cycles" records cpu_core/cycles/ and
> cpu_atom/cycles/. perf report and perf top then show one histogram per
> PMU, and a symbol that ran on both kinds of core is split across them,
> with each percentage relative to its own PMU's total. There is no way
> to ask for the single combined profile.
> 
> Add --hybrid-merge to perf report and perf top, which merges the
> histograms of the events that came from the same wildcard into one,
> with percentages taken against the summed period.
> 
> Merging is opt-in because it isn't always the right thing to do. The
> cores differ in performance, so a merged cycles count mixes work done
> at different rates and a merged IPC is not the IPC of either core
> type. perf-tips notes this. When merging is possible but wasn't asked
> for, the TUI says so, rather than merging silently.
> 
> core.hybrid-merge in .perfconfig turns it on by default. As a default
> rather than an explicit request it yields to the command line: with
> --hierarchy it is ignored with a warning, whereas asking for both
> --hierarchy and --hybrid-merge on the command line is an error. For
> the same reason it is silent when there is nothing to merge, so it
> doesn't warn on every invocation on a machine with a single core PMU.
> 
> perf stat is deliberately untouched. Counting already has its own
> merging options, and this is aimed at sampling.
> 
> The events to merge are found with first_wildcard_match, which parsing
> fills in. perf report reads events from a file rather than parsing
> them, so there the wildcard grouping is recovered by matching event
> names, and core PMUs are identified from the perf.data header topology
> so that a file recorded on another machine is read correctly.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
