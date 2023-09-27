Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3B2FB6
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 03:24:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D519027;
	Tue, 26 Sep 2023 20:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695785084; x=1727321084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BI0wCz5Y1/hfopD6qA0qFJQF81Z7fbGbcwe5ACKj33k=;
  b=G4o3LJ2lC2MlRxGMNuIcZJlBi0vzEPkSw21zyytmHghA5iEP5im6JO40
   7sHaGoz2XYxuCbJBS+6VCYIRmI84YqmoI7yPXXWhFkCl5YjXsK3YELO+v
   5bSl/bYXmAsTIu5+hbtrXldJqIY2gnzAkF9IpiIb5+reRKuIQkUwHVVn0
   7g8gM9zAmx9WiZzyEX02ZOXKjWoxAma6woKflXeZhVAZUb9sPq1hDCW21
   qNSLLSA+myr6mll90XedAgwnAt/yO786bjtnSHrqRt0khKsIhUzm/SXlK
   iBKC4GLPkVfLeCpDiEqPIGZFxHk0QThfLiZtZmt5Bo5nvvgk1KUZNe/yK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366780803"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366780803"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 20:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864637161"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="864637161"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2023 20:24:39 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>,
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
Cc: kvm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhang Xiong <xiong.y.zhang@intel.com>,
	Lv Zhiyuan <zhiyuan.lv@intel.com>,
	Yang Weijiang <weijiang.yang@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 06/13] perf/x86: Fix typos and inconsistent indents in perf_event header
Date: Wed, 27 Sep 2023 11:31:17 +0800
Message-Id: <20230927033124.1226509-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927033124.1226509-1-dapeng1.mi@linux.intel.com>
References: <20230927033124.1226509-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

