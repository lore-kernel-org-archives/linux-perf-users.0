Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605CA1FBCA1;
	Thu, 28 Aug 2025 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344957; cv=none; b=Z3MsByYZDYFenLy8cUKyVPtsmIedX8GkGGZSyEtSpQfsP3IJIJdedmbM5xqFrQkuDOy55FcYkUstY98fAwe/N+8LC0NGvJXM4P9o8orj5WvYx/GyofdaKocIp7+x8kCHJMY0ahKr8UGTD2yEBnFxVAuQy1rJhjlLBUyWFoWnibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344957; c=relaxed/simple;
	bh=JZYS5BstaxGX52jnfSSbcNb/bUfuw6h2qY/fOzUMwXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxg3ymO55ILJH0On2iRnpOt3l250Dr5gHn4f+PqNiZdE+LWPE7Ei7XSjkWqWQ4QnI0QHi8baWS72CXbfa+8uXkf/XOcbjCjK8e+SlZVgYdOGfowHpcR8bzyXlsamEjj5Ym187rfS/6fnpi0ohHMWQC2EkLNkeXIx5WjhCSRFvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8yjlI35; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8yjlI35"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756344956; x=1787880956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZYS5BstaxGX52jnfSSbcNb/bUfuw6h2qY/fOzUMwXQ=;
  b=T8yjlI35IR6+REbG/oq4p2opDKCvSssQHRyh0IrpKt+ScYBH0f2aenK+
   WHdO9ABk3Cv53xlKD1bUmW/1wPhlThKMBtHU8gVTRF7KO0jNA3+mdFDGk
   OO5h/XtTG/QFxx6SUrP7LleVwybFsO/u+eXSo1PDHwGbwzB4WtAVDUq5D
   pSNhCGP3dsGf5S+u7Jkk9SGQUE7PKcZCEjhGq92smF+ZbY73Qp1Ny0fMi
   KaRHNnXTIwDCFvfJaWXVn9iF/cB2xwYpf3IS/1e2etArr9uXhUCzO5Zgb
   OUqYLpSnPIySim4izhFBJy+6AEn7qWdqMMXemZsJCBoonjCfngapdOTCH
   A==;
X-CSE-ConnectionGUID: e+XFuoDoRDaElwKb/wuf3A==
X-CSE-MsgGUID: eH+Xe6pmSaue3idmWUFU5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61240815"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61240815"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 18:35:56 -0700
X-CSE-ConnectionGUID: 0PWbxrTkQfeZ0KbmfnQ0xA==
X-CSE-MsgGUID: JSNoSuuXRG6MI7nFP6uO7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170372443"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 18:35:53 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 01/12] perf/x86: Remove redundant is_x86_event() prototype
Date: Thu, 28 Aug 2025 09:34:24 +0800
Message-Id: <20250828013435.1528459-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
References: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
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

