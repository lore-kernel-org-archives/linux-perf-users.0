Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8470C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiFNTJW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiFNTJQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 15:09:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F891CFCB
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 12:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD00FB81A3D
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 19:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC64C3411B;
        Tue, 14 Jun 2022 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655233752;
        bh=dZTVJatnlJj9qXcGe87nGAv3KD+wwWgy7XVj3VmTHIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DowuhJxEcJiQV8sBohOV/VXGtw5ZbfOkSSY6FljuQJCsgRC64fjHYrxpNIoDND88e
         4N8pldoFn6z9TSJwHsl2abCWjuAqz3kl+x146JwV7Ljr6DbfrSs4BUZ+YTbwncOOdu
         ERLo/uhE9RZuLJ5KXOwaEH0CiIdCLFiUANEOSNNBYHNhfANBRYH7zSui1sOmTF+gLl
         zktgqBsuf+yCn0w/ygGvQAGdewDeO+w9iNUi/S0DJb6gfbJFFaGyMT9cIRRBJbGGxL
         EhnY3mQVN6Aoj5CoQF9K2sINugol9k7wrSxznC/rcxX9rbFPJORmhy0pDNdnMLMe8X
         Xz3LVWGx7YR7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B93164096F; Tue, 14 Jun 2022 16:09:09 -0300 (-03)
Date:   Tue, 14 Jun 2022 16:09:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        jolsa@kernel.org, James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] perf test: Record only user callchains
Message-ID: <Yqjc1W5hhnJZLGHx@kernel.org>
References: <20220614105207.26223-1-mpetlan@redhat.com>
 <7460bdf5-7c11-bfa7-9105-5b6b453aa925@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7460bdf5-7c11-bfa7-9105-5b6b453aa925@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 14, 2022 at 01:11:20PM +0100, German Gomez escreveu:
> Hi Michael, thanks for the fix
> 
> On 14/06/2022 11:52, Michael Petlan wrote:
> > The testcase 'Check Arm64 callgraphs are complete in fp mode' wants to
> > see the following output:
> >
> >     610 leaf
> >     62f parent
> >     648 main
> >
> > However, without excluding user callchains, the output might look like:
> 
> I think you meant "kernel callchains"

Fixed
 
> > 	ffffc2ff40ef1b5c arch_local_irq_enable
> > 	ffffc2ff419d032c __schedule
> > 	ffffc2ff419d06c0 schedule
> > 	ffffc2ff40e4da30 do_notify_resume
> > 	ffffc2ff40e421b0 work_pending
> > 	             610 leaf
> > 	             62f parent
> > 	             648 main
> >
> > Adding '--user-callchains' leaves only the wanted symbols in the chain.
> >
> > Suggested-by: German Gomez <german.gomez@arm.com>
> > Tested-by: Michael Petlan <mpetlan@redhat.com>
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> Fixes: cd6382d82752 ("perf test arm64: Test unwinding using fame-pointer (fp) mode")
> Reviewed-by: German Gomez <german.gomez@arm.com>

Added, thanks.

- Arnaldo
 
> German
> 
> > ---
> >  tools/perf/tests/shell/test_arm_callgraph_fp.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> > index 6ffbb27afaba..ec108d45d3c6 100755
> > --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> > +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> > @@ -43,7 +43,7 @@ CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
> >  cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> >  
> >  # Add a 1 second delay to skip samples that are not in the leaf() function
> > -perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 -- $TEST_PROGRAM 2> /dev/null &
> > +perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
> >  PID=$!
> >  
> >  echo " + Recording (PID=$PID)..."

-- 

- Arnaldo
