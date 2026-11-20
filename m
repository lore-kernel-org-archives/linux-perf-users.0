Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203100;
	b=2ugRoA7IDG8a/0esNQJttJkooiyQ/DUSDHoCoeSrZuZV9zhcEErANBDX2Wm1TNr1XxUQ
	 I0y1jcIoBZzdIzyD2URkiZ7orBuVFf9PUz/c4l3Ie/JincPxaoZPzkR3J04rQAHUMHDIj
	 F3cJJE557/ZRjb/Fgpk8VOGxu79DL5lOD3ON9FIPf0EfRk1UCE5rSNp/+gfoRPflT2tIf
	 3SZj9mqqizQRRfR3w/8Vyu7x3d1sx7lOuOWgkE8/rqVO0KxRIL1Ny39VmNyzRCvHNU05W
	 vo27KRe+WAu4urvKzaU+UxIyN9L8H+JmrufMO5wYgdUPnIRL11OdeiszyBRxfalDd+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203100;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6bXlMrsDc3GOSczK989TC9dHfAXb2YQatyNH8bNHlMA=;
	b=gFdFbWbylU1q8l4A146vQZV5l3lkIrHPp6Mb1ac8IrygwvCwfcZjFL3ss6vG8OvB1gLs
	 WaN/8uEzePyzptFIW11ZmQStrH86xOm9eZlqWR68f2LPZ//vH8zVqUvWC/34oJ3Xa6zYi
	 1WxJX3T03pKsiUx5g+5iYREZm82MMloFSLAcJ0JPUNeIrYmBn/hlvsiJuCGlt25r4QNSh
	 zNC7I6HLNsA61N5vE0lCJEBgEjMvGpEKDRcE8Lxu0P5bwyi+Q+wbXRAyGk7BqP0UYTTj+
	 G2/4GRW/CWNKRQhKrf9kFm14bfR0tvke9FM8sYP4HmVng9YmJ7rmhpOukgTxuHPH/1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hk4NeYGm;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113B606A6D8;
	Fri, 20 Nov 2026 19:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0113B606A6D8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hk4NeYGm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795203099; x=1826739099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lxkr7PxNk8FhadE88hgEK75ddXVqI6lu39vdwt+9YFM=;
  b=hk4NeYGmJ+wTb4YQceDuIwvUdHLuNvm3ffPWbw8OS2VES3562KJ8JEJI
   UHqF5rA4AY+ED5jF3JHc8TaKaUD7tsbm09WCcfZf1o7ENSwooIJ4Q51VR
   gudjxgXkRNNHEitp4JF82W5i65lNnLDwdks9xCxFBdQy19nAuzs+Umygp
   3farlFk49F80IwWAogH2bAogh0UqwRswT5yWwj1RESzgf76OR7prJW+tf
   C02nNiTodFJiR3Zb1x24dmfGnUz+hmP3WY7GHc5Y9J5k49yvKK4I5cv4F
   Q6J/kc6ts0hp+aJX6xketCYzviHiWVp131IRdbZZVza3kHU75gJ0s19+H
   A==;
X-CSE-ConnectionGUID: qzrGuo8WRDK73XSywIFcNA==
X-CSE-MsgGUID: t629CpcpTji3f6siDL1htQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4131213"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4131213"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 11:31:38 -0800
X-CSE-ConnectionGUID: CJ4IvkpVTbu2qiAe4oCzmw==
X-CSE-MsgGUID: bosRFog6SeuvCsi8xthtsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11064414"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa009.jf.intel.com with ESMTP; 20 Nov 2026 11:31:32 -0800
Date: Sat, 21 Nov 2026 03:22:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/ds: don't WARN when the BTS buffer can't
 be allocated
Message-ID: <awCd5z+JnA8yD9bf@yilunxu-OptiPlex-7050>
References: <20261105-perf-ds-bts-warn-1-yuehongwu@cmss.chinamobile.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-perf-ds-bts-warn-1-yuehongwu@cmss.chinamobile.com>

On Fri, Nov 06, 2026 at 11:06:41AM +0800, Yuehong Wu wrote:
> alloc_bts_buffer() asks for the buffer with __GFP_NOWARN and then WARNs
> if the allocation failed anyway.  The failure is already handled: the
> caller disables BTS for the event and releases what was set up, and
> perf_event_open() returns -ENOMEM.

perf_event_open() won't return -ENOMEM. You said your test went on until
a following BTS event returns -EOPNOTSUPP.

> 
> The WARN_ONCE() came with commit 4485154138f6 ("perf/x86/intel: Avoid
> spamming kernel log for BTS buffer failure"), which added __GFP_NOWARN to
> stop the log spam of the failing per-CPU allocation but kept one warning
> as a hint.  That hint is fatal under panic_on_warn: on a machine with
> BTS, the 64 KiB buffer allocation can fail on a memory-constrained
> system and a plain perf_event_open() then panics the kernel.

I think that's the only point for reviewers to debate, do we need to
panic on warn when a user could easily trigger it? An alternative is
pr_warn_once(), not keep silent and go on running.

But basically I dislike the code churn, and don't think the entire
change is necessary.

> Since the
> allocation explicitly asked not to warn and the error path is fine, drop
> the WARN_ONCE().

Here the logic is broken. As mentioned in 4485154138f6,__GFP_NOWARN
stops excessive warnings, WARN_ONCE() keeps one warning, they don't
conflict.

BTW, the changelog contains too much unrelated info, it is just a single
log removal.

> 
> Reproduced on 7.3.0-next-20261027 by making the page allocator fail the
> order-4 BTS buffer allocation (fail_page_alloc: min-order=4,
> ignore-gfp-wait=0).  Without this change the first perf_event_open() of
> a hardware event hits the warning and, with panic_on_warn=1, panics.
> With this change the same allocation failure is silent: BTS is disabled
> and a following branches/period=1 event returns -EOPNOTSUPP, while the
> kernel keeps running.  The buffer is allocated per possible CPU,
> independently of any specific BTS event, so the failure path is
> exercised without BTS tracing.
