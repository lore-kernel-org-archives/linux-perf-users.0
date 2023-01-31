Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E183CC636CC
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Jan 2023 13:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjAaNQu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjAaNQt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Jan 2023 08:16:49 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A753401A;
        Tue, 31 Jan 2023 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675171008; x=1706707008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PgoaMa5uG1on8jbmDVSgzzslCJYjltgwG8UjBjeDNrE=;
  b=h4K8YnoI+cdSsw9JmRrEGtkP7mLHgsKsWBl9fogKRN67MI/+uv6fJTIX
   7mkLtKsVCcWWf8a46vPRz7ipgO5xgCHBqHKEU0wXTz0QDK9w0yv4O1xgN
   HSNBjj8AhLr+PtHdUbrRNvrr8+FN9lO1HyNQQDLg0eph5U1CiAzIceVmg
   WeUPo0PNkGgd2vhImCEf8xYupvmLKp6aOQrbXbbwOLGPtDDSirAlU38cr
   r5BK2WTiyssxb2rh1MGO2pXm4zfF3nsC2AtnP8BgpLuKoiaY8+/ieYULt
   e2l9rCRHO9zDN/+S2zb3UbdsMJpLAj/4s9ZnUYEJYX2EcPw76PNS6prqR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325534169"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325534169"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657864813"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657864813"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.47.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:45 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 4/9] perf symbols: Record whether a symbol is an alias for an IFUNC symbol
Date:   Tue, 31 Jan 2023 15:16:20 +0200
Message-Id: <20230131131625.6964-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131131625.6964-1-adrian.hunter@intel.com>
References: <20230131131625.6964-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

To assist with synthesizing plt symbols for IFUNCs, record whether a
symbol is an alias of an IFUNC symbol.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol.c | 4 ++++
 tools/perf/util/symbol.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a024f06f75d8..d05727fcb30d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -201,10 +201,14 @@ void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 			continue;
 
 		if (choose_best_symbol(curr, next) == SYMBOL_A) {
+			if (next->type == STT_GNU_IFUNC)
+				curr->ifunc_alias = true;
 			rb_erase_cached(&next->rb_node, symbols);
 			symbol__delete(next);
 			goto again;
 		} else {
+			if (curr->type == STT_GNU_IFUNC)
+				next->ifunc_alias = true;
 			nd = rb_next(&curr->rb_node);
 			rb_erase_cached(&curr->rb_node, symbols);
 			symbol__delete(curr);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 2fdeb22bd02f..7558735543c2 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -64,6 +64,8 @@ struct symbol {
 	u8		inlined:1;
 	/** Has symbol__annotate2 been performed. */
 	u8		annotate2:1;
+	/** Symbol is an alias of an STT_GNU_IFUNC */
+	u8		ifunc_alias:1;
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
 	/** The name of length namelen associated with the symbol. */
-- 
2.34.1

