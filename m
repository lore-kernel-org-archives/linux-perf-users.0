Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388DAC432BE
	for <linux-perf-users@archiver.kernel.org>; Sun, 29 Aug 2021 21:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1322760F44
	for <linux-perf-users@archiver.kernel.org>; Sun, 29 Aug 2021 21:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhH2WAk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 29 Aug 2021 18:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233919AbhH2WAj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 29 Aug 2021 18:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630274386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEtwrx12PwOfxPQARnkiNSt23/oRXAM8HmLspIQ1bI4=;
        b=aWs/MPqosrA/AcR2Hv/pLVRhwWMLfb4bj9a2XehQvsFVNNbp9Kg9uXo3QwDGU8FTkUDobY
        omzsEdXrQZ90ikV6q63iZATfWhX38NS1cay8ZVc76KSgsql35J99Aackeh+QpmKNRcusqo
        Ky5PW9/h09nz/JNc4v6kSFssskSY8LU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-1dDbc3EgP6KeBSrXDmfaKw-1; Sun, 29 Aug 2021 17:59:44 -0400
X-MC-Unique: 1dDbc3EgP6KeBSrXDmfaKw-1
Received: by mail-ej1-f70.google.com with SMTP id o7-20020a170906288700b005bb05cb6e25so4867910ejd.23
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Aug 2021 14:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IEtwrx12PwOfxPQARnkiNSt23/oRXAM8HmLspIQ1bI4=;
        b=okH8BP2jOIo6szL63arVRy+23XE0TuyZbbfzXbx5XWv3iMkyqBPnOJUFBrdXgnotNl
         sCrD8EReGBGoiAO1GewHLdIemyj7lrXUWvt7TwpHR3Ha6VObM1bG0pPzawU/4t90vxpL
         Ml30QPz0O903zaIcqniSM1D402G0KfugHX/uzxnc+fvneS1A6/P4XbldHSUzw52VSS/y
         twGhhcrBd9atH+RQZZzIf29SjX6LwjV/WFw+fGEeyO58Y4SX4F/eGdG32Yf/vHI9Aav9
         p+GWk1Ar2ilO1qq+Fz3LbyhO1tYHclcQLAMJW/x8ylZhzuESEAhGPFHzR+oB0upTkund
         Oy2A==
X-Gm-Message-State: AOAM5303g2aEvKVaZsH6Kwj0rLup+iSLH6WHM2WzrajyscbcNJFH6OMI
        TWDw7iz7Ju6UBFEElxhuunwU0trfF6JnSrP65aoLikwesLjzQqQrdUSmH8/R1q+w25OGj5qkcAw
        vI/Um/e+GxSVphWIyMeW7h+wz6OTzNw==
X-Received: by 2002:a50:fb08:: with SMTP id d8mr14691954edq.160.1630274383366;
        Sun, 29 Aug 2021 14:59:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz51CmRdPAQCDsOkJVe+diy+1aHH8SpDUbvSP88z+Z7pwclgzRMBxS0jWAgHkeXgrpiyZ+t1Q==
X-Received: by 2002:a50:fb08:: with SMTP id d8mr14691939edq.160.1630274383084;
        Sun, 29 Aug 2021 14:59:43 -0700 (PDT)
Received: from krava ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id g13sm3530488edr.76.2021.08.29.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 14:59:42 -0700 (PDT)
Date:   Sun, 29 Aug 2021 23:59:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Subject: Re: [RFC PATCH v3 00/15] perf: add workqueue library and use it in
 synthetic-events
Message-ID: <YSwDTWsihFxn6f1E@krava>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 20, 2021 at 12:53:46PM +0200, Riccardo Mancini wrote:
> Changes in v3:
>  - improved separation of threadpool and threadpool_entry method
>  - replaced shared workqueue with per-thread workqueue. This should
>    improve the performance on big machines (Jiri noticed in his
>    experiments a significant performance degradation after 15 threads
>    with the shared queue).
>  - improved error reporting in both threadpool and workqueue
>  - added lazy spinup of threads in workqueue [9/15]
>  - added global workqueue [10/15]
>  - setup global workqueue in perf record, top and synthesize bench
>    [12-14/15] and used in in synthetic events


hi,
I ran the test again and there's still the slowdown,
adding the stats below

I'm doing the review and I noticed few strange things,
but so far nothing that would explain that

like I can see for 40 threads only 35 threads spawned,
need to check on that more

also I'll try run some tests for parallel_for > 1 to cut
down some of the workqueue code.. any tests on that?

jirka


---
new:                                                                                    old:
ell-r440-01 perf]# ./perf bench internals synthesize -t                                      [root@dell-r440-01 perf]# ./perf bench internals synthesize -t
# Running 'internals/synthesize' benchmark:                                                  # Running 'internals/synthesize' benchmark:
Computing performance of multi threaded perf event synthesis by                              Computing performance of multi threaded perf event synthesis by
synthesizing events on CPU 0:                                                                synthesizing events on CPU 0:
  Number of synthesis threads: 1                                                               Number of synthesis threads: 1
    Average synthesis took: 13970.400 usec (+- 339.216 usec)                                     Average synthesis took: 13563.700 usec (+- 348.354 usec)
    Average num. events: 2349.000 (+- 0.000)                                                     Average num. events: 2317.000 (+- 0.000)
    Average time per event 5.947 usec                                                            Average time per event 5.854 usec
  Number of synthesis threads: 2                                                               Number of synthesis threads: 2
    Average synthesis took: 15651.800 usec (+- 1612.798 usec)                                    Average synthesis took: 8433.600 usec (+- 83.725 usec)
    Average num. events: 2353.000 (+- 0.000)                                                     Average num. events: 2321.600 (+- 0.306)
    Average time per event 6.652 usec                                                            Average time per event 3.633 usec
  Number of synthesis threads: 3                                                               Number of synthesis threads: 3
    Average synthesis took: 12114.100 usec (+- 1208.208 usec)                                    Average synthesis took: 6716.200 usec (+- 16.889 usec)
    Average num. events: 2355.000 (+- 0.000)                                                     Average num. events: 2325.000 (+- 0.000)
    Average time per event 5.144 usec                                                            Average time per event 2.889 usec
  Number of synthesis threads: 4                                                               Number of synthesis threads: 4
    Average synthesis took: 9812.500 usec (+- 951.284 usec)                                      Average synthesis took: 5981.400 usec (+- 11.102 usec)
    Average num. events: 2357.000 (+- 0.000)                                                     Average num. events: 2323.000 (+- 0.000)
    Average time per event 4.163 usec                                                            Average time per event 2.575 usec
  Number of synthesis threads: 5                                                               Number of synthesis threads: 5
    Average synthesis took: 7338.300 usec (+- 661.620 usec)                                      Average synthesis took: 5538.800 usec (+- 12.990 usec)
    Average num. events: 2359.000 (+- 0.000)                                                     Average num. events: 2329.000 (+- 0.000)
    Average time per event 3.111 usec                                                            Average time per event 2.378 usec
  Number of synthesis threads: 6                                                               Number of synthesis threads: 6
    Average synthesis took: 7256.800 usec (+- 680.312 usec)                                      Average synthesis took: 5255.700 usec (+- 7.454 usec)
    Average num. events: 2361.000 (+- 0.000)                                                     Average num. events: 2331.000 (+- 0.000)
    Average time per event 3.074 usec                                                            Average time per event 2.255 usec
  Number of synthesis threads: 7                                                               Number of synthesis threads: 7
    Average synthesis took: 6119.600 usec (+- 479.409 usec)                                      Average synthesis took: 4836.200 usec (+- 8.132 usec)
    Average num. events: 2363.000 (+- 0.000)                                                     Average num. events: 2323.000 (+- 0.000)
    Average time per event 2.590 usec                                                            Average time per event 2.082 usec
  Number of synthesis threads: 8                                                               Number of synthesis threads: 8
    Average synthesis took: 5899.600 usec (+- 506.285 usec)                                      Average synthesis took: 4643.000 usec (+- 4.913 usec)
    Average num. events: 2365.000 (+- 0.000)                                                     Average num. events: 2335.000 (+- 0.000)
    Average time per event 2.495 usec                                                            Average time per event 1.988 usec
  Number of synthesis threads: 9                                                               Number of synthesis threads: 9
    Average synthesis took: 5459.100 usec (+- 431.725 usec)                                      Average synthesis took: 4526.600 usec (+- 5.207 usec)
    Average num. events: 2367.000 (+- 0.000)                                                     Average num. events: 2337.000 (+- 0.000)
    Average time per event 2.306 usec                                                            Average time per event 1.937 usec
  Number of synthesis threads: 10                                                              Number of synthesis threads: 10
    Average synthesis took: 4977.100 usec (+- 251.378 usec)                                      Average synthesis took: 4128.700 usec (+- 5.911 usec)
    Average num. events: 2369.000 (+- 0.000)                                                     Average num. events: 2327.800 (+- 0.533)
    Average time per event 2.101 usec                                                            Average time per event 1.774 usec
  Number of synthesis threads: 11                                                              Number of synthesis threads: 11
    Average synthesis took: 5428.700 usec (+- 513.409 usec)                                      Average synthesis took: 3890.800 usec (+- 15.051 usec)
    Average num. events: 2371.000 (+- 0.000)                                                     Average num. events: 2323.000 (+- 0.000)
    Average time per event 2.290 usec                                                            Average time per event 1.675 usec
  Number of synthesis threads: 12                                                              Number of synthesis threads: 12
    Average synthesis took: 5517.800 usec (+- 508.171 usec)                                      Average synthesis took: 3367.800 usec (+- 14.261 usec)
    Average num. events: 2373.000 (+- 0.000)                                                     Average num. events: 2343.000 (+- 0.000)
    Average time per event 2.325 usec                                                            Average time per event 1.437 usec
  Number of synthesis threads: 13                                                              Number of synthesis threads: 13
    Average synthesis took: 5279.500 usec (+- 432.819 usec)                                      Average synthesis took: 3974.300 usec (+- 12.437 usec)
    Average num. events: 2375.000 (+- 0.000)                                                     Average num. events: 2328.200 (+- 1.405)
    Average time per event 2.223 usec                                                            Average time per event 1.707 usec
  Number of synthesis threads: 14                                                              Number of synthesis threads: 14
    Average synthesis took: 4993.100 usec (+- 392.485 usec)                                      Average synthesis took: 4157.100 usec (+- 163.268 usec)
    Average num. events: 2377.000 (+- 0.000)                                                     Average num. events: 2319.800 (+- 0.533)
    Average time per event 2.101 usec                                                            Average time per event 1.792 usec
  Number of synthesis threads: 15                                                              Number of synthesis threads: 15
    Average synthesis took: 5584.700 usec (+- 379.862 usec)                                      Average synthesis took: 4065.700 usec (+- 25.656 usec)
    Average num. events: 2379.000 (+- 0.000)                                                     Average num. events: 2322.800 (+- 0.467)
    Average time per event 2.347 usec                                                            Average time per event 1.750 usec
  Number of synthesis threads: 16                                                              Number of synthesis threads: 16
    Average synthesis took: 5009.800 usec (+- 381.018 usec)                                      Average synthesis took: 4580.600 usec (+- 129.218 usec)
    Average num. events: 2381.000 (+- 0.000)                                                     Average num. events: 2324.800 (+- 0.200)
    Average time per event 2.104 usec                                                            Average time per event 1.970 usec
  Number of synthesis threads: 17                                                              Number of synthesis threads: 17
    Average synthesis took: 5543.300 usec (+- 376.064 usec)                                      Average synthesis took: 4089.700 usec (+- 54.096 usec)
    Average num. events: 2383.000 (+- 0.000)                                                     Average num. events: 2320.200 (+- 0.611)
    Average time per event 2.326 usec                                                            Average time per event 1.763 usec
  Number of synthesis threads: 18                                                              Number of synthesis threads: 18
    Average synthesis took: 5191.800 usec (+- 342.317 usec)                                      Average synthesis took: 4219.000 usec (+- 61.395 usec)
    Average num. events: 2385.000 (+- 0.000)                                                     Average num. events: 2323.000 (+- 0.516)
    Average time per event 2.177 usec                                                            Average time per event 1.816 usec
  Number of synthesis threads: 19                                                              Number of synthesis threads: 19
    Average synthesis took: 4647.000 usec (+- 273.303 usec)                                      Average synthesis took: 3998.800 usec (+- 49.221 usec)
    Average num. events: 2387.000 (+- 0.000)                                                     Average num. events: 2325.200 (+- 0.200)
    Average time per event 1.947 usec                                                            Average time per event 1.720 usec
  Number of synthesis threads: 20                                                              Number of synthesis threads: 20
    Average synthesis took: 4710.600 usec (+- 179.874 usec)                                      Average synthesis took: 3930.300 usec (+- 67.725 usec)
    Average num. events: 2389.000 (+- 0.000)                                                     Average num. events: 2319.000 (+- 0.000)
    Average time per event 1.972 usec                                                            Average time per event 1.695 usec
  Number of synthesis threads: 21                                                              Number of synthesis threads: 21
    Average synthesis took: 4959.100 usec (+- 318.519 usec)                                      Average synthesis took: 3696.400 usec (+- 30.953 usec)
    Average num. events: 2390.800 (+- 0.200)                                                     Average num. events: 2319.800 (+- 0.533)
    Average time per event 2.074 usec                                                            Average time per event 1.593 usec
  Number of synthesis threads: 22                                                              Number of synthesis threads: 22
    Average synthesis took: 4422.300 usec (+- 236.998 usec)                                      Average synthesis took: 3394.000 usec (+- 63.254 usec)
    Average num. events: 2392.800 (+- 0.200)                                                     Average num. events: 2319.000 (+- 0.000)
    Average time per event 1.848 usec                                                            Average time per event 1.464 usec
  Number of synthesis threads: 23                                                              Number of synthesis threads: 23
    Average synthesis took: 4640.800 usec (+- 245.604 usec)                                      Average synthesis took: 4091.100 usec (+- 134.320 usec)
    Average num. events: 2394.400 (+- 0.600)                                                     Average num. events: 2323.400 (+- 0.267)
    Average time per event 1.938 usec                                                            Average time per event 1.761 usec
  Number of synthesis threads: 24                                                              Number of synthesis threads: 24
    Average synthesis took: 4554.900 usec (+- 201.121 usec)                                      Average synthesis took: 3346.600 usec (+- 78.846 usec)
    Average num. events: 2395.800 (+- 0.854)                                                     Average num. events: 2321.000 (+- 0.667)
    Average time per event 1.901 usec                                                            Average time per event 1.442 usec
  Number of synthesis threads: 25                                                              Number of synthesis threads: 25
    Average synthesis took: 4668.300 usec (+- 248.254 usec)                                      Average synthesis took: 3794.300 usec (+- 191.158 usec)
    Average num. events: 2398.000 (+- 0.803)                                                     Average num. events: 2317.900 (+- 6.248)
    Average time per event 1.947 usec                                                            Average time per event 1.637 usec
  Number of synthesis threads: 26                                                              Number of synthesis threads: 26
    Average synthesis took: 4683.300 usec (+- 226.836 usec)                                      Average synthesis took: 3285.700 usec (+- 18.785 usec)
    Average num. events: 2399.000 (+- 1.265)                                                     Average num. events: 2317.100 (+- 6.198)
    Average time per event 1.952 usec                                                            Average time per event 1.418 usec
  Number of synthesis threads: 27                                                              Number of synthesis threads: 27
    Average synthesis took: 4590.300 usec (+- 158.000 usec)                                      Average synthesis took: 3604.600 usec (+- 35.487 usec)
    Average num. events: 2400.200 (+- 1.497)                                                     Average num. events: 2319.800 (+- 0.533)
    Average time per event 1.912 usec                                                            Average time per event 1.554 usec
  Number of synthesis threads: 28                                                              Number of synthesis threads: 28
    Average synthesis took: 4683.500 usec (+- 233.543 usec)                                      Average synthesis took: 3594.700 usec (+- 21.267 usec)
    Average num. events: 2402.400 (+- 1.688)                                                     Average num. events: 2319.200 (+- 0.200)
    Average time per event 1.950 usec                                                            Average time per event 1.550 usec
  Number of synthesis threads: 29                                                              Number of synthesis threads: 29
    Average synthesis took: 4830.700 usec (+- 235.730 usec)                                      Average synthesis took: 3531.700 usec (+- 15.935 usec)
    Average num. events: 2405.000 (+- 2.530)                                                     Average num. events: 2322.200 (+- 0.800)
    Average time per event 2.009 usec                                                            Average time per event 1.521 usec
  Number of synthesis threads: 30                                                              Number of synthesis threads: 30
    Average synthesis took: 4684.500 usec (+- 210.137 usec)                                      Average synthesis took: 3505.700 usec (+- 58.332 usec)
    Average num. events: 2407.600 (+- 2.495)                                                     Average num. events: 2315.100 (+- 5.900)
    Average time per event 1.946 usec                                                            Average time per event 1.514 usec
  Number of synthesis threads: 31                                                              Number of synthesis threads: 31
    Average synthesis took: 4823.300 usec (+- 213.480 usec)                                      Average synthesis took: 3431.100 usec (+- 42.022 usec)
    Average num. events: 2407.400 (+- 2.647)                                                     Average num. events: 2319.000 (+- 0.000)
    Average time per event 2.004 usec                                                            Average time per event 1.480 usec
  Number of synthesis threads: 32                                                              Number of synthesis threads: 32
    Average synthesis took: 4400.800 usec (+- 224.134 usec)                                      Average synthesis took: 3684.900 usec (+- 253.077 usec)
    Average num. events: 2407.400 (+- 2.544)                                                     Average num. events: 2319.200 (+- 0.200)
    Average time per event 1.828 usec                                                            Average time per event 1.589 usec
  Number of synthesis threads: 33                                                              Number of synthesis threads: 33
    Average synthesis took: 4452.600 usec (+- 231.034 usec)                                      Average synthesis took: 3233.000 usec (+- 24.035 usec)
    Average num. events: 2409.300 (+- 3.190)                                                     Average num. events: 2316.500 (+- 6.069)
    Average time per event 1.848 usec                                                            Average time per event 1.396 usec
  Number of synthesis threads: 34                                                              Number of synthesis threads: 34
    Average synthesis took: 4770.900 usec (+- 182.325 usec)                                      Average synthesis took: 3016.300 usec (+- 13.343 usec)
    Average num. events: 2411.200 (+- 3.032)                                                     Average num. events: 2322.800 (+- 0.200)
    Average time per event 1.979 usec                                                            Average time per event 1.299 usec
  Number of synthesis threads: 35                                                              Number of synthesis threads: 35
    Average synthesis took: 4442.800 usec (+- 248.017 usec)                                      Average synthesis took: 3246.700 usec (+- 71.765 usec)
    Average num. events: 2412.000 (+- 3.296)                                                     Average num. events: 2321.800 (+- 0.611)
    Average time per event 1.842 usec                                                            Average time per event 1.398 usec
  Number of synthesis threads: 36                                                              Number of synthesis threads: 36
    Average synthesis took: 5005.200 usec (+- 235.823 usec)                                      Average synthesis took: 3329.000 usec (+- 122.028 usec)
    Average num. events: 2410.400 (+- 2.750)                                                     Average num. events: 2310.800 (+- 8.133)
    Average time per event 2.077 usec                                                            Average time per event 1.441 usec
  Number of synthesis threads: 37                                                              Number of synthesis threads: 37
    Average synthesis took: 4654.000 usec (+- 208.838 usec)                                      Average synthesis took: 3011.600 usec (+- 46.026 usec)
    Average num. events: 2409.400 (+- 2.473)                                                     Average num. events: 2322.200 (+- 0.533)
    Average time per event 1.932 usec                                                            Average time per event 1.297 usec
  Number of synthesis threads: 38                                                              Number of synthesis threads: 38
    Average synthesis took: 4763.700 usec (+- 197.409 usec)                                      Average synthesis took: 3163.500 usec (+- 36.589 usec)
    Average num. events: 2406.200 (+- 2.462)                                                     Average num. events: 2319.000 (+- 0.000)
    Average time per event 1.980 usec                                                            Average time per event 1.364 usec
  Number of synthesis threads: 39                                                              Number of synthesis threads: 39
    Average synthesis took: 4333.100 usec (+- 194.456 usec)                                      Average synthesis took: 3170.900 usec (+- 30.538 usec)
    Average num. events: 2408.600 (+- 3.124)                                                     Average num. events: 2319.000 (+- 0.000)
    Average time per event 1.799 usec                                                            Average time per event 1.367 usec
  Number of synthesis threads: 40                                                              Number of synthesis threads: 40
    Average synthesis took: 4520.200 usec (+- 188.901 usec)                                      Average synthesis took: 3111.900 usec (+- 24.287 usec)
    Average num. events: 2409.600 (+- 3.184)                                                     Average num. events: 2307.600 (+- 7.600)
    Average time per event 1.876 usec                                                            Average time per event 1.349 usec

