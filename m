Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018504;
	b=5Lz36yPC/LE4XrZB11QTh0df4c1vu5bgamECqyUvrAPtuisu6EwbL4wic9mu3dbbnhBV
	 WcVhJWPhNakF6O29TuH7IjAw76uao0UGZY5n9WPxDAkG32qShWvn/Px4RAFVdcT6L3rmu
	 275UCfddJ/R2KSJXKcDrVzowZgxR11Ub5P9tz9FC566C40ge80TKv/08E2OXhxT4jd3T3
	 B7VA4ydjdZHUaCEtm9ZOzxUXomXV9GEv3FpmxV8aztYL6A6CGh0jgtnT2IJX++cnqk6cK
	 47H9U/kmPV+t30UB7idbRu3s0pM+qJjumm/RVvr2bW2lUSkvMuJm2YIEl24+IgN4H6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018504;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8BTsj7xQZG7PduAVaPvxu5YiA218HiWcfmYrYcf3JnM=;
	b=dRKs5R055rpb0NrMqUhqhZ6+sfpN4//LD7adDrm9J8tJnJFh2BX62d8gkeuvDyI1W3KM
	 3B88CGV9EPZ2mQRE0B7wuXnZOtXZ2V8o+TYj/TSVxmdblddTaZbyMJnt3RQCh7LztBvdD
	 XFia6o6kXQhwL24iPZsKVT5SUuG124c3UZtDPh6vh2ZOT5EEglKNLWu7qMgdQTRji85gN
	 lOIRUnroIE4rRCnYZ1f92apaiU7VK3zTMNxIc9FcV86i0cIW0D16bUU3Z3L6HZnNmBdBj
	 Y/wx3x0vrDKPgwgFmVSmEZFRWebJg3vJzljtXoio1z89f8DtvS4aEGfvbt95/R9TjTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArV1+vK0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DBE606A32A;
	Wed, 18 Nov 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArV1+vK0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDA51F000C6;
	Wed, 18 Nov 2026 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018504;
	bh=8BTsj7xQZG7PduAVaPvxu5YiA218HiWcfmYrYcf3JnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ArV1+vK0hQeWyt57BCYJmQWRzFdH2n8f4JlwdFiZGs0XPrqqRrucVSpBsAi409yr0
	 AeKYpCZYHuXBTX7GW5GQHXIfV8uKPl48x/tDqWmzYH5z/YdBeI3LUuEGq12Yt9Cxu7
	 g1Y7esNqtwrk9t+LTfs4iFhrswaKKtS70RAwrcm6sJPfPMyXSMIy7Wop3A7AuUcODP
	 qxdMaXhiEHSoV7ijhGgVWw60u9DSuVrzJJIcRlM5qvg4v8tMBtaIeX+/iTEnKI98G8
	 2Y31j47XVkmtQ9D3/hQ293tzCMpCG9Bt6cgW0FND70eNxG+l97FYIFfZdh8QKXMaBg
	 tbHej1N0yQFOw==
Date: Wed, 18 Nov 2026 13:15:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 03/13] perf annotate: Handle absolute addressing in
 data type profiling
Message-ID: <av3PBLtZQ0mYf-1V@phoenix2>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-4-acme@kernel.org>
 <av1O-I_uLOoY0u5r@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av1O-I_uLOoY0u5r@google.com>

On Tue, Nov 17, 2026 at 11:08:40PM -0800, Namhyung Kim wrote:
> On Tue, Nov 17, 2026 at 05:04:21PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > 32-bit x86 accesses globals with absolute addresses, like
> > "movl %eax,0x8c73448", but the operand parser only recognized the
> > offset(reg) forms, so the operand had no memory reference, the resolver
> > saw a zero data address and resolved nothing.
> > 
> > Parse a bare "0x" number as an absolute memory operand, leaving jumps,
> > calls, loop* and the 64-bit movabs* out, use the address in the resolver,
> > and let the instruction tracking record the type of an absolute global
> > load in the destination register.  The displacement is sign extended for
> > 64-bit objects, as the CPU does, and zero extended for 32-bit ones.
> > Values that do not fit the int offset, zero, and the operands of
> > relocatable objects, which are unrelocated addends, are skipped.
> > 
> > With bare numbers being memory operands, a frame base register of -1,
> > "none", would also compare equal to the -1 "no register" of an absolute
> > operand and take it for a stack access, so guard those comparisons.
> > Operands left with no register, like a user space "%gs:imm", are no
> > longer looked up as variables, which can change the data type stats of
> > those samples.
> > 
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/annotate-arch/annotate-x86.c | 52 ++++++++++++++++++--
> >  tools/perf/util/annotate.c                   | 25 +++++++++-
> >  tools/perf/util/annotate.h                   |  7 +++
> >  3 files changed, 79 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
> > index e38a4e7a54d5585c..adb52d148cba6001 100644
> > --- a/tools/perf/util/annotate-arch/annotate-x86.c
> > +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> > @@ -230,6 +230,11 @@ static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
> >  	return die_get_real_type(&func_die, type_die) != NULL;
> >  }
> >  
> > +static bool is_stack_or_fb_reg(struct type_state *state, int fbreg, int reg)
> > +{
> > +	return (fbreg != -1 && reg == fbreg) || reg == state->stack_reg;
> > +}
> > +
> >  static void update_insn_state_x86(struct type_state *state,
> >  				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
> >  				  struct disasm_line *dl)
> > @@ -437,7 +442,7 @@ static void update_insn_state_x86(struct type_state *state,
> >  		invalidate_reg_state(tsr);
> >  
> >  		/* Case 1: Based on stack pointer or frame pointer */
> > -		if (sreg == fbreg || sreg == state->stack_reg) {
> > +		if (is_stack_or_fb_reg(state, fbreg, sreg)) {
> >  			struct type_state_stack *stack;
> >  			int offset = src->offset - fboff;
> >  
> > @@ -626,7 +631,7 @@ static void update_insn_state_x86(struct type_state *state,
> >  
> >  retry:
> >  		/* Check stack variables with offset */
> > -		if (sreg == fbreg || sreg == state->stack_reg) {
> > +		if (is_stack_or_fb_reg(state, fbreg, sreg)) {
> >  			struct type_state_stack *stack;
> >  			int offset = src->offset - fboff;
> >  
> > @@ -741,6 +746,29 @@ static void update_insn_state_x86(struct type_state *state,
> >  				     insn_offset, addr, dst->reg1);
> >  			pr_debug_type_name(&type_die, tsr->kind);
> >  		}
> > +		/* Or an absolute address, as used by 32-bit code */
> > +		else if (annotated_op_loc__is_abs(src, map__dso(dloc->ms->map))) {
> 
> Then shouldn't it check if it's actually 32-bit code?

After some more rounds of local reviews and trying to answer your
question:
                        /*
                         * Keep only what fits the int, as disp32 or as a u32;
-                        * movabs*, the 64-bit form, is left out.
+                        * a 64-bit absolute value is left out.  The LLVM
+                        * disassembler prints a disp32 that does not fit an
+                        * int as a negative number.
                         */
                        if (offset != 0 && (offset <= UINT_MAX ||
                                            (s64)(int)offset == (s64)offset)) {
-                               /* Absolute address, as used by 32-bit code */
+                               /* An absolute address: 32-bit code, or a 64-bit disp32 */
                                op_loc->mem_ref = true;
                                op_loc->offset = offset;
                        }

It is not 32-bit specific, the comment was wrong.
 
> > +			struct map_symbol *ms = dloc->ms;
> > +			u64 ip = ms->sym->start + dl->al.offset;
> > +			u64 addr = annotated_op_loc__abs_addr(src, map__dso(ms->map));
> > +			int offset;
> > +
> > +			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
> > +						 &type_die) ||
> > +			    !die_get_member_type(&type_die, offset, &type_die)) {
> > +				invalidate_reg_state(tsr);
> > +				return;
> > +			}
> > +
> > +			tsr->type = type_die;
> > +			tsr->kind = TSR_KIND_TYPE;
 
> I'm not sure if it's _TYPE at this point.  Probably _POINTER instead?

Why do you think so?

This is just duplicating to some degree what is right before, that uses
a TYPE for a global, no? But please check v7, there is a change in this
area.

- Arnaldo
