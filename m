Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B1ECAA27
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Aug 2022 19:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbiHYTxS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 Aug 2022 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiHYTxR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Aug 2022 15:53:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0168B14D8;
        Thu, 25 Aug 2022 12:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7855FB82B0E;
        Thu, 25 Aug 2022 19:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F345BC433D6;
        Thu, 25 Aug 2022 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661457194;
        bh=wCZVMtGaA94I1qAzcQon/sEcAeym2CNlsWOaKMCIWrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2ceqzBlG7Vx4QfDM9cP4vIpBydoJ+QK2kR214z/vJpwEbr01DG0FqcQTF+UORxUp
         bCSoQRJIhCMl4Cjc2WAVJpRj91CiXnF4OFVeZpSDrdSPgmlDGtMNB40t1DWOPfM+5m
         Rtewd86CVfFSgrAuzUyfnD2i/9dBuBgqy5RC8I1/PIuryviUlZwheBwbbADE30KrpP
         bbFo1Rk8BUeqB65qODOj0hAUNjVSRVuL/D7C5HdOVXkO9mI6ISvER0X/j4VQvqsbl5
         up9R/SmBy0AwkhYRz3B7DV2ypoMSCES/om+FVyk5hParazFp4/1AEt3FQK2HJ0g+u/
         dhOQz53SfcY7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BA87404A1; Thu, 25 Aug 2022 16:53:11 -0300 (-03)
Date:   Thu, 25 Aug 2022 16:53:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH RFC v1 2/3] perf: Add perf_event_attr::config3
Message-ID: <YwfTJ3k1zgTcejEn@kernel.org>
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
 <20220825-arm-spe-v8-7-v1-2-c75b8d92e692@kernel.org>
 <YwfOHjw/VsIJOPjt@kernel.org>
 <CAL_JsqKdEkA+SGRd+P=WJnZE1YUuMjyPz5JwKz6cttuJ5hA_SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKdEkA+SGRd+P=WJnZE1YUuMjyPz5JwKz6cttuJ5hA_SQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Aug 25, 2022 at 02:43:42PM -0500, Rob Herring escreveu:
> On Thu, Aug 25, 2022 at 2:31 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Thu, Aug 25, 2022 at 01:08:01PM -0500, Rob Herring escreveu:
> > > Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> > > existing perf_event_attr::configN fields are all used up for SPE PMU, an
> > > additional field is needed. Add a new 'config3' field.

> > Try not to have tools/ and kernel code in the same patch, else you'll
> > burden kernel developers into testing tools/, which so far has been
> > refrained.
 
> I knew that, but assumed the header was special...

So, we have tools/perf/check-headers.sh for that purpose, so that tools
developers can have the opportunity to see that the kernel ABI changed,
think about it, check what is needed to best support the new kernel ABI,
etc.

I really love when kernel developers take the time and help with
supporting new features by working on the tools/ bits, that would be
perfect!

But, as we saw just a few days ago, when changes were made in the kernel
and in tools/ in tandem, tools/ got broken just before -rc2:

  "perf tools: Fix compile error for x86"
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cfd2b5c1106fa20254d9f24970232cdf24860005>

So it seems better to first do the kernel work, then do the user part,
to avoid burdening kernel developers with tools/ work.

- Arnaldo
