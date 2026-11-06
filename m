Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001498;
	b=EWV5R0FlY8sdwwdAMlz7P6cF5M9tk1M2bCEoFweyZDHJa0X/GqNkKfIyK+TzthWCYjI0
	 5y1+SnhH11LDiWXznJRzEf11UOGtGdMWtY5NziE5Cw4ayc6ziUNJnfQt3hYXt43qLXQDw
	 HUIE8RrFd/hXHlnMW+5+/dXysZ8fcJF16u6LUM3EJETsEtD1+/cJWysId8BxTuqkP4D0S
	 yPnaBNYtWXU+E49LqE3bOKd+E1T7A0J1vMjDMZvpN7OYVSdpC/rQIFjLVCX/FIJP+CjaX
	 1OD+tJaIBp0FmjMpCw/YR96YAQcCTWGFcR/BSo5Vi8Fu3LUfZwBunstJalwpTR0z2UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001498;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o6y7zpd4HTLdQTePgJ7BQ9bAxgxtM6ve+DgOROkBU0g=;
	b=uZ5mteNaCPCrjCiBx13vEEFJXlIgx3JuPDEesUptCbaWyEVdpLTFK3jRBvBs+9wBGVL0
	 pUtS0MNvpizjUfIHd0814tS2AN9wtFw8yf91qD4x3tVLL3Pi3LwXHAuLAS+rLTYS007xh
	 J3RY164Eo/LZimDmrX2ULV82YW4Gxe6JSrF7scMkyR5fh2VnkSl9lRrmvHP2arWiSVGVA
	 Dkx53CzeKkOOfTLIYtI68JREYG0Gs3TX22i/UujcMMee4cXdeC7BwQJpKOzPPJdGQOr+G
	 rJT9BZa7ru1eg2q8XTJDhF2VnC1+BVcPuu8NeXpHhwxTk4qztMUVrbxxvqDp3EZcHgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BrT78GB+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF07606A326;
	Fri,  6 Nov 2026 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BrT78GB+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F62C1F0089F;
	Fri,  6 Nov 2026 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794001497;
	bh=o6y7zpd4HTLdQTePgJ7BQ9bAxgxtM6ve+DgOROkBU0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BrT78GB+0O1hMds4+JN9Mq9eJhh/79yUOP/77xeG04uqM7Hkh81IVFN7oRZZW+IvU
	 SvBeBW18uN6VuyAdnwSNNlLS5LIJG+f78+KnXpbyy66k1tZ3pwoEqsbdBOF2yJflVX
	 9ynwNOWm6Cj6Bl0YUJwQC69bzU6UORHYaZ/bo/COS/oI804EspBTSU1NTdFLVI9wXe
	 AtqOvE3JnS68ngOtIoxCk9445DjfhbIlLQO0vjJSkAnB2a/b55hR2GmoTSZZL/zQ5g
	 c5QWHcg31kYmtlONZ7mXGGXuRguXhXoN4y4XtIEUtZR5tG9kbIsmUklt5T47h2NfCi
	 ZRiDhMkQOQ7zg==
Date: Fri, 6 Nov 2026 13:44:54 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Paul Moses <p@1g4.org>, acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	alexey.budankov@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Skip affinity for per-thread mmap buffers
Message-ID: <au5KVuPm-vZKSX3Z@google.com>
References: <20261030065857.2157899-1-p@1g4.org>
 <au1_U_VQGMCLNih1@google.com>
 <WbYsffp5YfE6DLkD1OT419MobQzwgeDDX5a3V2uu_MWCiCVCNHTzTu2gu2mQ9174qccVUepCdcCJEzrgp_BDlmQSJRvX69vdDKIn3j4ex5w=@1g4.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <WbYsffp5YfE6DLkD1OT419MobQzwgeDDX5a3V2uu_MWCiCVCNHTzTu2gu2mQ9174qccVUepCdcCJEzrgp_BDlmQSJRvX69vdDKIn3j4ex5w=@1g4.org>

On Fri, Nov 06, 2026 at 07:32:29AM +0000, Paul Moses wrote:
> 
> 
> 
> 
> On Friday, November 6th, 2026 at 1:18 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hello,
> > 
> > On Fri, Oct 30, 2026 at 06:59:28AM +0000, Paul wrote:
> > > From: Paul Moses <p@1g4.org>
> > >
> > > Per-thread mmap buffers use CPU -1 to mean any CPU. Combining --per-thread
> > > with --affinity=cpu passes this value to __set_bit() when constructing the
> > > reader affinity mask, causing an out-of-bounds bitmap access and SIGSEGV.
> > >
> > > Program received signal SIGSEGV, Segmentation fault.
> > > 0x0000555555f3488e in mmap.mmap ()
> > > #0  0x0000555555f3488e in mmap.mmap ()
> > > #1  0x0000555555e2f7bf in mmap_per_evsel (evlist=evlist@entry=0x7fffedcc1150, ops=ops@entry=0x7fffffffaf50, idx=idx@entry=0, mp=mp@entry=0x7fffffffaf70, cpu_idx=cpu_idx@entry=0, thread=thread@entry=0, _output=0x7fffffffaf08, _output_overwrite=0x7fffffffaf04, nr_mmaps=0x7fffffffaf0c) at evlist.c:598
> > > #2  0x0000555555e2ef96 in mmap_per_thread (evlist=0x7fffedcc1150, ops=0x7fffffffaf50, mp=0x7fffffffaf70) at evlist.c:650
> > > #3  perf_evlist__mmap_ops (evlist=0x7fffedcc1150, ops=0x7fffffffaf50, mp=0x7fffffffaf70) at evlist.c:748
> > > #4  0x0000555555f2150d in evlist.mmap_ex ()
> > > #5  0x0000555555db0b0a in record.open ()
> > > #6  0x0000555555dadea7 in __cmd_record ()
> > > #7  0x0000555555daca89 in cmd_record ()
> > > #8  0x0000555555e27d53 in run_builtin ()
> > > #9  0x0000555555e277cf in main ()
> > 
> > Please indent terminal outpus otherwise git will eat up lines start with
> > the hash (#).
> > 
> > > rip            0x555555f3488e      0x555555f3488e <mmap.mmap+382>
> > > rax            0x7fffef9e9bd0      140737213537232
> > > rbx            0x7fffedd249a0      140737183369632
> > > rcx            0x3ffffffffffffff   288230376151711743
> > > rdx            0x8000000000000000  -9223372036854775808
> > > rsi            0x0                 0
> > > rdi            0x7fffef9e9bd0      140737213537232
> > >    0x555555f34876 <mmap__mmap+358>:	movswq 0x10(%rbx),%rcx
> > >    0x555555f3487b <mmap__mmap+363>:	mov    0xb8(%rbx),%rax
> > >    0x555555f34882 <mmap__mmap+370>:	mov    $0x1,%edx
> > >    0x555555f34887 <mmap__mmap+375>:	shl    %cl,%rdx
> > >    0x555555f3488a <mmap__mmap+378>:	shr    $0x6,%rcx
> > > => 0x555555f3488e <mmap__mmap+382>:	or     %rdx,(%rax,%rcx,8)
> > >    0x555555f34892 <mmap__mmap+386>:	lea    0x17711b(%rip),%r14        # 0x5555560ab9b4 <verbose>
> > >    0x555555f34899 <mmap__mmap+393>:	cmpl   $0x2,(%r14)
> > >    0x555555f3489d <mmap__mmap+397>:	jne    0x555555f348f7 <mmap__mmap+487>
> > >    0x555555f3489f <mmap__mmap+399>:	mov    0xb8(%rbx),%rdi
> > >    0x555555f348a6 <mmap__mmap+406>:	mov    0xc0(%rbx),%esi
> > >    0x555555f348ac <mmap__mmap+412>:	lea    -0x430(%rbp),%r12
> > >
> > > Only construct and apply reader affinity masks for buffers with a
> > > nonnegative CPU. Skip the reader-side bitmap operations as well, since
> > > per-thread buffers no longer allocate an affinity mask.
> > 
> > Maybe we can just reject those options when they are used together.
> > 
> > Thanks,
> > Namhyung
> > 
> > >
> > > Fixes: 8384a2600c7d ("perf record: Adapt affinity to machines with #CPUs > 1K")
> > > Signed-off-by: Paul Moses <p@1g4.org>
> > > ---
> > >  tools/perf/builtin-record.c | 2 +-
> > >  tools/perf/util/mmap.c      | 4 ++--
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index a57987851cf0..d7c8f490cb62 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -1565,7 +1565,7 @@ static struct perf_event_header finished_init_event = {
> > >
> > >  static void record__adjust_affinity(struct record *rec, struct mmap *map)
> > >  {
> > > -	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
> > > +	if (map->core.cpu.cpu >= 0 && rec->opts.affinity != PERF_AFFINITY_SYS &&
> > >  	    !bitmap_equal(thread->mask->affinity.bits, map->affinity_mask.bits,
> > >  			  thread->mask->affinity.nbits)) {
> > >  		bitmap_zero(thread->mask->affinity.bits, thread->mask->affinity.nbits);
> > > diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> > > index 358e70c4f3ed..be3dffdaede8 100644
> > > --- a/tools/perf/util/mmap.c
> > > +++ b/tools/perf/util/mmap.c
> > > @@ -292,8 +292,8 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
> > >  		return -1;
> > >  	}
> > >
> > > -	if (mp->affinity != PERF_AFFINITY_SYS &&
> > > -		perf_mmap__setup_affinity_mask(map, mp)) {
> > > +	if (cpu.cpu >= 0 && mp->affinity != PERF_AFFINITY_SYS &&
> > > +	    perf_mmap__setup_affinity_mask(map, mp)) {
> > >  		pr_debug2("failed to alloc mmap affinity mask, error %d\n",
> > >  			  errno);
> > >  		return -1;
> > > --
> > > 2.56.GIT
> > >
> > >
> > 
> 
> 
> Hi Namhyung,
> 
> Can we please get this one settled first. There have been issues
> with important patches being overlooked for months.
> 
> https://lore.kernel.org/linux-perf-users/20261020171946.3593127-1-p@1g4.org/

Sorry about the delay.  But please understand that there can be some
delays during a merge window.  I'll take a look at the link but you
can ping me if it takes too long.

Arnaldo, I think it's simple enough to go to v7.4.

Thanks,
Namhyung

