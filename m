Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5B1B85F5;
	Tue, 24 Sep 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203337; cv=none; b=lgbC1Alml6HZZ9RcFiY1eZWYmwd9jwc6ZSDEwb6ieiRxTuzKwet0Yp/auqJsJApktfSKZrRaf7qphowqda1wFIcIASh1VDqX7tQHRSdXZByW/eM2n7brvcmeIWav0hF+oAhSx6tyCyR+YEfM3V2tRfBI549PLvx1GD4bfgafkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203337; c=relaxed/simple;
	bh=y3OXYglhlp43kVHeV0em3+MF9/JdFVSnXc51Xo/43Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai3PPjqdEfLWeEKa9//lvfMaMMRZU+sKVOg+rRlYmMHQlN4rSj6Q7u6N+CtMaOiHkJYBZ2lyiVZzB//eMCUgdD7Vh0QE6ZMqqKXPhNhTybWMIS/WVIZoI6VgI7xcFAycjKDrGLe8T9qgYonikDTW1/ddlDzEe8k6cEDxrBBDtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r99C9Vpk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r99C9Vpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4E5C4CEC4;
	Tue, 24 Sep 2024 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727203337;
	bh=y3OXYglhlp43kVHeV0em3+MF9/JdFVSnXc51Xo/43Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r99C9VpktgXTtWPwLrZhAvAzCHn4RS3SxjfdFcBI9QatPVRBKJbYicsEK9YGfk2WL
	 A9guDhWuHfz82VR28cxDeOn3KxTun7TUDguvsNZWmDdxMR0qdUsOImAyhR+JUsMyBu
	 XpE5kISj31J5wL0oWfuuQU61u0hC68KbwV+e7KsNTTL/IaukfIrXrrFp7yIR2QuKpA
	 rjIjie+DRmlOa8MR+yv10mCHn9hwlEGKYQ4d3u/KSUdZK6SIKgiCzX0QF+F/t78v06
	 s5x/mo/pC9dJfNE+ObFncno18qzKiWAVrOx1A+44k+P6Bv/s2AgEp9FoPcCJQ0NDxY
	 5qE8SeXBMu9DA==
Date: Tue, 24 Sep 2024 11:42:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	leo.yan@arm.com
Subject: Re: [PATCH RESEND v3 0/3] perf: build: Minor fixes for build failures
Message-ID: <ZvMIBxRzYSI5G7yU@google.com>
References: <20240919013513.118527-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919013513.118527-1-yangjihong@bytedance.com>

On Thu, Sep 19, 2024 at 09:35:10AM +0800, Yang Jihong wrote:
> Changes since v3:
>  - Add reviewed-by tag from Leo. (see Link[1])
>  - Resend the patchset with no code changes.
> 
> Link[1]: https://lore.kernel.org/all/b5688d4a-9389-4998-8031-3f002302311e@arm.com/
> 
> Changes since v2:
>  - patch1: change LIBDW_VERSION to follow up the style of
>    LIBTRACEEVENT_VERSION. (by Leo's suggestion)
>  - patch2: Use a new line for the -ldl dependency and with comment,
>    synchronize tools/perf/Makefile.config. (by Leo's suggestion)
>  - patch3: include header files in alphabetical order,
>    add reviewed-by tag from Leo. (by Leo's suggestion)
> 
> Changes since v1:
>  - patch3: Remove UTF-8 characters from build failure logs
> 
> Yang Jihong (3):
>   perf: build: Fix static compilation error when libdw is not installed
>   perf: build: Fix build feature-dwarf_getlocations fail for old libdw
>   perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
>     undefined

Acked-by: Namhyung Kim <namhyung@kernel.org>

Arnaldo, can you please pick this up to perf-tools tree?

Thanks,
Namhyung

> 
>  tools/build/feature/Makefile | 5 ++++-
>  tools/perf/Makefile.config   | 7 +++++--
>  tools/perf/util/dwarf-aux.h  | 1 +
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.1
> 
