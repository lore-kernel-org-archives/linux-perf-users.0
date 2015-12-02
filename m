From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf buildid-list: Fix return value of perf buildid-list -k
Date: Wed, 02 Dec 2015 19:27:51 +0100
Message-ID: <1449080871.24573.145.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35492 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbbLBS1y (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Dec 2015 13:27:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 257B4A35A2
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Dec 2015 18:27:54 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

The buildid string length is returned by perf buildid-list -k command.
Since a non-zero return value means an error, perf buildid-list -k cmd
should return 0 when successful instead.

Before:

	# perf buildid-list -k
	39356d74e96e02346fe0ec1f3f162b6c522bac62
	# echo $?
	41

After:

	# perf buildid-list -k
	39356d74e96e02346fe0ec1f3f162b6c522bac62
	# echo $?
	0

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-buildid-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 918b4de..6419f57 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -110,7 +110,7 @@ int cmd_buildid_list(int argc, const char **argv,
 	setup_pager();
 
 	if (show_kernel)
-		return sysfs__fprintf_build_id(stdout);
+		return !(sysfs__fprintf_build_id(stdout) > 0);
 
 	return perf_session__list_build_ids(force, with_hits);
 }
