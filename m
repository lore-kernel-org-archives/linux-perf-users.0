Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4301A0B13;
	Tue, 10 Dec 2024 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856172; cv=none; b=rJEM4z2cKGvbl4P5iTUpphQE7zMuAiVDE/qd5owmWg3LMW0kbtruRNMaK4Qlb2sg7zn88WkP0HvAA0tpLMExxgnAKzt4TclPKUXA01TBMWUQvOvH2kLSQiRKbGfOCSrgQLz/30wLdqMfo4jxqBUtLz+aOOp5nYbaDzi8Bcm1BEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856172; c=relaxed/simple;
	bh=F575JjWPc8ikhBk4etYa+ofaJl+wudcTJRQhU7yUtgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhpK6U/CH5Yn0NXMjda+3H1HDTWTtOUHi7PNFa8DSur5dqvcvDjDmFOHxKWValI4dtH8Z7NngN2FLn8tmVHDDVo/OhlhXMyQi+R5fYRZ65Ylex9UbeSNyKVfWzhVilNUK69N5uRK8KANTLVKGm8AtVSRkfyGEaTsfiXcxa0RnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeSAD/bQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeSAD/bQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C297FC4CED6;
	Tue, 10 Dec 2024 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856172;
	bh=F575JjWPc8ikhBk4etYa+ofaJl+wudcTJRQhU7yUtgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PeSAD/bQmBTVA4yz9srxkh+sHdc0XFjadACep3HYEDzHPGG8C8/SltBnQYYmnuC0F
	 pGkCsbes+l0kTagbVHJ2iEZvfvYuCRDduNLgYmaWtqNjkitYXrsz4FtnvEomm0C3WC
	 tc6kBg1QcJsxFYTOITYBg3F6qH5t0O80BMcwhmGO+875IrEgc7V9lohG+rnkdhKYno
	 w32qxX/qOnR1L7C4kv1OPgodlakHLPAD6qqobWYJgSTJxdNqCa70pc2tEqLkTy6z9u
	 nFyL/Xv43ZqdwMZrYQsmAPjiLeFR5I+eirUdZiQQP6cgusKlJD0TjDMpFdQj02SwkH
	 ljJtBDek1drGw==
Date: Tue, 10 Dec 2024 15:42:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] perf stat: Fix trailing comma when there is no
 metric unit
Message-ID: <Z1iLqNmDyNH7fDpa@x1>
References: <20241112160048.951213-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112160048.951213-1-james.clark@linaro.org>

On Tue, Nov 12, 2024 at 04:00:40PM +0000, James Clark wrote:
> The first commit is failing on Arm and I think the fix should stop more
> trailing comma issues which keep happening.
> 
> The second one I just noticed when looking at it. I don't feel strongly
> about it so not sure if we should do it or not, but seems like the empty
> metric-units exclusion from the JSON should be consistent if we're going
> to have it at all.
> 
> Changes since v2:
>   * Do more documentation and tidyups around struct outstate

Ian, have you had the chance of going over this series?

- Arnaldo
 
> Changes since v1:
>   * Don't skip printing when the metric-unit string is empty but pass
>     NULL instead of an empty string.
> 
> James Clark (5):
>   perf stat: Fix trailing comma when there is no metric unit
>   perf stat: Also hide metric-units from JSON when event didn't run
>   perf stat: Remove empty new_line_metric function
>   perf stat: Document and simplify interval timestamps
>   perf stat: Document and clarify outstate members
> 
>  tools/perf/arch/x86/util/iostat.c             |   4 +
>  .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
>  tools/perf/util/stat-display.c                | 242 ++++++++++--------
>  tools/perf/util/stat-shadow.c                 |   5 +-
>  4 files changed, 147 insertions(+), 118 deletions(-)
> 
> -- 
> 2.34.1
