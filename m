Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37F1C695
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Mar 2024 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505163; cv=none; b=hn3zexWFgrbKjAzcHyBt31JFCu41na8qWXQQEtSqpD9DAfj8JJBJ715lZK/eFRWntHwv1DNTYuYrGGuhd5HaCYDu/ueKc4mTkZZxvyVc2WKL3hYHO3fGn1GyDe7RkMAB2B0w/5Dr/cMrZLh5WsQ/V+GdMicVu6SZTVvNiKWqA5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505163; c=relaxed/simple;
	bh=EvTDZk0be3c93P7qV/KWi+BXmb8alObzmv7mFRg2Nmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPStCZP0RTJSh2g+ybE6A9tCXNCvRwdVDjkolpl59m6E/IsDWfWdFwAITBbS+wb82RcBPD+EnJnRZdXK3fBt5HS8B7jDefwjpiIiMvrZ8ihVSApLim4f/WUcQtZZozPzdD/lQEmKJjUAsPRhu/12pA7bL03Ax2d9fVYvSYzlZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8/q0rW4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8/q0rW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710505162; x=1742041162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EvTDZk0be3c93P7qV/KWi+BXmb8alObzmv7mFRg2Nmg=;
  b=i8/q0rW4FzQCTEHK8c1jyIs35nBw8qTDkzd94H2Mht7MLaW1fLAITaEe
   6ZgKygRY3VCYkpuk0hkMHnT/i9iuxBBSvHlvbeUyn2nxcjTW3pZCidcML
   xFYrZvK62WrKRow4v5pVb/05IxM4k1Y9CasjPTsgzKZ4cbBUlFbQ65AkB
   ihH8KbWXBqw9Y/+z10PKMHvTAPwWWP4P10wvi7z5pxyrx68TPExEuGsJb
   GvfgxeJDTllDoM4B0yZwiiUs5xSroA9X0VFBxbSOM7EhTKZ1td4o8PKtU
   Vd80IVMyG0lRBSwZaKeDONKFihHAExU9f/fcg6ELJTW/GWxxkcLkflAiT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="22832730"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="22832730"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 05:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="12694014"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.209.226])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 05:19:18 -0700
Message-ID: <bd71b8f5-bf56-4af5-bd55-deb12cc01415@intel.com>
Date: Fri, 15 Mar 2024 14:19:15 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf, script, capstone: Add support for -F
 +brstackdisasm
Content-Language: en-US
To: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
Cc: changbin.du@huawei.com
References: <20240308170611.719794-1-ak@linux.intel.com>
 <20240308170611.719794-2-ak@linux.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240308170611.719794-2-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/03/24 19:06, Andi Kleen wrote:
> Support capstone output for the -F +brstackinsn branch dump.
> The new output is enabled with the new field brstackdisasm
> This was possible before with --xed, but now also allow
> it for users that don't have xed using the builtin capstone support.
> 
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
> perf script -F +brstackdisasm
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
> 
> ---
> 
> v2: Use brstackdisasm instead of keying of disasm
> ---
>  tools/perf/Documentation/perf-script.txt |  7 +++-
>  tools/perf/builtin-script.c              | 32 +++++++++++----
>  tools/perf/util/dump-insn.h              |  1 +
>  tools/perf/util/print_insn.c             | 52 ++++++++++++++++++++++++
>  tools/perf/util/print_insn.h             |  3 ++
>  5 files changed, 86 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 005e51df855e..ff086ef05a0c 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -132,9 +132,9 @@ OPTIONS
>          Comma separated list of fields to print. Options are:
>          comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
>          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
> -        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, disasm,
> +        brstackinsn, brstackinsnlen, brstackdisasm, brstackoff, callindent, insn, disasm,
>          insnlen, synth, phys_addr, metric, misc, srccode, ipc, data_page_size,
> -        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat.
> +        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat,
>  
>          Field list can be prepended with the type, trace, sw or hw,
>          to indicate to which event type the field list applies.
> @@ -257,6 +257,9 @@ OPTIONS
>  	can’t know the next sequential instruction after an unconditional branch unless
>  	you calculate that based on its length.
>  
> +	brstackdisasm acts like brstackinsn, but will print disassembled instructions if
> +	perf is built with the capstone library.
> +
>  	The brstackoff field will print an offset into a specific dso/binary.
>  
>  	With the metric option perf script can compute metrics for
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 0299b1ed8744..db18d2c54c59 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -136,6 +136,7 @@ enum perf_output_field {
>  	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
>  	PERF_OUTPUT_DSOFF           = 1ULL << 41,
>  	PERF_OUTPUT_DISASM          = 1ULL << 42,
> +	PERF_OUTPUT_BRSTACKDISASM   = 1ULL << 43,
>  };
>  
>  struct perf_script {
> @@ -210,6 +211,7 @@ struct output_option {
>  	{.str = "vcpu", .field = PERF_OUTPUT_VCPU},
>  	{.str = "cgroup", .field = PERF_OUTPUT_CGROUP},
>  	{.str = "retire_lat", .field = PERF_OUTPUT_RETIRE_LAT},
> +	{.str = "brstackdisasm", .field = PERF_OUTPUT_BRSTACKDISASM},
>  };
>  
>  enum {
> @@ -510,7 +512,8 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  		       "selected. Hence, no address to lookup the source line number.\n");
>  		return -EINVAL;
>  	}
> -	if ((PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN)) && !allow_user_set &&
> +	if ((PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN) || PRINT_FIELD(BRSTACKDISASM))
> +	    && !allow_user_set &&
>  	    !(evlist__combined_branch_type(session->evlist) & PERF_SAMPLE_BRANCH_ANY)) {
>  		pr_err("Display of branch stack assembler requested, but non all-branch filter set\n"
>  		       "Hint: run 'perf record -b ...'\n");
> @@ -1162,6 +1165,20 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
>  	return ret;
>  }
>  
> +static const char *any_dump_insn(struct perf_event_attr *attr,

attr is __maybe_unused

> +			struct perf_insn *x, uint64_t ip,
> +			u8 *inbuf, int inlen, int *lenp)
> +{
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +	if (PRINT_FIELD(BRSTACKDISASM)) {
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
> @@ -1170,7 +1187,7 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>  {
>  	int ilen = 0;
>  	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t", ip,
> -			      dump_insn(x, ip, inbuf, len, &ilen));
> +			      any_dump_insn(attr, x, ip, inbuf, len, &ilen));
>  
>  	if (PRINT_FIELD(BRSTACKINSNLEN))
>  		printed += fprintf(fp, "ilen: %d\t", ilen);
> @@ -1262,6 +1279,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  		nr = max_blocks + 1;
>  
>  	x.thread = thread;
> +	x.machine = machine;
>  	x.cpu = sample->cpu;
>  
>  	printed += fprintf(fp, "%c", '\n');
> @@ -1313,7 +1331,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  			} else {
>  				ilen = 0;
>  				printed += fprintf(fp, "\t%016" PRIx64 "\t%s", ip,
> -						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
> +						   any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen));
>  				if (PRINT_FIELD(BRSTACKINSNLEN))
>  					printed += fprintf(fp, "\tilen: %d", ilen);
>  				printed += fprintf(fp, "\n");
> @@ -1361,7 +1379,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  			goto out;
>  		ilen = 0;
>  		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", sample->ip,
> -			dump_insn(&x, sample->ip, buffer, len, &ilen));
> +			any_dump_insn(attr, &x, sample->ip, buffer, len, &ilen));
>  		if (PRINT_FIELD(BRSTACKINSNLEN))
>  			printed += fprintf(fp, "\tilen: %d", ilen);
>  		printed += fprintf(fp, "\n");
> @@ -1372,7 +1390,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  	for (off = 0; off <= end - start; off += ilen) {
>  		ilen = 0;
>  		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", start + off,
> -				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
> +				   any_dump_insn(attr, &x, start + off, buffer + off, len - off, &ilen));
>  		if (PRINT_FIELD(BRSTACKINSNLEN))
>  			printed += fprintf(fp, "\tilen: %d", ilen);
>  		printed += fprintf(fp, "\n");
> @@ -1534,7 +1552,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  		printed += fprintf(fp, "\t\t");
>  		printed += sample__fprintf_insn_asm(sample, thread, machine, fp, al);
>  	}
> -	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
> +	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN) || PRINT_FIELD(BRSTACKDISASM))
>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
>  
>  	return printed;
> @@ -3940,7 +3958,7 @@ int cmd_script(int argc, const char **argv)
>  		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff,"
>  		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
>  		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
> -		     "brstackinsnlen,brstackoff,callindent,insn,disasm,insnlen,synth,"
> +		     "brstackinsnlen,brstackdisasm,brstackoff,callindent,insn,disasm,insnlen,synth,"
>  		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
>  		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat",
>  		     parse_output_fields),
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
> index 8e4e3cffd677..bca4449f0fa8 100644
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
> +

Better to factor out a function that does not depend on "sample"
e.g. see fprintf_insn_asm() below.

static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn, FILE *fp)
{
	struct addr_location al;
	size_t printed = 0;

	if (insn->detail && insn->detail->x86.op_count == 1) {
		cs_x86_op *op = &insn->detail->x86.operands[0];

		addr_location__init(&al);
		if (op->type == X86_OP_IMM &&
		    thread__find_symbol(thread, cpumode, op->imm, &al)) {
			printed += fprintf(fp, "%s ", insn[0].mnemonic);
			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
			addr_location__exit(&al);
			return printed;
		}
		addr_location__exit(&al);
	}

	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
	return printed;
}

static bool is64bitip(struct machine *machine, struct addr_location *al)
{
	const struct dso *dso = al->map ? map__dso(al->map) : NULL;

	if (dso)
		return dso->is_64_bit;

	return machine__is(machine, "x86_64") ||
		machine__normalized_is(machine, "arm64") ||
		machine__normalized_is(machine, "s390");
}

static ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
				bool is64bit, const uint8_t *code, size_t code_size,
				uint64_t ip, int *lenp, FILE *fp)
{
	size_t printed = 0;
	cs_insn *insn;
	csh cs_handle;
	size_t count;
	int ret;

	/* TODO: Try to initiate capstone only once but need a proper place. */
	ret = capstone_init(machine, &cs_handle, is64bit);
	if (ret < 0)
		return ret;

	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
	if (count > 0) {
		if (machine__normalized_is(machine, "x86"))
			printed += print_insn_x86(thread, cpumode, &insn[0], fp);
		else
			printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
		if (lenp)
			*lenp = insn->size;
		cs_free(insn, count);
	} else {
		printed += fprintf(fp, "illegal instruction");
	}

	cs_close(&cs_handle);
	return printed;
}

size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
				struct machine *machine, FILE *fp,
				struct addr_location *al)
{
	bool is64bit = is64bitip(machine, al);
	ssize_t printed;

	printed = fprintf_insn_asm(machine, thread, sample->cpumode, is64bit,
				   (uint8_t *)sample->insn, sample->insn_len,
				   sample->ip, NULL, fp);
	if (printed < 0)
		return sample__fprintf_insn_raw(sample, fp);

	return printed;
}

>  static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
>  			     cs_insn *insn, FILE *fp)
>  {
> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> index 6447dd41b543..c2a6391a45ce 100644
> --- a/tools/perf/util/print_insn.h
> +++ b/tools/perf/util/print_insn.h
> @@ -8,9 +8,12 @@
>  struct perf_sample;
>  struct thread;
>  struct machine;
> +struct perf_insn;
>  
>  size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
>  				struct machine *machine, FILE *fp, struct addr_location *al);
>  size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
> +const char *cs_dump_insn(struct perf_insn *x, uint64_t ip,
> +                         u8 *inbuf, int inlen, int *lenp);
>  
>  #endif /* PERF_PRINT_INSN_H */

