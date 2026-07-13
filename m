Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB633260B;
	Mon, 13 Jul 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934572; cv=none; b=H1VQ81GOPCQ3XyZPDt2bWpvdX5d0g5jHM84NBsQRXZ3CPr6dDFrjZj7GxoErFCH7mnn77ydhpGw6kBvBCNC/H20CdhPF+5EQvBzbKYwX/sNUyHqzatSyJrikyZ4u1PrtkB6xf+cjjP4OUB8oz+9owddNhkpLpiHCGetsVhGE0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934572; c=relaxed/simple;
	bh=UXanRqBjfcTzF3SPF5mbTKVPLs9mAvK5k+FodHwRMzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo9SSpo959axcz+2JWHd8R0aUbIMK/53bOb08Cd/rnA5RYaP5s6uNv6OfegYQJdn3H6EgGxNjgVSwvN7WyHc7bLyWxg8aMDQlIEncXT5L17J6AID5DO0Eno8TuIzSecPl6hLXt24G0fDtoCdrxpwhc9IQogUN62pHAFytE3ERPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gspSWSKl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gspSWSKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783934570; x=1815470570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UXanRqBjfcTzF3SPF5mbTKVPLs9mAvK5k+FodHwRMzw=;
  b=gspSWSKlhB2NlN11kvMteSgMUF09ct2JhcIyoX2YwHHAb5sfBEbLLOYO
   QsAMhnpNFtxovAK1CEgXxcDxUQXHLb4UFF/6UrDuuvrQuJwXsIsQMoK1u
   GXNPhENs+Khmi6UIHHvfP/JGD1UBfTnxgCFpiZg/e7dydI/d/fRYjZx9r
   UAe5/Miq2fNGyDPOGQYihQjhvsb+wqxUKLF7/6Umbrbx9HaTP/jIrRNFa
   kPIpg2QLHIBBrylP8dRlQmJS1sGLvzJppJU+IpqxXn9fJ9k4FPnreh5QX
   w9Ly751Cp8KDNBzKa3elSIQCVDlllqoZgmqNEFTPUWDaJlx+4M+i7NgUr
   A==;
X-CSE-ConnectionGUID: /EmCCFLoQJya51699HebLA==
X-CSE-MsgGUID: kDPpkh8CRIybC6vTxMFrVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84732961"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84732961"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 02:22:49 -0700
X-CSE-ConnectionGUID: EwEQ3DfmTDW7eSyoAasLVA==
X-CSE-MsgGUID: eDwPgmM8R1WhDZffCAcBfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252113792"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 13 Jul 2026 02:22:45 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	dapeng1.mi@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: Re: [PATCH 00/14] perf c2c: add a function view
Date: Mon, 13 Jul 2026 17:22:49 +0800
Message-ID: <20260713092249.340613-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <alFqMY_q3mIhd-qN@google.com>
References: <alFqMY_q3mIhd-qN@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

Thank you, and thanks for the idea.

> On Fri, Jul 10, 2026 at 04:49:20PM +0800, Jiebin Sun wrote:
> > > Any chance it can share the code?  We have `perf mem report` as well,
> > > which deals with similar kind of data.
> >
> > The part it does not reuse is the generic report hierarchy builder. That
> > nests a single sample's own sort keys, while the function view pairs
> > functions that share a cacheline -- the entries are (function A,
> > function B) pairs that don't map to one sample. That's why the hierarchy
> > is built explicitly rather than from a sort-key list.
>
> I see.  Yeah I think it's a different model but it may be possible to
> have a cacheline in a parent node and functions that accessed it in
> the children.

You're right that a cacheline-parent / accessing-functions-children
layout maps cleanly onto a single sample's own keys, so that one could be
expressed with the generic hierarchy (e.g. sorting on dcacheline then
symbol).

That organization is cacheline-centric, and fairly close to what the
cacheline view already offers -- the cacheline list, and the
per-cacheline detail ('d') that lists the accesses and the symbols
touching a given cacheline.

The function view is function-centric instead: starting from a function
and showing which other functions it contends with, and over which
cachelines. That "which functions contend with each other" pairing is
what needs the explicit build rather than a sort-key list.

Aggregating by function also helps to rank functions by their total HITM
penalty (HITM count times per-access latency). The cacheline view shows
the per-access HITM percentages and the latency, but not that product
summed per function.

A real false-sharing case we are working on is a good example. One of the
functions involved, cpupri_set, has its accesses split across several
cachelines, and within any single cacheline each access is only a small
share of that line's HITM (a few percent per access), so it doesn't stand
out in the per-cacheline view. Its cost only becomes apparent once summed
across the cachelines it touches, which is what the function view does --
it surfaces as a top per-function entry and points straight at the
function to investigate, without the user piecing it together across
cachelines by hand.

  https://lore.kernel.org/all/cover.1753076363.git.pan.deng@intel.com/

Thanks,
Jiebin
