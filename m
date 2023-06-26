Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA44EB64D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 15:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFZPK7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjFZPKj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 11:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE310DC
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 08:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE0760ECB
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 15:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D23C43397;
        Mon, 26 Jun 2023 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687792193;
        bh=VyY1nTQL7rVffzwKO6788a77rHxEzwZkW4th3uLFngU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZ0YScVgNaFKPJVHNCqzaBrAnGJrBUSViKbNspDqpnwX6Gp3s74rifzZNvOPWtKlx
         NmCT9AspmPh3On2KYONbjTRZxNywwmzSSLki/Jl+8XLC8fY1ILeWmCU9FkH8eu2aFW
         LUsRPDmepEWLsAvql89a1wrDWfygRaKMOri1AACFZLf0nfXMc1HzsJCqYl2yr/ekvB
         c5tu8sjoYarOPTDh1QCjDh8D1R8VEcoGuRQKzFaPaU3+L+WBG5EaqE2n3R3f09XeVB
         aKryes7qeBW+Y8/fugtYJDn6nVldh328ZO+lN+CJhe6ManoHg3u05n/+F0DVrifI6H
         ksefGi8TzrgRA==
Date:   Mon, 26 Jun 2023 16:09:46 +0100
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>, mark.rutland@arm.com
Subject: Re: perf-tools-next: Request for testing hybrid changes
Message-ID: <20230626150945.GA20321@willie-the-truck>
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com>
 <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
 <20230626123249.GC19941@willie-the-truck>
 <57ea7d37-83bd-80ba-3342-93598a88ac20@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57ea7d37-83bd-80ba-3342-93598a88ac20@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Mon, Jun 26, 2023 at 03:39:00PM +0100, James Clark wrote:
> On 26/06/2023 13:32, Will Deacon wrote:
> > What does PERF_PMU_CAP_EXTENDED_HW_TYPE buy us on Arm, given that we've
> > supported heterogeneous PMUs for years without issues? In other words,
> > what is the benefit of supporting two user ABIs here?
> > 
> Aren't there some issues around per-process perf sessions and choosing
> which PMU to use?
> 
> For example on Juno if I run perf on one of the big cores (1 and 2),
> then I only get an accurate cycle count if the process I'm interested in
> also runs on a big core:
> 
>   taskset --cpu-list 1 perf stat -e cycles -- taskset \
>    --cpu-list 1 stress -c 1 -t 1
> 
>   1087015046      cycles:u
> 
> If the stress process runs on a small core (4 for example) then I get a
> much lower count, which I think is only accounting for the taskset
> before it finishes pinning stress to the small core:
> 
>   taskset --cpu-list 1 perf stat -e cycles -- taskset \
>     --cpu-list 4 stress -c 1 -t 1
> 
>   68134032      cycles:u
> 
> Then if perf starts on a small core it gets even worse, you never get
> any cycle counts, even if stress runs on the same core:
> 
>   taskset --cpu-list 0 perf stat -e cycles -- taskset \
>     --cpu-list 0 stress -c 1 -t 1
> 
>   <not counted>      cycles:u
> 
> I'm not sure how many of these are just the perf tool doing the wrong
> thing and should be fixed in other ways than using
> PERF_PMU_CAP_EXTENDED_HW_TYPE. But there is also something to be said
> for consistency that if PERF_PMU_CAP_EXTENDED_HW_TYPE is already
> understood by the tool as a way to use different PMU types then
> supporting it on Arm might make sense.

I think the above is just an example of how the ABIs differ and doesn't
reflect a limitation of either, no? In other words, if you drive it wrong,
then yes, you get the wrong result. That's the same with any heterogeneous
system. I agree that consistency is great, but we've been exposing
heterogeneous PMUs on arm for what, a decade now? It feels a little
disingenuous to say we should be consistent with something that's this
hot off the press.

Anyway, my main question is still largely unanswered: what does the new
ABI gain us over what we have? Is it documented somewhere? For example,
how does it handle things like:

  - Different number of hardware counters across CPU types
  - An event that might not be supported across different CPU types
  - Events that might collide across CPU types (e.g. raw events that have
    the same encoding but count something different)

From what I can tell, the main difference between the interfaces seems to
be the level of resourcing that Intel and Arm have each put into the
tooling, and I don't think that's a particularly compelling reason to
take on the burden of maintaining both in the kernel. However, if there
are functional benefits with PERF_PMU_CAP_EXTENDED_HW_TYPE over what we've
been doing them I'm keen to hear about them.

Will
