Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30C2030A;
	Wed, 15 Oct 2025 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510777; cv=none; b=iSfQ6fSg1itKTdahbyK3dgKLnhKwKMvTwfD8ZNdFxRXD6K1kpFCIlzmp9OTWsilv2reVyAsHMB8iZsa+yq9r2VLq2IVxwb+lzAEQu3fXNbusSMBU/chyf43FGS041oJBOKy9JN5N4ryQnjQFMTCvhqVFOyy3MxGaEdG0Y6cFqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510777; c=relaxed/simple;
	bh=JZYS5BstaxGX52jnfSSbcNb/bUfuw6h2qY/fOzUMwXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urnrnt7BPGZxgwO3XHWigdINJD2Lew+1KF45/aw+QmfqxH7aVttqVleucgbxDjGItDwqcneepj4mJdlx3NYcP4uB3tNJs4IKrxR75WT6DgCshAT7TViRfDvYOFrw1W8nl+tWN1irPzrtZ6bRLa6LuvWeXp9sThX+YEAUYkJ+hYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jk+VCaZ9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jk+VCaZ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760510776; x=1792046776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZYS5BstaxGX52jnfSSbcNb/bUfuw6h2qY/fOzUMwXQ=;
  b=jk+VCaZ9DlkLVBKi8HeTNyyuE6j2Mp2WcWK2jmoyp0GuBK0hszvd2MW+
   qLukij4VUJ6gU0u1FUzznQ8+hdlwL/S3O6l/kxV3uHFPYrdLxPVE2N5I1
   S9G/mBPF9/50Rm3w3Cf76ueYy6PGDTNGuOV2/qgnpHshXvidsIgiyQPhm
   vhnYUGK8lEygtOjOuFZttoZDIeryHfhRN1nW8LB0GHPA2znMl9EkNeBCu
   WqOJKPzZyQrvd2hgJXGwksmmgMZ1NMDCX4W8zUDILheIsXDn/e7dPcOiJ
   yIMlLkGh3Pj8uzHE+O9BAJf3xL3q7QKgSwdB8oeaTmiVC+VJED/vkalab
   w==;
X-CSE-ConnectionGUID: 1AMlWDOzSpezA+iqaMVrAg==
X-CSE-MsgGUID: 4yBtgwJVQGaV9HiDE9uLdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50242445"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="50242445"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:46:15 -0700
X-CSE-ConnectionGUID: qmNRv9WwQ1aiMa4T2ox+nA==
X-CSE-MsgGUID: GdfTZ8OVTcyXpY9q/8bF0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182029876"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa006.fm.intel.com with ESMTP; 14 Oct 2025 23:46:11 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v8 01/12] perf/x86: Remove redundant is_x86_event() prototype
Date: Wed, 15 Oct 2025 14:44:11 +0800
Message-Id: <20251015064422.47437-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
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

