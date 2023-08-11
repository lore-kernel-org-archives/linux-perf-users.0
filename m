Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F773C001DE
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Aug 2023 17:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbjHKR2W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjHKR2R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2023 13:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4960BCE;
        Fri, 11 Aug 2023 10:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB57F61231;
        Fri, 11 Aug 2023 17:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7006FC433C9;
        Fri, 11 Aug 2023 17:28:13 +0000 (UTC)
Date:   Fri, 11 Aug 2023 13:28:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, irogers@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, zegao@tencent.com
Subject: Re: [PATCH] perf sched: parse task state from tracepoint print
 format
Message-ID: <20230811132811.28b9b766@gandalf.local.home>
In-Reply-To: <20230810055023.67529-2-zegao@tencent.com>
References: <20230803234122.19b3d3a4@rorschach.local.home>
        <20230810055023.67529-2-zegao@tencent.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 10 Aug 2023 01:50:24 -0400
Ze Gao <zegao2021@gmail.com> wrote:

> Hi Steven,
> 
> I managed to build task state char map dynamically by parsing
> the tracepoint print format from data recorded by perf. And
> likewise for libtraceevent.
> 
> FYI, I tried TEP_PRINT_INFO but no shot. It turns out TEP_PRINT_INFO
> stills relies on libtraceevent (i.e., sched_switch_handler() in 
> plugin_sched_switch.c) and we need to parse the print format on our own.

There is a way to unload plugins:

	tep_unload_plugins(t->plugin_list, tep);

Hmm, I should add:

	tep_unload_plugin(tep, t->plugin_list, "plugin-name");

To unload a single plugin.

I it can also just override what the plugin does by calling:

static int sched_switch_handler(struct trace_seq *s,
				struct tep_record *record,
				struct tep_event *event, void *context)
{
	// do whatever you want.
}

	tep_register_event_handler(tep, -1, "sched", "sched_switch",
				   sched_switch_handler, NULL);

> 
> Anyway, it works now and I've tested on some perf.data in old formats
> but not cover all the kernel releases.
> 
> Thoughts?

I don't maintain the perf code. You'll have to talk with the perf
maintainers.

-- Steve
