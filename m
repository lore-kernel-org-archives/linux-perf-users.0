Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6FDC07E94
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 15:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06940613AC
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 15:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhFDPSb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFDPSa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 11:18:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3364DC061766;
        Fri,  4 Jun 2021 08:16:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i13so11583055edb.9;
        Fri, 04 Jun 2021 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5INap2zzP9s4qR7EyrIKGSEeGROkQc8vXzeQAKJYVgg=;
        b=VezwnZdZDzyEBaJUjcW2YQnMa3HOaOGc5wcJ7xFdf8/3ST7ZjCoCApYvcqDdaVJEhy
         ckYzvwW7ZmcFFJGez2VKzhgjM9oOuOn7dD/Rrp3O1JkQoKwW1s4bINbvHsYk6t9XZjXb
         pWqP2BSZLQKK19JxHK5oBaB36q/dR6axpWjtnBYMnGWGkYpCvurr2XmOv1mQN4n/GJt8
         fJVNc8P4i5RqKsbCMbIkOgaQVB2SFgk637z24VsLKSulhISLO2vpY7M7G41rqR5ddh3q
         VpZ9kyVmhYGoqKLRDpdivtOpKbdwesxUjP8NqVPhxvBKGpD24sNeI0lG6S1jSTpqBDM3
         8wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5INap2zzP9s4qR7EyrIKGSEeGROkQc8vXzeQAKJYVgg=;
        b=sJdljyg2Wuuxtm+c4eO1YmsTC5beOXx+xFXu2ub094PUiQx83Fc3egq7p9bvIik9kV
         FsaTZL0/PsFa79Kt18MKR1D55hTxIn0YKIkxVx52gV7JWyLA8/XQxplXLWXG++TN+DP7
         lrkdHbgyzuFOJd0WSrPiv6pyU4FbDXPll+LnhKdsGXmTiYqPI1Xt1yn7RBQASnQ6lhLe
         Sx6F346nikWGqJYxJtrslm1WtkYmkLmisA19YAW8d1eg2KUPNN23ZhA2nKRvxszX/q79
         FtMsx8ggHbI4MrH/kvkFjkwqPtrdIEoAXQQYkKBpsaDSbXw6pf6wOvY3zVCzS0iJ+Iq3
         suxg==
X-Gm-Message-State: AOAM530TfvkiOLtFi3jZW7fufGxbtHITQllLzVEvy6QEuCnrhRz/et+8
        5dVgdjpnBpDUjv/+Mm8tT0w=
X-Google-Smtp-Source: ABdhPJynYpoT3gWvjQ7I7dsrOJg2RYthDMHp+mnoqLaGCib1yGeskAqEh2ZYn7Y9tTBfO1bBasX5lQ==
X-Received: by 2002:a50:afa3:: with SMTP id h32mr5197925edd.202.1622819802650;
        Fri, 04 Jun 2021 08:16:42 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.179.73])
        by smtp.gmail.com with ESMTPSA id u15sm3484268edy.29.2021.06.04.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:16:41 -0700 (PDT)
Message-ID: <3b8c7c2c5de492c7fbf86df73c43cdb0fbb453df.camel@gmail.com>
Subject: Re: [PATCH] perf ksymbol: fix memory leak: decrease refcount of map
 and dso
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Jun 2021 17:16:39 +0200
In-Reply-To: <YLopMBgLWysdJbkm@kernel.org>
References: <20210602231052.317048-1-rickyman7@gmail.com>
         <CAP-5=fVxHUnwGoRypMjCsPSh_yo5PB8Hzbkx5ArA5b0=7S-67g@mail.gmail.com>
         <YLopMBgLWysdJbkm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Fri, 2021-06-04 at 10:22 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 03, 2021 at 09:26:40PM -0700, Ian Rogers escreveu:
> > On Wed, Jun 2, 2021 at 4:15 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > > +++ b/tools/perf/util/machine.c
> > > @@ -776,6 +776,7 @@ static int machine__process_ksymbol_register(struct
> > > machine *machine,
> > >                 if (dso) {
> > >                         dso->kernel = DSO_SPACE__KERNEL;
> > >                         map = map__new2(0, dso);
> > > +                       dso__put(dso);
> 
> > Will this cause 2 puts if the map allocation fails? Perhaps this
> > should be "if (map) dso__put(dso);".
> 
> I think its just a matter of removing the put in the error path, i.e.
> the patch becomes what is at the end of this message.
> 
> I.e. if map__new2() fails, we want to drop the dso reference, and if it
> works, we already have a reference to it, obtained in map__new2().

Agree.
I'm sorry for this stupid oversight.
Should we make it a series including the fix to the issue you pointed out below,
or should I send you a v2 and fix the other issue in a subsequent patch?

> But looking at this code now I realize that maps__find() should grab a
> refcount for the map it returns, because in this
> machine__process_ksymbol_register() function we use reference that 'map'
> after the if block, i.e. we use it if it came from maps__find() or if we
> created it machine__process_ksymbol_register, so there is a possible
> race where other thread removes it from the list and map__put()s it
> ending up in map__delete() while we still use it in
> machine__process_ksymbol_register(), right?

Agree. It should be placed before up_read to avoid races, right?
Then we would need to see where it's called and add the appropriate map__put.

In addition, having a look at other possible concurrency issues in map.c:
 - maps__for_each_entry should always be called with either read or write lock,
am I right? It looks like this is not done in certain parts of the code. If such
lock is taken, then grabbing the refcount on the looping variable is not needed
unless we need to return it, right?
 - maps__first and map__next do not grab a refcount and neither a lock. If
they're used through a lock-protected loop, it's not a problem, but maybe it's
worth making explicit that they are not to be used directly (through either a
comment or adding some underscores in their names).
 - maps__empty: should probably take a reader lock.
 - maps__find_symbol: the returned symbol is not protected (the caller does not
receive a refcount to neither map or dso, so if dso is deleted, his reference to
the symbol gets invalidated). Depending on how it's being used it might not be a
problem, but in the general scenario I think it's not thread-safe.

Riccardo


> 
> - Arnaldo
> 
> > >                 }
> 
> > >                 if (!dso || !map) {
> > > @@ -792,6 +793,7 @@ static int machine__process_ksymbol_register(struct
> > > machine *machine,
> > >                 map->start = event->ksymbol.addr;
> > >                 map->end = map->start + event->ksymbol.len;
> > >                 maps__insert(&machine->kmaps, map);
> > > +               map__put(map);
> > >                 dso__set_loaded(dso);
> 
> > >                 if (is_bpf_image(event->ksymbol.name)) {
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3ff4936a15a42f74..da19be7da284c250 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -776,10 +776,10 @@ static int machine__process_ksymbol_register(struct
> machine *machine,
>                 if (dso) {
>                         dso->kernel = DSO_SPACE__KERNEL;
>                         map = map__new2(0, dso);
> +                       dso__put(dso);
>                 }
>  
>                 if (!dso || !map) {
> -                       dso__put(dso);
>                         return -ENOMEM;
>                 }
>  
> @@ -792,6 +792,7 @@ static int machine__process_ksymbol_register(struct
> machine *machine,
>                 map->start = event->ksymbol.addr;
>                 map->end = map->start + event->ksymbol.len;
>                 maps__insert(&machine->kmaps, map);
> +               map__put(map);
>                 dso__set_loaded(dso);
>  
>                 if (is_bpf_image(event->ksymbol.name)) {


