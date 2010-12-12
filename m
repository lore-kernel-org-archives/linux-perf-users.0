From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Sun, 12 Dec 2010 23:15:26 +0100
Message-ID: <m3ei9mfxj5.fsf@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net> <m3tyimxeyc.fsf@gmail.com>
	<20101212140851.GA2343@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64048 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab0LLWPc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 12 Dec 2010 17:15:32 -0500
Received: by wyb28 with SMTP id 28so5302382wyb.19
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Dec 2010 14:15:31 -0800 (PST)
In-Reply-To: <20101212140851.GA2343@ghostprotocols.net> (Arnaldo Carvalho de
	Melo's message of "Sun, 12 Dec 2010 12:08:52 -0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, Francis Moreau <francis.moro@gmail.com>, linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:

> Em Fri, Dec 10, 2010 at 08:30:19AM +0100, Franck Bui-Huu escreveu:
>> Looks like a standard path is missing...
>> 
>> What about adding the one above since it looks like Fedora is installing
>> their debug kernel images at this place ?
>
> Can I get your signed-off-by on this one?
>

Of course.

[PATCH] perf-tools: add one more default search path for kernel image

From: Franck Bui-Huu <fbuihuu@gmail.com>

It looks like Fedora is using this one.

Reported-by: Francis Moreau <francis.moro@gmail.com>
Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 tools/perf/util/symbol.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d628c8d..a3a0c43 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2260,7 +2260,7 @@ static int vmlinux_path__init(void)
 	if (uname(&uts) < 0)
 		return -1;
 
-	vmlinux_path = malloc(sizeof(char *) * 5);
+	vmlinux_path = malloc(sizeof(char *) * 6);
 	if (vmlinux_path == NULL)
 		return -1;
 
@@ -2288,6 +2288,12 @@ static int vmlinux_path__init(void)
 	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
 		goto out_fail;
 	++vmlinux_path__nr_entries;
+	snprintf(bf, sizeof(bf), "/usr/lib/debug/lib/modules/%s.debug/vmlinux",
+		 uts.release);
+	vmlinux_path[vmlinux_path__nr_entries] = strdup(bf);
+	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
+		goto out_fail;
+	++vmlinux_path__nr_entries;
 
 	return 0;
 
-- 
1.7.3.2
