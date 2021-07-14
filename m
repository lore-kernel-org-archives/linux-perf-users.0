Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C2FC07E9A
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 17:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD394613C3
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 17:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhGNRs2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhGNRs2 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 13:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D8DC613BE;
        Wed, 14 Jul 2021 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626284736;
        bh=WhHMSzbJG7vgyfqcgNwQHLAWwiQT+eksDibFemIqlus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyOvmz2v8I1bHZImwjKbBuHy3wsFD1yCc5frQsIQozIx0+drfOIfLX4RC8B9foP3+
         E0Vkkvi8kH/w36zgno5uw1/Qg/4+F9+VuXNHQkSlRlhXrDfPteTKGnnVGU7w91XbhE
         Vqqgh/mbj66AyJvEjQtlBmeHP9XcQ9GRWirL1JcbfR3PoreKkIIc4NX/Y+AHMrfKfm
         XhMiY69v3KuUa1iZ6PMqoJiG4Pukb4AYUbOknq1iZ2E3OipQ1zi56Sv5lUjTIPK2QY
         hXkHZlPX+OC4J71lowy37iTn5qDvGqjbHY6UNSI86xV1xXsksxYGeiC7tPJdWSoE7y
         KT1Mbzk2oHRpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32546403F2; Wed, 14 Jul 2021 14:45:34 -0300 (-03)
Date:   Wed, 14 Jul 2021 14:45:34 -0300
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
Message-ID: <YO8ivntow2JfdQWW@kernel.org>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
 <20210705193338.GB1493103@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705193338.GB1493103@p14s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jul 05, 2021 at 01:33:38PM -0600, Mathieu Poirier escreveu:
> On Thu, Jun 24, 2021 at 05:43:03PM +0100, James Clark wrote:
> > for example:
> > 
> >         Idx:808; ID:1c; I_BAD_SEQUENCE : Invalid Sequence in packet.[I_ASYNC]
> >         ...
> >         PKTP_ETMV4I_0016 : 0x0014 (OCSD_ERR_INVALID_PCKT_HDR) [Invalid packet header]; TrcIdx=822
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/util/cs-etm.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>



Thanks, applied.

- Arnaldo

