From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Thu, 23 Dec 2010 14:59:38 +0100
Message-ID: <m37hf08u9h.fsf@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net> <m2wrnernw3.fsf@gmail.com>
	<20101213125837.GB5407@ghostprotocols.net> <m2sjy1stuf.fsf@gmail.com>
	<20101213142159.GF5407@ghostprotocols.net>
	<4D0882E7.8090805@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51587 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab0LWN7p (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Dec 2010 08:59:45 -0500
Received: by wyb28 with SMTP id 28so6086974wyb.19
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Dec 2010 05:59:44 -0800 (PST)
In-Reply-To: <4D0882E7.8090805@hitachi.com> (Masami Hiramatsu's message of
	"Wed, 15 Dec 2010 17:57:11 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org

Hello Masami,

Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> writes:

> (2010/12/13 23:21), Arnaldo Carvalho de Melo wrote:
>
>> There are two problems here:
>> 
>> on the 'report' header, as we didn't collect "cycles", but
>> "probe:icmp_rcv" events, that is another fix that needs to be backported to
>> fedora, but a minor one.
>> 
>> Also 'perf probe -L' should look use
>> /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64 as a prefix to look for
>> sources.
>> 
>> That can be found using:
>> 
>> [root@felicio linux-2.6.35.x86_64]# readelf -wi /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux | grep DW_AT_comp_dir | head -5
>>     <2e>   DW_AT_comp_dir    : /usr/src/debug////////kernel-2.6.35.fc14/linux-2.6.35.x86_64	
>>     <95>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
>>     <75e8>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
>>     <900e>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
>>     <16670>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
>> [root@felicio linux-2.6.35.x86_64]# 
>> 
>>  <0><8b>: Abbrev Number: 1 (DW_TAG_compile_unit)
>>     <8c>   DW_AT_producer    : (indirect string, offset: 0x22f4): GNU C 4.5.1 20100924 (Red Hat 4.5.1-4)        
>>     <90>   DW_AT_language    : 1        (ANSI C)
>>     <91>   DW_AT_name        : (indirect string, offset: 0x37a): arch/x86/kernel/head64.c       
>>     <95>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64 
>>     <99>   DW_AT_low_pc      : 0x0      
>>     <a1>   DW_AT_entry_pc    : 0x0      
>>     <a9>   DW_AT_ranges      : 0x340    
>>     <ad>   DW_AT_stmt_list   : 0x114
>> 
>> I.e. using the DW_AT_comp_dir attribute in the DW_TAG_compile_unit DWARF tags,
>> Masami?
>
> It already supports DW_AT_comp_dir on upstream kernel,
> see find_line_range() in utils/probe-finder.c ;-)
>

It looks like adding probe with lazy matching pattern does not:

   $ cd /dev
   $ perf probe -n -a "icmp.c;sk=*"
   Failed to open net/ipv4/icmp.c: Operation not permitted
     Error: Failed to add events. (-2)
   $ cd /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64/
   $ perf probe -n -a "icmp.c;sk=*"
   Add new events:
     probe:icmp_push_reply (on @cmp.c)
     probe:icmp_reply     (on @cmp.c)
     probe:icmp_reply_1   (on @cmp.c)
     probe:icmp_send      (on @cmp.c)
     probe:icmp_send_1    (on @cmp.c)
     probe:icmp_error     (on @cmp.c)
     probe:icmp_error_1   (on @cmp.c)
     probe:icmp_error_2   (on @cmp.c)
     probe:icmp_error_3   (on @cmp.c)
   
   You can now use it on all perf tools, such as:
   
   	perf record -e probe:icmp_error_3 -aR sleep 1

Below is a quick and dirty fix (sorry, I don't have any time to make it
better for now), also note that the note of the file (icmp.c) reported
is screwed...

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 10ad1ad..53c2f97 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -241,7 +241,7 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
  * a newly allocated path on success.
  * Return 0 if file was found and readable, -errno otherwise.
  */
-static int get_real_path(const char *raw_path, const char *comp_dir,
+int get_real_path(const char *raw_path, const char *comp_dir,
 			 char **new_path)
 {
 	const char *prefix = symbol_conf.source_prefix;
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 3991d73..88829ef 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1126,9 +1126,17 @@ static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 	int ret = 0;
 
 	if (list_empty(&pf->lcache)) {
+		const char *comp_dir = cu_get_comp_dir(&pf->cu_die);
+		char *fullpath;
+
+		ret = get_real_path(pf->fname, comp_dir, &fullpath);
+		if (ret < 0)
+			return ret;
+
 		/* Matching lazy line pattern */
-		ret = find_lazy_match_lines(&pf->lcache, pf->fname,
+		ret = find_lazy_match_lines(&pf->lcache, fullpath,
 					    pf->pev->point.lazy_line);
+		free(fullpath);
 		if (ret == 0) {
 			pr_debug("No matched lines found in %s.\n", pf->fname);
 			return 0;
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index bba69d4..665938a 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -15,6 +15,9 @@ static inline int is_c_varname(const char *name)
 	return isalpha(name[0]) || name[0] == '_';
 }
 
+extern int get_real_path(const char *raw_path, const char *comp_dir,
+		  char **new_path);
+
 #ifdef DWARF_SUPPORT
 /* Find probe_trace_events specified by perf_probe_event from debuginfo */
 extern int find_probe_trace_events(int fd, struct perf_probe_event *pev,


-- 
		Franck
