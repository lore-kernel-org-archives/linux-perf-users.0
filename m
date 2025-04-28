Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329B26AF6;
	Mon, 28 Apr 2025 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870693; cv=none; b=asNJEvkbUz95p316pvE7DdZExPt05OGxWgboA/j3y4T5Yf8w5AptFVMeEuXz9FX4YCCJgRg/eUAkPU8Vx6VQK2qR0fJa9TSi2n80aWuTABD0Phkn/rxUB5cBvYgU2mNXzTWWatAGu01R/Fmh82TTDJvmHzf0Tx/ydo/wWBxplg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870693; c=relaxed/simple;
	bh=210PHU39hk+ycVM/ZVCX9uO4G8xdYGVnMyNCVfaumcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9dsbPuA7aV5JFzL26ZxrjRPE4dQ58gQbdHehTyQRcrzoqYJO4XP4WQopeIkSqRMJiKFLOd5DkWEzW1Qi1UBo/v2iUAn9WWu/gGeHaCjLVjhnA0CaT4cr7AVeVlPOAOcEf7xCesOaBbbrKNa4HXV5U0GLIWXrq+W4kWEj4UOu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6OG1fwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6OG1fwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF09C4CEE4;
	Mon, 28 Apr 2025 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745870692;
	bh=210PHU39hk+ycVM/ZVCX9uO4G8xdYGVnMyNCVfaumcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6OG1fwepmxoaohVlJsRgj6KRgELlNJQ4ShklEyD25CmL7OK27VznfLxgc/pJpZ5i
	 8gA4N1rddEO2n5SOZmpIcxdFvNYkmmblwSWWdLIY4qnL5yVTVnCYLEBC1nIMW5lA53
	 1WF17JxYQVKaI+YhigtCpTs9keL/8Oi5GvxraGdiZ/RypNCk7X7jx0nrVJw0bX4SYs
	 DIppN5e8tCKTR/wmhRC4rgF86rpCuL3gnr49wDXSqs2Bhmb7O6As2GiU9OLV0nvZkP
	 BRXJ8zd+tSXN+tmMxCjDu1VUXaLaGZksGG/Z5OU3CB/hFolDN25KZukfRGIc98lAbv
	 45HNe3PA+fY1Q==
Date: Mon, 28 Apr 2025 13:04:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	James Clark <james.clark@linaro.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zixian Cai <fzczx123@gmail.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Martin Liska <martin.liska@hey.com>,
	Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] perf dso: Move build_id to dso_id
Message-ID: <aA_fYvTI7YRIy2k9@google.com>
References: <20250424195831.1767457-1-irogers@google.com>
 <20250424195831.1767457-8-irogers@google.com>
 <aAvDStpWjwC7grya@google.com>
 <CAP-5=fXcTssH=bGQLDmPeT=fGf270B1-ocsP2Y7EP_RV=M838A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXcTssH=bGQLDmPeT=fGf270B1-ocsP2Y7EP_RV=M838A@mail.gmail.com>

On Fri, Apr 25, 2025 at 11:46:40AM -0700, Ian Rogers wrote:
> On Fri, Apr 25, 2025 at 10:15 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Thu, Apr 24, 2025 at 12:58:30PM -0700, Ian Rogers wrote:
[SNIP]
> > > @@ -1665,18 +1675,20 @@ bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
> > >  void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
> > >  {
> > >       char path[PATH_MAX];
> > > +     struct build_id bid;
> > >
> > >       if (machine__is_default_guest(machine))
> > >               return;
> > >       sprintf(path, "%s/sys/kernel/notes", machine->root_dir);
> > > -     if (sysfs__read_build_id(path, dso__bid(dso)) == 0)
> > > -             dso__set_has_build_id(dso);
> > > +     sysfs__read_build_id(path, &bid);
> > > +     dso__set_build_id(dso, &bid);
> >
> > Why not check the return value anymore?
> 
> Checking the return value was a mistake. For example if we have
> libc.so with a build ID and then it is replaced with a libc.so without
> a build ID then build ID wouldn't be updated previously as reading the
> build ID had failed - no value found.

I'm not sure if it updates the dso as a whole.  This functions is to get
build-ID of the kernel and it seems we can skip this if it already has a
build-ID.  But if sysfs__read_build_id() failed, it may have a garbage.

Do I miss something?

Thanks,
Namhyung

> >
> > >  }
> > >
> > >  int dso__kernel_module_get_build_id(struct dso *dso,
> > >                                   const char *root_dir)
> > >  {
> > >       char filename[PATH_MAX];
> > > +     struct build_id bid;
> > >       /*
> > >        * kernel module short names are of the form "[module]" and
> > >        * we need just "module" here.
> > > @@ -1687,9 +1699,8 @@ int dso__kernel_module_get_build_id(struct dso *dso,
> > >                "%s/sys/module/%.*s/notes/.note.gnu.build-id",
> > >                root_dir, (int)strlen(name) - 1, name);
> > >
> > > -     if (sysfs__read_build_id(filename, dso__bid(dso)) == 0)
> > > -             dso__set_has_build_id(dso);
> > > -
> > > +     sysfs__read_build_id(filename, &bid);
> > > +     dso__set_build_id(dso, &bid);
> > >       return 0;
> > >  }
