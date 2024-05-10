Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6651168BE;
	Fri, 10 May 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351184; cv=none; b=jotbzK8Lt9qFpkEFqPlVZ2+XMUChunzeAP3rY95hRSMhvGad3XvY7calJVqszAZo2uZe9lJq1BTcyjxAf9HLZzrLMon+9eeox6f6bRQb1sbakqfLt66BmEA1ae+BCXPhFUZm25nFYntLJ5X90CfdkYYInS4MiK3+bztlSi5QFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351184; c=relaxed/simple;
	bh=+DKU1DJyZN/2cve2AGF0NsYjCUCGhPhoIoQ+JdEnSqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGzE0FkO/lZNwfVTc+0OEwYp4e5v06vULGtBY7lVYGCmtORQs1qLfXNaTUoXHvZBK6pNhQy2g65rX/rj/ZosxWVhszo0c0KFtjEAhzUNSo9jPp8rDJc3YqqoiZhYB3JZ6EJ1BvzxWSjFuVZ0PdYhULHjujyYIUB2iSJjaMacBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP03ZOR6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP03ZOR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC11DC113CC;
	Fri, 10 May 2024 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715351184;
	bh=+DKU1DJyZN/2cve2AGF0NsYjCUCGhPhoIoQ+JdEnSqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP03ZOR6tAb3/dpjyiyJ1juh8WAZwYg4kfdZf5R9+4fsQ9KcZmpg6PdOQwlyN4INl
	 NUhVVE3Cfq1yMxi7PcqQ1Rp26HoBv2uGHNi7lbYK6+SXNWfkuoMbu6Nm1ukTJdq4sy
	 95jGL3dWHf0QrB54wXny5eL2nSnOSdGkhNmTPux7VZs2MaJb/yTjho9QlLxEnkHx/C
	 vkAE3Wa1QAbkkEHrrK0ZHBQ4d2W5SjAQbyzgmJwphBs1GFta7IwfHrKgxV01DD3oso
	 WbGnsLj/HWWGZwKnCcWcqjMxc23YdMOHTX/ovibAJD6PLgMu5AyOzDer01L6qH0WsH
	 BGnzvxWtZRuOQ==
Date: Fri, 10 May 2024 11:26:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"segher@kernel.crashing.org" <segher@kernel.crashing.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"maddy@linux.ibm.com" <maddy@linux.ibm.com>,
	"kjain@linux.ibm.com" <kjain@linux.ibm.com>,
	"disgoel@linux.vnet.ibm.com" <disgoel@linux.vnet.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akanksha@linux.ibm.com" <akanksha@linux.ibm.com>
Subject: Re: [PATCH V2 4/9] tools/perf: Add support to capture and parse raw
 instruction in objdump
Message-ID: <Zj4ujanupo0eKyby@x1>
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
 <20240506121906.76639-5-atrajeev@linux.vnet.ibm.com>
 <f2efdb9d-e636-4678-b492-83d3a28d8134@csgroup.eu>
 <E21FF3FD-1080-4A6C-99B0-7239AD831532@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E21FF3FD-1080-4A6C-99B0-7239AD831532@linux.vnet.ibm.com>

On Thu, May 09, 2024 at 10:56:23PM +0530, Athira Rajeev wrote:
> 
> 
> > On 7 May 2024, at 3:05 PM, Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> > 
> > 
> > 
> > Le 06/05/2024 à 14:19, Athira Rajeev a écrit :
> >> Add support to capture and parse raw instruction in objdump.
> > 
> > What's the purpose of using 'objdump' for reading raw instructions ? 
> > Can't they be read directly without invoking 'objdump' ? It looks odd to 
> > me to use objdump to provide readable text and then parse it back.
> 
> Hi Christophe,
> 
> Thanks for your review comments.
> 
> Current implementation for data type profiling on X86 uses "objdump" tool to get the disassembled code.

commit 6d17edc113de1e21fc66afa76be475a4f7c91826
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Fri Mar 29 14:58:11 2024 -0700

    perf annotate: Use libcapstone to disassemble
    
    Now it can use the capstone library to disassemble the instructions.
    Let's use that (if available) for perf annotate to speed up.  Currently
    it only supports x86 architecture.  With this change I can see ~3x speed
    up in data type profiling.
    
    But note that capstone cannot give the source file and line number info.
    For now, users should use the external objdump for that by specifying
    the --objdump option explicitly.
    
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>
    Tested-by: Ian Rogers <irogers@google.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Changbin Du <changbin.du@huawei.com>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: https://lore.kernel.org/r/20240329215812.537846-5-namhyung@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

From a quick look at http://www.capstone-engine.org/compile.html it
seems PowerPC is supported.

But since we did it first with objdump output parsing, its good to have
it as an alternative and sometimes a fallback:

commit f35847de2a65137e011e559f38a3de5902a5463f
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Wed Apr 24 17:51:56 2024 -0700

    perf annotate: Fallback disassemble to objdump when capstone fails
    
    I found some cases that capstone failed to disassemble.  Probably my
    capstone is an old version but anyway there's a chance it can fail.  And
    then it silently stopped in the middle.  In my case, it didn't
    understand "RDPKRU" instruction.
    
    Let's check if the capstone disassemble reached the end of the function
    and fallback to objdump if not

---------------

- Arnaldo

> And then the objdump result lines are parsed to get the instruction
> name and register fields. The initial patchset I posted to enable the
> data type profiling feature in powerpc was using the same way by
> getting disassembled code from objdump and parsing the disassembled
> lines. But in V2, we are introducing change for powerpc to use "raw
> instruction" and fetch opcode, reg fields from the raw instruction.
 
> I tried to explain below that current objdump uses option
> "--no-show-raw-insn" which doesn't capture raw instruction.  So to
> capture raw instruction, V2 patchset has changes to use default option
> "--show-raw-insn" and get the raw instruction [ for powerpc ] along
> with human readable annotation [ which is used by other archs ]. Since
> perf tool already has objdump implementation in place, I went in the
> direction to enhance it to use "--show-raw-insn" for powerpc purpose.
 
> But as you mentioned, we can directly read raw instruction without
> using "objdump" tool.  perf has support to read object code. The dso
> open/read utilities and helper functions are already present in
> "util/dso.c" And "dso__data_read_offset" function reads data from dso
> file offset. We can use these functions and I can make changes to
> directly read binary instruction without using objdump.
 
> Namhyung, Arnaldo, Christophe
> Looking for your valuable feedback on this approach. Please suggest if this approach looks fine
> 
> 
> Thanks
> Athira
> > 
> >> Currently, the perf tool infrastructure uses "--no-show-raw-insn" option
> >> with "objdump" while disassemble. Example from powerpc with this option
> >> for an instruction address is:
> > 
> > Yes and that makes sense because the purpose of objdump is to provide 
> > human readable annotations, not to perform automated analysis. Am I 
> > missing something ?
> > 
> >> 
> >> Snippet from:
> >> objdump  --start-address=<address> --stop-address=<address>  -d --no-show-raw-insn -C <vmlinux>
> >> 
> >> c0000000010224b4: lwz     r10,0(r9)
> >> 
> >> This line "lwz r10,0(r9)" is parsed to extract instruction name,
> >> registers names and offset. Also to find whether there is a memory
> >> reference in the operands, "memory_ref_char" field of objdump is used.
> >> For x86, "(" is used as memory_ref_char to tackle instructions of the
> >> form "mov  (%rax), %rcx".
> >> 
> >> In case of powerpc, not all instructions using "(" are the only memory
> >> instructions. Example, above instruction can also be of extended form (X
> >> form) "lwzx r10,0,r19". Inorder to easy identify the instruction category
> >> and extract the source/target registers, patch adds support to use raw
> >> instruction. With raw instruction, macros are added to extract opcode
> >> and register fields.
> >> 
> >> "struct ins_operands" and "struct ins" is updated to carry opcode and
> >> raw instruction binary code (raw_insn). Function "disasm_line__parse"
> >> is updated to fill the raw instruction hex value and opcode in newly
> >> added fields. There is no changes in existing code paths, which parses
> >> the disassembled code. The architecture using the instruction name and
> >> present approach is not altered. Since this approach targets powerpc,
> >> the macro implementation is added for powerpc as of now.
> >> 
> >> Example:
> >> representation using --show-raw-insn in objdump gives result:
> >> 
> >> 38 01 81 e8     ld      r4,312(r1)
> >> 
> >> Here "38 01 81 e8" is the raw instruction representation. In powerpc,
> >> this translates to instruction form: "ld RT,DS(RA)" and binary code
> >> as:
> >> _____________________________________
> >> | 58 |  RT  |  RA |      DS       | |
> >> -------------------------------------
> >> 0    6     11    16              30 31
> >> 
> >> Function "disasm_line__parse" is updated to capture:
> >> 
> >> line:    38 01 81 e8     ld      r4,312(r1)
> >> opcode and raw instruction "38 01 81 e8"
> >> Raw instruction is used later to extract the reg/offset fields.
> >> 
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> ---
