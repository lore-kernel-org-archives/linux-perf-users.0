Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10201C68A8;
	Tue, 22 Oct 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612825; cv=none; b=C9fm55BXy0cI/9tYxTVVLJ0xSfKwAKPnsbxRpqPDye8V3f34xZ8U4E11emjHkljg7fIa/qAEmTRI1nCcdisbrVKCEot81Y9SESvDqQ7HqqilhJ3KBeifqQwLQL5atQm8l/oyDbg241XTA+hv/hp2CBqYI9+y29kO9IIfiMZizWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612825; c=relaxed/simple;
	bh=qSLmULyuQLTlYMQgi0y7aT2AgtmJ5HDHawdb49crJfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4wPAMU50cPaXW1cWIrNVdxVOAODO9XFGhcT+pUhz3YyyIkZbFhQ8UIsJnxlR6ppwap046krc8I9l6237mUg+FeArPSc2lTJo3zQ/G++5PQsphdNeyDTs9FxCHEEukk1jWvwpBR4MweUPpbw9nFHgggUdYjtVZ1zJbqR3DxKRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFstUyNn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFstUyNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729612824; x=1761148824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qSLmULyuQLTlYMQgi0y7aT2AgtmJ5HDHawdb49crJfs=;
  b=iFstUyNnjowaoIien41LByURh9DMKc+Y3ysrUh0OWn9htEf+szoa/Bw6
   MppEGzjE8tEYaKaEB1y91Epm+rwdst8eciq3MREowmk7tuMK423s0IGXb
   MbEYqkEo6jSgNO6rrnKgwcwAEE65x2s+sX75R+rdDsKRQTa8owAdO48cp
   pAdp7xGj4UUPCL6vVYq1lSUu70sZwoPp6KZ3m0LG8GzICJSeD8hy7/Mli
   p9ixSB4ejY6YTs14t2viXD3YfOkQ3tPx/Aw9c96qXH/nvrcu3UFiYVDVf
   ntuNpyZVd+A8ZbP4N4LxQIiWs6li7OziWYvancWOWGet6RBD4r3fKX+U2
   A==;
X-CSE-ConnectionGUID: 0DeNsLS1SVioIt44cdlB7Q==
X-CSE-MsgGUID: Yso8BXA8R+SjDywCkouAtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29270946"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29270946"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:00:23 -0700
X-CSE-ConnectionGUID: mLD736aNSEC4gZKMQJR+rQ==
X-CSE-MsgGUID: amvlgsNDTg6uaMHp0nad6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79858558"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.246.16.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:00:14 -0700
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
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V14 05/11] perf tools: Add aux_start_paused, aux_pause and aux_resume
Date: Tue, 22 Oct 2024 18:59:11 +0300
Message-ID: <20241022155920.17511-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022155920.17511-1-adrian.hunter@intel.com>
References: <20241022155920.17511-1-adrian.hunter@intel.com>
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
index 4842c36fdf80..0524d541d4e3 100644
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
2.43.0

