From: Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] perf tests attr: Fix group stat tests
Date: Thu, 28 Sep 2017 18:06:33 +0200
Message-ID: <20170928160633.GA26973@krava>
References: <20170913081209.39570-1-tmricht@linux.vnet.ibm.com>
 <20170913081209.39570-2-tmricht@linux.vnet.ibm.com>
 <20170928152651.GB7264@kernel.org>
 <20170928155859.GC2000@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbdI1QGh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Sep 2017 12:06:37 -0400
Content-Disposition: inline
In-Reply-To: <20170928155859.GC2000@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

On Thu, Sep 28, 2017 at 05:58:59PM +0200, Jiri Olsa wrote:
> On Thu, Sep 28, 2017 at 12:26:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Sep 13, 2017 at 10:12:09AM +0200, Thomas Richter escreveu:
> > > Command perf test -v 16 (Setup struct perf_event_attr test)
> > > always reports success even if the test case fails.
> > > It works correctly if you also specify -F (for don't fork).
> > 
> > So, now I'm getting:
> > 
> > [root@jouet ~]# uname -a
> > Linux jouet 4.13.0+ #3 SMP Mon Sep 25 11:51:22 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
> > [root@jouet ~]# perf test -vv 16
> > 16: Setup struct perf_event_attr                          :
> > --- start ---
> > test child forked, pid 10932
> > running '/home/acme/libexec/perf-core/tests/attr/test-stat-group'
> >   'PERF_TEST_ATTR=/tmp/tmpI_lp9P /home/acme/bin/perf stat -o /tmp/tmpI_lp9P/perf.data --group -e cycles,instructions kill >/dev/null 2>&1' ret '1', expected '1'
> > expected read_format=3, got 15
> > FAILED '/home/acme/libexec/perf-core/tests/attr/test-stat-group' - match failure
> > test child finished with -1
> > ---- end ----
> > Setup struct perf_event_attr: FAILED!
> > [root@jouet ~]#
> > 
> > Jiri?
> 
> 
> there was the change to use group read when we can,
> so we need following change I think
> 
> I'll check more and post full patch

---
We started to use group read whenever it's possible:
  82bf311e15d2 perf stat: Use group read for event groups

That breaks some of attr tests, this change adds the
new possible read_format value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/attr/test-stat-group  | 2 ++
 tools/perf/tests/attr/test-stat-group1 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/tests/attr/test-stat-group b/tools/perf/tests/attr/test-stat-group
index fdc1596a8862..e15d6946e9b3 100644
--- a/tools/perf/tests/attr/test-stat-group
+++ b/tools/perf/tests/attr/test-stat-group
@@ -6,6 +6,7 @@ ret     = 1
 [event-1:base-stat]
 fd=1
 group_fd=-1
+read_format=3|15
 
 [event-2:base-stat]
 fd=2
@@ -13,3 +14,4 @@ group_fd=1
 config=1
 disabled=0
 enable_on_exec=0
+read_format=3|15
diff --git a/tools/perf/tests/attr/test-stat-group1 b/tools/perf/tests/attr/test-stat-group1
index 2a1f86e4a904..1746751123dc 100644
--- a/tools/perf/tests/attr/test-stat-group1
+++ b/tools/perf/tests/attr/test-stat-group1
@@ -6,6 +6,7 @@ ret     = 1
 [event-1:base-stat]
 fd=1
 group_fd=-1
+read_format=3|15
 
 [event-2:base-stat]
 fd=2
@@ -13,3 +14,4 @@ group_fd=1
 config=1
 disabled=0
 enable_on_exec=0
+read_format=3|15
-- 
2.13.5
