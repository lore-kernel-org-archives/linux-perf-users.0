Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A4C2BB41
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Aug 2022 22:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346925AbiHOWTT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Aug 2022 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350829AbiHOWSj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Aug 2022 18:18:39 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6526441D20
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Aug 2022 12:42:38 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id q14so4164578vke.9
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Aug 2022 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RGBjkPaE8J9hO2HXiD58roaLLtlMCd9GApWRbn/4InE=;
        b=FPnuTloO45sF2T+4wEAf823pe7ogF3QnjRaKt7CEVoHfJADFo52qIDJ1ZW2Z4LsAcu
         H1W2iVmPI4c522AHFCUyx7ONp/gv20XWuh3LLqi1W1gNTA7Go2R4zwn18WsNaore+syl
         0eYy6eJq/oyYLaYS+z59QmSMvokUC+mywr5AIISm+KTlLsOJU4LPOKV0XxpFu3UwdcS0
         dYc0WrRklRJfH4uzQCrjttrHj/om6vTyzT/5gmlSslEJoj/j2XoWwJu62hNTThOfBCfK
         uwOFZ9py99FCDB/TEkuZ2PIS8vruJ36GwJ47bJEEbddUQ86rJ18LozZWAOKcFsQXzuXX
         elKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RGBjkPaE8J9hO2HXiD58roaLLtlMCd9GApWRbn/4InE=;
        b=yCzDCwEMl+iO19mQ0cPdeLDhFLaz1zy8FEAhj9dWgCZ/pIQt2gELrOa9h8AJej1mCO
         grgXW5zt/OcIUNyHEA2cWTtXf/z+fX9Vl4Q8bZjL+e4sRGQtBfg/X9sM5oEGR0+A5+nI
         sdaRBpRg8TCRiT1hRs7kYMjnEoDB1SgN5hJpvZpFPcISEi9ZBNkpIyxFWkRE5HPQI1jd
         iwxtqwsuUTdx5v/Zc0NStnUpxM56bhYm/+l0fNyUNacLV5MREH0fUtDLQS31KAtCTqsh
         napU3n0IEtULnptvCiooCaiDgsaIvZVlOqPxvzL4gDocR9iH0dCHgNavV2soLLlTnFdj
         4Rmg==
X-Gm-Message-State: ACgBeo10Lk8MOnWHKyrhKlj4cp6AtCntz05Iqq4YhwrGygZbppwS+vKd
        nu6C6mX7a+Ku1DN0yz2su2NpMelRhyF98Ube3G3Bkw==
X-Google-Smtp-Source: AA6agR7pGITv9xB++a81UrxiizddUCff4tMML/JKgOT3cUKsfaaQ9Khq0zhzod+3R31qgsSrSVaAxFx5/6Bs+6Zfd0E=
X-Received: by 2002:a1f:2b47:0:b0:380:59c5:8b8f with SMTP id
 r68-20020a1f2b47000000b0038059c58b8fmr1092986vkr.20.1660592557245; Mon, 15
 Aug 2022 12:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660211399.git.sandipan.das@amd.com> <172d2b0df39306ed77221c45ee1aa62e8ae0548d.1660211399.git.sandipan.das@amd.com>
 <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
In-Reply-To: <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 15 Aug 2022 12:42:23 -0700
Message-ID: <CABPqkBQ1YLAu+sJC_U4QsQuo3PuzUwRDrNm9KcrUAEUxeBaYbg@mail.gmail.com>
Subject: Re: [PATCH 04/13] x86/cpufeatures: Add LbrExtV2 feature bit
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        like.xu.linux@gmail.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Mon, Aug 15, 2022 at 4:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Aug 11, 2022 at 05:59:52PM +0530, Sandipan Das wrote:
> > CPUID leaf 0x80000022 i.e. ExtPerfMonAndDbg advertises some new performance
> > monitoring features for AMD processors.
> >
> > Bit 1 of EAX indicates support for Last Branch Record Extension Version 2
> > (LbrExtV2) features. If found to be set during PMU initialization, the EBX
> > bits of the same leaf can be used to determine the number of available LBR
> > entries.
> >
> > For better utilization of feature words, LbrExtV2 is added as a scattered
> > feature bit.
> >
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 2 +-
> >  arch/x86/kernel/cpu/scattered.c    | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index 393f2bbb5e3a..e3fa476a24b0 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -96,7 +96,7 @@
> >  #define X86_FEATURE_SYSCALL32                ( 3*32+14) /* "" syscall in IA32 userspace */
> >  #define X86_FEATURE_SYSENTER32               ( 3*32+15) /* "" sysenter in IA32 userspace */
> >  #define X86_FEATURE_REP_GOOD         ( 3*32+16) /* REP microcode works well */
> > -/* FREE!                                ( 3*32+17) */
> > +#define X86_FEATURE_LBREXT_V2                ( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
> >  #define X86_FEATURE_LFENCE_RDTSC     ( 3*32+18) /* "" LFENCE synchronizes RDTSC */
> >  #define X86_FEATURE_ACC_POWER                ( 3*32+19) /* AMD Accumulated Power Mechanism */
> >  #define X86_FEATURE_NOPL             ( 3*32+20) /* The NOPL (0F 1F) instructions */
> > diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> > index dbaa8326d6f2..6be46dffddbf 100644
> > --- a/arch/x86/kernel/cpu/scattered.c
> > +++ b/arch/x86/kernel/cpu/scattered.c
> > @@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] = {
> >       { X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> >       { X86_FEATURE_MBA,              CPUID_EBX,  6, 0x80000008, 0 },
> >       { X86_FEATURE_PERFMON_V2,       CPUID_EAX,  0, 0x80000022, 0 },
> > +     { X86_FEATURE_LBREXT_V2,        CPUID_EAX,  1, 0x80000022, 0 },
> >       { 0, 0, 0, 0, 0 }
> >  };
>
> Would LBR_V2 work at all? It being a new version already seems to imply
> extention, no? Then again, I suppose there's an argument to be had for
> avoiding confusion vs the Intel LBR thing.. Couldn't you have called
> this BRS_V2 :-)
>
I believe it is called v2 because there was already a LBR in previous
generations, however it
was 1-deep and it was not connected to the PMU like this one. The
public PPR mentions it
(MSR 0x1DB/0x1DC, Last Branch From IP, Last Branch To IP). See for
instance the PPR
for Fam17h model 71h:
https://www.amd.com/system/files/TechDocs/56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06.zip

BRS is a model specific feature for Zen3.

LBRv2 is a great improvement including over Zen3 BRS.
