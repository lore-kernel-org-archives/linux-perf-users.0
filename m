Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AA5A0E9
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118071; cv=none; b=eIYPHOn1su3MUIeibDODxgzkc0+NaVzGHdtWM3kbt4vy167OuPWIWD+rk7mLHuYtfuEC839qv6FS/X3Jjib53UUPK98vS3PKkWz/RZZNo6LFKNAsYPw/LwSlZwzO4v5ubMMuhpRw4SCu1HoruBHPib4w6pdbJhmz3z9gltWcfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118071; c=relaxed/simple;
	bh=UklRYJMsti1hNmFuzUO6uYxUiE10spch1+76ldS8PGM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYj/wdFp/NQnNcqpVoPBZZ/NJv2rd/rZYv5vxtKduRKVha2kro1pstKEl5u+UExl4Vx7VdwoIf/rn1aWnLlEEtf5y3uqWBYlJ1Pfl4BdR4U6VbAkP2evqJDVkTqyi6FE5uWJeUuNTmNYtfQKwJr012/62y73if7Y2+fVhCmx7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TlBDN3gXlz1Q8TB;
	Wed, 28 Feb 2024 18:58:44 +0800 (CST)
Received: from kwepemd500001.china.huawei.com (unknown [7.221.188.144])
	by mail.maildlp.com (Postfix) with ESMTPS id D486018002F;
	Wed, 28 Feb 2024 19:00:59 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd500001.china.huawei.com (7.221.188.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 28 Feb 2024 19:00:59 +0800
Received: from M910t (10.110.54.157) by kwepemd100011.china.huawei.com
 (7.221.188.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 28 Feb
 2024 19:00:59 +0800
Date: Wed, 28 Feb 2024 19:00:06 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Andi Kleen <ak@linux.intel.com>
CC: <linux-perf-users@vger.kernel.org>, <changbin.du@huawei.com>,
	<adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] perf, capstone: Support 32bit code under 64bit OS
Message-ID: <20240228110006.piqtuyhvrjq2lulq@M910t>
References: <20240227234806.82694-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240227234806.82694-1-ak@linux.intel.com>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100011.china.huawei.com (7.221.188.204)

On Tue, Feb 27, 2024 at 03:48:04PM -0800, Andi Kleen wrote:
> Use the DSO to resolve whether an IP is 32bit or 64bit and use that to
> configure capstone to the correct mode. This allows to correctly
> disassemble 32bit code under a 64bit OS.
> 
> % cat > loop.c
> volatile int var;
> int main(void)
> {
> 	int i;
> 	for (i = 0; i < 100000; i++)
> 		var++;
> }
> % gcc -m32 -o loop loop.c
> % perf record -e cycles:u ./loop
> % perf script -F +disasm
>             loop   82665 1833176.618023:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>             loop   82665 1833176.618029:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>             loop   82665 1833176.618031:          7 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>             loop   82665 1833176.618034:         91 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
>             loop   82665 1833176.618036:       1242 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/util/print_insn.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> index 459e0e93d7b1..bd7a95e64ce5 100644
> --- a/tools/perf/util/print_insn.c
> +++ b/tools/perf/util/print_insn.c
> @@ -12,6 +12,8 @@
>  #include "machine.h"
>  #include "thread.h"
>  #include "print_insn.h"
> +#include "map.h"
> +#include "dso.h"
>  
>  size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
>  {
> @@ -28,12 +30,12 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>  #include <capstone/capstone.h>
>  
> -static int capstone_init(struct machine *machine, csh *cs_handle)
> +static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
>  {
>  	cs_arch arch;
>  	cs_mode mode;
>  
> -	if (machine__is(machine, "x86_64")) {
> +	if (machine__is(machine, "x86_64") && is64) {
>  		arch = CS_ARCH_X86;
>  		mode = CS_MODE_64;
>  	} else if (machine__normalized_is(machine, "x86")) {
> @@ -101,9 +103,21 @@ size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *threa
>  	size_t count;
>  	size_t printed = 0;
>  	int ret;
> +	struct addr_location al;
> +	bool is64bit = machine__is(machine, "x86_64");
> +	struct dso *dso;
> +
> +	addr_location__init(&al);
> +	if (thread__find_map(thread, sample->cpumode, sample->ip, &al) &&
> +		(dso = map__dso(al.map)) != NULL &&
> +		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
> +		map__load(al.map);
> +		is64bit = dso->is_64_bit;
> +	}
> +	addr_location__exit(&al);
>
This could be extracted as a standalone function. And this should apply to arm64
also.

>  	/* TODO: Try to initiate capstone only once but need a proper place. */
> -	ret = capstone_init(machine, &cs_handle);
> +	ret = capstone_init(machine, &cs_handle, is64bit);
>  	if (ret < 0) {
>  		/* fallback */
>  		return sample__fprintf_insn_raw(sample, fp);
> -- 
> 2.43.0
> 

-- 
Cheers,
Changbin Du
