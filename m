From: Andrew Lutomirski <luto@mit.edu>
Subject: perf vsyscall bugs
Date: Thu, 24 Mar 2011 00:36:56 -0400
Message-ID: <AANLkTikxSw5+wJZUWNz++nL7mgivCh_Zf=2Kq6=f9Ce_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55977 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845Ab1CXEhR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 Mar 2011 00:37:17 -0400
Received: by vws1 with SMTP id 1so6209225vws.19
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2011 21:37:16 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org

Perf can't currently trace into the vsyscall page.  It looks like it
was meant to work.
Tested on 2.6.38 and today's -git.

The bug is easy to reproduce.  Compile this:

#include <time.h>

int main()
{
	int i;
	struct timespec t;
	for(i = 0; i < 10000000; i++)
		clock_gettime(CLOCK_MONOTONIC, &t);
	return 0;
}

and run it through perf record; perf report.  The top entry shows
"[unknown]" and you can't zoom in.

It looks like there are two issues.  The first is a that a test for
user mode executing in kernel space
is backwards.  (That's the first hunk below).  The second (I think) is
that something's wrong with the
code that generates lots of little struct dso objects for different
sections -- when it runs on vmlinux
it results in bogus long_name values which cause objdump to fail.  I
don't really understand the
point of that code, so my fix is just a gross kludge.

The patch below applies to 2.6.38 and makes it work.  If only the VDSO
were so easy...

Signed-off-by: Andy Lutomirski <luto@mit.edu>

---

The first hunk is probably safe.  The other part is an eyesore and
probably breaks things that
I haven't tried (like guest mode, maybe).

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 50d0a93..5d6a5a7 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -728,7 +728,7 @@ try_again:
 		 * in the whole kernel symbol list.
 		 */
 		if ((long long)al->addr < 0 &&
-		    cpumode == PERF_RECORD_MISC_KERNEL &&
+		    cpumode == PERF_RECORD_MISC_USER &&
 		    machine && mg != &machine->kmaps) {
 			mg = &machine->kmaps;
 			goto try_again;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b1bf490..f521c03 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1197,6 +1197,8 @@ static int dso__load_sym(struct dso *self,
struct map *map, const char *name,
 				if (curr_dso == NULL)
 					goto out_elf_end;
 				curr_dso->kernel = self->kernel;
+				curr_dso->long_name = self->long_name;
+				curr_dso->long_name_len = self->long_name_len;
 				curr_map = map__new2(start, curr_dso,
 						     map->type);
 				if (curr_map == NULL) {
@@ -1842,6 +1844,9 @@ int dso__load_vmlinux(struct dso *self, struct map *map,
 	if (fd < 0)
 		return -1;

+	/* Gross hack.  dso__load_sym needs long_name to be set so
+	   it can propagate it to per-section DSOs. */
+	dso__set_long_name(self, (char*)vmlinux);
 	dso__set_loaded(self, map->type);
 	err = dso__load_sym(self, map, symfs_vmlinux, fd, filter, 0, 0);
 	close(fd);
