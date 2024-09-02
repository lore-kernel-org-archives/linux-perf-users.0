Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249C1CB508;
	Mon,  2 Sep 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298999; cv=none; b=WXbmUUcO8NUNe+8Edi7pZmrOinBgaKtN1jcBNz6mQ/mmFJo1hX7zxa43VZqbhg6co16Ip+qiZgEjl5Xt6s9oYFAvo9+VyWOev5eqIzUbguzMCrRnhIy+MGLHIyTESGmqEpSsWg6CsfXO6Oc9MKOcapYoNvna4fVDY9dhln4vXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298999; c=relaxed/simple;
	bh=pQjq5637RhyeLyjUbHTYNQQZXlfmZQqh2HY8sgaNvyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLz+Z8h7xK1MLu91bOsplgC7KqQsle4n3zKOigxw2/0sc4FMB3jb7eERMyVvSc9iWxEkUE7sdAi0qEeJ+rzVjD/f60wJuUGF+vt8jg/pLZtWCU5oDdPFrA4SsAWy6Io2/APb3w2ol8r3R7+bORq4GadoG1iRFelvPAa1W97JNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGjwJhx1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGjwJhx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C405DC4CEC2;
	Mon,  2 Sep 2024 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725298998;
	bh=pQjq5637RhyeLyjUbHTYNQQZXlfmZQqh2HY8sgaNvyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGjwJhx1h8jDsC78GRLKmR4Hdh/xNYAf7ROCcShPyQgGLvGt3uXVNqrzdQvKXizOM
	 boxw7X+phdUjTY0jPM7Qs3mKt9tlVFuDubX0eTD7Z3FSSNahemHE+zOmTl1VErIZWh
	 l2IZMSV6UMHOrUGZ5AgrHE0DnqgfOM6CkJXyOmCRLGcSGHPe5wUtrvzfKOkwV5Fmr+
	 GqlAUW4oBrru/8i+P+/o/0KZNkMr+nZ8SxXAIbflX+bCYhWw73s74lSUVvp3ClxrNZ
	 s6nHGZbiblbNsVsB4RPQ+jFX+5gxZeLqu9KQ9ikc4mxk2qdvPbx/KS7HQT0RoDgb/B
	 FCU9fSxU6y4cQ==
Date: Mon, 2 Sep 2024 10:43:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com, ak@linux.intel.com,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Ze Gao <zegao2021@gmail.com>, Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] perf test: Add a test for default perf stat
 command
Message-ID: <ZtX5Mw8Iuc5qgBWz@google.com>
References: <20240828140736.156703-1-james.clark@linaro.org>
 <20240828140736.156703-8-james.clark@linaro.org>
 <ZtFnbq_158fxttmW@google.com>
 <52de8df9-4554-4bc0-9735-fdbd197dbb7c@linaro.org>
 <b9a1f3fd-de17-492b-91c3-950131912f71@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9a1f3fd-de17-492b-91c3-950131912f71@linaro.org>

On Fri, Aug 30, 2024 at 09:45:11AM +0100, James Clark wrote:
> 
> 
> On 30/08/2024 9:29 am, James Clark wrote:
> > 
> > 
> > On 30/08/2024 7:32 am, Namhyung Kim wrote:
> > > Hello,
> > > 
> > > On Wed, Aug 28, 2024 at 03:07:21PM +0100, James Clark wrote:
> > > > Test that one cycles event is opened for each core PMU when "perf stat"
> > > > is run without arguments.
> > > > 
> > > > The event line can either be output as "pmu/cycles/" or just "cycles" if
> > > > there is only one PMU. Include 2 spaces for padding in the one PMU case
> > > > to avoid matching when the word cycles is included in metric
> > > > descriptions.
> > > > 
> > > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > > ---
> > > >   tools/perf/tests/shell/stat.sh | 21 +++++++++++++++++++++
> > > >   1 file changed, 21 insertions(+)
> > > > 
> > > > diff --git a/tools/perf/tests/shell/stat.sh
> > > > b/tools/perf/tests/shell/stat.sh
> > > > index 525d0c44fdc6..24ace1de71cc 100755
> > > > --- a/tools/perf/tests/shell/stat.sh
> > > > +++ b/tools/perf/tests/shell/stat.sh
> > > > @@ -148,6 +148,26 @@ test_cputype() {
> > > >     echo "cputype test [Success]"
> > > >   }
> > > > +test_hybrid() {
> > > > +  # Test the default stat command on hybrid devices opens one
> > > > cycles event for
> > > > +  # each CPU type.
> > > > +  echo "hybrid test"
> > > > +
> > > > +  # Count the number of core PMUs
> > > > +  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
> > > 
> > > Is it working on non-hybrid systems?  I don't think they have cpus file
> > > in the core PMU.
> > > 
> > > Thanks,
> > > Namhyung
> > > 
> > 
> > Good point I only tested on Arm non-hybrid. I can change it to assume 1
> > PMU for no cpus files?
> 
> Or maybe assume 1 if a /sys/bus/event_source/devices/cpu folder exists? Not
> sure which is best but either will work.

Some arch might not have a cpu PMU, I think we can assume 1 and update
only if it finds cpus files.

Thanks,
Namhyung

