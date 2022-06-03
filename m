Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08572C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Jun 2022 19:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiFCTT3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiFCTT3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Jun 2022 15:19:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861113CA63;
        Fri,  3 Jun 2022 12:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B383B82474;
        Fri,  3 Jun 2022 19:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C400AC385A9;
        Fri,  3 Jun 2022 19:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654283966;
        bh=8nKJf9dOTOAH1uAklFxKClj2mI73t1XJ/PQeizBDHM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgihMoLTfzeHQ+1HZqxv4d6k9no+96GjzYbAj0tPcZvnzJfcvMz7jWzvfvhFRX9gE
         YiXzKZ0DJmSl9+ajox91qmY5kkPOEFr4LgOmjcsz9uBJjpsjW/Br3VIFauF8SgvbaD
         httMGU59qGweYgNfQg0xtrF97rmaxEmUZvjb5/juHvPVNhOIEaAWoaojmHAxD/P9eq
         WXVmTVGQCmE0+5xHXDTyrfo4/ujeMwBWDUqrlzJ9gSDHbAylK5IYzN9Q5ktwbBSjIW
         9LSa1k3LqzOSkyMGEsmOEgnI5ldLYBm3JAdIfNeRa8zUQvNGXeMT5hp3p1Bn3CYD14
         +ES/shabXbXbg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D88EC4096F; Fri,  3 Jun 2022 21:19:22 +0200 (CEST)
Date:   Fri, 3 Jun 2022 21:19:22 +0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf test arm-spe: Check if perf-record hangs when
 recording workload with forks
Message-ID: <Yppeus3KIdICeSxf@kernel.org>
References: <20220228165655.3920-1-german.gomez@arm.com>
 <95ede14c-8dc2-d285-9f5b-8d6ee6797f00@arm.com>
 <20220527063821.GB829807@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527063821.GB829807@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, May 27, 2022 at 02:38:21PM +0800, Leo Yan escreveu:
> On Fri, May 13, 2022 at 02:03:52PM +0100, James Clark wrote:
> > On 28/02/2022 16:56, German Gomez wrote:
> > > Signed-off-by: German Gomez <german.gomez@arm.com>

> > Reviewed-by: James Clark <james.clark@arm.com>

> Thanks for review and popping up this patch, James.  LGTM:

> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

