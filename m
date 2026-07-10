Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70EB378833;
	Fri, 10 Jul 2026 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673347; cv=none; b=ZX2OOoBMrKwb2skCgm/CGtoOb9Jk2ruD5+5vrXP5ikzSwDtiaNcrP2qn06qBx1arRZKRNcJBD1wHqHaTu8w4JFx0A+jjEc4KBXgj/PS4VY3SReJ3zvs7qugnFGtPvj9j72wj0K38z09I6toXiqg/JfD4PJT9ilqWv2ubk6GV6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673347; c=relaxed/simple;
	bh=A1TeuydoPMf4AAHW+DPP6yUhKz+UaxBwjmSQ8N9P97w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuLeDcfD/sd/5XsK5yJXAgNphbmQg82jYBSPgAnBV2JCpVF8Y7TxyaOnF/bTccasNKq8/rzHKjm6nNqb4R3yHRW+UEeQ80d/+PXLJb2ytdRIOjZsUS9c7wYHwRYDiH62QU9iKLj5cuH43MNXPv3WSULzPyBzgnsZ02svNLVEWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRERTxh1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRERTxh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783673346; x=1815209346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A1TeuydoPMf4AAHW+DPP6yUhKz+UaxBwjmSQ8N9P97w=;
  b=TRERTxh17Mn7JVqXeXcbMKUNNDCkkiTyLARM+2fMaCMm3uFGO/0GTXcX
   Uk/kG0F7g5EzOM2p915CHbSe4T1hrAa2ZEbwclqYNs0ifTgSaRNNj+XKJ
   W1lfHIErXyJYWpq5lvltHcA0v8mQMOqDGvhMyY7lkkr3DKZEoMZAsgY78
   Xk7AnXwrUpYgZNW37gtAvhzuR+WZDSshNryKC/PfV34mJJpHStM1T3JY4
   eZM1GtBwEzbOTLFYUBvWIYyUK+kePLN4OUPrMljhNBYArkB+VMuwJMi8X
   AYV9oU6vivgxpfOzYA3dT1f9vgkG2ul6hbNpBEfl2WlDVbAra6mZctc/W
   Q==;
X-CSE-ConnectionGUID: KFUHO0ZmSw+2JxgWJ3Z0lQ==
X-CSE-MsgGUID: yOem6T0vSQCVkSJuYk00gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88284130"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88284130"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:49:06 -0700
X-CSE-ConnectionGUID: aReHqsGyRVyPLVCcIY97Bw==
X-CSE-MsgGUID: wUl7L/QeRl6Vwgihnqcxlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278066073"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 10 Jul 2026 01:49:01 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: Re: [PATCH 00/14] perf c2c: add a function view
Date: Fri, 10 Jul 2026 16:49:20 +0800
Message-ID: <20260710084920.3579079-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <akxLJvJvkD022Trl@google.com>
References: <akxLJvJvkD022Trl@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

Thank you very much for the review and the suggestions.

> It'd be great if you can add this to the documentation.

Sure. I've added the worked example to
tools/perf/Documentation/perf-c2c.txt in the v2 I just sent.

> Any chance it can share the code?  We have `perf mem report` as well,
> which deals with similar kind of data.

The function view does reuse the common infrastructure: it shares the
c2c data structures (moved into c2c.h), the perf_hpp_fmt column
framework, hists__collapse_resort()/hists__output_resort(),
hists__add_entry_ops() for dedup, and the hist_browser (including the
generic fold/expand handling).

The part it does not reuse is the generic report hierarchy builder. That
nests a single sample's own sort keys, while the function view pairs
functions that share a cacheline -- the entries are (function A,
function B) pairs that don't map to one sample. That's why the hierarchy
is built explicitly rather than from a sort-key list.

> Also data type profiling would give more meaningful data once DWARF is
> available.  It'd be nice if c2c could support the type analysis or c2c
> could be implemented on top of `perf mem report` which already supports
> the data type profiling.

Agreed, data-type profiling is a great fit here -- naming the exact
struct field being contended is often the most actionable part of a
false-sharing fix. I'd like to explore this as a follow-up after this
series, reusing perf mem report's type/typeoff support to add a "which
data structure" view to c2c.

Thanks,
Jiebin
