Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B127C433FE
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 04:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC1660FE6
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 04:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhIKEkk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 00:40:40 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:44352
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229559AbhIKEkj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Sep 2021 00:40:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAzrHPXXAnf8kfUQkYqn9BIQvAzq46y4lQ/E+HrYNto7wLS7tgJXHwdsj3v7EfC0kvnz/9EmvPA9Shld/lerfNVVxthuaxvhkYfVQPZ4mSiA/H+IS6PNqojai7WC6dz+Dd4h0fMPPFUG8eGWryU9IYZjVSnpS4TjnYDhiEXOhKAo7W8zljqztiPJJdXoVNbPdkkil+JqoCiLomc7HRA7xeWR3ho1gfgi9SQHC0vf2uq3mKNq8ULZzUS9h8Y9+6o50zvgmQ1qeJUsSv69qGDcPb3vrhvu9/u2zlMRKBPexL0ly6Q3opXZ9EmQYF+wGa2Mdcqh8J6omkVmPbqMIgGaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H/09r11XljhQiAxoULbvozhZfYx6gfON+wmakDIQlQE=;
 b=fLG6K3eNA05ifMPL29Hdy6hNDNo8DxHAZHCya5C7hx5/fnVsgM1ZvdVDQQxWM1jOtFK0MsL+e32LI/TFHcz17wZ1jmp095/GCWIK1kNBCvHQd0wJev4PSObRSxAJo4aYymY+8tewf6IZMqk9m7NJrTAqEBfg5VLeB9Emei/e/bormO53U+HVUen53t4OewV+g/q9VakTtil3/aRR7JHscuermi2gKxnarskF67dqRB09UGO8nhOZ81tQEigciW5HNHbKhDN2uC0F2GY+khEk0+pV2iKNV21m0M6M9U3jZoYCeEL/0k2r9ANhhlbu8Hb5vQnqkq06D9EGA6zn6kIPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/09r11XljhQiAxoULbvozhZfYx6gfON+wmakDIQlQE=;
 b=BSj4wWjtFKUYHMbF8Tlf4IgUP3gpNg0jYYq/0hK2Ss/E49Rqk4geEHWy6lwkCnC9sue1z2nv4Fms0wVeOXB8YyU+ZHu8xl4/0f3QcydYtmHxsDoEMpAX0F9N3e0BIR5fVIyMkNMIquLZHvdwFnimx7ycwpwpv7ZOXPEjvUWBm8c=
Received: from DM5PR1401CA0014.namprd14.prod.outlook.com (2603:10b6:4:4a::24)
 by BN6PR1201MB0148.namprd12.prod.outlook.com (2603:10b6:405:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Sat, 11 Sep
 2021 04:39:24 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::34) by DM5PR1401CA0014.outlook.office365.com
 (2603:10b6:4:4a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Sat, 11 Sep 2021 04:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Sat, 11 Sep 2021 04:39:24 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 23:39:19 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <yao.jin@linux.intel.com>, <namhyung@kernel.org>,
        <kim.phillips@amd.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] perf annotate: Fix fused instr logic for assembly functions
Date:   Sat, 11 Sep 2021 10:08:53 +0530
Message-ID: <20210911043854.8373-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df7eda01-fba1-4d21-24ec-08d974de2170
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0148:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB014892A5CC3B5629EC709813E0D79@BN6PR1201MB0148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgIZ8kMVhk0fNG6OcrkQlLz3wSeHIFf447AKSzEVlbzHZCm2mLtts+PCQ3lwz0I1R3doZHQv2LkphTPqYSFIkCGfTcXwlRrazN2XB5BOzqZ2lujM1hCZom7/Vs9OvEqvttwgqW8QUK86hBfjhycOmvD9PAL8jEfpDcEXoqwAk/VHUn4xLqBSuxu8LOX74a34bYTR5ghvccuNSD8E14USx0ucKbXwHahdX67A8XLlYdhYegWwZwNB7spIk69rM/3h+LBGI3bRRG3SeH8P4mzRod7Er8v7B+TJFgsQletC9LwTFdEI4u1167PXFNkBnFZnCd1HPYQkRUj3+ndDst/Fw7mSM7ocZG7R/djcF+/q04NL/jWwyWd6oXu0fLc3sUvWtpxz79VBUP9sl98dT3lw6aGNs+NCvC+MjkFU0jjw6wfVdOHV13hwKEI1ah0hOm2d4JjAQGOxzdNS4MMcc00XK+dEuSdH6ojk2Go0qhvC8Z8cqcjCgNDtZVRluJgLmA23UI6gZkuceUgfhH7ILJhPwAbjUekyJNgd2vL2DhUvFhKY4WOjGb8j2RaBs9edGmhQP3n1Q5PJRAfb4oeTfbTsrR5JHG/lPK0HR2wcITuTWA2W4mIjq6o5/+oNHY2JZf1XX7E6E3hrqL43O03nT6pw480lWpcHLvq7tch4E9+wP6sEir6w/Y8xkx8CbkmNvGEMMrx5P3Encg0wECyPc/yEam9BPD5m6fywWIC/lMZJsz4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(2616005)(4326008)(66574015)(36860700001)(47076005)(426003)(16526019)(186003)(356005)(26005)(44832011)(70586007)(8936002)(8676002)(82740400003)(478600001)(316002)(6916009)(336012)(7696005)(2906002)(83380400001)(70206006)(81166007)(1076003)(6666004)(54906003)(36756003)(82310400003)(5660300002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2021 04:39:24.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7eda01-fba1-4d21-24ec-08d974de2170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0148
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some x86 microarchitectures fuse a subset of cmp/test/ALU instructions
with branch instructions, and thus perf annotate highlight such valid
pairs as fused.

When annotated with source, perf uses struct disasm_line to contain
either source or instruction line from objdump output. Usually, a C
statement generates multiple instructions which include such
cmp/test/ALU + branch instruction pairs. But in case of assembly
function, each individual assembly source line generate one
instruction. Perf annotate instruction fusion logic assumes previous
disasm_line as previous instruction line, which is wrong because,
for assembly function, previous disasm_line contains source line.
And thus perf fails to highlight valid fused instruction pairs for
assembly functions.

Fix it by searching backward until we find an instruction line and
consider that disasm_line as fused with current branch instruction.

Before:
         │    cmpq    %rcx, RIP+8(%rsp)
    0.00 │      cmp    %rcx,0x88(%rsp)
         │    je      .Lerror_bad_iret      <--- Source line
    0.14 │   ┌──je     b4                   <--- Instruction line
         │   │movl    %ecx, %eax

After:
         │    cmpq    %rcx, RIP+8(%rsp)
    0.00 │   ┌──cmp    %rcx,0x88(%rsp)
         │   │je      .Lerror_bad_iret
    0.14 │   ├──je     b4
         │   │movl    %ecx, %eax

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/ui/browser.c           | 33 ++++++++++++++++++++++---------
 tools/perf/ui/browser.h           |  2 +-
 tools/perf/ui/browsers/annotate.c | 24 +++++++++++++++-------
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 781afe42e90e..fa5bd5c20e96 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -757,25 +757,40 @@ void __ui_browser__line_arrow(struct ui_browser *browser, unsigned int column,
 }
 
 void ui_browser__mark_fused(struct ui_browser *browser, unsigned int column,
-			    unsigned int row, bool arrow_down)
+			    unsigned int row, int diff, bool arrow_down)
 {
-	unsigned int end_row;
+	int end_row;
 
-	if (row >= browser->top_idx)
-		end_row = row - browser->top_idx;
-	else
+	if (diff <= 0)
 		return;
 
 	SLsmg_set_char_set(1);
 
 	if (arrow_down) {
+		if (row + diff <= browser->top_idx)
+			return;
+
+		end_row = row + diff - browser->top_idx;
 		ui_browser__gotorc(browser, end_row, column - 1);
-		SLsmg_write_char(SLSMG_ULCORN_CHAR);
-		ui_browser__gotorc(browser, end_row, column);
-		SLsmg_draw_hline(2);
-		ui_browser__gotorc(browser, end_row + 1, column - 1);
 		SLsmg_write_char(SLSMG_LTEE_CHAR);
+
+		while (--end_row >= 0 && end_row > (int)(row - browser->top_idx)) {
+			ui_browser__gotorc(browser, end_row, column - 1);
+			SLsmg_draw_vline(1);
+		}
+
+		end_row = (int)(row - browser->top_idx);
+		if (end_row >= 0) {
+			ui_browser__gotorc(browser, end_row, column - 1);
+			SLsmg_write_char(SLSMG_ULCORN_CHAR);
+			ui_browser__gotorc(browser, end_row, column);
+			SLsmg_draw_hline(2);
+		}
 	} else {
+		if (row < browser->top_idx)
+			return;
+
+		end_row = row - browser->top_idx;
 		ui_browser__gotorc(browser, end_row, column - 1);
 		SLsmg_write_char(SLSMG_LTEE_CHAR);
 		ui_browser__gotorc(browser, end_row, column);
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index 3678eb88f119..510ce4554050 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -51,7 +51,7 @@ void ui_browser__write_graph(struct ui_browser *browser, int graph);
 void __ui_browser__line_arrow(struct ui_browser *browser, unsigned int column,
 			      u64 start, u64 end);
 void ui_browser__mark_fused(struct ui_browser *browser, unsigned int column,
-			    unsigned int row, bool arrow_down);
+			    unsigned int row, int diff, bool arrow_down);
 void __ui_browser__show_title(struct ui_browser *browser, const char *title);
 void ui_browser__show_title(struct ui_browser *browser, const char *title);
 int ui_browser__show(struct ui_browser *browser, const char *title,
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ef4da4295bf7..e81c2493efdf 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -125,13 +125,20 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		ab->selection = al;
 }
 
-static bool is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
+static int is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
 {
 	struct disasm_line *pos = list_prev_entry(cursor, al.node);
 	const char *name;
+	int diff = 1;
+
+	while (pos && pos->al.offset == -1) {
+		pos = list_prev_entry(pos, al.node);
+		if (!ab->opts->hide_src_code)
+			diff++;
+	}
 
 	if (!pos)
-		return false;
+		return 0;
 
 	if (ins__is_lock(&pos->ins))
 		name = pos->ops.locked.ins.name;
@@ -139,9 +146,11 @@ static bool is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
 		name = pos->ins.name;
 
 	if (!name || !cursor->ins.name)
-		return false;
+		return 0;
 
-	return ins__is_fused(ab->arch, name, cursor->ins.name);
+	if (ins__is_fused(ab->arch, name, cursor->ins.name))
+		return diff;
+	return 0;
 }
 
 static void annotate_browser__draw_current_jump(struct ui_browser *browser)
@@ -155,6 +164,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	struct annotation *notes = symbol__annotation(sym);
 	u8 pcnt_width = annotation__pcnt_width(notes);
 	int width;
+	int diff = 0;
 
 	/* PLT symbols contain external offsets */
 	if (strstr(sym->name, "@plt"))
@@ -205,11 +215,11 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 				 pcnt_width + 2 + notes->widths.addr + width,
 				 from, to);
 
-	if (is_fused(ab, cursor)) {
+	diff = is_fused(ab, cursor);
+	if (diff > 0) {
 		ui_browser__mark_fused(browser,
 				       pcnt_width + 3 + notes->widths.addr + width,
-				       from - 1,
-				       to > from);
+				       from - diff, diff, to > from);
 	}
 }
 
-- 
2.27.0

