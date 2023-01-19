Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CCEC38159
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 05:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjATF3P (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjATF2e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70406C119
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 21:23:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F56EB82653
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 17:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2D3C433EF;
        Thu, 19 Jan 2023 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674147600;
        bh=0LgZVJyAgZJnPBzrQQTPDRzVjAbI65GHyE56eV+lyrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xd3Bf6HHJcFCVAu8Rq+CoFDPZNFAh7dqGytDjxmbArUWhhPzs8PxvNZwKsfm+VCEs
         US6ko6KiHQ4PoWfY0xCSUGfNwGWY9K8GMObRYcpQXWzBA32CKeGAOm3KytAsdmIF4+
         Oyp6PgOY6Ttfy5dXpT3BHvh8h1I39DJ6Yue6zYDzQ7+pZOEVKGhy7T6hlbSARFQLqm
         JOHRat9zJjB9axRb33H55KfeVQtoioCDQFHOqLMnwx9QEm7NVqCg+Dj1/NYw/+Aeza
         8V6GLSRdtfYaNBwLa2gEMUvepganuoZqsYWwyTpD+PwzXVpvbiUX4FJVUgl4nriMJC
         F5FuEMdIxCFZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 60534405BE; Thu, 19 Jan 2023 13:59:55 -0300 (-03)
Date:   Thu, 19 Jan 2023 13:59:55 -0300
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
Message-ID: <Y8l3C8LOohZvQOKH@kernel.org>
References: <20230119142719.32628-1-atrajeev@linux.vnet.ibm.com>
 <1a2f988593a4403db2a043ff42886ced@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2f988593a4403db2a043ff42886ced@AcuMS.aculab.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jan 19, 2023 at 03:49:15PM +0000, David Laight escreveu:
> From: Athira Rajeev
> > Sent: 19 January 2023 14:27
> ...
> > The test script "tests/shell/buildid.sh" uses some of the
> > string substitution ways which are supported in bash, but not in
> > "sh" or other shells. Above error on line number 69 that reports
> > "Bad substitution" is:
> 
> Looks better - assuming it works :-)

:-)

Can I take this as an:

Acked-by: David Laight <David.Laight@ACULAB.COM>

?

- Arnaldo
