Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39682C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 18:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJDSOf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJDSOc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2022 14:14:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022367CB6
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Oct 2022 11:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF87B614F4
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Oct 2022 18:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32603C433D6;
        Tue,  4 Oct 2022 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664907270;
        bh=jclFgCrFUBn52qvUWEPs5SL9Ek1Ns+2EbUXKGu56P5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jH3DB9eLjbBMsr8xuoLQUMS4XpT9bSi47/jFb/UHoeBrHxHkcLIFJj4qaGZRS0bmm
         mudXMvdEp0MbWERQNjHPsxAIIp5esA4gbONuN/VzVGuJfN1HP6QrvGeaV9gM3dfgGJ
         UE13UfjPIjIQrWUJ7CQGuDEDkZ4kZ1HVO8laxikUb0aD4sO/KfDK/2Qc5UZxWW+hN7
         krchhsplTYUBSJotrVEM9cvVfclB8oD6lLbWsFyMQSuPJSw4Mxckg0eR+fymJ/L4qG
         T9rX5q5rMvOvw/F9s+x2ZcUMBrmyfPYFZ7vqwO9XNzXZ6sHCnV+meeSNQ90gBnM7as
         1RKBf3vl1QCCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F16114062C; Tue,  4 Oct 2022 15:14:27 -0300 (-03)
Date:   Tue, 4 Oct 2022 15:14:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        atrajeev <atrajeev@imap.linux.ibm.com>, maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tools/perf: Fix aggr_printout to display cpu field
 irrespective of core value
Message-ID: <Yzx4A+2I4yWTlbEn@kernel.org>
References: <20220913115717.36191-1-atrajeev@linux.vnet.ibm.com>
 <4792ef3a-8790-a0d4-50f2-4917874d81d6@arm.com>
 <82D5587E-593A-43A7-92D7-7E095E2BE9A9@linux.vnet.ibm.com>
 <6627ae9a-91e3-0923-1234-54e0fc3f4916@arm.com>
 <CAP-5=fVBzLfhfwPjxE_9DNeesPaPxf3k0b5T5S6THzB1H85mrA@mail.gmail.com>
 <993a1391ee931e859d972c460644d171@imap.linux.ibm.com>
 <CAP-5=fWJ0YBxdCarpNSfbzoAZ9uTAtgj4CdR7sQU8748Y-+DVA@mail.gmail.com>
 <6A5D0603-CF66-43B4-A13F-0308CF01967A@linux.vnet.ibm.com>
 <CAP-5=fU=bwv-e_53QagWsKvW8wjibOjfGvnivWFFVba5A55boA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU=bwv-e_53QagWsKvW8wjibOjfGvnivWFFVba5A55boA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Oct 04, 2022 at 07:49:21AM -0700, Ian Rogers escreveu:
> On Tue, Oct 4, 2022, 12:06 AM Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Thanks for helping with testing. Can I add your Tested-by for the patch ?
 
> Yep.
 
> Tested-by: Ian Rogers <irogers@google.com>
 
> Thanks,
> Ian
