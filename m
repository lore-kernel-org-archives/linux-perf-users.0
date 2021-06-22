Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36312C48BDF
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182C56100B
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 16:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFVQDC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFVQDB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 12:03:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D7C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jun 2021 09:00:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so1849880wmf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jun 2021 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOMZk1VKxvEsQe+425mKGnLA46HeEVTGsHHfQ5TUmdo=;
        b=qf/fz46NPHaWfKJ5ojds9u2NYgfXiZNcmgkC6EINZuigVXaowBRq1Dfsr1lBSTZt3U
         eTRLvyjvjY5NBjK22ij1enha6oBN4bnvaf+I+8mNNhaKmcHek0wFDkTGmVJN2fM/9nPg
         yLnit/yU1sLblVKOht0L0ue5wrmmskduEtGR1NJzGEmMOE2C1nlAE6I/KRvMXDLL5uop
         mb3fwBNpowalE9b+Ui5rp0f5CnEisk8vb9/tJq+oQX8sFoSS3xK3vgaJEGDTZEtE4ABo
         zAxAI2ERqMj2e7WP3M9btYT0qVrk6AFOWnft9hmXilMET2N+KDozNSLMzpCcjJJMOWrN
         8twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOMZk1VKxvEsQe+425mKGnLA46HeEVTGsHHfQ5TUmdo=;
        b=IJcCPSojKyHjDQ6iObP2moiIJ/BWZ7BmRxCJ5cJI2YAUsnbtK8vZ9VcAL9zhzYTE0K
         Gcc1O33Cbujv6a4SI+E0m36+csKOrDbrVqhjWVyYqGHqjJtpRK8k492xZ1NlRYqGw9ci
         e0zovLfBs2F3hywSNvDEM4YSV7Y1GLsP7Kte7Pv7L/LjsMVtygq91cR00Sijx8lXA+MN
         GLIbfQlmbwVkqLokU6JI9WtDKa3htC6Qt86CAKJofEEF0mGeK9XV/1bldCllxna1Vhjk
         PbvDMC6tW6dXU1aCNfaRBNbnMIooA2bWOkam613UOE1TtjmQazX9oimaP1cH0FlOH2IL
         Jm3A==
X-Gm-Message-State: AOAM533QSuxLMl6ACMEEZx4f98JFE9b1dkZovxSGPDX+TYh5CSZXeAdV
        8qpPcmifE6lGMr3tht9a4C91kHHnj60X3qT5rWXp+Q==
X-Google-Smtp-Source: ABdhPJzSoujWiRAvyGIwEgL3UvR+fnBtxVS+HiJRtZsgofK9RRT0hDyY9RXFGnx6uEwTGNXL5kYwR8bY6o4aPKWadd4=
X-Received: by 2002:a05:600c:2484:: with SMTP id 4mr5336575wms.76.1624377643601;
 Tue, 22 Jun 2021 09:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <ecd941b3-2fd5-61d8-93a1-76a3a3ee4138@huawei.com>
 <CAP-5=fUxQZ+rxLEn6jeRNVMf48BaPNdaUdoMs8LY4P-GROiOnw@mail.gmail.com> <cd501541-deb5-f2f5-e086-cca44b40c87d@huawei.com>
In-Reply-To: <cd501541-deb5-f2f5-e086-cca44b40c87d@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Jun 2021 09:00:31 -0700
Message-ID: <CAP-5=fU05k62d57pbWquqv3Z1RFzWMOB1d3OFEcEax5btEWEzg@mail.gmail.com>
Subject: Re: perf tool: About tests debug level
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 22, 2021 at 4:58 AM John Garry <john.garry@huawei.com> wrote:
>
> On 22/06/2021 06:04, Ian Rogers wrote:
> >> ---- end ----
> >> Parse and process metrics: FAILED!
> >>
> >> Note that the "FAILED" messages from the test code come from pr_debug().
> >>
> >> In a way, I feel that pr_debug()/err from the test is more important
> >> than pr_debug() from the core code (when running a test).
> >>
> >> Any opinion on this or how to improve (if anyone agrees with me)? Or am
> >> I missing something? Or is it not so important?
> > Hi John,
> >
>
> Hi Ian,
>
> > I think the issue is that in the parsing you don't know it's broken
> > until something goes wrong. Putting everything on pr_err would cause
> > spam in the not broken case.
>
> Right, I would not suggest using pr_err everywhere.
>
> > Improving the parsing error handling is a
> > big task with lex and yacc to some extent getting in the way. Perhaps
> > a middle way is to have a parameter to the parser that logs more, and
> > recursively call this in the parser when parsing fails. I guess there
> > is also a danger of a performance hit.
>
> So I am thinking that for running a test, -v means different levels logs
> for test code and for core (non-test code). For example, -v prints
> pr_warn() and higher for test logs, but nothing for core logs. And then
> -vv for running a test gives pr_debug and above for test logs, and
> pr_warn and above for core logs. Or something like that.
>
> Maybe that is not a good idea. But I'm just saying that it's hard to
> debug currently at -v for tests.
>
> Thanks,
> John

I think this sounds good. It'd be nice also to have verbose output in
the shell tests following the same convention. There's currently no
verbose logging in shell tests but I propose it here:
https://lore.kernel.org/lkml/20210621215648.2991319-1-irogers@google.com/
By their nature some of the shell tests launch perf, perhaps there can
be some convention on passing the verbose flag through in those cases.

Thanks,
Ian
