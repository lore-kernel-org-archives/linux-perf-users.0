From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf-list: perf list sw segmentation fault fix
Date: Wed, 02 Dec 2015 14:52:02 +0100
Message-ID: <1449064322.24573.140.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34494 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758233AbbLBNwE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Dec 2015 08:52:04 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, ast@plumgrid.com

The PERF_COUNT_SW_BPF_OUTPUT entry is missing in the event_symbols_sw
array.  Due to that "perf list sw" segfaults,  because a NULL pointer
is passed to strlen() function at util/parse-events.c:1895.

After this patch, the syms array is set correctly,  so "perf list sw"
does not segfault.

Before:

Segmentation fault

After:

List of pre-defined events (to be used in -e):

  alignment-faults                                   [Software event]
  bpf-output                                         [Software event]
  context-switches OR cs                             [Software event]
  cpu-clock                                          [Software event]
  cpu-migrations OR migrations                       [Software event]
  dummy                                              [Software event]
  emulation-faults                                   [Software event]
  major-faults                                       [Software event]
  minor-faults                                       [Software event]
  page-faults OR faults                              [Software event]
  task-clock                                         [Software event]

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/util/parse-events.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e48d9da..40ae92a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -124,6 +124,10 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 		.symbol = "dummy",
 		.alias  = "",
 	},
+	[PERF_COUNT_SW_BPF_OUTPUT] = {
+		.symbol = "bpf-output",
+		.alias  = "",
+	},
 };
 
 #define __PERF_EVENT_FIELD(config, name) \
