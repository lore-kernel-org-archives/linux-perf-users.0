Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB470C61DA4
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Feb 2023 13:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBNNSs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Feb 2023 08:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjBNNSm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Feb 2023 08:18:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF3E2D72
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 05:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676380674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8HDxZQVwZH5D2IeFvDjPWBFybx0kwEQ286b5EVXyXg=;
        b=WGTcw+1PwaOinkxpi2PZTHIwcroO5V1xrkQefNm2r6qR9YZXUgcRsX0UffHT4RoMoAnpEV
        DnZa+5CS4ChJoI/Qf+n3nXa1spIzwZtL+t5XaTgQFpNfZ0Zu87xtKBzWw3ZBa+rJSL6opK
        azUKUnsCZq8nTok35cEZs5nIxXsasUU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-207-xAV6Ab3TMHmWOGWzV9bOmw-1; Tue, 14 Feb 2023 08:17:53 -0500
X-MC-Unique: xAV6Ab3TMHmWOGWzV9bOmw-1
Received: by mail-wm1-f70.google.com with SMTP id r14-20020a05600c35ce00b003e10bfcd160so8633565wmq.6
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 05:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8HDxZQVwZH5D2IeFvDjPWBFybx0kwEQ286b5EVXyXg=;
        b=h5lK59qg9WOHH4vcAHAMNc7noA7BRuiRDOBtxKXP7CYjwZIMO7az+mfbZGlBsaJ+on
         rSFvCJ0US11kmGtZrO7fabFgSRnE26HyVrdErBbjgl1SycxS0HGdMViXx72UNw5H7t0R
         2Vj+t4bunns4tIV/gBupxzLgs1o9Tkn6IBkIPgugHVaupPDAZnG00c5EpwBACr2s9p4S
         +V65OIFmkxbl5y2W2Wogh3ch/fB0EwRwiS9L9BtE5qVslRkDB1t3+bJaVFW4IFoc5SyY
         OgEAjPtulp4krfXEwiC8ICIetLXAXXh6VMcVAoed1G2Vb7435u76LD53xMzglEveLKgW
         JS6w==
X-Gm-Message-State: AO0yUKUj2E/jMmt8gp0nZOU74bY3VoQclDqp9l5YFqwIuYwUR/m1f+x4
        so+zjnBni1GWQM31neV7tEGXPlRyTVOR7VCC4h3/nCpL4gI+U812c2Q6q2xOZgzNU78RHxLV6ua
        PoaYuM5mDJqaAFuNbg4b2uyNQzbsSZg==
X-Received: by 2002:a7b:c855:0:b0:3db:742:cfe9 with SMTP id c21-20020a7bc855000000b003db0742cfe9mr2536566wml.34.1676380670592;
        Tue, 14 Feb 2023 05:17:50 -0800 (PST)
X-Google-Smtp-Source: AK7set8G7hIRNYDyQy+XjnM15cKgAkRYhCepLR9sQ49WwOk3wVWBgaodOKoIYp/PJB0uaGk7AdXIjg==
X-Received: by 2002:a7b:c855:0:b0:3db:742:cfe9 with SMTP id c21-20020a7bc855000000b003db0742cfe9mr2536546wml.34.1676380670294;
        Tue, 14 Feb 2023 05:17:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id iv12-20020a05600c548c00b003dc521f336esm18770472wmb.14.2023.02.14.05.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 05:17:49 -0800 (PST)
Message-ID: <baa7c076-09b9-f38d-ff6d-914fe2523219@redhat.com>
Date:   Tue, 14 Feb 2023 14:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Chih-En Lin <shiyn.lin@gmail.com>,
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
 <CA+CK2bB-dArab6scZU6tD7vnBBqbn9NwWbfwnddBzTxUmmhOfQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
In-Reply-To: <CA+CK2bB-dArab6scZU6tD7vnBBqbn9NwWbfwnddBzTxUmmhOfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 14.02.23 14:07, Pasha Tatashin wrote:
> On Tue, Feb 14, 2023 at 4:58 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 10.02.23 18:20, Chih-En Lin wrote:
>>> On Fri, Feb 10, 2023 at 11:21:16AM -0500, Pasha Tatashin wrote:
>>>>>>> Currently, copy-on-write is only used for the mapped memory; the child
>>>>>>> process still needs to copy the entire page table from the parent
>>>>>>> process during forking. The parent process might take a lot of time and
>>>>>>> memory to copy the page table when the parent has a big page table
>>>>>>> allocated. For example, the memory usage of a process after forking with
>>>>>>> 1 GB mapped memory is as follows:
>>>>>>
>>>>>> For some reason, I was not able to reproduce performance improvements
>>>>>> with a simple fork() performance measurement program. The results that
>>>>>> I saw are the following:
>>>>>>
>>>>>> Base:
>>>>>> Fork latency per gigabyte: 0.004416 seconds
>>>>>> Fork latency per gigabyte: 0.004382 seconds
>>>>>> Fork latency per gigabyte: 0.004442 seconds
>>>>>> COW kernel:
>>>>>> Fork latency per gigabyte: 0.004524 seconds
>>>>>> Fork latency per gigabyte: 0.004764 seconds
>>>>>> Fork latency per gigabyte: 0.004547 seconds
>>>>>>
>>>>>> AMD EPYC 7B12 64-Core Processor
>>>>>> Base:
>>>>>> Fork latency per gigabyte: 0.003923 seconds
>>>>>> Fork latency per gigabyte: 0.003909 seconds
>>>>>> Fork latency per gigabyte: 0.003955 seconds
>>>>>> COW kernel:
>>>>>> Fork latency per gigabyte: 0.004221 seconds
>>>>>> Fork latency per gigabyte: 0.003882 seconds
>>>>>> Fork latency per gigabyte: 0.003854 seconds
>>>>>>
>>>>>> Given, that page table for child is not copied, I was expecting the
>>>>>> performance to be better with COW kernel, and also not to depend on
>>>>>> the size of the parent.
>>>>>
>>>>> Yes, the child won't duplicate the page table, but fork will still
>>>>> traverse all the page table entries to do the accounting.
>>>>> And, since this patch expends the COW to the PTE table level, it's not
>>>>> the mapped page (page table entry) grained anymore, so we have to
>>>>> guarantee that all the mapped page is available to do COW mapping in
>>>>> the such page table.
>>>>> This kind of checking also costs some time.
>>>>> As a result, since the accounting and the checking, the COW PTE fork
>>>>> still depends on the size of the parent so the improvement might not
>>>>> be significant.
>>>>
>>>> The current version of the series does not provide any performance
>>>> improvements for fork(). I would recommend removing claims from the
>>>> cover letter about better fork() performance, as this may be
>>>> misleading for those looking for a way to speed up forking. In my
>>>
>>>   From v3 to v4, I changed the implementation of the COW fork() part to do
>>> the accounting and checking. At the time, I also removed most of the
>>> descriptions about the better fork() performance. Maybe it's not enough
>>> and still has some misleading. I will fix this in the next version.
>>> Thanks.
>>>
>>>> case, I was looking to speed up Redis OSS, which relies on fork() to
>>>> create consistent snapshots for driving replicates/backups. The O(N)
>>>> per-page operation causes fork() to be slow, so I was hoping that this
>>>> series, which does not duplicate the VA during fork(), would make the
>>>> operation much quicker.
>>>
>>> Indeed, at first, I tried to avoid the O(N) per-page operation by
>>> deferring the accounting and the swap stuff to the page fault. But,
>>> as I mentioned, it's not suitable for the mainline.
>>>
>>> Honestly, for improving the fork(), I have an idea to skip the per-page
>>> operation without breaking the logic. However, this will introduce the
>>> complicated mechanism and may has the overhead for other features. It
>>> might not be worth it. It's hard to strike a balance between the
>>> over-complicated mechanism with (probably) better performance and data
>>> consistency with the page status. So, I would focus on the safety and
>>> stable approach at first.
>>
>> Yes, it is most probably possible, but complexity, robustness and
>> maintainability have to be considered as well.
>>
>> Thanks for implementing this approach (only deduplication without other
>> optimizations) and evaluating it accordingly. It's certainly "cleaner",
>> such that we only have to mess with unsharing and not with other
>> accounting/pinning/mapcount thingies. But it also highlights how
>> intrusive even this basic deduplication approach already is -- and that
>> most benefits of the original approach requires even more complexity on top.
>>
>> I am not quite sure if the benefit is worth the price (I am not to
>> decide and I would like to hear other options).
>>
>> My quick thoughts after skimming over the core parts of this series
>>
>> (1) forgetting to break COW on a PTE in some pgtable walker feels quite
>>       likely (meaning that it might be fairly error-prone) and forgetting
>>       to break COW on a PTE table, accidentally modifying the shared
>>       table.
>> (2) break_cow_pte() can fail, which means that we can fail some
>>       operations (possibly silently halfway through) now. For example,
>>       looking at your change_pte_range() change, I suspect it's wrong.
>> (3) handle_cow_pte_fault() looks quite complicated and needs quite some
>>       double-checking: we temporarily clear the PMD, to reset it
>>       afterwards. I am not sure if that is correct. For example, what
>>       stops another page fault stumbling over that pmd_none() and
>>       allocating an empty page table? Maybe there are some locking details
>>       missing or they are very subtle such that we better document them. I
>>      recall that THP played quite some tricks to make such cases work ...
>>
>>>
>>>>> Actually, at the RFC v1 and v2, we proposed the version of skipping
>>>>> those works, and we got a significant improvement. You can see the
>>>>> number from RFC v2 cover letter [1]:
>>>>> "In short, with 512 MB mapped memory, COW PTE decreases latency by 93%
>>>>> for normal fork"
>>>>
>>>> I suspect the 93% improvement (when the mapcount was not updated) was
>>>> only for VAs with 4K pages. With 2M mappings this series did not
>>>> provide any benefit is this correct?
>>>
>>> Yes. In this case, the COW PTE performance is similar to the normal
>>> fork().
>>
>>
>> The thing with THP is, that during fork(), we always allocate a backup
>> PTE table, to be able to PTE-map the THP whenever we have to. Otherwise
>> we'd have to eventually fail some operations we don't want to fail --
>> similar to the case where break_cow_pte() could fail now due to -ENOMEM
>> although we really don't want to fail (e.g., change_pte_range() ).
>>
>> I always considered that wasteful, because in many scenarios, we'll
>> never ever split a THP and possibly waste memory.
> 
> Yes, it does sound wasteful for a pretty rare corner case that
> combines splitting THP in a process, and not having enough memory to
> allocate PTE page tables.
> 
>> Optimizing that for THP (e.g., don't always allocate backup THP, have
>> some global allocation backup pool for splits + refill when
>> close-to-empty) might provide similar fork() improvements, both in speed
>> and memory consumption when it comes to anonymous memory.
> 
> This sounds like a reasonable way to optimize the fork performance for
> processes with large RSS, which in most cases would have 2M THP
> mappings. When you say global pool, do you mean per machine, per
> cgroup, or per process?

Good question. I recall that the problem is that we sometimes need a new 
pgtable when splitting a THP, but

(a) we might be under spinlock and cannot sleep. We need an atomic
     allocation that might fail. For this, a pool might be helpful.

(b) we might actually be out of memory.

My gut feeling is that a global pool would be sufficient, only yo be 
used when we run into (a) or (b) to be able to make progress in these 
rare cases.

Something that would be interesting to evaluate is which THP split 
operations might might require some way to recover when really OOM.

For example, __split_huge_pmd() is currently not able to report a 
failure. I assume that we could sleep in there. And if we're not able to 
allocate any memory in there (with sleeping), maybe the process should 
be zapped either way by the OOM killer.


-- 
Thanks,

David / dhildenb

