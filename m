Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F9C05027
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Feb 2023 17:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBNRF4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Feb 2023 12:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjBNRFw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Feb 2023 12:05:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B632D141
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 09:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676394245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRv9ri62QZ3gJa1mEP8cILMMa4bJVoJu/pQsWSUh2bo=;
        b=Si83a7GTSitfhslsGTIPA+i4K6VWNOWcNk4uv/MXHC1Va1eil2JrZrFnKGWFZRhkqTAjD8
        z6i76QbOxj+igTRSCHl9Z64uxLtDnIpbTFxGwU+9dWvSCmKIzVNzULSLH5YxggUaYr6kUq
        EYUp+prlrqdW9l3Zioxst310GNt7JhQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-nfixKq8HMCOVeXOtPfSn3A-1; Tue, 14 Feb 2023 12:04:03 -0500
X-MC-Unique: nfixKq8HMCOVeXOtPfSn3A-1
Received: by mail-wm1-f69.google.com with SMTP id ay19-20020a05600c1e1300b003dc54daba42so8044202wmb.7
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 09:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRv9ri62QZ3gJa1mEP8cILMMa4bJVoJu/pQsWSUh2bo=;
        b=11iETsRVtp+K0golDAJsTRbqGu1WWlsCcWxE1egfwRh7V6olJD/BDaZM4YMridL7Pe
         jQrOHSlExWuUX2hBrv9/CAD2Yh6J/8avvykpoMUlg52xYgIEC6tt0Oc4YUX6P9ncd5Sk
         e53DVfBeUcC1+TIbqLnpIkmqOEUfdF47muM30O+ImeIW8SLk6aTa/rER6Xu5AKBWG/xy
         yCCDq+/Gsf9hK5Pk9itH8yD4+0n7zkkBoN37uZ7R/HaFwPNjGO8g+oydV5iOWfw5pE4g
         aV6jbrzojA/TuwjIkuLo0biHqQRt8GjvGIoa9wcbH9ZEo+6YLpkcJe4GN9ACBYNupCUK
         +5Jg==
X-Gm-Message-State: AO0yUKWCAKbM9LzKqk8BO2PuFOGssrnuvUd9FXqS4V4xn3gJMPLhiEXc
        tw8OXS3NYO56smS9rSKSk6TrBk73YvFKHA4E7PEG/VCra+CdELMiyNDPHv7PhRVN6vlVhCNjLPt
        OKM1gVZFiM6Bh5uho1qn7f8VRla6gdw==
X-Received: by 2002:a05:600c:13c5:b0:3dd:daac:d99d with SMTP id e5-20020a05600c13c500b003dddaacd99dmr2527013wmg.36.1676394241785;
        Tue, 14 Feb 2023 09:04:01 -0800 (PST)
X-Google-Smtp-Source: AK7set8tSPkMFovKHAi9fQL2Lota2iYTdYbeJPkqZQwJOal/QZ6PhHFXtJ8m01VC2QuC7xPfjtZ3Cg==
X-Received: by 2002:a05:600c:13c5:b0:3dd:daac:d99d with SMTP id e5-20020a05600c13c500b003dddaacd99dmr2526969wmg.36.1676394241490;
        Tue, 14 Feb 2023 09:04:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c450700b003dc42d48defsm20057888wmo.6.2023.02.14.09.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 09:04:00 -0800 (PST)
Message-ID: <1bee97ef-7632-b1bf-f042-29b97882bfb6@redhat.com>
Date:   Tue, 14 Feb 2023 18:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Chih-En Lin <shiyn.lin@gmail.com>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
 <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop>
 <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
 <Y+uv3iTajGoOuNMO@strix-laptop>
 <a02714ee-3223-ba53-09eb-33f7b03ef038@redhat.com>
Organization: Red Hat
In-Reply-To: <a02714ee-3223-ba53-09eb-33f7b03ef038@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 14.02.23 17:58, David Hildenbrand wrote:
> 
>>>>
>>>> Honestly, for improving the fork(), I have an idea to skip the per-page
>>>> operation without breaking the logic. However, this will introduce the
>>>> complicated mechanism and may has the overhead for other features. It
>>>> might not be worth it. It's hard to strike a balance between the
>>>> over-complicated mechanism with (probably) better performance and data
>>>> consistency with the page status. So, I would focus on the safety and
>>>> stable approach at first.
>>>
>>> Yes, it is most probably possible, but complexity, robustness and
>>> maintainability have to be considered as well.
>>>
>>> Thanks for implementing this approach (only deduplication without other
>>> optimizations) and evaluating it accordingly. It's certainly "cleaner", such
>>> that we only have to mess with unsharing and not with other
>>> accounting/pinning/mapcount thingies. But it also highlights how intrusive
>>> even this basic deduplication approach already is -- and that most benefits
>>> of the original approach requires even more complexity on top.
>>>
>>> I am not quite sure if the benefit is worth the price (I am not to decide
>>> and I would like to hear other options).
>>
>> I'm looking at the discussion of page table sharing in 2002 [1].
>> It looks like in 2002 ~ 2006, there also have some patches try to
>> improve fork().
>>
>> After that, I also saw one thread which is about another shared page
>> table patch's benchmark. I can't find the original patch though [2].
>> But, I found the probably same patch in 2005 [3], it also mentioned
>> the previous benchmark discussion:
>>
>> "
>> For those familiar with the shared page table patch I did a couple of years
>> ago, this patch does not implement copy-on-write page tables for private
>> mappings.  Analysis showed the cost and complexity far outweighed any
>> potential benefit.
>> "
> 
> Thanks for the pointer, interesting read. And my personal opinion is
> that part of that statement still hold true :)
> 
>>
>> However, it might be different right now. For example, the implemetation
>> . We have split page table lock now, so we don't have to consider the
>> page_table_share_lock thing. Also, presently, we have different use
>> cases (shells [2] v.s. VM cloning and fuzzing) to consider.


Oh, and because I stumbled over it, just as an interesting pointer on 
QEMU devel:

"[PATCH 00/10] Retire Fork-Based Fuzzing" [1]

[1] https://lore.kernel.org/all/20230205042951.3570008-1-alxndr@bu.edu/T/#u

-- 
Thanks,

David / dhildenb

