Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E9EE49A0
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 09:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjHWJOp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjHWJKj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 05:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DBA44B7
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692781337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wj9WtxEbLvJzHkSH6esfeJqU4Dl1HSMUDKMoaMlX9Uc=;
        b=fTQ4qR2M9QrHInuzvVZh2/IVxD5HjylN5M3/ykfY5a8B6tf4bmsdq2oGsR62dp6JlRUOGT
        7gCOa0LHV1GOiJoSfuzS3olSKTq5CdNZ3mPMgnypeAkNaJiRs8umK5v9qasw/3clyIzU7X
        TzOSK2Ev7K3SMQ3jsp8GMrcgt0LbfmE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-4r1Nb1OAMC2LLKdxhXrG7Q-1; Wed, 23 Aug 2023 05:02:16 -0400
X-MC-Unique: 4r1Nb1OAMC2LLKdxhXrG7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8B3885D184;
        Wed, 23 Aug 2023 09:02:15 +0000 (UTC)
Received: from Diego (unknown [10.39.208.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B7781121315;
        Wed, 23 Aug 2023 09:02:14 +0000 (UTC)
Date:   Wed, 23 Aug 2023 11:02:12 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     vmolnaro@redhat.com
cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Subject: Re: [PATCH 1/2] perf test lock_contention.sh: Skip test if the number
 of CPUs is low
In-Reply-To: <20230821090053.8807-1-vmolnaro@redhat.com>
Message-ID: <alpine.LRH.2.20.2308231101250.3810@Diego>
References: <20230821090053.8807-1-vmolnaro@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 21 Aug 2023, vmolnaro@redhat.com wrote:
> From: notValord <v.m.veverka@gmail.com>
> 
> Machines with less then 4 CPUs weren't consistently triggering lock
> events required for the test.
> 
> Skip the test on those machines. The limit of 4 CPUs is set as it
> generates around 100 lock events for a test.

Acked-by: Michael Petlan <mpetlan@redhat.com>

> ---
>  tools/perf/tests/shell/lock_contention.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> index f2cc187b618..1d3598ff6a0 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -31,6 +31,12 @@ check() {
>  		echo "[Skip] No lock contention tracepoints"
>  		err=2
>  		exit
> +	fi 
> +
> +	if [ `nproc` -lt 4 ]; then
> +		echo "[Skip] Low number of CPUs (`nproc`), lock event cannot be triggered certainly"
> +		err=2
> +		exit
>  	fi
>  }
>  
> -- 
> 2.41.0
> 
> 

