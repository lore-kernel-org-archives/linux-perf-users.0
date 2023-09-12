Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB3CA0EC3
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 12:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjILMWb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjILMW1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 08:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B71C10D2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694521298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WmneyOPfrM1X7vJ0rCfE0DMx+A3w7c3cN38XzKAKpa8=;
        b=LPqSpIVHfVGDgEbKVnxgVVsoMw9x6/KbFnpQnIcWb0uKXGoTojdoz5OG82+zu4Mjb8Gbjy
        vVqh9lhcjnd/qgDg1gcHMiYQHwZMhu+51lkS8ajtW/vNp0cUb3LV7ogkxV9IYArGtVEqsW
        gcutVDV6wwXKXGaVW49K3LjD/0MCLnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-GXdIXhELOcaJWs0YrX91YA-1; Tue, 12 Sep 2023 08:21:37 -0400
X-MC-Unique: GXdIXhELOcaJWs0YrX91YA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0A8B181A6E1;
        Tue, 12 Sep 2023 12:21:36 +0000 (UTC)
Received: from Diego (unknown [10.39.208.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8976B40C2064;
        Tue, 12 Sep 2023 12:21:35 +0000 (UTC)
Date:   Tue, 12 Sep 2023 14:21:33 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     vmolnaro@redhat.com
cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Subject: Re: [PATCH 1/2] perf test lock_contention.sh: Skip test if the number
 of CPUs is low
In-Reply-To: <20230912121926.12111-1-vmolnaro@redhat.com>
Message-ID: <alpine.LRH.2.20.2309121421120.3810@Diego>
References: <20230912121926.12111-1-vmolnaro@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 12 Sep 2023, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
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

