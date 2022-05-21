Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3235AC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 May 2022 17:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbiEURwJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 May 2022 13:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344419AbiEURwI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 May 2022 13:52:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16C02871A
        for <linux-perf-users@vger.kernel.org>; Sat, 21 May 2022 10:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59758B80948
        for <linux-perf-users@vger.kernel.org>; Sat, 21 May 2022 17:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0285C385AA;
        Sat, 21 May 2022 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653155522;
        bh=2/n5JrWpmpYECdth3FvUmQTIKjToGNXS/pFJfIMr7TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyhKAyJ1frcVMhe5DThh7+fUVFF8xPhcEnysuil2FUP4NZmN3QSD1Fq2EzWE4AXzi
         BQEV0l27ESNI+qS3/+Eg+CXjukc6bnQfEwU9bD3eqtzOHOPZDXlaCcD9AtEQnvspV9
         jeeAQY/bm2h8TVoGUgTpqSfnUbKeXBOXsStigHlH1atyk0BmgoS1s2bpmCYYiTpBUz
         uT2/aVqLVk0uf/5qYblrAQTywgfPkGDQvFadfnTzoc3shg1vefickSbSPBbvFcrmyC
         NpWKB23cIQZ+VXUl9dn5Sroi1s4qAlgSfBNb8RDNWVoNJbqPljBKD+RMGAox6ADXKE
         9smBsYMcbjcXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 65407400B1; Sat, 21 May 2022 14:52:00 -0300 (-03)
Date:   Sat, 21 May 2022 14:52:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>, kjain@linux.ibm.com
Subject: Re: [PATCH V2] tools/perf/tests: Fix session topology test to skip
 the test in guest environment
Message-ID: <YokmwM4weyhr9G7u@kernel.org>
References: <20220511114959.84002-1-atrajeev@linux.vnet.ibm.com>
 <151b1538daf92259702242dbf734230aea3199fe.camel@linux.vnet.ibm.com>
 <CAP-5=fVAfjUHvhLF2E2UZo+BwneSex0GV5BgbHAV6bvdUxj_9w@mail.gmail.com>
 <BD2D6432-8327-4090-958A-71573169E9AA@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD2D6432-8327-4090-958A-71573169E9AA@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, May 21, 2022 at 10:16:59AM +0530, Athira Rajeev escreveu:
> > On 14-May-2022, at 12:03 AM, Ian Rogers <irogers@google.com> wrote:
> > On Thu, May 12, 2022 at 11:18 PM Disha Goel <disgoel@linux.vnet.ibm.com> wrote:
> >> Tested the patch on powerpc and powernv, session topology test works fine with the patch.
> >> Tested-by: Disha Goel <disgoel@linux.vnet.ibm.com>

> > Acked-by: Ian Rogers <irogers@google.com>
 
> Thanks all for the review.

Thanks, applied.

- Arnaldo

