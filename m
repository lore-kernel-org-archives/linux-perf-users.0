Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D38EE4993
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 09:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjHWJOq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbjHWJMM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 05:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C746B5
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692781386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=39Tt9iGtfqsY9gUiKlGEICmFkjBqLppcGpXNAvtNxk4=;
        b=EciDSM9GnEBt9BpfswwqxsaBpUkUTsJ14S8y+N2bZuW82CJQsr78Yy59KK13lhDBoEn6Vb
        Q4NM8MSXC3S7vqNyhn8Wj/UaL1SEMsdEf421wh4oZiwKw4ZoRay9nbEbH1g1KJIYewYPLG
        J7+1xfkBHXCUoKeuiDlBzVK2/46R6GU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-XSqFm7kjP-miNdN4hebu9Q-1; Wed, 23 Aug 2023 05:03:01 -0400
X-MC-Unique: XSqFm7kjP-miNdN4hebu9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70395101A5BA;
        Wed, 23 Aug 2023 09:03:01 +0000 (UTC)
Received: from Diego (unknown [10.39.208.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 501772026D76;
        Wed, 23 Aug 2023 09:03:00 +0000 (UTC)
Date:   Wed, 23 Aug 2023 11:02:58 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     vmolnaro@redhat.com
cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Subject: Re: [PATCH 2/2] perf test stat+shadow_stat.sh: Add threshold for
 rounding errors
In-Reply-To: <20230821090053.8807-2-vmolnaro@redhat.com>
Message-ID: <alpine.LRH.2.20.2308231102350.3810@Diego>
References: <20230821090053.8807-1-vmolnaro@redhat.com> <20230821090053.8807-2-vmolnaro@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 21 Aug 2023, vmolnaro@redhat.com wrote:
> From: notValord <v.m.veverka@gmail.com>
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

