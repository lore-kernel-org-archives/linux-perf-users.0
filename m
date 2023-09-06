Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF38EE14B1
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Sep 2023 16:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbjIFQvv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Sep 2023 12:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjIFQvv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Sep 2023 12:51:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A454C1997
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Sep 2023 09:51:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ABFC433C7;
        Wed,  6 Sep 2023 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694019107;
        bh=Afp+5e3h3qkcnDmeFS6QQtQJmifDGZKvVS8J1uw5LyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAiSxp2cIJfthgsEAemWi9TfMOERtwrq/f0ajU5Md1QCDl+fq1bNGIdPeGFKGrQGg
         j5mB5NIrqsQq2rBgz+rXtvVRMWze7vYwAzxofnuRi29q8Lenr4ayGc3b4OMOtJRKic
         68cnd/Xk+3DwdGv5/08hQ/d0gXz2lcpsHU1snmeA867Z9sJM5PYlww16isk5ZzWxoK
         IMZsSWxIHeiVQUbb9KbaH31+NplxBnaxi+k+MqDImg3QmEwztGyxAbvkbq0P27EL14
         SQ8D558XK7E7B7ooJ8DGYZaP8I6+MyzTiLPOQHJpotA8F1oXnTj2s7W0f53qYiFg3e
         KgZ8EkA/q5r9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66A1F403F4; Wed,  6 Sep 2023 13:51:44 -0300 (-03)
Date:   Wed, 6 Sep 2023 13:51:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     vmolnaro@redhat.com
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        mpetlan@redhat.com
Subject: Re: [PATCH 2/2] perf test stat+shadow_stat.sh: Add threshold for
 rounding errors
Message-ID: <ZPiuIMDR3bhml9pu@kernel.org>
References: <20230821090053.8807-1-vmolnaro@redhat.com>
 <20230821090053.8807-2-vmolnaro@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821090053.8807-2-vmolnaro@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 21, 2023 at 11:00:53AM +0200, vmolnaro@redhat.com escreveu:
> From: notValord <v.m.veverka@gmail.com>

Hi, is the above the same person as vmolnaro@redhat.com? Can we please
have the full name and use that as the From and also the Signed-off-by?

Thanks,

- Arnaldo
 
> The test was failing in specific scenarios due to imperfection of FP
> arithmetics. The `bc` command wasn't correctly rounding the result
> of division causing the failure.
> 
> Replace the `bc` with `awk` which should work with more decimal
> places and add a threshold to catch any possible rounding errors.
> The acceptable rounding error is set to 0.01 when the test
> passes with a warning message.
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

-- 

- Arnaldo
