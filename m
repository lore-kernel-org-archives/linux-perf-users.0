Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB37FBDF;
	Fri, 31 May 2024 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135108; cv=none; b=pWCGOIG+V3aj60aNT88/zP6eZxn76NzoQH9FjtWbqDZcY9xr+pgbpFppfb12ESmllsdlI1KHXoAJEQaD1u4V3sHRQ3NXNzd6XHp2QliInteqyU1TNaiic9KXN9EpaviFHyOWiJP9JFp3hTfJYrVpRODAULRSwiAEbntE8dqZ2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135108; c=relaxed/simple;
	bh=Vc4onBiyA081mqZ+u8spT9LVIyOZyH6KyTqbDavfdDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3d2oWsNWeoTohYj+y+T2w9DRvbNPnKUXgq7Y/yaAtQwoDmXFghep4wkSG04zFDDX/d7O6LeMtz0gjTLOSAokkkfcwWUUdRv5fo6clWO/A6guaBdraNOEdcBN9B0Rn5kY0Qbv6iQUjF0zs6OdjZlhMGxtgEzE6VfPHo7WtSsJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHJBf1Xp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHJBf1Xp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717135107; x=1748671107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vc4onBiyA081mqZ+u8spT9LVIyOZyH6KyTqbDavfdDU=;
  b=IHJBf1Xp27CeShrhUOkv2py3SE3qiUAkGFDSa04ZEgcZHjnXXvKvaD4a
   O006wM1y3PCHxzrjkRv0XtJg3thDzP3kHu8Bdd0HnjjtvwplmU3UqpxYF
   E+tME2eoNPc4HN8tgE/BVsEX2nC0iwo7rmDJIgSopDDfrauslVDdzJQKq
   kMhwt8+DTPCq5joW7C0qPHmE8HrJV2R9UI2SOqpYT+iWOfUA+Jq+xeZwf
   ncK8O6iQ9ZV0HJV+5kWBBRbx+6TJPdqh5fvMTnSf7W7NoBi49leF0hO2A
   86Wysn++o4nwAKJpNjflZiGzHz6czKqrYGq48qJlACwPGrdT1cscMjecl
   w==;
X-CSE-ConnectionGUID: rQeoKzcJT4OwFnBLWPn6RA==
X-CSE-MsgGUID: DHvtsmAMThiB+7laI2Hoxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25068231"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25068231"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:23 -0700
X-CSE-ConnectionGUID: 4Lo1yoUgQ76+2TZnAwteTw==
X-CSE-MsgGUID: ZyuBHiWTQoaHUOL4nyDgUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40510928"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.41.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:19 -0700
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
Subject: [PATCH V7 06/12] perf tools: Add aux_start_paused, aux_pause and aux_resume
Date: Fri, 31 May 2024 08:57:25 +0300
Message-Id: <20240531055731.12541-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531055731.12541-1-adrian.hunter@intel.com>
References: <20240531055731.12541-1-adrian.hunter@intel.com>
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

