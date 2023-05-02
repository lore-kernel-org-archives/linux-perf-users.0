Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E245C7EE21
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 13:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjEBNs4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjEBNsy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 09:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D45B85
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683035269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3J2uAw/ly+PNbny+QW1yUQ6DEbuSoPG3Zwu6k/I8hM=;
        b=fozI/mZc92pFL+/0eqXM3yQCfGfxEs2OJ8Ej0lP6qiI7zyeYU2nFSNzP5myYt21CmZ+uws
        D3VVy/Mqp6z0WQpvHaWNv6ZKXCEfnMswAAwGuiUmb96k3WpdxO+A6pviy+mPMW+TzVfJk8
        5KTFTf+mh3BLGDDbB/aab3fzHbr0BVI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-rk_DjvwUPQyY19vLsaZF9A-1; Tue, 02 May 2023 09:47:48 -0400
X-MC-Unique: rk_DjvwUPQyY19vLsaZF9A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f16f50aeb5so12484065e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 06:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683035267; x=1685627267;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3J2uAw/ly+PNbny+QW1yUQ6DEbuSoPG3Zwu6k/I8hM=;
        b=X56i+xL2wWJMQlYVQN0zLd0TSbtbbPSYExZQ7gm5qC4UkGgm9i1ceowrdqw76VrnGH
         iA/D9DNj+mob5Tj/V4MDNVMIpRRleC3kwu2lDqg7PFLXVSEwicA5hm5J7ZusF27flJjw
         LvZ76mXf80Z0A8XP2Prq6LXP78Dd7kCkj7c0Oxzv3II0jfNLrMQwSi4E3tFGYzR5MKr1
         Rb0jUpnztuhuyCLUtA9g5N/UK+wm/NESUf9DLgGJkVMVKJR6pcP2MM5fbjQl5tZVPCPl
         Omv27qlnje/lP83IyAokokUWGCBhCfNApc/Q5ODoLFXYIUyNEu8mFHYYz/MgChStU/jv
         xc3w==
X-Gm-Message-State: AC+VfDwL9JdDVoUn2b09inDfa5Iv9s/tLjgfzEaas6fqverEVY42gsW5
        2vhNJ9ps2gazNk8G1P8qykCFu8PWs8dl99kO+XPK5U0SaxyQwdfcX7Ca/Xoa6sPKkst8ob2xHDc
        /O1qhCIJABgRZEEPcvHWOgXcAzVjUUw==
X-Received: by 2002:a1c:7404:0:b0:3f1:92aa:4eb8 with SMTP id p4-20020a1c7404000000b003f192aa4eb8mr13150690wmc.16.1683035267232;
        Tue, 02 May 2023 06:47:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5erONwJ74D2u4zUQpg0uPdUPwazWaMyXU9Kn1O6BpFG7TQ1T86Oqm9RgmLypMPcZwuJndm2g==
X-Received: by 2002:a1c:7404:0:b0:3f1:92aa:4eb8 with SMTP id p4-20020a1c7404000000b003f192aa4eb8mr13150657wmc.16.1683035266844;
        Tue, 02 May 2023 06:47:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c00d300b003f17eaae2c9sm35746626wmm.1.2023.05.02.06.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 06:47:45 -0700 (PDT)
Message-ID: <ad60d5d2-cfdf-df9f-aef1-7a0d3facbece@redhat.com>
Date:   Tue, 2 May 2023 15:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
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
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>
References: <cover.1682981880.git.lstoakes@gmail.com>
 <dee4f4ad6532b0f94d073da263526de334d5d7e0.1682981880.git.lstoakes@gmail.com>
 <fbad9e18-f727-9703-33cf-545a2d33af76@linux.ibm.com>
 <7d56b424-ba79-4b21-b02c-c89705533852@lucifer.local>
 <a6bb0334-9aba-9fd8-6a9a-9d4a931b6da2@linux.ibm.com>
 <ZFEL20GQdomXGxko@nvidia.com>
 <c4f790fb-b18a-341a-6965-455163ec06d1@redhat.com>
 <ZFER5ROgCUyywvfe@nvidia.com>
 <ce3aa7b9-723c-6ad3-3f03-3f1736e1c253@redhat.com>
 <ff99f2d8-804d-924f-3c60-b342ffc2173c@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ff99f2d8-804d-924f-3c60-b342ffc2173c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 02.05.23 15:43, Matthew Rosato wrote:
> On 5/2/23 9:39 AM, David Hildenbrand wrote:
>> On 02.05.23 15:36, Jason Gunthorpe wrote:
>>> On Tue, May 02, 2023 at 03:28:40PM +0200, David Hildenbrand wrote:
>>>> On 02.05.23 15:10, Jason Gunthorpe wrote:
>>>>> On Tue, May 02, 2023 at 03:04:27PM +0200, Christian Borntraeger wrote:
>>>>> \> > We can reintroduce a flag to permit exceptions if this is really broken, are you
>>>>>>> able to test? I don't have an s390 sat around :)
>>>>>>
>>>>>> Matt (Rosato on cc) probably can. In the end, it would mean having
>>>>>>      <memoryBacking>
>>>>>>        <source type="file"/>
>>>>>>      </memoryBacking>
>>>>>
>>>>> This s390 code is the least of the problems, after this series VFIO
>>>>> won't startup at all with this configuration.
>>>>
>>>> Good question if the domain would fail to start. I recall that IOMMUs for
>>>> zPCI are special on s390x. [1]
>>>
>>> Not upstream they aren't.
>>>
>>>> Well, zPCI is special. I cannot immediately tell when we would trigger
>>>> long-term pinning.
>>>
>>> zPCI uses the standard IOMMU stuff, so it uses a normal VFIO container
>>> and the normal pin_user_pages() path.
>>
>>
>> @Christian, Matthew: would we pin all guest memory when starting the domain (IIRC, like on x86-64) and fail early, or only when the guest issues rpcit instructions to map individual pages?
>>
> 
> Eventually we want to implement a mechanism where we can dynamically pin in response to RPCIT.
> 

Okay, so IIRC we'll fail starting the domain early, that's good. And if 
we pin all guest memory (instead of small pieces dynamically), there is 
little existing use for file-backed RAM in such zPCI configurations 
(because memory cannot be reclaimed either way if it's all pinned), so 
likely there are no real existing users.

> However, per Jason's prior suggestion, the initial implementation for s390 nesting via iommufd will pin all of guest memory when starting the domain.  I have something already working via iommufd built on top of the nesting infrastructure patches and QEMU iommufd series that are floating around; needs some cleanup, hoping to send an RFC in the coming weeks.  I can CC you if you'd like.

Yes, please.

-- 
Thanks,

David / dhildenb

