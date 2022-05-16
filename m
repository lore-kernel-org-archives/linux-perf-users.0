Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC90C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 May 2022 22:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346955AbiEPWFI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbiEPWFH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 18:05:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD692C65C
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 15:05:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so22289818wrg.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLSttKxKU2q9AfLnTeIvu5H/3FQLjYmh/YpNKwsVkZ8=;
        b=rI0b0Z1z2nGbGxLDDPq/kA17H6s5pelE1RVQJF/cFc3mKmAwPeoa15pG+p+EWGNh7Z
         FlBNGtzPJ5GJ4K1m1YB/D+TMGzj4fwbexC3xidfi9K3FvYg1PtSd07ShYXyixNMZwWu2
         TQb+sFKu77CUkGlZZNlBKXyweWNpbprUYUBSwpwjdhft5lf24aTlnpjv5sLk6Yuhz2Sf
         KZMxO171AkzyGYVj0qPkJPzqf6Oh2LNR24Kr3JHjmg072+jHeZG0EgBxZ07svg7v9gsk
         3q5V8QDyuPrAgFYJmMx0yuQiEOOmtyTMRGdx5EGfRipCknvL9BA5OWi9OhdawXtkcpKf
         Kl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLSttKxKU2q9AfLnTeIvu5H/3FQLjYmh/YpNKwsVkZ8=;
        b=i9ldBZtYHuOPyDHTNHb4/uZxtN2pAEDktZ0zZrhkh8542rGmpqM0OHqq62XKQiuJR8
         8EiSrBb5XgulES5LoJS7jbsIhbys0oldJ1rq5cIvXMkhm5AxA2OgmQvv8pCuvFyh1w2P
         LOzNo9MOViBpr9/1suRAINoT+vauKr+WRvnCQlqKZr1y++hWhe1PYs4+pXWuy7xXBDZO
         1GsPEDJGAtFIVGec6UiUsPPP3NZ4m1pmlW5w9XKE4IFKWTXWzvwSXVqjrOtJddTQ+lH9
         zjNNTasEdbWjLUz/+NsqG2qU/sh5H8mfZaZOiYNDoun06sUab1nFl5ImdK2w0r+suhfb
         qDcw==
X-Gm-Message-State: AOAM532wokDRgoEQ2Um7iHrC7M7H6n/sOPguQ9TPR3asGuNMBV+gdrFy
        uT6NYc/GNLYKtfPilTQa2+LIqKKcs6E3SelzICYM0jSAyh4=
X-Google-Smtp-Source: ABdhPJxkaQVPBqXM+SxukydbVPgsc1vwsfoozK0WhvrnC8y1wFTFYGANUuIjqecfy82ZA2itiyiBYIxR9xo72CNg+Gw=
X-Received: by 2002:a5d:674c:0:b0:20d:87e:8d6f with SMTP id
 l12-20020a5d674c000000b0020d087e8d6fmr5919067wrw.40.1652738704503; Mon, 16
 May 2022 15:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <f0add43b-3de5-20c5-22c4-70aff4af959f@scylladb.com>
In-Reply-To: <f0add43b-3de5-20c5-22c4-70aff4af959f@scylladb.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 May 2022 15:04:51 -0700
Message-ID: <CAP-5=fV0rXit7BqBxghE=zK=ao_GYhwkCbu+GhJZebzhVCxq0g@mail.gmail.com>
Subject: Re: Infinite recursion in `perf record`
To:     Avi Kivity <avi@scylladb.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 16, 2022 at 8:23 AM Avi Kivity <avi@scylladb.com> wrote:
>
> In bpf-event.c we have:
>
>
> struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> {
>         struct btf *btf;
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>         int err = btf__get_from_id(id, &btf);
> #pragma GCC diagnostic pop
>
>         return err ? ERR_PTR(err) : btf;
> }
>
> and in btf.c we have:
>
>
> int btf__get_from_id(__u32 id, struct btf **btf)
> {
>          struct btf *res;
>          int err;
>
>          *btf = NULL;
>          res = btf__load_from_kernel_by_id(id);
>          err = libbpf_get_error(res);
>
>          if (err)
>                  return libbpf_err(err);
>
>          *btf = res;
>          return 0;
> }
>
> Obviously, if the first weak symbol isn't overridden we get into an
> infinite recursion, which is what I see immediately on running perf record:
>
>
> (gdb) bt
> #0  0x00007f3d94c26d76 in btf__get_from_id (id=282,
> btf=btf@entry=0x7ffc1dab4010) at btf.c:1410
> #1  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #2  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4060) at btf.c:1411
> #3  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #4  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab40b0) at btf.c:1411
> #5  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #6  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4100) at btf.c:1411
> #7  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #8  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4150) at btf.c:1411
> #9  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #10 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab41a0) at btf.c:1411
> #11 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #12 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab41f0) at btf.c:1411
> #13 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #14 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4240) at btf.c:1411
> #15 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #16 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4290) at btf.c:1411
> #17 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #18 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab42e0) at btf.c:1411
> #19 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #20 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4330) at btf.c:1411
> #21 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #22 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4380) at btf.c:1411
> #23 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #24 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab43d0) at btf.c:1411
> #25 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #26 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4420) at btf.c:1411
> #27 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #28 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4470) at btf.c:1411
> #29 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #30 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab44c0) at btf.c:1411
> #31 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #32 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4510) at btf.c:1411
> #33 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #34 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4560) at btf.c:1411
> #35 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #36 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab45b0) at btf.c:1411
> #37 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #38 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4600) at btf.c:1411
> #39 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #40 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4650) at btf.c:1411
> #41 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #42 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab46a0) at btf.c:1411
> #43 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #44 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab46f0) at btf.c:1411
> #45 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #46 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4740) at btf.c:1411
> #47 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #48 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4790) at btf.c:1411
> #49 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #50 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab47e0) at btf.c:1411
> #51 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #52 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4830) at btf.c:1411
> #53 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #54 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4880) at btf.c:1411
> #55 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #56 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab48d0) at btf.c:1411
> #57 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #58 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4920) at btf.c:1411
> #59 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #60 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4970) at btf.c:1411
> #61 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #62 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab49c0) at btf.c:1411
> #63 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #64 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4a10) at btf.c:1411
> #65 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #66 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4a60) at btf.c:1411
> #67 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #68 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4ab0) at btf.c:1411
> #69 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #70 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4b00) at btf.c:1411
> #71 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #72 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4b50) at btf.c:1411
> #73 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #74 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4ba0) at btf.c:1411
> #75 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #76 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4bf0) at btf.c:1411
> #77 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> #78 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4c40) at btf.c:1411
> #79 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized
> out>) at util/bpf-event.c:30
> --Type <RET> for more, q to quit, c to continue without paging--
>
>
> (rest of infinite stack trace omitted)
>
>
> I guess I should load some library or other, but I have no idea which,
> and in any case this is quite a fragile interface.
>
>
> perf-5.17.6-300.fc36.x86_64
>

Hi, could you provide more details of the build? I have a bazel based
build and weak symbols are a problem for me too. For example, arm and
arm64 code needs building and linking together on an arm64 build for
the symbols to work properly - normally we just need 1 arch. There
have also been issues with constant propagation. I'd prefer if we
could use #ifdefs where we explicitly say what we expect to happen on
each architecture. Weak symbols' implicit behavior is troublesome.
With #ifdefs if things are broken then linking fails, which provides
useful signal.

Thanks,
Ian
