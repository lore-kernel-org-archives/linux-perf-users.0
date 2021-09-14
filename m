Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F75CC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E941860462
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhINS5O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhINS5O (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 14:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631645756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJ+BNwVEZBS9mSvzR1TN3qxw8qHDnkwbPKz92pjeVxM=;
        b=Tgtam9KYmRPngLmyqJuXbUvtEKK//YHmkrEqOigzF8rGkatR/JZDjdHK9DWL37xbTIuems
        hRjKbuyYeIp4e/XGnklXKCcmq0zNm1o6myYjKUMDXrTY9HGhuJdVNKhyTizu3kEvwfclDx
        Xq+I6Vk5mW9NibwaWMzveDt6sz2eyA0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-2PKz4Kz0Nyiw8B6jlgFYCQ-1; Tue, 14 Sep 2021 14:55:54 -0400
X-MC-Unique: 2PKz4Kz0Nyiw8B6jlgFYCQ-1
Received: by mail-wm1-f69.google.com with SMTP id a144-20020a1c7f96000000b002fee1aceb6dso195518wmd.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Sep 2021 11:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IJ+BNwVEZBS9mSvzR1TN3qxw8qHDnkwbPKz92pjeVxM=;
        b=XJOW90NMoryJAOYlVpXdlS7j0HofenYJcZCDr1z+SYv8wzbsFYLkdzLxCBguOJbhvM
         JD043XIdC2Y/3SsdbYIsvCPDN3HOpMhmv/xCWdT/5GVO8LLSRiseMun34B6ADOsdr90B
         tcl0CXf9PQkjMmKhmqbraymDJR7ObAXpAhccn2Yd6B5guVFLvRY/w8VY3v0++BGnrvzK
         iNc2MAU9X1Gbibbgmv+MxXXMwUQaDTiMoRmCOYwRnz54IKWZlq++OZNdFhyOZ5Q3xr1q
         w9mboJPFVBCUW9Rlzn9oaqxSCxBcwBm4wLf8zef/rfL7oz4CJ8osDj0EsVDn3JjxATa8
         460A==
X-Gm-Message-State: AOAM532glevO62agNM/tP7pi8QHbumE1o3Xbu7M6Gz1KNLRxjnD2nk9n
        hSy7E1KasyvAbRIDcqV0m3uYH8gst8mMug2gyTcWxyDoOAY4UE8uiueLSr3ZGG2PQ0rGfIgpi24
        bnBXiQMgJGBqNYnSsfGeRd3FC3jJY+w==
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr645813wms.35.1631645753655;
        Tue, 14 Sep 2021 11:55:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrMqQnTV0LZJr401srJAoe4Q91AcLc49bkTgK15y4bmsfRT+7nJvHDml5+onAknqWn4yMy7A==
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr645795wms.35.1631645753429;
        Tue, 14 Sep 2021 11:55:53 -0700 (PDT)
Received: from krava ([83.240.63.251])
        by smtp.gmail.com with ESMTPSA id o7sm1831907wmc.46.2021.09.14.11.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:55:53 -0700 (PDT)
Date:   Tue, 14 Sep 2021 20:55:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH perf] perf: ignore deprecation warning when using
 libbpf's btf__get_from_id()
Message-ID: <YUDwNvoYJ/C+94gY@krava>
References: <20210914170004.4185659-1-andrii@kernel.org>
 <YUDoNX0eUndsPCu+@krava>
 <CAEf4BzbU8Ok-7Fsp1uGZ4F6b5GPb58fk1YKgnGwx9+sUBq71tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbU8Ok-7Fsp1uGZ4F6b5GPb58fk1YKgnGwx9+sUBq71tA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 14, 2021 at 11:28:28AM -0700, Andrii Nakryiko wrote:
> On Tue, Sep 14, 2021 at 11:21 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Sep 14, 2021 at 10:00:04AM -0700, Andrii Nakryiko wrote:
> > > Perf code re-implements libbpf's btf__load_from_kernel_by_id() API as
> > > a weak function, presumably to dynamically link against old version of
> > > libbpf shared library. Unfortunately this causes compilation warning
> > > when perf is compiled against libbpf v0.6+.
> > >
> > > For now, just ignore deprecation warning, but there might be a better
> > > solution, depending on perf's needs.
> >
> > HI,
> > the problem we tried to solve is when perf is using symbols
> > which are not yet available in released libbpf.. but it all
> > linkes in default perf build because it's linked statically
> > libbpf.a in the tree
> >
> 
> If you are always statically linking libbpf into perf, there is no
> need to implement this __weak shim. Libbpf is never going to deprecate
> an API if a new/replacement API hasn't been at least in a previous
> released version. So in this case btf__load_from_kernel_by_id() was
> added in libbpf 0.5, and btf__get_from_id() was marked deprecated in
> libbpf 0.6 (not yet released, of course). So with that, do you still
> think we need this __weak re-implementation?

we package/build perf to dynamically link to libbpf, so there's
time window where perf already uses new libbpf function that has
not been released yet in libbpf and perf build fails

Arnaldo has another solution using feature detection and have ifdefs
to take care about that, but having the weak functions is less code
and seems more manageable

jirka

> 
> I was wondering if this was done to make latest perf code compile
> against some old libbpf source code or dynamically linked against old
> libbpf. But if that's not the case, the fix should be a removal of
> __weak btf__load_from_kernel_by_id().
> 
> > so now we have weak function with that warning disabled locally,
> > which I guess could work?  also for future cases like that
> >
> > jirka
> >
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/perf/util/bpf-event.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > > index 683f6d63560e..1a7112a87736 100644
> > > --- a/tools/perf/util/bpf-event.c
> > > +++ b/tools/perf/util/bpf-event.c
> > > @@ -24,7 +24,10 @@
> > >  struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > >  {
> > >         struct btf *btf;
> > > +#pragma GCC diagnostic push
> > > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > >         int err = btf__get_from_id(id, &btf);
> > > +#pragma GCC diagnostic pop
> > >
> > >         return err ? ERR_PTR(err) : btf;
> > >  }
> > > --
> > > 2.30.2
> > >
> >
> 

