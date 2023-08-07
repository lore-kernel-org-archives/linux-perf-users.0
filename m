Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB78C001DF
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Aug 2023 21:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHGVTg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHGVTf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2023 17:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FFFE7F
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Aug 2023 14:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D8662252
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Aug 2023 21:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A316C433C9;
        Mon,  7 Aug 2023 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691443173;
        bh=xZZy1LMAyCIz0vNMcgNk01VXZ57vkAT/9FTncjwi7jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUHCOgov6scJzivL96MPzt+BMxji2V8FgxHkCMbl3GH6K2s1VtvhqXDmKy4/vSibT
         OWyNV6gOSAYv/MQcaFA+jjVRCx+qpkmm56K2mU/T0846pH6+hIsSTFc4gtd2iwDFWm
         HH21uzK1qQ5PQEQd2FQyiVFZ7aQ4sMxnKgBKWhIG6s5QPKlR5bdEmPZCPrfiGck5QQ
         0kybmRi6Zxt+AHCg8NTFbGGi8754Bd44z3UeyUhysTzgB8nLm/n+6U1QzFlv5uG3/M
         Q1ohXxRNye7z9KuyF6lzTrcaY1PRth32Ne0sEF3r4ozKzKypRHE21XA9NLPPFH11R2
         5LyqLJwL61npw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CCE38404DF; Mon,  7 Aug 2023 18:19:30 -0300 (-03)
Date:   Mon, 7 Aug 2023 18:19:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Disha Goel <disgoel@linux.ibm.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V2 2/2] tools/perf/tests: perf all metricgroups test
 fails when perf_event access is restricted
Message-ID: <ZNFf4iliPNnqlvbH@kernel.org>
References: <20230804050047.94240-1-atrajeev@linux.vnet.ibm.com>
 <20230804050047.94240-2-atrajeev@linux.vnet.ibm.com>
 <3c0eb25b-a51b-edba-82ea-22e6d2b07978@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c0eb25b-a51b-edba-82ea-22e6d2b07978@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 07, 2023 at 08:14:39PM +0530, Disha Goel escreveu:
> On 04/08/23 10:30 am, Athira Rajeev wrote:
> > Perf all metricgroups test fails as below when perf_event access
> > is restricted.
> > 
> >      ./perf test -v "perf all metricgroups test"
> >      Testing Memory_BW
> >      Error:
> >      Access to performance monitoring and observability operations is limited.
> >      Enforced MAC policy settings (SELinux) can limit access to performance
> >      access to performance monitoring and observability operations for processes
> >      without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> > 
> >      test child finished with -1
> >      ---- end ----
> >      perf all metricgroups test: FAILED!
> > 
> > Fix the testcase to skip those metric events which needs perf_event access
> > explicitly. The exit code of the testcase is based on return code of
> > the perf stat command ( enabled by set -e option ). Hence save the
> > exit status in a variable and use that to decide success or fail for the
> > testcase.

I wonder if we shouldn't somehow check if the credentials needed to
performing a test shouldn't be checked before trying it. This way we
would check if the check that the tool or the kernel is doing is the
appropriate one.

I.e. the kernel refusal for doing something may be an error.

- Arnaldo

> > Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
> 
> With this patch applied(on power) perf metricgroups test works correctly when perf_event access is restricted.
> 
>  # ./perf test "perf all metricgroups test"
>  96: perf all metricgroups test                                      : Ok
> 
> Tested-by: Disha Goel<disgoel@linux.ibm.com>
> 
> > ---
> > Changelog:
> > v1 -> v2:
> >   Changed the condition to use "echo" and "grep" so it works on
> >   Posix shell as well.
> > 
> >   tools/perf/tests/shell/stat_all_metricgroups.sh | 14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> > index cb35e488809a..eaa5e1172294 100755
> > --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
> > +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> > @@ -2,11 +2,19 @@
> >   # perf all metricgroups test
> >   # SPDX-License-Identifier: GPL-2.0
> > 
> > -set -e
> > -
> >   for m in $(perf list --raw-dump metricgroups); do
> >     echo "Testing $m"
> > -  perf stat -M "$m" -a true
> > +  result=$(perf stat -M "$m" -a true 2>&1)
> > +  rc=$?
> > +  # Skip if there is no access to perf_events monitoring
> > +  # Otherwise exit based on the return code of perf comamnd.
> > +  if echo "$result" | grep -q "Access to performance monitoring and observability operations is limited";
> > +  then
> > +      continue
> > +  else
> > +      [ $rc -ne 0 ] && exit $rc
> > +  fi
> > +
> >   done
> > 
> >   exit 0

-- 

- Arnaldo
