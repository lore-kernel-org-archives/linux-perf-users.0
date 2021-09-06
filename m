Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F40C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 14:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E90360C51
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 14:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbhIFORe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Sep 2021 10:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242521AbhIFORd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Sep 2021 10:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630937788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A9LTAmrB/SMWL9k88RGaI4MEPyQE5adtMZOmJcMHJ3Q=;
        b=drG3hH4iLSVgiICG/1Zphstgf/33S3lPJMoTMnajGfP3gIYy8GbCqnIpbdZFPKny4yllV4
        625Zpo85m2R8oSiMSnGAxVmGF+5uGXkIRdVBedlWGbTa279jVhyZiTyYA3zMkA67+dBUgf
        LV8Lje5+FRRJ2O/TolB7HUQ4fk+DZWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-dqmOkdirP4K_NLm6Da3XXQ-1; Mon, 06 Sep 2021 10:16:26 -0400
X-MC-Unique: dqmOkdirP4K_NLm6Da3XXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03940107ACF7
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Sep 2021 14:16:26 +0000 (UTC)
Received: from Diego (unknown [10.39.208.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7497760861;
        Mon,  6 Sep 2021 14:16:24 +0000 (UTC)
Date:   Mon, 6 Sep 2021 16:16:21 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     acme@redhat.com
cc:     linux-perf-users@vger.kernel.org, jolsa@redhat.com,
        pbonzini@redhat.com
Subject: Re: [PATCH] perf scripts python: fix passing arguments to stackcollapse
 report
In-Reply-To: <20200427142327.21172-1-mpetlan@redhat.com>
Message-ID: <alpine.LRH.2.20.2109061615390.27231@Diego>
References: <20200427142327.21172-1-mpetlan@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo, could you merge this?
It seems still valid.

Thank you.
Michael


On Mon, 27 Apr 2020, Michael Petlan wrote:
> The '--' prevented arguments from being passed to the script, such as:
> 
>   $ perf script report stackcollapse -i my_perf.data
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/scripts/python/bin/stackcollapse-report | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/bin/stackcollapse-report b/tools/perf/scripts/python/bin/stackcollapse-report
> index 356b9656393d..21a356bd27f6 100755
> --- a/tools/perf/scripts/python/bin/stackcollapse-report
> +++ b/tools/perf/scripts/python/bin/stackcollapse-report
> @@ -1,3 +1,3 @@
>  #!/bin/sh
>  # description: produce callgraphs in short form for scripting use
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/stackcollapse.py -- "$@"
> +perf script -s "$PERF_EXEC_PATH"/scripts/python/stackcollapse.py "$@"
> -- 
> 2.18.1
> 
> 

