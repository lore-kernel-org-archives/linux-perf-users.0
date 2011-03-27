From: David Ahern <dsahern@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Sun, 27 Mar 2011 15:09:27 -0600
Message-ID: <4D8FA787.7020308@gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>	<AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>	<4D8DE695.3000606@gmail.com>	<AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>	<4D8DF6E4.1070804@gmail.com>	<AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com>	<4D8EB605.7070407@gmail.com> <AANLkTi=JefJqiUdvZ+r+sS25+bbDG_c6M8825xKpSUnu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46476 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab1C0VKA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 27 Mar 2011 17:10:00 -0400
Received: by yia27 with SMTP id 27so972269yia.19
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Mar 2011 14:09:59 -0700 (PDT)
In-Reply-To: <AANLkTi=JefJqiUdvZ+r+sS25+bbDG_c6M8825xKpSUnu@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: zhao bao <baozhao@gmail.com>
Cc: linux-perf-users@vger.kernel.org



On 03/27/11 01:44, zhao bao wrote:
> The address I want is the value stored  in X86 CR2 register when page
> fault  occurs, Does perf provide these  information?

Add the -d option to perf-record, and try the following change on
perf-script:

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ac574ea..85376b7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -32,6 +32,7 @@ enum perf_output_field {
    PERF_OUTPUT_EVNAME          = 1U << 5,
    PERF_OUTPUT_TRACE           = 1U << 6,
    PERF_OUTPUT_SYM             = 1U << 7,
+   PERF_OUTPUT_ADDR            = 1U << 8,
 };

 struct output_option {
@@ -46,6 +47,7 @@ struct output_option {
    {.str = "event", .field = PERF_OUTPUT_EVNAME},
    {.str = "trace", .field = PERF_OUTPUT_TRACE},
    {.str = "sym",   .field = PERF_OUTPUT_SYM},
+   {.str = "addr",   .field = PERF_OUTPUT_ADDR},
 };

 /* default set to maintain compatibility with current format */
@@ -158,6 +160,8 @@ static void print_sample_start(struct perf_sample
*sample,

        printf("%s: ", evname ? evname : "(unknown)");
    }
+   if (PRINT_FIELD(ADDR))
+       printf("0x%" PRIx64, sample->addr);
 }

 static void process_event(union perf_event *event __unused,
@@ -829,7 +833,7 @@ static const struct option options[] = {
    OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
            "Look for files with symbols relative to this directory"),
    OPT_CALLBACK('f', "fields", NULL, "str",
-            "comma separated output fields prepend with 'type:'. Valid
types: hw,sw,trace. Fields: comm,tid,pid,time,cpu,event,trace,sym",
+            "comma separated output fields prepend with 'type:'. Valid
types: hw,sw,trace. Fields: comm,tid,pid,time,cpu,event,trace,sym,addr",
             parse_output_fields),

    OPT_END()


> 
> Another question.
> I find  a new utility called 'trace' mentioned in
> http://lwn.net/Articles/415728/  which provides I want (trace report
> -p). But I git the tip tree,  and make -j install in   tools/perf
> directory,  I couldn't find trace utility. Where is the trace utility?
