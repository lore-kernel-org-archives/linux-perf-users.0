Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26F38F936;
	Tue,  7 Apr 2026 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545761; cv=none; b=kJaNYDgL7YcFNKmACesaLePthyy1JS5o1BwUMLVIv2R2w47RVVObHLz5yWXeetFrfUE+FNi1ryGvz1pBLT+jY9xUcmprLhLuKN+AOlOolDbmqUNdQgXTAo7IF78mT4XIEyb2iTG06NcZJngAlL+e/LeRXzdKu4vA2rkJOmxC7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545761; c=relaxed/simple;
	bh=yjqn7mxpmMG0XkkF6uF5LUIaTVIZDAEWzbEU7g3jtMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDZeTO/6a26JZpmhldR2BHWOLwAJb1CuSUlS4STSCRfcGczWHFjaTQUx4mZAXHXUIhk/9v4WfEcIsQjv4J1OWlX6p1XvprNJxiFXc9dSos2hsB6vGA3n1RsL4ruaXaEbipq3yMH8TDNwU2xf5wZc9ZH2q+BatdM/rbOJ07NBCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1jEdXwk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1jEdXwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355DFC116C6;
	Tue,  7 Apr 2026 07:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775545760;
	bh=yjqn7mxpmMG0XkkF6uF5LUIaTVIZDAEWzbEU7g3jtMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1jEdXwkvyAtoDAL1qIsKRo6JnBiJ6XjEWtNvjXO/BQ/ylys3bbn8hBfpxcDCmusu
	 rPn1ChSdmjnM6rnh7WhITrs6netoHeKFqtBWrbP3rNykY3EelsM7MypfVzLxl7z63b
	 MnKl/wDJQaLJyo+IJdTCFJwAE4oNcl13EwtPqgTKA2TwhdWA/05NQMaGfRvu8YIk1G
	 dQs9E5kFEzhOqZyf9gi4l5XMA1HwV4kmRBJcTsRpBN7mhuT01GZccWP3IzY6CDAqJA
	 b4OL9UPj5qQ3ImqBZnJLuD0DVIylVK6M+i/CIoAV1dhWBe+i2eiq3LGmNDkBG9I2Ta
	 Spj1af/ztiaFg==
Date: Tue, 7 Apr 2026 00:09:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 04/16] perf annotate-arm64: Handle load and store
 instructions
Message-ID: <adStnrfA6IxkOfRN@z2>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-5-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-5-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:47:48AM +0000, Tengda Wu wrote:
> Add ldst_ops to handle load and store instructions in order to parse
> the data types and offsets associated with PMU events for memory access
> instructions. There are many variants of load and store instructions in
> ARM64, making it difficult to match all of these instruction names
> completely. Therefore, only the instruction prefixes are matched. The
> prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
> matches atomic instructions, and 'prf' matches memory prefetch
> instructions.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 4c42323b0c18..8209faaa6086 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -3,7 +3,9 @@
>  #include <errno.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <ctype.h>
>  #include <linux/zalloc.h>
> +#include <linux/string.h>
>  #include <regex.h>
>  #include "../annotate.h"
>  #include "../disasm.h"
> @@ -12,6 +14,7 @@ struct arch_arm64 {
>  	struct arch arch;
>  	regex_t call_insn;
>  	regex_t jump_insn;
> +	regex_t ldst_insn; /* load and store instruction */
>  };
>  
>  static bool arm64__check_multi_regs(const char *op)
> @@ -114,6 +117,59 @@ static const struct ins_ops arm64_mov_ops = {
>  	.scnprintf = mov__scnprintf,
>  };
>  
> +static int arm64_ldst__parse(const struct arch *arch __maybe_unused,

The 'arch' is used. :)


> +			     struct ins_operands *ops,
> +			     struct map_symbol *ms __maybe_unused,
> +			     struct disasm_line *dl __maybe_unused)
> +{
> +	char *s, *target;
> +
> +	/*
> +	 * The part starting from the memory access annotation '[' is parsed
> +	 * as 'target', while the part before it is parsed as 'source'.

It'd be nice if you can show some examples.  So it always looks like:

	LDR  x1, [x2, #4]
	STR  x1, [x3], #8

Right?  What about other instructions?


> +	 */
> +	target = s = strchr(ops->raw, arch->objdump.memory_ref_char);
> +	if (!s)
> +		return -1;
> +
> +	while (s > ops->raw && *s != ',')
> +		--s;
> +
> +	if (s == ops->raw)
> +		return -1;
> +
> +	*s = '\0';
> +	ops->source.raw = strdup(ops->raw);
> +
> +	*s = ',';
> +	if (!ops->source.raw)
> +		return -1;
> +
> +	ops->source.multi_regs = arm64__check_multi_regs(ops->source.raw);

Probably it's better to set ops->source.mem_ref to false.  Then you
won't need to set multi_regs.

Thanks,
Namhyung

> +
> +	ops->target.raw = strdup(target);
> +	if (!ops->target.raw) {
> +		zfree(&ops->source.raw);
> +		return -1;
> +	}
> +	ops->target.mem_ref = true;
> +	ops->target.multi_regs = arm64__check_multi_regs(ops->target.raw);
> +
> +	return 0;
> +}
> +
> +static int arm64_ldst__scnprintf(const struct ins *ins, char *bf, size_t size,
> +				 struct ins_operands *ops, int max_ins_name)
> +{
> +	return scnprintf(bf, size, "%-*s %s,%s", max_ins_name, ins->name,
> +			 ops->source.raw, ops->target.raw);
> +}
> +
> +static struct ins_ops arm64_ldst_ops = {
> +	.parse	   = arm64_ldst__parse,
> +	.scnprintf = arm64_ldst__scnprintf,
> +};
> +
>  static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
>  {
>  	struct arch_arm64 *arm = container_of(arch, struct arch_arm64, arch);
> @@ -124,6 +180,8 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
>  		ops = &jump_ops;
>  	else if (!regexec(&arm->call_insn, name, 2, match, 0))
>  		ops = &call_ops;
> +	else if (!regexec(&arm->ldst_insn, name, 2, match, 0))
> +		ops = &arm64_ldst_ops;
>  	else if (!strcmp(name, "ret"))
>  		ops = &ret_ops;
>  	else
> @@ -148,6 +206,8 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>  	arch->id = *id;
>  	arch->objdump.comment_char	  = '/';
>  	arch->objdump.skip_functions_char = '+';
> +	arch->objdump.memory_ref_char	  = '[';
> +	arch->objdump.imm_char		  = '#';
>  	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
>  
>  	/* bl, blr */
> @@ -161,8 +221,20 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>  	if (err)
>  		goto out_free_call;
>  
> +	/*
> +	 * The ARM64 architecture has many variants of load/store instructions.
> +	 * It is quite challenging to match all of them completely. Here, we
> +	 * only match the prefixes of these instructions.
> +	 */
> +	err = regcomp(&arm->ldst_insn, "^(ld|st|cas|prf|swp)",
> +		      REG_EXTENDED);
> +	if (err)
> +		goto out_free_jump;
> +
>  	return arch;
>  
> +out_free_jump:
> +	regfree(&arm->jump_insn);
>  out_free_call:
>  	regfree(&arm->call_insn);
>  out_free_arm:
> -- 
> 2.34.1
> 
