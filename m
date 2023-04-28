Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AF3C77B61
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 16:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjD1QB2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344351AbjD1QB0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 12:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77D4212
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682697646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aTvTmC3w8cSoK1sZTIItrjPETSg3RyPhXAPGqmBpz9w=;
        b=WyDlBnLsVmXgf6nfmZhbRS6pfkj9EGKSfLx2QB6Kw3JO8sKtTVrhEiXt53s4IRCkfUvUbA
        nn/5tYtkxBkquS8OceQhLBHctt7exsF653PwKklC3wmfv2GwK6LvRN13hSi+yDpa8KY5ND
        5Ci0PEOGbd8Sqw74exvFteYWo0hCy+M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-ih7Lwj4YPiG9ARPMKegBfA-1; Fri, 28 Apr 2023 12:00:30 -0400
X-MC-Unique: ih7Lwj4YPiG9ARPMKegBfA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f3157128b4so43723965e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 09:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697627; x=1685289627;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTvTmC3w8cSoK1sZTIItrjPETSg3RyPhXAPGqmBpz9w=;
        b=FL6dLQoUVL2u9ZlrZzH8w4HfBYfC9dknmibXVOGSal730rI7cLfUHj/baqleSCiVz+
         M55+NXt85+Vp9nYRPE1BN/4UGZz6nubntwt3mvQnR7gdi4uxrqdPyydqfunKZw5PWrDw
         g7qlTqfFiVu3eG8x3PrM7frKy8xWl8L9p1HKNGq0H5Hp+bpJXDI1X783fwqQHAgdzV40
         8f7VK5Sr2UcFD3XBaQFvKQfFMcWkaX/M1bCkA+D1hB7hLW0v7Uj73Apf2n9PMleazrmN
         /XBJQZT7f4F6WXw7De9mxHYmjGp290u+GrO0JIhd9TX7T8S3a00VCiYdueQDFSgBGIk5
         8pBg==
X-Gm-Message-State: AC+VfDxeTH/fkhPwECsfKaHuWBgbDgwKDvvlQYhgv37ApCFQ1pXCP8tk
        AAo4zGSJYD8Km6bhWYdsNZHXgI8WWLsRNwy+dRRwvHpVTrd58i67e3CHHtknmIarp2IXRlsYYJT
        jDZxwdVz2tU9RWtjcZA760+FoK4IxeA==
X-Received: by 2002:a05:600c:2046:b0:3ed:3268:5f35 with SMTP id p6-20020a05600c204600b003ed32685f35mr4408030wmg.18.1682697627086;
        Fri, 28 Apr 2023 09:00:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CuV5Y9R4xOZ0iO1MIIj9ynREbGl3f73GmNX7T5mCyhDkj53kzHkbrow+2KlrZE2FhtmwsQw==
X-Received: by 2002:a05:600c:2046:b0:3ed:3268:5f35 with SMTP id p6-20020a05600c204600b003ed32685f35mr4407973wmg.18.1682697626733;
        Fri, 28 Apr 2023 09:00:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:9300:1711:356:6550:7502? (p200300cbc72693001711035665507502.dip0.t-ipconnect.de. [2003:cb:c726:9300:1711:356:6550:7502])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003f049a42689sm24709589wmc.25.2023.04.28.09.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 09:00:25 -0700 (PDT)
Message-ID: <620882a8-2b93-b709-1093-a323570f0fd2@redhat.com>
Date:   Fri, 28 Apr 2023 18:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
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
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <6b73e692c2929dc4613af711bdf92e2ec1956a66.1682638385.git.lstoakes@gmail.com>
 <afcc124e-7a9b-879c-dfdf-200426b84e24@redhat.com>
 <f60722d4-1474-4876-9291-5450c7192bd3@lucifer.local>
 <a8561203-a4f3-4b3d-338a-06a60541bd6b@redhat.com>
 <49ebb100-afd2-4810-b901-1a0f51f45cfc@lucifer.local>
 <a501219c-f75a-4467-fefe-bd571e84f99e@redhat.com>
 <b11d8e94-1324-41b3-91ba-78dbef0b1fc0@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5] mm/gup: disallow GUP writing to file-backed mappings
 by default
In-Reply-To: <b11d8e94-1324-41b3-91ba-78dbef0b1fc0@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

[...]

>>>
>>> Personally I come at this from the 'I just want my vmas patch series' unblocked
>>> perspective :) and feel there's a functional aspect here too.
>>
>> I know, it always gets messy when touching such sensible topics :P
> 
> I feel that several people owe me drinks at LSF/MM :P
> 
> To cut a long story short to your other points, I'm _really_ leaning
> towards an opt-in variant of this change that we just hand to io_uring to
> make everything simple with minimum risk (if Jens was also open to this
> idea, it'd simply be deleting the open coded vma checks there and adding
> FOLL_SAFE_FILE_WRITE).
> 
> That way we can save the delightful back and forth for another time while
> adding a useful feature and documenting the issue.

Just for the records: I'm not opposed to disabling it system-wide, 
especially once this is an actual security issue and can bring down the 
machine easily (thanks to Jason for raising the security aspect). I just 
wanted to raise awareness that there might be users affected ...

Sure, we could glue this to some system knob like Jason said, if we want 
to play safe.

> 
> Altneratively I could try to adapt this to also do the GUP-fast check,
> hoping that no FOLL_FAST_ONLY users would get nixed (I'd have to check who
> uses that). The others should just get degraded to a standard GUP right?

Yes. When you need the VMA to make a decision, fallback to standard GUP.

The only problematic part is something like get_user_pages_fast_only(), 
that would observe a change. But KVM never passes FOLL_LONGTERM, so at 
least in that context the change should be fine I guess.

The performance concern is the most problematic thing (how to identify 
shmem pages).

> 
> I feel these various series have really helped beat out some details about
> GUP, so as to your point on another thread (trying to reduce noise here
> :P), I think discussion at LSF/MM is also a sensible idea, also you know,
> if beers were bought too it could all work out nicely :]

The issue is, that GUP is so complicated, that each and every MM 
developer familiar with GUP has something to add :P

What stood out to me is that we disallow something for ordinary GUP but 
disallow it for GUP-fast, which looks very odd.

So sorry again for jumping in late ...

-- 
Thanks,

David / dhildenb

