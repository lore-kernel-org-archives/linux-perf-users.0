Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9EDC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B526109E
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348412AbhICLDA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 07:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235107AbhICLC7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Sep 2021 07:02:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17E1E6108E;
        Fri,  3 Sep 2021 11:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630666919;
        bh=lgby07MWvfG1oz4/DDBlgxOw0pRbSFIwjvNEtZHL2KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnyl8jIJptFDaTNx8CtamNAwBx/V/GzvltogCPOMpgU7hLkcruXkvLT6QDAxXmjl2
         WVkxX15ieuQ6wmA1uskPvjhesNu9Mx5C6if6j2Aaz7QIt4id1VzkAFSg8eZOSiaWzS
         Z+23DNZI/5FL31dyDM3RRRKDhFtrOnBgyqmG0ZzZfxbhsB1hrxy8Tv7fmS4zK5MvQ0
         ozY9rVn2+AHGV62gt8koJdD8XgBmEiYZf269CRI3bYP/Y8jS/1TkCwotoHZnNBvD0Y
         C9Q50snZzO6lrvRIDKQ0fEBVd56fB6gt7HGvVrKdI2tH0/bLRGujrFU40VP5HHfwNl
         XHplGGacZO19w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 658514007E; Fri,  3 Sep 2021 08:01:56 -0300 (-03)
Date:   Fri, 3 Sep 2021 08:01:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH] tools: perf: Report collisions in AUX records
Message-ID: <YTIApA/jrFPoDz74@kernel.org>
References: <20210723124456.3828769-1-suzuki.poulose@arm.com>
 <20210728091219.527886-1-suzuki.poulose@arm.com>
 <20210731013847.GA91194@leoy-ThinkPad-X240s>
 <20210902192520.GD1078000@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902192520.GD1078000@p14s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 02, 2021 at 01:25:20PM -0600, Mathieu Poirier escreveu:
> On Sat, Jul 31, 2021 at 09:38:47AM +0800, Leo Yan wrote:
> > On Wed, Jul 28, 2021 at 10:12:19AM +0100, Suzuki Kuruppassery Poulose wrote:
> > > Just like the other flags in the AUX records, report a summary
> > > of the Collisions if there were any.
> > > 
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Leo Yan <leo.yan@linaro.org>
> > > Cc: James Clark <james.clark@arm.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: linux-perf-users@vger.kernel.org
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > The change looks good to me:
> > 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied.

- Arnaldo

