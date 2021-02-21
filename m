Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D5EC433DB
	for <linux-perf-users@archiver.kernel.org>; Sun, 21 Feb 2021 12:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63EB64F06
	for <linux-perf-users@archiver.kernel.org>; Sun, 21 Feb 2021 12:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhBUMrU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 21 Feb 2021 07:47:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:56804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhBUMrT (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 21 Feb 2021 07:47:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AECC9B02A;
        Sun, 21 Feb 2021 12:46:36 +0000 (UTC)
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] perf annotate: improve --stdio mode
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Message-ID: <a0d53f31-f633-5013-c386-a4452391b081@suse.cz>
Date:   Sun, 21 Feb 2021 13:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The patch changes the output format in 2 ways:
- line number is displayed for all source lines (matching TUI mode)
- source locations for the hottest lines are printed
   at the line end in order to preserve layout

Before:

     0.00 :   405ef1: inc    %r15
          :            tmpsd * (TD + tmpsd * TDD)));
     0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
          :            tmpsd * (TC +
  eff.c:1811    0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8>
          :            TA + tmpsd * (TB +
     0.35 :   405f06: vfmadd213sd 0x2b9b1(%rip),%xmm0,%xmm3        # 4318c0 <_IO_stdin_used+0x8c0>
          :            dumbo =
  eff.c:1809    1.41 :   405f0f: vfmadd213sd 0x2b9b0(%rip),%xmm0,%xmm3        # 4318c8 <_IO_stdin_used+0x8c8>
          :            sumi -= sj * tmpsd * dij2i * dumbo;
  eff.c:1813    2.58 :   405f18: vmulsd %xmm3,%xmm0,%xmm0
     2.81 :   405f1c: vfnmadd213sd 0x30(%rsp),%xmm1,%xmm0
     3.78 :   405f23: vmovsd %xmm0,0x30(%rsp)
          :            for (k = 0; k < lpears[i] + upears[i]; k++) {
  eff.c:1761    0.90 :   405f29: cmp    %r15d,%r12d

After:

     0.00 :   405ef1: inc    %r15
          : 1812   tmpsd * (TD + tmpsd * TDD)));
     0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
          : 1811   tmpsd * (TC +
     0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8> // eff.c:1811
          : 1810   TA + tmpsd * (TB +
     0.35 :   405f06: vfmadd213sd 0x2b9b1(%rip),%xmm0,%xmm3        # 4318c0 <_IO_stdin_used+0x8c0>
          : 1809   dumbo =
     1.41 :   405f0f: vfmadd213sd 0x2b9b0(%rip),%xmm0,%xmm3        # 4318c8 <_IO_stdin_used+0x8c8> // eff.c:1809
          : 1813   sumi -= sj * tmpsd * dij2i * dumbo;
     2.58 :   405f18: vmulsd %xmm3,%xmm0,%xmm0 // eff.c:1813
     2.81 :   405f1c: vfnmadd213sd 0x30(%rsp),%xmm1,%xmm0
     3.78 :   405f23: vmovsd %xmm0,0x30(%rsp)
          : 1761   for (k = 0; k < lpears[i] + upears[i]; k++) {

Where e.g. '// eff.c:1811' shares the same color as the percentantage
at the line beginning.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
  tools/perf/util/annotate.c | 30 ++++++++++++++----------------
  1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e60841b86d27..80542012ec1b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1366,7 +1366,6 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
  {
  	struct disasm_line *dl = container_of(al, struct disasm_line, al);
  	static const char *prev_line;
-	static const char *prev_color;
  
  	if (al->offset != -1) {
  		double max_percent = 0.0;
@@ -1405,20 +1404,6 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
  
  		color = get_percent_color(max_percent);
  
-		/*
-		 * Also color the filename and line if needed, with
-		 * the same color than the percentage. Don't print it
-		 * twice for close colored addr with the same filename:line
-		 */
-		if (al->path) {
-			if (!prev_line || strcmp(prev_line, al->path)
-				       || color != prev_color) {
-				color_fprintf(stdout, color, " %s", al->path);
-				prev_line = al->path;
-				prev_color = color;
-			}
-		}
-
  		for (i = 0; i < nr_percent; i++) {
  			struct annotation_data *data = &al->data[i];
  			double percent;
@@ -1439,6 +1424,19 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
  		printf(" : ");
  
  		disasm_line__print(dl, start, addr_fmt_width);
+
+		/*
+		 * Also color the filename and line if needed, with
+		 * the same color than the percentage. Don't print it
+		 * twice for close colored addr with the same filename:line
+		 */
+		if (al->path) {
+			if (!prev_line || strcmp(prev_line, al->path)) {
+				color_fprintf(stdout, color, " // %s", al->path);
+				prev_line = al->path;
+			}
+		}
+
  		printf("\n");
  	} else if (max_lines && printed >= max_lines)
  		return 1;
@@ -1454,7 +1452,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
  		if (!*al->line)
  			printf(" %*s:\n", width, " ");
  		else
-			printf(" %*s:     %*s %s\n", width, " ", addr_fmt_width, " ", al->line);
+			printf(" %*s: %-*d %s\n", width, " ", addr_fmt_width, al->line_nr, al->line);
  	}
  
  	return 0;
-- 
2.30.1

