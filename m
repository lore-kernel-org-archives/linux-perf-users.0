Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B7FC07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5A861CC2
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 15:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhGGPLd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 11:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232231AbhGGPLd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 11:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625670532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aWcVKjuywp9lh2ZpwGA5QOnKrFtu8NroiBWGr7IsBn8=;
        b=a28QXZwcYX5I/YLrg1MDdlWEUmXUAtcH5JBcOlEOkiMVUh4HpNTPvV7Wg+uS2Bhl8+3nSB
        Dh5xkYvITzmzLH1LYuf5SRofuSYNiBhEbogm+Bxpoq3vn6m8RhnNNvQyQa8dwLw0yH9rEt
        LUOl5TIEj9wh1GGcbtPHiEMLIJgjM1E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-tg-T8N9MOdmlYl65Glu3Ww-1; Wed, 07 Jul 2021 11:08:51 -0400
X-MC-Unique: tg-T8N9MOdmlYl65Glu3Ww-1
Received: by mail-lj1-f198.google.com with SMTP id q13-20020a2e914d0000b02901752c889bcdso643905ljg.20
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jul 2021 08:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWcVKjuywp9lh2ZpwGA5QOnKrFtu8NroiBWGr7IsBn8=;
        b=ZaC4gZadC447Dnnnt8HKQfpyg8E4c/48u4mBiLErYK7uOc5GA45bMddUryRMIHjqe7
         VWpNYh0p8p0nQ7Dh1b9t4EAG/iBCc0773E/b3x4pfNuR+ZZdUjDLUIA2qFD6f91ZGRRn
         uSrLQtsvobn5YHhq2fG5OQonYVewldgNYEo8QfoTpU1lPCQhNa/ZHy2U5ivzezSHMEly
         cnaovST8WBy2yqEQV5jcBYtnQRuCaFIib5Yo1uv8PER2wxXZ6i1hG2t4NEDVJxv/mQzO
         BzH+cCDKeWopPSc1WhxwvEo/on4ekm2M9A+xWEGriN/jN4EwUzOeJyPlPO1AQNxm3VT0
         wrMw==
X-Gm-Message-State: AOAM530iPDPFVd2UDZWfn5jz2FZGdAeZTLXgQnSSviOw/ikdk5hvkl5T
        sC1A2LE3lYl983r2QcLI4dzq4wZ3AKxVgtPsj+hjQTuc2K8zkI5uzhzW0a7wSyfySeHz/eYZVgQ
        f8hhl6d4CrcJn1WP8zpJDWVI1eOEkRVhXUFY59OEJrXxZ/A==
X-Received: by 2002:a19:2d0f:: with SMTP id k15mr20212365lfj.237.1625670529919;
        Wed, 07 Jul 2021 08:08:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlXVR/XQy7YZ+nddw8d1d1hF4je9/71Rlb3CsaZQ2XC6f0NCZVAnPc1T3/8u2rsmmgs33oME3cBU/Gin1VvQg=
X-Received: by 2002:a19:2d0f:: with SMTP id k15mr20212330lfj.237.1625670529596;
 Wed, 07 Jul 2021 08:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <de6b97a567e273adff1f5268998692bad548aa10.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <20210706195233.h6w4cm73oktfqpgz@habkost.net> <4cc2c5fe-2153-05c5-dedd-8cb650753740@redhat.com>
 <CAOpTY_qdbbnauTkbjkz+cZmo8=Hz6qqLNY6i6uamqhcty=Q1sw@mail.gmail.com> <671be35f-220a-f583-aa31-3a2da7dae93a@redhat.com>
In-Reply-To: <671be35f-220a-f583-aa31-3a2da7dae93a@redhat.com>
From:   Eduardo Habkost <ehabkost@redhat.com>
Date:   Wed, 7 Jul 2021 11:08:32 -0400
Message-ID: <CAOpTY_paTO=xqfGXPCC2Paty5ptJ6Dqpo4Tzb4C2hrO_t=vS8w@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/tsx: Add cmdline tsx=fake to not clear CPUID bits
 RTM and HLE
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Victor Ding <victording@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Anand K Mistry <amistry@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org, Jiri Denemark <jdenemar@redhat.com>,
        "libvir-list@redhat.com" <libvir-list@redhat.com>,
        Michal Privoznik <mprivozn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

CCing libvir-list, Jiri Denemark, Michal Privoznik, so they are aware
that the definition of "supported CPU features" will probably become a
bit more complex in the future.

On Tue, Jul 6, 2021 at 5:58 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 06/07/21 23:33, Eduardo Habkost wrote:
> > On Tue, Jul 6, 2021 at 5:05 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> It's a bit tricky, because HLE and RTM won't really behave well.  An old
> >> guest that sees RTM=1 might end up retrying and aborting transactions
> >> too much.  So I'm not sure that a QEMU "-cpu host" guest should have HLE
> >> and RTM enabled.
> >
> > Is the purpose of GET_SUPPORTED_CPUID to return what is supported by
> > KVM, or to return what "-cpu host" should enable by default? They are
> > conflicting requirements in this case.
>
> In theory there is GET_EMULATED_CPUID for the former, so it should be
> the latter.  In practice neither QEMU nor Libvirt use it; maybe now we
> have a good reason to add it, but note that userspace could also check
> host RTM_ALWAYS_ABORT.
>
> > Returning HLE=1,RTM=1 in GET_SUPPORTED_CPUID makes existing userspace
> > take bad decisions until it's updated.
> >
> > Returning HLE=0,RTM=0 in GET_SUPPORTED_CPUID prevents existing
> > userspace from resuming existing VMs (despite being technically
> > possible).
> >
> > The first option has an easy workaround that doesn't require a
> > software update (disabling HLE/RTM in the VM configuration). The
> > second option doesn't have a workaround. I'm inclined towards the
> > first option.
>
> The default has already been tsx=off for a while though, so checking
> either GET_EMULATED_CPUID or host RTM_ALWAYS_ABORT in userspace might
> also be feasible for those that are still on tsx=on.

This sounds like a perfect use case for GET_EMULATED_CPUID. My only
concern is breaking existing userspace.

But if this was already broken for a few kernel releases due to
tsx=off being the default, maybe GET_EMULATED_CPUID will be a
reasonable approach.

--
Eduardo

