Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79931C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 17:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357912AbiDLRDD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357913AbiDLRDC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 13:03:02 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8A45C661
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 10:00:45 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id f32so1057312vsv.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yIA2wn+QaOwYDvrtCgKX2Tj4JIOiiRe8uNAwOXX5jg=;
        b=Ca3+HpKVZ75dCJijo4u2b2bGKkNL68V+dQi3oyENza4SfipURczF83yvEIFpdoAvSE
         /5s+ttarEYmbOhU0J88EX35siD8DlU8vblXfLTh4Ib8+yyyvQdm0+fQmEqJa+pW4Kg5Z
         7X/Ui1+MwWSMYIR3lPXvME1/sMt2efubfof+ChcZm+XODvkK7xTxycWTyaH6M5EpIy8y
         6FXyJwP9hIbjymfxBheBRC5/thJAvMv/CYkYaoErxmfpBevetarb/1bYyejfmiOsf+Tf
         rFUxqvV88Dw7P8cSMmqPQGI2yQ8y9dpyqWnmAzZXNYaSpEFCYSsU4Rq4C/VggFq9njT/
         B8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yIA2wn+QaOwYDvrtCgKX2Tj4JIOiiRe8uNAwOXX5jg=;
        b=Hn105yUP2cf3/pT4ACLe/MurT+GY+RWPXnetD0+BkL4l3BASTdr21RqDY8Ji9qXrgp
         o3WQv4yoTrMkvYdR1KOIJG+iQAe0UAhZvibtQjHfvph7eNTRGZe1x0OLUphxH5F1Qx1U
         8lJxnoeshxw5qOfwL0l8Y2cpnOqzZseAIjyvvscW81p4gV58TSIe5A8G1N+qutL71oyT
         k6R6CsTNHGekg3OwBILl7gvim7s6JlD9hWhzblBsfjW8+bJ5gRh5lyDDOjLAQ4Hz18hG
         hc/2h5+g1FNxBiOhh6TO68hSl7BZSn9TFPuWJHwc+FYVrW4ivs5cPUtSwOhJbkDlGfK/
         xowQ==
X-Gm-Message-State: AOAM533R50R3PAgPDUlp8gwTGaiMSZAeW6D08gFRIQSHbRhmWotAdEN7
        SjBuQWEsNiXz2huLelYUtrpMPatb58VDTuGguDE=
X-Google-Smtp-Source: ABdhPJz/q+Hg9RHwcEG4UaXkc+P7h3n57XbQsxlmkU/Ncv2Z3oYdOlvNYObDgcpnW3F2LjuGHK3x8MTBhT4t50H31Jg=
X-Received: by 2002:a67:e917:0:b0:328:255a:ece3 with SMTP id
 c23-20020a67e917000000b00328255aece3mr6253599vso.78.1649782844239; Tue, 12
 Apr 2022 10:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPS78prVW-RRgzpBoYONRvmZz5DotizX9t8U4aWd2qLb1x9D=w@mail.gmail.com>
 <CAP-5=fU0NEgdEwv1cGtvF2-cRLO=wOZ5UF0QCK3toJf2tnT3TQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU0NEgdEwv1cGtvF2-cRLO=wOZ5UF0QCK3toJf2tnT3TQ@mail.gmail.com>
From:   Tanusree Debnath <tanu235m@gmail.com>
Date:   Tue, 12 Apr 2022 10:00:33 -0700
Message-ID: <CAPS78ppsojuwgLyOE1=B7YmUBhKj-kk9dsw6-G09tW-3U35WPQ@mail.gmail.com>
Subject: Re: [GSoC] Applicant Introduction, project selection
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        arnaldo.melo@gmail.com, mingo@redhat.com, acme@kernel.org,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
Thanks for your reply. I have submitted the application.
Regards,
Tanusree


On Tue, Apr 12, 2022 at 9:38 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Apr 11, 2022 at 9:21 PM Tanusree Debnath <tanu235m@gmail.com> wrote:
> >
> > Hi,
> > I am Tanusree Debnath. I have graduated from San Jose State University
> > with a bachelor's degree in computer science. I love to program in
> > different programming languages. I like open source projects, and I
> > recently started contributing to open source projects. I have been
> > using the linux operating system for over 5 years now. I always wanted
> > to contribute to Linux and recently I started contributing to the
> > Linux operating system.
> >
> > I am interested in contributing to the "Perf data converter" project.
> > In preparation for this, I have already submitted three patches to
> > Linux perf out of which one was accepted.
>
> Awesome, thank you for your contributions!
>
> > My IRC nick is Tanusree.
>
> Apologies, I'd dropped off but will try to make sure I'm on IRC for
> people who want to talk about GSoC.
>
> Thanks,
> Ian
>
> > Thanks,
> > Tanusree Debnath
