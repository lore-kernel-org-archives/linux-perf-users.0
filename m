From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2] perf callchain: Compare dsos (as well) for CCKEY_FUNCTION
Date: Thu,  5 Oct 2017 14:42:34 +0530
Message-ID: <20171005091234.5874-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20171005041355.GB1584@danjae.aot.lge.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751672AbdJEJMs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Oct 2017 05:12:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9598p9m039176
        for <linux-perf-users@vger.kernel.org>; Thu, 5 Oct 2017 05:12:47 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ddeuc0y4n-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2017 05:12:46 -0400
Received: from localhost
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <ravi.bangoria@linux.vnet.ibm.com>;
        Thu, 5 Oct 2017 19:12:43 +1000
In-Reply-To: <20171005041355.GB1584@danjae.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: pozdneyev@gmail.com, acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com, ak@linux.intel.com, kjlx@templeofstupid.com, milian.wolff@kdab.com, zhangmengting@huawei.com, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Two functions from different binaries can have same start
address. Thus, comparing only start address in match_chain()
leads to inconsistent callchains. Fix this by adding a check
for dsos as well.

Ex, https://www.spinics.net/lists/linux-perf-users/msg04067.html

Reported-by: Alexander Pozdneev <pozdneyev@gmail.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v2:
  - Remove unnecessary checks for 'map'

 tools/perf/util/callchain.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index be09d77..a971caf 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -685,6 +685,8 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 {
 	struct symbol *sym = node->sym;
 	u64 left, right;
+	struct dso *left_dso = NULL;
+	struct dso *right_dso = NULL;
 
 	if (callchain_param.key == CCKEY_SRCLINE) {
 		enum match_result match = match_chain_srcline(node, cnode);
@@ -696,12 +698,14 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
 		left = cnode->ms.sym->start;
 		right = sym->start;
+		left_dso = cnode->ms.map->dso;
+		right_dso = node->map->dso;
 	} else {
 		left = cnode->ip;
 		right = node->ip;
 	}
 
-	if (left == right) {
+	if (left == right && left_dso == right_dso) {
 		if (node->branch) {
 			cnode->branch_count++;
 
-- 
1.8.3.1
