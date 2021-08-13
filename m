Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE237C43214
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 20:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1989610FA
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 20:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhHMURt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Aug 2021 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhHMURs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Aug 2021 16:17:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328CBC061756
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Aug 2021 13:17:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g30so22000978lfv.4
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Aug 2021 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFV5lmVN+JD08JpsLHuW/g9a9aLzMuIjyvYEJ1TJkEE=;
        b=j7uHAAwVagEhjIQfAEgVKt4UKiNyCnssnj/SNuUT329+DGFnIt6yCSq8ozr8erC0rS
         4GyRceTxDH8qO8sNYeKT+WZV+SE+m4X2UCzI9l/m0/F4FBhTOxsznVi86ovhBa1OMDRn
         jHRLq7nJl/LAFDXvqlxic0IdHd+hd1Mj/5Af6Sv9ce9eeH+O5WhuuVB8wA8JvF8lwogB
         xLowwuoNchcoQshChqWwr9aZ5bA1/0EJ29oE/TKdsWaU2nShSp/tfIDNUhIZ32TZ30HR
         0icMnstEpn3IVzgT8SnhPYHOTEQYR4abF2ZLW5zUi1zPyFUBFqtx0qG25EAIc080eYv8
         Am3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFV5lmVN+JD08JpsLHuW/g9a9aLzMuIjyvYEJ1TJkEE=;
        b=SpXKvl5rDzObYlMIeqoW+0PZPKDa2883tX2Mar0j3ftN6PevXmX7f/ZUUTy4uFiA+e
         bhrlR8M6LzlWZh8+5Uh/G+lWoMv6H1+JRU2P2zPaIGClgzifI9En44rg+5t0uR9jD4IX
         Uj309CTaIyucENKAcQb2ugjOzCh+MlyPTEM0p/vAmGWu1RTP/nUhp342/2xohNqj9rcg
         5T41TlGBNVCLkHtl5IMkViQXfz4Oo7e1MvhMjgOxUUNPx49CgZ7tVDpe46cEZJyqoHHc
         eWI2ZsAcLPwbGTeEfxYY3BAONekJ3BIvKlAyQMzlLMZJVBXiM13Y+Hs2VJD/W5OiXRpm
         BokQ==
X-Gm-Message-State: AOAM532lnf9EJOZn7WiSK3KMLFQWbrtv+YBbeDULIILvqqRJCI6YpZnk
        P9gv7Az8vpRKQgQxgu8ujR+gxv2hGkH0m363bv8HbA==
X-Google-Smtp-Source: ABdhPJwwvdMMPK6x8sK+8U8N0u9tL75R5rFPakH+Z3Gp5EZkBrwGd31/IG7GW0Fv4b5+BeSGUSiJFZI+NiHA4xhaV8s=
X-Received: by 2002:a19:e00a:: with SMTP id x10mr2996893lfg.536.1628885838324;
 Fri, 13 Aug 2021 13:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fUV-Tbo+X-myLZ2z8hpjBbHUrgLN6wq9z_wsykyXgxp+g@mail.gmail.com>
 <CAA4y5iAnwnubx1hSxrfopPajqNnyH+UWWUvMZJqsiyy=L3sx-w@mail.gmail.com> <CAGq6xJ4oo2WM2j58vkMayp_FikLEEJ7pK+oMcp=85aPGdEaFGg@mail.gmail.com>
In-Reply-To: <CAGq6xJ4oo2WM2j58vkMayp_FikLEEJ7pK+oMcp=85aPGdEaFGg@mail.gmail.com>
From:   Namhyung Kim <namhyung@google.com>
Date:   Fri, 13 Aug 2021 13:17:06 -0700
Message-ID: <CAA4y5iARtvPfLEQ+UcrNMQwpwxXr56Of6U7ApiOqffHf8OCYWw@mail.gmail.com>
Subject: Re: perf report sort
To:     Arnaldo Melo <acme@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

+ LKML and linux-perf-users

On Thu, Aug 12, 2021 at 5:20 PM Arnaldo Melo <acme@redhat.com> wrote:
>
> On Thu, Aug 12, 2021 at 4:15 PM Namhyung Kim <namhyung@google.com> wrote:
>>
>> Hi Ian,
>>
>> On Wed, Aug 11, 2021 at 12:01 AM Ian Rogers <irogers@google.com> wrote:
>> > My suspicion is that page_fault and _dl_relocate_object have identical
>> > numbers of samples (5.56%) but sorting by the symbol (in sort_order)
>> > should solve this. I suspect providing a sort order in the test will
>> > make it robust, but I'm confused looking at the builtin-report code as
>> > it reads that this should already happen. I wondered if you had any
>> > suggestions?
>>
>> So actually the sort key doesn't sort the output. :(
>> It should be called 'group-by' rather than sort.
>
>
> I think there is value in changing this behaviour to match what Ian expected, don't you think?
>
> And also I think we should start doing this not via command line options, but via .perfconfig settings.
>
> And perhaps we can mark these kinds of settings as .perfconfig-only ones.
>
> This way we can have a 'perf config' mode that extracts these settings to share with others, or keep
> per-organization defaults.
>
> The range of preferences is huge, it is really difficult to find sane defaults that please everybody, so we probably should try to help facilitate per-community defaults.
>
> wdyt?

I agree that it's confusing especially with -F/--fields option.
If users want to change the behavior to be a real sort key
they probably need to use -F too.

Not sure what's the best way to handle it.  But by providing
the config option, I guess users should be aware of the
change and use appropriate options.

>
> - Arnaldo
>
> P.S.: This discussion should really have happened in the open, please consider replying to this CCing linux-perf-users & linux-kernel while keeping as-is this response :-)

Yep, Cc-ed.

Thanks,
Namhyung


>
>>
>> The output is sorted by the overhead (= period) by default.
>>
>> There is -F/--fields option to control which fields are displayed.
>> When it's used, the -s option will behave as (real) sort keys.
>> In fact, 'perf report' (using the default sort key) is same as
>>
>>   perf report -F overhead,comm,dso,sym -s overhead
>>
>> If you want to sort the output by symbol name,
>>
>>   perf report -F overhead,comm,dso,sym -s sym
>>
>> Maybe we need to change the test like above.
>>
>> Thanks,
>> Namhyung
>>
