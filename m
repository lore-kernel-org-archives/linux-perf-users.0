Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFECBC07E9D
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831306113B
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbhGSWhl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1386354AbhGST36 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 15:29:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1827610FB;
        Mon, 19 Jul 2021 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626725437;
        bh=rKR67g1sIBg6Y7Tg6bJuaStZpslkuAKbjv8O8NlYaM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJzGOUXx8pA0xFxLyuyRWXbtNiKycwYGpH8S50wL12n9743cYlhx7f5pa7vydO9+D
         2aLvWn7Zmw0Qghos2NdrqbjM9nEHceo71Zc46Jvmtt2ntJ++2QOWCQcwnBI4buJalf
         bKBVq+btEIbP3e9vvQbe/9w0dY2nstPGS19DGEQ/EogOkzhDuQmF7AFTnvZ1k6oJTV
         VlQEk/l2Oim21YoK9UPjUtTjgxfIyhol//oGErlTVmqpGI0zJdXHu9z5EofhHQe5le
         alCCXf0NkgeC+PnCN+jCN7bQbKVQX241pY1GUQ0dJpnLt500sjw2LPQRtE4T9NTKen
         jSdniQ40cgb1w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E3DF4403F2; Mon, 19 Jul 2021 17:10:34 -0300 (-03)
Date:   Mon, 19 Jul 2021 17:10:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        leo.yan@linaro.org, al.grant@arm.com, branislav.rankov@arm.com,
        denik@chromium.org, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
Message-ID: <YPXcOrkjYdUJ3iRl@kernel.org>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
 <20210705193338.GB1493103@p14s>
 <YO8ivntow2JfdQWW@kernel.org>
 <20210719163336.GA2255168@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719163336.GA2255168@p14s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jul 19, 2021 at 10:33:36AM -0600, Mathieu Poirier escreveu:
> Hi Arnaldo,
> 
> On Wed, Jul 14, 2021 at 02:45:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jul 05, 2021 at 01:33:38PM -0600, Mathieu Poirier escreveu:
> > > On Thu, Jun 24, 2021 at 05:43:03PM +0100, James Clark wrote:
> > > > for example:
> > > > 
> > > >         Idx:808; ID:1c; I_BAD_SEQUENCE : Invalid Sequence in packet.[I_ASYNC]
> > > >         ...
> > > >         PKTP_ETMV4I_0016 : 0x0014 (OCSD_ERR_INVALID_PCKT_HDR) [Invalid packet header]; TrcIdx=822
> > > > 
> > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > > ---
> > > >  tools/perf/util/cs-etm.c | 20 ++++++++++++++++++--
> > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > > 
> > > 
> > > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > 
> > 
> > Thanks, applied.
> 
> This patch is the second of a two patch series[1][2].  The first one was applied and
> is in Linus' current master branch.  But I can't find the second one in
> either your core branch or Linus', and that despite your reply above that it has been
> applied.  As such I am guessing something went wrong with the process.  
> 
> How do you want to proceed - should we resend the second patch[2] or you still
> have it somewhere in your Inbox?

My bad, its no in tmp.perf/urgent, after testing together with other
patches will move to perf/urgent and by the end of this week I'll submit
it to Linus, sorry.

- Arnaldo
 
> Thanks,
> Mathieu
> 
> [1]. https://lists.linaro.org/pipermail/coresight/2021-June/006575.html
> [2]. https://lists.linaro.org/pipermail/coresight/2021-June/006576.html
> 
> > 
> > - Arnaldo
> > 

-- 

- Arnaldo
