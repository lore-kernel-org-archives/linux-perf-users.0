Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09318CCA47E
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 19:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiFNTJ5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244451AbiFNTJz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 15:09:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9541A387
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 12:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD4A4B81B34
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 19:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1CEC3411B;
        Tue, 14 Jun 2022 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655233791;
        bh=yFP3A4YskDnkmWCFQosgrBCaxftA4zWoO0fHP9s5ACM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQ3LOV2FmWTjDcwWYGPE2XTtPdifLSVLLXuxsXPrCLR/OoYGJCea/AihOowVRBAh3
         HmlMQeoKKvGAvhP77rC9tRZwjPFAgd9/w7FHXJafKQHxgUx8g4V9tZWmG16YMrS25w
         RInYN6V24Lp2RbP2KPTQsazZzPkVKoXsodsMG22IBwN6HVLr4EnCBq2V7DEikVYrmd
         sHP/btFSetOYF0WCOnDhVitzjr2LzxsmCE5j1aevlVv9mzVOBxNht/cSExmoaBvrpk
         nc1oCx6voH9lVFdhcztdPNFzjsgI+lzVkrm4QmdGXQWqzrVJemQCazz1NXByBKM2Tn
         8k+TP4aHh97aQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D69634096F; Tue, 14 Jun 2022 16:09:48 -0300 (-03)
Date:   Tue, 14 Jun 2022 16:09:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        jolsa@kernel.org, german.gomez@arm.com
Subject: Re: [PATCH] perf test: Record only user callchains
Message-ID: <Yqjc/FSW2sJ6ZA5U@kernel.org>
References: <20220614105207.26223-1-mpetlan@redhat.com>
 <20220614131704.GA237086@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614131704.GA237086@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 14, 2022 at 09:17:04PM +0800, Leo Yan escreveu:
> On Tue, Jun 14, 2022 at 12:52:07PM +0200, Michael Petlan wrote:
> > The testcase 'Check Arm64 callgraphs are complete in fp mode' wants to
> > see the following output:
> > 
> >     610 leaf
> >     62f parent
> >     648 main
> > 
> > However, without excluding user callchains, the output might look like:
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
> 
> Since you are the patch's author, it's not necessary to add your
> tested tag.

Right, removed, we expect authors test their patches :-)
 
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> With addressing German's comment for "excluding kernel callchains":

Addressed.
 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, added.

- Arnaldo
 
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
> > -- 
> > 2.18.4
> > 

-- 

- Arnaldo
