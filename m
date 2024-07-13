Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF413A403;
	Sat, 13 Jul 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889768; cv=none; b=dAbpbPa88P+XRGeEOz/McrYZWVORAwTx9SPuZoA3la5+p+tjCe/rdu8zVHzGAhEWHGLn3nOgc3hGYRcQxueR+BMD4Egxo5bJaL+hKjgipNbtGHim61U2xYufXfDqRNbyqWQU5bimmYd39f9gvvJtogA7qcYAlX/GrWb0FXXM0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889768; c=relaxed/simple;
	bh=F9uP4rt8fGpXfaLpsUEwoBnPn+QKtAdZX4U20gAtHpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DI06WMyEO5WA2BTSy18f0ZcMEIuIUpeGL7DYK/LB/Vk7T4QeuXtsuQX84BXYNd1Vgu5t42hAHIzZlMEnY3tTifkeCF6+5VCvChwy+MjFeRopZ5U6/teBo/BYy2f6bUeUnc2gVBYQWWmDwpgqQY89Ne7mhAH+xl1U3qAkV1ANMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kAE+EcNH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kAE+EcNH"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DGKP3h012821;
	Sat, 13 Jul 2024 16:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=kQC5VTKaMX+Uc
	BgJ2AWgO2ehiJXqCbQEXoK+CylhJLA=; b=kAE+EcNHaV44YlNPanVNPvhjM+hbQ
	SHEakUl+eLiFDeJjDxi4kuYXsn20qyu/ou7KMr2vdX8vy+Sez8ia0ToBtZ9TE1i0
	39HjOOFgPw9hFKGTExw0xZPVgxGRHJdKQXyoPfkgc/XNfAR3F/Z8UEHLgJcYpIzo
	DVQjt/0eCFoMpjdWRlQlEJBFTxnQyUzpDz2KsT01P9Oc5GKCLU09uXuvpB02mCQc
	0FUz3gCqesqTTG0oO3aKiKqYoXMAWjmDXD6K9BdxDit3SYmmgJStP9CwmPFgkFrh
	CgWjRUkAU+AkeRN3eOACnVe1qgB0UeeXt9y3dqTMQibhgRcK5go3XJUtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bv8gg3tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:55:47 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46DGtkrS029509;
	Sat, 13 Jul 2024 16:55:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bv8gg3td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:55:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46DFZVaK010225;
	Sat, 13 Jul 2024 16:55:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40bqxks5n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:55:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46DGtd5U52166942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 16:55:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 469C020040;
	Sat, 13 Jul 2024 16:55:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 764C520063;
	Sat, 13 Jul 2024 16:55:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.134])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jul 2024 16:55:36 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V7 01/18] tools/perf: Move the data structures related to register type to header file
Date: Sat, 13 Jul 2024 22:25:12 +0530
Message-Id: <20240713165529.59298-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240713165529.59298-1-atrajeev@linux.vnet.ibm.com>
References: <20240713165529.59298-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZmS1MO7Vvc0kE9auZ6_nuPCxyo_U0j-t
X-Proofpoint-ORIG-GUID: EaEOYvmETzZUi7_0mCRLquGuheUf16O6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407130127

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

