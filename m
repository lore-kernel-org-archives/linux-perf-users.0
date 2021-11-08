Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183C8C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC42A6115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 15:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbhKHP1X (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 10:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhKHP1X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 10:27:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC195C061570;
        Mon,  8 Nov 2021 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ifil5zeZzBeMdGep2fEek9iKOuh1Q96iQHGmTHqvI0w=; b=HOi318BEWDtA70Q+Jy4/U+cvn9
        2MuQaUsGbmpTac/PKZEJF3a/KsvMTDVPCYMNei/oBob+wQcjVmEMsTsSCk7AWlIbPK1pHUz5wepsJ
        iFwYiNit1JLz1BQc+gzvsvbnAAhlPNPl+3LI7RANm6YUkVkxaOuwOzp1PRwMnaHFCuWVnzDAbL3Ke
        jhacBfvBRJI66O1O/iOoQBE6QiSkV9Quy6vHb6251DoSSRJtYgAyVD8khMjxdZWlPsLlNliz5/yNH
        YCZ4vHjyC6Tb4QbCrd6q95rjSiEVVNh3/ZQadrOeeXqvANVsyUJJ+qqRb9GcjV2V4i5vdh3GVQZuY
        2N/FOJHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk6Ve-00EuBn-Q0; Mon, 08 Nov 2021 15:24:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B4CB3000DD;
        Mon,  8 Nov 2021 16:24:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B5C8202A0135; Mon,  8 Nov 2021 16:24:34 +0100 (CET)
Date:   Mon, 8 Nov 2021 16:24:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     kan.liang@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: Using perf_event_open() to sample multiple events of a process
Message-ID: <YYlBMmMg0PTV3pED@hirez.programming.kicks-ass.net>
References: <92645262-D319-4068-9C44-2409EF44888E@gmail.com>
 <YYXQRYbRO193U4re@hirez.programming.kicks-ass.net>
 <YYXS8yldO/dwwVD4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYXS8yldO/dwwVD4@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Nov 06, 2021 at 01:57:23AM +0100, Peter Zijlstra wrote:

> The problem seems to be that we call perf_event_set_output() before we
> set event->ctx, which is a bit of a problem.
> 
> Now, afaict it's been broken since c3f00c70276d ("perf: Separate
> find_get_context() from event initialization"), which is ages ago :/
> 
> It's waaay too late to try and fix it; I'll be likely to make an even
> bigger mess if I tried. Perhaps tomorrow.
> 
> Clearly FD_OUTPUT isn't much used :-(

The below seems to fix, it's a bit of a hack, but I couldn't really come
up with anything saner.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f2253ea729a2..dbe766663733 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5595,6 +5595,7 @@ static inline int perf_fget_light(int fd, struct fd *p)
 }
 
 static int perf_event_set_output(struct perf_event *event,
+				 struct perf_event_context *ctx,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
@@ -5647,10 +5648,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 			if (ret)
 				return ret;
 			output_event = output.file->private_data;
-			ret = perf_event_set_output(event, output_event);
+			ret = perf_event_set_output(event, event->ctx, output_event);
 			fdput(output);
 		} else {
-			ret = perf_event_set_output(event, NULL);
+			ret = perf_event_set_output(event, event->ctx, NULL);
 		}
 		return ret;
 	}
@@ -11830,7 +11831,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 }
 
 static int
-perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
+perf_event_set_output(struct perf_event *event,
+		      struct perf_event_context *event_ctx,
+		      struct perf_event *output_event)
 {
 	struct perf_buffer *rb = NULL;
 	int ret = -EINVAL;
@@ -11851,7 +11854,7 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 	/*
 	 * If its not a per-cpu rb, it must be the same task.
 	 */
-	if (output_event->cpu == -1 && output_event->ctx != event->ctx)
+	if (output_event->cpu == -1 && output_event->ctx != event_ctx)
 		goto out;
 
 	/*
@@ -12232,7 +12235,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (output_event) {
-		err = perf_event_set_output(event, output_event);
+		err = perf_event_set_output(event, ctx, output_event);
 		if (err)
 			goto err_context;
 	}
