Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABDFC6FD1C
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Mar 2023 11:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjCNLpd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCNLpa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Mar 2023 07:45:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA5A11167
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Mar 2023 04:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 659136172A
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Mar 2023 11:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DDAC433D2;
        Tue, 14 Mar 2023 11:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678794286;
        bh=GTQ1VAiPGfXvfzEmd6vB3LPQPYDI/bO4drxo/RNT+xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZTTB8fswJKGU4D3nw7CFHKjiJY+/bKR18Q286NL/FQP90OdfqUVJycQw9C9u+AIv
         SR4H0V+/79ukq3pa0eWYG6QaHbaGa14XASIOY1p0ydNNGfRfEuDJSkQUkjUSD9IAHc
         dZt0hO3b5cebcHwHhIZv9xDoiZW7jhCz4rigVOq3YAavhZQLHTL4Iw3fCds0RkRIoN
         7Aau0vTOjP1cnPcidmJtie91zWm21uanVJbUJOdDhgtBXdjXMbajVlMmq8YEELV382
         7GRHKUy+G/NGBTs052vxG+s7D5gSuhnvnvs4YB6i2QMeSCAlYF8k0aqKIpvjZs/9rB
         TrKPvZoeHzG6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 085454049F; Tue, 14 Mar 2023 08:44:44 -0300 (-03)
Date:   Tue, 14 Mar 2023 08:44:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Roman Lozko <lozko.roma@gmail.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf scripts: intel-pt-events.py: Fix IPC output for
 Python 2
Message-ID: <ZBBeKyM++DM7lvmI@kernel.org>
References: <01f16399-f600-2b45-766f-0b5e5f868345@intel.com>
 <20230310150445.2925841-1-lozko.roma@gmail.com>
 <19a697ba-9520-92a0-1419-07c5a66481b1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a697ba-9520-92a0-1419-07c5a66481b1@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Mar 10, 2023 at 06:50:48PM +0200, Adrian Hunter escreveu:
> On 10/03/23 17:04, Roman Lozko wrote:
> > Integers are not converted to floats during division in Python 2
> > which results in incorrect IPC values. Fix by switching to new division
> > behavior.
> 
> There is usually a blank line here

Fixed
 
> > Fixes: a483e64c0b62 ("perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace")
> > Signed-off-by: Roman Lozko <lozko.roma@gmail.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/scripts/python/intel-pt-events.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> > index 08862a2582f4..1c76368f13c1 100644
> > --- a/tools/perf/scripts/python/intel-pt-events.py
> > +++ b/tools/perf/scripts/python/intel-pt-events.py
> > @@ -11,7 +11,7 @@
> >  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> >  # more details.
> >  
> > -from __future__ import print_function
> > +from __future__ import division, print_function
> >  
> >  import io
> >  import os
> 

-- 

- Arnaldo
