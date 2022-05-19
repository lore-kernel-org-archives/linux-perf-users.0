Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B47EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 15:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiESPRC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 May 2022 11:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbiESPRA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 May 2022 11:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C5DC5F8F8
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652973418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFxAkTiFYx/27rNrxiNuMe1vTCHfN4tVz87m6TJA89U=;
        b=ECZCR2WzbqgSWgTXmvLZNNqXQsvlIxYsSZd9y54f5Je7rPrStf5I9irxtT262XG5sYutWy
        sTT9VOzqo1dHM7r6BI5fA3h5Ds0uCM2YPbPM3csk2G+dysvHmW8LJ1V8p7mX8jdruhDroS
        uYJD1d4JQnPAW6iy6Nbn2/ON6SDqlFQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-5KEFFvx8MASOgAEkaTBxlQ-1; Thu, 19 May 2022 11:16:57 -0400
X-MC-Unique: 5KEFFvx8MASOgAEkaTBxlQ-1
Received: by mail-qv1-f72.google.com with SMTP id ck16-20020a05621404d000b00461bcafbbe9so4497216qvb.23
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 08:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eFxAkTiFYx/27rNrxiNuMe1vTCHfN4tVz87m6TJA89U=;
        b=k7bYmfPsfmM7kwM00M5rts0fMqz/w5tp1kTuGgKlvu7Pu2SvvFGP7443OHGURRAHNx
         mMQvdUudILhmAlbM6eXK3LcSNxPMs6YDC50Uk5g5kecVrkTleUKXZUTF237J5o1DIyt2
         a9H7tIulxd9mvjFgW0Gy214iLmbMGUEEv7XrZLgz64Lnv54AYGzmpANygthhCbYYxwSG
         i58Oc0yCi7n4qrlID3AXCAq39uLtvDkCN6M228aUCQfAP7lKBoYVbEBQtfhNZKdvwLqX
         eDWOCOFQVIRZxs9qVRTFAnK2cvPDYVMPmPh1VGl7pP33WLcbRDWgFo9z+74QIlljOdmd
         ww8g==
X-Gm-Message-State: AOAM532woZRDxgYk5vVg66XKC3z4dvAG16Xj600viPZYNPNaW4RoyxG7
        lgsfDoevAywMLnBUeKpc3T35OE+PulH3ehSnUH9Z131pRSohx7ciwqbNOcK4f+WlLt1uTval3WR
        h4MiSvsDXduTF5nrmX7NVvKb0LBexFA==
X-Received: by 2002:a05:622a:15cb:b0:2f3:f90f:1939 with SMTP id d11-20020a05622a15cb00b002f3f90f1939mr4332863qty.374.1652973416659;
        Thu, 19 May 2022 08:16:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvxlpYrFwSJ+r9PedV8x0+cauaFMXyvayTXrq2OHyietf7KJSz5bBSaj+kURa8rNtS/vfhAg==
X-Received: by 2002:a05:622a:15cb:b0:2f3:f90f:1939 with SMTP id d11-20020a05622a15cb00b002f3f90f1939mr4332845qty.374.1652973416375;
        Thu, 19 May 2022 08:16:56 -0700 (PDT)
Received: from [192.168.1.86] (pool-173-48-131-43.bstnma.fios.verizon.net. [173.48.131.43])
        by smtp.gmail.com with ESMTPSA id c190-20020ae9edc7000000b0069fc13ce1e3sm1347636qkg.20.2022.05.19.08.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 08:16:55 -0700 (PDT)
Message-ID: <32e5a3b7-9294-bbd5-0ae4-b5c04eb4e0e6@redhat.com>
Date:   Thu, 19 May 2022 11:16:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 0/4] perf: arm-spe: Decode SPE source and use for perf
 c2c
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
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
From:   Joe Mario <jmario@redhat.com>
In-Reply-To: <20220518041630.GD402837@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 5/18/22 12:16 AM, Leo Yan wrote:
> Hi Joe,
> 
> On Tue, May 17, 2022 at 06:20:03PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Tue, May 17, 2022 at 02:03:21AM +0000, Ali Saidi escreveu:
>>> When synthesizing data from SPE, augment the type with source information
>>> for Arm Neoverse cores so we can detect situtions like cache line
>>> contention and transfers on Arm platforms. 
>>>
>>> This changes enables future changes to c2c on a system with SPE where lines that
>>> are shared among multiple cores show up in perf c2c output. 
>>>
>>> Changes is v9:
>>>  * Change reporting of remote socket data which should make Leo's upcomping
>>>    patch set for c2c make sense on multi-socket platforms  
>>
>> Hey,
>>
>> 	Joe Mario, who is one of 'perf c2c' authors asked me about some
>> git tree he could clone from for both building the kernel and
>> tools/perf/ so that he could do tests, can you please provide that?
> 
> I have uploaded the latest patches for enabling 'perf c2c' on Arm SPE
> on the repo:
> 
> https://git.linaro.org/people/leo.yan/linux-spe.git branch: perf_c2c_arm_spe_peer_v3
> 
> Below are the quick notes for build the kernel with enabling Arm SPE:
> 
>   $ git clone -b perf_c2c_arm_spe_peer_v3 https://git.linaro.org/people/leo.yan/linux-spe.git
> 
>   Or
> 
>   $ git clone -b perf_c2c_arm_spe_peer_v3 ssh://git@git.linaro.org/people/leo.yan/linux-spe.git
> 
>   $ cd linux-spe
> 
>   # Build kernel
>   $ make defconfig
>   $ ./scripts/config -e CONFIG_PID_IN_CONTEXTIDR
>   $ ./scripts/config -e CONFIG_ARM_SPE_PMU
>   $ make Image
> 
>   # Build perf
>   $ cd tools/perf
>   $ make VF=1 DEBUG=1
> 
> When boot the kernel, please add option "kpti=off" in kernel command
> line, you might need to update grub menu for this.
> 
> Please feel free let us know if anything is not clear for you.
> 
> Thank you,
> Leo
> 

Hi Leo:
Thanks for getting this working on ARM.  I do have a few comments.

I built and ran this on a ARM Neoverse-N1 system with 2 numa nodes.  

Comment 1:
When I run "perf c2c report", the "Node" field is marked "N/A".  It's supposed to show the numa node where the data address for the cacheline resides.  That's important both to see what node hot data resides on and if that data is getting lots of cross-numa accesses. 

Comment 2:
I'm assuming you're identifying the contended cachelines using the "peer" load response, which indicates the load was resolved from a "peer" cpu's cacheline.  Please confirm.
If that's true, is it possible to identify if that "peer" response was on the local or remote numa node?  

I ask because being able to identify both local and remote HitM's on Intel X86_64 has been quite valuable.  That's because remote HitM's are costly and because it helps the viewer see if they need to optimize their cpu affinity or what node their hot data resides on.

Last Comment:
There's a row in the Pareto table that has incorrect column alignment.
Look at row 80 below in the truncated snipit of output.  It has an extra field inserted in it at the beginning.
I also show what the corrected output should look like.

Incorrect row 80:
    71	=================================================
    72	      Shared Cache Line Distribution Pareto      
    73	=================================================
    74	#
    75	# ----- HITM -----    Snoop  ------- Store Refs ------  ------- CL --------                      
    76	# RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss      N/A    Off  Node  PA cnt        Code address
    77	# .......  .......  .......  .......  .......  .......  .....  ....  ......  ..................
    78	#
    79	  -------------------------------------------------------------------------------
    80	      0        0        0     4648        0        0    11572            0x422140
    81	  -------------------------------------------------------------------------------
    82	    0.00%    0.00%    0.00%    0.00%    0.00%   44.47%    0x0   N/A       0            0x400ce8
    83	    0.00%    0.00%   10.26%    0.00%    0.00%    0.00%    0x0   N/A       0            0x400e48
    84	    0.00%    0.00%    0.00%    0.00%    0.00%   55.53%    0x0   N/A       0            0x400e54
    85	    0.00%    0.00%   89.74%    0.00%    0.00%    0.00%    0x8   N/A       0            0x401038


Corrected row 80:
    71	=================================================
    72	      Shared Cache Line Distribution Pareto      
    73	=================================================
    74	#
    75	# ----- HITM -----    Snoop  ------- Store Refs -----   ------- CL --------                       
    76	# RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss     N/A     Off  Node  PA cnt        Code address
    77	# .......  .......  .......  .......  .......  ......   .....  ....  ......  ..................
    78	#
    79	  -------------------------------------------------------------------------------
    80	       0        0     4648        0        0    11572            0x422140
    81	  -------------------------------------------------------------------------------
    82	    0.00%    0.00%    0.00%    0.00%    0.00%   44.47%    0x0   N/A       0            0x400ce8
    83	    0.00%    0.00%   10.26%    0.00%    0.00%    0.00%    0x0   N/A       0            0x400e48
    84	    0.00%    0.00%    0.00%    0.00%    0.00%   55.53%    0x0   N/A       0            0x400e54
    85	    0.00%    0.00%   89.74%    0.00%    0.00%    0.00%    0x8   N/A       0            0x401038
       
Thanks again for doing this.
Joe

