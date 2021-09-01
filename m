Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D2C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 15:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9223A61090
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 15:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbhIAPzf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 11:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244935AbhIAPzf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 11:55:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E948361075;
        Wed,  1 Sep 2021 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630511678;
        bh=/4wn19eKOOwryeccB2/BNC/IzR5o0qm/E+ohvyEmRO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thftqGNBdiUWbRlW+UIfbUC/d/fD7K17RIGz8nV9JtHqvkNlTokryn3ICyPjretd7
         tX2N9rKKEG31ywzbUMEu0PaKaUDpCPnn/IaDqykZ6U3yzclLXuwMUZBtUbaOZhqsuZ
         t1e7C5rgz8QVAMOwHleg/kxYpfOil1GoINYoI3hInmdMIX7lR8KtA8LLNWI2lvCMcj
         j1KL0ITY239lrrmEJ0a91F5RYgrGAHSezredDq4BczqxxoB0dlT1bIjv3PJRQ8ltN4
         Tc9+tMdZI6k8GomXDrfPf5sPn4vPWD9MMDGMoZy0Ir2x9H729savbajoQjYSPyC2kw
         A3ASNUHkwPGuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A2DE24007E; Wed,  1 Sep 2021 12:54:34 -0300 (-03)
Date:   Wed, 1 Sep 2021 12:54:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic
 number
Message-ID: <YS+iOrcPTzQfmbqU@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824083615.GF204566@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 24, 2021 at 04:36:15PM +0800, Leo Yan escreveu:
> On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> > Currently perf reports "Cannot allocate memory" which isn't very helpful
> > for a potentially user facing issue. If we add a new magic number in
> > the future, perf will be able to report unrecognised magic numbers.
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Applies cleanly to my tree, test building it now, holler if there is
something that prevents it from being merged.

- Arnaldo
 
> > ---
> >  tools/perf/util/cs-etm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 788ad5a099f6..5b276bdb96a6 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -2973,6 +2973,11 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  
> >  			/* ETE shares first part of metadata with ETMv4 */
> >  			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> > +		} else {
> > +			ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". File could be from a newer version of perf.\n",
> > +				  ptr[i]);
> > +			err = -EINVAL;
> > +			goto err_free_metadata;
> >  		}
> >  
> >  		if (!metadata[j]) {
> > -- 
> > 2.28.0
> > 

-- 

- Arnaldo
