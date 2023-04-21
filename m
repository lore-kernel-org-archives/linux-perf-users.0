Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC28CC77B61
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Apr 2023 17:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjDURa0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Apr 2023 13:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDURaZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Apr 2023 13:30:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0BE12586
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Apr 2023 10:30:23 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3e0965f70ecso1189441cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Apr 2023 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682098223; x=1684690223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tRKCWMZnTF2ZsvW9MLFJBWNERdB0b58QBR/7LuTpY4=;
        b=ORGIHgHFo0nTEqV0qX3Yyu+MlUR7mqgMPWnmYdaN5DR0gjgMXJzJfq393klj+bJRMQ
         Uw1HLDGOfmQZB7QpIg37YVmm8gsEoG3iq8wgXU5PtX+0AKiHa1rkdEfblhau0vUgI4/6
         /Tn4OfNBMwR1RjqJbjH1e12Y0L3BxkrXNTwbDpnLpWran5mw96eo0wkuj5iOIgu3u9X/
         GbGhnBrDuBc7Al4n6EexwIlP/VGNZTzs9sJkg7j0WziPYGF0eCZnaJ6zVJmIRnEHNy5q
         en0gutEsKytmt9BIwUxlOWmPnQ0oitKhPmbMt80Ph+vTobpMCRbS9qVSl8qVJfV6hU+l
         KHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098223; x=1684690223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tRKCWMZnTF2ZsvW9MLFJBWNERdB0b58QBR/7LuTpY4=;
        b=ZEpVUE1V1UZhJFf0PL6pfQWNPGPSyfyD02Df+0SvvlXQu2x7NPrYm5Mom0hfQLXZFD
         Ni9rWc+k15Tc+/ruP/ooC1zON0XXhyJOAxhA7GhbMNiZw92uP6LZa2m0rZwSt7TO5Tnp
         RZFYUnecrPseq8USQH73/sqUH/mOYd0cNR17/OVVDG0w4XQlIdKl0Zk4q8LvIrEZfRb2
         KuTNrpXFnAtpyECCDtw7r1gTaIxHuS7zRY3TsvUy4nhgraIiJVOzV4LZ+JMonfBD8Vb4
         DfqnAyWO4fX5aVj9vJG0BJLGq7VTElpqj/Eh5qqttMAXL+UokQnvEkBlRCzJ/hBRCyFD
         BZrg==
X-Gm-Message-State: AAQBX9c/3XaW95vyY8Nc1auaqUIvkpj0K7oDBoyBTUpy/Ss+BmlSS4ep
        +YOIai0kl5KjimCxs9B+oxf5vDth963foYEAIZHN/A==
X-Google-Smtp-Source: AKy350YEDa+B6f5e3vrr/0omQSA5LXhpOu02+rAUkZVhJbQQISmPin/ZiWT+TbCXcVJ7wpSVEILnk3rJcUxYIn8QtDU=
X-Received: by 2002:a05:622a:189a:b0:3df:6cbb:c76 with SMTP id
 v26-20020a05622a189a00b003df6cbb0c76mr338522qtc.13.1682098222812; Fri, 21 Apr
 2023 10:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
 <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com> <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com> <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com> <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
 <2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com> <CAP-5=fU9WeBga_tQKi6QKX1-t=C1w5CoPc8Rn9myR=1CxeQuMg@mail.gmail.com>
 <46508ba1-6bd5-a28e-5ae8-bc69a679b2c5@linux.intel.com> <CAP-5=fWeBN0gzCzk3_gh=bd_H+q5B+1KqofG5q-JGTaFk7akog@mail.gmail.com>
 <7836c3c0-75bb-7c66-d6b1-ee6ff1201117@linux.intel.com> <CAP-5=fVnuQ08zUg8XxFhT-oddRd9PC8GPu6q-FU-_H0QLqO91w@mail.gmail.com>
 <c48515e6-6ba1-2c8e-7f84-869e227c5089@linux.intel.com>
In-Reply-To: <c48515e6-6ba1-2c8e-7f84-869e227c5089@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 21 Apr 2023 10:30:09 -0700
Message-ID: <CAP-5=fVOfEOLuvrrJKydaPNwaMgZ5-tykUzZDdD0oLiUGdDe6w@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Apr 21, 2023 at 10:11=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-04-21 11:49 a.m., Ian Rogers wrote:
> >> Can we take a step back? Create a perf/json_metric or whatever branch,
> >> fix all the issues thoroughly, and then merge to the mainline.
> >>
> >> I think the default of perf stat is frequently used by not only the
> >> newbees but also the veterans. That could have a big user-visible impa=
ct.
> >>
> >> The 6.4 merge window is approaching. Can we at least revert the patche=
s
> >> for 6.4?
> >>
> >> Arnaldo, what do you think?
> > Revert is a complete no go, we'd be reintroducing the bugs that are
> > fixed and who will then fix those? How will they be fixed in any way
> > other than how they've already been fixed? I've yet to see a
> > description of a bug that isn't either:
> > 1) an issue because the output formatting changed - the fix here is to
> > use CSV or json output, using the hard coded metrics was a bug here
> > anyway, not least as the metrics are wrong,
> > 2) a pre-existing issue, such as hybrid is broken,
> > 3) a non-issue, such as multiplexing on Skylake.
> > That's not to say everything couldn't run better, which was the issue
> > this patch was looking to address.
>
> Sigh, we really need a clear design and definition regarding the default
> of perf stat, especially what is included, what's the expected layout,
> the forbidden. So everyone from the developers to the users is on the
> same page. Could you please update the document for the default of perf
> stat?
>
>
> One more thing I want to point out is that the json metric may keep
> changing. While the kernel metics (only includes the core part of the
> json metric) is quite stable. For the default of perf stat, the kernel
> metics should be a better choice.
>
>
> Clarification: I'm not looking for reverting all the patches of the json
> metrics in the perf-tool-next branch. The request is to revert the
> patches which impact the default of perf stat. More specifically, the
> patch 39 and 41.
> https://lore.kernel.org/lkml/20230219092848.639226-40-irogers@google.com/

This is silly. You can't just revert those patches. The removal of the
hard coded logic was so that it didn't need to get ported when the
later patches removed saved values. You are asking for a far bigger
revert.

Thanks,
Ian

> This is really a long discussion. I think we all express the arguments
> clearly. Let's make the final decision and stop here.
>
> Arnaldo? Peter? Ingo?
>
> Could you please share your opinions?
>
> Thanks,
> Kan
