Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0821C7EE25
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 15:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbjD1PYa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346374AbjD1PY1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 11:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662475FC7
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682695415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNqQu/Hbgh8GgG/TaR2UQBBPYePy9tTL0DFgLY8LdrU=;
        b=ML+bEd2uqQF2mEPpifoZPqZcHUoCUQjeUJuAhtGvXo0DjrvcggrLWnMSMMMuoQn4c7XHHB
        KNmAn4P4foC4wDMAIOrh3ur6oYsg0KQ8ox/SvOptb0JVUw4tZjAezMAYmHVyJRD+UBdisz
        OAEUKvOl3Bft8brNPq0qj3Mnw0A2I0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-JZtnuQ3pNguXYYP_XUofEA-1; Fri, 28 Apr 2023 11:23:33 -0400
X-MC-Unique: JZtnuQ3pNguXYYP_XUofEA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2fbb99cb303so3721587f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 08:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682695413; x=1685287413;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNqQu/Hbgh8GgG/TaR2UQBBPYePy9tTL0DFgLY8LdrU=;
        b=ij5lGN9XD/DJb30n1BWNeK4G9XF6zZZlv6EHD6mSFqI5EMOtfWQ2+/2nm4I/NW6k2j
         QHodEFfr8+pc+ZonIexAHzizyedYrq0qhrpCfQNHjpa9OmQ2wUskMA1ylJ2xoOlTRnD9
         3ivn9w3jw1wK4dWU/YzOPh+iceLOFK67Iwa4hHdXk8hpt0EdeuuyUe5lmuiS3VIhNHJY
         Ng5l8x+eeUDH+/WLt+rPLGJFdHq2g3G8BwHBEeJWgtsOI1M/y5XCwBOxPgbzIWeGviRt
         CqwHAYH9068B/tadCU3evm0dQdV6Fy5NveVOnKe/j5/+HupOjQCaGhDDmhizbKmaIVsN
         43wQ==
X-Gm-Message-State: AC+VfDwRa4Q9bi7ghVy/u6ES9t3cH0mV2+rAnfBCOUqcTIfuOpwscGMe
        CrP+QtPeed/itDhmbW5hA//273bVm5tu7OfWK9pqdPQviVRaNPLX61D4xvmwRD7Lx+8cwFW30J3
        tKJyI2MOolBsjmhENLEhsCIl/EZ2K6g==
X-Received: by 2002:a05:6000:1148:b0:304:7159:d3e4 with SMTP id d8-20020a056000114800b003047159d3e4mr4054758wrx.44.1682695412809;
        Fri, 28 Apr 2023 08:23:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7m7lYREqwJwCW0J3nLemNcIH2KdfBgyx6gX0Qrhp/YfT+ZQtoJy3PoVU25XYCmL9JQIphxhg==
X-Received: by 2002:a05:6000:1148:b0:304:7159:d3e4 with SMTP id d8-20020a056000114800b003047159d3e4mr4054718wrx.44.1682695412463;
        Fri, 28 Apr 2023 08:23:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:9300:1711:356:6550:7502? (p200300cbc72693001711035665507502.dip0.t-ipconnect.de. [2003:cb:c726:9300:1711:356:6550:7502])
        by smtp.gmail.com with ESMTPSA id a18-20020a056000101200b002e61e002943sm21368158wrx.116.2023.04.28.08.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 08:23:31 -0700 (PDT)
Message-ID: <400da248-a14e-46a4-420a-a3e075291085@redhat.com>
Date:   Fri, 28 Apr 2023 17:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
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
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <6b73e692c2929dc4613af711bdf92e2ec1956a66.1682638385.git.lstoakes@gmail.com>
 <afcc124e-7a9b-879c-dfdf-200426b84e24@redhat.com>
 <ZEvZtIb2EDb/WudP@nvidia.com>
 <094d2074-5b69-5d61-07f7-9f962014fa68@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5] mm/gup: disallow GUP writing to file-backed mappings
 by default
In-Reply-To: <094d2074-5b69-5d61-07f7-9f962014fa68@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

>>
>> Security is the primary case where we have historically closed uAPI
>> items.
> 
> As this patch
> 
> 1) Does not tackle GUP-fast
> 2) Does not take care of !FOLL_LONGTERM
> 
> I am not convinced by the security argument in regard to this patch.
> 
> 
> If we want to sells this as a security thing, we have to block it
> *completely* and then CC stable.

Regarding GUP-fast, to fix the issue there as well, I guess we could do 
something similar as I did in gup_must_unshare():

If we're in GUP-fast (no VMA), and want to pin a !anon page writable, 
fallback to ordinary GUP. IOW, if we don't know, better be safe.

Of course, this would prevent hugetlb/shmem from getting pinned writable 
during gup-fast. Unless we're able to whitelist them somehow in there.


For FOLL_LONGTERM it might fairly uncontroversial. For everything else 
I'm not sure if there could be undesired side-effects.

-- 
Thanks,

David / dhildenb

