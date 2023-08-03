Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AC1C001DF
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Aug 2023 17:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHCRcm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjHCRcl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Aug 2023 13:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B495F1B9
        for <linux-perf-users@vger.kernel.org>; Thu,  3 Aug 2023 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691083916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V3OZMzxi9fUDHiCuups6Frg0CT+Gs83q33vmZ66OFKg=;
        b=aYQ6x4qvQcAwYq/bt0E+Yb7IDpel6coEgj4jwjwKu9xai2vNZlLAh/jpKd7ubiyI8gfrIb
        4X52jepTqVFZi8l1eSqgc51XlRQexo1CVKu/mFHJ6YsGs99cTPVs0w1PocvSGlGmPp2NYP
        QpLJJ8hSzFbBb2WjjffTFSHFR9OsLyg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-683-fiEGGAMRMa22QAbY26TX0g-1; Thu, 03 Aug 2023 13:31:53 -0400
X-MC-Unique: fiEGGAMRMa22QAbY26TX0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1A5429AA38B;
        Thu,  3 Aug 2023 17:31:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8396AF7FAF;
        Thu,  3 Aug 2023 17:31:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  3 Aug 2023 19:31:11 +0200 (CEST)
Date:   Thu, 3 Aug 2023 19:31:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Show correct error about @symbol for uprobe
Message-ID: <20230803173106.GA15866@redhat.com>
References: <169055397023.67089.12693645664676964310.stgit@devnote2>
 <ZMkAq5yx3+EiQNkF@kernel.org>
 <20230801225618.06cb86992ae30564e5b87554@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801225618.06cb86992ae30564e5b87554@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Masami,

On 08/01, Masami Hiramatsu wrote:
>
> Oleg, what do you think about accessing symbols in data section from
> uprobes? Can we access it from user-land IP-relative address?

Sorry, I don't I understand... I don't even understand the context, can't
find the whole thread on lore.kernel.org/lkml. Plus I forgot EVERYTHING
I knew about tracing/uprobes anyway ;)

but when I look at traceprobe_parse_probe_arg() paths it seems to me that
uprobe can fetch the IP-relative address, not sure about the syntax but
perhaps something like xxx=+OFFSET(%ip). The question is how tools/perf
can calculate this OFFSET. But I am sure you understand this all much
better than me.

> > > --- a/tools/perf/util/probe-event.c
> > > +++ b/tools/perf/util/probe-event.c
> > > @@ -2800,13 +2800,18 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
> > >  	if (!tev->uprobes || tev->nargs == 0 || !buf)
> > >  		goto out;
> > >
> > > -	for (i = 0; i < tev->nargs; i++)
> > > -		if (strglobmatch(tev->args[i].value, "[$@+-]*")) {
> > > -			pr_warning("Please upgrade your kernel to at least "
> > > -				   "3.14 to have access to feature %s\n",
> > > +	for (i = 0; i < tev->nargs; i++) {
> > > +		if (strchr(tev->args[i].value, '@')) {
> > > +			pr_warning("%s accesses a variable by symbol name, but that is not supported for user application probe.\n",
> > > +				   tev->args[i].value);
> > > +			break;

IIUC without this change @symbol will trigger the

			/* uprobes don't support symbols */
			if (!(ctx->flags & TPARG_FL_KERNEL)) {
				trace_probe_log_err(ctx->offset, SYM_ON_UPROBE);
				return -EINVAL;
			}

in parse_probe_arg(), right?

So FWIW the patch looks fine to me, but as you have mentioned tools/perf
could probably (try to) turn @symbol into @+symbol_offset_in_file...

In short, sorry for spam, I can't help ;)

And just in case, I am on PTO till Aug 14, won't be able to read emails
till then.

Oleg.

