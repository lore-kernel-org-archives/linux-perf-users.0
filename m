Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C74FEB64D9
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 Jul 2023 23:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGGXMR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 Jul 2023 19:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGXMR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Jul 2023 19:12:17 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38A1BD
        for <linux-perf-users@vger.kernel.org>; Fri,  7 Jul 2023 16:12:11 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367HVJr1001778
        for <linux-perf-users@vger.kernel.org>; Fri, 7 Jul 2023 16:12:11 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rpaun8de4-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Jul 2023 16:12:11 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Jul 2023 16:12:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B9B62342E9F6D; Fri,  7 Jul 2023 16:12:02 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <ravi.bangoria@amd.com>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] libbpf: only reset sec_def handler when necessary
Date:   Fri, 7 Jul 2023 16:11:56 -0700
Message-ID: <20230707231156.1711948-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _LsjuRAs0qJD6iESDBSSo0EfK7UNkqBo
X-Proofpoint-ORIG-GUID: _LsjuRAs0qJD6iESDBSSo0EfK7UNkqBo
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_14,2023-07-06_02,2023-05-22_02
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Don't reset recorded sec_def handler unconditionally on
bpf_program__set_type(). There are two situations where this is wrong.

First, if the program type didn't actually change. In that case original
SEC handler should work just fine.

Second, catch-all custom SEC handler is supposed to work with any BPF
program type and SEC() annotation, so it also doesn't make sense to
reset that.

This patch fixes both issues. This was reported recently in the context
of breaking perf tool, which uses custom catch-all handler for fancy BPF
prologue generation logic. This patch should fix the issue.

  [0] https://lore.kernel.org/linux-perf-users/ab865e6d-06c5-078e-e404-7f90686db50d@amd.com/

Fixes: d6e6286a12e7 ("libbpf: disassociate section handler on explicit bpf_program__set_type() call")
Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fd4f1875df65..78635feb1946 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8562,13 +8562,31 @@ enum bpf_prog_type bpf_program__type(const struct bpf_program *prog)
 	return prog->type;
 }
 
+static size_t custom_sec_def_cnt;
+static struct bpf_sec_def *custom_sec_defs;
+static struct bpf_sec_def custom_fallback_def;
+static bool has_custom_fallback_def;
+static int last_custom_sec_def_handler_id;
+
 int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
 {
 	if (prog->obj->loaded)
 		return libbpf_err(-EBUSY);
 
+	/* if type is not changed, do nothing */
+	if (prog->type == type)
+		return 0;
+
 	prog->type = type;
-	prog->sec_def = NULL;
+
+	/* If a program type was changed, we need to reset associated SEC()
+	 * handler, as it will be invalid now. The only exception is a generic
+	 * fallback handler, which by definition is program type-agnostic and
+	 * is a catch-all custom handler, optionally set by the application,
+	 * so should be able to handle any type of BPF program.
+	 */
+	if (prog->sec_def != &custom_fallback_def)
+		prog->sec_def = NULL;
 	return 0;
 }
 
@@ -8744,13 +8762,6 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
 };
 
-static size_t custom_sec_def_cnt;
-static struct bpf_sec_def *custom_sec_defs;
-static struct bpf_sec_def custom_fallback_def;
-static bool has_custom_fallback_def;
-
-static int last_custom_sec_def_handler_id;
-
 int libbpf_register_prog_handler(const char *sec,
 				 enum bpf_prog_type prog_type,
 				 enum bpf_attach_type exp_attach_type,
-- 
2.34.1

