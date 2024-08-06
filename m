Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5740875;
	Tue,  6 Aug 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959830; cv=none; b=K2QWzqPGb3+GnAiP+MGdTdROfw0V8OfkjiXF9S4zeAwXam2cTkK+Xx7cSw1QKrf1kgoG0ntnUgGZtUUAA5YBmSAxg+3PuN+THSK7fvrkRMf62O0+KPL9pTjKBdi6BrkWxkslKb/vxlzxKjIx85rao+OS7ICmvsGSHsBpVv792Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959830; c=relaxed/simple;
	bh=Vc4onBiyA081mqZ+u8spT9LVIyOZyH6KyTqbDavfdDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LhsCpt6jbp6epV/cHQgbGRWKjcThvoZpuqOi72L5NVQZeVLXVE19/oHaKOXlRwTXJ4MYZELUsvPb1CE3gDrEqe+pmpr7Y8CCatvKdCt67qYRuu8s/d/2FStLMW6VicTLDSRgDoBeklBO+2mfaCIjlxv1f9FDOs+avvcK6X6ECmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRQDhUcS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRQDhUcS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722959829; x=1754495829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vc4onBiyA081mqZ+u8spT9LVIyOZyH6KyTqbDavfdDU=;
  b=kRQDhUcSICp22dFoNyQuxcmyR5DhQ9v9IAzjaA7Fx4vpfYGXZBcCtrfz
   S1M0pLkqZ2+41QEsGGWVJiAg+/QQmUpL2hmTsRIv56SJvWnJergljNtn7
   Q7xK4h8if0C+Jozw+Jb8zGfXD6zeB1Po79z0JHKTov2TN0mQNkDvruBqh
   PhGZkN5CWbWB8zn2OaYpIdehv7txYwf6Es+8fuxW6d2OnYSyGBUwFjK3J
   wV89NyCKq8YFHxXcXdimy3PlqJyNwUV12yzhfybCxLE8jwqILFLxKdd8V
   8n+4zDbi7qYyhsW0YMJTDwk6qC9NGmas4iSx0v0h07hpApkBSu2N0XrNn
   A==;
X-CSE-ConnectionGUID: gEJGCQrzQPSSLlncSzsQ7g==
X-CSE-MsgGUID: cJSesFPkTS+jcfpGvd6WtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="43514119"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="43514119"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:55:56 -0700
X-CSE-ConnectionGUID: myVnSxqvSEmIiMd8WTqf1w==
X-CSE-MsgGUID: TmNWln+xR+iKiGHo7i7D/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56631198"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.248.17])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:55:51 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V11 04/10] perf tools: Add aux_start_paused, aux_pause and aux_resume
Date: Tue,  6 Aug 2024 18:55:08 +0300
Message-Id: <20240806155514.17900-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806155514.17900-1-adrian.hunter@intel.com>
References: <20240806155514.17900-1-adrian.hunter@intel.com>
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
 tools/include/uapi/linux/perf_event.h     | 11 ++++++++++-
 tools/perf/util/perf_event_attr_fprintf.c |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 3a64499b0f5d..0c557f0a17b3 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -511,7 +511,16 @@ struct perf_event_attr {
 	__u16	sample_max_stack;
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
-	__u32	__reserved_3;
+
+	union {
+		__u32	aux_action;
+		struct {
+			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
+				aux_pause        :  1, /* on overflow, pause AUX area tracing */
+				aux_resume       :  1, /* on overflow, resume AUX area tracing */
+				__reserved_3     : 29;
+		};
+	};
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 59fbbba79697..29db0aef9a74 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -335,6 +335,9 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
 	PRINT_ATTRf(sig_data, p_unsigned);
+	PRINT_ATTRf(aux_start_paused, p_unsigned);
+	PRINT_ATTRf(aux_pause, p_unsigned);
+	PRINT_ATTRf(aux_resume, p_unsigned);
 
 	return ret;
 }
-- 
2.34.1

