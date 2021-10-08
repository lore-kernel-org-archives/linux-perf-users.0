Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B577FC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B876101E
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhJHTDH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhJHTDG (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 15:03:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C74B60F38;
        Fri,  8 Oct 2021 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633719671;
        bh=v0J0hrryQl9l8zn56qmUobmgZDPPAhWnEmX3U/IK40E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIYry73eJ/dteuVV0PWU5rwIxpgOnSHEHPT6SrXdgt0yDzv+UQCSkzenSaw38//p6
         taa94lwmP4NK0kOZPiHaJdn+b30iKAgVzNVWp/Z0O3tnn/qKb29p7JPsvRCHy7JiPA
         it1PcXxZnJ2F8rppevd3VTy1Omh19tn3FTHpuo/6LDi/BVEJRWPVAg56ZHH//d/cHC
         5lW69Hn5skPcCOG2ESGunx8Rv0TEwKV6gvrK4urrtT6bAS8RiDyMDwwyQQKPJXCf15
         jhtlJ0xZUzrToPVe0AUE9z+/04xBNHp9gfOok2joY/2T1ES1gEsGmu6Nh/YoTakt+M
         LFgxLHmzodAfg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 90346410A1; Fri,  8 Oct 2021 16:01:08 -0300 (-03)
Date:   Fri, 8 Oct 2021 16:01:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     James Clark <james.clark@arm.com>, john.garry@huawei.com,
        ak@linux.intel.com, linux-perf-users@vger.kernel.org,
        Nick.Forrington@arm.com, Andrew.Kilroy@arm.com,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf tools: Make the JSON parser more conformant
 when in strict mode
Message-ID: <YWCVdJ1AlbEgDcjW@kernel.org>
References: <20211007110543.564963-1-james.clark@arm.com>
 <20211007110543.564963-3-james.clark@arm.com>
 <YV8z306sBJQsdNNR@krava>
 <2e14963b-cb98-f508-7067-255fdbd36bdb@arm.com>
 <YWBDo5Ciq1hOIxLq@krava>
 <YWCUWo6pMns6p05o@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWCUWo6pMns6p05o@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Oct 08, 2021 at 03:56:26PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 08, 2021 at 03:12:03PM +0200, Jiri Olsa escreveu:
> > On Fri, Oct 08, 2021 at 11:08:25AM +0100, James Clark wrote:
> > > 
> > > 
> > > On 07/10/2021 18:52, Jiri Olsa wrote:
> > > > On Thu, Oct 07, 2021 at 12:05:41PM +0100, James Clark wrote:
> > > >> Return an error when a trailing comma is found or a new item is
> > > >> encountered before a comma or an opening brace. This ensures that the
> > > >> perf json files conform more closely to the spec at https://www.json.org
> > > >>
> > > >> Signed-off-by: James Clark <james.clark@arm.com>
> > > >> ---
> > > >>  tools/perf/pmu-events/jsmn.c | 42 ++++++++++++++++++++++++++++++++++--
> > > >>  1 file changed, 40 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/tools/perf/pmu-events/jsmn.c b/tools/perf/pmu-events/jsmn.c
> > > >> index 11d1fa18bfa5..8124d2d3ff0c 100644
> > > >> --- a/tools/perf/pmu-events/jsmn.c
> > > >> +++ b/tools/perf/pmu-events/jsmn.c
> > > >> @@ -176,6 +176,14 @@ jsmnerr_t jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
> > > >>  	jsmnerr_t r;
> > > >>  	int i;
> > > >>  	jsmntok_t *token;
> > > >> +#ifdef JSMN_STRICT
> > > > 
> > > > I might have missed some discussion on this, but do we need the
> > > > JSMN_STRICT define, if you enable it in the next patch?
> > > > why can't we be more strict by default.. do you plan to disable
> > > > it in future?
> > > 
> > > I didn't plan on disabling it, I was just trying to keep to the existing style of the
> > > jsmn project.
> > > 
> > > I could have added the trailing comma detection by default and not inside any
> > > #ifdef JSMN_STRICT blocks, but I would like to enable JSMN_STRICT anyway, because it
> > > enables some additional built in checking that was already there. So I thought it
> > > made sense to put my new strict stuff inside the existing strict option.
> > > 
> > > One option would be to remove all (including the existing) #ifdef JSMN_STRICT blocks
> > > and have everything strict by default. But it would be a further deviation from jsmn.
> > 
> > ok, I think it makes sense to have JSMN_STRICT then..
> > thanks for explanation
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> So, is this for the whole patchset? b4 picked it just for this message.

Got it from IRC, thanks,

- Arnaldo
