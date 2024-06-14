Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB471AC42C;
	Fri, 14 Jun 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386063; cv=none; b=YvDnpJT9pcsx8stCT/FPT2hNWTgCJbUKieXsKZe2lfYc0M5qCVoqzz32pmHQa3LZUKptS4HMYgrN8TY1P1RS6dQ7R5cb9p5k4qyIlgNvTz3gvsiI4Emw5ymnFzbjQt532m5o3WK21GbUunu14jemj0a8B7CYnCMqs6vZVWS75aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386063; c=relaxed/simple;
	bh=OXx7QUD9etvoANquCrQMv+C9ub+57I0kOsXdanWULuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSq99Z6sfcHcaWkHp0EWQpEJVMs4wsjSF/drGBE9SjdJ53hdxGVOZBDaaF8AvfpCbYETY8RCIfL7c2c9igkQ2yrCyPmiQkfqB4SYtO2+tKccfVDG1mZN9EkgjVRhNYhONPIikMT9owagnVqCjNoQK5mEbSAOjuH236T8pGhgH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xa2Y5rMN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xa2Y5rMN"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EGc7xb009726;
	Fri, 14 Jun 2024 17:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=GpQ484FOzeOKZ
	FyAoHEWhMevDvvkyS0kxUopNu/FT9Q=; b=Xa2Y5rMNNt760/tduzY1TRi2mNqRl
	5Rwox6DFIOv4IrMZ4YRTjR7M2wRzlrNXBVx1Ac8+OKriGZKtFmQcthHW1BiY4rvl
	EeMBSaiCbO1VIwMf/5y6+lJTSa61FpmgEx+yAixSrQ73E6huZH2A1gTB28VXdaMT
	e61iw5iPG9SkAGGOnPyhJIpyjf4DvWT4N/PCwxndb9UL6wBa8xiUdr9u1nsMyG0U
	VtoP3SBtVhSJ6kDMB6fiz67bhEWPi4D7qbp6ytI3FhAS7kPdia2eOH4AjZgyl2XA
	UvCvK+47K6muStpkwq1mDgOIms6K95L62+3rnOSkOErVmjJckeWop2ihA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrsja85gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:31 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45EHRVwo026328;
	Fri, 14 Jun 2024 17:27:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrsja85gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45EFZrF1008701;
	Fri, 14 Jun 2024 17:27:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn4b4309q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45EHRPp613107536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 17:27:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F264F20040;
	Fri, 14 Jun 2024 17:27:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 329482004E;
	Fri, 14 Jun 2024 17:27:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.82.18])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 17:27:22 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [V4 14/16] tools/perf: Add support to find global register variables using find_data_type_global_reg
Date: Fri, 14 Jun 2024 22:56:29 +0530
Message-Id: <20240614172631.56803-15-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lDVWUKcnnYDF7DoDsjX5iFo-rRzKiqzs
X-Proofpoint-GUID: 9HH_prXftfJLRtxpqYsHSSAP5yxSsL08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140119

There are cases where define a global register variable and associate it
with a specified register. Example, in powerpc, two registers are
defined to represent variable:
1. r13: represents local_paca
register struct paca_struct *local_paca asm("r13");

2. r1: represents stack_pointer
register void *__stack_pointer asm("r1");

These regs are present in dwarf debug as DW_OP_reg as part of variables
in the cu_die (compile unit). These are not present in die search done
in the list of nested scopes since these are global register variables.

Example for local_paca represented by r13:

<<>>
 <1><18dc6b4>: Abbrev Number: 128 (DW_TAG_variable)
    <18dc6b6>   DW_AT_name        : (indirect string, offset: 0x3861): local_paca
    <18dc6ba>   DW_AT_decl_file   : 48
    <18dc6bb>   DW_AT_decl_line   : 36
    <18dc6bc>   DW_AT_decl_column : 30
    <18dc6bd>   DW_AT_type        : <0x18dc6c3>
    <18dc6c1>   DW_AT_external    : 1
    <18dc6c1>   DW_AT_location    : 1 byte block: 5d    (DW_OP_reg13 (r13))

 <1><18dc6c3>: Abbrev Number: 3 (DW_TAG_pointer_type)
    <18dc6c4>   DW_AT_byte_size   : 8
    <18dc6c4>   DW_AT_type        : <0x18dc353>

Where  DW_AT_type : <0x18dc6c3> further points to :

 <1><18dc6c3>: Abbrev Number: 3 (DW_TAG_pointer_type)
    <18dc6c4>   DW_AT_byte_size   : 8
    <18dc6c4>   DW_AT_type        : <0x18dc353>

which belongs to:

 <1><18dc353>: Abbrev Number: 67 (DW_TAG_structure_type)
    <18dc354>   DW_AT_name        : (indirect string, offset: 0x56cd): paca_struct
    <18dc358>   DW_AT_byte_size   : 2944
    <18dc35a>   DW_AT_alignment   : 128
    <18dc35b>   DW_AT_decl_file   : 48
    <18dc35c>   DW_AT_decl_line   : 61
    <18dc35d>   DW_AT_decl_column : 8
    <18dc35d>   DW_AT_sibling     : <0x18dc6b4>
<<>>

Similar is case with "r1".

<<>>
 <1><18dd772>: Abbrev Number: 129 (DW_TAG_variable)
    <18dd774>   DW_AT_name        : (indirect string, offset: 0x11ba): current_stack_pointer
    <18dd778>   DW_AT_decl_file   : 51
    <18dd779>   DW_AT_decl_line   : 1468
    <18dd77b>   DW_AT_decl_column : 24
    <18dd77c>   DW_AT_type        : <0x18da5cd>
    <18dd780>   DW_AT_external    : 1
    <18dd780>   DW_AT_location    : 1 byte block: 51    (DW_OP_reg1 (r1))

 where 18da5cd is:

 <1><18da5cd>: Abbrev Number: 47 (DW_TAG_base_type)
    <18da5ce>   DW_AT_byte_size   : 8
    <18da5cf>   DW_AT_encoding    : 7   (unsigned)
    <18da5d0>   DW_AT_name        : (indirect string, offset: 0x55c7): long unsigned int
<<>>

To identify data type for these two special cases, iterate over
variables in the CU die (Compile Unit) and match it with the register.
If the variable is a base type, ie die_get_real_type will return NULL
here, set offset to zero. With the changes, data type for "paca_struct"
and "long unsigned int" for r1 is identified.

Snippet from ./perf report -s type,type_off

    12.85%  long unsigned int  long unsigned int +0 (no field)
     4.68%  struct paca_struct  struct paca_struct +2312 (__current)
     4.57%  struct paca_struct  struct paca_struct +2354 (irq_soft_mask)

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/annotate-data.c      | 40 ++++++++++++++++++++++++++++
 tools/perf/util/annotate.c           |  8 ++++++
 tools/perf/util/annotate.h           |  1 +
 tools/perf/util/include/dwarf-regs.h |  1 +
 4 files changed, 50 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 734acdd8c4b7..82232f2d8e16 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1170,6 +1170,40 @@ static int find_data_type_block(struct data_loc_info *dloc,
 	return ret;
 }
 
+/*
+ * Handle cases where define a global register variable and
+ * associate it with a specified register. These regs are
+ * present in dwarf debug as DW_OP_reg as part of variables
+ * in the cu_die (compile unit). Iterate over variables in the
+ * cu_die and match with reg to identify data type die.
+ */
+static int find_data_type_global_reg(struct data_loc_info *dloc, int reg, Dwarf_Die *cu_die,
+		Dwarf_Die *type_die)
+{
+	Dwarf_Die vr_die;
+	int ret = -1;
+	struct die_var_type *var_types = NULL;
+
+	die_collect_vars(cu_die, &var_types);
+	while (var_types) {
+		if (var_types->reg == reg) {
+			if (dwarf_offdie(dloc->di->dbg, var_types->die_off, &vr_die)) {
+				if (die_get_real_type(&vr_die, type_die) == NULL) {
+					dloc->type_offset = 0;
+					dwarf_offdie(dloc->di->dbg, var_types->die_off, type_die);
+				}
+				pr_debug_type_name(type_die, TSR_KIND_TYPE);
+				ret = 0;
+				pr_debug_dtp("found by CU for %s (die:%#lx)\n",
+						dwarf_diename(type_die), (long)dwarf_dieoffset(type_die));
+			}
+			break;
+		}
+		var_types = var_types->next;
+	}
+	return ret;
+}
+
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
@@ -1217,6 +1251,12 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	pr_debug_dtp("CU for %s (die:%#lx)\n",
 		     dwarf_diename(&cu_die), (long)dwarf_dieoffset(&cu_die));
 
+	if (loc->reg_type == DWARF_REG_GLOBAL) {
+		ret = find_data_type_global_reg(dloc, reg, &cu_die, type_die);
+		if (!ret)
+			goto out;
+	}
+
 	if (reg == DWARF_REG_PC) {
 		if (get_global_var_type(&cu_die, dloc, dloc->ip, dloc->var_addr,
 					&offset, type_die)) {
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bfa6420dc4b9..c7e4fd16e8b4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2431,6 +2431,14 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 			op_loc->reg1 = DWARF_REG_PC;
 		}
 
+		/* Global reg variable 13 and 1
+		 * assign to DWARF_REG_GLOBAL
+		 */
+		if (arch__is(arch, "powerpc")) {
+			if ((op_loc->reg1 == 13) || (op_loc->reg1 == 1))
+				op_loc->reg_type = DWARF_REG_GLOBAL;
+		}
+
 		mem_type = find_data_type(&dloc);
 
 		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 9ba772f46270..ad69842a8ebc 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -475,6 +475,7 @@ struct annotated_op_loc {
 	bool mem_ref;
 	bool multi_regs;
 	bool imm;
+	int reg_type;
 };
 
 enum annotated_insn_ops {
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 7ea39362ecaf..a873c906a86b 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -5,6 +5,7 @@
 
 #define DWARF_REG_PC  0xd3af9c /* random number */
 #define DWARF_REG_FB  0xd3affb /* random number */
+#define DWARF_REG_GLOBAL 0xd3affc /* random number */
 
 #ifdef HAVE_DWARF_SUPPORT
 const char *get_arch_regstr(unsigned int n);
-- 
2.43.0

