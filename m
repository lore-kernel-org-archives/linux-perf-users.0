Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4321CE79CB
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Sep 2023 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjITK6c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Sep 2023 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjITK6b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Sep 2023 06:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38F97
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695207463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAggLEBGq72aCJlFNytjAeaSovw1fL5Cw4HeabiSiWk=;
        b=TE7SS6UVCM+xgT5dCjia7TscwW0bB7l9TlpnVehXW8bP9ww7vM7IIHYABLwGiSlA8eXwWe
        d2CLT3oGsXp7LHyECEe2AzwVXkZM0L7vE5iUB0CSMzvQDCReIbxfE11xG93yzcrXKWvZ49
        xnFyTkvUTNw2zDpc5t0bvNyz1zb4LKo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-9D7x3AYJNXiTHPUqk05CFw-1; Wed, 20 Sep 2023 06:57:40 -0400
X-MC-Unique: 9D7x3AYJNXiTHPUqk05CFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2CB02999B26;
        Wed, 20 Sep 2023 10:57:39 +0000 (UTC)
Received: from Diego (unknown [10.39.208.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9155051E3;
        Wed, 20 Sep 2023 10:57:38 +0000 (UTC)
Date:   Wed, 20 Sep 2023 12:57:36 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     vmolnaro@redhat.com
cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Subject: Re: [PATCH 2/2] perf test lock_contention.sh: Skip test if not enough
 CPUs
In-Reply-To: <20230919150419.23193-2-vmolnaro@redhat.com>
Message-ID: <alpine.LRH.2.20.2309201257260.3810@Diego>
References: <20230919150419.23193-1-vmolnaro@redhat.com> <20230919150419.23193-2-vmolnaro@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 19 Sep 2023, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Machines with less then 4 CPUs weren't consistently triggering lock
> events required for the test.
> 
> Skip the test on those machines. The limit of 4 CPUs is set as it
> generates around 100 lock events for a test.
> 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>

Acked-by: Michael Petlan <mpetlan@redhat.com>
> ---
> Resending the patches with sign-off as it didn't go through last time, 
> also tried to fix the found issues.
> 
>  tools/perf/tests/shell/lock_contention.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> index f2cc187b618..768c10f1d6b 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -32,6 +32,12 @@ check() {
>  		err=2
>  		exit
>  	fi
> +
> +	if [ `nproc` -lt 4 ]; then
> +		echo "[Skip] Low number of CPUs (`nproc`), lock event cannot be triggered certainly"
> +		err=2
> +		exit
> +	fi
>  }
>  
>  test_record()
> -- 
> 2.41.0
> 
> 

