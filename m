Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4235C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCMTKS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCMTKR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 15:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FAF113DE;
        Mon, 13 Mar 2023 12:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD3EAB811F6;
        Mon, 13 Mar 2023 19:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45396C433D2;
        Mon, 13 Mar 2023 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734614;
        bh=MAofgLrk4Js+qKsV+odN1yUxa+jzNMRyfwV8Ta0XBK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gGk2jQEFvQX9F3ST8y7VfWPw2UsmHx53WPAx30R0y2uzsYMIhZ2b28ZzH9tS7dYW4
         GCvgNmCW4mn+oWB0tiOydwgmiWeVv2/8+4EAATFYos2YaHvGUoPWi5YLBtORdfqadg
         LBzsdpwPBPnegVq2sn5dGqdn+PwUd0iGyWBhJii9jHvtqiOZFxFAm3QZWQRV2+g5D6
         VDaJFOMb7C2dYpxHdeTVP/fjmX6scooK5asA/3wC09uDcrjyvdzsUb5cRjE1Y1hx6d
         8TrwqQ4ymC4zNB2V9Ewx6wyYnR8yzg0vOxGgT/prjezgFyxQ6mD0T2ED/dgmFwyjgl
         EhNUVzHD6oSLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C10F4049F; Mon, 13 Mar 2023 16:10:11 -0300 (-03)
Date:   Mon, 13 Mar 2023 16:10:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] perf cs-etm: Reduce verbosity of ts_source warning
Message-ID: <ZA91E31u6vDoolfM@kernel.org>
References: <20230308094843.287093-1-james.clark@arm.com>
 <20230308114644.GC19253@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308114644.GC19253@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Mar 08, 2023 at 07:46:44PM +0800, Leo Yan escreveu:
> On Wed, Mar 08, 2023 at 09:48:42AM +0000, James Clark wrote:
> > This is printed as a warning but it is normal behavior that users
> > shouldn't be expected to do anything about. Reduce the warning level to
> > debug3 so it's only seen in verbose mode to avoid confusion.
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org

Thanks, applied both patches.

- Arnaldo

