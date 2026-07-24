Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB94377A87;
	Fri, 24 Jul 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887431; cv=none; b=Q3Ly2quaCz+iakKYMuGBBxmlOU5N9Tm1wWXokSmJIGWdabwQGY33sRxZdw/rfDl01AFfaslN64gKoN4wrEpTVxWYWa0uTd3tx0h7SdXPSoaqM25pvtj1RP8WdYeWmX0zPZ38ILNvvjuXoM+DRFDeutP6Nq4HvmUpLd/W7XSU38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887431; c=relaxed/simple;
	bh=TTNu8z8C8+rZhy9RvimN7rsnzmN3UBOiCxCqvmg7/eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9lt0IXndyZS7Ukq+I8lPSTAEE8b0ergQI81Y7qyvCg1AXBJ2xk9xd5OzUrPzvj3lFC6sDeMcsAfbnPzZHVcE5F8RyLaFmWFvSoNo42SXp42WpN84XUOga3TZbR9lYRZALDn6rDMLb6RrHznY4e/E4a9M2yIUpq4DIBp3Vylvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dwc32GJ3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dwc32GJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784887430; x=1816423430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TTNu8z8C8+rZhy9RvimN7rsnzmN3UBOiCxCqvmg7/eA=;
  b=Dwc32GJ3NdKERex+kMgXdSGfXyCwuLYj7Iyz9XBkGcPsb2Ahc4OySyYI
   YJdQSBsIV4Q4szmtLfqTM9m+IS4KUEOWJmqAFf8q0Vf8XHDmEU61YXRn5
   gduutJfta2RZmQ+4B9MGyegFMiPSzt8/GMgjIAiVWx+dS6WBWLQyceLAu
   x9XtyHql9h2f0l5MgziAGxHJUZZudwVhIx1WbL09IxKPlcZa8CmLjgrQA
   bKEYpKOg1PTJZ3lstnRgz3gQikenZ0XXRouGDmdK17IPk+6YpnsmIYM88
   YcUnJ3yMKseDFvTKS3kYsIR/68f4A0puNm3nyQduzC5iI4u9I8xvTcTtW
   Q==;
X-CSE-ConnectionGUID: 8R13VHNuQG2f2dnZ6iHh6w==
X-CSE-MsgGUID: Vx83yCn7RDaHJIq8Hhs71A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89442968"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="89442968"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 03:03:48 -0700
X-CSE-ConnectionGUID: Ie4yQ/HUQ6KcGASQE2/OrQ==
X-CSE-MsgGUID: Fbh0ge/9SV+iQseXMt1oDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="255302811"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 24 Jul 2026 03:03:44 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: Re: [PATCH 00/14] perf c2c: add a function view
Date: Fri, 24 Jul 2026 18:10:29 +0800
Message-ID: <20260724101029.1000212-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <amGpVYnDyqe7-xdy@google.com>
References: <amGpVYnDyqe7-xdy@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

Thanks a lot for the review and for confirming the layout.

I've just posted v4 with the reworked hierarchy:

  Level 1: the read-side function (pays the estimated HITM/peer
           load-cycle cost)
  Level 2: the contending function that writes the shared lines
  Level 3: the specific shared cachelines

Every level now shows functions and cachelines only, with per-level
indentation; the code addresses and offsets are no longer shown in the
main view -- they remain available in the cacheline detail view. The
series is also reorganized into 9 logically self-contained patches.

> ... add a shortcut to the cacheline view on the given item.

The function view already supports this for level-3 cacheline entries:
pressing 'd' opens the corresponding cacheline detail view.

Thanks,
Jiebin
