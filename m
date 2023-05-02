Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6668DC77B73
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 17:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjEBRfC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjEBRfB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 13:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF07910CF
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683048851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8EQxB5Rji2ViwQdGaI3sszlcO5mXGtLYkFgR+gxOeA=;
        b=P+1Y62ieRfl6JfG7ckZ3t3M5VmzLJwsKnUB5iGHETr91YQBSYWliOoo4n/dugewt6YXEK2
        jjfz9u2x6GstgbOYeRbTdysGf0GqHcL5F+Y4KRzJ5hhYX7vpRrz2rgiYuslhJqWH54TokJ
        2OGfhetGKdGNQu5B2zCDqweJpjrKzZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-tkPikvESMAyD0bqaL1Y7zg-1; Tue, 02 May 2023 13:34:10 -0400
X-MC-Unique: tkPikvESMAyD0bqaL1Y7zg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f16f50aeb5so13587455e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 10:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683048849; x=1685640849;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8EQxB5Rji2ViwQdGaI3sszlcO5mXGtLYkFgR+gxOeA=;
        b=U8PneVRhG4KPy4Zs1AYrBm5zSr9Y6MFGDGzAU/UGO1QqNE4ak7SWklGsiSbeNonRAZ
         FFE4reaL2K1PIFrLBhHVD8JFtWEnxgNy2CUdLxjkD9zRbOMILqpCFEIN637l6uLov6kK
         YQSzKUF54y0H5L+jaDaXl/Ceq9q3uy/gIekFj6BfQfUCu3zCbjKnNoNukeUND48yMEIv
         yNPBQhNOCBx75S8u0MI4zw9Q5eAHtflDfzI0gvQmnsyIw1M8te6zFSBJfRovBYLlxme5
         qHu3fdThZOtUJvCCDokEN0edIskoJ8bXpbnUN5NiceDcYm0l4mAZH7PYZdg6+qTsTKoe
         m8gg==
X-Gm-Message-State: AC+VfDxYWd5uDOohQAAe210dn6Vqk6RYGVPUTzebITv5Y7xQilVijCKp
        O2mZ2wC9vKCoFDZ3U8ig+ygIChttORk8YuyAdoDPzk5RG1aEJRLAXMp3aAvNtOJJ06n8Wwq6P36
        1PRARRMxdUF2ZQ0YA5W+xP6A4kSikgg==
X-Received: by 2002:a05:600c:243:b0:3f0:7eda:c19f with SMTP id 3-20020a05600c024300b003f07edac19fmr13178726wmj.11.1683048849404;
        Tue, 02 May 2023 10:34:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rY/Uw9D184Y6lbc9agQJLV0y9DAm7UV6MhvxNJyexluz6bhaJuqIcn/csPhLRfdlbL7/yQQ==
X-Received: by 2002:a05:600c:243:b0:3f0:7eda:c19f with SMTP id 3-20020a05600c024300b003f07edac19fmr13178707wmj.11.1683048849038;
        Tue, 02 May 2023 10:34:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id q6-20020a5d5746000000b003063db8f45bsm351606wrw.23.2023.05.02.10.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 10:34:08 -0700 (PDT)
Message-ID: <406fd43a-a051-5fbe-6f66-a43f5e7e7573@redhat.com>
Date:   Tue, 2 May 2023 19:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
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
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <cover.1683044162.git.lstoakes@gmail.com>
 <b3a4441cade9770e00d24f5ecb75c8f4481785a4.1683044162.git.lstoakes@gmail.com>
 <1691115d-dba4-636b-d736-6a20359a67c3@redhat.com>
 <20230502172231.GH1597538@hirez.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
In-Reply-To: <20230502172231.GH1597538@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 02.05.23 19:22, Peter Zijlstra wrote:
> On Tue, May 02, 2023 at 07:13:49PM +0200, David Hildenbrand wrote:
>> [...]
>>
>>> +{
>>> +	struct address_space *mapping;
>>> +
>>> +	/*
>>> +	 * GUP-fast disables IRQs - this prevents IPIs from causing page tables
>>> +	 * to disappear from under us, as well as preventing RCU grace periods
>>> +	 * from making progress (i.e. implying rcu_read_lock()).
>>> +	 *
>>> +	 * This means we can rely on the folio remaining stable for all
>>> +	 * architectures, both those that set CONFIG_MMU_GATHER_RCU_TABLE_FREE
>>> +	 * and those that do not.
>>> +	 *
>>> +	 * We get the added benefit that given inodes, and thus address_space,
>>> +	 * objects are RCU freed, we can rely on the mapping remaining stable
>>> +	 * here with no risk of a truncation or similar race.
>>> +	 */
>>> +	lockdep_assert_irqs_disabled();
>>> +
>>> +	/*
>>> +	 * If no mapping can be found, this implies an anonymous or otherwise
>>> +	 * non-file backed folio so in this instance we permit the pin.
>>> +	 *
>>> +	 * shmem and hugetlb mappings do not require dirty-tracking so we
>>> +	 * explicitly whitelist these.
>>> +	 *
>>> +	 * Other non dirty-tracked folios will be picked up on the slow path.
>>> +	 */
>>> +	mapping = folio_mapping(folio);
>>> +	return !mapping || shmem_mapping(mapping) || folio_test_hugetlb(folio);
>>
>> "Folios in the swap cache return the swap mapping" -- you might disallow
>> pinning anonymous pages that are in the swap cache.
>>
>> I recall that there are corner cases where we can end up with an anon page
>> that's mapped writable but still in the swap cache ... so you'd fallback to
>> the GUP slow path (acceptable for these corner cases, I guess), however
>> especially the comment is a bit misleading then.
>>
>> So I'd suggest not dropping the folio_test_anon() check, or open-coding it
>> ... which will make this piece of code most certainly easier to get when
>> staring at folio_mapping(). Or to spell it out in the comment (usually I
>> prefer code over comments).
> 
> So how stable is folio->mapping at this point? Can two subsequent reads
> get different values? (eg. an actual mapping and NULL)
> 
> If so, folio_mapping() itself seems to be missing a READ_ONCE() to avoid
> the compiler from emitting the load multiple times.

I can only talk about anon pages in this specific call order here (check 
first, then test if the PTE changed in the meantime): we don't care if 
we get two different values. If we get a different value the second 
time, surely we (temporarily) pinned an anon page that is no longer 
mapped (freed in the meantime). But in that case (even if we read 
garbage folio->mapping and made the wrong call here), we'll detect 
afterwards that the PTE changed, and unpin what we (temporarily) pinned. 
As folio_test_anon() only checks two bits in folio->mapping it's fine, 
because we won't dereference garbage folio->mapping.

With folio_mapping() on !anon and READ_ONCE() ... good question. Kirill 
said it would be fairly stable, but I suspect that it could change 
(especially if we call it before validating if the PTE changed as I 
described further below).

Now, if we read folio->mapping after checking if the page we pinned is 
still mapped (PTE unchanged), at least the page we pinned cannot be 
reused in the meantime. I suspect that we can still read "NULL" on the 
second read. But whatever we dereference from the first read should 
still be valid, even if the second read would have returned NULL ("rcu 
freeing").

-- 
Thanks,

David / dhildenb

