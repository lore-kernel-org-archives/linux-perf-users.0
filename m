Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CFFC43334
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Jul 2022 15:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiGAPRM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 1 Jul 2022 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiGAPRJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Jul 2022 11:17:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9988C30F53
        for <linux-perf-users@vger.kernel.org>; Fri,  1 Jul 2022 08:17:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so3648753wrc.12
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Jul 2022 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMI/XAvmNko62zI8fR7xDBUzGEYZuQGMwppHrobM2Is=;
        b=oWX6VMkvLKmdW/9AlOxqt7UN5ZjMxvJ9LXnTB0W79b4TrcLC76M8Ty5JcwoHGkyFjc
         Ewdp5ce79ofLluNSBfpG/PaMZCKJxAN4x6E6x0ezwFlCsNQaZd8YlxnUmjx9BLvNH7HI
         GcCy2lsk2hpTUm5IFEJEZd0w9F7QAmtmphJTyWKM0fH1zFhlBSgM1+n74pT48wm8d4sU
         c4Z0rhQ7nMFPpD4GwS4zGjKjSo4v1Wb2QLdokKJZv3eOmkcrJkCBb8p1McPuyaptor7Z
         49KbI6rLcfyxqsjW/I7iY2XNikbIWWFS8hQ+Lj2LKElttsdEKAZ2X3A/N7y8W4ClukC4
         fWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMI/XAvmNko62zI8fR7xDBUzGEYZuQGMwppHrobM2Is=;
        b=E4WBqaGyEnfyA5HnPo1vMdyESgJLYHNCOQYbHU20T7+6+t9RHtQvw5e3jroJaE3Hau
         KRKQd4+6q8HLmY82xCR5mrYPdO+xjEWmlnkqMdzS6EcALbMYJqQM+wt9aaew+raagO1z
         MiCsyRsBxLV4CCF0T8czRg+ATSNmEh2glURc/lazYmxV5nMprbYQdlyCfUtMcqyCASVZ
         1VvQf9YwWhens2oBFOglHYpp/kk1xT7pTqKRE9F4F0JTB8LGHWW4By1wUClkYIO6wlC1
         ej3hC8uJsqs6emMviHzKkI7GR8M2oySQsD4xYzwscB5uvnf4DcV3J6/jtjp0+Kvi7Tdi
         +hIg==
X-Gm-Message-State: AJIora/4rMq/C/vKcwrvUiO8Bs/6F5SOUmaFTl1Sm0Jfpc4d7R9lK2HK
        HxvmU3Z8a2Z7xty/0loYdajvJDhhthD4XupjpQA6QA==
X-Google-Smtp-Source: AGRyM1tGdDWBegVkpV4Moi/BOVD8mnBFBtbY4t/nuGv2lIH4gznInl9qyg5ucQ5RCYpPDubZq1Eojl2qbsW+695TTqU=
X-Received: by 2002:a5d:5983:0:b0:21b:b7cb:f84e with SMTP id
 n3-20020a5d5983000000b0021bb7cbf84emr14645409wri.654.1656688625975; Fri, 01
 Jul 2022 08:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220629034007.332804-1-irogers@google.com> <Yr1ozmP2E8Fer11e@worktop.programming.kicks-ass.net>
 <CAP-5=fXRxvSB9WrcTEM+2rnALuzPBdPz=v+WGhvN_SS2Ba2MTw@mail.gmail.com> <Yr62go3Zx1ydlxpg@worktop.programming.kicks-ass.net>
In-Reply-To: <Yr62go3Zx1ydlxpg@worktop.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 Jul 2022 08:16:53 -0700
Message-ID: <CAP-5=fXdqr1F9Mm_0-OMCcvAWxTAChqfM91QAOkE4Dg9foTp6Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip for paranoid 3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 1, 2022 at 1:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 30, 2022 at 01:59:54PM -0700, Ian Rogers wrote:
> > On Thu, Jun 30, 2022 at 2:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 08:40:07PM -0700, Ian Rogers wrote:
> > > > Add skip tests for paranoid level being 3.
> > > > Rather than skipping lines starting "Failed", skip lines containing
> > > > "failed" - making the behavior consistent with the previous python
> > > > version.
> > >
> > > paranoid 3 is an out of tree patch.
> >
> > Thanks, what is the right way to resolve this? My desktop appears to
> > be carrying the patch and I'd like the tests to be as green as
> > possible.
>
> Then you desktop is probably running a Debian or derivative distro
> kernel. You can run your own kernel, or ask the Debian team to ditch
> their hack and use the LSM hooks to further limit perf usage if they
> feel this is required.
>
> The big advantage of the LSM hooks is that they can explicitly
> white-list the perf binary while dis-allowing random users access to the
> syscall. That way perf will still work but the possible exploit
> potential is much reduced.

Thanks, neither rewriting Debian's security to use LSM or running a
custom kernel are going to work in the environment I have. Presumably
it is going to be a matter of policy not to allow this test fix to
land, meaning Debian kernels are going to show failing tests? I can
carry the patch privately but that's a tech-debt, merge-conflict mess.

Thanks,
Ian
