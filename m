Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA03DEADC
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895329; cv=none; b=GmLTd0VuVowZcvixdmXZ9R6ixVpRxL9uthxapIP/6iBDiH5Z7AWp2OoQTBIRHTbnbrSWi6HZRu8yw3zEQ+eTgTjk6IXN2zo5HyhszIvdtn+cSoh7mB7QpaI8zzQ8UVtsoBXDJ1G9FVzNgTDwqFw2NkwAa7V72yaESDUi6caezww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895329; c=relaxed/simple;
	bh=39FZCVMGumZTRxDDjBHCEvmLnmEbrU61duRrfOMb/YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leG9opThTPuchcrrENPVrFA4fBR4SMKCbwFnknF8JsMUzf6pvX4LXmIUOtWSxhD2if1J7LTK3iFoUfzGQ5lHSMgYgOiud59nREX70OM4EmuURq2fQbKDXNu4iUVSlE/m4GxHpakdnKSJ1nIUOIDWQwehfF4Kk6cxgj7RvwSxVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r0LN8hpP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r0LN8hpP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IGGa298737;
	Wed, 1 Jul 2026 08:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g2T0wyrKfiEMk0Mon
	yQUELxrAJMbhr4PjfD18naYzTQ=; b=r0LN8hpPsi4XUax1uJ2oC/vypuhgG93bf
	SRzDQ3Mx3odp7Ng3FcUY9C8u5u/Na/tcABEIE3+BRvDxic2y8f4r4096rS9lh8bj
	I2Jn5Kv8kLwKu3qsphv/Gz4GRfbqmH1jdBOueZgS7xha4ZLOzsTOM+SvWFsNFJig
	BKLde4HJY+aEGYtQIJ67FjcDL1tPNsqnrD1W4IEt8HSeSJK1um6OAtYAs/w8OeNp
	sl+NJCnWR/wldh9gA1TtwQqQvvOaUSsi0U/Al6MUxI+WZaaZtWwe7sOrJbhsc0RR
	qbIjxsZnci3WRoPxeO5/6k6rfOhvLkMMUwMJ0ubOGfVmI/vRM9eEA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5ufpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:42:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YoNk018135;
	Wed, 1 Jul 2026 08:42:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqemp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:42:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fwa553019034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E1D320043;
	Wed,  1 Jul 2026 08:41:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD0820040;
	Wed,  1 Jul 2026 08:41:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:55 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 9/9] tools/perf/powerpc: Add logical address in decoded traces
Date: Wed,  1 Jul 2026 14:11:15 +0530
Message-Id: <20260701084115.80383-10-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260701084115.80383-1-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfXwGsEZ4iLrKRo
 lFcCn2kVAFVjkCD8ek1J+q2Vyq2Bq9yE6reN+aNwznyr2mhNpvdO+257eZeuK+3mHPIetO6aQ1Z
 ex8+o8sJggkC2/f0Eb6p/BZfoepvRJ8IBMsCCGHNi703/fERUG7F47cSTxoW9njG8iv0DhhrZWA
 OEjTi1HrMaAO4Zo4/eoh5kONGjz1M8CeGxsObvxk3K8dYhGIO5xbvIEG+PT926uORjEJA/cRHP9
 YgJV4886SGA905XNtIS4Gzv7FbzK+CZNbkdhiYqyX65snmyxF1h9Owpvh6MqV2MF7CglI+sBwpL
 lJTIjDYLfRK/6Xn3lWmPgcRholjuryApKajxnNn84e3Q/JVZxi3cmglokFSMAMj+6EWsBZ1U6BX
 jPsxFpAUQVTmYzMGKscEIlTx7s+5/WNbzBhJ64db+jRbZwBujZcJvKiGpPEWbrhxrOtEf69blyY
 /IKkxxk7y+Cdqihc1gQ==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44d2db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=A_eqvsjfpbeckq1sgSgA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: TWkO6yGqx3ZJjinLtuMyAR5Yy6jhjlWw
X-Proofpoint-GUID: HTsi6dXjJNWA93BQP0rj2DZouVkNnmMw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX72+7p1A7vtHg
 h1BAQkmIhzWoZnZOackR2NozL8QKsiXTra+MoSBRorG4Lt1ODJ3x4iFMLpsHXxJxSfeX7dNTQX2
 0VohpckMJ6tEndC/8CYkiwfkjfeMceM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

Enhance the post processing to translate physical addresses to logical
addresses in the decoded output. This improves debuggability by
allowing direct correlation with source code and debug symbols.

The decoder now creates a .l output file with logical addresses,
making it easier to analyze traces using symbol tables and debuggers.
LP index filtering is made optional when dumping traces to show all
addresses.

Add logical address translation in the post-processing step of
process_trace_file(). For each physical address found in the decoded
trace, find_logical_addr() is used to look up the corresponding
logical address from the mem_entries array. The translated output is
written to a new file with a ".l" suffix alongside the original
decoded trace file.

LP index filtering in find_logical_addr() is made optional via a
new 'filter' parameter. When running with dump_trace (perf script -D),
filtering is disabled so all addresses are translated regardless of
LP index. This ensures complete coverage when dumping traces for
analysis.

Example output files after decoding:
  htm.bin.n0.p2.c0.out   - decoded trace with physical addresses
  htm.bin.n0.p2.c0.out.l - decoded trace with logical addresses

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/powerpc-htm.c | 81 ++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
index 050fbceac71e..1bd2664453c6 100644
--- a/tools/perf/util/powerpc-htm.c
+++ b/tools/perf/util/powerpc-htm.c
@@ -202,7 +202,7 @@ static int add_map_entry(struct addr_map **arr, size_t *count, size_t *cap, stru
 static unsigned long find_logical_addr(unsigned long long given_addr,
 				struct mem_entries *mem_entries_array,
 				size_t n_entries,
-				u32 lp_filter)
+				u32 lp_filter, int filter)
 {
 	for (size_t i = 0; i < n_entries; i++) {
 		unsigned long long start = mem_entries_array[i].phy_addr & PHYS_ADDR_MASK;
@@ -221,11 +221,13 @@ static unsigned long find_logical_addr(unsigned long long given_addr,
 		 * If so, calculate:
 		 * 'offset' and the 'logical address
 		 */
-		if (start <= given_addr && given_addr < end &&
-			mem_entries_array[i].lp_index == lp_filter) {
+		if (start <= given_addr && given_addr < end) {
 			unsigned long long offset = given_addr - start;
 			unsigned long logical = mem_entries_array[i].logical_addr + offset;
 
+			if (filter && (mem_entries_array[i].lp_index != lp_filter))
+				continue;
+
 			pr_debug("DEBUG: Condition hit at i=%zu given_addr=0x%llx start=0x%llx end=0x%llx lp_index=%u\n",
 				i, given_addr,
 				start, end,
@@ -259,36 +261,60 @@ static struct addr_map *process_trace_file(const char *trace_file,
 	unsigned long logical_addr;
 	size_t total_phys = 0;
 	size_t total_phys_to_logical = 0;
-
 	FILE *fp = fopen(trace_file, "r");
+	size_t prefix_len;
+	int found_match = 0;
+	FILE *fout;
+	int filter_lp = 1;
+	char *output = malloc(strlen(trace_file) + 3);  /* +3 for ".l" and null */
+
+	if (!output) {
+		pr_err("Failed to allocate memory for output filename\n");
+		fclose(fp);
+		return NULL;
+	}
 
 	if (!fp) {
 		pr_err("Failed to open trace file %s: %s\n", trace_file, strerror(errno));
 		return NULL;
 	}
 
+	snprintf(output, strlen(trace_file) + 3, "%s.l", trace_file);
+	fout = fopen(output, "w");
+	if (!fout) {
+		pr_err("Failed to open trace output file: %s\n", output);
+		fclose(fp);
+		return NULL;
+	}
+
 	if (regcomp(&addr_regex, "addr:0x[0-9A-Fa-f]+", REG_EXTENDED) != 0) {
 		pr_err("Failed to compile addr_regex\n");
-		return NULL;
+		goto out;
 	}
 
 	if (regcomp(&label_regex,
 		   "^[[:space:]]*[0-9A-Fa-f]+ : [^[:space:]]+[[:space:]]+([^[:space:]]+)",
 		   REG_EXTENDED) != 0) {
 		pr_err("Failed to compile label_regex\n");
-		return NULL;
+		regfree(&addr_regex);
+		goto out;
 	}
 
 	maps = NULL;
 	count = 0;
 	cap = 0;
 
+	/* When dumping traces, show all addresses regardless of LP index */
+	if (dump_trace)
+		filter_lp = 0;
+
 	while (getline(&line, &len, fp) != -1) {
 		if (regexec(&label_regex, line, 2, pmatch, 0) == 0) {
 			char label[64] = {0};
 			int start = pmatch[1].rm_so;
 			int end   = pmatch[1].rm_eo;
 			int line_len   = end - start;
+			found_match = 0;
 
 			if (line_len < 0)
 				line_len = 0;
@@ -303,6 +329,10 @@ static struct addr_map *process_trace_file(const char *trace_file,
 			while (regexec(&addr_regex, ptr, 1, pmatch, 0) == 0) {
 				unsigned long long phys_addr = 0;
 				struct addr_map entry = {0};
+				char *hex_start = strstr(line, "addr:0x");
+				const char *target = "addr:0x";
+				char *old_val_ptr;
+				size_t written;
 
 				if (sscanf(ptr + pmatch[0].rm_so + strlen("addr:"),
 					  "%llx", &phys_addr) != 1) {
@@ -315,7 +345,30 @@ static struct addr_map *process_trace_file(const char *trace_file,
 				logical_addr = find_logical_addr(phys_addr,
 							mem_entries_array,
 							n_entries,
-							lp_filter);
+							lp_filter, filter_lp);
+				/* create output.txt with logical address */
+				if (dump_trace && hex_start) {
+					old_val_ptr = hex_start + strlen(target);
+					prefix_len = hex_start - line;
+					written = fwrite(line, 1, prefix_len, fout);
+					if (written != prefix_len) {
+						pr_err("Failed to write prefix to output file\n");
+						continue;
+					}
+					if (fprintf(fout, "addr:0x%llx\t", (unsigned long long)logical_addr) < 0) {
+						pr_err("Failed to write to output file\n");
+						continue;
+					}
+					while (*old_val_ptr != ' ' && *old_val_ptr != '\n' && *old_val_ptr != '\0') {
+						old_val_ptr++;
+					}
+					if (fprintf(fout, "%s", old_val_ptr) < 0) {
+						pr_err("Failed to write suffix to output file\n");
+						continue;
+					}
+					found_match = 1;
+				}
+
 				if (logical_addr == 0) {
 					ptr += pmatch[0].rm_eo;
 					continue;
@@ -335,6 +388,12 @@ static struct addr_map *process_trace_file(const char *trace_file,
 
 				ptr += pmatch[0].rm_eo;
 			}
+			if (dump_trace && (!found_match) && line) {
+				if (fprintf(fout, "%s", line) < 0) {
+					pr_err("Failed to write line to output file\n");
+					continue;
+				}
+			}
 		}
 	}
 
@@ -342,9 +401,17 @@ static struct addr_map *process_trace_file(const char *trace_file,
 	fclose(fp);
 	regfree(&addr_regex);
 	regfree(&label_regex);
+	fclose(fout);
+	free(output);
 
 	*count_out = count;
 	return maps;
+
+out:
+	fclose(fp);
+	fclose(fout);
+	free(output);
+	return NULL;
 }
 
 static int create_mem_maps(struct perf_session *session, struct powerpc_htm *htm)
-- 
2.52.0

