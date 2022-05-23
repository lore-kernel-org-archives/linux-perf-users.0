Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FACC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 May 2022 17:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbiEWRdx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 May 2022 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbiEWRcl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 May 2022 13:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE92D71A2F
        for <linux-perf-users@vger.kernel.org>; Mon, 23 May 2022 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653326677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weOcs0SP0Itwl3y4nqcPRNxrz6fRVorG523c4Uo/pJY=;
        b=aQ7BjRNhNGMm9fhA/EZUz7pzdSAu9aNjsBbwzpRpu+a9BDDtMegfmnvKGm885XvVcBJdc0
        1LXpw9YYYgHj0Vei8H25FVCZR/4IheFhJmjFh7+OCD0TnzV9e9/DLKWF1VsyagxNDpEOhL
        h39SJg0j4y7cD/FDvXUUOv1v5VhhwQ8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-eoRo_MUpNHSB-7Da8DL4dw-1; Mon, 23 May 2022 13:24:36 -0400
X-MC-Unique: eoRo_MUpNHSB-7Da8DL4dw-1
Received: by mail-qv1-f72.google.com with SMTP id j2-20020a0cfd42000000b0045ad9cba5deso11456147qvs.5
        for <linux-perf-users@vger.kernel.org>; Mon, 23 May 2022 10:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=weOcs0SP0Itwl3y4nqcPRNxrz6fRVorG523c4Uo/pJY=;
        b=FXvznuLLcGSpHR7hw9K+E5+Pc5DMriu6loCNZI9/fMvdcUtuRpCywnxokROddASV41
         ru7TYM8vXywV1f65Cut0bCUvVaOb910dxWBu9ZMApc1o0UWzxsYUFZX/nZZ7XeUpF1a5
         nMTe2tmrNuoZ5gBcSr6xSf6HASGodamJ9mnbvZFObg01bPjJdrcG3Q0J+H5stJhE3kPc
         UL81/BjsOToZ+EiEw+FKj6q4KCwX58eyTRUL4Tk5B8IVNaBdil1iGc8uxCvHtirrkFaJ
         jFWwEBMAWk0qfg/LfQwduzx5MLH/xZJKW6IhVEHKX+5ync2o4ntAcz/8jQdKKwXGNFer
         sLdQ==
X-Gm-Message-State: AOAM530LiQ5Uhttg/DljSRmnw8dHdFa532waR7SRnpAghKafXpQs02Wx
        Xe50vpdRKjZitMBBVhABa1c7NDml8BJUobgzi2i5pUV7K/gLneHFXSgmR/S85yuUu2nt1AfUcdm
        DSgQJ/ZtQ+bFUUo0t7GE7jcRsat7crg==
X-Received: by 2002:a05:620a:24d0:b0:6a0:7ba7:c6d1 with SMTP id m16-20020a05620a24d000b006a07ba7c6d1mr14114470qkn.514.1653326674369;
        Mon, 23 May 2022 10:24:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXQtTevyabfQaMvNHvSek+aErt4VD34gBz5l7J6nAWY+immtijEMoEu5ekfNWO9oHaiuPBzw==
X-Received: by 2002:a05:620a:24d0:b0:6a0:7ba7:c6d1 with SMTP id m16-20020a05620a24d000b006a07ba7c6d1mr14114448qkn.514.1653326674117;
        Mon, 23 May 2022 10:24:34 -0700 (PDT)
Received: from [192.168.1.86] (pool-173-48-131-43.bstnma.fios.verizon.net. [173.48.131.43])
        by smtp.gmail.com with ESMTPSA id q186-20020a37a7c3000000b0069fd21d0b09sm4945054qke.0.2022.05.23.10.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 10:24:33 -0700 (PDT)
Message-ID: <7bf021df-2755-6937-629f-b3ed9281804d@redhat.com>
Date:   Mon, 23 May 2022 13:24:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 0/4] perf: arm-spe: Decode SPE source and use for perf
 c2c
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com,
        Jiri Olsa <jolsa@kernel.org>, kjain@linux.ibm.com,
        lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <20220517020326.18580-1-alisaidi@amazon.com>
 <YoQRg1r7HuwiO3bZ@kernel.org> <20220518041630.GD402837@leoy-ThinkPad-X240s>
 <32e5a3b7-9294-bbd5-0ae4-b5c04eb4e0e6@redhat.com>
 <20220522061533.GA715382@leoy-ThinkPad-X240s>
From:   Joe Mario <jmario@redhat.com>
In-Reply-To: <20220522061533.GA715382@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 5/22/22 2:15 AM, Leo Yan wrote:
> Hi Joe,
> 
> On Thu, May 19, 2022 at 11:16:53AM -0400, Joe Mario wrote:
> 
> [SNIP]
> 
>> Last Comment:
>> There's a row in the Pareto table that has incorrect column alignment.
>> Look at row 80 below in the truncated snipit of output.  It has an extra field inserted in it at the beginning.
>> I also show what the corrected output should look like.
>>
>> Incorrect row 80:
>>     71	=================================================
>>     72	      Shared Cache Line Distribution Pareto      
>>     73	=================================================
>>     74	#
>>     75	# ----- HITM -----    Snoop  ------- Store Refs ------  ------- CL --------                      
>>     76	# RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss      N/A    Off  Node  PA cnt        Code address
>>     77	# .......  .......  .......  .......  .......  .......  .....  ....  ......  ..................
>>     78	#
>>     79	  -------------------------------------------------------------------------------
>>     80	      0        0        0     4648        0        0    11572            0x422140
>>     81	  -------------------------------------------------------------------------------
>>     82	    0.00%    0.00%    0.00%    0.00%    0.00%   44.47%    0x0   N/A       0            0x400ce8
>>     83	    0.00%    0.00%   10.26%    0.00%    0.00%    0.00%    0x0   N/A       0            0x400e48
>>     84	    0.00%    0.00%    0.00%    0.00%    0.00%   55.53%    0x0   N/A       0            0x400e54
>>     85	    0.00%    0.00%   89.74%    0.00%    0.00%    0.00%    0x8   N/A       0            0x401038
>>
>>
>> Corrected row 80:
>>     71	=================================================
>>     72	      Shared Cache Line Distribution Pareto      
>>     73	=================================================
>>     74	#
>>     75	# ----- HITM -----    Snoop  ------- Store Refs -----   ------- CL --------                       
>>     76	# RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss     N/A     Off  Node  PA cnt        Code address
>>     77	# .......  .......  .......  .......  .......  ......   .....  ....  ......  ..................
>>     78	#
>>     79	  -------------------------------------------------------------------------------
>>     80	       0        0     4648        0        0    11572            0x422140
>>     81	  -------------------------------------------------------------------------------
>>     82	    0.00%    0.00%    0.00%    0.00%    0.00%   44.47%    0x0   N/A       0            0x400ce8
>>     83	    0.00%    0.00%   10.26%    0.00%    0.00%    0.00%    0x0   N/A       0            0x400e48
>>     84	    0.00%    0.00%    0.00%    0.00%    0.00%   55.53%    0x0   N/A       0            0x400e54
>>     85	    0.00%    0.00%   89.74%    0.00%    0.00%    0.00%    0x8   N/A       0            0x401038
> 
> Hmm‥.  At my side, I used below command to output pareto view, but I
> cannot see the conlumn "CL", the conlumn "CL" is only shown for TUI
> mode but not for the mode "--stdio".  Could you share the method for
> how to reproduce this issue?

Hi Leo:
I figured out why my output was different than yours.

I did not have the slang-devel rpm installed on the host system.  

In my original perf build, I missed the this output in the build log:
 > slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev

Once I installed slang-devel, rebuilt perf, and then reran my test, the pareto output looked fine.

When the TUI support is disabled, it shouldn't corrupt the resulting stdio output.  I don't believe this has anything to do with your commits.  

Last, it looks like you should update the help text for the display flag options to reflect your new peer option.
Currently it says:
   -d, --display <Switch HITM output type>
                          lcl,rmt

But since you added the "peer" display, shouldn't the output for that help text state:
   -d, --display <Switch HITM output type>
                          lcl,rmt,peer

Joe

