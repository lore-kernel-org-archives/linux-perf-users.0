Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C3747F;
	Wed, 31 Jul 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440781; cv=none; b=PQBvijqLF5z8hTuKkCHnEwKa6CoD0klpMWl6xV/RTPS/gek+ivyXY75If2wUStFg6PFx7pp0NSGNmghGt0Q/cuLoxsRR4mnNy/KBiJVQr1Xr5oh8m9lq0TlqmR0jJDTSdx/gjl5EHXcCkpDc7RPySdjPaQDtgg10au2H3wlcM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440781; c=relaxed/simple;
	bh=JSqrGcPdxzdCkjvNhdbWF6uWfXTLDQGpsCJBheDjKec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxcCApiPT/CMRuk33kKZmkHpyB88Va3nZ7tP4Uvi1nrpCTTCQ2QHULKRW0fH6gKIqLvwdQcv2N3XYYU1qZtx17BJY1jnN0m0IqZlDDHEzc3C2a7IdjCodxqxeAQBD6Lrz+sc46v9GknT42DpskcRY+gSlSWyuWvtYERFWPcx4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWGtcRW7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWGtcRW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6519AC116B1;
	Wed, 31 Jul 2024 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722440780;
	bh=JSqrGcPdxzdCkjvNhdbWF6uWfXTLDQGpsCJBheDjKec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWGtcRW7JTz9AhW73D1JKdDg1kHMKRaMmla1MWLto+INP4Y79/i/yrILqpqhHnl14
	 ymI4Wt8UDTBdROJ3m2GVc+AmTUlwTDNRK1OJ23m9COaXD0zKMKkUc5MuvxcrMifplD
	 dttABrsBdutLR3gIS118enLq0jgSLF4HMMNcVjpidcm7/vpQIJ/2eoC5D8rZUxbVEU
	 Pk+P4/YzDjbQt/ERLrDRESGGi5v/lcFGW3c5088o+NM5elb+UbGHHAQGRsilPytCGH
	 e4JwkwecbZW3RxRCXwSffJzaOaGpD/naFrFlCFAdBRyJquwDUttmbtvWbjopPqpiGH
	 p9LDCZ8h7VtZg==
Date: Wed, 31 Jul 2024 12:46:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	philip.li@intel.com, oliver.sang@intel.com,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v3 2/2] perf jevents: Autogenerate empty-pmu-events.c
Message-ID: <ZqpcRIzzBb5KC6Zb@x1>
References: <20240730191744.3097329-1-irogers@google.com>
 <20240730191744.3097329-3-irogers@google.com>
 <Zqo5vVdrkhL5NHJK@x1>
 <CAP-5=fXyOfPya+TrKVaFhCK3rNY=AuLZLG67ith5YHf_XXVdNg@mail.gmail.com>
 <ZqpZWywTe2j3U9Pl@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqpZWywTe2j3U9Pl@x1>

On Wed, Jul 31, 2024 at 12:33:50PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 31, 2024 at 07:08:18AM -0700, Ian Rogers wrote:
> > On Wed, Jul 31, 2024 at 6:18 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Jul 30, 2024 at 12:17:44PM -0700, Ian Rogers wrote:
> > > > empty-pmu-events.c exists so that builds may occur without python
> > > > being installed on a system. Manually updating empty-pmu-events.c to
> > > > be in sync with jevents.py is a pain, let's use jevents.py to generate
> > > > empty-pmu-events.c.
> > >
> > > What am I missing here?
> > >
> > > If it exists so that we can build on a system without python how can we
> > > use python to generate it?
> > >
> > > Now having python in the system is a requirement and thus we don't need
> > > empty-pmu-events.c anymore?
> > >
> > > Can you guys please clarify that?
> > 
> > The requirement for python hasn't changed.
> > 
> > Case 1: no python or NO_JEVENTS=1
> > Build happens using empty-pmu-events.c that is checked in, no python
> > is required.
> > 
> > Case 2: python
> > pmu-events.c is created by jevents.py (requiring python) and then built.
> > This change adds a step where the empty-pmu-events.c is created using
> > jevents.py and that file is diffed against the checked in version.
> > This stops the checked in empty-pmu-events.c diverging if changes are
> > made to jevents.py. If the diff causes the build to fail then you just
> > copy the diff empty-pmu-events.c over the checked in one.
> 
> I'll try and add your explanation to the log message, thanks for
> clarifying it!

So, with it in place I'm now noticing:

⬢[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
⬢[acme@toolbox perf-tools-next]$ alias m='rm -rf ~/libexec/perf-core/ ; make -k CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test python'
⬢[acme@toolbox perf-tools-next]$ m
<SNIP>
  GEN     /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
  MKDIR   /tmp/build/perf-tools-next/arch/x86/util/
  CC      /tmp/build/perf-tools-next/util/annotate.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/tsc.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/hybrid.o
  CC      /tmp/build/perf-tools-next/util/block-info.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/intel-pt-test.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/pmu.o
  MKDIR   /tmp/build/perf-tools-next/ui/browsers/
  CC      /tmp/build/perf-tools-next/ui/browsers/annotate.o
  CC      /tmp/build/perf-tools-next/builtin-kallsyms.o
  CC      /tmp/build/perf-tools-next/util/block-range.o
  TEST    /tmp/build/perf-tools-next/pmu-events/empty-pmu-events.log
--- pmu-events/empty-pmu-events.c	2024-07-31 12:44:14.355042296 -0300
+++ /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c	2024-07-31 12:45:35.048682785 -0300
@@ -380,7 +380,7 @@
                         continue;
 
                 ret = pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data);
-                if (pmu || ret)
+                if (ret)
                         return ret;
         }
         return 0;
  CC      /tmp/build/perf-tools-next/tests/openat-syscall.o
make[3]: *** [pmu-events/Build:42: /tmp/build/perf-tools-next/pmu-events/empty-pmu-events.log] Error 1
make[3]: *** Deleting file '/tmp/build/perf-tools-next/pmu-events/empty-pmu-events.log'
make[2]: *** [Makefile.perf:763: /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf-tools-next/arch/x86/util/kvm-stat.o
<SNIP>
