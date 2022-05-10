Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8799C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 May 2022 18:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbiEJSRH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 May 2022 14:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiEJSRF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 May 2022 14:17:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BF587A07
        for <linux-perf-users@vger.kernel.org>; Tue, 10 May 2022 11:13:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq30so30746505lfb.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 May 2022 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+mhbUG8PMDB8QXSseDQwzEe01Khv6i9dx48j8lmtdY=;
        b=VYL9j4eEhQi+y5jroNsekGGDgbHvK7gBY2RS5tr5c3cJkqy9ODxmTeYuY3+r+6f8/w
         eafQ2ivjlBXqswOgGzsGHGnflJnHCXk3DUJMiGvX2AW+dbAUMsHyo+1VoZZJUPQNXS9W
         PogVEThUknDYF9kmc6Y8HnbQ3tpVTPWtTLbvyYXW3hWpfiTorKr+RS2FV0Z+nk2FQpVV
         dolMATi5dThlZtLi4gGg1BWjYI7oPdCzQ9+mD4sz0cASszscxWcHjbRqiYFIvtFbGYpp
         49Q8bkQlaIg9iDlJ1nstNphpmoJDXr0RNyQogChGWb1MEbN4vxyT/KvgRcXWjO/U8aqp
         04UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+mhbUG8PMDB8QXSseDQwzEe01Khv6i9dx48j8lmtdY=;
        b=AoV12c8qtW4jbOj3lbeyanZTOAiKHuD8kxUugsLlRsIrnIC1x/ozIeKKuVEX6kohkc
         IEO3DLzgdDCt0mu6FyOj7q7dsTJgVkVmDjIfFqAgFjE9LS0OCIcdXbwEVRX9Kc7lzGGa
         XZMQz9B4JgZRdlTtTdUg733/KtNMygqv/ZUubELzx9bCY/hz0oupvTGxsarRnpjCbbpi
         bM6QkrVmDnrjvfSVriBL6z7p/oAKX9hN876oYvBzUnN89ptlBu3UvIlZy8Tqkx8dj942
         uflD8I9HRkcP/QRgyNbBWVyA+lkevncqcCE1gbAygGd/ormn8ddhYkeJrvUGc+gOx0kX
         b1XQ==
X-Gm-Message-State: AOAM530sGawgwP1oqlk5Cpk4e56DNorznleeVRR/jR6wjWfewLkCALy7
        OYAS0z0Nd8tlh/lVQo+4P7WQLpbJO/gKL3ODEpoHTg==
X-Google-Smtp-Source: ABdhPJzflSbkOIVfh3BfhcfU3qBsFSUkT8A9ZRNLjuHTUKPrO6sSQhGwP4fCX9UKcjPngmjO5g8FetAXbFrAFELGW1Q=
X-Received: by 2002:a05:6512:1048:b0:473:c648:c5c3 with SMTP id
 c8-20020a056512104800b00473c648c5c3mr17114682lfb.487.1652206384534; Tue, 10
 May 2022 11:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220503213704.2524229-1-blakejones@google.com> <YnqW68rLssWA8uba@kernel.org>
In-Reply-To: <YnqW68rLssWA8uba@kernel.org>
From:   Blake Jones <blakejones@google.com>
Date:   Tue, 10 May 2022 11:12:53 -0700
Message-ID: <CAP_z_CjM=xdogE7YMhwPj25rG7cvK6=TS_0O_bJ22+SgW6pxhQ@mail.gmail.com>
Subject: Re: [PATCH] Add an "-m" option to "perf buildid-list".
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks for taking a look at this!

On Tue, May 10, 2022 at 9:46 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Tue, May 03, 2022 at 02:37:04PM -0700, Blake Jones escreveu:
> > +-m::
> > +--modules::
> > +     Show buildid, start/end text address, and path of kernel and modules.
>
> Hi,
>
>         Wouldn't it be better to have -m show just modules, name +
> buildid, then have -v show more verbose info, i.e. the start, end and
> switch from just the module name to its full path?
>
>         Then to get what your patch produces now one would use:
>
>         $ perf buildid-list -kmv
>
>         That would be more flexible, wdyt?

I'm open to using "-v" like this if you think it would be useful; is
there a use case you have in mind for the non-verbose mode? For doing
external symbolization of stack traces, the BuildID isn't useful without
also knowing the starting and ending addresses.

If "-m" only showed information about modules and not about the kernel,
then "perf buildid-list -km" (without "-v") would have different output
formats for the kernel and for the modules. So I'm inclined to have "-m"
include information about the kernel as well as the modules.

How does that sound?

Blake
