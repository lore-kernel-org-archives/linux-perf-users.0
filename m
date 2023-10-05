Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A56E41220
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+r21PKZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88AEEB;
	Thu,  5 Oct 2023 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696532794; x=1728068794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/M0BXFayBhHOB8YBHRkLZxRHjkjjHcYFaqoHoxPtxBQ=;
  b=J+r21PKZg31aA1D3j2yjmnf2dI5vC479k4oUjpSD4XIf/QaeySprDkfX
   nE1CWAcuk0BDBOK3T7XQmpBJyVLK1yb462D07g0Pef8BvhBdbcsHsczkJ
   BhSpUkJs4O5r7PxxGVPvG+kLvBg/V61LPiZAiZOgJKPW2yxKoCgI4iCdC
   ELdoAWjOEc1mDz1afz9812v5AIP6lwv7bJdRX+lyJltarEg9dOy6ycxDA
   /3Uup9+Y57fSr0BDIgRrr6DwQJm3YISXR0/EvjhzQnGT9dfiEtQaACwQP
   qm5kkfpwfSu/wRo3r8ZfNkO5om/PgfP6uznx42/anIdi6T3umfEpvrbE/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383488235"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383488235"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999055112"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999055112"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.35.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:12 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/5] perf intel-pt: Simplify intel_pt_get_vmcs()
Date: Thu,  5 Oct 2023 22:04:48 +0300
Message-Id: <20231005190451.175568-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005190451.175568-1-adrian.hunter@intel.com>
References: <20231005190451.175568-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simplify and remove unnecessary constant expressions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c    | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index af9710622a1f..249610cc9284 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -131,19 +131,14 @@ static int intel_pt_get_cbr(const unsigned char *buf, size_t len,
 static int intel_pt_get_vmcs(const unsigned char *buf, size_t len,
 			     struct intel_pt_pkt *packet)
 {
-	unsigned int count = (52 - 5) >> 3;
-
-	if (count < 1 || count > 7)
-		return INTEL_PT_BAD_PACKET;
-
-	if (len < count + 2)
+	if (len < 7)
 		return INTEL_PT_NEED_MORE_BYTES;
 
 	packet->type = INTEL_PT_VMCS;
-	packet->count = count;
-	memcpy_le64(&packet->payload, buf + 2, count);
+	packet->count = 5;
+	memcpy_le64(&packet->payload, buf + 2, 5);
 
-	return count + 2;
+	return 7;
 }
 
 static int intel_pt_get_ovf(struct intel_pt_pkt *packet)
-- 
2.34.1

