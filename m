Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCECBC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 14:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFEFF60F14
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 14:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbhIFO1p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Sep 2021 10:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243326AbhIFO1o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Sep 2021 10:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630938397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pa5lyXJkuizLFBwGfxieATj3aTl2wYZdhrQMYfu5ilI=;
        b=TdeZtMW4szplGy9jaCN4hYfuLQr1AD7RE6fEElyfpTDrkDY9UL0AdHO5TRBdXLYjo1lfr1
        nH3U6rMW3b1P0Eu82XIHLAc8dKunIO67LM8EtwJZll+3tvYx2HkjvQ8IU68D9obmo3h3jJ
        VhRXoIv8yteLkMSD/BgpTMswP+TG72I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-pV4q-AshMhiHcUdQZrJcQg-1; Mon, 06 Sep 2021 10:26:36 -0400
X-MC-Unique: pV4q-AshMhiHcUdQZrJcQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DB2E81431C;
        Mon,  6 Sep 2021 14:26:35 +0000 (UTC)
Received: from Diego (unknown [10.39.208.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9662118761;
        Mon,  6 Sep 2021 14:26:33 +0000 (UTC)
Date:   Mon, 6 Sep 2021 16:26:31 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     acme@redhat.com
cc:     linux-perf-users@vger.kernel.org, jolsa@redhat.com,
        sumanthk@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix bpf test sample mismatch reporting
In-Reply-To: <20210805160611.5542-1-mpetlan@redhat.com>
Message-ID: <alpine.LRH.2.20.2109061625540.27231@Diego>
References: <20210805160611.5542-1-mpetlan@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo, please have a look.
This is still valid.
Thanks.
Michael

On Thu, 5 Aug 2021, Michael Petlan wrote:
> When the expected sample count in the condition changed, the message
> needs to be changed too, otherwise we'll get:
> 
>   0x1001f2091d8: mmap mask[0]:
>   BPF filter result incorrect, expected 56, got 56 samples
> 
> Fixes: 4b04e0decd25 ("perf test: Fix basic bpf filtering test")
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/tests/bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index dbf5f5215abe..fa03ff0dc083 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -192,7 +192,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
>  	}
>  
>  	if (count != expect * evlist->core.nr_entries) {
> -		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect, count);
> +		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect * evlist->core.nr_entries, count);
>  		goto out_delete_evlist;
>  	}
>  
> -- 
> 2.18.4
> 
> 

