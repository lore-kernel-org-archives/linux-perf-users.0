Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F11CDA1A;
	Mon, 16 Dec 2024 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332581; cv=none; b=gRrN96kUM8SbHEBNjQpH4VHnjrQtgu955MQBKUb9VJXt4v6GDcjDNbypt96Cv0j0tL4bfcf6bv+xlYmLKhQjflzFPjkqyP+vVw7VuC88A6lzh8pqe29a//3emh7Qx5nyhX4J76RzgzEdpCmo29XEHIk/+C3Ms7LKqwC1LVcscZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332581; c=relaxed/simple;
	bh=IziRzV2/wGidSl5ytaHi8uMAv2ne2mNV+JioSICHTxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwrPr8Sm8m8A5TSBepLG3yAGfhC2eIhMHGGm5JUAXSHhGwFfo+5eWMVIKr0jD2ecdSMOALQpFyo4r0exiiJcVT/WOFiwOEVbs1s4r94p5XF70DUEFWlSNBgdxOm5IhdiUSedFRFd7WBoVJWa3TSEitzVFNGDEWNPwxgyYlKboFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjHAXtdV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjHAXtdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734332580; x=1765868580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IziRzV2/wGidSl5ytaHi8uMAv2ne2mNV+JioSICHTxo=;
  b=BjHAXtdV+dMnmMiMAc6wZPXeEugC5qy9nWq8sUUmw3fmefXG7EIizo/9
   PS/W9dxdaaJYvCNtkKgt2T0auWzAEe2ZaXSuLTZ93ioPkQsoW1w8yYOig
   GbESYaQTDW2BcP1pkO7yrxMHEybId6gMy11YRUE3SHvzhflc8zbJpQ7hZ
   7G6bj7MvasNYfF3/ogg/ToufmcbhbVRCRupJ1n5d1ap3P5PFrA2Z3E0tm
   phB3a2Lh2v4Bua0jNX3rh+ifceEDqvHMS7mK+Sj2XnomHijJ3972IGw6H
   mSJNnrwNsrep+73H+Kg9P91n0DGyq+tnKH/fGtXKjYrYu7D6XH0LyDMx6
   A==;
X-CSE-ConnectionGUID: I2gFCQsfTL2jIKKEY8BllA==
X-CSE-MsgGUID: IGWPfZGtRPWgrF6861c7hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34584252"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34584252"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:03:00 -0800
X-CSE-ConnectionGUID: eR2yri2ORjKFkDUPr0SE0w==
X-CSE-MsgGUID: 4xQ23uGbQ1+uPG1ejk+62g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101258629"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.115.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:02:57 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V16 1/7] perf tools: Add aux_start_paused, aux_pause and aux_resume
Date: Mon, 16 Dec 2024 09:02:37 +0200
Message-ID: <20241216070244.14450-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216070244.14450-1-adrian.hunter@intel.com>
References: <20241216070244.14450-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add struct perf_event_attr members to support pause and resume of AUX area
tracing.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---


Changes in V16:

	Changes to tools/include/uapi/linux/perf_event.h already applied


 tools/perf/util/perf_event_attr_fprintf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index a73c74b99a3b..c7f3543b9921 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -331,6 +331,9 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
 	PRINT_ATTRf(sig_data, p_unsigned);
+	PRINT_ATTRf(aux_start_paused, p_unsigned);
+	PRINT_ATTRf(aux_pause, p_unsigned);
+	PRINT_ATTRf(aux_resume, p_unsigned);
 
 	return ret;
 }
-- 
2.43.0

