Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4747BC432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 14:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A60461027
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 14:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbhIAO12 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 10:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236539AbhIAO11 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 10:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA93761056;
        Wed,  1 Sep 2021 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630506391;
        bh=Lr7NDxwN7fcf2Qff92CnluLy5KXUdI7ZL0G5scwyLMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtosxcBAOgGYvCDka6h0Kj0FQRvTy0uhfmVjC4W42cLSNKU1/qEMzhZERQN+FVLk+
         yQ2mLaAmiN+HbDqCDZudfWakdIZmuky8nG8JSeVjTDFefx7en9YJN2J68NejJb2DeZ
         +h53GB3iA4X85GzqNoAvjSAuMXDtNNlGyixq82wWJeK0XC71yEl0WIrGlxjVyZyxx3
         DtPZEqaj3023pNfv3IkIpUYCxE0KZQYZJLYl2L4DlOP29ku8FkjdKgdLUkFIPEYXhI
         wRQOKj60AqGzrJCpcx5FwlzoSOPrHRF7CEcFLsmU0jqS31U2DY37d7MIJuX0jytDL2
         Z0d9jgz1mZt0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 612134007E; Wed,  1 Sep 2021 11:26:28 -0300 (-03)
Date:   Wed, 1 Sep 2021 11:26:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     James Clark <james.clark@arm.com>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools build: Fix feature detect clean for out of source
 builds
Message-ID: <YS+NlBGl1xMqHlgC@kernel.org>
References: <20210816130705.1331868-1-james.clark@arm.com>
 <YS548qYreGLtabs4@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS548qYreGLtabs4@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 31, 2021 at 08:46:10PM +0200, Jiri Olsa escreveu:
> On Mon, Aug 16, 2021 at 02:07:05PM +0100, James Clark wrote:
> > Currently the clean target when using O= isn't cleaning the feature
> > detect output. This is because O= and OUTPUT= are set to canonical
> > paths. For example in tools/perf/Makefile:
> > 
> >   FULL_O := $(shell cd $(PWD); readlink -f $(O) || echo $(O))
> > 
> > This means that OUTPUT ends in a / and most usages prepend it to a file
> > without adding an extra /. This line that was changed adds an extra /
> > before the 'feature' folder but not to the end, resulting in a clean
> > command like this:
> > 
> >   rm -f /tmp/build//featuretest-all.bin ...
> > 
> > After the change the clean command looks like this:
> > 
> >   rm -f /tmp/build/feature/test-all.bin ...
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> nice catch!
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied and added:

Fixes: 762323eb39a257c3 ("perf build: Move feature cleanup under tools/build")

- Arnaldo

