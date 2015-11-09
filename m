From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf annotate: Support of full source file paths for
 srcline fix
Date: Mon, 09 Nov 2015 16:33:31 +0100
Message-ID: <1447083211.15375.57.camel@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58531 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbbKIPdd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Nov 2015 10:33:33 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 1ECC2264C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2015 15:33:33 +0000 (UTC)
Received: from [10.34.1.123] (dhcp-1-123.brq.redhat.com [10.34.1.123])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tA9FXV1r021645
	for <linux-perf-users@vger.kernel.org>; Mon, 9 Nov 2015 10:33:32 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


The --full-paths option did not show the full source file paths
in the perf annotate tool, because the value of the option was
not propagated into the related functions.

With this patch the value of the --full-paths option is known to
the function that composes the srcline string, so it prints the
full path when necessary.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/util/annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0fc8d7a..cbf0fdb 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1604,6 +1604,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	len = symbol__size(sym);
 
 	if (print_lines) {
+		srcline_full_filename = full_paths;
 		symbol__get_source_line(sym, map, evsel, &source_line, len);
 		print_summary(&source_line, dso->long_name);
 	}
-- 
1.8.3.1
