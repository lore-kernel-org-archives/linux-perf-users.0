Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024855A0F9;
	Sat,  4 May 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714847320; cv=none; b=i5BFwm3z43TeqIT/KTFcZsp0jEiSdeHNK5f6pYw8+LfNAxgVrFkt598jPFhn5IVhqgrSDFbZYj62vkryqmqe8sjBLf5WZiKGGv+4Y/aJGBF9Cgq76prgo3p3tAt/reWZioZsAyy5UYm+T4cLrwUulERLYd7N13pNsFKueSpn3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714847320; c=relaxed/simple;
	bh=hYXK12g+YXp0eom7ZGnE3hBz1pg4fXoYGSAa74G/OX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTB2BBy1sjfJ3hqwxUbT+mPLzEk4UmiV59mrnVePHteSg56mrzYBzG/iqeVXzQtu3yvbNPfidFVA31UDH/dIpCGVkLLpUQjwBEN/WV/jPgd2yZwaImVr0zfD9DG8uo4njifJRTOagNS2VwlssXyjwF92f5GJerlWNZ2fzhDFZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icYxfyOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icYxfyOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB41C072AA;
	Sat,  4 May 2024 18:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714847319;
	bh=hYXK12g+YXp0eom7ZGnE3hBz1pg4fXoYGSAa74G/OX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icYxfyOvdKDIfgLpmhna3a0Ie3WKU3VqPYqMKrMD1CSQUtIjTKwAXcJ9isKwL05xa
	 54MtGgLbephJUVDNHNFctzGVovj+EO9BT3hXHsYy9vcm5/dA23QAesfdgTqIdQCTqR
	 D4SnhDCtHNLx83wqKqXNarZcX3seLDjVD4OyHHVfCs90R18qrtAaCVJw89oYssVfi6
	 A3t1HQvT6vRHB/RnRNd0pz/UrmZ7PvgO51lTX+2SRbGrfHr5XhtkjjSwBH1lce+BVT
	 u81iGRSCQ8mxSv5zTVLi2daeDK5JTo/UU7FvQjgfbyD+Wj5GYcxMGI1LKWagU1TKhu
	 xyOgw6Hp1y8vg==
Date: Sat, 4 May 2024 15:28:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>,
	Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ben Gainey <ben.gainey@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Changbin Du <changbin.du@huawei.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dima Kogan <dima@secretsauce.net>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yang Jihong <yangjihong1@huawei.com>,
	Chengen Du <chengen.du@canonical.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] perf dsos: Switch backing storage to array from
 rbtree/list
Message-ID: <ZjZ-VPVqDhjkGxmC@x1>
References: <20240429184614.1224041-1-irogers@google.com>
 <20240429184614.1224041-2-irogers@google.com>
 <ZjVHNB7pTKKWERFn@x1>
 <CAP-5=fXE6-atL+FdCdD529eqyveWUqgR6QbJgzvGy=5xR_TBRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXE6-atL+FdCdD529eqyveWUqgR6QbJgzvGy=5xR_TBRg@mail.gmail.com>

On Sat, May 04, 2024 at 11:14:52AM -0700, Ian Rogers wrote:
> On Fri, May 3, 2024 at 1:21 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Mon, Apr 29, 2024 at 11:46:08AM -0700, Ian Rogers wrote:
> > > DSOs were held on a list for fast iteration and in an rbtree for fast
> > > finds. Switch to using a lazily sorted array where iteration is just
> > > iterating through the array and binary searches are the same
> > > complexity as searching the rbtree. The find may need to sort the
> > > array first which does increase the complexity, but add operations
> > > have lower complexity and overall the complexity should remain about
> > > the same.

> > With just this first one applied:

> > ⬢[acme@toolbox perf-tools-next]$ git log --oneline -10
> > 325557715f1d8593 (HEAD) perf dsos: Switch backing storage to array from rbtree/list
> > 7b6dd7a923281a7c perf pmu: Assume sysfs events are always the same case
> > 6debc5aa326fa2ee perf test pmu: Test all sysfs PMU event names are the same case
> > 18eb2ca8c18f0612 perf test pmu: Add an eagerly loaded event test
> > aa1551f299ba414c perf test pmu: Refactor format test and exposed test APIs
> > 785623ee855e893d perf Document: Sysfs event names must be lower or upper case
> > 97c48ea8ff1cd70f perf test pmu-events: Make it clearer that pmu-events tests JSON events
> > 3cdd98b42d212160 (x1/perf-tools-next) perf maps: Remove check_invariants() from maps__lock()
> > e3123079b906dc2e perf cs-etm: Improve version detection and error reporting
> > bc5e0e1b93565e37 perf cs-etm: Remove repeated fetches of the ETM PMU
> > ⬢[acme@toolbox perf-tools-next]$

> > root@number:~# perf -v
> > perf version 6.9.rc5.g325557715f1d
> > root@number:~# perf probe -l
> > DSO [kernel.kallsyms] is still in rbtree when being deleted!
> > DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/hid/hid-sensor-hub.ko.xz is still in rbtree when being deleted!
> > DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/hid/uhid.ko.xz is still in rbtree when being deleted!
> > DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/net/tun.ko.xz is still in rbtree when being deleted!
> > DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/fs/overlayfs/overlay.ko.xz is still in rbtree when being deleted!
> > DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/net/bluetooth/rfcomm/rfcomm.ko.xz is still in rbtree when being deleted!
> > DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/input/misc/uinput.ko.xz is still in rbtree when being deleted!
> > DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/sound/core/seq/snd-seq-dummy.ko.xz is still in rbtree when being deleted!
> > <SNIP a lot of other modules, probably all of them>
 
> Right, we don't have a test on this and this motivates the addition of
> reference count checking on DSO in the later patches. With the series
> applied, fixing the rebase issue, I see:
 
> $ git log --oneline
> eabe5dd91331 (HEAD) perf dso: Use container_of to avoid a pointer in dso_data
> fd47ec98a05c perf dso: Reference counting related fixes
> 962af2d2b092 perf dso: Add reference count checking and accessor functions
> 48664a9a6ca4 perf dsos: Switch hand code to bsearch
> ae7a9854dabd perf dsos: Remove __dsos__findnew_link_by_longname_id
> e616a6b3739d perf dsos: Remove __dsos__addnew
> e789368716dd perf dsos: Switch backing storage to array from rbtree/list
> 7b6dd7a92328 (ptn/tmp.perf-tools-next, ptn/perf-tools-next) perf pmu:
> Assume sysfs events are always the same case
> ...
> $ sudo /tmp/perf/perf -v
> perf version 6.9.rc5.geabe5dd91331
> $ sudo /tmp/perf/perf probe -l
> $
 
> I'll see if I can find a fix to backport before sending a new series
> to work around the 2 line rebase conflict.

Thanks a lot for doing that!

- Arnaldo
