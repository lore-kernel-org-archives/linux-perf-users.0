Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA9C47080
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514116138C
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhFAJvD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJu6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 05:50:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD03C061574;
        Tue,  1 Jun 2021 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EuGCCm5EZ/sX+eHD5FHi6GnTzOhSNCWdbP2mdYLbgnU=; b=ujEzvQevKkdCAW/w9IhRubqD9H
        7ex6ULSAG8gXwx5HueR1BWQt0o1QbjnPD4qWvVsbfhTgN9UAsF5OdTdfinFotswHpvJMB6duQ24DD
        OQMaKep/FhBTAYhIsIoXFU35moBWqcfJJserOj+fnP9gbdqFMgcap6VFQhhqiHoSJZl74OfqlPf23
        MDgnZ9/EB4ypM98hHhEnO9CADZRRJrSeQPQ3m7yzKj8Vn/zBpheWbvemXj+JCgEta0uM15fiuYvze
        atHA85j6uRQ/jNFlarND5lOgp/cLgt0+Z/F9ZyhTomT2jSOb6LKoGq4VgV+TEGCDY5qmJ8F9FLqzU
        Oh99UoVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lo112-009tW8-TS; Tue, 01 Jun 2021 09:48:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EEF83300223;
        Tue,  1 Jun 2021 11:48:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B35F12011CA24; Tue,  1 Jun 2021 11:48:51 +0200 (CEST)
Date:   Tue, 1 Jun 2021 11:48:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with
 load-acquire and store-release
Message-ID: <YLYCg3VF+rzmGiJj@hirez.programming.kicks-ass.net>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
 <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
 <20210601063342.GB10026@leoy-ThinkPad-X240s>
 <71b0e395-0e20-fdd1-b105-0ca1706c8ed1@intel.com>
 <YLX7OhK37QmfeOwu@hirez.programming.kicks-ass.net>
 <4af1a96d-e03c-f1b4-ebce-ca869318c8cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af1a96d-e03c-f1b4-ebce-ca869318c8cf@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 01, 2021 at 12:45:16PM +0300, Adrian Hunter wrote:
> On 1/06/21 12:17 pm, Peter Zijlstra wrote:
> > On Tue, Jun 01, 2021 at 12:07:31PM +0300, Adrian Hunter wrote:
> >> __sync_xxx_compare_and_swap is out-of-date now. This page:
> >>
> >> https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html#g_t_005f_005fsync-Builtins
> >>
> >> recommends '__atomic' builtins instead.
> > 
> > perf doesn't seem to use that.
> 
> I guess we could drop support for the compat case; add validation:
> 
> "Error, 32-bit perf cannot record AUX area traces from a 64-bit kernel.
> Please use a 64-bit version of perf instead."

For AUX, possibly, sadly the exact same problem exists for the normal
buffer IIRC.
