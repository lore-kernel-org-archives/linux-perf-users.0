Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF393C10B8;
	Fri, 10 Jul 2026 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720500; cv=none; b=siJr0tVVNgKky9itGVD+n/1F7m3R/7nshRMfgNL0wyOS12eGHsUVE8gQwnWmy/tPaCaps3XOp4f8G4f01MhO+qtAnAWapatRf2TEDem3EAWCrlOVWdkIoj+kjQC48trqQL3Huhi0cIFYBnvrzIuwzcOKsZBwcdzwZ8CWlFzld04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720500; c=relaxed/simple;
	bh=ySWMY6pa6qvECfhq7dbBy1StuwfgAq9lGdO7R+L1Nvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJP+7pPK7TJ7H3qKn+lLSbpHJzB2ByditzVR+8WFadrxYh/OfEEGZTw/AotkpC+WpqhgA02kSRQuD7arhOgzmpS59hYAcbUXzlwjIN3TxrO9ENp5l7anO93fvrkVlyyMRxNp6pINz3BaKE+zP6Dto+KcvsBzlKLf2c5SC3SSsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZGXwzWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZGXwzWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4E81F00AC4;
	Fri, 10 Jul 2026 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783720498;
	bh=bgnzsDi2O6UwX9w+N43jEgZmeGBGJPYFPG7kS7jjoNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EZGXwzWPTjLL2T811C2s+MdwBZf/+ZaxKHqF/nsPqAcrK6r/4p5wkdo3jCk/S3Gr/
	 GbrDZ/RA4nWEHySZBTawBFTxT1m+YRY8cgV2/err/b5IgtiK5SIKRzLzmj3m2IiDC3
	 uIcVHOpAIobN8r+he/NKM9BOesbS3vYEiZernnzmZ6x+t3On1mzjEYQ4BfnbYsupTc
	 05NFFHq9US/uC6MyExGdlPiaYmjJJ1tHCEt59fLpRw0Mw+z2SoPN84tiqqJLB8WWoc
	 Y+BaxyusdM1DV0VK7uuf1lClL4zhQDWqEAgH5ojtKMh4SjRFHLlcMLU158VstbtHlX
	 a/VxFkz1rhU8A==
Date: Fri, 10 Jul 2026 14:54:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] perf c2c: add a function view
Message-ID: <alFqMY_q3mIhd-qN@google.com>
References: <akxLJvJvkD022Trl@google.com>
 <20260710084920.3579079-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710084920.3579079-1-jiebin.sun@intel.com>

Hello,

On Fri, Jul 10, 2026 at 04:49:20PM +0800, Jiebin Sun wrote:
> Hi Namhyung,
> 
> Thank you very much for the review and the suggestions.
> 
> > It'd be great if you can add this to the documentation.
> 
> Sure. I've added the worked example to
> tools/perf/Documentation/perf-c2c.txt in the v2 I just sent.

Thanks!

> 
> > Any chance it can share the code?  We have `perf mem report` as well,
> > which deals with similar kind of data.
> 
> The function view does reuse the common infrastructure: it shares the
> c2c data structures (moved into c2c.h), the perf_hpp_fmt column
> framework, hists__collapse_resort()/hists__output_resort(),
> hists__add_entry_ops() for dedup, and the hist_browser (including the
> generic fold/expand handling).
> 
> The part it does not reuse is the generic report hierarchy builder. That
> nests a single sample's own sort keys, while the function view pairs
> functions that share a cacheline -- the entries are (function A,
> function B) pairs that don't map to one sample. That's why the hierarchy
> is built explicitly rather than from a sort-key list.

I see.  Yeah I think it's a different model but it may be possible to
have a cacheline in a parent node and functions that accessed it in
the children.

> 
> > Also data type profiling would give more meaningful data once DWARF is
> > available.  It'd be nice if c2c could support the type analysis or c2c
> > could be implemented on top of `perf mem report` which already supports
> > the data type profiling.
> 
> Agreed, data-type profiling is a great fit here -- naming the exact
> struct field being contended is often the most actionable part of a
> false-sharing fix. I'd like to explore this as a follow-up after this
> series, reusing perf mem report's type/typeoff support to add a "which
> data structure" view to c2c.

Sounds good.

Thanks,
Namhyung

