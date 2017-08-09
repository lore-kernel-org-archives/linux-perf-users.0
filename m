From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 9/9] perf: test 15 fix expected task value.
Date: Wed, 9 Aug 2017 17:01:16 +0200
Message-ID: <20170809150116.GA23060@krava>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
 <20170809064040.50899-9-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751919AbdHIPBS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 11:01:18 -0400
Content-Disposition: inline
In-Reply-To: <20170809064040.50899-9-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

On Wed, Aug 09, 2017 at 08:40:40AM +0200, Thomas Richter wrote:
> Running perf test 15 (event attr test) the expected value
> for task is 1. This can be seen with:

I just sent email to Arnaldo (you're in CC), fix for this was already posted

jirka

> 
> [root@oc2666213455 ~]# perf record -vv -b -- sleep 1
> ------------------------------------------------------------
> perf_event_attr:
>   size                             104
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|PERIOD|BRANCH_STACK
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   enable_on_exec                   1
>   task                             1
>   sample_id_all                    1
>   exclude_guest                    1
>   mmap2                            1
>   comm_exec                        1
> ------------------------------------------------------------
> [...]
> 
> Change the expected task value from 0 to 1 in the base-record
> file to match the correct results and report success for the
> test-record-* test cases.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/attr/base-record | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
> index 31e0b1d..3794066 100644
> --- a/tools/perf/tests/attr/base-record
> +++ b/tools/perf/tests/attr/base-record
> @@ -23,7 +23,7 @@ comm=1
>  freq=1
>  inherit_stat=0
>  enable_on_exec=1
> -task=0
> +task=1
>  watermark=0
>  precise_ip=0|1|2|3
>  mmap_data=0
> -- 
> 2.9.3
> 
