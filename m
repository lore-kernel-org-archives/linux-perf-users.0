Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0D3BFE3A;
	Fri, 14 Aug 2026 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677411; cv=none; b=PgfL8zEedNPuooZjMOo5TNZpGumlgfVmemhwOSGHuwaWbj3/56p7lWYnSqm/iQdk5Db0wS9RIP6TcgmPy1t7FXlpLmicaLvuYTJ4LdSY6Zy9GvJPiVJeikheDiI22i6qSl2shGrhSXQKo1+naVmmAsw5FyGvusKQkuO+ebnjKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677411; c=relaxed/simple;
	bh=gZFIWj7FJlZtehL1uFtHx2G2K1BARohGIMbjZUNIeQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTi/Ai3fTOXfT+JsIimJ94B2mJk3lZNElAr8NrnrFkS2RWYckZ7CCAry4yxaR3SEG1R9+vCoE+biYnH2iTbPuFOB8+flZQwrm3nUynAGlwOoyafge30L7qcpu1Tlb5u6Klvjhdc5e5E0h/jHRrdZHICRLwCa9kME0QPq7Cqd71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNkFcyMs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNkFcyMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786677410; x=1818213410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gZFIWj7FJlZtehL1uFtHx2G2K1BARohGIMbjZUNIeQs=;
  b=kNkFcyMsuDVdSw2nrVgQnMaTnV4sYFi3zUVoRNjNSHV9mfYhY2UDQvUI
   Te+MwrjW2RmjfJERK1+s429R/tOlnQ2PC1Lr+cO7Cy3tPDYGr5QyWxlOy
   wEGwfb2D7bzODV1NoXS75tU3cmk5bXkD1QIKTHnkAthVCCzdnlSh6qAwT
   Mexwmmbglq2198s5RYZ8O+nLGg7EeMoDkz3PTAyCLICCZCBi76IEtsQHa
   PgjowS7KJ2MmLh4cScfl+6GlxZWuyrz6DI9ks56zd355XpSJqkf3/eM14
   xkrVOY25w/j4+SaevV84DJJfP7O9CUmw6oPNtVMXNyWwijfTIM0HTqzIo
   g==;
X-CSE-ConnectionGUID: 1ldMaCJNSEKH6DjgMKIaRw==
X-CSE-MsgGUID: qe9AGeTvTYqhzctE1W3jDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97850015"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97850015"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 20:16:49 -0700
X-CSE-ConnectionGUID: 8BpsCuPzTTiR+MBDR/R8aQ==
X-CSE-MsgGUID: 5G/NeHeTStyyLJNaBkT4mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="262790359"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2026 20:16:46 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
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
Subject: Re: [PATCH v8 6/9] perf c2c: add function view hierarchy entry creation
Date: Fri, 14 Aug 2026 11:23:06 +0800
Message-ID: <20260814032306.2055624-3-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <anxvDnc2Kx-OSQEj@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com> <20260810052647.588867-7-jiebin.sun@intel.com> <anxvDnc2Kx-OSQEj@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

> What if both DSOs are NULL?

If both are NULL, the outer condition is true, but
left_dso != right_dso is false. The function therefore skips the DSO name
comparison and reaches the final _sort__sym_cmp() call, using the symbols
to distinguish the entries instead.

Thanks,
Jiebin
