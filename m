Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ABCC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Dec 2022 22:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiLMWsC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 17:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiLMWsB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Dec 2022 17:48:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618412408A
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Dec 2022 14:47:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f18so17445586wrj.5
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Dec 2022 14:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P2rPSpV30DMArlILJhVf/pTOykjarxMulIIIDDH7UVw=;
        b=G6kBGUFFgfwTZSKoa0aosDD5Wxux3w3OF7RvGU0xEmTxpuBtQgm85e1jZ/rg9YrLu9
         fPF+IPDmy2MarCLC0d1UOBcD0CQ4Sez8K3qhTbguNDoKsyZsqKNakie5Kymj86C3yI9w
         JYCfL6I/fgNHIUfHOn2ZXxfOjAtDP/WHjBCsg3dWbawsEhu1doOivfn2bdzSnU5qy34K
         bRqFyoY/7fRjBnjdlm7k/a7UAR5eTGZAWIoJoyKLLBSvs7Xge3iriN+PmXs7TdSsQjdC
         pCc8V7pPIXt20wu6dTYkIwcEf8q3rL+wyFpD4knHIo5KeVP2fHrVrddQJLU79ZJzTd90
         7eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2rPSpV30DMArlILJhVf/pTOykjarxMulIIIDDH7UVw=;
        b=GkS8FOWiumlgxDhQs6AMIFNFD/CSeSTc7HgUoxhyXQLjjOalxQYNUboQAgwBtwpXrG
         5VL+Fc7ifBRRK+2GUbZJV+swyQ2DIMXuH9h87hRDuXbgnkQPu+JGPxlIleyrCEDLNB6/
         +MqZUm1q8tYH/UbtEUdNudIfBCs5hFjDE22reznYjqaOOXcqdyWk+pqGPlpgpnMGHn1C
         zlfJKGckCl827MpLxSk+GrTRLFY8GeDtdb/LDK0xgydI9y4gQrU0hCBodstKUOVIeUtI
         Kp1YrG/4VE7KnPo44SvODq5h2oCs1bxo4RgdbeInZGXiBJA2Y9i2L0LyKWb8VlH53T38
         /8Iw==
X-Gm-Message-State: ANoB5pkqBwOO6fMp73Xw4lJ2T9ADXnrXE6+xO5xk0pDoEZKj8L2GFuXQ
        X+ZxcoMubvll153r2uA3jPLjiRYJp5xhWaPHEQdijg==
X-Google-Smtp-Source: AA0mqf4bhFpkeK8ZTyG2hqUWEfovpOG10oszQspQQQIntPx71LnjjEFLPxDVqPiHPuPaulPAZDlkqvYO0inWLUWcJh4=
X-Received: by 2002:adf:f3c5:0:b0:242:5caa:5fbf with SMTP id
 g5-20020adff3c5000000b002425caa5fbfmr11175741wrp.300.1670971677544; Tue, 13
 Dec 2022 14:47:57 -0800 (PST)
MIME-Version: 1.0
References: <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com> <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com> <Y5JfgyN59dSeKbUP@kernel.org>
 <Y5Jl8MeW90DXy1wT@kernel.org> <8F6F0C27-53F3-4837-A19C-845768253249@linux.vnet.ibm.com>
 <Y5cxyk3OdgFXlyhS@kernel.org> <BB236C92-3505-4DAB-AE28-A55F74EDE161@linux.vnet.ibm.com>
 <CAP-5=fVVPDo_3cjKmumEVKDN2Zssz-ZU=nYVQFNr1xUGHxx-PQ@mail.gmail.com> <927374FD-C6C0-42B3-9F93-5379A5898FB3@gmail.com>
In-Reply-To: <927374FD-C6C0-42B3-9F93-5379A5898FB3@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Dec 2022 14:47:45 -0800
Message-ID: <CAP-5=fUD+0sPu1u+MMJQ=P5haufV7ifZtt3E7PFpufY6DyX5bw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Dec 13, 2022 at 2:34 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On December 13, 2022 7:09:07 PM GMT-03:00, Ian Rogers <irogers@google.com> wrote:
> >Thanks Athira and Arnaldo. It is a little strange to me to be using
> >the shell to do a version number test. The intent was to be doing
> >these in the code:
> >#if LIBRTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
> >vs
> >...
> >LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE := $(shell expr 1 \*
> >255 \* 255 + 5 \* 255 + 0) # 1.5.0
> >ifeq ($(shell test $(LIBTRACEEVENT_VERSION_CPP) -gt
> >$(LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE); echo $$?),0)
> >CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >endif
> >...
> >#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >I'm a little selfish as I'm maintaining a bazel build and a single
> >version number to maintain is easier than lots of HAVE_... tests. I'm
> >happy to follow Arnaldo's lead. I think the test should also be
> >greater-equal rather than greater-than:
> >https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/tree/include/traceevent/event-parse.h?h=libtraceevent-v1.5#n128
>
> I'll fix that, and in a case like this please consider to send a patch with your preference, I'd happily
> graft it.
>
> - Arnaldo

I can fix it. I can fold it in with:
https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/
which I mentioned in this thread.

Thanks,
Ian

> >
