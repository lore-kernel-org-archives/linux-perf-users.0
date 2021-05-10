Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D1CC433ED
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A33611AB
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 16:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhEJQfC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 May 2021 12:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhEJQex (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 May 2021 12:34:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26747C06175F
        for <linux-perf-users@vger.kernel.org>; Mon, 10 May 2021 09:33:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s82so9553192wmf.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 May 2021 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzsapzwQo1sU7vk4C9wVe0nWjAV2j6bYomVQNz4HZ6o=;
        b=a3Tje2HB5U0LxEiIer9Axrl9nUx26z16do6RZnwmOMPDH1tRxiuF3XF+ooSQNScYl4
         noS7jchno6+selZ+vSze5DkeArY3lI3ZJR/VgUv5yEFUmgfrd6b/qILQcwdCDR5yeGmQ
         oaSdNhEhA94YvjB+SjKpJCNc0s4SEompJ2mjghh7rLnOsF8qAzBR9c4UWIhg/jFoePw6
         VHSQgo0mw/0M1llULFsF9DCvBWwpwdw6pQWQ5JzafR01Ow0k5wqAYC+L25M2EBXshKbK
         5/B8BYAjBjUdG/Ud30REvEsziKdWyyinOskx0qoZG3PAODbdsfMwofPD08aT0VMcG7cO
         O7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzsapzwQo1sU7vk4C9wVe0nWjAV2j6bYomVQNz4HZ6o=;
        b=p40SEtqqk8kYnBVmg17qiET0ycy0CtMIx+Na5cX6JFdbNsiF+RY6GUw6UxGBPXNZpx
         V0uyVk0mhS3kZ8IBb7nkYoGJCz9xjP4iJLKHrjvRWlXHsD2fC6kcY0xqlluCCVyN8FCu
         Roizh2hr76NgV3F5vyZGXQ9XOQ0mhyqg13y1wMeRPapinnLu0Cdtvy2SdtyJS+9NCRL0
         ToTwOkFDumMJoJYNesdBmRRGoFIgotMyTLbOaeMVlSXUOHxuvtk7M54OFKLmkdSebtkm
         ZOv7ta1yUjc1OlgREI/5JX6iNgtf+i1lAGx5GDIxvC9jgx4B7dsUor7makLaoTBwBzqj
         8Fgg==
X-Gm-Message-State: AOAM531BrFEAjO25k81QLGE7vfs6DbXWio3apOHAFXDj5UynXky8ycT5
        20o0dkpWNicYrFE9HeW8QWj9N8jCjWDPjwQ8j8wJiQ==
X-Google-Smtp-Source: ABdhPJyBqiWlS5Tm5D2XOPtY2dsb1DWHUvY+42X1bfmqrG0F/94UluqLtViC1N78Y8pkK9TE4dlTPaVRq8M13iUqpsM=
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr4438wmb.58.1620664425650;
 Mon, 10 May 2021 09:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210504194329.840964-1-irogers@google.com> <CAL_JsqLUxMOF_AhtDj7KuPmBzax-ZejSC76HNOOTr-Pq5fdj7Q@mail.gmail.com>
In-Reply-To: <CAL_JsqLUxMOF_AhtDj7KuPmBzax-ZejSC76HNOOTr-Pq5fdj7Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 May 2021 09:33:33 -0700
Message-ID: <CAP-5=fWfZXS57aQ2Sf+ycmDnvRpUf_oJfkv1sNzVdpY4PVcOdA@mail.gmail.com>
Subject: Re: [PATCH] libperf test: Silence printf flag warning
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 4, 2021 at 6:53 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 4, 2021 at 2:43 PM Ian Rogers <irogers@google.com> wrote:
> >
> > __u64 maybe an unsigned long, it may also differ from the format
> > expected by PRIu64. Add a cast to silence the warning:
> >
> > tools/lib/perf/tests/test-evsel.c:176:33: error: format specifies type 'unsigned long long' but the argument has type 'unsigned long' [-Werror,-Wformat]
> >                 __T_VERBOSE("count = %llu\n", end - start);
> >                                      ~~~~     ^~~~~~~~~~~
> >                                      %lu
>
> Which arch/compiler did you hit this? LLVM? Would have been 64-bit
> presumably. I'm wondering how I didn't...
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/tests/test-evsel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> > index 288b5feaefe2..558097bbbfd0 100644
> > --- a/tools/lib/perf/tests/test-evsel.c
> > +++ b/tools/lib/perf/tests/test-evsel.c
> > @@ -173,7 +173,7 @@ static int test_stat_user_read(int event)
> >
> >                 __T("invalid counter data", (end - start) > last);
> >                 last = end - start;
> > -               __T_VERBOSE("count = %llu\n", end - start);
> > +               __T_VERBOSE("count = %llu\n", (unsigned long long)(end - start));
>
> I think I'd either change end/start to uint64_t which matches the
> count struct and use PRIu64, or change them to unsigned long long.

Thanks! I need to dig into this again, I suspect there was a problem
on PowerPC defining s64/u64 to be long int. Perhaps this is happening
by way of a typedef using int64_t but more likely defining
__SANE_USERSPACE_TYPES__ is my fix. The guidance in the kernel on
formatters is pretty clear:
https://www.kernel.org/doc/Documentation/printk-formats.txt
And so I think it is better to fix the type for overall sanity and to drop this.

Thanks,
Ian


> >         }
> >
> >         perf_evsel__munmap(evsel);
> > --
> > 2.31.1.607.g51e8a6a459-goog
> >
