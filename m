From: =?iso-2022-jp?B?GyRCSj8+PjJtTCYbKEIgLyBISVJBTUFUVRskQiEkGyhCTUFTQU1J?=
	<masami.hiramatsu.pt@hitachi.com>
Subject: RE: [RFC] perf: probe_finder: continue if atleast one probe point
 found
Date: Tue, 1 Mar 2016 04:29:18 +0000
Message-ID: <50399556C9727B4D88A595C8584AAB37B4E27589@GSjpTKYDCembx32.service.hitachi.net>
References: <1456658087-4107-1-git-send-email-agnel.joel@gmail.com>
 <56D2DB9B.4090500@gmail.com>
 <CAD=GYpZtDb3ugJRFQg1karJ_Fb7RsGPpSu0ZbL8i9Oy8x5eZ9A@mail.gmail.com>
 <20160229141944.GF8720@kernel.org>
 <50399556C9727B4D88A595C8584AAB37B4E274CB@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:55848 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbcCAE3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 29 Feb 2016 23:29:22 -0500
In-Reply-To: <50399556C9727B4D88A595C8584AAB37B4E274CB@GSjpTKYDCembx32.service.hitachi.net>
Content-Language: ja-JP
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "'ltc-kernel@ml.yrl.intra.hitachi.co.jp'" <ltc-kernel@ml.yrl.intra.hitachi.co.jp>, 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc: Joel Fernandes <agnel.joel@gmail.com>, Taeung Song <treeze.taeung@gmail.com>, Joel Fernandes <joel.opensrc@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, sysp-manager <cti.systems-productivity-manager.ts@hitachi.com>

BTW,

./perf probe  \
  -k ./vmlinux -s ./ -x /lib/x86_64-linux-gnu/libc.so.6 -a 'malloc $params'

might help your case. $params is expanded to function parameters automatically
and if there is no parameters, it is just ignored :)

Thank you,

>From: 平松雅巳 / HIRAMATU，MASAMI [mailto:masami.hiramatsu.pt@hitachi.com]
>
>Hi,
>
>>From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
>>
>>Em Sun, Feb 28, 2016 at 03:49:44AM -0800, Joel Fernandes escreveu:
>>> Taeung,
>>>
>>> Thanks for that. As this is an RFC, I have added them now to this email
>>> thread and when I post the final patch, I'll include them in CC.
>>>
>>> All,
>>> Please provide your comments on my patch.
>>
>>Masami, are you ok with this patch?
>
>Hmm, I think this is not enough. I concider that the case if users
>expect probing on "__malloc_get_state+11", just ignoring it may
>confuse or mislead them that perf-probe has a bug not to find it.
>
>IOW, this was by design that perf probe refuses all probe point
>if it hits any error.
>
>I think we have 2 options, one is adding an option (or reuse --force)
>to ignore error on finding probe points (but this MUST show the error
>message by pr_error.) The other is extending perf probe's argument
>format so that it can accept local-vars which may not exist, e.g.
>'malloc *bytes' or 'malloc {bytes,}' :)
>
>Thank you,
>
>
>>
>>- Arnaldo
>>
>>> Thanks,
>>> Joel
>>>
>>> On Sun, Feb 28, 2016 at 3:35 AM, Taeung Song <treeze.taeung@gmail.com>
>>> wrote:
>>>
>>> > Hi, Joel
>>> >
>>> > perf subsystem's maintainers are
>>> > Arnaldo Carvalho de Melo <acme@kernel.org>
>>> > Peter Zijlstra <peterz@infradead.org>
>>> > Ingo Molnar <mingo@redhat.com>
>>> >
>>> > (or Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>)
>>> >
>>> > AFAIK,
>>> > When sending some patches, it would be better to add them into To: or Cc:
>>> >
>>> >
>>> > Thanks,
>>> > Taeung
>>> >
>>> >
>>> > On 02/28/2016 08:14 PM, Joel Fernandes wrote:
>>> >
>>> >> Sometimes for inline functions, perf probe can fail such as if an
>>> >> arguments are
>>> >> requested at probe points. This is probably because when the compiler
>>> >> inlines,
>>> >> for some instances it optimizes away arguments. Either way, the DWARF has
>>> >> missing arguments for certain probe points of inline functions causing
>>> >> 'perf
>>> >> probe' to fail. I noticed this when probing the C library that ships with
>>> >> my
>>> >> distribution. With the following patch I am successfully able to record
>>> >> kprobe
>>> >> events with arguments.
>>> >>
>>> >> Test
>>> >> ----
>>> >>   ./perf probe \
>>> >>     -k ./vmlinux -s ./ -x /lib/x86_64-linux-gnu/libc.so.6 -a 'malloc
>>> >> bytes' -v
>>> >>
>>> >> Without the patch
>>> >> -----------------
>>> >> Matched function: __libc_malloc
>>> >> found inline addr: 0x831a6
>>> >> Probe point found: malloc_atfork+150
>>> >> Searching 'bytes' variable in context.
>>> >> Converting variable bytes into trace event.
>>> >> bytes type is long unsigned int.
>>> >> found inline addr: 0x844a0
>>> >> Probe point found: __libc_malloc+0
>>> >> Searching 'bytes' variable in context.
>>> >> Converting variable bytes into trace event.
>>> >> bytes type is long unsigned int.
>>> >> found inline addr: 0x8463b
>>> >> Probe point found: __malloc_get_state+11
>>> >> Searching 'bytes' variable in context.
>>> >> Failed to find 'bytes' in this function.
>>> >> An error occurred in debuginfo analysis (-2).
>>> >>    Error: Failed to add events. Reason: No such file or directory (Code:
>>> >> -2)
>>> >>
>>> >> With the patch
>>> >> --------------
>>> >> Open Debuginfo file: /usr/lib/debug/lib/x86_64-linux-gnu/libc-2.21.so
>>> >> Try to find probe point from debuginfo.
>>> >> Symbol malloc address found : 844a0
>>> >> Matched function: __libc_malloc
>>> >> found inline addr: 0x831a6
>>> >> Probe point found: malloc_atfork+150
>>> >> Searching 'bytes' variable in context.
>>> >> Converting variable bytes into trace event.
>>> >> bytes type is long unsigned int.
>>> >> found inline addr: 0x844a0
>>> >> Probe point found: __libc_malloc+0
>>> >> Searching 'bytes' variable in context.
>>> >> Converting variable bytes into trace event.
>>> >> bytes type is long unsigned int.
>>> >> found inline addr: 0x8463b
>>> >> Probe point found: __malloc_get_state+11
>>> >> Searching 'bytes' variable in context.
>>> >> Failed to find 'bytes' in this function.
>>> >> Probe point error, ignoring. Atleast one probe point found
>>> >> found inline addr: 0x84bba
>>> >> Probe point found: __libc_realloc+410
>>> >> Searching 'bytes' variable in context.
>>> >> Failed to find 'bytes' in this function.
>>> >> Probe point error, ignoring. Atleast one probe point found
>>> >> found inline addr: 0x84d08
>>> >> ...
>>> >> Probe point error, ignoring. Atleast one probe point found
>>> >> Found 3 probe_trace_events.
>>> >> Opening /sys/kernel/debug/tracing//uprobe_events write=1
>>> >> Writing event: p:probe_libc/malloc /lib/x86_64-linux-gnu/libc-2.21.so:0x831a6
>>> >> bytes=%bp:u64
>>> >> Writing event: p:probe_libc/malloc_1 /lib/x86_64-linux-gnu/libc-2.21.so:0x844a0
>>> >> bytes=%di:u64
>>> >> Writing event: p:probe_libc/malloc_2 /lib/x86_64-linux-gnu/libc-2.21.so:0x85af7
>>> >> bytes=%di:u64
>>> >> Added new events:
>>> >>    probe_libc:malloc    (on malloc in /lib/x86_64-linux-gnu/libc-2.21.so
>>> >> with bytes)
>>> >>    probe_libc:malloc_1  (on malloc in /lib/x86_64-linux-gnu/libc-2.21.so
>>> >> with bytes)
>>> >>    probe_libc:malloc_2  (on malloc in /lib/x86_64-linux-gnu/libc-2.21.so
>>> >> with bytes)
>>> >>
>>> >> Signed-off-by: Joel Fernandes <agnel.joel@gmail.com>
>>> >> ---
>>> >>   tools/perf/util/probe-finder.c | 4 ++++
>>> >>   1 file changed, 4 insertions(+)
>>> >>
>>> >> diff --git a/tools/perf/util/probe-finder.c
>>> >> b/tools/perf/util/probe-finder.c
>>> >> index 4ce5c5e..3ac9481 100644
>>> >> --- a/tools/perf/util/probe-finder.c
>>> >> +++ b/tools/perf/util/probe-finder.c
>>> >> @@ -1255,6 +1255,10 @@ end:
>>> >>         if (ret) {
>>> >>                 clear_probe_trace_event(tev);
>>> >>                 tf->ntevs--;
>>> >> +               if (tf->ntevs != 0) {
>>> >> +                       pr_debug("Ignoring error as atleast one probe
>>> >> point found.\n");
>>> >> +                       ret = 0;
>>> >> +               }
>>> >>         }
>>> >>         free(args);
>>> >>         return ret;
>>> >>
>>> >>
