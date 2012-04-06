From: David Ahern <dsahern@gmail.com>
Subject: Re: perf report -k kfoo -C bar (3.2.14) crashes
Date: Fri, 06 Apr 2012 08:59:13 -0600
Message-ID: <4F7F04C1.6090007@gmail.com>
References: <CAEmqk_wOgktquxBmMUyW1EskHOrca0n3OLnFp3yEk5UHPM0nHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34225 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840Ab2DFO7R (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 6 Apr 2012 10:59:17 -0400
Received: by pbcun15 with SMTP id un15so2720625pbc.19
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Apr 2012 07:59:16 -0700 (PDT)
In-Reply-To: <CAEmqk_wOgktquxBmMUyW1EskHOrca0n3OLnFp3yEk5UHPM0nHg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kant <fnord.hammer@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 4/6/12 5:36 AM, Kant wrote:
> (gdb) bt
> #0  0x000000000041adb0 in __cmd_report () at builtin-report.c:315
> #1  cmd_report (argc=<optimized out>, argv=<optimized out>,
> prefix=<optimized out>) at builtin-report.c:575
> #2  0x000000000041129f in run_builtin (p=p@entry=0x6aab88,
> argc=argc@entry=6, argv=argv@entry=0x7e2c43b8e760) at perf.c:286
> #3  0x0000000000410b2f in handle_internal_command
> (argv=0x7e2c43b8e760, argc=6) at perf.c:358
> #4  run_argv (argv=0x7e2c43b8e560, argcp=0x7e2c43b8e56c) at perf.c:402
> #5  main (argc=6, argv=0x7e2c43b8e760) at perf.c:512
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Fixed by 47fbe53bef3b219a365ebf3eca949d6cd4c5291c.I guess that one did 
not make it into 3.2 stable.

Here's the diff if you want to apply it to your branch:

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 85c1e6b7..0f4555c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1333,6 +1333,10 @@ int perf_session__cpu_bitmap(struct perf_session 
*session,
     }

     map = cpu_map__new(cpu_list);
+   if (map == NULL) {
+       pr_err("Invalid cpu_list\n");
+       return -1;
+   }

     for (i = 0; i < map->nr; i++) {
         int cpu = map->map[i];

David
