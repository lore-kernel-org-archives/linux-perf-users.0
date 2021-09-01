Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181EDC432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F394860F91
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 16:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245254AbhIAQ0i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229820AbhIAQ0h (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 12:26:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8607F61026;
        Wed,  1 Sep 2021 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630513540;
        bh=6XGIessxCdstb1MMTQL+7eNQhowuUPMqPTFcz8N7HFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDReyLgUFD8AGU1OgU1f2rxSgz3EmMgeeN5NXrDXT1Uyo3fvU3H6qs9Ojo8HbzxEL
         2OH9CpZzEKNml2BMqKpmgY32xDGerER2vj4mS7CShaJnGpRkkIyO3D6gE8Tl3Zr1Rk
         XkBKi+SN4u/cjjL7OJzpqrQHOF6zLH06+lH4Ebpb124UrpME9L9pSETdMAZiqxQW5D
         0ATeVxhZhs06Aq/TxPOdaamE1BYXHVFrGl1lAxLBgSouTAxjib/usI9//FTIMOFoW7
         Ge/oyFpiWDe8boqMg5ZeOfDhDbUtOkS97wgS0zJo8MUrPCnY7nw9tKk0URHJDI0DFj
         ACwmX2b9Xp9/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C043E4007E; Wed,  1 Sep 2021 13:25:37 -0300 (-03)
Date:   Wed, 1 Sep 2021 13:25:37 -0300
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
Message-ID: <YS+pgZMpFmnRlMuT@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s>
 <YS+iOrcPTzQfmbqU@kernel.org>
 <YS+lTXyuC+9VTrxd@kernel.org>
 <YS+neCZler56Hs2D@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS+neCZler56Hs2D@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 01, 2021 at 01:16:56PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Sep 01, 2021 at 01:07:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Sep 01, 2021 at 12:54:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Aug 24, 2021 at 04:36:15PM +0800, Leo Yan escreveu:
> > > > On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> > > > > Currently perf reports "Cannot allocate memory" which isn't very helpful
> > > > > for a potentially user facing issue. If we add a new magic number in
> > > > > the future, perf will be able to report unrecognised magic numbers.
> > > > > 
> > > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > > 
> > > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > 
> > > Applies cleanly to my tree, test building it now, holler if there is
> > > something that prevents it from being merged.
> > 
> > I´m now trying to fix this up, I applied it using 'b4', so no patch
> > should have gone missing...
> 
> So its probably related to:
> 
> ⬢[acme@toolbox perf]$ rpm -qa | grep opencsd
> opencsd-1.0.0-1.fc34.x86_64
> opencsd-devel-1.0.0-1.fc34.x86_64
> ⬢[acme@toolbox perf]$
> 
> In which case the usual mechanism is to test if we have what is needed
> via tools/build/feature/test-_____.c, lemme check...

There is a test and it fails, of course:

⬢[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-libopencsd.make.output
test-libopencsd.c:9:2: error: #error "OpenCSD >= 1.1.1 is required"
    9 | #error "OpenCSD >= 1.1.1 is required"
      |  ^~~~~
⬢[acme@toolbox perf]$

But the fact that I ask for CORESIGHT=1 should have the build fail then,
i.e. if one explicitely asks for a feature and it can't be built, fail
the whole build.

- Arnaldo
