Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542A168BD;
	Thu, 16 Jul 2026 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236051; cv=none; b=a5CLFCxINJV02U1slj1dxHoS9NnO2T7x09pKXB4VnqoU5Pdrtwu2bm8Ufg4uWYvrXMaw/bW1rkGyeDtvQUFgvQL3wk7hlKP1EB9O6yg6l9AvfWvfAxEdAwP6vtfjv08cT1iiK6uLgNjwX74LmfrmpAeJxe2Tz508AVtyusJJrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236051; c=relaxed/simple;
	bh=PdJQ7QCnbyYypMFD5wBHuTeCUviOvFsyxMgFD04mtXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfiumTmNh8UtwKIf2SO3YD6ckhOfJk0iQ3214oQFVgy8rh22UrnH6IGggYvwhVZvUvJ6Zbcn2DCcQcU9dXWrx7mPaVrSmGfBAnafyBVGmlbr4X9Irg/m6z33iqWtMNbHfdX5TJNeXBNXxmYKnKH0tVj24jto/u/dxGU1V0lW43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxtE1lfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxtE1lfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545201F000E9;
	Thu, 16 Jul 2026 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784236050;
	bh=Rr9PGHaybNU4pS2FeD8PYIkRaXvOBImrNRg2+G1FnuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxtE1lfb10hBqZ+8Drq8ZJ09PN9D1LXUpqyNZIqDUHrA+LCfpSKyNbcA6v0zLAqTE
	 1BKOyAO87BOxfYZYKU6ObZkAqpRxnNCQuUcdTNcnv2H/9/iNiKcPgqRKtWJgktFBGF
	 EKzJus4sUICmHVDDAucsGO35KekX0yWYSje7CabnOwrMNVK9NoyH6WaoswXmdi1uyr
	 w7hZqhB22x31/NerX2UQrZf0RdEJNYJ5GzoimaEXnNJvvX/sZEBhRBW+VgLajCAgZw
	 4X1v+NmZtk6aXKyEun04ptXBUkTyCn6l4xSk5f2IfH7pRkIubL/BPvbf3TMrJ87Wvv
	 wJ+CL2x0aHJEQ==
Date: Thu, 16 Jul 2026 14:07:26 -0700
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
Message-ID: <allIDpCmKRcqEjgd@google.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-4-wutengda@huaweicloud.com>
 <ak89Hg1SWnn0DHCk@z2>
 <8812e4e2-3a3b-4f32-bdb8-b963bc21b301@huaweicloud.com>
 <cd081966-36e3-42a6-a06b-27b56b3dd663@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd081966-36e3-42a6-a06b-27b56b3dd663@huaweicloud.com>

On Thu, Jul 16, 2026 at 08:46:01PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/7/9 15:49, Tengda Wu wrote:
> > 
> > 
> > On 2026/7/9 14:18, Namhyung Kim wrote:
> >> On Wed, Jul 01, 2026 at 03:53:37AM +0000, Tengda Wu wrote:
> >>> The operands of 'adrp' instructions parsed by libllvm are currently
> >>> represented as raw immediates rather than the "address <symbol+offset>"
> >>> format used by objdump. This inconsistency causes arm64_mov__parse()
> >>> to fail when parsing these instructions during post-processing.
> >>>
> >>> Example of the mismatch:
> >>>   Current: adrp x18, 8014
> >>>   Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>
> >>>
> >>> Fix this by manually extracting the target address from the raw adrp
> >>> instruction via symbol_lookup_callback(). The address is then converted
> >>> to a specific symbol during symbol__disassemble_llvm() and formatted
> >>> to match objdump's output, ensuring compatibility with existing
> >>> parsers.
> >>>
> >>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >>> ---
> >>>  tools/perf/util/llvm.c | 50 ++++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 50 insertions(+)
> >>>
> >>> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> >>> index a0deb742a733..533d47e8084d 100644
> >>> --- a/tools/perf/util/llvm.c
> >>> +++ b/tools/perf/util/llvm.c
> >>> @@ -94,6 +94,7 @@ static void init_llvm(void)
> >>>  struct symbol_lookup_storage {
> >>>  	u64 branch_addr;
> >>>  	u64 pcrel_load_addr;
> >>> +	u64 pcrel_adrp_addr;
> >>>  };
> >>>  
> >>>  static const char *
> >>> @@ -108,6 +109,18 @@ symbol_lookup_callback(void *disinfo, uint64_t value,
> >>>  		storage->branch_addr = value;
> >>>  	else if (*ref_type == LLVMDisassembler_ReferenceType_In_PCrel_Load)
> >>>  		storage->pcrel_load_addr = value;
> >>
> >> Is this used by arm64?  If not, would be possible to reuse
> >> pcrel_load_addr unless it'd complicate the code significantly?
> >>
> >> I think it's the common concept of PC-relative addressing while it
> >> requires two instructions to set up the final address on arm64.
> >>
> >> Thanks,
> >> Namhyung
> >>
> 
> I checked the LLVM internal implementation and conducted further experiments.
> You are correct, arm64 does not trigger LLVMDisassembler_ReferenceType_In_PCrel_Load
> at all. Instead, it utilizes its own architecture-specific reference types
> like LLVMDisassembler_ReferenceType_In_ARM64_ADRP, _LDRXl, etc.
> Therefore, 'pcrel_load_addr' is completely safe to reuse here.
> 
> I will reuse 'pcrel_load_addr' to avoid adding unnecessary fields and
> optimize this patch in the next version.

Great, thanks for looking into it.

Thanks,
Namhyung

