Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C7AC05027
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 14:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjATO36 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjATO3z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 09:29:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA40CFD1E
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 06:29:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4405BCE28B5
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 14:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682A7C433D2;
        Fri, 20 Jan 2023 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674224961;
        bh=IBjuEA1LYU7gz0sqSmBd2iSa+BLtKQyEXGOlz3negME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQBdHtotEDhbBlIuQFXXRtgly8zOJJoZ6Iciib1jvWIjAOMsHBdSvF9ncEfibNEer
         cqPl9o/UQwVf6EL6NMLWWs2JZVe4YE3X4oEYj1rnQ4gibzpmvTS8JZXgycYA4XvXyE
         5Pv1gFlIia3/uO0RMly2xM+K4OGm5qVLhn5xzB1cT2HLoo/MCkvSg+qDPR2EcuXvpv
         zgixVJq5yReDkLg6H7fp9bxaMU5THMpKGl5BUfVORmitGOFKIpOTpo39rAM5EGiaxi
         tZK7Zs6fVc1iA46v8TZdZ1M03RZBBF1hc1X5sQ+1LcU1u2dS6AYTsg9Wf35Q+E2Yhf
         jrzM0iFWFP18Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34352405BE; Fri, 20 Jan 2023 11:29:19 -0300 (-03)
Date:   Fri, 20 Jan 2023 11:29:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Athira Rajeev' <atrajeev@linux.vnet.ibm.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
        "rnsastry@linux.ibm.com" <rnsastry@linux.ibm.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "disgoel@linux.ibm.com" <disgoel@linux.ibm.com>
Subject: Re: [PATCH V3] tools/perf/tests: Fix string substitutions in build
 id test
Message-ID: <Y8qlP+mmgW0M80u3@kernel.org>
References: <20230119142719.32628-1-atrajeev@linux.vnet.ibm.com>
 <1a2f988593a4403db2a043ff42886ced@AcuMS.aculab.com>
 <Y8l3C8LOohZvQOKH@kernel.org>
 <8c433a543cda48e5b736312903355918@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c433a543cda48e5b736312903355918@AcuMS.aculab.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jan 20, 2023 at 08:51:59AM +0000, David Laight escreveu:
> From: Arnaldo Carvalho de Melo
> > Sent: 19 January 2023 17:00
> > 
> > Em Thu, Jan 19, 2023 at 03:49:15PM +0000, David Laight escreveu:
> > > From: Athira Rajeev
> > > > Sent: 19 January 2023 14:27
> > > ...
> > > > The test script "tests/shell/buildid.sh" uses some of the
> > > > string substitution ways which are supported in bash, but not in
> > > > "sh" or other shells. Above error on line number 69 that reports
> > > > "Bad substitution" is:
> > >
> > > Looks better - assuming it works :-)
> > 
> > :-)
> > 
> > Can I take this as an:
> > 
> > Acked-by: David Laight <David.Laight@ACULAB.COM>
> 
> I'm not sure that is worth anything.
> You can add a Reviewed-by

Thanks, I'll then add:

Reviewed-by: David Laight <David.Laight@ACULAB.COM>

- Arnaldo
