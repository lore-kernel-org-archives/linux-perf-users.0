Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AC6C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Jul 2022 16:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiGLQ3f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiGLQ3e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Jul 2022 12:29:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14928BDB9D;
        Tue, 12 Jul 2022 09:29:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900A3618EA;
        Tue, 12 Jul 2022 16:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3A5C3411C;
        Tue, 12 Jul 2022 16:29:31 +0000 (UTC)
Date:   Tue, 12 Jul 2022 12:29:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, peterz@infradead.org, mingo@redhat.com,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220712122930.277cc5d6@gandalf.local.home>
In-Reply-To: <20220703093216.5qpxfvza5dhuknru@erthalion.local>
References: <20220625152429.27539-1-9erthalion6@gmail.com>
        <20220627113731.00fa70887d19a163884243fa@kernel.org>
        <20220703093216.5qpxfvza5dhuknru@erthalion.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, 3 Jul 2022 11:32:16 +0200
Dmitry Dolgov <9erthalion6@gmail.com> wrote:

> Thanks. Is there anything else I can help with to get this change
> committed?

It should go through the perf tree (if it hasn't already).

But you should have Cc'd LKML and not linux-perf-users, as it is a kernel
change not a user change.

For the tracing parts:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
