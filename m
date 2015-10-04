From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf report: Support caller callchain order when using DWARF unwinder.
Date: Sun,  4 Oct 2015 17:16:37 +0200
Message-ID: <1443971797-25548-1-git-send-email-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:36392 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbbJDPQl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 4 Oct 2015 11:16:41 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

We cannot reverse the order of the libunwind stepper. To workaround
this, we store the IPs in a temporary stack buffer and then walk
this buffer in reverse order when callchain_param.order is set to
ORDER_CALLER.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/util/unwind-libunwind.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 4c00507..bf631f1 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -621,11 +621,24 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	if (ret)
 		display_error(ret);
 
-	while (!ret && (unw_step(&c) > 0) && max_stack--) {
-		unw_word_t ip;
+	if (callchain_param.order == ORDER_CALLEE) {
+		while (!ret && (unw_step(&c) > 0) && max_stack--) {
+			unw_word_t ip;
 
-		unw_get_reg(&c, UNW_REG_IP, &ip);
-		ret = ip ? entry(ip, ui->thread, cb, arg) : 0;
+			unw_get_reg(&c, UNW_REG_IP, &ip);
+			ret = ip ? entry(ip, ui->thread, cb, arg) : 0;
+		}
+	} else {
+		unw_word_t ips[max_stack];
+		int i = 0;
+
+		while ((unw_step(&c) > 0) && i < max_stack) {
+			unw_get_reg(&c, UNW_REG_IP, &ips[i]);
+			++i;
+		}
+		max_stack = i;
+		for (i = max_stack - 1; i >= 0; --i)
+			entry(ips[i], ui->thread, cb, arg);
 	}
 
 	return ret;
-- 
2.6.0
