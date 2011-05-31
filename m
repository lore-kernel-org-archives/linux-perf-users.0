From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
Subject: Re: A shortcut to select generalized hw events
Date: Tue, 31 May 2011 16:21:55 +0100
Message-ID: <4DE50793.8040607@draigBrady.com>
References: <BANLkTinxXczFsG8hd8fQULiCch8-FnMbBA@mail.gmail.com> <4DDFAB2B.90107@draigBrady.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010104080707060704050903"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail1.slb.deg.dub.stisp.net ([84.203.253.98]:11714 "HELO
	mail1.slb.deg.dub.stisp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756625Ab1EaPYb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 31 May 2011 11:24:31 -0400
In-Reply-To: <4DDFAB2B.90107@draigBrady.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

This is a multi-part message in MIME format.
--------------010104080707060704050903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On 27/05/11 14:46, Pádraig Brady wrote:
> On 27/05/11 13:01, Francis Moreau wrote:
>> Hello,
>>
>> Is there a mean to select all counters of a certain type ?
>>
>> For example I'd like to select all generalized hw counter with
>> perf-stat, is this possible ?
> 
> I was looking for that too.
> I didn't look too hard, but there was nothing obvious.
> It would be very useful for example, to print all hardware counters
> that are supported by the current system as you say.
> To do that, I'm using this perf-hw script:
> 
> #!/bin/sh
> hw_events=$(
>  for i in $(perf list | sed -n 's/\[Hardware.*event\]//; T; s/ OR .*//; p'); do
>     perf stat -e $i true >/dev/null 2>&1 &&
>      printf -- "-e %s \n" $i
>  done | tr -d '\n'
> )
> perf stat $hw_events $*

I've also just noticed the -ddd option recently added with:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2cba3ffb

I've attached some more documentation which might be useful?

cheers,
Pádraig.

--------------010104080707060704050903
Content-Type: text/x-patch;
 name="perf-stat-ddd.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="perf-stat-ddd.diff"

From 50273f3c531b2111343326a22dd76a9c1d893338 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?P=C3=A1draig=20Brady?= <P@draigBrady.com>
Date: Tue, 31 May 2011 16:16:59 +0100
Subject: [PATCH] perf stat: better document the -d option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document fully the -d option from commit 2cba3ffb
* Documentation/perf-stat.txt: Detail the -d option
* builtin-stat.c: Document that -d can be repeated

Signed-off-by: PÃ¡draig Brady <P@draigBrady.com>
---
 tools/perf/Documentation/perf-stat.txt |    6 ++++++
 tools/perf/builtin-stat.c              |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 918cc38..36a6a00 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -50,6 +50,12 @@ OPTIONS
 --scale::
 	scale/normalize counter values
 
+-d::
+        print more detailed statistics - repeat for more
+            -d:           detailed events, L1 and LLC data cache
+            -dd:     more detailed events, dTLB and iTLB events
+            -ddd:    very detailed events, adding prefetch events
+
 -r::
 --repeat=<n>::
 	repeat command and print average + stddev (max: 100)
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a9f0671..a99be46 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1044,7 +1044,7 @@ static const struct option options[] = {
 	OPT_BOOLEAN('n', "null", &null_run,
 		    "null run - dont start any counters"),
 	OPT_INCR('d', "detailed", &detailed_run,
-		    "detailed run - start a lot of events"),
+		    "detailed run - start a lot of events - repeat for more"),
 	OPT_BOOLEAN('S', "sync", &sync_run,
 		    "call sync() before starting a run"),
 	OPT_CALLBACK_NOOPT('B', "big-num", NULL, NULL, 
-- 
1.7.5.1


--------------010104080707060704050903--
