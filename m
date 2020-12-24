Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AE2C433DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Dec 2020 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95161224B8
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Dec 2020 12:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgLXMbG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Dec 2020 07:31:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbgLXMbG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Dec 2020 07:31:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 045D9224B0;
        Thu, 24 Dec 2020 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608813025;
        bh=UTX4NY2//XHZ3bT1CqU1okJ/pCfOmDDpYpMiTqQ1Av0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crfmOFxsz4UDJPk9OiZuZwMAE4D1gMiBdyhETVbZTNdiUryr5ExbfLBBy6/oTUdzf
         AqLH0AnwDIG5HWqP9N1NBvxfbylPV83fUtc6uhMtDexY/o0OSXjB92qyzoGs8wLzr3
         DyNk99xrUIlOGQg5f/9eFKSfpAS5yuobDuZgJ7Y/mvmBe0FZFPtU9UCcOaqNyDMYru
         6FpIktWV1TO3Jh+lkfmVxtsS3scawv/7gLdL/GgaVxaj0FpWrJ3P/2OcEm64TEprDW
         BQh2DhFO+PQX1muRfvcSfkUZZjJ2wdYUY/7Dn/9QBX1RIeEa63QDlaQLPljoA/vnuq
         SQialONXxBLgA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD2F7411E9; Thu, 24 Dec 2020 09:30:38 -0300 (-03)
Date:   Thu, 24 Dec 2020 09:30:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v6 00/12] perf tools: fix perf stat with large socket IDs
Message-ID: <20201224123038.GC477817@kernel.org>
References: <20201126141328.6509-1-james.clark@arm.com>
 <20201203153923.GA3613481@krava>
 <30c4426d-b314-98ff-e6d5-6d5152f316e8@huawei.com>
 <20201223221747.GB236568@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223221747.GB236568@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Dec 23, 2020 at 11:17:47PM +0100, Jiri Olsa escreveu:
> On Fri, Dec 04, 2020 at 11:48:36AM +0000, John Garry wrote:
> > On 03/12/2020 15:39, Jiri Olsa wrote:
> > 
> > +
> > 
> > > On Thu, Nov 26, 2020 at 04:13:16PM +0200, James Clark wrote:
> > > > Changes since v5:
> > > >    * Fix test for cpu_map__get_die() by shifting id before testing.
> > > >    * Fix test for cpu_map__get_socket() by not using cpu_map__id_to_socket()
> > > >      which is only valid in CPU aggregation mode.
> > > > 
> > > > James Clark (12):
> > > >    perf tools: Improve topology test
> > > >    perf tools: Use allocator for perf_cpu_map
> > > >    perf tools: Add new struct for cpu aggregation
> > > >    perf tools: Replace aggregation ID with a struct
> > > >    perf tools: add new map type for aggregation
> > > >    perf tools: drop in cpu_aggr_map struct
> > > >    perf tools: Start using cpu_aggr_id in map
> > > >    perf tools: Add separate node member
> > > >    perf tools: Add separate socket member
> > > >    perf tools: Add separate die member
> > > >    perf tools: Add separate core member
> > > >    perf tools: Add separate thread member
> > > 
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > > 
> > 
> > Tested-by: John Garry <john.garry@huawei.com>
> 
> hi,
> I was wondering where this went, and noticed that
> Arnaldo was not CC-ed on the cover letter ;-)

Looking at it right now, used the Message-ID and b4 got everything,
there are some fuzzies that I'm checking:

[acme@five perf]$ git am --show-current-patch=diff | patch -p1
patching file tools/perf/builtin-stat.c
Hunk #1 succeeded at 1186 (offset -2 lines).
Hunk #2 succeeded at 1347 (offset -2 lines).
Hunk #3 succeeded at 1373 (offset -2 lines).
Hunk #4 succeeded at 1399 (offset -2 lines).
Hunk #5 succeeded at 1448 (offset -2 lines).
patching file tools/perf/tests/topology.c
patching file tools/perf/util/cpumap.c
patching file tools/perf/util/cpumap.h
patching file tools/perf/util/stat-display.c
Hunk #8 succeeded at 326 with fuzz 2 (offset -3 lines).
Hunk #9 succeeded at 334 (offset -3 lines).
Hunk #10 succeeded at 397 (offset -3 lines).
Hunk #11 succeeded at 500 (offset -3 lines).
Hunk #12 succeeded at 589 (offset -3 lines).
Hunk #13 succeeded at 598 (offset -3 lines).
Hunk #14 succeeded at 634 (offset -3 lines).
Hunk #15 succeeded at 656 (offset -3 lines).
Hunk #16 succeeded at 739 (offset -3 lines).
Hunk #17 succeeded at 763 (offset -3 lines).
Hunk #18 succeeded at 781 (offset -3 lines).
Hunk #19 succeeded at 827 (offset -3 lines).
Hunk #20 succeeded at 855 (offset -3 lines).
Hunk #21 succeeded at 870 (offset -3 lines).
Hunk #22 succeeded at 888 (offset -3 lines).
Hunk #23 succeeded at 897 (offset -3 lines).
Hunk #24 succeeded at 908 (offset -3 lines).
Hunk #25 succeeded at 1159 (offset -3 lines).
patching file tools/perf/util/stat.c
patching file tools/perf/util/stat.h
[acme@five perf]$

[acme@five perf]$ git am --show-current-patch=diff | head -20
---
 tools/perf/builtin-stat.c      |  76 +++++++++++++----------
 tools/perf/tests/topology.c    |  17 +++---
 tools/perf/util/cpumap.c       |  82 ++++++++++++++-----------
 tools/perf/util/cpumap.h       |  10 +--
 tools/perf/util/stat-display.c | 108 +++++++++++++++++++--------------
 tools/perf/util/stat.c         |   2 +-
 tools/perf/util/stat.h         |   5 +-
 7 files changed, 173 insertions(+), 127 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f15b2f8aa14d..f10c67a26472 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1188,65 +1188,67 @@ static struct option stat_options[] = {
 	OPT_END()
 };

-static int perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
+static struct aggr_cpu_id perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
[acme@five perf]$
 
> jirka
> 
> > 
> > I still think that vendors (like us) need to fix/improve their firmware
> > tables so that we don't get silly big numbers for socket/package IDs, like
> > S5418-D0, below:
> > 
> > $./perf stat -a --per-die
> > 
> >  Performance counter stats for 'system wide':
> > 
> > S36-D0   48   72,216.31 msec cpu-clock      #   47.933 CPUs utilized
> > S36-D0   48        174     context-switches #   0.002 K/sec
> > S36-D0   48         48     cpu-migrations   #   0.001 K/sec
> > S36-D0   48         0     page-faults    #   0.000 K/sec
> > S36-D0   48   7,991,698     cycles    #   0.000 GHz
> > S36-D0   48   4,750,040     instructions   #   0.59  insn per cycle
> > S36-D0    1   <not supported>     branches
> > S36-D0   48      32,928     branch-misses    #   0.00% of all branches
> > S5418-D0   48   72,189.54 msec cpu-clock     #   47.915 CPUs utilized
> > S5418-D0   48        176     context-switches  #   0.002 K/sec
> > S5418-D0   48         48     cpu-migrations   #   0.001 K/sec
> > S5418-D0   48         0     page-faults     #   0.000 K/sec
> > S5418-D0   48   5,677,218     cycles    #    0.000 GHz
> > S5418-D0   48   3,872,285     instructions   #  0.68  insn per cycle
> > S5418-D0    1   <not supported>     branches
> > S5418-D0   48      29,208     branch-misses   #  0.00% of all branches
> > 
> >       1.506615297 seconds time elapsed
> > 
> > but at least it works now. Thanks.
> > 
> > > 
> > > > 
> > > >   tools/perf/builtin-stat.c      | 128 ++++++++++++------------
> > > >   tools/perf/tests/topology.c    |  64 ++++++++++--
> > > >   tools/perf/util/cpumap.c       | 171 ++++++++++++++++++++++-----------
> > > >   tools/perf/util/cpumap.h       |  55 ++++++-----
> > > >   tools/perf/util/stat-display.c | 102 ++++++++++++--------
> > > >   tools/perf/util/stat.c         |   2 +-
> > > >   tools/perf/util/stat.h         |   9 +-
> > > >   7 files changed, 337 insertions(+), 194 deletions(-)
> > > > 
> > > > -- 
> > > > 2.28.0
> > > > 
> > > 
> > > .
> > > 
> > 
> 

-- 

- Arnaldo
