Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D4AC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 13:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiKWNr3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiKWNqj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 08:46:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224CE10FEE
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 05:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA42CB81F31
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 13:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D257C433D6;
        Wed, 23 Nov 2022 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669210558;
        bh=VWWLHtkFBXyHuij2sLVljPVRVR2J6IQNKf5WyBXDOwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPFjLaQkgeIjO46OBbfwEqBw/Z4brH9tZM9q/lWbRNU2i8Z6dvX2X2VYKiFzU+9D8
         eISju+ipazjcLLZlnCzvPMzggsFGrrsyEYUMnQBv5dD45MbwPeEk5utC4HUDuDbcy3
         NCM5iJ/l2OS4PumTYDLyDreY6Efq6qrGS0sXyubppqWF/PESrcQmbG2dWdpHl9zlAq
         aftTS0o8JmIiinxSSilXdzI0zg4OTnk3vdKPQvYdfxCCb2geER2iLZBJwXbD84zcau
         dwXWabLwX/UEVCUHwf4y73tICbF53ShosEU12DpS/6RoAUSE1j88pmUaeADqpoLRB3
         POrfS7q7oB3uw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 072404034E; Wed, 23 Nov 2022 10:35:56 -0300 (-03)
Date:   Wed, 23 Nov 2022 10:35:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix record test on KVM guests
Message-ID: <Y34hvEyFjST2GDK6@kernel.org>
References: <20221122083121.6012-1-mpetlan@redhat.com>
 <CAP-5=fUj11rCAA8t6FUN1N+pLO4-FWE-buAVor-v41gYJ7M3hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUj11rCAA8t6FUN1N+pLO4-FWE-buAVor-v41gYJ7M3hw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 22, 2022 at 09:31:49PM -0800, Ian Rogers escreveu:
> On Tue, Nov 22, 2022 at 12:33 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > Using precise flag with br_inst_retired.near_call causes the test fail
> > on KVM guests, even when the guests have PMU forwarding enabled and the
> > event itself is supported.
> >
> > Remove the precise flag in order to make the test work on KVM guests.
> >
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/shell/record.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > index e93b3a8871fe..a796222288ec 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -134,7 +134,7 @@ test_register_capture() {
> >      echo "Register capture test [Skipped missing registers]"
> >      return
> >    fi
> > -  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
> > +  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call \
> >      -c 1000 --per-thread ${testprog} 2> /dev/null \
> >      | perf script -F ip,sym,iregs -i - 2> /dev/null \
> >      | grep -q "DI:"
> > --
> > 2.18.4
> >

-- 

- Arnaldo
