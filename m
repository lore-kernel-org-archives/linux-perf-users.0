Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68B1C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2276109E
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhINSXF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230458AbhINSXE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 14:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631643706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RzRQOokEbdUeicnCoLmtUmPl1TTH24mpTDbC+pUZi8=;
        b=iQdZlPhjSW4f0Ni0weaASIbPtJ82cuDK+ZLvehgp3vhLNsw4uvQZcLidPJCkqCwdC27It7
        GDf6sEY3C9PuPQxREu3mlECI5a827bSmuNU+9kIxNoWbkmg2hdaGG1PqSOXO6hEzbfLOPj
        dk9tt2E2k9Db0XQJyZYmhfWZ7dno/e8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-Jo8stBLhPBWwVxRSR-BpYg-1; Tue, 14 Sep 2021 14:21:45 -0400
X-MC-Unique: Jo8stBLhPBWwVxRSR-BpYg-1
Received: by mail-wm1-f70.google.com with SMTP id h1-20020a05600c350100b002e751bf6733so51066wmq.8
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Sep 2021 11:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2RzRQOokEbdUeicnCoLmtUmPl1TTH24mpTDbC+pUZi8=;
        b=1WSzrlFtCKCgB/miokHL1DF0PCtsPlXSNgF0sp5P6gS6au69ICVnk+r0HJ6U701VYZ
         PBynPqJFnhRh8ULeCChjgw553cmLN32CkfAk/FVvBic2ak4Xk1n/OPaOv73J1G8InKwG
         6Eu1WitkJgNpjMUUpm0GzfyRwrPkD8Z/PiF/p4J4NbWWA5Mo+tZDZb+Qcm1x5uhhTGov
         nfuPx1mgZfYv/CJv5r/8bQqQ/LSm4Y5x5wE/Gc/jy/tTSraxOpR2qGIt6tYduRkOXv4g
         HdWukC/JvPAd3vlOPDXo5bBhIsT/E1s0sqRMeZ4o/9RWNV6WNkYRKpDqgfR0vGFLlD4g
         eYWQ==
X-Gm-Message-State: AOAM532OsBa5TZ0IVMziYWa67oNKj4ZmBArK6ZC3kkT/VyO413QM8wgz
        I1hXNAKZF3gJgI7wWo3KoQom159YNqao16/DhCPAqM1s+zwIfMmuVHoOjsXJ7Mrr6CCIniJ99fR
        iQrlmRxkd1AQXaxdfGv74mjndmvaJQA==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr584694wrv.81.1631643704159;
        Tue, 14 Sep 2021 11:21:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHX114+4ddP/vyY3zGWHlIpqyrz+peRm/giBAKyFao004xx7dh9UMPOH5Ec1nlffZVZNPgUw==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr584684wrv.81.1631643703990;
        Tue, 14 Sep 2021 11:21:43 -0700 (PDT)
Received: from krava ([83.240.63.251])
        by smtp.gmail.com with ESMTPSA id x21sm1922476wmc.14.2021.09.14.11.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:21:43 -0700 (PDT)
Date:   Tue, 14 Sep 2021 20:21:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH perf] perf: ignore deprecation warning when using
 libbpf's btf__get_from_id()
Message-ID: <YUDoNX0eUndsPCu+@krava>
References: <20210914170004.4185659-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914170004.4185659-1-andrii@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 14, 2021 at 10:00:04AM -0700, Andrii Nakryiko wrote:
> Perf code re-implements libbpf's btf__load_from_kernel_by_id() API as
> a weak function, presumably to dynamically link against old version of
> libbpf shared library. Unfortunately this causes compilation warning
> when perf is compiled against libbpf v0.6+.
> 
> For now, just ignore deprecation warning, but there might be a better
> solution, depending on perf's needs.

HI,
the problem we tried to solve is when perf is using symbols
which are not yet available in released libbpf.. but it all
linkes in default perf build because it's linked statically
libbpf.a in the tree

so now we have weak function with that warning disabled locally,
which I guess could work?  also for future cases like that

jirka

> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/perf/util/bpf-event.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 683f6d63560e..1a7112a87736 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -24,7 +24,10 @@
>  struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
>  {
>         struct btf *btf;
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>         int err = btf__get_from_id(id, &btf);
> +#pragma GCC diagnostic pop
>  
>         return err ? ERR_PTR(err) : btf;
>  }
> -- 
> 2.30.2
> 

