Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C4EC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 12:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E8CB60F02
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 12:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhHIMFP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 08:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231327AbhHIMFO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 08:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628510693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdmQw9M/85lkFGoQvkACYQul8ZHniMSyZNIJ32g8qMs=;
        b=UoE3vZXX3UDLT+2egtUeNL2DuqlLNMpxBwSO2+qbfGO7ujvj3oPmKTRHUHUTHlemsaa7pS
        ikUMRIC1L/zQYpIpUG4j+08IL509LO6Wzltr4pJuUJukcVQOVmtW6Qqe2a18UKK6cr99E0
        nBvxf7XlUd6ApEss9cvVV7+z6ROGaKI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-QBXj6DBfO82uzaqNExskfw-1; Mon, 09 Aug 2021 08:04:52 -0400
X-MC-Unique: QBXj6DBfO82uzaqNExskfw-1
Received: by mail-ej1-f72.google.com with SMTP id a19-20020a1709063e93b0290551ea218ea2so999162ejj.5
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Aug 2021 05:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdmQw9M/85lkFGoQvkACYQul8ZHniMSyZNIJ32g8qMs=;
        b=CBZEyFkdqaD83kHWK1OGANwhr3FaVYcodYmtjZgEXkAh53QK5PhjXsZ3ZCaFSUmxtv
         L7cELN55RpwMTyhW9L6D65wHxvQG4lmbN0X3l7x0/vcMEdURgpf8n+JE/pwV5MJeRgaV
         cVe905m4slZsOCYJm4mjnkopa5db4P7blDXifZC2WJVfmwOaI2Z4Vo+aNF6eBiDgm+1h
         TjGrgWPT36m/qKYGSnL22zC3BCZPWAPTAT5W5hcm5oSHIdXOcH0UcvAvpqWz3esQkLc8
         LiPfd3lCKp+1tHqLocNgQ2FXvSNmXW4mcPfGr5nXOAka3z89UrOn5/gyh5abAfzmiSAL
         EjiA==
X-Gm-Message-State: AOAM531Rjk+yTR3RHc4mZIcK30IpgIObcdipjP+4FgDmdxdmh+IM+x3w
        Ig5KKdfwKqyFxu9OmCUxelgX8rCEX1oR3FPCdycKiQpjRrhz26TIu4tU5TB+pRJ+ll0MoTTHbDG
        HWOykwQfdqI53tGO8Xzo/gXOzmW9eKw==
X-Received: by 2002:a17:906:5e55:: with SMTP id b21mr22155455eju.121.1628510691362;
        Mon, 09 Aug 2021 05:04:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3dd3KCaJ6nmDqCrkPBd09x5JE2BzcnTg6Lipo+AhkVGLQgZobgruPTNLzSDLbtovkcN6PHw==
X-Received: by 2002:a17:906:5e55:: with SMTP id b21mr22155400eju.121.1628510690969;
        Mon, 09 Aug 2021 05:04:50 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id m12sm5895933ejd.21.2021.08.09.05.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:04:50 -0700 (PDT)
Date:   Mon, 9 Aug 2021 14:04:48 +0200
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
Subject: Re: [RFC PATCH v2 10/10] perf synthetic-events: use workqueue
 parallel_for
Message-ID: <YREZ4G1xzncpdsVk@krava>
References: <cover.1627657061.git.rickyman7@gmail.com>
 <0e9bdbcb903b24b95841e09bbae180841b6311ca.1627657061.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9bdbcb903b24b95841e09bbae180841b6311ca.1627657061.git.rickyman7@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 30, 2021 at 05:34:17PM +0200, Riccardo Mancini wrote:
> To generate synthetic events, perf has the option to use multiple
> threads. These threads are created manually using pthread_created.
> 
> This patch replaces the manual pthread_create with a workqueue,
> using the parallel_for utility.

hi,
I really like this new interface

> 
> Experimental results show that workqueue has a slightly higher overhead,
> but this is repayed by the improved work balancing among threads.

how did you measure that balancing improvement?
is there less kernel cycles spent?

I ran the benchmark and if I'm reading the results correctly I see
performance drop for high cpu numbers (full list attached below).


old perf:                                                                 new perf:

[jolsa@dell-r440-01 perf]$ ./perf.old bench internals synthesize -t       [jolsa@dell-r440-01 perf]$ ./perf bench internals synthesize -t
...
  Number of synthesis threads: 40                                           Number of synthesis threads: 40
    Average synthesis took: 2489.400 usec (+- 49.832 usec)                    Average synthesis took: 4576.500 usec (+- 75.278 usec)
    Average num. events: 956.800 (+- 6.721)                                   Average num. events: 1020.000 (+- 0.000)
    Average time per event 2.602 usec                                         Average time per event 4.487 usec

maybe profiling will show what's going on?

thanks,
jirka


---
[jolsa@dell-r440-01 perf]$ ./perf.old bench internals synthesize -t       [jolsa@dell-r440-01 perf]$ ./perf bench internals synthesize -t
# Running 'internals/synthesize' benchmark:                               # Running 'internals/synthesize' benchmark:
Computing performance of multi threaded perf event synthesis by           Computing performance of multi threaded perf event synthesis by
synthesizing events on CPU 0:                                             synthesizing events on CPU 0:
  Number of synthesis threads: 1                                            Number of synthesis threads: 1 
    Average synthesis took: 7907.100 usec (+- 197.363 usec)                   Average synthesis took: 7972.900 usec (+- 198.158 usec)
    Average num. events: 956.000 (+- 0.000)                                   Average num. events: 936.000 (+- 0.000)
    Average time per event 8.271 usec                                         Average time per event 8.518 usec
  Number of synthesis threads: 2                                            Number of synthesis threads: 2 
    Average synthesis took: 5616.800 usec (+- 61.253 usec)                    Average synthesis took: 5844.700 usec (+- 87.219 usec)
    Average num. events: 958.800 (+- 0.327)                                   Average num. events: 940.000 (+- 0.000)
    Average time per event 5.858 usec                                         Average time per event 6.218 usec
  Number of synthesis threads: 3                                            Number of synthesis threads: 3 
    Average synthesis took: 4274.000 usec (+- 93.293 usec)                    Average synthesis took: 4019.700 usec (+- 67.354 usec)
    Average num. events: 962.000 (+- 0.000)                                   Average num. events: 942.000 (+- 0.000)
    Average time per event 4.443 usec                                         Average time per event 4.267 usec
  Number of synthesis threads: 4                                            Number of synthesis threads: 4 
    Average synthesis took: 3425.700 usec (+- 43.044 usec)                    Average synthesis took: 3382.200 usec (+- 74.652 usec)
    Average num. events: 959.600 (+- 0.933)                                   Average num. events: 944.000 (+- 0.000)
    Average time per event 3.570 usec                                         Average time per event 3.583 usec
  Number of synthesis threads: 5                                            Number of synthesis threads: 5 
    Average synthesis took: 2958.000 usec (+- 82.951 usec)                    Average synthesis took: 3086.500 usec (+- 48.213 usec)
    Average num. events: 966.000 (+- 0.000)                                   Average num. events: 946.000 (+- 0.000)
    Average time per event 3.062 usec                                         Average time per event 3.263 usec
  Number of synthesis threads: 6                                            Number of synthesis threads: 6 
    Average synthesis took: 2808.400 usec (+- 66.868 usec)                    Average synthesis took: 2752.200 usec (+- 56.411 usec)
    Average num. events: 956.800 (+- 0.327)                                   Average num. events: 948.000 (+- 0.000)
    Average time per event 2.935 usec                                         Average time per event 2.903 usec
  Number of synthesis threads: 7                                            Number of synthesis threads: 7 
    Average synthesis took: 2622.900 usec (+- 83.524 usec)                    Average synthesis took: 2548.200 usec (+- 48.042 usec)
    Average num. events: 958.400 (+- 0.267)                                   Average num. events: 950.000 (+- 0.000)
    Average time per event 2.737 usec                                         Average time per event 2.682 usec
  Number of synthesis threads: 8                                            Number of synthesis threads: 8 
    Average synthesis took: 2271.600 usec (+- 29.181 usec)                    Average synthesis took: 2486.600 usec (+- 47.862 usec)
    Average num. events: 972.000 (+- 0.000)                                   Average num. events: 952.000 (+- 0.000)
    Average time per event 2.337 usec                                         Average time per event 2.612 usec
  Number of synthesis threads: 9                                            Number of synthesis threads: 9 
    Average synthesis took: 2372.000 usec (+- 95.495 usec)                    Average synthesis took: 2347.300 usec (+- 23.959 usec)
    Average num. events: 959.200 (+- 0.952)                                   Average num. events: 954.000 (+- 0.000)
    Average time per event 2.473 usec                                         Average time per event 2.460 usec
  Number of synthesis threads: 10                                           Number of synthesis threads: 10
    Average synthesis took: 2544.600 usec (+- 107.569 usec)                   Average synthesis took: 2328.800 usec (+- 14.234 usec)
    Average num. events: 968.400 (+- 3.124)                                   Average num. events: 957.400 (+- 0.306)
    Average time per event 2.628 usec                                         Average time per event 2.432 usec
  Number of synthesis threads: 11                                           Number of synthesis threads: 11
    Average synthesis took: 2299.300 usec (+- 57.597 usec)                    Average synthesis took: 2340.300 usec (+- 34.638 usec)
    Average num. events: 956.000 (+- 0.000)                                   Average num. events: 960.000 (+- 0.000)
    Average time per event 2.405 usec                                         Average time per event 2.438 usec
  Number of synthesis threads: 12                                           Number of synthesis threads: 12
    Average synthesis took: 2545.500 usec (+- 69.557 usec)                    Average synthesis took: 2318.700 usec (+- 15.803 usec)
    Average num. events: 974.800 (+- 0.611)                                   Average num. events: 963.800 (+- 0.200)
    Average time per event 2.611 usec                                         Average time per event 2.406 usec
  Number of synthesis threads: 13                                           Number of synthesis threads: 13
    Average synthesis took: 2386.400 usec (+- 79.244 usec)                    Average synthesis took: 2408.700 usec (+- 27.071 usec)
    Average num. events: 950.500 (+- 5.726)                                   Average num. events: 966.000 (+- 0.000)
    Average time per event 2.511 usec                                         Average time per event 2.493 usec
  Number of synthesis threads: 14                                           Number of synthesis threads: 14 
    Average synthesis took: 2466.600 usec (+- 57.893 usec)                    Average synthesis took: 2547.200 usec (+- 53.445 usec)
    Average num. events: 957.600 (+- 0.718)                                   Average num. events: 968.000 (+- 0.000)
    Average time per event 2.576 usec                                         Average time per event 2.631 usec
  Number of synthesis threads: 15                                           Number of synthesis threads: 15 
    Average synthesis took: 2249.700 usec (+- 64.026 usec)                    Average synthesis took: 2647.900 usec (+- 79.014 usec)
    Average num. events: 956.000 (+- 0.000)                                   Average num. events: 970.000 (+- 0.000)
    Average time per event 2.353 usec                                         Average time per event 2.730 usec
  Number of synthesis threads: 16                                           Number of synthesis threads: 16 
    Average synthesis took: 2311.700 usec (+- 64.304 usec)                    Average synthesis took: 2676.200 usec (+- 34.824 usec)
    Average num. events: 955.000 (+- 0.907)                                   Average num. events: 972.000 (+- 0.000)
    Average time per event 2.421 usec                                         Average time per event 2.753 usec
  Number of synthesis threads: 17                                           Number of synthesis threads: 17 
    Average synthesis took: 2174.100 usec (+- 36.673 usec)                    Average synthesis took: 2580.100 usec (+- 45.414 usec)
    Average num. events: 971.600 (+- 3.124)                                   Average num. events: 974.000 (+- 0.000)
    Average time per event 2.238 usec                                         Average time per event 2.649 usec
  Number of synthesis threads: 18                                           Number of synthesis threads: 18 
    Average synthesis took: 2294.200 usec (+- 63.657 usec)                    Average synthesis took: 2810.200 usec (+- 49.113 usec)
    Average num. events: 953.200 (+- 0.611)                                   Average num. events: 976.000 (+- 0.000)
    Average time per event 2.407 usec                                         Average time per event 2.879 usec
  Number of synthesis threads: 19                                           Number of synthesis threads: 19 
    Average synthesis took: 2410.700 usec (+- 120.169 usec)                   Average synthesis took: 2862.400 usec (+- 36.982 usec)
    Average num. events: 953.400 (+- 0.306)                                   Average num. events: 978.000 (+- 0.000)
    Average time per event 2.529 usec                                         Average time per event 2.927 usec
  Number of synthesis threads: 20                                           Number of synthesis threads: 20 
    Average synthesis took: 2387.000 usec (+- 91.051 usec)                    Average synthesis took: 2908.800 usec (+- 36.404 usec)
    Average num. events: 952.800 (+- 0.800)                                   Average num. events: 978.600 (+- 0.306)
    Average time per event 2.505 usec                                         Average time per event 2.972 usec
  Number of synthesis threads: 21                                           Number of synthesis threads: 21 
    Average synthesis took: 2275.700 usec (+- 39.815 usec)                    Average synthesis took: 3141.100 usec (+- 30.896 usec)
    Average num. events: 954.600 (+- 0.306)                                   Average num. events: 980.000 (+- 0.000)
    Average time per event 2.384 usec                                         Average time per event 3.205 usec
  Number of synthesis threads: 22                                           Number of synthesis threads: 22 
    Average synthesis took: 2373.200 usec (+- 89.528 usec)                    Average synthesis took: 3342.400 usec (+- 112.115 usec)
    Average num. events: 949.100 (+- 5.843)                                   Average num. events: 982.000 (+- 0.000)
    Average time per event 2.500 usec                                         Average time per event 3.404 usec
  Number of synthesis threads: 23                                           Number of synthesis threads: 23 
    Average synthesis took: 2318.300 usec (+- 39.395 usec)                    Average synthesis took: 3269.700 usec (+- 55.215 usec)
    Average num. events: 954.600 (+- 0.427)                                   Average num. events: 984.000 (+- 0.000)
    Average time per event 2.429 usec                                         Average time per event 3.323 usec
  Number of synthesis threads: 24                                           Number of synthesis threads: 24
    Average synthesis took: 2241.900 usec (+- 52.577 usec)                    Average synthesis took: 3379.500 usec (+- 56.380 usec)
    Average num. events: 954.000 (+- 0.000)                                   Average num. events: 986.000 (+- 0.000)
    Average time per event 2.350 usec                                         Average time per event 3.427 usec
  Number of synthesis threads: 25                                           Number of synthesis threads: 25
    Average synthesis took: 2343.400 usec (+- 101.611 usec)                   Average synthesis took: 3382.500 usec (+- 51.535 usec)
    Average num. events: 956.200 (+- 1.009)                                   Average num. events: 988.000 (+- 0.000)
    Average time per event 2.451 usec                                         Average time per event 3.424 usec
  Number of synthesis threads: 26                                           Number of synthesis threads: 26
    Average synthesis took: 2260.700 usec (+- 18.863 usec)                    Average synthesis took: 3391.600 usec (+- 44.053 usec)
    Average num. events: 954.000 (+- 0.000)                                   Average num. events: 990.000 (+- 0.000)
    Average time per event 2.370 usec                                         Average time per event 3.426 usec
  Number of synthesis threads: 27                                           Number of synthesis threads: 27
    Average synthesis took: 2373.800 usec (+- 74.213 usec)                    Average synthesis took: 3659.200 usec (+- 113.176 usec)
    Average num. events: 955.000 (+- 0.803)                                   Average num. events: 992.000 (+- 0.000)
    Average time per event 2.486 usec                                         Average time per event 3.689 usec
  Number of synthesis threads: 28                                           Number of synthesis threads: 28
    Average synthesis took: 2335.500 usec (+- 49.480 usec)                    Average synthesis took: 3625.000 usec (+- 90.131 usec)
    Average num. events: 954.000 (+- 0.000)                                   Average num. events: 994.000 (+- 0.000)
    Average time per event 2.448 usec                                         Average time per event 3.647 usec
  Number of synthesis threads: 29                                           Number of synthesis threads: 29
    Average synthesis took: 2182.100 usec (+- 41.649 usec)                    Average synthesis took: 3708.400 usec (+- 103.717 usec)
    Average num. events: 954.000 (+- 0.000)                                   Average num. events: 996.000 (+- 0.000)
    Average time per event 2.287 usec                                         Average time per event 3.723 usec
  Number of synthesis threads: 30                                           Number of synthesis threads: 30
    Average synthesis took: 2246.100 usec (+- 58.252 usec)                    Average synthesis took: 3820.500 usec (+- 95.282 usec)
    Average num. events: 954.000 (+- 0.000)                                   Average num. events: 998.000 (+- 0.000)
    Average time per event 2.354 usec                                         Average time per event 3.828 usec
  Number of synthesis threads: 31                                           Number of synthesis threads: 31
    Average synthesis took: 2156.900 usec (+- 26.141 usec)                    Average synthesis took: 3881.400 usec (+- 36.277 usec)
    Average num. events: 948.300 (+- 5.700)                                   Average num. events: 1000.000 (+- 0.000)
    Average time per event 2.274 usec                                         Average time per event 3.881 usec
  Number of synthesis threads: 32                                           Number of synthesis threads: 32
    Average synthesis took: 2295.300 usec (+- 41.538 usec)                    Average synthesis took: 4191.700 usec (+- 149.780 usec)
    Average num. events: 954.000 (+- 0.000)                                   Average num. events: 1002.000 (+- 0.000)
    Average time per event 2.406 usec                                         Average time per event 4.183 usec
  Number of synthesis threads: 33                                           Number of synthesis threads: 33
    Average synthesis took: 2249.100 usec (+- 59.135 usec)                    Average synthesis took: 3988.200 usec (+- 25.015 usec)
    Average num. events: 948.500 (+- 5.726)                                   Average num. events: 1004.000 (+- 0.000)
    Average time per event 2.371 usec                                         Average time per event 3.972 usec
  Number of synthesis threads: 34                                           Number of synthesis threads: 34
    Average synthesis took: 2270.400 usec (+- 65.011 usec)                    Average synthesis took: 4064.600 usec (+- 44.158 usec)
    Average num. events: 954.200 (+- 0.200)                                   Average num. events: 1006.000 (+- 0.000)
    Average time per event 2.379 usec                                         Average time per event 4.040 usec
  Number of synthesis threads: 35                                           Number of synthesis threads: 35
    Average synthesis took: 2259.200 usec (+- 44.287 usec)                    Average synthesis took: 4145.700 usec (+- 37.297 usec)
    Average num. events: 954.000 (+- 0.000)                                   Average num. events: 1008.000 (+- 0.000)
    Average time per event 2.368 usec                                         Average time per event 4.113 usec
  Number of synthesis threads: 36                                           Number of synthesis threads: 36
    Average synthesis took: 2294.100 usec (+- 38.693 usec)                    Average synthesis took: 4234.900 usec (+- 81.904 usec)
    Average num. events: 954.000 (+- 0.000)                                   Average num. events: 1010.400 (+- 0.267)
    Average time per event 2.405 usec                                         Average time per event 4.191 usec
  Number of synthesis threads: 37                                           Number of synthesis threads: 37
    Average synthesis took: 2338.900 usec (+- 80.346 usec)                    Average synthesis took: 4337.900 usec (+- 30.071 usec)
    Average num. events: 954.400 (+- 0.267)                                   Average num. events: 1014.000 (+- 0.000)
    Average time per event 2.451 usec                                         Average time per event 4.278 usec
  Number of synthesis threads: 38                                           Number of synthesis threads: 38
    Average synthesis took: 2406.300 usec (+- 57.140 usec)                    Average synthesis took: 4426.600 usec (+- 27.035 usec)
    Average num. events: 938.400 (+- 7.730)                                   Average num. events: 1016.000 (+- 0.000)
    Average time per event 2.564 usec                                         Average time per event 4.357 usec
  Number of synthesis threads: 39                                           Number of synthesis threads: 39
    Average synthesis took: 2371.000 usec (+- 35.676 usec)                    Average synthesis took: 5979.000 usec (+- 1518.855 usec)
    Average num. events: 963.000 (+- 0.000)                                   Average num. events: 1018.000 (+- 0.000)
    Average time per event 2.462 usec                                         Average time per event 5.873 usec
  Number of synthesis threads: 40                                           Number of synthesis threads: 40
    Average synthesis took: 2489.400 usec (+- 49.832 usec)                    Average synthesis took: 4576.500 usec (+- 75.278 usec)
    Average num. events: 956.800 (+- 6.721)                                   Average num. events: 1020.000 (+- 0.000)
    Average time per event 2.602 usec                                         Average time per event 4.487 usec

