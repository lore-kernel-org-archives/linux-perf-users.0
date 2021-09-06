Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5BDC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 10:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E32A60EBA
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 10:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhIFK6l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:58:41 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:8385
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231511AbhIFK6k (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Sep 2021 06:58:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWfBm7inlRle4gj6ZuDgmQlGM4RM30mVQ74xPCag252qxgo6UoaZoq7E+tphf0XJFWmepZN9Pex7uZawc3E1VjvfnGEpAdAkiwOiNGdJD3WVUcRR3TPb66Qd1o/8hqnxEGLmNxP4BCGtO7nY69WSTDNh71iqv7UPRziWl2xfc1q3xsEOSG3n0dM8QljC9496o/6hxj19u2Hds+t/yEGLJAX1321vNVVq8UvmpN4bYRlcZO39ve9aqvChaEPjz3Qiq9H9Nrkg81w6QmEUQlkRMHMUNFLB8hsg0LZWYJPLQMryvOl14OVf5osOvb4Byig4yVCyW/cVWJKYy9jAhjZpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H/09r11XljhQiAxoULbvozhZfYx6gfON+wmakDIQlQE=;
 b=YEhgAJVUh0Of8qwD+sp3RzQUUuFrMXIjycVSgnxsWTrQWzZ5XANq+3forwtOazkgZ1Wc0oskSCn28tF9k3hf7g1l/gRRyFb+BLTjezJC8hIQap7x8cMainzchJnKdqcmoXbvZYroR7NtwhxZZYkAETkUIGb/DRQyfYtUpNZxOhjwgOMmGbNT3dCK3tk5mRog1M2U4a7GXc/ffGq68BAVFheTs+Toq9llYxK51CJqwR2EvuM2KoANpJrLD0YcQifTc1CcAaTYUch20joFWmdEoDQXmKXMK+oNV553hKnzQCqjBNf7vf+vK/LF0sbkimSFhiXYCgo/WZvWR6EvDnENAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/09r11XljhQiAxoULbvozhZfYx6gfON+wmakDIQlQE=;
 b=TGfKiViOgg4Tu5MaCvx32NapMBsBM0VPB/djrbu+LU83v6Vem21UJPoMvebos62Wzdg5GURVr0Sm4xGcHkc1vEdpS5H9vWK0q6jktgXhtoC2pkM9UzJxdMNUg0mFUM7dc/LpOxtfudM3nvII0GqDY1X3yr/11gWgsr0AptVFxwg=
Received: from BN9PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:fa::13)
 by CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Mon, 6 Sep
 2021 10:57:33 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::6f) by BN9PR03CA0008.outlook.office365.com
 (2603:10b6:408:fa::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend
 Transport; Mon, 6 Sep 2021 10:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 10:57:32 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 6 Sep 2021
 05:57:26 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <yao.jin@linux.intel.com>, <namhyung@kernel.org>,
        <kim.phillips@amd.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] perf annotate: Fix fused instr logic for assembly functions
Date:   Mon, 6 Sep 2021 16:26:39 +0530
Message-ID: <20210906105640.1040-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f563b274-0277-4f01-9a20-08d9712520f4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1352:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1352D024F506004639DA112CE0D29@CY4PR12MB1352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBm7f1EwJA6bg9Ozbb3s9KbFsJc6/nI6FR8APk+MhNhKM93mF/rL4YpFUeYURP0mE1LTWsGftYcagtcQ1sOOsMNLsXY3LvEC19aBixSFIxhGTY+Hw8DS/nzw+wlB5lPV3oqM/vKxBWH1ARUVrkmolkz5wI888jRbca0g51yebAQaT/jHp8XU+G6DD9T0d2qeV37uE9OiQAdY4jJPSww/G9XUgPMThtF1qm383nG+RWsADHnbxKX2lkGG1JX9qILreOIx4PTscitqYVZWrxYWh7VWSScBdiGXHtSEwLa7ge2CSuSif3TwOmOV2znCb1tp5r+XnpbujilxIfBoupSBewiW0QDhTTNGopksaY50vQ45p527OaxsGjo9CvJ/nMqSV/Dt1rJ6CXHWhbNmjuVNMtmTp8jukHL/A0pXURH3mTtiRi779Ws1Mp2ICVYsBPjRiwami/gNrcA3RArI79xCoZf2tdh3T8jQcoGwZ4OLPQU24+8jIdMeFUz4lrymJXn7/+yszbfmRjwkJ1x06k2LE4kj7pB0Ozslee0ubzGfdJExsuU8Ty5mTtcrlEEdibj8LQqI3wNR4jRy22ESZ3sNMAdKGsrA/CKJBak3zM1SBFtyu6FD2MKMmdphmaVIS8Iwk/AsYGPnJudALMdOwXljGZ/H2lt4NkOMbxRuZjIGV5qluTifx15yTTgbEvLd8xXz/4EZqv2Y0TmjpXSs4f+sDtA6mOE2EOqfY9ySm36nRAA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7696005)(6916009)(66574015)(316002)(16526019)(81166007)(4326008)(26005)(6666004)(36860700001)(2616005)(54906003)(356005)(36756003)(508600001)(8936002)(44832011)(1076003)(82310400003)(47076005)(186003)(70586007)(5660300002)(70206006)(2906002)(8676002)(426003)(83380400001)(86362001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 10:57:32.9835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f563b274-0277-4f01-9a20-08d9712520f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1352
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

