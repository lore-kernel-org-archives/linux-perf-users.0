Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEDB30D3F1;
	Wed,  9 Sep 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965564; cv=none; b=P2olnhzf924FOXlBe0ztsuGNdnIUZye71rFbYa2CKk3Go5Wl5dPgJri3Toky/ZOC2q4tHU+Kf1xISn1BphsidwvQHyTOWj8eJO6SPiGys/MRfHSpu+n7UOqxHfVhdQwSVUgOzRB+oyM4Y1rZSJ8hxNyy1rcOFoCY7HhFkkqaMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965564; c=relaxed/simple;
	bh=DkcbBCEeBjItlrEFmgH2ykYdrnaurag5bbzAMpCmNLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7Wf31NhvN/6tSZ9Evpzz0S+OBysPR9x6f//F+SxFBgVM+XFujODBBZgmMWrQ/p5p+pmDyF1GPUwtUOqLwHu8yYpDHJLLRyaxlYvVKDjlpsEUq2W72vqnsBVjuzok9Bdd+eHwd3QMGwnEwD0E20HBM69v7Sxv/0SiKpRUoqkWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNMxlvFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNMxlvFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC0C1F00A3A;
	Wed,  9 Sep 2026 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965562;
	bh=9fuZ0PCsn/VJJZGyAkfrVmhfxC95j9+FcuBO33Q5GlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oNMxlvFMh3nkWfdqpO07nnImsjxS6npgBEForPIuUT6MqTzrlrZXMVtAuDsgUev+A
	 vR7xa5HZKk46AzPFNrNiek4FrAfUlctY2WFuEYZsnu7HlJ3qq1BWF1QlOYHP9RkgBX
	 mO5SytYL608S8RYxXJ+Rm+aTbiJgWSxZ/fgklGrPuGYgbY474V8caKQgDIDptfOzg7
	 nGeEwUZ4IOn6BbgsdnSrOgwpPhmT+WuBrkzLnvPN5VeRV/1ik7fsx5IM4qg4iSepG2
	 6BTnGEgkCHum8VHh6wtmCGRaXJ+jf0EWSj9Xav0LzO9Vt7oEuMgWzZdUBq/lsCfcaX
	 Z+ui0mJa2TL7w==
Date: Wed, 9 Sep 2026 10:52:40 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 03/26] perf annotate-arm64: Generalize
 arm64_mov__parse to support more instructions
Message-ID: <aqFyuD_waCJpfaTv@google.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <872f51108191d20f65fc12f17c796863a36166da.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <872f51108191d20f65fc12f17c796863a36166da.1788872630.git.wutengda@huaweicloud.com>

On Tue, Sep 08, 2026 at 01:05:06PM +0000, Tengda Wu wrote:
> As the default parser for arm64 instructions, arm64_mov__parse()
> currently only supports parsing instructions with the 'addr <symbol>'
> suffix. Other instructions are not supported, causing a lack of
> source and target information for most regular instructions.
> 
> Generalize arm64_mov__parse to extend its parsing capabilities:
> 1. Parse 'ops->target.raw' and 'ops->source.raw' by default.
> 2. Utilize arm64__check_multi_regs() to identify if source and
>    target contain multiple registers.
> 3. Maintain backward compatibility for instructions containing the
>    'addr <symbol>' suffix.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 166 ++++++++++++++----
>  1 file changed, 134 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 33080fdca125..151184210691 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -3,6 +3,8 @@
>  #include <errno.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <linux/ctype.h>
> +#include <linux/string.h>
>  #include <linux/zalloc.h>
>  #include <regex.h>
>  #include "../annotate.h"
> @@ -14,59 +16,158 @@ struct arch_arm64 {
>  	regex_t jump_insn;
>  };
>  
> -static int arm64_mov__parse(const struct arch *arch __maybe_unused,
> +static bool arm64__is_reg(const char *op)
> +{
> +	if (!op || !*op)
> +		return false;
> +
> +	/*
> +	 * General-purpose registers: x0-x30, w0-w30.
> +	 * Check for 'x' or 'w' prefix followed by a numeric index.
> +	 */
> +	if ((op[0] == 'x' || op[0] == 'w') && isdigit(op[1]))
> +		return true;
> +
> +	/* Special-purpose registers: sp, wzr, xzr. */
> +	if (!strncmp(op, "sp", 2) || !strncmp(op, "xzr", 3) ||
> +	    !strncmp(op, "wzr", 3))
> +		return true;
> +
> +	/* TODO: Support more registers. */
> +	return false;
> +}
> +
> +static bool arm64__check_multi_regs(const struct arch *arch, const char *op)
> +{
> +	const char *p = op;
> +	int reg_count = 0;
> +
> +	while (p && *p) {
> +		p = skip_spaces(p);
> +		if (*p == arch->objdump.memory_ref_char)
> +			p++;
> +
> +		if (arm64__is_reg(p))
> +			reg_count++;
> +
> +		if (reg_count >= 2)
> +			return true;
> +
> +		/* Move to next operand after comma */
> +		p = strchr(p, ',');
> +		if (p)
> +			p++;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Duplicate @insn, stripping the comment and trailing whitespace.
> + * Returns a newly allocated string which the caller must free(),
> + * or NULL on allocation failure or if @insn is NULL.
> + */
> +static char *rstrip_space_and_comment(const char *insn, char comment_char)
> +{
> +	const char *end, *comment;
> +	size_t len;
> +	char *result;
> +
> +	if (insn == NULL)
> +		return NULL;
> +
> +	comment = strchr(insn, comment_char);
> +	if (comment != NULL)
> +		end = comment;
> +	else
> +		end = insn + strlen(insn);
> +
> +	while (end > insn && isspace(end[-1]))
> +		--end;
> +
> +	len = end - insn;
> +	result = malloc(len + 1);
> +	if (result == NULL)
> +		return NULL;
> +
> +	memcpy(result, insn, len);
> +	result[len] = '\0';
> +
> +	return result;
> +}
> +
> +static int arm64_mov__parse(const struct arch *arch,
>  			    struct ins_operands *ops,
>  			    struct map_symbol *ms __maybe_unused,
>  			    struct disasm_line *dl __maybe_unused)
>  {
> -	char *s = strchr(ops->raw, ','), *target, *endptr;
> +	char *s = strchr(ops->raw, ','), *source, *endptr;
>  
>  	if (s == NULL)
>  		return -1;
>  
> +	/* Parse target */
>  	*s = '\0';
> -	ops->source.raw = strdup(ops->raw);
> +	ops->target.raw = strdup(ops->raw);
>  	*s = ',';
>  
> -	if (ops->source.raw == NULL)
> -		return -1;
> -
> -	target = ++s;
> -	ops->target.raw = strdup(target);
>  	if (ops->target.raw == NULL)
> -		goto out_free_source;
> +		return -1;
>  
> -	ops->target.addr = strtoull(target, &endptr, 16);
> -	if (endptr == target)
> -		goto out_free_target;
> +	ops->target.multi_regs = arm64__check_multi_regs(arch, ops->target.raw);
>  
> -	s = strchr(endptr, '<');
> -	if (s == NULL)
> -		goto out_free_target;
> -	endptr = strchr(s + 1, '>');
> -	if (endptr == NULL)
> -		goto out_free_target;
> -
> -	*endptr = '\0';
> -	*s = ' ';
> -	ops->target.name = strdup(s);
> -	*s = '<';
> -	*endptr = '>';
> -	if (ops->target.name == NULL)
> -		goto out_free_target;
> +	/* Parse source, stripping comment if present */
> +	source = skip_spaces(++s);
> +	ops->source.raw = rstrip_space_and_comment(source, arch->objdump.comment_char);
> +	if (ops->source.raw == NULL) {
> +		zfree(&ops->target.raw);
> +		return -1;
> +	}
> +
> +	ops->source.multi_regs = arm64__check_multi_regs(arch, ops->source.raw);
> +
> +	/*
> +	 * Parse 'addr <symbol>' from source (if any).
> +	 *
> +	 * A raw hex string may be a scalar immediate, not an address.
> +	 * Only validate 'source.addr' if accompanied by a '<symbol>' tag,
> +	 * otherwise reset it to 0 to avoid false positive address tracking.
> +	 */
> +	ops->source.addr = strtoull(ops->source.raw, &endptr, 16);
> +	if (endptr != ops->source.raw) {
> +		s = strchr(endptr, '<');
> +		if (s == NULL) {
> +			ops->source.addr = 0;
> +			return 0;
> +		}
> +		endptr = strrchr(s + 1, '>');
> +		if (endptr == NULL) {
> +			ops->source.addr = 0;
> +			return 0;
> +		}
> +
> +		*endptr = '\0';
> +		ops->source.name = strdup(s + 1);
> +		*endptr = '>';
> +		if (ops->source.name == NULL) {
> +			ops->source.addr = 0;
> +			return 0;
> +		}
> +	}
>  
>  	return 0;
> +}
>  
> -out_free_target:
> -	zfree(&ops->target.raw);
> -out_free_source:
> -	zfree(&ops->source.raw);
> -	return -1;
> +static int arm64_mov__scnprintf(const struct ins *ins, char *bf, size_t size,
> +				struct ins_operands *ops, int max_ins_name)
> +{
> +	return scnprintf(bf, size, "%-*s %s, %s", max_ins_name, ins->name,
> +			 ops->target.raw, ops->source.name ?: ops->source.raw);
>  }
>  
>  static const struct ins_ops arm64_mov_ops = {
>  	.parse	   = arm64_mov__parse,
> -	.scnprintf = mov__scnprintf,
> +	.scnprintf = arm64_mov__scnprintf,
>  };
>  
>  static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
> @@ -103,6 +204,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>  	arch->id = *id;
>  	arch->objdump.comment_char	  = '/';
>  	arch->objdump.skip_functions_char = '+';
> +	arch->objdump.memory_ref_char	  = '[';
>  	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
>  
>  	/* bl, blr */
> -- 
> 2.34.1
> 
