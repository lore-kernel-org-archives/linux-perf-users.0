Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9276C0015E
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGMUsl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjGMUsl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 16:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA52D54
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 13:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D67B961B45
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 20:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045C7C433C7;
        Thu, 13 Jul 2023 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689281319;
        bh=qZPWKl8BQXLNFn/UYiBA3giYB7qM27vvwQHUR0ouwMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTNiVKA/utMl0mm7y/Auzcl6X9zyjRSZ+kweegfzarm+SGYaPpHYY6SgolkPNAC8p
         GNGw7qUtnqyTO23v37fAgynyYIdAYTRyFRoFF04gkk5RsvEu/fo/wh3rOacyarG1Na
         ASpT514mctDJsuvjYmk+ZP7v+UA/Qaqjtv5RSQkwnHcKc4OwZkPPIEw8zJmLde8shm
         tnSqdBYZG7g5FBGHI8+V7PBveWX3Bw40CXiWz5/AxK5tOFNwzWS4v44RWGTHu7y3Lz
         yUakCyZ1jNypRgSfBzN1KH4XE2tOPz9qnCCyr0uUw1bzkj3csZjq/DlVSUeLxwXANo
         0wtXFPlFHVf7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBCBF40516; Thu, 13 Jul 2023 17:48:35 -0300 (-03)
Date:   Thu, 13 Jul 2023 17:48:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: Event reordering regression for software events
Message-ID: <ZLBjI4a3wIMs75lA@kernel.org>
References: <ZLBgbHkbrfGygM/u@tassilo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLBgbHkbrfGygM/u@tassilo>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 13, 2023 at 01:37:00PM -0700, Andi Kleen escreveu:
> Hi Ian,
> 
> The current post 6.3 linux-perf-next causes some fairly drastic
> reordering in output for some event combinations. I bisected it down to
> your patch:
> 
> commit 347c2f0a0988c59c402148054ef54648853fa669
> Author: Ian Rogers <irogers@google.com>
> Date:   Sat Mar 11 18:15:40 2023 -0800
> 
>     perf parse-events: Sort and group parsed events
> 
>     This change is intended to be a no-op for most current cases, the
>     default sort order is the order the events were parsed. Where it
>     varies is in how groups are handled. Previously an uncore and core
>     event that are grouped would most often cause the group to be removed:
> 
> I currently only have a large test case, but for the test case [1] below 
> most of the "dummy"s and some other software events end up in a row and also in the
> wrong place, instead of the expected order.
> 
> good:
> 
> ...
> 986476553;ns;duration_time;986476553;100.00;;
> 0;;dummy;983952237;100.00;;
> 0;;cs:u;983952237;100.00;;
> 16532;;minor-faults:u;983952237;100.00;;
> 0;;major-faults:u;983952237;100.00;;
> 0;;migrations:u;983952237;100.00;;
> 3532509496;;cycles:u;23999092;2.00;;
> ....
> 
> bad:
> 
> 1010119571;ns;duration_time;1010119571;100.00;;
> 0;;dummy [software];1007748753;100.00;;
> 0;;cs:u [software];1007748753;100.00;;
> 16496;;minor-faults:u [software];1007748753;100.00;;
> 0;;major-faults:u [software];1007748753;100.00;;
> 0;;migrations:u [software];1007748753;100.00;;
> 0;;dummy [software];1007748753;100.00;;
> 0;;dummy [software];1007748753;100.00;;
> 0;;dummy [software];1007748753;100.00;;
> 0;;dummy [software];1007748753;100.00;;
> 0;;emulation-faults [software];1007748753;100.00;;
> 0;;dummy [software];1007748753;100.00;;
> 0;;dummy [software];1007748753;100.00;;
> 0;;emulation-faults [software];1007748753;100.00;;
> 0;;emulation-faults [software];1007748753;100.00;;
> 3603193382;;cycles:u;23996241;2.00;;
> 2277091922;;cpu/event=0x0,umask=0x3/u;23996241;2.00;;
> 4182126406;;cpu/event=0xc2,umask=0x2/u;23996241;2.00;;
> 4364677170;;cpu/event=0xc0,umask=0x0/u;23996241;2.00;;
> 
> 
> Unfortunately this totally breaks toplev. It needs to have the dummies
> in the right location.`
> 
> Another problem is that it also now adds [software] to lots of software
> events, which of course also breaks any parsing tools. I haven't bisected
> that too, but it needs fixing too.
> 
> I must say using perf recently is frustrating with all the regressions!
> Please be a bit more careful with compatibility.

That is really unfortunate and indeed perf passed thru a lot of changes
trying to properly support hybrid systems and verify reference counting
correctness, a necessary step to resume attempts at being multithreaded.

We have seen a growing number of 'perf test' entries being submitted,
with writing shell scripts that check if the output from various command
lines produce expected results.

It would really be great to have new entries that exercise what is
expected by toplev so that we really are careful with compatibility.

- Arnaldo
