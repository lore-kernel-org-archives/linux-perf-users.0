Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECD351FAE;
	Wed, 29 Oct 2025 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733463; cv=none; b=dCC9o54nVq+69/bUjBa+dV0f6GcEa1pPVFfYzbXLOvd6+v70E+MI+4WAZamGWAhWSkLVvNJUNjMyMpUvkGfW0RzydAY+DmJhex8Xkjt4/vpP07jGvJBnLpwAN78HYp+L6ykqPhiSstHAitS5mUQvGx37S2UHN/i1ccIMP3z/k0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733463; c=relaxed/simple;
	bh=JZYS5BstaxGX52jnfSSbcNb/bUfuw6h2qY/fOzUMwXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNA48e6QiWFi3ZI7zY/FxOG1aj59gsCMgN77oNLkbY1g1DxjoT5YlBthDWASvrYt2D6gq44Bzds0KeEc9wU8zMFpz/nkZ7VwUQ77yuW7Mh9FDfk/Xl7qDeH+J86Bm6kRuNVidofueIYuFsh36kF1pjBdqh9u8aP2Epj2npVoHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEAJlxNJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEAJlxNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761733462; x=1793269462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZYS5BstaxGX52jnfSSbcNb/bUfuw6h2qY/fOzUMwXQ=;
  b=GEAJlxNJDImFpSL0H+NzqtO/pp/qA67CSsmDOBGl/o1OIODewVeunwYg
   X+Q3F+5OwB/7vVm3BAh6ZIQKcYgVaSznpmt0KOh8ov1ZtCRRUmYYWCZkt
   D7gcDisr+6dYY1GWejY1EcGWqyQ8PSEfrlD5Ihn9ESOTfXgexjbxKAQxV
   nqziCASz/BF3649QTVqs/tK4TCgyVru5sx/Gc7772gWTS4V8Zb5Wq91zp
   4tJer4/3buln37zRGQO0I26/O7Ga09cLkpIenpvu0aaMZoLuOJG0PxqHm
   Vz1z7R8BZ9j1znjklPkFCEraRjAYc5SgwRnxhkQ2FMEpGgz9DtYEA7xyx
   g==;
X-CSE-ConnectionGUID: rtIjVWc+SXCQeoDkDUl+sg==
X-CSE-MsgGUID: i9vXov6dRTW+z2APRm4SCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="63885938"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63885938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 03:24:21 -0700
X-CSE-ConnectionGUID: aC+tNpi9Qk2Oj4uwIHETyw==
X-CSE-MsgGUID: IrLDP1xeRm+T2ouoWoOwWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185963334"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2025 03:24:16 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v9 01/12] perf/x86: Remove redundant is_x86_event() prototype
Date: Wed, 29 Oct 2025 18:21:25 +0800
Message-Id: <20251029102136.61364-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

2 is_x86_event() prototypes are defined in perf_event.h. Remove the
redundant one.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/perf_event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2b969386dcdd..285779c73479 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1124,7 +1124,6 @@ static struct perf_pmu_format_hybrid_attr format_attr_hybrid_##_name = {\
 	.pmu_type	= _pmu,						\
 }
 
-int is_x86_event(struct perf_event *event);
 struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
 
-- 
2.34.1

