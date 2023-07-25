Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E1CC001DE
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Jul 2023 12:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjGYMKn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGYMKn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Jul 2023 08:10:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52CC10D1;
        Tue, 25 Jul 2023 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A2V9CSb8/y4hxyqm6Ss/vkxK+iOPYKv+1yclOyzBI9Q=; b=NyZHBOXxIo7BdML3h3Ngbsaoi+
        mJrSdyT99/3mkZPabOUjfUkyE3aCGqfWqI0AmtD4xv6dcCG7wmKn3LkrFVeb+XgIKCvxdeG75VV7L
        UnQvnJQ3MSocxa8Cw2rnJgUZnjJ3o3/JhzZ1KJ2MAYoNTuv9Llk+cT4oAf0kabzsyedusfRLFjMUk
        v5WYRibviHvjeq3H0ABkOlf/VGFwL/h6hjNeNPKGiep3SnqU/kbOpU9fx0/HeYJbQZ6Ds+qPlt0cO
        Tg3T2HZLjCW3lHjoWAw9KgJejhyzeKQf09EEiTqfNaERXmOEn0diI8jYpVoSYTgAjKhyXnR0Qy+SB
        HC136A+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOGrw-0047kb-1v;
        Tue, 25 Jul 2023 12:10:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D7A9300137;
        Tue, 25 Jul 2023 14:10:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 368242612ABE5; Tue, 25 Jul 2023 14:10:23 +0200 (CEST)
Date:   Tue, 25 Jul 2023 14:10:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        anshuman.khandual@arm.com, will@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE
 capability
Message-ID: <20230725121023.GH3765278@hirez.programming.kicks-ass.net>
References: <20230724134500.970496-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724134500.970496-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 24, 2023 at 02:44:55PM +0100, James Clark wrote:

> James Clark (4):
>   arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
>   perf/x86: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
>   arm_pmu: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
>   perf: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
> 
>  arch/x86/events/core.c     |  1 -
>  drivers/perf/arm_pmu.c     | 10 ++++++----
>  include/linux/perf_event.h |  7 +++----
>  3 files changed, 9 insertions(+), 9 deletions(-)

Thanks!
