Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7CB289340;
	Fri,  5 Jun 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670758; cv=none; b=QQWgEJe5pYVxZTh9dWlVRmmpdXtMNgcr6epmLHHLWH6Bagzo72CHrjH3f/ypQpD5H9I48melRlaDWCp+tDbhhFTN3WUPSKkL0ahRdaI/hMIdxbF4fThW3XIKfdiMWuVL38Af/ZflVtKzqUhM8BVygoWI+fVZxZfjZWmp985I0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670758; c=relaxed/simple;
	bh=bYnYHrZQLqezAAEClptwkiPB18M4FWj2nyOjvDldeA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU300ONrG0n/0qz2P/PK8ix+MWSOthGKii3axEADIbbX5wXQmaJIPI0p0ic4WPXHyXYqLm1mYyJtE898RJv0adzX+QrjFm98y0t1OV/Rb9DUVRE+t3jdOIvKp6vs4IickwkqBgIRFRUHNtroay2sqNZ1tASzFehrVpD0XRG5I9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF15EbQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF15EbQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFB01F00893;
	Fri,  5 Jun 2026 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780670757;
	bh=Ww/M3NWb2znT+uTU6Ci5K7Qcsa7wnGMgbYt6hVS76LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eF15EbQsWMjRR5kCkKXKH0EoQd76XAm2fo6dT9+ctlNlIcekDWujaHJGOrR9W52zt
	 JiPGvIUecY6IkacxiGXE6thQnHzxELX9nDp2CnCZR25anMypd/e3s1HErSagJWLr+O
	 3nCfAXWW/fsZkXBEp6vh9EoJc/iekU/QtcCewTY9xCD4DxzkiIvHD+rdk8kv2Pq/Gl
	 gMtOfwI46ZU0vrKOcLVAbaJap8urId0tAuyDKpM+KQeCbRgP75wa52JYpkkZ5T3jHu
	 JbgSJ2ltOp9bDAko/8VaBaam6sJ4DVCH3Zz+mYWRsMO8f+kU8DfXIZNq2VOZ6VW3o+
	 ZikadOLoNJhyQ==
Date: Fri, 5 Jun 2026 11:45:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/5] perf tools: Add bounds check to cpu__get_node()
Message-ID: <aiLhH7NEScm55m3X@x1>
References: <20260605121515.1725549-3-acme@kernel.org>
 <20260605143000.DE0CD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605143000.DE0CD1F00893@smtp.kernel.org>

On Fri, Jun 05, 2026 at 02:30:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] `builtin-kmem` omits the `.attr` callback in its `perf_tool`, which breaks processing of piped streams natively.
> - [High] Integer truncation in `set_max_cpu_num()` combined with missing bounds checks in `cpu__setup_cpunode_map()` causes heap out-of-bounds writes on systems with large sparse CPU topologies.
> - [High] `perf_mmap__aio_bind` triggers an out-of-bounds memory write and subsequent crash when a CPU's NUMA node is unknown or mapped to a dummy CPU.
> --

Thanks, added all these pre-existing conditions for the following
series,

- Arnaldo
 
> commit 84fade77fbbcea06a93ffe9275b1abcc29bbc6bc
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf tools: Add bounds check to cpu__get_node()
> 
> The patch adds a bounds check against max_cpu_num in cpu__get_node() to
> protect against untrusted or out-of-bounds CPU index values before accessing
> cpunode_map. This prevents out-of-bounds array indexing, particularly when
> analyzing cross-machine perf recordings where the recorded CPU count may
> exceed the host's CPU count.
> 
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index b1e5c29c6e3ec..d3432622b2adc 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -576,6 +576,10 @@ int cpu__get_node(struct perf_cpu cpu)
> >  		return -1;
> >  	}
> >  
> > +	/* cpunode_map allocated for max_cpu_num entries; input may be untrusted */
> > +	if (cpu.cpu < 0 || cpu.cpu >= max_cpu_num.cpu)
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but parsing sysfs to determine
> the maximum CPU number introduces a memory corruption vulnerability.
> 
> In tools/perf/util/cpumap.c:set_max_cpu_num(), the max possible CPU number
> is parsed from sysfs into a local int max. This value is directly assigned to
> max_cpu_num.cpu, which is an int16_t. If max exceeds 32,767 (as is possible on
> large modern architectures or due to sparse APIC numbering), the assignment
> truncates the value, resulting in a small or negative integer.
> 
> Later, init_cpunode_map() allocates cpunode_map based on this truncated size,
> and cpu__setup_cpunode_map() writes to it without truncation:
> 
> tools/perf/util/cpumap.c:cpu__setup_cpunode_map() {
> ...
> 		while ((dent2 = readdir(dir2)) != NULL) {
> 			if (dent2->d_type != DT_LNK || sscanf(dent2->d_name, "cpu%u", &cpu) < 1)
> 				continue;
> 			cpunode_map[cpu] = mem;
> 		}
> ...
> 
> Could this result in an out-of-bounds write on the heap?
> 
> > +		return -1;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but returning -1 here causes a
> crash in perf_mmap__aio_bind() when a CPU's NUMA node is unknown or mapped to
> a dummy CPU.
> 
> tools/perf/util/mmap.c:perf_mmap__aio_bind() {
> ...
> 		node_index = cpu__get_node(cpu);
> 		node_mask = bitmap_zalloc(node_index + 1);
> 		if (!node_mask) {
> 			pr_err("Failed to allocate node mask for mbind: error %m\n");
> 			return -1;
> 		}
> 		__set_bit(node_index, node_mask);
> ...
> 
> When cpu__get_node() returns -1, it is implicitly cast to unsigned long
> node_index (ULONG_MAX). bitmap_zalloc(ULONG_MAX + 1) evaluates to
> bitmap_zalloc(0) and allocates a minimal buffer.
> 
> Does the subsequent __set_bit(ULONG_MAX, node_mask) perform a wild memory
> write vastly outside the allocated bitmap?
> 
> > +
> >  	return cpunode_map[cpu.cpu];
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing
> builtin-kmem.c which is mentioned in the commit message as calling
> cpu__get_node(), it appears the perf_tool initialization omits the
> .attr callback:
> 
> tools/perf/builtin-kmem.c:cmd_kmem() {
> ...
> 	perf_tool__init(&perf_kmem, /*ordered_events=*/true);
> 	perf_kmem.sample	= process_sample_event;
> 	perf_kmem.comm		= perf_event__process_comm;
> 	perf_kmem.mmap		= perf_event__process_mmap;
> 	perf_kmem.mmap2		= perf_event__process_mmap2;
> 	perf_kmem.namespaces	= perf_event__process_namespaces;
> ...
> 
> In pipe mode (e.g., perf kmem record -o - | perf kmem stat -i -), perf.data
> headers are missing and events must be processed sequentially. Omitting the
> perf_event__process_attr callback causes perf_event_header_attr events to be
> silently discarded by the default stub.
> 
> Does this prevent the creation of evsels and the initialization of the
> perf_env, completely breaking the tool's ability to process piped data
> streams natively?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260605121515.1725549-1-acme@kernel.org?part=2
