Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB01386A8
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118396; cv=none; b=iMBHeMljKg9I4GQVWD0g7HndZCXqGZ0jBIkJYIGmJZ53ERZHAHAeruKufNjDirpVwiF331S5PfTjScKJI8S8vBaD1ZpqDzBm2ycQ0+KS23/B6QNsVjquBxuS0WHPKi+SK0BvXnOAfEu0Y5X0arGq3xmaubSWkuzWKNHVGdyJ+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118396; c=relaxed/simple;
	bh=WmjfnJ9X1eJk6bYuMqRFkeoeCbY6YxypGQEt8Aw/nHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDC2JL9JU92tViszkI43nybN97cmKWlhNFMSW/3BtXnTi9rHSf0lvaGIXaOXqGpYmqaEcRvH6sPK3I9DdHFiGsdKN4j3iFiBvnmqAmSOu40a2u6th/tuYsUyI5poooH48RXXeibEA0W4otZ86KR38QSKxy4k0AhJ0Kna/CigkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TlBNX6R7hzLnZ9;
	Wed, 28 Feb 2024 19:05:48 +0800 (CST)
Received: from kwepemd100001.china.huawei.com (unknown [7.221.188.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 26626140414;
	Wed, 28 Feb 2024 19:06:28 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100001.china.huawei.com (7.221.188.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 28 Feb 2024 19:06:27 +0800
Received: from M910t (10.110.54.157) by kwepemd100011.china.huawei.com
 (7.221.188.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 28 Feb
 2024 19:06:27 +0800
Date: Wed, 28 Feb 2024 19:05:34 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Andi Kleen <ak@linux.intel.com>
CC: <linux-perf-users@vger.kernel.org>, <changbin.du@huawei.com>,
	<adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] perf, capstone: Support capstone for -F +brstackinsn
Message-ID: <20240228110534.mradyavqgzfln5mg@M910t>
References: <20240227234806.82694-1-ak@linux.intel.com>
 <20240227234806.82694-2-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240227234806.82694-2-ak@linux.intel.com>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100011.china.huawei.com (7.221.188.204)

On Tue, Feb 27, 2024 at 03:48:05PM -0800, Andi Kleen wrote:
> Support capstone output for the -F +brstackinsn branch dump.
> It is only enabled when -F +disasm is specified.
> This was possible before with --xed, but now also allow
> it for users that don't have xed using the builtin capstone support.
By this, 'disasm' acts as a flag but not a field any more.

> Before:
> 
> perf record -b emacs -Q --batch '()'
> perf script -F +brstackinsn
> ...
>           emacs   55778 1814366.755945:     151564 cycles:P:      7f0ab2d17192 intel_check_word.constprop.0+0x162 (/usr/lib64/ld-linux-x86-64.s>        intel_check_word.constprop.0+237:
>         00007f0ab2d1711d        insn: 75 e6                     # PRED 3 cycles [3]
>         00007f0ab2d17105        insn: 73 51
>         00007f0ab2d17107        insn: 48 89 c1
>         00007f0ab2d1710a        insn: 48 39 ca
>         00007f0ab2d1710d        insn: 73 96
>         00007f0ab2d1710f        insn: 48 8d 04 11
>         00007f0ab2d17113        insn: 48 d1 e8
>         00007f0ab2d17116        insn: 49 8d 34 c1
>         00007f0ab2d1711a        insn: 44 3a 06
>         00007f0ab2d1711d        insn: 75 e6                     # PRED 3 cycles [6] 3.00 IPC
>         00007f0ab2d17105        insn: 73 51                     # PRED 1 cycles [7] 1.00 IPC
>         00007f0ab2d17158        insn: 48 8d 50 01
>         00007f0ab2d1715c        insn: eb 92                     # PRED 1 cycles [8] 2.00 IPC
>         00007f0ab2d170f0        insn: 48 39 ca
>         00007f0ab2d170f3        insn: 73 b0                     # PRED 1 cycles [9] 2.00 IPC
> 
> After (perf must be compiled with capstone):
> 
> perf script -F +brstackinsn,+disasm
> 
> ...
>            emacs   55778 1814366.755945:     151564 cycles:P:      7f0ab2d17192 intel_check_word.constprop.0+0x162 (/usr/lib64/ld-linux-x86-64.s>        intel_check_word.constprop.0+237:
>         00007f0ab2d1711d        jne intel_check_word.constprop.0+0xd5   # PRED 3 cycles [3]
>         00007f0ab2d17105        jae intel_check_word.constprop.0+0x128
>         00007f0ab2d17107        movq %rax, %rcx
>         00007f0ab2d1710a        cmpq %rcx, %rdx
>         00007f0ab2d1710d        jae intel_check_word.constprop.0+0x75
>         00007f0ab2d1710f        leaq (%rcx, %rdx), %rax
>         00007f0ab2d17113        shrq $1, %rax
>         00007f0ab2d17116        leaq (%r9, %rax, 8), %rsi
>         00007f0ab2d1711a        cmpb (%rsi), %r8b
>         00007f0ab2d1711d        jne intel_check_word.constprop.0+0xd5   # PRED 3 cycles [6] 3.00 IPC
>         00007f0ab2d17105        jae intel_check_word.constprop.0+0x128  # PRED 1 cycles [7] 1.00 IPC
>         00007f0ab2d17158        leaq 1(%rax), %rdx
>         00007f0ab2d1715c        jmp intel_check_word.constprop.0+0xc0   # PRED 1 cycles [8] 2.00 IPC
>         00007f0ab2d170f0        cmpq %rcx, %rdx
>         00007f0ab2d170f3        jae intel_check_word.constprop.0+0x75   # PRED 1 cycles [9] 2.00 IPC
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-script.c  | 23 +++++++++++++---
>  tools/perf/util/dump-insn.h  |  1 +
>  tools/perf/util/print_insn.c | 52 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/print_insn.h |  3 +++
>  4 files changed, 75 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 37088cc0ff1b..f18bcf61be8b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1162,6 +1162,20 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
>  	return ret;
>  }
>  
> +static const char *any_dump_insn(struct perf_event_attr *attr,
> +			struct perf_insn *x, uint64_t ip,
> +			u8 *inbuf, int inlen, int *lenp)
> +{
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +	if (PRINT_FIELD(DISASM)) {
> +		const char *p = cs_dump_insn(x, ip, inbuf, inlen, lenp);
> +		if (p)
> +			return p;
> +	}
> +#endif
> +	return dump_insn(x, ip, inbuf, inlen, lenp);
> +}
> +
>  static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>  			    struct perf_insn *x, u8 *inbuf, int len,
>  			    int insn, FILE *fp, int *total_cycles,
> @@ -1170,7 +1184,7 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>  {
>  	int ilen = 0;
>  	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t", ip,
> -			      dump_insn(x, ip, inbuf, len, &ilen));
> +			      any_dump_insn(attr, x, ip, inbuf, len, &ilen));
>  
>  	if (PRINT_FIELD(BRSTACKINSNLEN))
>  		printed += fprintf(fp, "ilen: %d\t", ilen);
> @@ -1262,6 +1276,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  		nr = max_blocks + 1;
>  
>  	x.thread = thread;
> +	x.machine = machine;
>  	x.cpu = sample->cpu;
>  
>  	printed += fprintf(fp, "%c", '\n');
> @@ -1313,7 +1328,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  			} else {
>  				ilen = 0;
>  				printed += fprintf(fp, "\t%016" PRIx64 "\t%s", ip,
> -						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
> +						   any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen));
>  				if (PRINT_FIELD(BRSTACKINSNLEN))
>  					printed += fprintf(fp, "\tilen: %d", ilen);
>  				printed += fprintf(fp, "\n");
> @@ -1361,7 +1376,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  			goto out;
>  		ilen = 0;
>  		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", sample->ip,
> -			dump_insn(&x, sample->ip, buffer, len, &ilen));
> +			any_dump_insn(attr, &x, sample->ip, buffer, len, &ilen));
>  		if (PRINT_FIELD(BRSTACKINSNLEN))
>  			printed += fprintf(fp, "\tilen: %d", ilen);
>  		printed += fprintf(fp, "\n");
> @@ -1372,7 +1387,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  	for (off = 0; off <= end - start; off += ilen) {
>  		ilen = 0;
>  		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", start + off,
> -				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
> +				   any_dump_insn(attr, &x, start + off, buffer + off, len - off, &ilen));
>  		if (PRINT_FIELD(BRSTACKINSNLEN))
>  			printed += fprintf(fp, "\tilen: %d", ilen);
>  		printed += fprintf(fp, "\n");
> diff --git a/tools/perf/util/dump-insn.h b/tools/perf/util/dump-insn.h
> index 650125061530..4a7797dd6d09 100644
> --- a/tools/perf/util/dump-insn.h
> +++ b/tools/perf/util/dump-insn.h
> @@ -11,6 +11,7 @@ struct thread;
>  struct perf_insn {
>  	/* Initialized by callers: */
>  	struct thread *thread;
> +	struct machine *machine;
>  	u8	      cpumode;
>  	bool	      is64bit;
>  	int	      cpu;
> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> index bd7a95e64ce5..35785ab22c07 100644
> --- a/tools/perf/util/print_insn.c
> +++ b/tools/perf/util/print_insn.c
> @@ -12,6 +12,7 @@
>  #include "machine.h"
>  #include "thread.h"
>  #include "print_insn.h"
> +#include "dump-insn.h"
>  #include "map.h"
>  #include "dso.h"
>  
> @@ -71,6 +72,57 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
>  	return 0;
>  }
>  
> +static void dump_insn_x86(struct thread *thread, cs_insn *insn, struct perf_insn *x)
> +{
> +	struct addr_location al;
> +	bool printed = false;
> +
> +	if (insn->detail && insn->detail->x86.op_count == 1) {
> +		cs_x86_op *op = &insn->detail->x86.operands[0];
> +
> +		addr_location__init(&al);
> +		if (op->type == X86_OP_IMM &&
> +		    thread__find_symbol(thread, x->cpumode, op->imm, &al) &&
> +		    al.sym &&
> +		    al.addr < al.sym->end) {
> +			snprintf(x->out, sizeof(x->out), "%s %s+%#" PRIx64 " [%#" PRIx64 "]", insn[0].mnemonic,
> +					al.sym->name, al.addr - al.sym->start, op->imm);
> +			printed = true;
> +		}
> +		addr_location__exit(&al);
> +	}
> +
> +	if (!printed)
> +		snprintf(x->out, sizeof(x->out), "%s %s", insn[0].mnemonic, insn[0].op_str);
> +}
> +
> +const char *cs_dump_insn(struct perf_insn *x, uint64_t ip,
> +			 u8 *inbuf, int inlen, int *lenp)
> +{
> +	int ret;
> +	int count;
> +	cs_insn *insn;
> +	csh cs_handle;
> +
> +	ret = capstone_init(x->machine, &cs_handle, x->is64bit);
> +	if (ret < 0)
> +		return NULL;
> +
> +	count = cs_disasm(cs_handle, (uint8_t *)inbuf, inlen, ip, 1, &insn);
> +	if (count > 0) {
> +		if (machine__normalized_is(x->machine, "x86"))
> +			dump_insn_x86(x->thread, &insn[0], x);
> +		else
> +			snprintf(x->out, sizeof(x->out), "%s %s",
> +					insn[0].mnemonic, insn[0].op_str);
> +		*lenp = insn->size;
> +		cs_free(insn, count);
> +	} else {
> +		return NULL;
> +	}
> +	return x->out;
> +}
Most of above codes are duplicated. The difference between dumping and printing is
only the output target. So the could share common code.

> +
>  static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
>  			     cs_insn *insn, FILE *fp)
>  {
> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> index 465bdcfcc2fd..135d78322f71 100644
> --- a/tools/perf/util/print_insn.h
> +++ b/tools/perf/util/print_insn.h
> @@ -8,9 +8,12 @@
>  struct perf_sample;
>  struct thread;
>  struct machine;
> +struct perf_insn;
>  
>  size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
>  				struct machine *machine, FILE *fp);
>  size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
> +const char *cs_dump_insn(struct perf_insn *x, uint64_t ip,
> +                         u8 *inbuf, int inlen, int *lenp);
>  
>  #endif /* PERF_PRINT_INSN_H */
> -- 
> 2.43.0
> 

-- 
Cheers,
Changbin Du
