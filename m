Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5917C61;
	Mon,  1 Jul 2024 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808500; cv=none; b=ki7FHhI4JuTovglOLZbUypmfMMzGGyGHGCIkNKTBSN4fhJz+Om6NY3aA1D58YoJ2hnCUbdPuJt4G2b47CYtfE0aeOuX9Q+j4KEMxRjEwx6JXxMm2w6jYVg9LpYCnj+W5X01oNxTzToagdM3od4J47+HvXTBlpvdms6avONdavYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808500; c=relaxed/simple;
	bh=F9uP4rt8fGpXfaLpsUEwoBnPn+QKtAdZX4U20gAtHpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4SxMOvJqrQAg6QNoD0/6WZ9BP6c75/u43j88oR0gm6D/7N2oSTlNeR00wSZSwRoqjISD6EaMJ3DK5OqBsfLsqkUbw2Y6ulTsJ2LvDKC91w1mKU+1Iz6RPjzg2PG+eCuxy+TfoEfLV2KOVVDT7nNSF8nXGJKpNJ+K95uxvUUxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZwNYIixf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZwNYIixf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4614QwHv016152;
	Mon, 1 Jul 2024 04:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=kQC5VTKaMX+Uc
	BgJ2AWgO2ehiJXqCbQEXoK+CylhJLA=; b=ZwNYIixfWTnQVn+ez/fO7xqIj8oWO
	xgCay9t6a3dNVYXhZrNnUiWb4VtJ1m2iCzo8NxZbbgveefuh7f6Gj4o2yX+DvWJl
	kvqgk4PRFQtTbkembuOUdNSBOlYXiB6Q/bs4Gts3vWhClEjTrUSPyszB6Jqpnu7W
	ZBwkbaf6/r105345l+ckHgMToFcOfEA30m2Bjy/ogh60031Yr07nMzcxb54KCfdk
	aNcizFCLLD7nj0rT8mIkoslPqxcobk8NtKOVPCViNGSuy7Nh9p4bx6jbOxehAw2E
	FJJLH0Be8G5VGsK0k2YQ3qsy2gzPiJbXuUgCbI4OA128NnvuuctvhygYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403mk084eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:34:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4614YkSb028891;
	Mon, 1 Jul 2024 04:34:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403mk084ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:34:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46142f5U026418;
	Mon, 1 Jul 2024 04:34:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpnb3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:34:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4614Ydrw46596410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 04:34:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D5412004B;
	Mon,  1 Jul 2024 04:34:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30EBB20040;
	Mon,  1 Jul 2024 04:34:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.21.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 04:34:35 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V5 01/17] tools/perf: Move the data structures related to register type to header file
Date: Mon,  1 Jul 2024 10:04:14 +0530
Message-Id: <20240701043430.66666-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
References: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RMGKwDP1UUljfECGBJTKEy-YpYJ4YOgi
X-Proofpoint-ORIG-GUID: XkWeeFcWOsusst5yaf5_YIVQm_-R5F-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_03,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010030

Data type profiling uses instruction tracking by checking each
instruction and updating the register type state in some data
structures. This is useful to find the data type in cases when the
register state gets transferred from one reg to another. Example, in
x86, "mov" instruction and in powerpc, "mr" instruction. Currently these
structures are defined in annotate-data.c and instruction tracking is
implemented only for x86. Move these data structures to
"annotate-data.h" header file so that other arch implementations can use
it in arch specific files as well.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/annotate-data.c | 53 +------------------------------
 tools/perf/util/annotate-data.h | 56 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 965da6c0b542..a4c7f98a75e3 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -31,15 +31,6 @@
 
 static void delete_var_types(struct die_var_type *var_types);
 
-enum type_state_kind {
-	TSR_KIND_INVALID = 0,
-	TSR_KIND_TYPE,
-	TSR_KIND_PERCPU_BASE,
-	TSR_KIND_CONST,
-	TSR_KIND_POINTER,
-	TSR_KIND_CANARY,
-};
-
 #define pr_debug_dtp(fmt, ...)					\
 do {								\
 	if (debug_type_profile)					\
@@ -140,49 +131,7 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
 	}
 }
 
-/*
- * Type information in a register, valid when @ok is true.
- * The @caller_saved registers are invalidated after a function call.
- */
-struct type_state_reg {
-	Dwarf_Die type;
-	u32 imm_value;
-	bool ok;
-	bool caller_saved;
-	u8 kind;
-};
-
-/* Type information in a stack location, dynamically allocated */
-struct type_state_stack {
-	struct list_head list;
-	Dwarf_Die type;
-	int offset;
-	int size;
-	bool compound;
-	u8 kind;
-};
-
-/* FIXME: This should be arch-dependent */
-#define TYPE_STATE_MAX_REGS  16
-
-/*
- * State table to maintain type info in each register and stack location.
- * It'll be updated when new variable is allocated or type info is moved
- * to a new location (register or stack).  As it'd be used with the
- * shortest path of basic blocks, it only maintains a single table.
- */
-struct type_state {
-	/* state of general purpose registers */
-	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
-	/* state of stack location */
-	struct list_head stack_vars;
-	/* return value register */
-	int ret_reg;
-	/* stack pointer register */
-	int stack_reg;
-};
-
-static bool has_reg_type(struct type_state *state, int reg)
+bool has_reg_type(struct type_state *state, int reg)
 {
 	return (unsigned)reg < ARRAY_SIZE(state->regs);
 }
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 0a57d9f5ee78..cdb5cd8960bb 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -6,6 +6,11 @@
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
 #include <linux/types.h>
+#include "annotate.h"
+
+#ifdef HAVE_DWARF_SUPPORT
+#include "debuginfo.h"
+#endif
 
 struct annotated_op_loc;
 struct debuginfo;
@@ -15,6 +20,15 @@ struct hist_entry;
 struct map_symbol;
 struct thread;
 
+enum type_state_kind {
+	TSR_KIND_INVALID = 0,
+	TSR_KIND_TYPE,
+	TSR_KIND_PERCPU_BASE,
+	TSR_KIND_CONST,
+	TSR_KIND_POINTER,
+	TSR_KIND_CANARY,
+};
+
 /**
  * struct annotated_member - Type of member field
  * @node: List entry in the parent list
@@ -143,6 +157,47 @@ struct annotated_data_stat {
 extern struct annotated_data_stat ann_data_stat;
 
 #ifdef HAVE_DWARF_SUPPORT
+/*
+ * Type information in a register, valid when @ok is true.
+ * The @caller_saved registers are invalidated after a function call.
+ */
+struct type_state_reg {
+	Dwarf_Die type;
+	u32 imm_value;
+	bool ok;
+	bool caller_saved;
+	u8 kind;
+};
+
+/* Type information in a stack location, dynamically allocated */
+struct type_state_stack {
+	struct list_head list;
+	Dwarf_Die type;
+	int offset;
+	int size;
+	bool compound;
+	u8 kind;
+};
+
+/* FIXME: This should be arch-dependent */
+#define TYPE_STATE_MAX_REGS  16
+
+/*
+ * State table to maintain type info in each register and stack location.
+ * It'll be updated when new variable is allocated or type info is moved
+ * to a new location (register or stack).  As it'd be used with the
+ * shortest path of basic blocks, it only maintains a single table.
+ */
+struct type_state {
+	/* state of general purpose registers */
+	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
+	/* state of stack location */
+	struct list_head stack_vars;
+	/* return value register */
+	int ret_reg;
+	/* stack pointer register */
+	int stack_reg;
+};
 
 /* Returns data type at the location (ip, reg, offset) */
 struct annotated_data_type *find_data_type(struct data_loc_info *dloc);
@@ -160,6 +215,7 @@ void global_var_type__tree_delete(struct rb_root *root);
 
 int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
 
+bool has_reg_type(struct type_state *state, int reg);
 #else /* HAVE_DWARF_SUPPORT */
 
 static inline struct annotated_data_type *
-- 
2.43.0

