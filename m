Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE27C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 09:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4465A60E73
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 09:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhKLKAK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 05:00:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234656AbhKLKAJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 05:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636711039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=47Mj/s2OGoXBUg1L/G3d/9O3IYAWfxTSQUL/X5G91Dg=;
        b=Af7bl8WOo9vmv8q3FCu1UVZbTDCVW1Zcc3tviEuDeE8VWF/01FyKy3992+eMLlX+VqW7xN
        LL4fPrfoXJ8FvEq6ZdNvFvgPgr+nnK0GMU4D4E4KwmZkvb++beeTqc5kdJKa40SdxugxwH
        AW4CWIWBmollZw/LxOCZ+FAwWt7HO/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-eTeKCeQYObSloQQK57SAoQ-1; Fri, 12 Nov 2021 04:57:17 -0500
X-MC-Unique: eTeKCeQYObSloQQK57SAoQ-1
Received: by mail-wm1-f71.google.com with SMTP id c1-20020a05600c0ac100b00322fcaa2bc7so4039152wmr.4
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 01:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=47Mj/s2OGoXBUg1L/G3d/9O3IYAWfxTSQUL/X5G91Dg=;
        b=b3AnH1VHVLhpd7z2FgZ2TWQQNCEz8m1e3tUn6bAMBbS6YDIfMJFHjaDr6itL+YXpJm
         sInpRwkcH2MFxd86U4KCgXEnjT0D3hvDpIJwTHaN2BlpbZSNdb/ZKU7FYCxGgJYEG14f
         i4CWgH8nBkhpwCToWC8KgJRSok0OFva+iPEq0JCknFaCzJJSogumkC/GGTOfwl6GBtEB
         TOMSe9kE+SABl9Wybv30skqx5D8zpTkiXjqSaxxwimVFB1kTJMLWx9zURMBzeQ69srwh
         4B5U23TC95ibRZdaJECnLQk7gQs7gwAJ3/srYf2Nb+kkVtHhv0BWw/FxAVKJ2fW5CJGg
         cLLQ==
X-Gm-Message-State: AOAM530J9BfX3D0K2jdEKpJMq0rATqBBNibCmABUPIq2bxpPAyF1JeJ0
        v+ODSSXiwUbghped5K0Uq+i7BIVPvhfw5h63c0535yUDz7Y3XXr3IlYGUAePyk3/1Kw2EbA9z1x
        0qdrBCjoCMth03320UqC8H+LT+LWiwQ==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr16869060wrs.304.1636711036371;
        Fri, 12 Nov 2021 01:57:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeVn0x2TSEWzhmnEn7BfzFtckHC2A1/CQn/iVlQgpPjnffgUjn8z9jRiE/L/lQ2awftUCCgg==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr16869037wrs.304.1636711036098;
        Fri, 12 Nov 2021 01:57:16 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id m20sm12017786wmq.11.2021.11.12.01.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 01:57:15 -0800 (PST)
Date:   Fri, 12 Nov 2021 10:57:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: Counting page fault per PID
Message-ID: <YY4544YTnnajizhk@krava>
References: <13ec9620-dbd6-a8a9-b51d-46aaec764351@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ec9620-dbd6-a8a9-b51d-46aaec764351@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 12, 2021 at 10:30:33AM +0100, Thomas Richter wrote:
> Hi,
> 
> I have a question regarding perf tool usage. I would like to know
> which process caused how many page faults?
> 
> I ran these commands:
> 
>  # perf stat -e faults -a -- sleep 4 &
>  # find / -ls > /dev/null 2>&1 &
>  # dd if=/dev/zero of=/dev/null bs=1M count=10K &
> Performance counter stats for 'system wide':
> 
>                606      faults
> 
>        3.994941053 seconds time elapsed
> 
> This tells me 606 page faults in total, but how to find out how many
> page faults did hit my two processes dd and find?
> 
> When I do this
>  # perf report -e faults -a -- sleep 4 &
>  # find / -ls > /dev/null 2>&1 &
>  36033
>  # dd if=/dev/zero of=/dev/null bs=1M count=10K &
>  36034
>  sleep 4
> 
> Now I have a perf.data file and can check for PERF_RECORD_SAMPLE from
> pid 36033 and 36034? Is the number of sample entries for pid 36034 identical
> with the page faults?
> 
> PERF_RECORD_FORK(36034:36034):(36031:36031)
> PERF_RECORD_COMM: dd:36034/36034
> ...
> PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffbaa12d00 period: 1 addr: 0
>  ... thread: dd:36034
> PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffba978cc4 period: 1 addr: 0
>  ... thread: dd:36034
> PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffba978d02 period: 1 addr: 0
>  ... thread: dd:36034
> PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffba9768d2 period: 2 addr: 0
>  ... thread: dd:36034
> PERF_RECORD_SAMPLE(IP, 0x2): 36034/36034: 0x3ffba961550 period: 9 addr: 0
>  ... thread: dd:36034
> PERF_RECORD_EXIT(36034:36034):(36031:36031)
> 
> Since I detect 5 sample entries from dd command, I can attribute 5 page
> faults to the running dd command?

yes, I think so.. with your test above, you can do following report:

	[root@krava perf]# ./perf report -f -s overhead,period,pid -n --stdio
	# To display the perf.data header info, please use --header/--header-only options.
	#
	#
	# Total Lost Samples: 0
	#
	# Samples: 347  of event 'faults'
	# Event count (approx.): 21379
	#
	# Overhead       Samples        Period      Pid:Command        
	# ........  ............  ............  .......................
	#
	    65.55%           236         14015   711526:find           
	    14.29%            31          3055    12445:Web Content    
	     4.91%             5          1049   702453:MediaSu~isor #3
	     2.25%             8           480   702436:MediaSu~isor #1
	     2.18%             1           465    12608:TaskCon~ller #2
	     1.90%             9           407   702441:MediaSu~isor #2
	     1.65%            10           352   683724:Backgro~l #3843
	     1.28%             9           273    12231:GeckoMain      
	     1.27%             1           272    12606:TaskCon~ller #0
	     1.21%             2           258    12463:Web Content    
	     1.05%             3           224   711531:DOM Worker     
	     0.69%            10           147   711528:sleep          
	     0.29%             1            63    12611:TaskCon~ller #5
	     0.25%             1            53    12454:IPC I/O Child  
	     0.22%             1            47        1:systemd        
	     0.18%             5            38   711525:perf           
	     0.16%             1            35    12609:TaskCon~ller #3
	     0.15%             2            31    12627:TaskCon~ller #2
	     0.12%             1            25    11684:Xorg           
	     0.11%             1            23    12363:IPDL Background
	     0.10%             2            21   706434:MediaSu~isor #4
	     0.09%             1            19    13129:TaskCon~ller #7
	     0.07%             1            14    12466:ImageIO        
	     0.06%             5            13   711527:dd             


now I'm not sure how we map period for fault event, I thought it's 1:1 to
number of samples, but apparently not ;-)

jirka

