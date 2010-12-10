From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Fri, 10 Dec 2010 08:30:19 +0100
Message-ID: <m3tyimxeyc.fsf@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39396 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0LJHaY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Dec 2010 02:30:24 -0500
Received: by wyb28 with SMTP id 28so3143077wyb.19
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Dec 2010 23:30:23 -0800 (PST)
In-Reply-To: <20101209153548.GA11820@ghostprotocols.net> (Arnaldo Carvalho de
	Melo's message of "Thu, 9 Dec 2010 13:35:48 -0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Francis Moreau <francis.moro@gmail.com>, linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:

> Em Thu, Dec 09, 2010 at 04:00:08PM +0100, Francis Moreau escreveu:
>> I'm trying to use perf-probe(1) with the latest F14 kernel
>> (2.6.35.9-64.fc14.x86_64).
>> 
>
>> I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
>> contains the running vmlinux image AFAICT.
>> 
>> I added it to the buildid cache:
>> 
>> $ perf buildid-cache -v -a /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux
>> Adding 4d89e23415d8ab491cfc8ef8aa67764b91cc6787 /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux: OK
>> 
>> But when running perf-probe(1) like the following:
>> 
>>   $ perf probe schedule cpu
>>   Failed to find path of kernel moduleFailed to open debuginfo file.
>>   Error: Failed to add events. (-2)
>> 
>> it fails.
>> 
>> One strange thing is that when perf read the running kernel build id, it
>> get: 882b1b53eb1d65320e8fa710273aa8493896c4.
>> 
>> Could anybody tell me what I'm doing wrong ?
>
> Can you try using:
>
> $ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux <rest of the probe definition>
>
> So that it tries it directly instead of looking into the buildid cache?
>
> I'll check if perf probe actually looks in the buildid cache, till then,
> please try specifying it directly,

Looks like a standard path is missing...

What about adding the one above since it looks like Fedora is installing
their debug kernel images at this place ?

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d628c8d..0f914c7 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2260,7 +2262,7 @@ static int vmlinux_path__init(void)
 	if (uname(&uts) < 0)
 		return -1;
 
-	vmlinux_path = malloc(sizeof(char *) * 5);
+	vmlinux_path = malloc(sizeof(char *) * 6);
 	if (vmlinux_path == NULL)
 		return -1;
 
@@ -2288,6 +2290,12 @@ static int vmlinux_path__init(void)
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
		Franck
