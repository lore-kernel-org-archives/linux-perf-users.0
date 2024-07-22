Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51B383B1;
	Mon, 22 Jul 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682425; cv=none; b=Ya1Khr9eKZbckgd8AxdnwVaZnW5jOHLVJ19jqQYmh1qtfhAwjyFC+AglU8mofU/xbhwE2cbvhmeaMlVQVcAODNjFBCAb1AFmCD1Pov+cpn/zHFjQS9psduq6zuQxvEfH/2pGAAcNgQ3rAdEFeufJdoIS5KQBQd4/GgtKWZp2odA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682425; c=relaxed/simple;
	bh=CLDzciEero0wXQ8D8VOvwQtfDeWAgDoyzgMa/VmjAO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaOQG0JEmSccjLOelClvb4fgr2QKn2V8aWHw67RdgimKUKDOMfpZ0pxhGa1EYspP6VTMnd9MjFp6AqGzV11bul+YiKllSWc8RLe4fL2txS2j9UT/RxyIH72c7sEfwGWEsj2PGbHG4INTtcnYOiLbGmRYVXv3TGH5+jPRacePTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYIrgQ4u; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYIrgQ4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721682423; x=1753218423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLDzciEero0wXQ8D8VOvwQtfDeWAgDoyzgMa/VmjAO0=;
  b=DYIrgQ4uAMkUf5UuLPLb3FYWG5rIJ0QCl/UKJ3j05nzHWI5WZAqcYERl
   mdFvjjsQ8WrSf42tFV0Zd3Rq/4MF6U933tw/klyJuha3d0odOHlFw7jpC
   1r+uiPrvdTNQZncS0paVuuKLduJZOgqdfFbRj3PQbKxasQjxGFIVBCFEV
   0motSB9slxF/iUzzgk6A9bDxBRC3rt0LsbhAMxY6+ihxLcqkFbtsSTqCd
   pt06S3I9H7pO5b92PM3uSkLhGGmxMqcNlvPCItIPX1/XvSNUiCU5KPzYo
   daM5Dw5ej6uuhrIK3esByrU4dX+XWx+NU299Onl3Fiw9TQgzTsiXerJP1
   Q==;
X-CSE-ConnectionGUID: T8LC4ZEVR9W67CzWxLz6gg==
X-CSE-MsgGUID: 1OCk9NbmSK+Bj/Ph/E1SRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30428302"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30428302"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:01 -0700
X-CSE-ConnectionGUID: hu99ZmEUQSqsTKwyznoSWg==
X-CSE-MsgGUID: Nmi7OYq1T/WIR85QVowNHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51653292"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:01 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-gfx@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 3/7] drm/i915/pmu: Use event_to_pmu()
Date: Mon, 22 Jul 2024 14:06:44 -0700
Message-ID: <20240722210648.80892-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722210648.80892-1-lucas.demarchi@intel.com>
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i915 pointer is not needed in this function and all the others simply
calculate the i915_pmu container based on the event->pmu. Follow the
same logic as in other functions.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index cb5f6471ec6e..3a8bd11b87e7 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -820,15 +820,14 @@ static void i915_pmu_event_start(struct perf_event *event, int flags)
 
 static void i915_pmu_event_stop(struct perf_event *event, int flags)
 {
-	struct drm_i915_private *i915 =
-		container_of(event->pmu, typeof(*i915), pmu.base);
-	struct i915_pmu *pmu = &i915->pmu;
+	struct i915_pmu *pmu = event_to_pmu(event);
 
 	if (pmu->closed)
 		goto out;
 
 	if (flags & PERF_EF_UPDATE)
 		i915_pmu_event_read(event);
+
 	i915_pmu_disable(event);
 
 out:
-- 
2.43.0

