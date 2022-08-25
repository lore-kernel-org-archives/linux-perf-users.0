Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A2C32774
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Aug 2022 15:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbiHYPXd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 Aug 2022 11:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiHYPXc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Aug 2022 11:23:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDEFB8F34
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Aug 2022 08:23:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso5414334pjj.4
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Aug 2022 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=AHkYLosTUlLzDn2E62SzaMtiFX4B6CYSNh1rEJtPsS4=;
        b=XPykrXJnPtaVVrcd0/FJM5bJ9x9N5oHBNowUK8REQaSIxJQ5fgVKbic+daIEsTLBOU
         IKpjQwIrvsj2ME1uePBk8XBmSpeHN/Y2DAjzHA+GXh4eJsBGKETloAde1aQkHimPT58b
         pvkTlFbtDXHIWrRapcCaWLNnpo2MANPsafKsdX2vDNg9JyB+N/CNIBhTCExmOO4xajXP
         Ksc0vDokShK7dWI3bwEkRrkkriGPpqpMxrUePfPivUBdZqMNTqxAJsVpJXbi3qIDuwwR
         RNDAYnIPXqv8vjH3P8dK8RCHGhR0KYCCuM+W7aZ0RFngklXvwzrIJhcKzgYimQ1naZty
         7cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AHkYLosTUlLzDn2E62SzaMtiFX4B6CYSNh1rEJtPsS4=;
        b=YhdGpCVFjUW0Vkp8ch7grnoCp7otBa4HM4re8oLISFsFOTwB7cf/eWnWbcUl5s/q9Z
         h6L8xLlwgCAkewKLAdbNMEC0YPQgGTgbxBYWoBsWgF5qACjDF5HzKexZkgkrrw/OX9a3
         QcI+gwZ9PAyBm8wEck3CCkuOJRbj75r1iS+ERUxIpRhmo4PtQ389XIxoB39JJpPPsVyL
         PabMK2qnvCjuvMdSLSUbKsdtJEHZhVpkzZufkhYfGhH6v2+Exh5sKXZ/Hm4U840BFGBj
         RW8Y4oODJRnjORnQ8WQzMBs8jE8gD1NWG9LRQAPxmOyU/TDKdvQNfSnrMvnlPnXa1RTa
         RzCw==
X-Gm-Message-State: ACgBeo2XpGDD5rrTGQ105JJ32IOOQPBrD80WN53o4u5PY4QdwIn8UEcq
        bKY4faFJqKaBq0xYMmAltOBqdA==
X-Google-Smtp-Source: AA6agR7ecob0vG/6HjfUWKLFj9Rm64OSuEbn9LI4vl068lplif764DZbpGrjjFpYzOE8yxwJfuwZkg==
X-Received: by 2002:a17:902:ce81:b0:172:9ac1:6ee with SMTP id f1-20020a170902ce8100b001729ac106eemr4104207plg.93.1661441010644;
        Thu, 25 Aug 2022 08:23:30 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a1f0400b001fa79c1de15sm3640192pja.24.2022.08.25.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:23:30 -0700 (PDT)
Date:   Thu, 25 Aug 2022 15:23:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] perf/x86/intel/pt: Introduce
 intel_pt_{stop,resume}()
Message-ID: <YweT7jqpHI0+JHi+@google.com>
References: <20220825085625.867763-1-xiaoyao.li@intel.com>
 <20220825085625.867763-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825085625.867763-2-xiaoyao.li@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 25, 2022, Xiaoyao Li wrote:
> KVM supports PT_MODE_HOST_GUEST mode for Intel PT that host and guest
> have separate Intel PT configurations and work independently. In that
> mdoe, KVM needs to context switch all the Intel PT configurations
> between host and guest on VM-entry and VM-exit.
> 
> Before VM-entry, if Intel PT is enabled on host, KVM needs to disable it
> first so as to context switch the PT configurations. After VM exit, KVM
> needs to re-enable Intel PT for host. Currently, KVM achieves it by
> manually toggle MSR_IA32_RTIT_CTL.TRACEEN bit to en/dis-able Intel PT.
> 
> However, PT PMI can be delivered after MSR_IA32_RTIT_CTL.TRACEEN bit is
> cleared. PT PMI handler changes PT MSRs and re-enable PT, that leads to
> 1) VM-entry failure of guest 2) KVM stores stale value of PT MSRs.
> 
> To solve the problems, expose two interfaces for KVM to stop and
> resume the PT tracing.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/events/intel/pt.c      | 11 ++++++++++-
>  arch/x86/include/asm/intel_pt.h |  6 ++++--
>  arch/x86/kernel/crash.c         |  4 ++--
>  3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 82ef87e9a897..55fc02036ff1 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -1730,13 +1730,22 @@ static int pt_event_init(struct perf_event *event)
>  	return 0;
>  }
>  
> -void cpu_emergency_stop_pt(void)
> +void intel_pt_stop(void)
>  {
>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
>  
>  	if (pt->handle.event)
>  		pt_event_stop(pt->handle.event, PERF_EF_UPDATE);
>  }
> +EXPORT_SYMBOL_GPL(intel_pt_stop);
> +
> +void intel_pt_resume(void) {

Curly brace goes on its own line.

> +	struct pt *pt = this_cpu_ptr(&pt_ctx);
> +
> +	if (pt->handle.event)
> +		pt_event_start(pt->handle.event, 0);
> +}
> +EXPORT_SYMBOL_GPL(intel_pt_resume);
>  
>  int is_intel_pt_event(struct perf_event *event)
>  {
