Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF533C77B7D
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 20:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjEEUWQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjEEUWO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 16:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F0A44BF
        for <linux-perf-users@vger.kernel.org>; Fri,  5 May 2023 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683318087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsggkaMmsBvOy5xyONdITFWw/iHmRz4dl3tGfhzjtDI=;
        b=AsFjbdPgh+Wyv+dUSCHG+cSIT9hLp+oJwF4hPJY2dVon5WDio+pwNGjk+unG7FAgvlM4IQ
        ziM3qZQPg5Tn2FVyf044sYxkLxz7CiktUkFs1DRSRcPLwSs6xh0sihQk3diC05DRR/tFlC
        KECQzO7obsc3ZKb/H5PrvPPlARgxFfA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-9IGj914sMMuPrzWUIQpoSQ-1; Fri, 05 May 2023 16:21:26 -0400
X-MC-Unique: 9IGj914sMMuPrzWUIQpoSQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f1793d6363so8475135e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 13:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683318085; x=1685910085;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsggkaMmsBvOy5xyONdITFWw/iHmRz4dl3tGfhzjtDI=;
        b=FWeu1Lk39ESe2QfoEl1ehSmb7c9f3gZi3X+XP5V6MsFA3/7HSE9lqPVWZ5kswa7T4s
         m24oYXPzjEYs6b5V5dNvGywq1m+o2OUiWTp1aWMcyP45mJM2Dm241vN/DlVRnS33zKQn
         h5cm7zB5/P/BDpNmLpePAXCD6cE5TryQ/fzed4Zg11FECbi/fWD7BS+VMX206c2n55fs
         uhCxq0Wqi4Ibm2CoOcZpkfMKry2P8x9uH63qvbzKEihTOyGM0ysoHyeljAt0GqEdn17r
         t7EdcvIolPmywCjrAzlHnPA+l19hprFL8QdQZSROF6LF98LvYvrzAXKobNMXI5QNPY7c
         ljvg==
X-Gm-Message-State: AC+VfDy2i3AEuw6huFvhAZu34h8bKFjun589Edz6Xr5JTvz2h4YgsBYb
        EnHfA8A7CWqyV+ZDF7Ya+0mQaEr6ovD8U6SZrNLQ97wH7SNeP8PhoGdbm0ZXmvHFfmXaj/as77M
        duRzUdeDavCkGrxvOIoNEjLTMTChW3A==
X-Received: by 2002:a5d:4570:0:b0:2fe:c0ea:18b5 with SMTP id a16-20020a5d4570000000b002fec0ea18b5mr2183580wrc.35.1683318085034;
        Fri, 05 May 2023 13:21:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FviCLOGbcNtThAkyINVmphT4Em0kBlGhMilbIRI+JzZwkEaqvefxxGYCQlWMeGdaho0noZA==
X-Received: by 2002:a5d:4570:0:b0:2fe:c0ea:18b5 with SMTP id a16-20020a5d4570000000b002fec0ea18b5mr2183541wrc.35.1683318084651;
        Fri, 05 May 2023 13:21:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:6900:2b25:fc69:599e:3986? (p200300cbc71f69002b25fc69599e3986.dip0.t-ipconnect.de. [2003:cb:c71f:6900:2b25:fc69:599e:3986])
        by smtp.gmail.com with ESMTPSA id q18-20020a056000137200b003063176ef09sm3377323wrz.6.2023.05.05.13.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 13:21:24 -0700 (PDT)
Message-ID: <6e96358e-bcb5-cc36-18c3-ec5153867b9a@redhat.com>
Date:   Fri, 5 May 2023 22:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
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
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <cover.1683235180.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v9 0/3] mm/gup: disallow GUP writing to file-backed
 mappings by default
In-Reply-To: <cover.1683235180.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 04.05.23 23:27, Lorenzo Stoakes wrote:
> Writing to file-backed mappings which require folio dirty tracking using
> GUP is a fundamentally broken operation, as kernel write access to GUP
> mappings do not adhere to the semantics expected by a file system.
> 
> A GUP caller uses the direct mapping to access the folio, which does not
> cause write notify to trigger, nor does it enforce that the caller marks
> the folio dirty.
> 
> The problem arises when, after an initial write to the folio, writeback
> results in the folio being cleaned and then the caller, via the GUP
> interface, writes to the folio again.
> 
> As a result of the use of this secondary, direct, mapping to the folio no
> write notify will occur, and if the caller does mark the folio dirty, this
> will be done so unexpectedly.
> 
> For example, consider the following scenario:-
> 
> 1. A folio is written to via GUP which write-faults the memory, notifying
>     the file system and dirtying the folio.
> 2. Later, writeback is triggered, resulting in the folio being cleaned and
>     the PTE being marked read-only.
> 3. The GUP caller writes to the folio, as it is mapped read/write via the
>     direct mapping.
> 4. The GUP caller, now done with the page, unpins it and sets it dirty
>     (though it does not have to).
> 
> This change updates both the PUP FOLL_LONGTERM slow and fast APIs. As
> pin_user_pages_fast_only() does not exist, we can rely on a slightly
> imperfect whitelisting in the PUP-fast case and fall back to the slow case
> should this fail.
> 
>

Thanks a lot, this looks pretty good to me!

I started writing some selftests (assuming none would be in the works) using
iouring and and the gup_tests interface. So far, no real surprises for the general
GUP interaction [1].


There are two things I noticed when registering an iouring fixed buffer (that differ
now from generic gup_test usage):


(1) Registering a fixed buffer targeting an unsupported MAP_SHARED FS file now fails with
     EFAULT (from pin_user_pages()) instead of EOPNOTSUPP (from io_pin_pages()).

The man page for io_uring_register documents:

        EOPNOTSUPP
               User buffers point to file-backed memory.

... we'd have to do some kind of errno translation in io_pin_pages(). But the
translation is not simple (sometimes we want to forward EOPNOTSUPP). That also
applies once we remove that special-casing in io_uring code.

... maybe we can simply update the manpage (stating that older kernels returned
EOPNOTSUPP) and start returning EFAULT?


(2) Registering a fixed buffer targeting a MAP_PRIVATE FS file fails with EOPNOTSUPP
     (from io_pin_pages()). As discussed, there is nothing wrong with pinning all-anon
     pages (resulting from breaking COW).

That could be easily be handled (allow any !VM_MAYSHARE), and would automatically be
handled once removing the iouring special-casing.


[1]

# ./pin_longterm
# [INFO] detected hugetlb size: 2048 KiB
# [INFO] detected hugetlb size: 1048576 KiB
TAP version 13
1..50
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd
ok 1 Pinning succeeded as expected
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
ok 2 Pinning succeeded as expected
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
ok 3 Pinning failed as expected
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 4 # SKIP need more free huge pages
# [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
ok 5 Pinning succeeded as expected
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd
ok 6 Pinning succeeded as expected
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with tmpfile
ok 7 Pinning succeeded as expected
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with local tmpfile
ok 8 Pinning failed as expected
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 9 # SKIP need more free huge pages
# [RUN] R/W longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
ok 10 Pinning succeeded as expected
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd
ok 11 Pinning succeeded as expected
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
ok 12 Pinning succeeded as expected
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
ok 13 Pinning succeeded as expected
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 14 # SKIP need more free huge pages
# [RUN] R/O longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
ok 15 Pinning succeeded as expected
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd
ok 16 Pinning succeeded as expected
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with tmpfile
ok 17 Pinning succeeded as expected
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with local tmpfile
ok 18 Pinning succeeded as expected
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 19 # SKIP need more free huge pages
# [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
ok 20 Pinning succeeded as expected
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
ok 21 Pinning succeeded as expected
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfile
ok 22 Pinning succeeded as expected
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with local tmpfile
ok 23 Pinning succeeded as expected
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
ok 24 # SKIP need more free huge pages
# [RUN] R/W longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
ok 25 Pinning succeeded as expected
# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd
ok 26 Pinning succeeded as expected
# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
ok 27 Pinning succeeded as expected
# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
ok 28 Pinning succeeded as expected
# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
ok 29 # SKIP need more free huge pages
# [RUN] R/W longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
ok 30 Pinning succeeded as expected
# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd
ok 31 Pinning succeeded as expected
# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with tmpfile
ok 32 Pinning succeeded as expected
# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with local tmpfile
ok 33 Pinning succeeded as expected
# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
ok 34 # SKIP need more free huge pages
# [RUN] R/O longterm GUP pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
ok 35 Pinning succeeded as expected
# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd
ok 36 Pinning succeeded as expected
# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with tmpfile
ok 37 Pinning succeeded as expected
# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with local tmpfile
ok 38 Pinning succeeded as expected
# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
ok 39 # SKIP need more free huge pages
# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
ok 40 Pinning succeeded as expected
# [RUN] iouring fixed buffer with MAP_SHARED file mapping ... with memfd
ok 41 Pinning succeeded as expected
# [RUN] iouring fixed buffer with MAP_SHARED file mapping ... with tmpfile
ok 42 Pinning succeeded as expected
# [RUN] iouring fixed buffer with MAP_SHARED file mapping ... with local tmpfile
ok 43 Pinning failed as expected
# [RUN] iouring fixed buffer with MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
ok 44 # SKIP need more free huge pages
# [RUN] iouring fixed buffer with MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
ok 45 Pinning succeeded as expected
# [RUN] iouring fixed buffer with MAP_PRIVATE file mapping ... with memfd
ok 46 Pinning succeeded as expected
# [RUN] iouring fixed buffer with MAP_PRIVATE file mapping ... with tmpfile
ok 47 Pinning succeeded as expected
# [RUN] iouring fixed buffer with MAP_PRIVATE file mapping ... with local tmpfile
not ok 48 Pinning failed as expected
# [RUN] iouring fixed buffer with MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
ok 49 # SKIP need more free huge pages
# [RUN] iouring fixed buffer with MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
ok 50 Pinning succeeded as expected
Bail out! 1 out of 50 tests failed
# Totals: pass:39 fail:1 xfail:0 xpass:0 skip:10 error:0


-- 
Thanks,

David / dhildenb

