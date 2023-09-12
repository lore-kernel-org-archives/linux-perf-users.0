Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B354CA0EC3
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 12:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjILMXB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjILMXA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 08:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 862F710D5
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694521329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CDEPHFopRZA+PuiZRei3lkTc2CBm4TBtrZiF0tF5PU0=;
        b=B/m5a4Tt1yDGXbF6KuJ1TVmaP2r8xXu9OXgSZTziiIHKD9EeHfEnIRW9OnAop3OMWrxLcq
        vZrVyy35+9fqh7dZXE74cMP8J1qWL/sDTQqyUL1QK7T4GkXdT8sMT60sy8EZ7jXe0+afbY
        ouVaYzn3AFh3XyHF/H00KY8YR55broI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-RuqSgqdtPSGiXNcA801LVA-1; Tue, 12 Sep 2023 08:22:08 -0400
X-MC-Unique: RuqSgqdtPSGiXNcA801LVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5E443800BD2;
        Tue, 12 Sep 2023 12:22:07 +0000 (UTC)
Received: from Diego (unknown [10.39.208.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B0A40C6EA8;
        Tue, 12 Sep 2023 12:22:06 +0000 (UTC)
Date:   Tue, 12 Sep 2023 14:22:04 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     vmolnaro@redhat.com
cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Subject: Re: [PATCH 2/2] perf test stat+shadow_stat.sh: Add threshold for
 rounding errors
In-Reply-To: <20230912121926.12111-2-vmolnaro@redhat.com>
Message-ID: <alpine.LRH.2.20.2309121421440.3810@Diego>
References: <20230912121926.12111-1-vmolnaro@redhat.com> <20230912121926.12111-2-vmolnaro@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 12 Sep 2023, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> The test was failing in specific scenarios due to imperfection of FP
> arithmetics. The `bc` command wasn't correctly rounding the result
> of division causing the failure.
> 
> Replace the `bc` with `awk` which should work with more decimal
> places and add a threshold to catch any possible rounding errors.
> The acceptable rounding error is set to 0.01 when the test
> passes with a warning message.

Acked-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/tests/shell/stat+shadow_stat.sh | 30 +++++++++++++++++-----
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
> index 0e9cba84e75..73c990fe5ee 100755
> --- a/tools/perf/tests/shell/stat+shadow_stat.sh
> +++ b/tools/perf/tests/shell/stat+shadow_stat.sh
> @@ -4,6 +4,8 @@
>  
>  set -e
>  
> +TRESHOLD=0.015
> +
>  # skip if system-wide mode is forbidden
>  perf stat -a true > /dev/null 2>&1 || exit 2
>  
> @@ -33,10 +35,18 @@ test_global_aggr()
>  		fi
>  
>  		# use printf for rounding and a leading zero
> -		res=`printf "%.2f" "$(echo "scale=6; $num / $cyc" | bc -q)"`
> +		res=`echo $num $cyc | awk '{printf "%.2f", $1 / $2}'`
>  		if [ "$ipc" != "$res" ]; then
> -			echo "IPC is different: $res != $ipc  ($num / $cyc)"
> -			exit 1
> +			# check the difference from the real result for FP imperfections
> +			diff=`echo $ipc $res $TRESHOLD | \
> +			awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`
> +
> +			if [ $diff -eq 1 ]; then
> +				echo "IPC is different: $res != $ipc  ($num / $cyc)"
> +				exit 1
> +			fi
> +
> +			echo "Warning: Difference of IPC is under the treshold"
>  		fi
>  	done
>  }
> @@ -67,10 +77,18 @@ test_no_aggr()
>  		fi
>  
>  		# use printf for rounding and a leading zero
> -		res=`printf "%.2f" "$(echo "scale=6; $num / $cyc" | bc -q)"`
> +		res=`echo $num $cyc | awk '{printf "%.2f", $1 / $2}'`
>  		if [ "$ipc" != "$res" ]; then
> -			echo "IPC is different for $cpu: $res != $ipc  ($num / $cyc)"
> -			exit 1
> +			# check difference from the real result for FP imperfections
> +			diff=`echo $ipc $res $TRESHOLD | \
> +			awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`
> +
> +			if [ $diff -eq 1 ]; then
> +				echo "IPC is different: $res != $ipc  ($num / $cyc)"
> +				exit 1
> +			fi
> +
> +			echo "Warning: Difference of IPC is under the treshold"
>  		fi
>  	done
>  }
> -- 
> 2.41.0
> 
> 

