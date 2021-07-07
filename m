Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CBBC07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B84AC61CC7
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGGRL1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230378AbhGGRL0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 13:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625677726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKokQ6HlP8zCRHXKsabsyD7PFz88tRZ5vWzOFOKcnus=;
        b=FfHLnEX3izBdfFMwxSSipR4/UeMuEOkx2gfa3B4JveO2TmkD+bg0NMLrXIYVASHUiw+V61
        E6FMj9QrQIHGjNoTMqx0CHXfpoYZMKcitifDzTFayIiKzg7H4+EWqiih9BUsrXaBm5r2F7
        F8BnQngy0MywnmLukr6oT00iZsp5eJk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-4V-dR9CfNhGF6m7Z16go5A-1; Wed, 07 Jul 2021 13:08:44 -0400
X-MC-Unique: 4V-dR9CfNhGF6m7Z16go5A-1
Received: by mail-lf1-f71.google.com with SMTP id t14-20020ac24c0e0000b0290323b04a9bd4so1403509lfq.9
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jul 2021 10:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKokQ6HlP8zCRHXKsabsyD7PFz88tRZ5vWzOFOKcnus=;
        b=h/qcfvQz+TeBJNPGa58X6SzEKV0KBld8xF8nR6YpEch0QWea0BA/gbHXm6QCAB49TW
         TMW7DYV3BsoEt8U9A971EUyzhMqtv2ILaBRRWkTju1pLj40UWjS3ZL6X6RhuqbpcAM9F
         VCDE/wv9XNI0kFdFtVCgDpsROpv/viKnEUB3ymxzRbYGry5IXYFtv/5VqjgPVwFkfa6E
         rT6R45JPB3vmjqYnGT3hNOcwS9kz4A1GtgIiw6OfsxRt6mcK/p7a6V9aDqNwvKR5sgD2
         /QSF784JDpKEKQCYK8UDZEJQJkpGU4CZkh2CZMS9dRYm36PafJXXIta83oBeZ7h099mh
         T+0w==
X-Gm-Message-State: AOAM5327eyOdBBi5hDqNVVIpQ+uxF77LLey3lAYvaNez+tSscbLALsOn
        V+RUkgZuhqn6cVuodb9Qij4vZLu/PRDnRIaRQZ+lBk7KRYkjB7rhFdbSnxS/j1uVq7No9/pP+n0
        Xi77oulum7HcPCXC1DMJniB5THb+fAvswcxmYb8TwtoirbA==
X-Received: by 2002:a19:6d06:: with SMTP id i6mr13400958lfc.295.1625677723032;
        Wed, 07 Jul 2021 10:08:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIVbMaYKmhK4voQf0eRNSJP0bDqNGYvkVM74ION1H4OiOMDQQFrRwSGJ2qM5HSbBwHujP+BJ9y3biXkOhSbn8=
X-Received: by 2002:a19:6d06:: with SMTP id i6mr13400912lfc.295.1625677722393;
 Wed, 07 Jul 2021 10:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <de6b97a567e273adff1f5268998692bad548aa10.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <20210706195233.h6w4cm73oktfqpgz@habkost.net> <4cc2c5fe-2153-05c5-dedd-8cb650753740@redhat.com>
 <CAOpTY_qdbbnauTkbjkz+cZmo8=Hz6qqLNY6i6uamqhcty=Q1sw@mail.gmail.com>
 <671be35f-220a-f583-aa31-3a2da7dae93a@redhat.com> <CAOpTY_paTO=xqfGXPCC2Paty5ptJ6Dqpo4Tzb4C2hrO_t=vS8w@mail.gmail.com>
 <CALMp9eSJyvU1=FndZyR+hZMtKPWwgibKisBqp0Xcx4jxjrWn2w@mail.gmail.com>
In-Reply-To: <CALMp9eSJyvU1=FndZyR+hZMtKPWwgibKisBqp0Xcx4jxjrWn2w@mail.gmail.com>
From:   Eduardo Habkost <ehabkost@redhat.com>
Date:   Wed, 7 Jul 2021 13:08:26 -0400
Message-ID: <CAOpTY_pefOmJ0zJjUzitgTGxqgX6XxwTP0fMKoiyuBCHrh+AWg@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/tsx: Add cmdline tsx=fake to not clear CPUID bits
 RTM and HLE
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
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

On Wed, Jul 7, 2021 at 12:42 PM Jim Mattson <jmattson@google.com> wrote:
>
> On Wed, Jul 7, 2021 at 8:09 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > CCing libvir-list, Jiri Denemark, Michal Privoznik, so they are aware
> > that the definition of "supported CPU features" will probably become a
> > bit more complex in the future.
>
> Has there ever been a clear definition? Family, model, and stepping,
> for instance: are these the only values supported? That would make
> cross-platform migration impossible. What about the vendor string? Is
> that the only value supported? That would make cross-vendor migration
> impossible. For the maximum input value for basic CPUID information
> (CPUID.0H:EAX), is that the only value supported, or is it the maximum
> value supported? On the various individual feature bits, does a '1'
> imply that '0' is also supported, or is '1' the only value supported?
> What about the feature bits with reversed polarity (e.g.
> CPUID.(EAX=07H,ECX=0):EBX.FDP_EXCPTN_ONLY[bit 6])?
>
> This API has never made sense to me. I have no idea how to interpret
> what it is telling me.

Is this about GET_SUPPORTED_CPUID, QEMU's query-cpu-model-expansion &
related commands, or the libvirt CPU APIs?

-- 
Eduardo

