Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB7BC77B73
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 13:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjEBNnY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjEBNm7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 09:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2807A8A
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683034796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChfrC0Na3lwoOCssg8XYm2tZsAjdTOPFW5RxWJ9WF6Q=;
        b=KcPR08UXgbTyWrAUU1NlrmfijJUTVQdF+MiHlJMJnxRFlhIUweKZCWZYyuELEZSEkadKkA
        TKHP7d2x6GLhFhAd9tdfsvGW6oQ3sVEJrHMQGVV3a7YvQ2G/aJZPc68GP4R+TOBbaoKtK5
        8lyqASoscgJJJG311T4r6kFhB2rWhuo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-lLsXevMfOQirPNsD9dEzGw-1; Tue, 02 May 2023 09:39:55 -0400
X-MC-Unique: lLsXevMfOQirPNsD9dEzGw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f171d38db3so23507595e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 06:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683034794; x=1685626794;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChfrC0Na3lwoOCssg8XYm2tZsAjdTOPFW5RxWJ9WF6Q=;
        b=K5THkUeCOtuRDBrg5Q5+FD4q/Smi6Vmc90rPmaxiLcDDTxuWyhXH7yNvTtlj/P3RbY
         z1NeK9UDD0vYU4PFkSpOuRGLsVhjZe82tUg4QRnWpjgkNTCqWeucDyXZpiPoyQWxgiGi
         tFz/8b+BMSzKITJL05S3yD+83QcmlYGvtz8e84Rb/DxEAx6iOeSCLxCdinCxpR0sUMoK
         H5vf1WItRgeBHhzL7ja+7tDBbErknlYtorbAZxhqiNg7OySmQKHK4Mo0pF+LcfsnkvyU
         UVtbXoJeK56JagyCh3OVOLgmILBrNFx6BcLzxWx2rWjhulGdXKO87QRsOD3E6eEVDQ4M
         kHDw==
X-Gm-Message-State: AC+VfDw1oqZPM4vDeN7nWXFKfepvVrRrOrgWIGrvurcisRv7tY1xZ7H3
        45ahrUNQrhhRObQ7tewK1xoPer8VUWErPFnalMCWvMfm/xDJ1U4wwvVdoFpHuvOpI7V4flbRuP6
        tD98iol2rACjhg1tpZr49Ixkt5+66SA==
X-Received: by 2002:a7b:c047:0:b0:3f1:979f:a734 with SMTP id u7-20020a7bc047000000b003f1979fa734mr12143043wmc.11.1683034793780;
        Tue, 02 May 2023 06:39:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fv9K5Zv09NhPo0iCYbemjYTTJL6PDbk31pGpPsym+SF2XVg6IT3tAZ5IAhu9BYcyhA4qZ7Q==
X-Received: by 2002:a7b:c047:0:b0:3f1:979f:a734 with SMTP id u7-20020a7bc047000000b003f1979fa734mr12142986wmc.11.1683034793381;
        Tue, 02 May 2023 06:39:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id iz14-20020a05600c554e00b003f175954e71sm38857931wmb.32.2023.05.02.06.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 06:39:52 -0700 (PDT)
Message-ID: <ce3aa7b9-723c-6ad3-3f03-3f1736e1c253@redhat.com>
Date:   Tue, 2 May 2023 15:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <cover.1682981880.git.lstoakes@gmail.com>
 <dee4f4ad6532b0f94d073da263526de334d5d7e0.1682981880.git.lstoakes@gmail.com>
 <fbad9e18-f727-9703-33cf-545a2d33af76@linux.ibm.com>
 <7d56b424-ba79-4b21-b02c-c89705533852@lucifer.local>
 <a6bb0334-9aba-9fd8-6a9a-9d4a931b6da2@linux.ibm.com>
 <ZFEL20GQdomXGxko@nvidia.com>
 <c4f790fb-b18a-341a-6965-455163ec06d1@redhat.com>
 <ZFER5ROgCUyywvfe@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZFER5ROgCUyywvfe@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 02.05.23 15:36, Jason Gunthorpe wrote:
> On Tue, May 02, 2023 at 03:28:40PM +0200, David Hildenbrand wrote:
>> On 02.05.23 15:10, Jason Gunthorpe wrote:
>>> On Tue, May 02, 2023 at 03:04:27PM +0200, Christian Borntraeger wrote:
>>> \> > We can reintroduce a flag to permit exceptions if this is really broken, are you
>>>>> able to test? I don't have an s390 sat around :)
>>>>
>>>> Matt (Rosato on cc) probably can. In the end, it would mean having
>>>>     <memoryBacking>
>>>>       <source type="file"/>
>>>>     </memoryBacking>
>>>
>>> This s390 code is the least of the problems, after this series VFIO
>>> won't startup at all with this configuration.
>>
>> Good question if the domain would fail to start. I recall that IOMMUs for
>> zPCI are special on s390x. [1]
> 
> Not upstream they aren't.
> 
>> Well, zPCI is special. I cannot immediately tell when we would trigger
>> long-term pinning.
> 
> zPCI uses the standard IOMMU stuff, so it uses a normal VFIO container
> and the normal pin_user_pages() path.


@Christian, Matthew: would we pin all guest memory when starting the 
domain (IIRC, like on x86-64) and fail early, or only when the guest 
issues rpcit instructions to map individual pages?

-- 
Thanks,

David / dhildenb

