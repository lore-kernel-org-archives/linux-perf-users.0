From: Arun Sharma <asharma@fb.com>
Subject: [PATCH] Symbolize stripped binaries without buildid
Date: Fri, 28 Jan 2011 14:11:33 -0800
Message-ID: <20110128221133.GA25958@radium.snc4.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail001.snc4.facebook.com ([66.220.144.131]:45113 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752226Ab1A1WQf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Jan 2011 17:16:35 -0500
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Symbolize binaries which don't have buildids and are stripped, but have a .dynsym.

Signed-off-by: Arun Sharma <asharma@fb.com>

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 15ccfba..a84db85 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1480,7 +1480,7 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 	 * Failing that, do a second pass where we accept .dynsym also
 	 */
 	for (self->origin = DSO__ORIG_BUILD_ID_CACHE, want_symtab = 1;
-	     self->origin != DSO__ORIG_NOT_FOUND;
+	     self->origin != DSO__ORIG_END;
 	     self->origin++) {
 		switch (self->origin) {
 		case DSO__ORIG_BUILD_ID_CACHE:
@@ -1530,6 +1530,7 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 				 self->long_name);
 			break;
 
+		case DSO__ORIG_NOT_FOUND:
 		default:
 			/*
 			 * If we wanted a full symtab but no image had one,
@@ -1538,8 +1539,7 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 			if (want_symtab) {
 				want_symtab = 0;
 				self->origin = DSO__ORIG_BUILD_ID_CACHE;
-			} else
-				continue;
+			}
 		}
 
 		/* Name is now the name of the next image to try */
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 670cd1c..6b79ab9 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -201,6 +201,7 @@ enum dso_origin {
 	DSO__ORIG_GUEST_KMODULE,
 	DSO__ORIG_KMODULE,
 	DSO__ORIG_NOT_FOUND,
+	DSO__ORIG_END,
 };
 
 char dso__symtab_origin(const struct dso *self);
