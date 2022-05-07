Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6DEC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 May 2022 00:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445046AbiEGAS1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 May 2022 20:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiEGAS0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 May 2022 20:18:26 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A7193D5;
        Fri,  6 May 2022 17:14:38 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r27so9747262iot.1;
        Fri, 06 May 2022 17:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYHoqrW62bDSXtF7FVIR7Ce1mBN8BG4H8G3uYkKai+M=;
        b=oqfp3V8h26v18VZIi2Ugg2P0nVNPUi7Aal2Ctl1ZLnK2pYUBxojPPv3lGexF0I+caO
         0kkK7AFdAeMrc8UQeViEh+4tCmHU4NNvblhuqBWhDZj0EdX/51JGAgxsQNY9s3KvSv0J
         Gej1/ktNWNuD26jhXCcDAWBHgmfhhpLXsNKCDBwhtB5neYxy/YInL798GOSRGN2+fHar
         2iBy8mA1rAz0AkzK5lHusLtZQFsF0qXovs3sqHLKJCoVnFvWUSm1TXIm4JZPyx6q3/cx
         l08+TbVNxmBr64wUETW1ma7zxO+DPxJ/nJVGxnebVQklUg2MI9UzSNEwLuOlqiGKQa2o
         lWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYHoqrW62bDSXtF7FVIR7Ce1mBN8BG4H8G3uYkKai+M=;
        b=k/o1WTEkCBvl5V0LQYV2kwQwu847eVbLFIn2vBlqCgDmlqmRLQSHLZuPHCOgYz74aO
         Syg5TG9uqnQcJ/vmVPlJ90f0pZ+lejB8nKJ7ER478zXsJR7EQPKwZkyIYdhUc+Xxzoui
         VLk0dyLWO/UWhFFrxtzWbFqPHrc1fHKB6MD+5X5jAjja3NMwLCjbxIxuWM0QDsqF+jtA
         b22oLdSK/5U27lSfcpGmZSVpWWRoeSNfDbewLLQe0CaN7aFjusZWcxw0orzyUo+ePPdG
         dI/7S/4pofB1m+5UPkFIEtWQhgS6TIaOOoTmTah+MIytfqLj15qH561tcBGcasz72sLT
         zx9A==
X-Gm-Message-State: AOAM531AdQuDaPdcFOn0B+cUysEJIhKQLNH5x+pv4u21P8RCkHRAfv/w
        1lGM0RlUkaTgBolsSb3iw7GdnlVc6YmtBBVO3fY=
X-Google-Smtp-Source: ABdhPJxXr2yP4eX/1ylZ/7D6mybucRQwBj1ZlfFn3LMQWSNvaM6XZ++qu+ySgovKRNTp2eOd3RBDB7gNkk7VX+TkePw=
X-Received: by 2002:a05:6638:2104:b0:326:1e94:efa6 with SMTP id
 n4-20020a056638210400b003261e94efa6mr2620154jaj.234.1651882477804; Fri, 06
 May 2022 17:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220422150507.222488-1-namhyung@kernel.org> <20220422150507.222488-5-namhyung@kernel.org>
 <CAEf4Bzbdh-wbQQLzoXGGKkqqE=+qz19C4tCq4Ynb-_PXzRYM1w@mail.gmail.com>
 <CAM9d7chos3xgxPMOMwgSh6nCNfqk8k2tXO=0JsdL4KgN_yngCA@mail.gmail.com>
 <CAEf4BzZ-RwXV8NoWk4rLyLWyxJhQ6b96ieVCy0kkjLCq8cVxqw@mail.gmail.com> <CAM9d7ciZcsTD7oK5JQA5PJ3gDHcN+Fzon=gVoPvyRb4yLzVF7w@mail.gmail.com>
In-Reply-To: <CAM9d7ciZcsTD7oK5JQA5PJ3gDHcN+Fzon=gVoPvyRb4yLzVF7w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 17:14:27 -0700
Message-ID: <CAEf4Bzb0SHV7O7iDkYg0ad6JQcOii7jdLLHj5NW9dB+H=vD_kw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf record: Handle argument change in sched_switch
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 28, 2022 at 4:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Apr 27, 2022 at 12:26 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Apr 27, 2022 at 11:15 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > Actually I tried something similar but it was with a variable (in bss)
> > > so the verifier in an old kernel rejected it due to invalid arg access.
> > >
> > > I guess now the const makes the verifier ignore the branch as if
> > > it's dead but the compiler still generates the code, right?
> >
> >
> > yes, exactly
>
> Then I'm curious how it'd work on newer kernels.
> The verifier sees the false branch and detects type mismatch
> for the second argument then it'd reject the program?
>

Verifier will know which branch is never taken, and will just ignore
and remove any code in it as dead code.


> Thanks,
> Namhyung
