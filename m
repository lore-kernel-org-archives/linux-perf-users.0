Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF44C05027
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Feb 2023 18:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjBNSxE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Feb 2023 13:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjBNSxD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Feb 2023 13:53:03 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B38A6B
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 10:52:53 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id r73so6532923qke.6
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 10:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OO7zbNPYsLgMAueQIKSxf/Kr+7+LgMABqvRk9SFj/Jk=;
        b=Ayqx7xMhzV5E3CwlCICFqozMpZyqraoxxSDrfJbeU4C0r04jYtPH/VZOq0X/zQBJsJ
         cVbztPVtJDwSojXI0guADhvaylJaR9jGSbH23VL3t09cdmzwhUo0nwC06tH7PF76ZLus
         jqpi+aYN0gw3r6WUedmXi1qlDlrPobJp8gOLQ8ie/JXGOQyMcKJYRxioUrcuyne+A1+m
         ElLjsTheSlhAOO07Q/QYhyqjGWG+R2KAHWkplQ6PoAuhVwZDs2P0n8FgFEBGIYUMJrU0
         KiiD6TeOE5hvz+AJcqKz1zXpcYWKV+jStjOOeJLKWq4gm9Kb58M7hMV6ovXRG6OLSr4O
         abhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OO7zbNPYsLgMAueQIKSxf/Kr+7+LgMABqvRk9SFj/Jk=;
        b=ACPaqz616CSQbP3Krc+ivB36nr25wjBvT2R+iYIz5XfKdr2xyMyr7dQCjwi6hNkF8s
         4ZcD1f5n4LyaG3zrLXSgrnJ46dJfh0l1FTBRqo8x9gNUNg+0wOWV3fTLW4jPd1O9yVQM
         2N8lbOctbMzJgxX9AaPT2/nMFthk4ShmkOfV156Rzd3LDGfU3hB/niuLsyooYm3eW69G
         hstAsfxHkFfeySXbynm2E6UmT+vvWbyOrqOtOWt89Zkvkc6MfRuZvXm1AUlbwWzxSvcS
         +Z7TxXoca2YcaDh7MfTZVZDRbfwN1EDwBK7nmbWtjBXdKQ33vKTHuAHQjSd91y0aGwX3
         k3fw==
X-Gm-Message-State: AO0yUKUXyckpqbQmnV5bIgebVZvveObft5GarDrc9Mba4gzMAP3G6X/f
        0X4ik9oE5X5a81abKKjfpSnhMKJMVOpUmt3Au7qL4g==
X-Google-Smtp-Source: AK7set+wb66HZ+f0aMDWEe3NDhalPbeZXZ4gImsWcqepnaTG0T3+q5z7ICV7K81oQPd1lHtaiAHk1AS8WVD6fknRwZc=
X-Received: by 2002:a05:620a:cc1:b0:720:6045:25ea with SMTP id
 b1-20020a05620a0cc100b00720604525eamr225052qkj.27.1676400772177; Tue, 14 Feb
 2023 10:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20230207035139.272707-1-shiyn.lin@gmail.com> <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop> <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
 <Y+uv3iTajGoOuNMO@strix-laptop> <CA+CK2bCKOONeipaYNQJSPTicej1DW0OWvw97r0TbG7oRtxVGnQ@mail.gmail.com>
 <Y+vV9YaiEIUQaW65@strix-laptop>
In-Reply-To: <Y+vV9YaiEIUQaW65@strix-laptop>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 14 Feb 2023 13:52:16 -0500
Message-ID: <CA+CK2bDYHT4m=we7jbLWxneZTnBt2wJd2Msw67V97c1nNq-KZQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
To:     Chih-En Lin <shiyn.lin@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 14, 2023 at 1:42 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
>
> On Tue, Feb 14, 2023 at 11:30:26AM -0500, Pasha Tatashin wrote:
> > > > The thing with THP is, that during fork(), we always allocate a backup PTE
> > > > table, to be able to PTE-map the THP whenever we have to. Otherwise we'd
> > > > have to eventually fail some operations we don't want to fail -- similar to
> > > > the case where break_cow_pte() could fail now due to -ENOMEM although we
> > > > really don't want to fail (e.g., change_pte_range() ).
> > > >
> > > > I always considered that wasteful, because in many scenarios, we'll never
> > > > ever split a THP and possibly waste memory.
> > > >
> > > > Optimizing that for THP (e.g., don't always allocate backup THP, have some
> > > > global allocation backup pool for splits + refill when close-to-empty) might
> > > > provide similar fork() improvements, both in speed and memory consumption
> > > > when it comes to anonymous memory.
> > >
> > > When collapsing huge pages, do/can they reuse those PTEs for backup?
> > > So, we don't have to allocate the PTE or maintain the pool.
> >
> > It might not work for all pages, as collapsing pages might have had
> > holes in the user page table, and there were no PTE tables.
>
> So if there have holes in the user page table, after we doing the
> collapsing and then splitting. Do those holes be filled? Assume it is,
> then, I think it's the reason why it's not work for all the pages.
>
> But, after those operations, Will the user get the additional and
> unexpected memory (which is from the huge page filling)?

Yes, more memory is going to be allocated for a process in such THP
collapse case. This is similar to madvise huge pages, and touching the
first byte may allocate 2M.

Pasha
