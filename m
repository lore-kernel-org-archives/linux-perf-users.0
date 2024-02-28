Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A813D311
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162961; cv=none; b=t2gFn1XKbR2OQVkDNkD20dE3baEuVeFaAB4kSR3XQrx3iSXxZtecphjlOt3YN0kWfXq3oZ/bDIiCSh2cxXumo6gCVplANLJMXuN0n9o+MNM86ubttp6h+F/nUxy4paSBhOceGF7TtokcEKq70oEwiDN/J2o4BiZ48q+awNA5n5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162961; c=relaxed/simple;
	bh=41UFiklEjWil3jkAoazVv0RzX3VREWustC/r35g0+ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR/Kw+02Y3adIiLndOs6zVFmjq2T+uGNWeQoTEZ8BvmM9qt6Xoq3/8fbuqeAAla++EQkLwAKJCc9NI8TvBn1CkIaCOyn+wKy8lMDulsHenB0+rPy7zPnkTF9XLUz164nwnMHXjGIuBroMe2rU2xDnrgP+i+fABr44y8ViyEE7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cteqrlww; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cteqrlww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709162960; x=1740698960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=41UFiklEjWil3jkAoazVv0RzX3VREWustC/r35g0+ls=;
  b=cteqrlwwTJYFwvlfXtJdEJ/nuHczLvdk7cTwbdNosJesrut7AIvs7YZA
   +cvUvRSrR5q7r96NS65fZPDBQTjHZbnVAhELI9NKIifZD3rRJpTaHBN7V
   6rN5rNd281tCzhR7Txv5wHtile3hDC0Z1KSuXjEnABZuoC4TLbD6E3ehz
   T/fJXJGFYvvIRetzsPm01kWzktZcBkFDmJ61oq5FC3yebjl1cZ4yHKUen
   /pCbpsWvbkEumo0Qx34IDBu5D6jrSLAjhsJ0F5iX5yBzsGzZTxCjoPvOP
   PUBbU/5bOAN3754h5deIazlucb9PMyRzeV98793bbV5EMcsuQniB/JSYd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3764193"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3764193"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:29:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12173614"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:29:17 -0800
Date: Wed, 28 Feb 2024 15:29:16 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Changbin Du <changbin.du@huawei.com>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com
Subject: Re: [PATCH 1/2] perf, capstone: Support 32bit code under 64bit OS
Message-ID: <Zd_BzC4gHONl0VL7@tassilo>
References: <20240227234806.82694-1-ak@linux.intel.com>
 <20240228110006.piqtuyhvrjq2lulq@M910t>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228110006.piqtuyhvrjq2lulq@M910t>

On Wed, Feb 28, 2024 at 07:00:06PM +0800, Changbin Du wrote:
> On Tue, Feb 27, 2024 at 03:48:04PM -0800, Andi Kleen wrote:
> > Use the DSO to resolve whether an IP is 32bit or 64bit and use that to
> > configure capstone to the correct mode. This allows to correctly
> > disassemble 32bit code under a 64bit OS.
> > 
> > % cat > loop.c
> > volatile int var;
> > int main(void)
> > {
> > 	int i;
> > 	for (i = 0; i < 100000; i++)
> > 		var++;
> > }
> > % gcc -m32 -o loop loop.c
> > % perf record -e cycles:u ./loop
> > % perf script -F +disasm
> >             loop   82665 1833176.618023:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> >             loop   82665 1833176.618029:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> >             loop   82665 1833176.618031:          7 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> >             loop   82665 1833176.618034:         91 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> >             loop   82665 1833176.618036:       1242 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/util/print_insn.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> > index 459e0e93d7b1..bd7a95e64ce5 100644
> > --- a/tools/perf/util/print_insn.c
> > +++ b/tools/perf/util/print_insn.c
> > @@ -12,6 +12,8 @@
> >  #include "machine.h"
> >  #include "thread.h"
> >  #include "print_insn.h"
> > +#include "map.h"
> > +#include "dso.h"
> >  
> >  size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
> >  {
> > @@ -28,12 +30,12 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
> >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> >  #include <capstone/capstone.h>
> >  
> > -static int capstone_init(struct machine *machine, csh *cs_handle)
> > +static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
> >  {
> >  	cs_arch arch;
> >  	cs_mode mode;
> >  
> > -	if (machine__is(machine, "x86_64")) {
> > +	if (machine__is(machine, "x86_64") && is64) {
> >  		arch = CS_ARCH_X86;
> >  		mode = CS_MODE_64;
> >  	} else if (machine__normalized_is(machine, "x86")) {
> > @@ -101,9 +103,21 @@ size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *threa
> >  	size_t count;
> >  	size_t printed = 0;
> >  	int ret;
> > +	struct addr_location al;
> > +	bool is64bit = machine__is(machine, "x86_64");
> > +	struct dso *dso;
> > +
> > +	addr_location__init(&al);
> > +	if (thread__find_map(thread, sample->cpumode, sample->ip, &al) &&
> > +		(dso = map__dso(al.map)) != NULL &&
> > +		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
> > +		map__load(al.map);
> > +		is64bit = dso->is_64_bit;
> > +	}
> > +	addr_location__exit(&al);
> >
> This could be extracted as a standalone function. And this should apply to arm64
> also.

It should work for ARM64 too, at least for the sample case which it
supports. I haven't tested it however because I don't have such a
system.

-Andi
