Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD6C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Mar 2022 11:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiCQL2z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Mar 2022 07:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCQL2z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Mar 2022 07:28:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98561E3E16;
        Thu, 17 Mar 2022 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6pSjtFwZExqOXA+yysNgtvdz+muXo5bfQL+YBtE9pIU=; b=iG6ZHYm09e+pzmWv7SrbFgUFNu
        QW7P4qPMvTf9Iv9kqoiSPrZY5PB2irtdQEjRan1bsLaTfYRlfte+n7e67FBphG0RPMWMd7a+7IcRM
        uMgJt6Z0NE3rz5VsbVhew8lJDu173grOW8GwaBUfq1dyekucOjm8d6cN28ATM3S7C7d5JsmNQgvHe
        eFkZv2nHnVoGB2/EbKOHIQdqv5Kyi0vzjTIL0wXDjVMPfInGlwXCymNyLvjZKLQYd5ijzqUp2Pqw8
        Wl1Cr1veut6D0bFKTPS+3nk/D7LPqAWG/f2B3quw0yyy4IQtRwHFZxOSp2YzsVySkLXC6AF7jSGzj
        WSSEnTiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUoHs-001s9t-U1; Thu, 17 Mar 2022 11:27:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FF333001EA;
        Thu, 17 Mar 2022 12:27:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DD7422B9050A; Thu, 17 Mar 2022 12:27:24 +0100 (CET)
Date:   Thu, 17 Mar 2022 12:27:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 3/7] perf/x86/amd/core: Detect PerfMonV2 support
Message-ID: <YjMbHKwtOKJTfVIh@hirez.programming.kicks-ass.net>
References: <cover.1647498015.git.sandipan.das@amd.com>
 <1ddd003765ac0d057b2137eab869be4ffee69473.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ddd003765ac0d057b2137eab869be4ffee69473.1647498015.git.sandipan.das@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Mar 17, 2022 at 11:58:32AM +0530, Sandipan Das wrote:
> AMD Performance Monitoring Version 2 (PerfMonV2) introduces
> some new Core PMU features such as detection of the number
> of available PMCs and managing PMCs using global registers
> namely, PerfCntrGlobalCtl and PerfCntrGlobalStatus.
> 
> Clearing PerfCntrGlobalCtl and PerfCntrGlobalStatus ensures
> that all PMCs are inactive and have no pending overflows
> when CPUs are onlined or offlined.
> 
> The PMU version (x86_pmu.version) now indicates PerfMonV2
> support and will be used to bypass the new features on
> unsupported processors.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---

> +static void amd_pmu_cpu_reset(int cpu)
> +{
> +	if (x86_pmu.version < 2)
> +		return;
> +
> +	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
> +	wrmsrl_on_cpu(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
> +
> +	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
> +	wrmsrl_on_cpu(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
> +		      amd_pmu_global_cntr_mask);
> +}

I think these can be wrmsrl() both starting and dead run on the target
cpu.
