Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2152C2BB9A
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Dec 2020 14:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42D022B2A
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Dec 2020 14:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgLQOi5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Dec 2020 09:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgLQOi4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Dec 2020 09:38:56 -0500
Date:   Thu, 17 Dec 2020 11:38:30 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608215896;
        bh=iLt+J3PgOwSlZKRUlu6BZXoBI29ETmQwu2XW/JvqzLg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKphHGAb3buVJFbh8BY+6Koj430VRInWXkFARHfdgOhmksteoChBHhfGd66pz8rZS
         sfAZuwpZmfZboBERO/UG7ITIC/lXhqIwekvO8x9SeZRwGecDEoAVjcQbf2fQg8Z6FI
         EtIVKfQpufRz++feqXlhMrx7j1FHqRCUhA/z67cyhXxbMlNPktzvvYCKSdsjNws6rX
         V0/Hc8oGExqLf3P460881DZwD6oDLYitHzqZtvNGTvTNumqL3nYVN5YDTP+yc4fjJF
         1o1OIZspxlN32OdolkH7F9W72XQKsyP06bqVatAG63/O8ZhYGIm8nPNOT5suEv+TGd
         9cWSlLT6LHEAw==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Thompson <nathompson7@protonmail.com>
Cc:     trivial@kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf config: Fix example command in manpage to conform
 to syntax specified in the SYNOPSIS section.
Message-ID: <20201217143830.GA309398@kernel.org>
References: <4NRiGHoarpAH9Bm8v4IALfprSaF_-io8e27O4A486cEAHRfNccrU0jOWM4Bep37oMSUSNk565zwqiWac_l-nYQXfPBWgAtDjWBJVfO4SbrY=@protonmail.com>
 <20201217142619.GA14524@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217142619.GA14524@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Dec 17, 2020 at 11:26:19AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Dec 16, 2020 at 05:29:43PM +0000, Nick Thompson escreveu:
> > Attached is a trivial fix to the syntax in the perf config man page.
> 
> 
> Thanks, I've added this to complement the commit log message, and as
> well your Signed-off-by, ok?


Oops, I mean this:

perf config: Fix example command in manpage to conform to syntax specified in the SYNOPSIS section.

Committer testing:

With the previously documented example:

  $ perf config --user report sort-order=srcline
  The config variable does not contain a section name: report
  $

With the fixed example line:

  $ perf config --user report.sort-order=srcline
  $ perf config --user report.sort-order
  report.sort-order=srcline
  $

Signed-off-by: Nick Thompson <nathompson7@protonmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/linux-perf-users/20201217142619.GA14524@redhat.com/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

