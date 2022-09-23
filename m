Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF87C6FA90
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 08:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIWILf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiIWILe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 04:11:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC3412C1C2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 01:11:32 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYlB12YT3zlWqL;
        Fri, 23 Sep 2022 16:07:21 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 16:11:31 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 16:11:30 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <yao.jin@linux.intel.com>, <shangxiaojing@huawei.com>
Subject: [PATCH v2 6/6] perf script: Add perf_sample__fprintf_dsoname helper
Date:   Fri, 23 Sep 2022 16:45:40 +0800
Message-ID: <20220923084540.25849-7-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220923084540.25849-1-shangxiaojing@huawei.com>
References: <20220923084540.25849-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Wrap repeated code in helper function perf_sample__fprintf_dsoname(),
which prints the dsoname and parentheses to the file, then return the
printed size.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
changes in v2:
- new patch since v1
---
 tools/perf/builtin-script.c | 65 +++++++++++++++----------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 886f53cfa257..9487c10135ec 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -885,6 +885,19 @@ static int print_bstack_flags(FILE *fp, struct branch_entry *br)
 		       get_branch_type(br));
 }
 
+static int perf_sample__fprintf_dsoname(struct perf_event_attr *attr,
+					 struct map *map, FILE *fp)
+{
+	int printed = 0;
+
+	if (PRINT_FIELD(DSO)) {
+		printed += fprintf(fp, "(");
+		printed += map__fprintf_dsoname(map, fp);
+		printed += fprintf(fp, ")");
+	}
+	return printed;
+}
+
 static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 					struct thread *thread,
 					struct perf_event_attr *attr, FILE *fp)
@@ -910,18 +923,10 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 		}
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alf.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		printed += perf_sample__fprintf_dsoname(attr, alf.map, fp);
 
 		printed += fprintf(fp, "/0x%"PRIx64, to);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alt.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		printed += perf_sample__fprintf_dsoname(attr, alt.map, fp);
 
 		printed += print_bstack_flags(fp, entries + i);
 	}
@@ -953,18 +958,10 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alf.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		printed += perf_sample__fprintf_dsoname(attr, alf.map, fp);
 		printed += fprintf(fp, "%c", '/');
 		printed += symbol__fprintf_symname_offs(alt.sym, &alt, fp);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alt.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		printed += perf_sample__fprintf_dsoname(attr, alt.map, fp);
 		printed += print_bstack_flags(fp, entries + i);
 	}
 
@@ -1000,17 +997,9 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 			to = map__map_ip(alt.map, to);
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alf.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		printed += perf_sample__fprintf_dsoname(attr, alf.map, fp);
 		printed += fprintf(fp, "/0x%"PRIx64, to);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alt.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		printed += perf_sample__fprintf_dsoname(attr, alt.map, fp);
 		printed += print_bstack_flags(fp, entries + i);
 	}
 
@@ -1372,11 +1361,9 @@ static int perf_sample__fprintf_addr(struct perf_sample *sample,
 			printed += symbol__fprintf_symname(al.sym, fp);
 	}
 
-	if (PRINT_FIELD(DSO)) {
-		printed += fprintf(fp, " (");
-		printed += map__fprintf_dsoname(al.map, fp);
-		printed += fprintf(fp, ")");
-	}
+	if (PRINT_FIELD(DSO))
+		printed += fprintf(fp, " ");
+	printed += perf_sample__fprintf_dsoname(attr, al.map, fp);
 out:
 	return printed;
 }
@@ -1435,10 +1422,10 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 
 	name = resolve_branch_sym(sample, evsel, thread, al, addr_al, &ip);
 
-	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
-		dlen += fprintf(fp, "(");
-		dlen += map__fprintf_dsoname(al->map, fp);
-		dlen += fprintf(fp, ")\t");
+	if (!(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
+		dlen += perf_sample__fprintf_dsoname(attr, al->map, fp);
+		if (PRINT_FIELD(DSO))
+			dlen += fprintf(fp, "\t");
 	}
 
 	if (name)
-- 
2.17.1

