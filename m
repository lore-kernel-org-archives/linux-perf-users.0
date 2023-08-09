Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FCDC04A94
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Aug 2023 09:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjHIJKo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 05:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHIJKn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2023 05:10:43 -0400
X-Greylist: delayed 2723 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 02:10:41 PDT
Received: from out-81.mta0.migadu.com (out-81.mta0.migadu.com [IPv6:2001:41d0:1004:224b::51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5E71FD0
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Aug 2023 02:10:41 -0700 (PDT)
Date:   Wed, 9 Aug 2023 09:10:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691572240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mvmzvKOGcM7VTd90ZNc4xMJrUWrhIk71OKZHdX1ecXM=;
        b=qrezTWI5AElJZqV9qQGcT9+Kg1Sv+qGaGp0ABG0ROC2hAq8H45AlVEdjXZmLHcWdvrAN3v
        UzgLZj9d3z52lNjfEviNP8FCivMcqGZikDTWDs5h5Ill5r0bZfDRxCFUdB+utjW4CZS/M9
        zYb9t9t6JFETPi3apcQaXR40eklcy1Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huang Shijie <shijie@os.amperecomputing.com>, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com,
        peterz@infradead.org, ingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-perf-users@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com
Subject: Re: [PATCH] perf/core: fix the bug in the event multiplexing
Message-ID: <ZNNYCQjsi30APZQ+@linux.dev>
References: <20230809013953.7692-1-shijie@os.amperecomputing.com>
 <864jl8ha8y.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864jl8ha8y.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 09, 2023 at 09:48:29AM +0100, Marc Zyngier wrote:

[...]

> Another question is how the same thing is handled on x86? Maybe they
> don't suffer from this problem thanks to specific architectural
> features, but it'd be good to find out, as this may guide the
> implementation in a different way.

I'm pretty sure the bug here is arm64 specific. x86 (at least on intel)
fetches the guest PMU context from the perf driver w/ irqs disabled
immediately before entering the guest (see atomic_switch_perf_msrs()).

-- 
Thanks,
Oliver
