From: David Ahern <daahern@cisco.com>
Subject: [PATCH] perf symbols: reuse of name in dso__load when starting second pass
Date: Sun, 21 Nov 2010 08:03:50 -0700
Message-ID: <1290351830-4398-1-git-send-email-daahern@cisco.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:43107 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab0KUPDx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Nov 2010 10:03:53 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: David Ahern <daahern@cisco.com>

continue statement in default case applies when a second pass is
wanted as well. As it stands the code drops down to the open
re-using the value in name from the previous origin attempt.

Signed-off-by: David Ahern <daahern@cisco.com>
---
 tools/perf/util/symbol.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d30136e..861be8b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1488,8 +1488,8 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 			if (want_symtab) {
 				want_symtab = 0;
 				self->origin = DSO__ORIG_BUILD_ID_CACHE;
-			} else
-				continue;
+			}
+			continue;
 		}
 
 		/* Name is now the name of the next image to try */
-- 
1.7.2.3
