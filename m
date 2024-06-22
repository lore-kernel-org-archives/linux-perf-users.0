Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233728F1;
	Sat, 22 Jun 2024 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014796; cv=none; b=TVq1wDnMxocrn3hzqQlbaU7Ip6mS9rx67jmyKUJlS65n1qau36LkaRvg6P7MnCeIvojL9Qk4HUZq6B425Yv8iF2Fp/QioQilj8G5iIZGmRBDOxFn2WzHmttqGcwxQVZzQ84rVnJJmtnMdRRKiHhndjdgHSdhmnjrZCPlCWKf8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014796; c=relaxed/simple;
	bh=WiVqt52hzMLAeBX8UtUgQuCV4HjtrANjoiU7an0ykWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZRVEcu8mYHtyLZe6nSptEoYgtKJ0+UhpEABNvGxJJXMkRpmMWVc5dxQN1PIQvu+ca1Bi8D1zuB2i1mAssJwJiJ6YB7+E5eGF3dYdBkxAVm7JQXD4q1AzPfXKEFPr3f+Gx3k1blNWYnNZlVA/LO82I27nQhYpR73++v171WnWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXODp2mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXODp2mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1E0C2BBFC;
	Sat, 22 Jun 2024 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719014796;
	bh=WiVqt52hzMLAeBX8UtUgQuCV4HjtrANjoiU7an0ykWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXODp2mk+szphHJvZuIflFYNpzNivWHTSyZlSJfakOaEo/Ah8Lz0Mbyqi3XIFvz3+
	 IVYFco8aCNBe2SDKRsM8XOUi/Zo0hi5/PZ2ilsaEfTNbxtyTfJPTqM8ldL4rjVkK2Q
	 GyJDsYW1YGHtbLBLmxSp1BDSRkfvE+PPO/IpeDjerJ9IyIYNuKVft5gQu+yjd3z/EY
	 6kI5wTLf9SvUm2eoZu7X4ND4PBxcONEH1EhCUOdNV8//8E1UxZMadtJz4bFWQZkZPf
	 nRjkDDyke6yetM3Kp6+yxiT9yX4lCg4fZjgZMrHQCi/ZNpLmYKBnIVTyi6+y/s9r4Q
	 8Btx13c7Hcjqg==
Date: Fri, 21 Jun 2024 17:06:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [V4 00/16] Add data type profiling support for powerpc
Message-ID: <ZnYVitG1tffUNTn6@google.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <C84A4D8E-3BCD-47A7-B41E-1B39744AECDF@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C84A4D8E-3BCD-47A7-B41E-1B39744AECDF@linux.vnet.ibm.com>

Hello,

On Thu, Jun 20, 2024 at 09:01:01PM +0530, Athira Rajeev wrote:
> 
> 
> > On 14 Jun 2024, at 10:56 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> > 
> > The patchset from Namhyung added support for data type profiling
> > in perf tool. This enabled support to associate PMU samples to data
> > types they refer using DWARF debug information. With the upstream
> > perf, currently it possible to run perf report or perf annotate to
> > view the data type information on x86.
> > 
> > Initial patchset posted here had changes need to enable data type
> > profiling support for powerpc.
> > 
> > https://lore.kernel.org/all/6e09dc28-4a2e-49d8-a2b5-ffb3396a9952@csgroup.eu/T/
> > 
> > Main change were:
> > 1. powerpc instruction nmemonic table to associate load/store
> > instructions with move_ops which is use to identify if instruction
> > is a memory access one.
> > 2. To get register number and access offset from the given
> > instruction, code uses fields from "struct arch" -> objump.
> > Added entry for powerpc here.
> > 3. A get_arch_regnum to return register number from the
> > register name string.
> > 
> > But the apporach used in the initial patchset used parsing of
> > disassembled code which the current perf tool implementation does.
> > 
> > Example: lwz     r10,0(r9)
> > 
> > This line "lwz r10,0(r9)" is parsed to extract instruction name,
> > registers names and offset. Also to find whether there is a memory
> > reference in the operands, "memory_ref_char" field of objdump is used.
> > For x86, "(" is used as memory_ref_char to tackle instructions of the
> > form "mov  (%rax), %rcx".
> > 
> > In case of powerpc, not all instructions using "(" are the only memory
> > instructions. Example, above instruction can also be of extended form (X
> > form) "lwzx r10,0,r19". Inorder to easy identify the instruction category
> > and extract the source/target registers, second patchset added support to use
> > raw instruction. With raw instruction, macros are added to extract opcode
> > and register fields.
> > Link to second patchset:
> > https://lore.kernel.org/all/20240506121906.76639-1-atrajeev@linux.vnet.ibm.com/
> > 
> > Example representation using --show-raw-insn in objdump gives result:
> > 
> > 38 01 81 e8     ld      r4,312(r1)
> > 
> > Here "38 01 81 e8" is the raw instruction representation. In powerpc,
> > this translates to instruction form: "ld RT,DS(RA)" and binary code
> > as:
> >  _____________________________________
> >  | 58 |  RT  |  RA |      DS       | |
> >  -------------------------------------
> > 0    6     11    16              30 31
> > 
> > Second patchset used "objdump" again to read the raw instruction.
> > But since there is no need to disassemble and binary code can be read
> > directly from the DSO, third patchset (ie this patchset) uses below
> > apporach. The apporach preferred in powerpc to parse sample for data
> > type profiling in V3 patchset is:
> > - Read directly from DSO using dso__data_read_offset
> > - If that fails for any case, fallback to using libcapstone
> > - If libcapstone is not supported, approach will use objdump
> > 
> > Patchset adds support to pick the opcode and reg fields from this
> > raw/binary instruction code. This approach came in from review comment
> > by Segher Boessenkool and Christophe for the initial patchset.
> > 
> > Apart from that, instruction tracking is enabled for powerpc and
> > support function is added to find variables defined as registers
> > Example, in powerpc, below two registers are
> > defined to represent variable:
> > 1. r13: represents local_paca
> > register struct paca_struct *local_paca asm("r13");
> > 
> > 2. r1: represents stack_pointer
> > register void *__stack_pointer asm("r1");
> > 
> > These are handled in this patchset.
> > 
> > - Patch 1 is to rearrange register state type structures to header file
> > so that it can referred from other arch specific files
> > - Patch 2 is to make instruction tracking as a callback to"struct arch"
> > so that it can be implemented by other archs easily and defined in arch
> > specific files
> > - Patch 3 adds support to capture and parse raw instruction in powerpc
> > using dso__data_read_offset utility
> > - Patch 4 adds logic to support using objdump when doing default "perf
> > report" or "perf annotate" since it that needs disassembled instruction.
> > - Patch 5 adds disasm_line__parse to parse raw instruction for powerpc
> > - Patch 6 update parameters for reg extract functions to use raw
> > instruction on powerpc
> > - Patch 7 add support to identify memory instructions of opcode 31 in
> > powerpc
> > - Patch 8 adds more instructions to support instruction tracking in powerpc
> > - Patch 9 and 10 handles instruction tracking for powerpc.
> > - Patch 11, 12 and 13 add support to use libcapstone in powerpc
> > - Patch 14 and patch 15 handles support to find global register variables
> > - Patch 16 handles insn-stat option for perf annotate
> > 
> > Note:
> > - There are remaining unknowns (25%) as seen in annotate Instruction stats
> > below.
> > - This patchset is not tested on powerpc32. In next step of enhancements
> > along with handling remaining unknowns, plan to cover powerpc32 changes
> > based on how testing goes.
> > 
> > With the current patchset:
> > 
> > ./perf record -a -e mem-loads sleep 1
> > ./perf report -s type,typeoff --hierarchy --group --stdio
> > ./perf annotate --data-type --insn-stat
> > 
> > perf annotate logs:
> > ==================
> > 
> > Annotate Instruction stats
> > total 609, ok 446 (73.2%), bad 163 (26.8%)
> > 
> >  Name/opcode:  Good   Bad
> >  -----------------------------------------------------------
> >  58                  :   323    80
> >  32                  :    49    43
> >  34                  :    33    11
> >  OP_31_XOP_LDX       :     8    20
> >  40                  :    23     0
> >  OP_31_XOP_LWARX     :     5     1
> >  OP_31_XOP_LWZX      :     2     3
> >  OP_31_XOP_LDARX     :     3     0
> >  33                  :     0     2
> >  OP_31_XOP_LBZX      :     0     1
> >  OP_31_XOP_LWAX      :     0     1
> >  OP_31_XOP_LHZX      :     0     1
> > 
> > perf report logs:
> > =================
> > 
> >  Total Lost Samples: 0
> > 
> >  Samples: 1K of event 'mem-loads'
> >  Event count (approx.): 937238
> > 
> >  Overhead  Data Type  Data Type Offset
> > ........  .........  ................
> > 
> >    48.60%  (unknown)  (unknown) +0 (no field)
> >    12.85%  long unsigned int  long unsigned int +0 (current_stack_pointer)
> >     4.68%  struct paca_struct  struct paca_struct +2312 (__current)
> >     4.57%  struct paca_struct  struct paca_struct +2354 (irq_soft_mask)
> >     2.69%  struct paca_struct  struct paca_struct +2808 (canary)
> >     2.68%  struct paca_struct  struct paca_struct +8 (paca_index)
> >     2.24%  struct paca_struct  struct paca_struct +48 (data_offset)
> >     1.41%  struct vm_fault  struct vm_fault +0 (vma)
> >     1.29%  struct task_struct  struct task_struct +276 (flags)
> >     1.03%  struct pt_regs  struct pt_regs +264 (user_regs.msr)
> >     0.90%  struct security_hook_list  struct security_hook_list +0 (list.next)
> >     0.76%  struct irq_desc  struct irq_desc +304 (irq_data.chip)
> >     0.76%  struct rq  struct rq +2856 (cpu)
> > 
> > Thanks
> > Athira Rajeev
> 
> Hi All
> 
> Requesting for review comments for this patchset

Sorry about the delay, I was traveling and busy with other things.
I'll review this next week!

Thanks,
Namhyung
