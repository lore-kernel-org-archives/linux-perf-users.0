Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C91C05027
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Feb 2023 16:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBNQbK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Feb 2023 11:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBNQbJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Feb 2023 11:31:09 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5555B9F
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 08:31:03 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id ow4so6352816qkn.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DeKrFVj5RLu1KKnNTVCusgp5T0P1wsNltnH7kGalgo8=;
        b=lTQvvwCTQaIPkgC4gnl5/hjKykULn4Egld4GWcEFMZ5GSFB7wzUHzwatF1UsxgmIBf
         Q5L6KF6EAIjWy6lD9/0VT22Z4TtKiNNeST78ktjPDgN2LLePJQRvhVDC1juULo45oYs6
         DIDhkOM/iYfIQtqcUytpx5/hzlrc62TtNADKfcal3v4gXHZ+K/Cl8YptRnp96r3ykb6m
         HQKKqnoOuaJSH/HMuxkIN4YG/ulb9k2pxtXZ4IzlKB6RX5/muq6WBdeQMNrSexeB2O8V
         bCXUt83hwneHXMKOuup0hNUYUA4Y9MUCprj61gZqjf3zltCdVO8ewwOuKRkwy0VkL7U+
         +xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeKrFVj5RLu1KKnNTVCusgp5T0P1wsNltnH7kGalgo8=;
        b=dL9AO5V+shdNjbFS0t5dARB6r4Cmi9klD/pzYFxe+kZWYEKWe+5MWLzQc30whxVY+Q
         Qq0Uph7nswgU+go1InhslNJoiqqSjjIdP9Ntg42aVeodEFtPqDMfi0Tf1ZSlyAFScCQR
         hX9NIbrZRBpcyFFARzi2UoJmtuZFkDgBXYsGOPnpWXHgkHefi+BlWqSdkHCgsvQVXKPH
         8k7B4LedrwGs7tYfRw2qBj1NKUUUkkQudAKmVnjoNtCmrE1urRMss4z7IMk/4YVPh56H
         e8jX36FUgpBiM2UKx80zDFeeLW0JOK5oQS5mrnGYNVAesKM8L2xx6Y+njEu0Mb16YcRU
         iOHQ==
X-Gm-Message-State: AO0yUKW0s+DyFh6rOBg0z8If5armpztyhafzOBYCD4JpyQNVIYH9uHgd
        yjxbXw/JG1yL7efmLEW8scdXJS5JSU9cuKiZqQIoSA==
X-Google-Smtp-Source: AK7set/L+qy5uWlxvBUp/FcipQgFAAkwrRaoGi3X/CTT2//GFz/QnqteBkgrL4rwfaRCkEkiLcVtj6hsQmZEOseBQR4=
X-Received: by 2002:a05:620a:cc1:b0:720:6045:25ea with SMTP id
 b1-20020a05620a0cc100b00720604525eamr194899qkj.27.1676392262801; Tue, 14 Feb
 2023 08:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20230207035139.272707-1-shiyn.lin@gmail.com> <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop> <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
 <Y+uv3iTajGoOuNMO@strix-laptop>
In-Reply-To: <Y+uv3iTajGoOuNMO@strix-laptop>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 14 Feb 2023 11:30:26 -0500
Message-ID: <CA+CK2bCKOONeipaYNQJSPTicej1DW0OWvw97r0TbG7oRtxVGnQ@mail.gmail.com>
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

> > The thing with THP is, that during fork(), we always allocate a backup PTE
> > table, to be able to PTE-map the THP whenever we have to. Otherwise we'd
> > have to eventually fail some operations we don't want to fail -- similar to
> > the case where break_cow_pte() could fail now due to -ENOMEM although we
> > really don't want to fail (e.g., change_pte_range() ).
> >
> > I always considered that wasteful, because in many scenarios, we'll never
> > ever split a THP and possibly waste memory.
> >
> > Optimizing that for THP (e.g., don't always allocate backup THP, have some
> > global allocation backup pool for splits + refill when close-to-empty) might
> > provide similar fork() improvements, both in speed and memory consumption
> > when it comes to anonymous memory.
>
> When collapsing huge pages, do/can they reuse those PTEs for backup?
> So, we don't have to allocate the PTE or maintain the pool.

It might not work for all pages, as collapsing pages might have had
holes in the user page table, and there were no PTE tables.
Pasha
