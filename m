Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DCC636D6
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Feb 2023 13:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjBWNc2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Feb 2023 08:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBWNc1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Feb 2023 08:32:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901DF4D613;
        Thu, 23 Feb 2023 05:32:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84995616E2;
        Thu, 23 Feb 2023 13:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AF1C433EF;
        Thu, 23 Feb 2023 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677159142;
        bh=3oLf3kVcXnmYyNl6ow6zYoGULEpaipXNptn4aFoyxkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLC9W9DGbnuQvuUuHhnvvocTnCDXK1XzNnq+ctqyBkK2WuqqOfG8EI2vct/sY/qbK
         D+3Uaqb935HCbQQoyvAzHt4zuody6PzvCoQ1YpPGcTAEryh7Sd8l5t/dy4gyp3ox3P
         NNhOJpCLKldX23QznPfOmaPWmLNH8uIJCIO/ZOPt0KjI6XqylpHCM68jwf//2e44ex
         e1gpvH6GRt4il93hwzscmqH1RGIfLGCUXhtElmP4GAybhDJB99yJd42bX9/2NcVXBh
         EkpVe8rlfdP4QSqfzt//JNv3aB2rAXZ40ReZg5jU3Wiq8ReuuVjciBZvIR/OmndVQU
         qkrmAC/versXQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D910F4049F; Thu, 23 Feb 2023 10:32:19 -0300 (-03)
Date:   Thu, 23 Feb 2023 10:32:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Claire Jensen <cjense@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf tests stat+csv_output: Switch CSV separator
 to @
Message-ID: <Y/dq4yO+zXYLCQ8d@kernel.org>
References: <20230223071818.329671-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223071818.329671-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Feb 22, 2023 at 11:18:17PM -0800, Ian Rogers escreveu:
> Commas may appear in events like:
> cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
> which causes the commachecker to see more fields than expected. Use @
> as the CSV separator to avoid this.

Thanks, applied both patches.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat+csv_output.sh | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
> index b7f050aa6210..324fc9e6edd7 100755
> --- a/tools/perf/tests/shell/stat+csv_output.sh
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -7,6 +7,7 @@
>  set -e
>  
>  skip_test=0
> +csv_sep=@
>  
>  function commachecker()
>  {
> @@ -34,7 +35,7 @@ function commachecker()
>  		[ "$x" = "Failed" ] && continue
>  
>  		# Count the number of commas
> -		x=$(echo $line | tr -d -c ',')
> +		x=$(echo $line | tr -d -c $csv_sep)
>  		cnt="${#x}"
>  		# echo $line $cnt
>  		[[ ! "$cnt" =~ $exp ]] && {
> @@ -54,7 +55,7 @@ function ParanoidAndNotRoot()
>  check_no_args()
>  {
>  	echo -n "Checking CSV output: no args "
> -	perf stat -x, true 2>&1 | commachecker --no-args
> +	perf stat -x$csv_sep true 2>&1 | commachecker --no-args
>  	echo "[Success]"
>  }
>  
> @@ -66,7 +67,7 @@ check_system_wide()
>  		echo "[Skip] paranoid and not root"
>  		return
>  	fi
> -	perf stat -x, -a true 2>&1 | commachecker --system-wide
> +	perf stat -x$csv_sep -a true 2>&1 | commachecker --system-wide
>  	echo "[Success]"
>  }
>  
> @@ -79,14 +80,14 @@ check_system_wide_no_aggr()
>  		return
>  	fi
>  	echo -n "Checking CSV output: system wide no aggregation "
> -	perf stat -x, -A -a --no-merge true 2>&1 | commachecker --system-wide-no-aggr
> +	perf stat -x$csv_sep -A -a --no-merge true 2>&1 | commachecker --system-wide-no-aggr
>  	echo "[Success]"
>  }
>  
>  check_interval()
>  {
>  	echo -n "Checking CSV output: interval "
> -	perf stat -x, -I 1000 true 2>&1 | commachecker --interval
> +	perf stat -x$csv_sep -I 1000 true 2>&1 | commachecker --interval
>  	echo "[Success]"
>  }
>  
> @@ -94,7 +95,7 @@ check_interval()
>  check_event()
>  {
>  	echo -n "Checking CSV output: event "
> -	perf stat -x, -e cpu-clock true 2>&1 | commachecker --event
> +	perf stat -x$csv_sep -e cpu-clock true 2>&1 | commachecker --event
>  	echo "[Success]"
>  }
>  
> @@ -106,7 +107,7 @@ check_per_core()
>  		echo "[Skip] paranoid and not root"
>  		return
>  	fi
> -	perf stat -x, --per-core -a true 2>&1 | commachecker --per-core
> +	perf stat -x$csv_sep --per-core -a true 2>&1 | commachecker --per-core
>  	echo "[Success]"
>  }
>  
> @@ -118,7 +119,7 @@ check_per_thread()
>  		echo "[Skip] paranoid and not root"
>  		return
>  	fi
> -	perf stat -x, --per-thread -a true 2>&1 | commachecker --per-thread
> +	perf stat -x$csv_sep --per-thread -a true 2>&1 | commachecker --per-thread
>  	echo "[Success]"
>  }
>  
> @@ -130,7 +131,7 @@ check_per_die()
>  		echo "[Skip] paranoid and not root"
>  		return
>  	fi
> -	perf stat -x, --per-die -a true 2>&1 | commachecker --per-die
> +	perf stat -x$csv_sep --per-die -a true 2>&1 | commachecker --per-die
>  	echo "[Success]"
>  }
>  
> @@ -142,7 +143,7 @@ check_per_node()
>  		echo "[Skip] paranoid and not root"
>  		return
>  	fi
> -	perf stat -x, --per-node -a true 2>&1 | commachecker --per-node
> +	perf stat -x$csv_sep --per-node -a true 2>&1 | commachecker --per-node
>  	echo "[Success]"
>  }
>  
> @@ -154,7 +155,7 @@ check_per_socket()
>  		echo "[Skip] paranoid and not root"
>  		return
>  	fi
> -	perf stat -x, --per-socket -a true 2>&1 | commachecker --per-socket
> +	perf stat -x$csv_sep --per-socket -a true 2>&1 | commachecker --per-socket
>  	echo "[Success]"
>  }
>  
> -- 
> 2.39.2.637.g21b0678d19-goog
> 

-- 

- Arnaldo
