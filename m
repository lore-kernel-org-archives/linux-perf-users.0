From: David Ahern <daahern@cisco.com>
Subject: [PATCH] perf symbols: skip duplicate check in dso__load by guest kmod origin
Date: Sun, 21 Nov 2010 07:50:41 -0700
Message-ID: <1290351041-4083-1-git-send-email-daahern@cisco.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:27512 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab0KUOux (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Nov 2010 09:50:53 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: David Ahern <daahern@cisco.com>

If machine is not set root_dir is set to "" which drops name to the
same lookup as DSO__ORIG_DSO.

Signed-off-by: David Ahern <daahern@cisco.com>

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b39f499..d30136e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1473,10 +1473,10 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 			snprintf(name, size, "%s", self->long_name);
 			break;
 		case DSO__ORIG_GUEST_KMODULE:
-			if (map->groups && map->groups->machine)
-				root_dir = map->groups->machine->root_dir;
-			else
-				root_dir = "";
+			if (!map->groups || !map->groups->machine)
+				continue;
+
+			root_dir = map->groups->machine->root_dir;
 			snprintf(name, size, "%s%s", root_dir, self->long_name);
 			break;
 
-- 
1.7.2.3
