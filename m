Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB23AEF3F;
	Thu,  9 Jul 2026 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577426; cv=none; b=Fel72A/GQdlvHUs4mX2tip5gDUXbF6F+BUS8kTsHxEXRtXNOIdwbudAh89WSb5zQGYj+7nxYffG9LKf0cfWXrDl5XI6QsPGgj2O0NCCEahQjsLwjC0gVjU9yOgfxXke0wSILjg2pqyuepXAYWRo+9lG5QKo1jLyRRfvrWuie1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577426; c=relaxed/simple;
	bh=DHs68o3LTcKTjsNgkMQ+0PCQCqEwZFDfAiUH85jah9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHoTqNnAvjPEqxIPx2y6EL6FMhIaXyveXP1JuKx1WHyttCvYuUX7tVZkeUh/FXj0XzIaA3JRolhIDN0YaX6P7g8QgU5DKW4Tuvwb6zRsnaf5xMCb5NeLbLutSocLuyX4nH4t+SwPCZfO+V3pFu3rf/orOYjgWKeers5MqSmSKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NILGzXZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NILGzXZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D361F000E9;
	Thu,  9 Jul 2026 06:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783577425;
	bh=6gQ23HRlh8Rt7omFu2ipeDOrE/ZuIEFhWejk2PvEor8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NILGzXZWBhLTeEvJFAANxWPaDX1EIYgYxBy+LNZmxtukKGZ4e9BcTIQc/n9U/HKRd
	 eEtu0wcifqY30ab6Hv95L5nl/TReywW/i3pV59sp56Ehegw34Xgd/CtAMRBpPu3kvE
	 RamZ59zHlITGDVxpS+S6I0kUAoGKreQIxV5dsnM6VfinuvuYdXWS60CzLrzbTimk/o
	 bT4EQVn89LyBzANqJrLKvLj1X7luBpNH6riqCEEl2Q8P1JUqiJqO3af/IXrcOwLCQd
	 0cWjEsrIl4IaIRYssUAl1ow9u/qRx66jI3ucP6ejf6v77lgLhA0OoNF3+zaVFeRSR0
	 xIZJdAw2ONS0w==
Date: Wed, 8 Jul 2026 23:10:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 02/21] perf capstone: Fix arm64 jump/adrp disassembly
 mismatch with objdump
Message-ID: <ak87T3G5-4EAcKIy@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-3-wutengda@huaweicloud.com>
 <20260701040748.64F631F000E9@smtp.kernel.org>
 <70364d4d-e891-45e5-84ed-addf7dcd97d7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70364d4d-e891-45e5-84ed-addf7dcd97d7@huaweicloud.com>

On Wed, Jul 01, 2026 at 02:44:13PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/7/1 12:07, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > - [High] Symbol resolution fails for relocated kernels (KASLR) and user-space shared libraries due to mismatched address spaces.
> > - [Low] Build failure due to undeclared `machine` variable and undefined `machine__normalized_is()` function in `capstone_init()`.
> > - [Low] Missing `<stdlib.h>` inclusion causes musl libc build failure.
> > - [Low] Usage of `ARM64_GRP_BRANCH_RELATIVE` causes build failures with Capstone versions prior to 5.0.
> > --
> > 
> > commit 1f9744f04e456b1209677658edb7f30a5b26e56d
> > Author: Tengda Wu <wutengda@huaweicloud.com>
> > 
> > perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
> > 
> > The patch implements extended formatting for arm64 jump and adrp instructions
> > during symbol__disassemble_capstone() to match objdump's expected output style.
> > It adds instruction detail resolution in capstone_init() and formats the
> > output with correct symbol and offset mappings.
> > 
> >> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> >> index 9bba78ee0c5a2..a9c0a1d2eb036 100644
> >> --- a/tools/perf/util/capstone.c
> >> +++ b/tools/perf/util/capstone.c
> > 
> > [ ... ]
> > 
> >> @@ -218,6 +218,12 @@ static int capstone_init(uint16_t e_machine, csh *cs_handle, bool is64, bool is_
> >>  		 * on x86 by investigating instruction details.
> >>  		 */
> >>  		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> >> +	} else if (machine__normalized_is(machine, "arm64")) {
> > 
> > [Severity: Low]
> > Does this code cause a build failure? The variable machine is not declared
> > in capstone_init(), and the function machine__normalized_is() does not appear
> > to be defined in the codebase.
> > 
> 
> Agreed. This is due to commit 12c4737f55f2 ("perf capstone: Determine architecture from
> e_machine"), which changed the capstone interface. I haven't rebased this part yet.
> The base-commit already fails to build with capstone, so I didn't notice this one.

Yep, it should be 'else if (arch == CS_ARCH_ARM64)' instead.

> 
> >> +		/*
> >> +		 * Same as x86: arm64 needs instruction details to resolve
> >> +		 * symbolic addresses
> >> +		 */
> >> +		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> >>  	}
> >>  
> >>  	return 0;
> > 
> > [ ... ]
> > 
> >> +static bool is_pc_relative_insn(struct cs_insn *insn)
> >> +{
> >> +	int i;
> >> +
> >> +	if (insn->id == ARM64_INS_ADR || insn->id == ARM64_INS_ADRP)
> >> +		return true;
> >> +
> >> +	if (insn->detail == NULL)
> >> +		return false;
> >> +
> >> +	for (i = 0; i < insn->detail->groups_count; i++) {
> >> +		if (insn->detail->groups[i] == ARM64_GRP_JUMP ||
> >> +		    insn->detail->groups[i] == ARM64_GRP_CALL ||
> >> +		    insn->detail->groups[i] == ARM64_GRP_BRANCH_RELATIVE)
> > 
> > [Severity: Low]
> > Will this break compilation against Capstone versions prior to 5.0?
> > ARM64_GRP_BRANCH_RELATIVE was introduced in Capstone 5.0. Since the perf
> > tool's build feature detection doesn't mandate a specific Capstone version,
> > relying on this enum might cause build failures on older setups.

I don't think it's added in 5.0.  I can see it in the 4.0 version too.

https://github.com/capstone-engine/capstone/blob/4.0/include/capstone/arm64.h#L1149

> > 
> 
> This enum was added in Capstone 5.0 over two years ago. I think we can
> safely assume most systems are on a newer version now. I'll leave it as-is.

Two years ago is not old enough to ignore them.  In fact, I have a
commit to fix the capstone build issue by adding the missing constants.

https://lore.kernel.org/linux-perf-users/20260706234836.815254-1-namhyung@kernel.org/

> 
> >> +			return true;
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >> +
> >> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
> >> +				       size_t len, struct annotate_args *args,
> >> +				       u64 addr)
> >> +{
> > 
> > [ ... ]
> > 
> >> +	if (is_pc_relative_insn(insn)) {
> >> +		/* Extract last immediate value as address */
> >> +		last_imm = strrchr(buf, '#');
> >> +		if (!last_imm)
> >> +			return;
> >> +
> >> +		orig_addr = strtoull(last_imm + 1, &endptr, 16);
> > 
> > [Severity: Low]
> > Can this cause a build failure on musl libc? The POSIX standard function
> > strtoull() is used here, but stdlib.h is not explicitly included in the
> > file. Relying on implicit inclusions often works on glibc but breaks on
> > musl libc.
> > 
> 
> I'd say we can ignore this. strtoull() is used all over the perf codebase
> and gets included indirectly. I don't think this is a real issue.

Yep, most of these comments are false alarms.

Thanks,
Namhyung

> 
> >> +		if (endptr == last_imm + 1)
> >> +			return;
> >> +
> >> +		/* Relocate map that contains the address */
> >> +		if (dso__kernel(map__dso(map))) {
> >> +			found_map = maps__find(map__kmaps(map), orig_addr);
> >> +			if (found_map == NULL)
> >> +				return;
> >> +			map = found_map;
> >> +		}
> >> +
> >> +		/* Convert it to map-relative address for search */
> >> +		addr = map__map_ip(map, orig_addr);
> > 
> > [Severity: High]
> > Does this code fail to resolve symbols for relocated kernels (KASLR) or
> > user-space shared libraries (PIE)?
> > 
> > The extracted orig_addr is in the objdump address space. However,
> > maps__find() and map__map_ip() expect absolute memory addresses. By omitting
> > the translation step via map__objdump_2mem(map, orig_addr) (which the x86
> > implementation handles correctly), KASLR relocated kernels will fail in
> > maps__find(), and user-space shared libraries will underflow in
> > map__map_ip().
> > 
> 
> Agreed. I missed map__objdump_2mem() here.
> 
> >> +
> >> +		sym = map__find_symbol(map, addr);
> >> +		if (sym == NULL) {
> >> +			map__put(found_map);
> >> +			return;
> >> +		}
> > 
> 
