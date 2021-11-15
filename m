Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C3C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 21:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B92F61B2C
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 21:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbhKOVgo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348982AbhKOVNx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 16:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637010652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3jupCc4IITmY9q0ereyU1/OdqsEHxFt+kRYI5gk66Y=;
        b=S//l6sJp8KP/kNTtqyDBvLDek4VN6q2l+AYEM1EjeA6Vel2dD+B+P6SJc/IaFwLg15xLX3
        LAxt16ImHXhGiVxIdU3eFaVrOrD4alCbRicBDhuB7/Z+h0yXc/NLGWLaKyeYyvEgTFg3aa
        wdb3UxHQj3agieIQcflNwGmsnr14xhQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-h4JtFdcIO9CJrmHJwDbJYg-1; Mon, 15 Nov 2021 16:10:51 -0500
X-MC-Unique: h4JtFdcIO9CJrmHJwDbJYg-1
Received: by mail-wr1-f69.google.com with SMTP id z5-20020a5d6405000000b00182083d7d2aso4004858wru.13
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Nov 2021 13:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z3jupCc4IITmY9q0ereyU1/OdqsEHxFt+kRYI5gk66Y=;
        b=QvdHwdCSMHpqh7YCHYO0ZFisSJGfGSH/f0KotafJEdwicH5kMY36AsB5qSHDjV23wh
         3wWk8X/lJAYRD3PD175rr1Q6TfyUKC4FJG1V0P876uJYjfmdcoz7mTpVvS5EkSVPF21F
         utCClwje8Rv8ifij/drx9L7JH4M7usesFVu03YPrpR60/rr2qEyq49oS6o05lWAukih8
         EhuP9GbeX7GjdQ8wiuZpFmTCZ1vpqtCZsgdc/U7f9MZEkPaQHAWAIZmPeYq4nCnCHxUm
         4GehBxledn1HSP0UzN3biEM8SyX9X8C6F3vYBFHiyow+jkhMqhXfDgIiJtF8eB3Bz+Jn
         PCwQ==
X-Gm-Message-State: AOAM531kEVKOgVEq/CADNFhdMca1Kc/m4+pu26Bqw3xridaHdy4XKsPO
        mPMoa9abhwwiAY4GSHCY9G9IjkqwZ1cFnFaL/crDgyTFvmNYtmhXgQjl6WGJtSkDml0ON6FY6a6
        E0tCCaixA57DGRDBs/u32LugAr9s30Q==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr2615235wrn.145.1637010650139;
        Mon, 15 Nov 2021 13:10:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/+t1dna98ZvBpdsgt6maHPw++KLX3my6Ka4lFa3gZ4EizHSuM3/6PybxsV1tC0sXHh+dyGA==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr2615210wrn.145.1637010649990;
        Mon, 15 Nov 2021 13:10:49 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id m36sm503171wms.25.2021.11.15.13.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:10:49 -0800 (PST)
Date:   Mon, 15 Nov 2021 22:10:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        masahiroy@kernel.org, Laura Abbott <labbott@kernel.org>,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com
Subject: Re: [PATCH] perf tools: Enable warnings through HOSTCFLAGS
Message-ID: <YZLM2BmFo+cK4B4J@krava>
References: <1635525041-151876-1-git-send-email-john.garry@huawei.com>
 <YYbXMd3N4+aXYLTJ@kernel.org>
 <591edce2-5aaa-22bc-6fd3-5a247f623eb3@huawei.com>
 <239840A9-F713-4FED-B638-14D6B91FBBF2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <239840A9-F713-4FED-B638-14D6B91FBBF2@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 15, 2021 at 02:44:59PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> 
> On November 15, 2021 12:53:33 PM GMT-03:00, John Garry <john.garry@huawei.com> wrote:
> >On 06/11/2021 19:27, Arnaldo Carvalho de Melo wrote:
> >> Em Sat, Oct 30, 2021 at 12:30:41AM +0800, John Garry escreveu:
> >>> The tools build system uses KBUILD_HOSTCFLAGS symbol for obvious purposes.
> >>>
> >>> However this is not set for anything under tools/
> >>>
> >>> As such, host tools apps built have no compiler warnings enabled.
> >>>
> >>> Declare HOSTCFLAGS for perf tools build, and also use that symbol in
> >>> declaration of host_c_flags. HOSTCFLAGS comes from EXTRA_WARNINGS, which
> >>> is independent of target platform/arch warning flags.
> >>>
> >>> Suggested-by: Jiri Olsa <jolsa@redhat.com>
> >>> Signed-off-by: John Garry <john.garry@huawei.com>
> >>> --
> >>> Using HOSTCFLAGS, as opposed to KBUILD_HOSTCFLAGS, is going opposite
> >>> direction to commit 96f14fe738b6 ("kbuild: Rename HOSTCFLAGS to
> >>> KBUILD_HOSTCFLAGS"), so would like further opinion from Laura and
> >>> Masahiro.
> >> 
> >> Laura's redhat e-mail bouncedm updated it to her kernel.org one, Laura,
> >> Masahiro, would you please comment? Jiri?
> >
> >Any opinion on this one? Shall I just resend ... ? or just apply it if 
> >no one cares too much :)
> 
> I'll apply it now that everybody got enough time to review it . :-)

sorry, overlooked this one, looks good

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> - Arnaldo
> >
> >Thanks,
> >John
> >
> >> 
> >> - Arnaldo
> >>   
> >>> diff --git a/tools/build/Build.include b/tools/build/Build.include
> >>> index 2cf3b1bde86e..c2a95ab47379 100644
> >>> --- a/tools/build/Build.include
> >>> +++ b/tools/build/Build.include
> >>> @@ -99,7 +99,7 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
> >>>   ###
> >>>   ## HOSTCC C flags
> >>>   
> >>> -host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
> >>> +host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
> >>>   
> >>>   # output directory for tests below
> >>>   TMPOUT = .tmp_$$$$
> >>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> >>> index 4a9baed28f2e..9b95ba09657f 100644
> >>> --- a/tools/perf/Makefile.config
> >>> +++ b/tools/perf/Makefile.config
> >>> @@ -17,6 +17,7 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
> >>>   detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
> >>>   
> >>>   CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> >>> +HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> >>>   
> >>>   include $(srctree)/tools/scripts/Makefile.arch
> >>>   
> >>> @@ -211,6 +212,7 @@ endif
> >>>   ifneq ($(WERROR),0)
> >>>     CORE_CFLAGS += -Werror
> >>>     CXXFLAGS += -Werror
> >>> +  HOSTCFLAGS += -Werror
> >>>   endif
> >>>   
> >>>   ifndef DEBUG
> >>> @@ -292,6 +294,9 @@ CXXFLAGS += -ggdb3
> >>>   CXXFLAGS += -funwind-tables
> >>>   CXXFLAGS += -Wno-strict-aliasing
> >>>   
> >>> +HOSTCFLAGS += -Wall
> >>> +HOSTCFLAGS += -Wextra
> >>> +
> >>>   # Enforce a non-executable stack, as we may regress (again) in the future by
> >>>   # adding assembler files missing the .GNU-stack linker note.
> >>>   LDFLAGS += -Wl,-z,noexecstack
> >>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> >>> index a3966f290297..8ca656aa8b06 100644
> >>> --- a/tools/perf/Makefile.perf
> >>> +++ b/tools/perf/Makefile.perf
> >>> @@ -226,7 +226,7 @@ else
> >>>   endif
> >>>   
> >>>   export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> >>> -export HOSTCC HOSTLD HOSTAR
> >>> +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
> >>>   
> >>>   include $(srctree)/tools/build/Makefile.include
> >>>   
> >>> -- 
> >>> 2.17.1
> >> 
> >
> 

