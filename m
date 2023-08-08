Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AB8C41513
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Aug 2023 19:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjHHTCi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjHHTBy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Aug 2023 15:01:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AAC187EB1;
        Tue,  8 Aug 2023 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691515901; x=1723051901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BI0wCz5Y1/hfopD6qA0qFJQF81Z7fbGbcwe5ACKj33k=;
  b=glbnkBclzXSDsID57KE/WICXqYBWP18bhv39X3c55MT9Ek0N2Ct7xIzK
   v6oxRDD0448icuxAtoSrLgIDCa5uGYyzXaIgu3sUn/3gPKXVSxuOwWGCA
   VQLW4ooyZ5aqX84uGHOhbRkoIbpudZY2IrzBAx+vGREhuYTLp8Rua+HfN
   wrGMwSKshchDtpDP6fDH9SKfvwVxldnwWCztKmNpCpQ3iD09sSoZWU2Ee
   I5tQwFK8d07bTOe+SShCn+p6HXo1mw2cUcC5ZzeAWdFreQSWFrwxQDR+P
   uTMclUdSoCxxu9YIDrE0qRW4qUAeZHw2AiqBAgBuY9+qoqeKCxXkvgaHp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434582052"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="434582052"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 23:26:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="734377740"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="734377740"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by fmsmga007.fm.intel.com with ESMTP; 07 Aug 2023 23:26:50 -0700
From:   Dapeng Mi <dapeng1.mi@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Like Xu <likexu@tencent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Lv Zhiyuan <zhiyuan.lv@intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>,
        Dapeng Mi <dapeng1.mi@intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH RFV v2 06/13] perf/x86: Fix typos and inconsistent indents in perf_event header
Date:   Tue,  8 Aug 2023 14:31:04 +0800
Message-Id: <20230808063111.1870070-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808063111.1870070-1-dapeng1.mi@linux.intel.com>
References: <20230808063111.1870070-1-dapeng1.mi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There is one typo and some inconsistent indents in perf_event.h header
file. Fix them.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/perf_event.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 85a9fd5a3ec3..63e1ce1f4b27 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -386,15 +386,15 @@ static inline bool is_topdown_idx(int idx)
  *
  * With this fake counter assigned, the guest LBR event user (such as KVM),
  * can program the LBR registers on its own, and we don't actually do anything
- * with then in the host context.
+ * with them in the host context.
  */
-#define INTEL_PMC_IDX_FIXED_VLBR	(GLOBAL_STATUS_LBRS_FROZEN_BIT)
+#define INTEL_PMC_IDX_FIXED_VLBR		(GLOBAL_STATUS_LBRS_FROZEN_BIT)
 
 /*
  * Pseudo-encoding the guest LBR event as event=0x00,umask=0x1b,
  * since it would claim bit 58 which is effectively Fixed26.
  */
-#define INTEL_FIXED_VLBR_EVENT	0x1b00
+#define INTEL_FIXED_VLBR_EVENT			0x1b00
 
 /*
  * Adaptive PEBS v4
-- 
2.34.1

