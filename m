Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D257E792;
	Fri, 10 Apr 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775782887; cv=none; b=TDX9040C9J15AfnY6kir8Vh17GjgYOO/7fVrAuRdnGUJaY6mgF8+JklaI5D++BFpZuuSB/lHFnQqkdnkUYCmgFSUs8y87XDa13o5fmE6AMT1JNGdq8DW/+TKB0rAClrCBlOzOd49ZliPGe4MdAjxkEbRmQyUyjumJm07RLFLOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775782887; c=relaxed/simple;
	bh=PA3j5yJ4LRfJW5DI9IX2E8IxbmgNZvGwjLoFEIttv7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl4zunvdQi2PVjuaVN/hKddxRcJVBvVCZIopUoWd1xcXsp179BFVWn34Jwa/jLEZ7+GiHYOQJf0snUfE73Fas6ZD7EWMn7p3ixZHwpJEBiWc5hk9e+VIjgl6UwOIFC1Xpq8vbo/nolU8ejRrU+CkYEmSmw6Rex1qngb+eAFtqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRp23qhW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRp23qhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FBDC4CEF7;
	Fri, 10 Apr 2026 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775782886;
	bh=PA3j5yJ4LRfJW5DI9IX2E8IxbmgNZvGwjLoFEIttv7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRp23qhWFYQ6ysvmzt07qpwO5XYZBkMKEkU8ekYqb6Uj90SXZ/1BVGka1wf+zFww0
	 YkPUzFCPwDh2Pzju3H+FFRt/LYz67JNmtCtBp5oHYVEgfF8vkXPQQTXjjcAtXMXCv7
	 924zeAos3P30xSBBMb4shK2QwsDY6Y0Md+PmJdd/W7CnoO54EYjzC6fXcjqPc4KnxD
	 wtd1dM2jMb0qX2v7ORz1BmuY5ncG3fsVJyBbf/uRIK7AZBXdc7nMUxLU/Att/aMjjN
	 jaGXq7GG2am97hfRYGxvh/FuXuLtQjcsg55Iig/gkspVQ1jh3vA2Sr76fqNBfsD5+L
	 bl9j1Jkf00ujA==
Date: Thu, 9 Apr 2026 22:01:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 10/13] perf header: Sanity check HEADER_HYBRID_TOPOLOGY
Message-ID: <adhL4vXRiW0TIGSM@x1>
References: <20260410004000.148138-11-acme@kernel.org>
 <20260410005837.D3516C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410005837.D3516C4CEF7@smtp.kernel.org>

On Fri, Apr 10, 2026 at 12:58:37AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Low] The MAX_PMU_MAPPINGS macro is defined locally inside process_pmu_mappings() but reused in process_hybrid_topology().
> --
> 
> commit b5af27fec41475de3166cc72abe94ddc329689cc
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf header: Sanity check HEADER_HYBRID_TOPOLOGY
> 
> This commit adds an upper bound check on nr_nodes in
> process_hybrid_topology() to harden against malformed perf.data files by
> reusing the MAX_PMU_MAPPINGS limit.
> 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -3448,6 +3448,18 @@ static int process_hybrid_topology(struct feat_fd *ff,
> >  	if (do_read_u32(ff, &nr))
> >  		return -1;
> >  
> > +	if (nr > MAX_PMU_MAPPINGS) {
> 
> This isn't a bug, but could this cause build failures if the functions are
> reordered in the future?
> 
> MAX_PMU_MAPPINGS is currently defined locally inside process_pmu_mappings():
> 
> tools/perf/util/header.c:process_pmu_mappings() {
>     ...
> #define MAX_PMU_MAPPINGS 4096
> 	if (pmu_num > MAX_PMU_MAPPINGS) {
>     ...
> }
> 
> While the C preprocessor doesn't respect function block scope, allowing it
> to be used here, this relies on process_pmu_mappings() always appearing
> lexically before process_hybrid_topology() in this file.
> 
> Should this macro be hoisted to file scope to prevent accidental breakage
> during future refactoring?

Yeah, I'll do it in v2.

- Arnaldo
 
> > +		pr_err("Invalid HEADER_HYBRID_TOPOLOGY: nr_nodes (%u) > %u\n",
> > +		       nr, MAX_PMU_MAPPINGS);
> > +		return -1;
> > +	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260410004000.148138-1-acme@kernel.org?part=10
