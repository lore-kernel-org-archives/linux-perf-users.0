Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC61CC3F6B0
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 15:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiHDPHw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiHDPHu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Aug 2022 11:07:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1941CB35
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Aug 2022 08:07:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso5617031pjq.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Aug 2022 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=neB+q0Kh/QsWUNLfDZS1PKd7092ZvbprenIhcvXZr4s=;
        b=DEtCTuZuYtlNCKENrIWS/qrP6UQrptimFrP7vr/8hGEfVxGNVAqaGxVs1Mqahh3fJf
         Bk8KfmBIyI2ctXtvBZ8yDNsVrvvumQU+Y395lVQju+2V1hs0PKE68RlkcSPVWHTOTL/2
         KBO5J9nzOj09abxmKMh61PutppsEYFH+qAyutY6ntxdijTFkg3Z9Vl3W8ItxXlYwoc62
         qYRqdStaJn4e9fw7YPAtUq0kDQ9F+l1royE+v4mZgpIA9xi6VuvhXezVDhLWxacvVRVN
         XTiuz3CEDMVaaP23QuuUGKS8aObobALB2lOYSdnHgRuQopka5bRyrcoIrQ+HGDYOdtzO
         yysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=neB+q0Kh/QsWUNLfDZS1PKd7092ZvbprenIhcvXZr4s=;
        b=RptQhKdDqrbXAO1y8tITnoykR+MZEHkh+awyvEV8Q68dtJ2NRXmBIqJoFmQnYYb15s
         vPyxwusoym7YbLa6PI4dhdZD0PrbAQj/5pd9UwVLAFUTiMQJ1h87ucptPwMHh9fB17/8
         YbfKI0cPgX7HhVinPUk3CJJnMsc2Sps0WSslOyJo0LVqJCbQpKwMaud5FuI9NaLwOSz/
         OiDwI+2X09QK03g+ymjzvBhCNBDLAKp7gaTGRh1qcOUJowZ2xTrECQL4VnBc0Z2SgS58
         ITdQzPd76KZw+PW5hHoR0K4wCUzH0Qo6aq90ZMm7Iyz2va8HBzyNENP0dcgWHV326pOr
         Cq2Q==
X-Gm-Message-State: ACgBeo3l4cLzilZTvggUsLMqd44QLBf1DBNCuEaFhhYLp79pclsi6gsE
        PZTivqsU6qrxGokWaZ5bItAcLQ==
X-Google-Smtp-Source: AA6agR70GYTX3ilAS5d1f2gctcAwETJuwcR3TW4OSclNNeLqgXdvT9Jce7p5cZBSSsf9/7R9avPxpQ==
X-Received: by 2002:a17:902:788f:b0:16e:f6b8:16c6 with SMTP id q15-20020a170902788f00b0016ef6b816c6mr2331324pll.3.1659625668331;
        Thu, 04 Aug 2022 08:07:48 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b0016c9e5f291bsm1103441plg.111.2022.08.04.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 08:07:47 -0700 (PDT)
Date:   Thu, 4 Aug 2022 15:07:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 2/7] perf/x86/core: Remove unnecessary stubs provided
 for KVM-only helpers
Message-ID: <Yuvgv4QC3oKPlKs2@google.com>
References: <20220803192658.860033-1-seanjc@google.com>
 <20220803192658.860033-3-seanjc@google.com>
 <fcb0e878-29ff-e408-ccf3-3b594160c0df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb0e878-29ff-e408-ccf3-3b594160c0df@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 04, 2022, Like Xu wrote:
> On 4/8/2022 3:26 am, Sean Christopherson wrote:
> > -#if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
> > - extern void amd_pmu_enable_virt(void);
> > - extern void amd_pmu_disable_virt(void);
> > -
> > -#if defined(CONFIG_PERF_EVENTS_AMD_BRS)
> > +#ifdef CONFIG_PERF_EVENTS_AMD_BRS
> >   #define PERF_NEEDS_LOPWR_CB 1
> > @@ -566,12 +538,13 @@ static inline void perf_lopwr_cb(bool lopwr_in)
> >   	static_call_mod(perf_lopwr_cb)(lopwr_in);
> >   }
> > -#endif /* PERF_NEEDS_LOPWR_CB */
> 
> Oops, now the definition of PERF_NEEDS_LOPWR_CB will not be unset.
> This is not mentioned in the commit message and may cause trouble.

PERF_NEEDS_LOPWR_CB isn't being "unset" in the existing code, the comment is simply
wrong.  The #endif pairs with CONFIG_PERF_EVENTS_AMD_BRS.

  #if defined(CONFIG_PERF_EVENTS_AMD_BRS)

  #define PERF_NEEDS_LOPWR_CB 1

  /*
   * architectural low power callback impacts
   * drivers/acpi/processor_idle.c
   * drivers/acpi/acpi_pad.c
   */
  extern void perf_amd_brs_lopwr_cb(bool lopwr_in);

  DECLARE_STATIC_CALL(perf_lopwr_cb, perf_amd_brs_lopwr_cb);

  static inline void perf_lopwr_cb(bool lopwr_in)
  {
  	static_call_mod(perf_lopwr_cb)(lopwr_in);
  }

  #endif /* PERF_NEEDS_LOPWR_CB */ <=== should be /* CONFIG_PERF_EVENTS_AMD_BRS */
