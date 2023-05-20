Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3155FC77B75
	for <linux-perf-users@archiver.kernel.org>; Sat, 20 May 2023 03:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjETDL7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 May 2023 23:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjETDL4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 May 2023 23:11:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF4E50
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 20:11:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64384c6797eso3139396b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 20:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684552292; x=1687144292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUYxBmPqmV/ud9DWbP70oFr6/exYLUsp2ukjA2oNtgI=;
        b=VEDvd2PE2K7Zi4zpxPMmWHLt9o3UfKTc9AfaVA5mmV6FetkQw0KGqg3mX9iWh/jrDL
         FiP5DrXdXZlMNV2G4deLB38oTNmJzy+nkw1TfzL/R0bJiXHHAnq2yjYZ1iVFaCEX91LF
         xBGHRQUYGuJ+MrhkRI7Wsh15RrYG46Ia/UN8ZajRPJ2mNlhKWvYggo0f42kgvqMbced7
         mF2pZYOqyJaMw2dAjalaGaBHuJRbBUjKBdPr/Qnb/0256/FbnATaj7C3/WcUGxCXegs6
         EdN1A18/CXOPMM0TQimJPh9VFl/Oy16IO4ZHike9S9PnCkBesNdXJbgbkh8bQkNY6hNz
         PIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684552292; x=1687144292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUYxBmPqmV/ud9DWbP70oFr6/exYLUsp2ukjA2oNtgI=;
        b=EObp1ejUSosCdSrZJ7JpCoojWdGy5Nv0NFc6ABbUfhTFy5O39sQ2YIJbYgzdskkay1
         N81Luz/Oy9Oy42mwhU5IsyRHwMawLfM0T6No3h7fSciCyQHEDy/GQVJAakJYop7bRc9z
         yqMIPhDbPqUZb4V7yEuwaAiNj4pQO+u7k8v8di8TZXRzvjVH9UYupI1aYswHQ9zLaHn9
         1ukaac0SBjtJksY/CRm3WUP19D8AtsmYOx4szxtpToJbh89z6/sb3+iswPKJnWF3pRlL
         /wcmIiHxjDl9oo1R9iqGTWIQI7rskIZ9sqSWQAChG8WWGSgL1jIDojvbI77GVOJ6FQ92
         S+4w==
X-Gm-Message-State: AC+VfDwoKwIWO1M0loRtyHS6z+P1rGYNz0qoKaT/S69wDQnOYqdLxMFk
        V3JgdgXX0gyxIFj4ZArOUVWdeg==
X-Google-Smtp-Source: ACHHUZ7Sbjz5WvqoXsEU/kz+oyvFJmCJWROzcIsMmquneVj+AYvadFDfZe+0v93ck15oV4rVfKfPqw==
X-Received: by 2002:a05:6a00:2e0e:b0:646:3c2:4d30 with SMTP id fc14-20020a056a002e0e00b0064603c24d30mr5388136pfb.30.1684552292023;
        Fri, 19 May 2023 20:11:32 -0700 (PDT)
Received: from leoy-yangtze.lan ([107.151.177.126])
        by smtp.gmail.com with ESMTPSA id m17-20020aa78a11000000b0063aa1763146sm380420pfa.17.2023.05.19.20.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 20:11:31 -0700 (PDT)
Date:   Sat, 20 May 2023 11:11:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 17/17] tools arch arm64: Sync the perf_regs headers
 with the kernel sources
Message-ID: <20230520031122.GG1068119@leoy-yangtze.lan>
References: <cover.1683712944.git.siyanteng@loongson.cn>
 <84e48c9d165a71c30b7a299baaa87a22c578ca0a.1683712945.git.siyanteng@loongson.cn>
 <ZFu3sY4AuuCGb9Nw@kernel.org>
 <20230515040832.GB1826330@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515040832.GB1826330@leoy-yangtze.lan>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 15, 2023 at 12:08:32PM +0800, Leo Yan wrote:
> On Wed, May 10, 2023 at 12:26:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 10, 2023 at 06:25:24PM +0800, Yanteng Si escreveu:
> > > Picking the changes from:
> > > 
> > >   commit aa3e49b606e0796a ("arm64: asm/perf_regs.h: Avoid C++-style
> > >    comment in UAPI header")
> > >   commit 2ee0d7fd36a3f87b ("ARM64: perf: add support for perf
> > >    registers API")
> > >   commit cbb0c02caf4bd98b ("perf: arm64: Add SVE vector granule
> > >    register to user regs")
> > > 
> > > Silencing these perf build warnings:
> > > 
> > >   Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi
> > >    /asm/perf_regs.h' differs from latest version at 'arch/arm64
> > >     /include/uapi/asm/perf_regs.h'
> > >   diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64
> > >    /include/uapi/asm/perf_regs.h
> > > 
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > ---
> > >  tools/arch/arm64/include/uapi/asm/perf_regs.h | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> > > index fd157f46727e..86e556429e0e 100644
> > > --- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
> > > +++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> > > @@ -36,11 +36,13 @@ enum perf_event_arm_regs {
> > >  	PERF_REG_ARM64_LR,
> > >  	PERF_REG_ARM64_SP,
> > >  	PERF_REG_ARM64_PC,
> > > +	PERF_REG_ARM64_MAX,
> > >  
> > >  	/* Extended/pseudo registers */
> > > -	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
> > > -
> > > -	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
> > > -	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1
> > > +	PERF_REG_ARM64_VG = 46,				/* SVE Vector Granule */
> > > +	PERF_REG_ARM64_EXTENDED_MAX
> > >  };
> > > +
> > > +#define PERF_REG_EXTENDED_MASK	(1ULL << PERF_REG_ARM64_VG)
> > > +
> > >  #endif /* _ASM_ARM64_PERF_REGS_H */
> > 
> > This needs some more work, note that -DCORESIGHT=1 in the make command line.
> 
> On the mainline kernel, the patch cbb0c02caf4bd ("perf: arm64: Add SVE
> vector granule register to user regs") and f450f11b2d3f ("perf tools
> arm64: Copy perf_regs.h from the kernel") are to update headers for
> kernel header and tool's header respectively, but there are not
> aligned with each other.  So Yanteng's patch is valid and we should
> pick up it.
> 
> However, as Arnaldo tested, Yanteng's patch introduces building
> regression due to arm64 and x86 both defines the macro
> PERF_REG_EXTENDED_MASK, but this macro actually is architecture
> specific.
> 
> The issue is now we use a single file util/perf_regs.c to maintain
> perf register related stuffs for all architectures, this is fragile
> since we cannot have any duplicated naming (e.g. for macros, structure
> name, etc).  We need to refactor the source file util/perf_regs.c to
> move architecture specific code into arch folders and only keep common
> code.
> 
> @James, you is the best person to know this part for arm64.  If you
> have already worked on this, please let me know.  Otherwise, I can
> prepare a patch set for this, I tried a bit but found I cannot just
> use a single patch to refactor util/perf_regs.c.

Hi,

I sent a patch series [1] for perf register refactoring, which will
resolve the building failure issue caused by this arm64 header syncing
change.

Thanks,
Leo

[1] https://lore.kernel.org/lkml/20230520025537.1811986-1-leo.yan@linaro.org/T/#mf286726bcfbc0fc5313798d1693db65ef902d9ed
