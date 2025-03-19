Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557F35942;
	Wed, 19 Mar 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391063; cv=none; b=S1eivqDI8edFJjbSvbgM75TfOhl8DLeSsw2cQCVunzVgHP61uP+PEYLMBZG7tqznwBhzBwHze8fjCznw6pEQkFiCtIXYGfmAFljK7cCr6EQ5AUus8OqOJaDmjMJMdSpqmgJYnoTPYr6NjmPKRvTcaRpomlARtFFZdpinaDFoCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391063; c=relaxed/simple;
	bh=0Epci9SDyt00rMVYsl2p86Xlmpbww68QfF792+rVcVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsD05TRHtS1uHpYatIz7E4obHihej9wWXs2zW9ppdzeso2MSO35KPD52VhzqbON4vPO3aD/3qFF5MoXqMIiC0XqrZq7cjjQGauOi1mKQZaeX+FCbtVZVKGv/Tm9vXg64/cUpqCAP47Eu4dOWoojkG/tQ0q0ek/xmV4QF6DBeWVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88026113E;
	Wed, 19 Mar 2025 06:31:08 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F354A3F673;
	Wed, 19 Mar 2025 06:30:59 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:30:55 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Restore {0} initializer since GCC-15
Message-ID: <20250319133055.GA3249206@e132581.arm.com>
References: <20250319110454.3230687-1-leo.yan@arm.com>
 <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>

On Wed, Mar 19, 2025 at 11:19:38AM +0000, James Clark wrote:
> 
> On 19/03/2025 11:04 am, Leo Yan wrote:
> > GCC-15 release claims [1]:
> > 
> >   {0} initializer in C or C++ for unions no longer guarantees clearing
> >   of the whole union (except for static storage duration initialization),
> >   it just initializes the first union member to zero. If initialization
> >   of the whole union including padding bits is desirable, use {} (valid
> >   in C23 or C++) or use -fzero-init-padding-bits=unions option to
> >   restore old GCC behavior.
> > 
> > This new behaviour might cause stale and unexpected data we defined in
> > Perf.  Add the -fzero-init-padding-bits=unions option for entirely
> > zeroing union structures.
> > 
> 
> Do we need this? I don't see any unions initialized in that way. In fact
> there is only one struct initialized with {0}, the other handful are char*s
> but I don't think either are affected.

Though I did not found a straightforward case in Perf for initializing
union with "{0}", the result I got:

$ git grep -E "\{ *0 *\}" tools/perf/
tools/perf/arch/x86/tests/insn-x86.c:   {{0}, 0, 0, NULL, NULL, NULL},
tools/perf/arch/x86/tests/insn-x86.c:   {{0}, 0, 0, NULL, NULL, NULL},
tools/perf/arch/x86/tests/intel-pt-test.c:      {1, {0}, 0, {INTEL_PT_PAD, 0, 0}, 0, 1 },
tools/perf/arch/x86/tests/intel-pt-test.c:      {0, {0}, 0, {0, 0, 0}, 0, 0 },
tools/perf/arch/x86/util/perf_regs.c:   char new_reg[SDT_REG_NAME_SIZE] = {0};
tools/perf/arch/x86/util/perf_regs.c:   char prefix[3] = {0};
tools/perf/builtin-kwork.c:             .nr_skipped_events   = { 0 },
tools/perf/builtin-record.c:    u8 pad[8] = {0};
tools/perf/python/twatch.py:                    print("cpu: {0}, pid: {1}, tid: {2} {3}".format(event.sample_cpu,
tools/perf/tests/code-reading.c:        unsigned char buf1[BUFSZ] = {0};
tools/perf/tests/code-reading.c:        unsigned char buf2[BUFSZ] = {0};
tools/perf/util/bpf_counter.c:  struct bpf_map_info map_info = {0};
tools/perf/util/bpf_kwork.c:    char name[MAX_KWORKNAME] = { 0 };
tools/perf/util/bpf_skel/bperf_follower.bpf.c:  struct bperf_filter_value child_fval = { 0 };
tools/perf/util/lzma.c: char buf[6] = { 0 };
tools/perf/util/mem-events.c:bool perf_mem_record[PERF_MEM_EVENTS__MAX] = { 0 };
tools/perf/util/mem-events.c:   char hit_miss[5] = {0};
tools/perf/util/trace-event-scripting.c:        char xs[16] = {0};
tools/perf/util/zlib.c: char buf[2] = { 0 };

We can see the bpf structures (bpf_map_info/bperf_filter_value) are
initialized with {0}.  For a more complex case, {0} is used for
initialize a specific field in a structure (see the results in
insn-x86.c and intel-pt-test.c).

> Adding options that allow people to add more non standard code doesn't feel
> very portable or in the spirit of doing it the right way. Maybe there's an
> argument that it guards against future mistakes, but it's not mentioned in
> the commit message.

I think Linux perf shares the same understanding with "we do expect
initializers that always initialize the whole variable fully" (quote
in [1]).  Furthermore, the reply mentioned:

 The exact same problem happens with "{ 0 }" as happens with "{ }".
 The bug is literally that some versions of clang seem to implement
 BOTH of these as "initialize the first member of the union", which
 then means that if the first member isn't the largest member, the
 rest of the union is entirely undefined.

So I think it is reasonable to imposes a compiler option to make
compiler's behavouir consistent.

Thanks,
Leo

[1] https://www.spinics.net/lists/netdev/msg1007244.html
