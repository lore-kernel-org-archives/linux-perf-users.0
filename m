From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
Subject: [PATCH] perf probe: Fix probe definition for inlined functions
Date: Wed, 21 Jun 2017 18:41:34 +0200
Message-ID: <20170621164134.5701-1-bjorn.topel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:20545 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdFUQmN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2017 12:42:13 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, magnus.karlsson@intel.com

From: Björn Töpel <bjorn.topel@intel.com>

In commit 613f050d68a8 ("perf probe: Fix to probe on gcc generated
functions in modules"), the offset from symbol is, incorrectly, added
to the trace point address. This leads to incorrect probe trace points
for inlined functions and when using relative line number on symbols.

Prior this patch:
  $ perf probe -m nf_nat -D in_range
  p:probe/in_range nf_nat:in_range.isra.9+0
  $ perf probe -m i40e -D i40e_clean_rx_irq
  p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+2212
  $ perf probe -m i40e -D i40e_clean_rx_irq:16
  p:probe/i40e_clean_rx_irq i40e:i40e_lan_xmit_frame+626

After:
  $ perf probe -m nf_nat -D in_range
  p:probe/in_range nf_nat:in_range.isra.9+0
  $ perf probe -m i40e -D i40e_clean_rx_irq
  p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+1106
  $ perf probe -m i40e -D i40e_clean_rx_irq:16
  p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+2665

Fixes: 613f050d68a8 ("perf probe: Fix to probe on gcc generated functions in modules")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 84e7e698411e..a2670e9d652d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -619,7 +619,7 @@ static int post_process_probe_trace_point(struct probe_trace_point *tp,
 					   struct map *map, unsigned long offs)
 {
 	struct symbol *sym;
-	u64 addr = tp->address + tp->offset - offs;
+	u64 addr = tp->address - offs;
 
 	sym = map__find_symbol(map, addr);
 	if (!sym)
-- 
2.7.4
