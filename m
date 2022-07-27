Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1104BC19F29
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Jul 2022 23:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiG0Xdp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiG0Xdo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Jul 2022 19:33:44 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E2613E30;
        Wed, 27 Jul 2022 16:33:43 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id p5-20020a4a4805000000b0043548dba757so17215ooa.8;
        Wed, 27 Jul 2022 16:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6mNGbKG32EZj+pRu9k63GQMtitbdxrC5+KmXFQp3Ho=;
        b=IAPOwnTsAdHaIB9rSWHV/diDkTpxY2MVJMJq4wHHrVNQQn6gEXWFz9a/saiv/Eoj10
         GdEhYxG0b8ROID6SnGyC2fg/IG8bN7VLdVoDG+gzZUVuv4j3mDqzsP2U4vBJgyvAHL5q
         g6XdV18xUNv4aUK7t3aNDY1rSIPQB/MZDL+NpjKSlSOjOqPiXc6/gQ48FjdYmrtwLo2O
         BpDvppxbbBpjLTLk7q7KAJ91oo8K3IvEc0MpEywRbcRM2lyud1006OtisMdIqTAHW+J2
         ++pZAXjFBkUH/WbvQva8qaZ4XBYVcPQqFofbm/WOS1nQAOCjSvB8TQolRVQi09jqDDak
         D9ig==
X-Gm-Message-State: AJIora+PBURQ1XYErUY2ykmMDLdcA57hoqU4KmAx5SvpOoIyROJGyJxy
        5Wbk2c+/EWJdtqDlKb91VZWXJGRYpxSLWbwR8ok=
X-Google-Smtp-Source: AGRyM1v689DudA8J5K9PJqMq422qOAMA/3CE+F3AeykWp8IPzVdloadbmvDr3aQsYiK5A7SnQILyMbRmEfbW2lBtF8Q=
X-Received: by 2002:a4a:d8d2:0:b0:435:66f0:c931 with SMTP id
 c18-20020a4ad8d2000000b0043566f0c931mr8503901oov.97.1658964823011; Wed, 27
 Jul 2022 16:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220709015033.38326-1-yangjihong1@huawei.com> <20220709015033.38326-2-yangjihong1@huawei.com>
In-Reply-To: <20220709015033.38326-2-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jul 2022 16:33:32 -0700
Message-ID: <CAM9d7cjRPSsoAk22xTO=BFQTVn+HmMZkcm7grNehHkbtRWwhgw@mail.gmail.com>
Subject: Re: [RFC v3 01/17] perf kwork: New tool
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Paul Clarke <pc@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Fri, Jul 8, 2022 at 6:53 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> The perf-kwork tool is used to trace time properties of kernel work
> (such as irq, softirq, and workqueue), including runtime, latency,
> and timehist, using the infrastructure in the perf tools to allow
> tracing extra targets.
>
> This is the first commit to reuse perf_record framework code to
> implement a simple record function, kwork is not supported currently.
>
> Test cases:
>
>   # perf
>
>    usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
>
>    The most commonly used perf commands are:
>   <SNIP>
>      iostat          Show I/O performance metrics
>      kallsyms        Searches running kernel for symbols
>      kmem            Tool to trace/measure kernel memory properties
>      kvm             Tool to trace/measure kvm guest os
>      kwork           Tool to trace/measure kernel work properties (latencies)
>      list            List all symbolic event types
>      lock            Analyze lock events
>      mem             Profile memory accesses
>      record          Run a command and record its profile into perf.data
>   <SNIP>
>    See 'perf help COMMAND' for more information on a specific command.
>
>   # perf kwork
>
>    Usage: perf kwork [<options>] {record}
>
>       -D, --dump-raw-trace  dump raw trace in ASCII
>       -f, --force           don't complain, do it
>       -k, --kwork <kwork>   list of kwork to profile
>       -v, --verbose         be more verbose (show symbol address, etc)
>
>   # perf kwork record -- sleep 1
>   [ perf record: Woken up 0 times to write data ]
>   [ perf record: Captured and wrote 1.787 MB perf.data ]
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
[SNIP]
> +
> +static int perf_kwork__record(struct perf_kwork *kwork,
> +                             int argc, const char **argv)
> +{
> +       const char **rec_argv;
> +       unsigned int rec_argc, i, j;
> +       struct kwork_class *class;
> +
> +       const char *const record_args[] = {
> +               "record",
> +               "-a",
> +               "-R",
> +               "-m", "1024",
> +               "-c", "1",

Please consider adding '--synth task' to skip costly synthesis
if you don't need user space symbols.

> +       };
> +
> +       rec_argc = ARRAY_SIZE(record_args) + argc - 1;
> +
> +       list_for_each_entry(class, &kwork->class_list, list)
> +               rec_argc += 2 * class->nr_tracepoints;
> +
> +       rec_argv = calloc(rec_argc + 1, sizeof(char *));
> +       if (rec_argv == NULL)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < ARRAY_SIZE(record_args); i++)
> +               rec_argv[i] = strdup(record_args[i]);
> +
> +       list_for_each_entry(class, &kwork->class_list, list) {
> +               for (j = 0; j < class->nr_tracepoints; j++) {
> +                       rec_argv[i++] = strdup("-e");
> +                       rec_argv[i++] = strdup(class->tp_handlers[j].name);
> +               }
> +       }
> +
> +       for (j = 1; j < (unsigned int)argc; j++, i++)
> +               rec_argv[i] = argv[j];
> +
> +       BUG_ON(i != rec_argc);
> +
> +       pr_debug("record comm: ");
> +       for (j = 0; j < rec_argc; j++)
> +               pr_debug("%s ", rec_argv[j]);
> +       pr_debug("\n");
> +
> +       return cmd_record(i, rec_argv);
> +}
