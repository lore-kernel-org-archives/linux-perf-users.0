Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AB0C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 Oct 2022 12:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJGMoj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 Oct 2022 08:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJGMoi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Oct 2022 08:44:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C4CAE78;
        Fri,  7 Oct 2022 05:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B8F3B822ED;
        Fri,  7 Oct 2022 12:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A7AC433D7;
        Fri,  7 Oct 2022 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665146669;
        bh=uP1JSwwRcUIushFlcvkfM6oZ5R02T+VIpZAyha6T7LI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjsvpdOeX0OiEO36qY8VuJi8a7CvZ0SteG6tQiPJRUVYA5XY7JK81O6CY64usgqol
         1H7d1Vqxx91WfxbeYycymYNKItgfriSmIfBUGjoEq1aEqAgJPTVZZV3XHv9dObtGOL
         MNA4+vuj7tSxKaORkYViIKN89hjQhKdYvaCBlSuzFekuAkUcymGme9KskzpNMvvc2g
         N5H17Ibvaw2Yd/asSlupU/27YWg0q8RttGE4FJWI2B6+4QnyBTGHU6rpRPTxSPKITF
         wUnfGY03fSvqggxrag98fNKK8YcGPmZuyeTFcMhYUpGR/xEyBjitKiCtTWEWHYm9W9
         kSEOXmW8htlnQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A4F634062C; Fri,  7 Oct 2022 09:44:27 -0300 (-03)
Date:   Fri, 7 Oct 2022 09:44:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Y0AfK7sVphNkQA4q@kernel.org>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org>
 <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
 <e9f980a7-fba8-4610-a058-b74e51d6ab24@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f980a7-fba8-4610-a058-b74e51d6ab24@foss.arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Oct 07, 2022 at 12:34:51PM +0100, Carsten Haitzler escreveu:
> On 10/6/22 13:58, Leo Yan wrote:
> > On Thu, Oct 06, 2022 at 08:45:18AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Oct 06, 2022 at 08:26:00AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Also had to remove:

> > > 		$(INSTALL) tests/shell/coresight/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'

> > > from this patch, as it makes install fail at this point in the patchset:

> > Thanks a lot!

> > James and me had found the merging conflict and planned to send out
> > email for reminding it, the right change for above section would be:

> > @@ -1006,7 +1014,10 @@ install-tests: all install-gtk
> >                  $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
> >                  $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> >                  $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > -               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> > +               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> > +               $(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> > +       $(Q)$(MAKE) -C tests/shell/coresight install-tests

> > It's deliberately to not add '-m 644' when install coresight test
> > shell scripts under the folder tests/shell/coresight/ so that we can
> > keep the executable permission for these scripts.  On the other
> > flip, we set 644 mode for the scripts under tests/shell/lib/ so
> > these scripts will not be executed directly by perf test framework.

> > @Carsten, if have chance could you confirm for above change?

> > >    DESCEND plugins
> > >    GEN     /tmp/build/perf/python/perf.so
> > >    INSTALL trace_plugins
> > >    INSTALL binaries
> > >    INSTALL tests
> > > install: cannot stat 'tests/shell/coresight/*.sh': No such file or directory
> > > make[2]: *** [Makefile.perf:1007: install-tests] Error 1
> > > make[2]: *** Waiting for unfinished jobs....

> > > I'll add it back when the first .sh gets added to tests/shell/coresight/

> > Sorry for introducing extra efforts for you and thanks!
 
> oh sorry - indeed i didn't see this problem coming after fixing the
> conflicts. i've got an update of the patches that fix that. should i just
> send through the 2 updates patches as a v10 or the whole series?

No need, I did some fixes taking into account the comments on this
thread, we can go on and fix things from what I have now at
acme/perf/core, which I'll send to Linus today.

- Arnaldo
