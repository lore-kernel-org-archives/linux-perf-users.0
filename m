Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5734D4C0;
	Tue, 23 Dec 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513205; cv=none; b=pslkkNNarZDnr9NOql7gORvbC0r6Im6uTYijqKFzrlYE6GFHs6DKpiih5J9dECkrL6ulEVuV7zLIgZqWnzzAypF4hnzl8thiyHfGwAsUFyVp0wlHOD9eqOs4ciG6nsS0dvJ54zo3MPjgeKIgonwirCosn2LnBGzThWIECacxRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513205; c=relaxed/simple;
	bh=p4oE+5o9bN0kXgNRRBGEZJVGoL3abU2EiA/DKtkd5rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdafqVOYhjSX88By4bKKRpFGIMQLY9f5++hFMiIVsoNzWd88K7w4c08mj5mYaAMprP2utdlxwJn6CHnE7YJZiFslFBFyNO8gXtFuKvN2hpAN2a+bVMnrpTCTK6a/MboENeHALPTbyIqiu8nqXf2amLi5qURVVJV2SvAqyilwoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRKXB5CX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRKXB5CX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D467CC113D0;
	Tue, 23 Dec 2025 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766513205;
	bh=p4oE+5o9bN0kXgNRRBGEZJVGoL3abU2EiA/DKtkd5rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRKXB5CXPr/2qVqWwBw3KOJ2f+ZjW8AXTnkL3tDS+isZzEVGahJ2O5inD4lY/sQ0Q
	 v9Sy5UXYy52nuEjM3+RQ+UZx3EfRzlBTTKT2aVFkCsDpcWTaLGGzVuaPY1mVXn+cNW
	 BomlQLRSEBlHCJgMdJq5KAolXb8+xjkQ4oONZoXT/zsI1NX2hnpcb4Tp86oPMl2lUF
	 0VDJipxWpp4R44TpryHQN4AIhdyOjJV4dvFZsF+ctKsVNCgeeScvVDkEQL85BvahRI
	 lhm962IHjpzhvPZNLL11W9//slDMK0zaeGAoczpqQ8AAnuWGUTGrM01RXn03PY7DEl
	 wR6nMYFqZUhfw==
Date: Tue, 23 Dec 2025 10:06:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/11] tools headers: Sync linux/gfp_types.h with kernel
 sources
Message-ID: <aUraMnczL_ba_zes@google.com>
References: <20251222225716.3565649-9-namhyung@kernel.org>
 <20251223010057.4135-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251223010057.4135-1-sj@kernel.org>

Hi SeongJae,

On Mon, Dec 22, 2025 at 05:00:57PM -0800, SeongJae Park wrote:
> On Mon, 22 Dec 2025 14:57:14 -0800 Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > To pick up changes from:
> > 
> >   4c0a17e28340e458 ("slab: prevent recursive kmalloc() in alloc_empty_sheaf()")
> > 
> > This would be used to handle GFP masks in the perf code and address these
> > tools/perf build warnings:
> > 
> >   Warning: Kernel ABI header differences:
> >     diff -u tools/include/linux/gfp_types.h include/linux/gfp_types.h
> > 
> > Please see tools/include/README.kernel-copies.
> 
> Nit.  I don't find the file on linux-next tree.  Do you mean
> tools/include/uapi/README [1]?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/include/uapi/README

Oops, you're right.  I've used a wrong template.  Will fix.

> 
> > 
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Other than the above trivial nit,
> 
> Acked-by: SeongJae Park <sj@kernel.org>

Thanks for your review!
Namhyung

