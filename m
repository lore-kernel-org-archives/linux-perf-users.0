From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 2/2] perf-probe: fail if the kernel image contains no symbol
Date: Fri, 10 Dec 2010 14:07:14 +0100
Message-ID: <m3d3p9ydx9.fsf_-_@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net> <m2k4jiewhi.fsf@gmail.com>
	<4D019E3F.4040902@hitachi.com> <m3pqtaxdv8.fsf@gmail.com>
	<4D01E453.3000208@hitachi.com> <m3lj3xye9a.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64150 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756292Ab0LJNHS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Dec 2010 08:07:18 -0500
Received: by wwa36 with SMTP id 36so3688977wwa.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2010 05:07:17 -0800 (PST)
In-Reply-To: <m3lj3xye9a.fsf@gmail.com> (Franck Bui-Huu's message of "Fri, 10
	Dec 2010 14:00:01 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Francis Moreau <francis.moro@gmail.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

From: Franck Bui-Huu <fbuihuu@gmail.com>

This fix is for kernel images found in the standard paths.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 tools/perf/util/probe-event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 99f9933..fc2b0b4 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -135,7 +135,7 @@ const char *kernel_get_module_path(const char *module)
 		if (dso__load_vmlinux(dso, map, vmlinux_name, NULL) <= 0)
 			return NULL;
 	} else {
-		if (dso__load_vmlinux_path(dso, map, NULL) < 0) {
+		if (dso__load_vmlinux_path(dso, map, NULL) <= 0) {
 			pr_debug("Failed to load kernel map.\n");
 			return NULL;
 		}
-- 
1.7.3.2


-- 
		Franck
