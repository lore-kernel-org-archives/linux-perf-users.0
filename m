Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65296276049;
	Thu,  9 Jul 2026 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577890; cv=none; b=t2c5gYCytZUB51NclFnYB0fJTyk9DqJH4HRMlXV66X5I/Z4ryFOLu+Apf4K988oFrXgFvR4tTciZqrB/kS2ohGJxiHXU7zYMen48RYieVRXDOHRPJTZbxAardGzK+s6GIR06HWfrZCKQ3Tgb0lrTBnrmBlceIQn8LFH/fidn/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577890; c=relaxed/simple;
	bh=OVWgK4GryE26S401jqP3KlcIJn3fOegRQejFG4DLsWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AABy198xs+p8jAKJ4h559Mo8Y8fNqitfHB6qmgxNWrYv1gcuqOV83EvERyBPN1OfKfpILZS8HYt2DFCLEtu/0d5U8eLbaymGVnuRJp89YqCPZWa2xl6qoIlvWGHslvC3QjopxMdFLOhF8qHmscRdEnfAV9RRZDd85sYkl1wnvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSTrO/ku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSTrO/ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBB71F000E9;
	Thu,  9 Jul 2026 06:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783577889;
	bh=bL7V8thIsS5hZKLcfLbJiCQ8qnWnuo3kHsyulKxfHyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oSTrO/kub/cLu6oHchapKP357FkEfVEZ7g23UcJ8OkyebdSeF0jrhV9G/XSCTFzkr
	 MmrEVkI6v082m1uZ96bZMwyEcdy/xbTyamkCFx15liVYN4h3KiaAamuFZmLZNwDLXM
	 7+qZEPHOzSu++0/Tu8RTAnOEdoWTs9h8uaRX4lURuw6BOLvkQLBT64pOSI4HXM3/Nm
	 9Tg43loitIpci4AIJziY0gvxbyjoK+qEb07g4mRweGuBy2PoafqObN1NNMxdf/T9+9
	 fiqaeehq6YDZAl3GY95bKd+sycNRbXHVgeYzGUHuJY9GkYSjD3A+jmtYctMtahLhf4
	 80SE+yhmhJQ9g==
Date: Wed, 8 Jul 2026 23:18:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 03/21] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
Message-ID: <ak89Hg1SWnn0DHCk@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-4-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701035355.752944-4-wutengda@huaweicloud.com>

On Wed, Jul 01, 2026 at 03:53:37AM +0000, Tengda Wu wrote:
> The operands of 'adrp' instructions parsed by libllvm are currently
> represented as raw immediates rather than the "address <symbol+offset>"
> format used by objdump. This inconsistency causes arm64_mov__parse()
> to fail when parsing these instructions during post-processing.
> 
> Example of the mismatch:
>   Current: adrp x18, 8014
>   Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>
> 
> Fix this by manually extracting the target address from the raw adrp
> instruction via symbol_lookup_callback(). The address is then converted
> to a specific symbol during symbol__disassemble_llvm() and formatted
> to match objdump's output, ensuring compatibility with existing
> parsers.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/perf/util/llvm.c | 50 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> index a0deb742a733..533d47e8084d 100644
> --- a/tools/perf/util/llvm.c
> +++ b/tools/perf/util/llvm.c
> @@ -94,6 +94,7 @@ static void init_llvm(void)
>  struct symbol_lookup_storage {
>  	u64 branch_addr;
>  	u64 pcrel_load_addr;
> +	u64 pcrel_adrp_addr;
>  };
>  
>  static const char *
> @@ -108,6 +109,18 @@ symbol_lookup_callback(void *disinfo, uint64_t value,
>  		storage->branch_addr = value;
>  	else if (*ref_type == LLVMDisassembler_ReferenceType_In_PCrel_Load)
>  		storage->pcrel_load_addr = value;

Is this used by arm64?  If not, would be possible to reuse
pcrel_load_addr unless it'd complicate the code significantly?

I think it's the common concept of PC-relative addressing while it
requires two instructions to set up the final address on arm64.

Thanks,
Namhyung


> +	else if (*ref_type == LLVMDisassembler_ReferenceType_In_ARM64_ADRP) {
> +		uint64_t adrp_imm;
> +
> +		/* immhi (bits 23:5) and immlo (bits 30:29) */
> +		adrp_imm = ((value & 0x00ffffe0) >> 3) | ((value >> 29) & 0x3);
> +		/* Sign-extend the 21-bit immediate to 64-bit */
> +		if (adrp_imm & (1ULL << 20))
> +			adrp_imm |= ~((1ULL << 21) - 1);
> +
> +		/* Calculate the target page address */
> +		storage->pcrel_adrp_addr = (address & ~0xFFFLL) + (adrp_imm << 12);
> +	}
>  	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
>  	return NULL;
>  }
> @@ -204,6 +217,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
>  
>  		storage.branch_addr = 0;
>  		storage.pcrel_load_addr = 0;
> +		storage.pcrel_adrp_addr = 0;
>  
>  		/*
>  		 * LLVM's API has the code be disassembled as non-const, cast
> @@ -227,6 +241,42 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
>  				free(name);
>  			}
>  		}
> +		if (storage.pcrel_adrp_addr != 0) {
> +			/*
> +			 * ADRP (Address Page) instructions encode a 21-bit signed
> +			 * immediate offset relative to the current PC's page.
> +			 *
> +			 * To maintain consistency with standard objdump output,
> +			 * we truncate the raw encoded immediate at the comma
> +			 * and replace it with the resolved absolute page address.
> +			 *
> +			 * Example conversion:
> +			 * From: adrp x18, 8014
> +			 * To:   adrp x18, ffff800081f5f000 <this_cpu_vector>
> +			 */
> +			char *name;
> +			char *s = strchr(disasm_buf, ',');
> +
> +			if (s == NULL)
> +				goto err;
> +
> +			s++;
> +			*s = '\0';
> +			disasm_len = strlen(disasm_buf);
> +			disasm_len += scnprintf(disasm_buf + disasm_len,
> +						sizeof(disasm_buf) - disasm_len,
> +						" %"PRIx64,
> +						storage.pcrel_adrp_addr);
> +			name = llvm_name_for_data(dso, filename,
> +						  storage.pcrel_adrp_addr);
> +			if (name) {
> +				disasm_len += scnprintf(disasm_buf + disasm_len,
> +							sizeof(disasm_buf) -
> +							disasm_len,
> +							" <%s>", name);
> +				free(name);
> +			}
> +		}
>  		if (storage.pcrel_load_addr != 0) {
>  			char *name = llvm_name_for_data(dso, filename,
>  							storage.pcrel_load_addr);
> -- 
> 2.34.1
> 
