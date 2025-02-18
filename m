Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA823FC67;
	Tue, 18 Feb 2025 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866522; cv=none; b=hACNVcNDGSlJHpZ+/Nb/lGOp/vLf6m0nZw3iAMihgKjb+l48w8BRcpJvC1ElyWQ48/U4cAihYECwjNWt97MbRLmlxKACoszCWH9aVlKLp/uLIYqRQ4aNxwiiY/CJJE6eVolWaThKJrFQYYbYDnyj2keOG1GNbSd8zI447mPKbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866522; c=relaxed/simple;
	bh=/pg+nNMfML1XB0+IQ7KNXLwtQmJ6IriCGs7j9y+MwZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSgGEgX/Sqb8EncgZ14xdqKm85ChZ4In4kLZWea4gi9yMSZTZBOUjL92HGtJAnECm2zj9pI797tdHgZvgO7sOVwRTRdEpl1kbmCsoHUwIJGooa4+NAEOsH+EszD7ffJksX8PNshJ3Cj3SfczZPNCz2HVULNwXJKYa6PH3tasvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvZ5+6n7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvZ5+6n7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866522; x=1771402522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/pg+nNMfML1XB0+IQ7KNXLwtQmJ6IriCGs7j9y+MwZw=;
  b=AvZ5+6n7daUtjM8uYTTBw6GdWqmSSc1hctROmxTRx1L6T/Eh64b+2E55
   rYpmPM4AeZ4Y2SkeOo6LmFILm6SRnmB4x0tUw5qXsVCpxgQ7sPQk18Rsi
   4LMQrTaCnUIAVSY1RukmRJanxu9EmCHHBX+JGOrgVqNBrVxbupuIELd5h
   kDGaXDcF6HMq3KvBP4F1abJBEarnagfTh3a1Yy8NXbU9w0ibnzOOiK28Y
   46L7HZG2g8IWfe0UgLWFnnrqukIR0q5tL2weXL/6QeQ037aw3u9/xXuFF
   Y4LaXz7Rz1UsBWc7sfbz7xOjbjlGUSESS6t/6pDjEyEAAPV1vPeV3FFhl
   Q==;
X-CSE-ConnectionGUID: TY3dZkMlSkKqfQkE3gQo1Q==
X-CSE-MsgGUID: +4VnSjhDT0GCwQLotuxalw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200912"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200912"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:15:22 -0800
X-CSE-ConnectionGUID: 5ecgc/4IQnCPXPE+q60bcg==
X-CSE-MsgGUID: s2Fv6RI0SCmKoB461wMzMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166390"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:15:17 -0800
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
Subject: [Patch v2 24/24] perf tools: Fix incorrect --user-regs comments
Date: Tue, 18 Feb 2025 15:28:18 +0000
Message-Id: <20250218152818.158614-25-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment of "--user-regs" option is not correct, fix it.

"on interrupt," -> "on user space,"

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5db1aedf48df..c3b1ea2d2eae 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3471,7 +3471,7 @@ static struct option __record_options[] = {
 		    "sample selected machine registers on interrupt,"
 		    " use '-I?' to list register names", parse_intr_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
-		    "sample selected machine registers on interrupt,"
+		    "sample selected machine registers on user space,"
 		    " use '--user-regs=?' to list register names", parse_user_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
-- 
2.40.1

