Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A9DC7EE22
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 17:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjEJRQO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjEJRPw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 13:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63B8A72;
        Wed, 10 May 2023 10:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4CBB63411;
        Wed, 10 May 2023 17:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E789FC433EF;
        Wed, 10 May 2023 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738945;
        bh=kwBbgP+5vBJThrO7fvCQXHQgjr8ifqeicGUxMgkRj1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqPBZp9kPhRac09GVfnCv7Ls0QdW8Jmk9xVg+frOfrtMQlP6TwOvMRU/tNSemPL27
         W0plD+neghYgRbjFpDbJThmRRuEk37ye7q0WvhYhHA49uUXwHGOkA4xNFSbe+dPuN5
         NdgIbJvRJH2q3ZBSQpP4eg6qojR0lddbefp/Gut4DmdRw0ieOqU/S7Rk3VNOWOk9nA
         ar792Tan7siN112zdA/7mVFVPWfKMBVDYj92vVrCvxoOEzgLsaYAsFWDOHz/Ei36v1
         jvhHrhdWR/tZDu9O2WYb5v6xGdTKW/4IpHkJNp0vabseH2TkwkOzxib8xGU9TPUXUo
         TwdPZya4+J8iA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 86860403B5; Wed, 10 May 2023 14:15:42 -0300 (-03)
Date:   Wed, 10 May 2023 14:15:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V2 0/2] perf parse-events: Do not break up AUX event group
Message-ID: <ZFvRPsrI5SVcyrU4@kernel.org>
References: <20230508093952.27482-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508093952.27482-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, May 08, 2023 at 12:39:50PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here is a fix needed in v6.4, but dependent on Ian's patch
> "perf evsel: Modify group pmu name for software events", refer:

Thanks, applied to perf-core, for v6.4.

- Arnaldo
 
> https://lore.kernel.org/lkml/20230502223851.2234828-20-irogers@google.com/
> 
> There is also a test amendment to test the AUX event group fix for
> Intel PT.
> 
> 
> Changes in V2:
> 
>    Add an Intel PT test amendment for the AUX event group fix
>    Change AUX event group fix as suggested by Ian
> 
> 
> Adrian Hunter (2):
>       perf test: test_intel_pt.sh: Test sample mode with named PMU
>       perf parse-events: Do not break up AUX event group
> 
>  tools/perf/tests/shell/test_intel_pt.sh | 7 +++++++
>  tools/perf/util/evsel.c                 | 9 +++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
