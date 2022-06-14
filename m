Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7999BC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 12:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiFNMTt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiFNMTr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 08:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6603742A22
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 05:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655209185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tWBc/vI1Z1D0EjroDYG8+oWkAC8zWRb9nfpYXzA3cC0=;
        b=TVjHiYYp35NWkVF3UTnOgRsthgWUxXqdnT2za1iic9jy1+pCTmhk11jwaOpayceDc3OZk2
        w27mn6HFbJdr0kcRdKhy3SLrznh44ylbcGHTcX9PDz6ma8a0eo/8FdJBA1gJoNMswVRB12
        ioXf6HP4IdS0kZ3dBuh0f/Sry4Tqd1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-8Ts-B-UnOY6q51BZ8OUivg-1; Tue, 14 Jun 2022 08:19:40 -0400
X-MC-Unique: 8Ts-B-UnOY6q51BZ8OUivg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C425101A54E;
        Tue, 14 Jun 2022 12:19:40 +0000 (UTC)
Received: from Diego (unknown [10.39.208.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B63F9D7F;
        Tue, 14 Jun 2022 12:19:37 +0000 (UTC)
Date:   Tue, 14 Jun 2022 14:19:34 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     German Gomez <german.gomez@arm.com>
cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
        jolsa@kernel.org, James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] perf test: Record only user callchains
In-Reply-To: <7460bdf5-7c11-bfa7-9105-5b6b453aa925@arm.com>
Message-ID: <alpine.LRH.2.20.2206141419010.3839@Diego>
References: <20220614105207.26223-1-mpetlan@redhat.com> <7460bdf5-7c11-bfa7-9105-5b6b453aa925@arm.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 14 Jun 2022, German Gomez wrote:
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

Oh... of course I did. Thanks.

> 
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
> 
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
> 
> 

