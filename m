From: Paul Clarke <pc@us.ibm.com>
Subject: [PATCH v2] Allow user probes on versioned symbols
Date: Thu, 30 Mar 2017 12:00:33 -0500
Message-ID: <7938e6cb-ed96-5d47-f0ae-02490eaebfe5@us.ibm.com>
Reply-To: pc@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932827AbdC3RAk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Mar 2017 13:00:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2UGwlps030471
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2017 13:00:39 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29gx8bg1hk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2017 13:00:38 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 30 Mar 2017 13:00:38 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

Symbol versioning, as in glibc, results in symbols being defined as:
<real symbol>@[@]<version>
(Note that "@@" identifies a default symbol, in case the symbol name
is repeated.)

perf is currently unable to deal with this, and is unable to create
user probes at such symbols:
--
$ nm /lib/powerpc64le-linux-gnu/libpthread.so.0 | grep pthread_create
0000000000008d30 t __pthread_create_2_1
0000000000008d30 T pthread_create@@GLIBC_2.17
$ /usr/bin/sudo perf probe -v -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
probe-definition(0): pthread_create
symbol:pthread_create file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Open Debuginfo file: /usr/lib/debug/lib/powerpc64le-linux-gnu/libpthread-2.19.so
Try to find probe point from debuginfo.
Probe point 'pthread_create' not found.
    Error: Failed to add events. Reason: No such file or directory (Code: -2)
--

One is not able to specify the fully versioned symbol, either, due to
syntactic conflicts with other uses of "@" by perf:
--
$ /usr/bin/sudo perf probe -v -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create@@GLIBC_2.17
probe-definition(0): pthread_create@@GLIBC_2.17
Semantic error :SRC@SRC is not allowed.
0 arguments
    Error: Command Parse Error. Reason: Invalid argument (Code: -22)
--

The attached patch ignores versioning for default symbols, thus
allowing probes to be created for these symbols:
--
$ /usr/bin/sudo ./perf probe -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
Added new event:
    probe_libpthread:pthread_create (on pthread_create in /lib/powerpc64le-linux-gnu/libpthread-2.19.so)

You can now use it in all perf tools, such as:

          perf record -e probe_libpthread:pthread_create -aR sleep 1

$ /usr/bin/sudo ./perf record -e probe_libpthread:pthread_create -aR ./test 2
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.052 MB perf.data (2 samples) ]
$ /usr/bin/sudo ./perf script
              test  2915 [000] 19124.260729: probe_libpthread:pthread_create: (3fff99248d38)
              test  2916 [000] 19124.260962: probe_libpthread:pthread_create: (3fff99248d38)
$ /usr/bin/sudo ./perf probe --del=probe_libpthread:pthread_create
Removed event: probe_libpthread:pthread_create
--

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
Changes in v2:
- move logic from arch__compare_symbol_names to new map__compare_symbol_names
- call through from map__compare_symbol_names to arch__compare_symbol_names
- redirect uses of arch__compare_symbol_names
- send patch to LKML

  tools/perf/util/auxtrace.c |  2 +-
  tools/perf/util/map.c      | 21 +++++++++++++++++++++
  tools/perf/util/map.h      |  3 ++-
  tools/perf/util/symbol.c   |  4 ++--
  4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c5a6e0b1..f3511a6 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1875,7 +1875,7 @@ static bool dso_sym_match(struct symbol *sym, const char *name, int *cnt,
  			  int idx)
  {
  	/* Same name, and global or the n'th found or any */
-	return !arch__compare_symbol_names(name, sym->name) &&
+	return !map__compare_symbol_names(name, sym->name) &&
  	       ((!idx && sym->binding == STB_GLOBAL) ||
  		(idx > 0 && ++*cnt == idx) ||
  		idx < 0);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 4f9a71c..90342ee 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -330,6 +330,27 @@ int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
  	return strcmp(namea, nameb);
  }
  
+int map__compare_symbol_names(const char *namea, const char *nameb)
+{
+	int rc;
+	const char *namea_versioning, *nameb_versioning;
+
+	namea_versioning = strstr(namea,"@@");
+	if (namea_versioning)
+		namea = strndup(namea,namea_versioning-namea);
+
+	nameb_versioning = strstr(nameb,"@@");
+	if (nameb_versioning)
+		nameb = strndup(nameb,nameb_versioning-nameb);
+
+	rc = arch__compare_symbol_names(namea, nameb);
+
+	if (namea_versioning) free((void *)namea);
+	if (nameb_versioning) free((void *)nameb);
+
+	return rc;
+}
+
  struct symbol *map__find_symbol(struct map *map, u64 addr)
  {
  	if (map__load(map) < 0)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index abdacf8..aaad64d 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -130,13 +130,14 @@ struct thread;
   */
  #define __map__for_each_symbol_by_name(map, sym_name, pos)	\
  	for (pos = map__find_symbol_by_name(map, sym_name);	\
-	     pos && arch__compare_symbol_names(pos->name, sym_name) == 0;	\
+	     pos && map__compare_symbol_names(pos->name, sym_name) == 0;	\
  	     pos = symbol__next_by_name(pos))
  
  #define map__for_each_symbol_by_name(map, sym_name, pos)		\
  	__map__for_each_symbol_by_name(map, sym_name, (pos))
  
  int arch__compare_symbol_names(const char *namea, const char *nameb);
+int map__compare_symbol_names(const char *namea, const char *nameb);
  void map__init(struct map *map, enum map_type type,
  	       u64 start, u64 end, u64 pgoff, struct dso *dso);
  struct map *map__new(struct machine *machine, u64 start, u64 len,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dc93940..4fb9d275 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -411,7 +411,7 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
  		int cmp;
  
  		s = rb_entry(n, struct symbol_name_rb_node, rb_node);
-		cmp = arch__compare_symbol_names(name, s->sym.name);
+		cmp = map__compare_symbol_names(name, s->sym.name);
  
  		if (cmp < 0)
  			n = n->rb_left;
@@ -429,7 +429,7 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
  		struct symbol_name_rb_node *tmp;
  
  		tmp = rb_entry(n, struct symbol_name_rb_node, rb_node);
-		if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
+		if (map__compare_symbol_names(tmp->sym.name, s->sym.name))
  			break;
  
  		s = tmp;
-- 
2.1.4

Regards,
Paul Clarke
