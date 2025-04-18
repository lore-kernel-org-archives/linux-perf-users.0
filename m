Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CB70823;
	Fri, 18 Apr 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989810; cv=none; b=PGcjsrTP1wv5FnpFWzAa72r1nNwHXO1Cb8cJccXB7LCq1CPjOiFk39OEJ2VDDR+OTlqqPFtwlHQTYUNrF5fH8CaGz6fmDOyyxjqQIV8Aar/fQA/8L/lp4QqoGfAuY2K8sI9xYudFmB0L0+aS/x/bjdLxVKsGtRdm0Mr3QIcr/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989810; c=relaxed/simple;
	bh=BwX+9wXA6Ac9mBBnqhuy/FtmyqsXwluaY0L2o3BkbaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2PyDJu7wVkOw9ENFM4yiyun/n78bDlPMuHvKPqFdpdA3GfPxrgwQxpavLGte7G2+K8IXoWmidbNF/PvYqxkCz4cyFCXmlx55IoYy9H2got+9ZXp306g/EL+BoxE+3zAlzsVn8cbiv3oFrrWLDoXOvioC39fxSOrNqG0twQyiAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8lY3zb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8lY3zb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78576C4CEE2;
	Fri, 18 Apr 2025 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744989810;
	bh=BwX+9wXA6Ac9mBBnqhuy/FtmyqsXwluaY0L2o3BkbaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8lY3zb2INgzFtGaKJl38+oCnv5dr7tamkviuXCbxN0qvpbmgvR91iKXICc9ARAVs
	 y61CoV/uNt76EPUbfLb5BSPPw1IcpTrpG8Ok9Wlj+DQbQjd11KMHweF5CyJJ8+4I80
	 EjxGpzBDhV4TmEy7IdD6oJjBPV0J4EvgpV+u1gSnltyL+13bbo6EQhFpsQt2fHadML
	 7K1xUXqIS21iid4mVfkd2RW2Nut0WsfK34qxu/bpRNd6pisjbZ5xW0+nUYJVInsfSS
	 XyoAfLyJ9Ia/Wdc7kuX+cTNgq4U2NI5H0X8zWN5B0OAMRDSvrr+6iPDJCn5c3B7Fp2
	 HgtbCa8vRqhIg==
Date: Fri, 18 Apr 2025 12:23:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: arnaldo.melo@gmail.com, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Remove libbfd from the set of expected
 libraries to build perf
Message-ID: <aAJublOL0i5BzrH5@x1>
References: <aABlDyhAYz95vOM1@x1>
 <CAP-5=fXeykYoqLJ8t6Gq31cO8eYGOnppgc86PHfWnBoz4xgw-g@mail.gmail.com>
 <aAF5mIul8qhDUYz8@x1>
 <CAP-5=fXxxaBs_JGqZVM8rZzg837Po4_p2wOARBj2i6183kXgjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXxxaBs_JGqZVM8rZzg837Po4_p2wOARBj2i6183kXgjA@mail.gmail.com>

On Thu, Apr 17, 2025 at 04:12:16PM -0700, Ian Rogers wrote:
> On Thu, Apr 17, 2025 at 2:58 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > There is a wider set of cleanups that remove BUILD_NONDISTRO and
> > > libbfd that I posted back in January:
> > > https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com/

> > I thought that discussion hadn't come to a conclusion, then I was in
> > vacation in January + LSFMM/BPF, lost track of it, will read your
> > message below and look at it again.

> > Its just that I recreated my toolbox container for building perf to a
> > fedora:42 based one and went on trying to build it from the base system
> > that gets installed in such containers till the point where I found the
> > above problem.

> > Now doing 'make -C tools/perf build-test' I'm getting this after the
> > above patch:

> >             make_nondistro_O: cd . && make BUILD_NONDISTRO=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.NssFD0ssxu DESTDIR=/tmp/tmp.oEuROiOLtI
> > cd . && make BUILD_NONDISTRO=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.NssFD0ssxu DESTDIR=/tmp/tmp.oEuROiOLtI
> >   BUILD:   Doing 'make -j32' parallel build

<SNIP>

> > util/disasm_bpf.c:109:23: error: too few arguments to function ‘disassembler’; expected 4, have 1
> >   109 |         disassemble = disassembler(bfdf);
> >       |                       ^~~~~~~~~~~~
> > /usr/include/dis-asm.h:411:27: note: declared here
> >   411 | extern disassembler_ftype disassembler (enum bfd_architecture arc,
> >       |                           ^~~~~~~~~~~~
> > make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:86: /tmp/tmp.NssFD0ssxu/util/disasm_bpf.o] Error 1
> > make[6]: *** Waiting for unfinished jobs....
> >   CC      /tmp/tmp.NssFD0ssxu/bench/mem-memcpy-x86-64-asm.o
> > <SNIP>

<SNIP>
 
> Looked like a bad cherry pick, I sent rebased versions of the patches

I didn't cherry pick from your series, I mean on what is in
perf-tools-next/perf-tools-next

> and an extra small cleanup patch in the v4 patch series:
> https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/

Thanks for resending it, I'll test with it.

- Arnaldo
