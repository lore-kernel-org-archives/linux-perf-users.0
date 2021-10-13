Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D2AC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B09761152
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 15:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhJMPgV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhJMPgV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 11:36:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B6616113E;
        Wed, 13 Oct 2021 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634139257;
        bh=zWogLvkEl3unCoYeF+s2zvQhnPYnGg/843EaXjemURw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSyLspcthTTTjoe9lKO2PfRV1Im8RqjwooDYen/IrUd0zdQHofAYWU3hDvN7F0vfR
         3lTs9y/bokY6psRbMsmpQbxiGhCo/2lQjdBukIqpG/TiTGEBb+yTHma4uOvCaRTsQw
         hTnUrKosF19BAVh0OaNfMy9rVYfopKHAH0ZS5szR2T1QhD3x9zn3cXzeKurte4XGFW
         AF5qTMM0f30fv8lxV4DubV/sfmm0YlsUla6GWmF6il4bvgl+W+LHzpeyCscyVvBRdN
         6ZCcmGLbRPDhy/xm0IAxrMyX08sR9bPAem4cwvJkMRB8Qq3Ts/M/i+Ko3LDqKwl34t
         GEy9GwCBCZhSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D52C3410A1; Wed, 13 Oct 2021 12:34:14 -0300 (-03)
Date:   Wed, 13 Oct 2021 12:34:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] perf/x86: Add new event for AUX output counter
 index
Message-ID: <YWb8dt6whVpf8rGF@kernel.org>
References: <20210907163903.11820-1-adrian.hunter@intel.com>
 <20210907163903.11820-2-adrian.hunter@intel.com>
 <ab6f9ec2-2571-de5a-d44a-427851b08d19@linux.intel.com>
 <20210910160409.GI4323@worktop.programming.kicks-ass.net>
 <453b9364-c350-79ca-00fa-b9e6ed6e3367@linux.intel.com>
 <9da4ae5e-3e0e-180e-5bba-1351c08d7df9@intel.com>
 <87k0j7hzaw.fsf@ashishki-desk.ger.corp.intel.com>
 <3211feb9-b8e3-21fc-958c-07c7c7766bf2@intel.com>
 <YWbqjfPVx7AjSe5o@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWbqjfPVx7AjSe5o@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 13, 2021 at 04:17:49PM +0200, Peter Zijlstra escreveu:
> On Wed, Oct 13, 2021 at 12:12:48PM +0300, Adrian Hunter wrote:
> 
> > Will anyone takes these patches?  Perhaps Arnaldo if no one objects?
> > The patches still seem to apply cleanly.
> 
> I've picked up the first. But if acme wants to route the whole lot:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>


I'll pick the rest, thanks.

- Arnaldo
