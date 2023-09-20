Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F0ECE79CB
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Sep 2023 10:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjITK6M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Sep 2023 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjITK6L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Sep 2023 06:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC80CC2
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695207440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i42mRJPzsDjqBqE9wuCN7JU0g+Q68FCkcYRKehyAQ4E=;
        b=HA9dE/T9pp0E5ewYkg6aB4SRN74JOaLQjPNjYpTadqdvrjT6iVd6JjZVWP+CEz4t7f+r/o
        gnjTrMXh4NRvcJgBOEYS19e/V7LiOl5VPkoEx0WPwytRilpfFp66Ky0a3CJgJECmCglVdZ
        1ktYg/eOAZNrKTD4D4+7QGuwDazcn5g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-XhkHoH6SPU2-vcvXQPJdSg-1; Wed, 20 Sep 2023 06:57:17 -0400
X-MC-Unique: XhkHoH6SPU2-vcvXQPJdSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AAFC101A550;
        Wed, 20 Sep 2023 10:57:17 +0000 (UTC)
Received: from Diego (unknown [10.39.208.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24F4210F1BE7;
        Wed, 20 Sep 2023 10:57:15 +0000 (UTC)
Date:   Wed, 20 Sep 2023 12:57:14 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     vmolnaro@redhat.com
cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Subject: Re: [PATCH 1/2] perf test stat+shadow_stat.sh: Add threshold for
 rounding errors
In-Reply-To: <20230919150419.23193-1-vmolnaro@redhat.com>
Message-ID: <alpine.LRH.2.20.2309201256480.3810@Diego>
References: <20230919150419.23193-1-vmolnaro@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 19 Sep 2023, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> The test was failing in specific scenarios due to imperfection of FP
> arithmetics. The `bc` command wasn't correctly rounding the result of
> division causing the failure.
> 
> Replace the `bc` with `awk` which should work with more decimal places
> and add a threshold to catch any possible rounding errors.  The
> acceptable rounding error is set to 0.01 when the test passes with a
> warning message.
> 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>

Acked-by: Michael Petlan <mpetlan@redhat.com>

> ---
> Resending the patches with sign-off as it didn't go through last time,
> also tried to fix the found issues.
> 
>  tools/perf/tests/shell/stat+shadow_stat.sh | 30 +++++++++++++++++-----
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
> index 0e9cba84e75..6be3b4f80e5 100755
> --- a/tools/perf/tests/shell/stat+shadow_stat.sh
> +++ b/tools/perf/tests/shell/stat+shadow_stat.sh
> @@ -4,6 +4,8 @@
>  
>  set -e
>  
> +THRESHOLD=0.015
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
> +			diff=`echo $ipc $res $THRESHOLD | \
> +			awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`
> +
> +			if [ $diff -eq 1 ]; then
> +				echo "IPC is different: $res != $ipc  ($num / $cyc)"
> +				exit 1
> +			fi
> +
> +			echo "Warning: Difference of IPC is under the threshold"
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
> +			diff=`echo $ipc $res $THRESHOLD | \
> +			awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`
> +
> +			if [ $diff -eq 1 ]; then
> +				echo "IPC is different: $res != $ipc  ($num / $cyc)"
> +				exit 1
> +			fi
> +
> +			echo "Warning: Difference of IPC is under the threshold"
>  		fi
>  	done
>  }
> -- 
> 2.41.0
> 
> 

