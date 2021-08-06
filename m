Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E3C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7757611C3
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbhHFSjs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhHFSjs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 14:39:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C07F61050;
        Fri,  6 Aug 2021 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628275172;
        bh=sv9KWjs7sk7y29Yo3zwcDq1ejIwJ7upxJSMKHEtstE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7GEj3BH7XtHQ4yuZAnwk8my55Ai4hZN4VC5Yi027kMIcrejw3LhcMbCaw8EREzT3
         w12hZKRME9ngON1WRKZLYnc1J0blnJ+VMfG0Lg9qUzTKxu5oeU3u3mCpHBJc+mVC9q
         eO6ojP8Ro+Iy7E9ajCbxcSRt3bMKDJRdqEhHqovs/7ulh0sEnqgP1lcaYUp7uRyR77
         cnQrP/xxDbMk7etpqv2OMhN8QTnfh98yBnJkWyBS3L5Wn6fjs8biPSK/aIf1cU2YDh
         82JmY85NR5+TteqRY+lGmsnOI9wY2fiBlJFv5eh5l7fyjVSswC2n2B78fmwC2zGYTw
         hRPj4mpyAZsvA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC8BB403F2; Fri,  6 Aug 2021 15:39:28 -0300 (-03)
Date:   Fri, 6 Aug 2021 15:39:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] perf cs-etm: Add warnings for missing DSOs
Message-ID: <YQ2B4N5ULNdiuwTx@kernel.org>
References: <20210805130354.878120-1-james.clark@arm.com>
 <20210805130354.878120-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805130354.878120-2-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Aug 05, 2021 at 02:03:54PM +0100, James Clark escreveu:
> Currently decode will silently fail if no binary data is available for
> the decode. This is made worse if only partial data is available because
> the decode will appear to work, but any trace from that missing DSO will
> silently not be generated.
> 
> Add a UI popup once if there is any data missing, and then warn in the
> bottom left for each individual DSO that's missing.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks, applied.

- Arnaldo

