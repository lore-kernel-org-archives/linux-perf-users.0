Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40447D2FB;
	Wed, 22 Oct 2025 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093726; cv=none; b=MDkSFzv54n19rJyYsbl7AX5dYuENHjuBjHohMDStKRgINY1H4hbFi/ptqHatW9z7PYjC1++erFC2QqBtFm7kretP20qDNvaOsEit9nXNaHvnOpbLeH7Klpfrwl9urPFOPsPvacEUC9eQbaV5+Qr9PpW4m0RlCVc0lP5aIQ2JCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093726; c=relaxed/simple;
	bh=LnhsXoBcNxtEasvKkLZV5gjzwsUsenbpgPgL7jkUjl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1T6lffWN8c5GbkCHNOJ0weU7dPq4SKAOIfyJ7vQ72ZGZ2EGYnSxrT1V8jrdecpftGUrMEtvTkcZjAgWbVsvta+LtuvAem2wanpUF8wzyCaEwEQsnWDcl5BXIwPCljQTc1FoOwYN9J6ibLHYsT/naZi3vm5kCE99oGmSFcipld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgSi1rDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgSi1rDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409A2C4CEF1;
	Wed, 22 Oct 2025 00:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761093725;
	bh=LnhsXoBcNxtEasvKkLZV5gjzwsUsenbpgPgL7jkUjl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgSi1rDLmnzf3yQSa+2FTfYs1O2nzKyq7UwwLjQ1Dq6KeugwGOU4wwtu/0bmocy2Y
	 a49gK8PHnP9XCrqNU4CaGNM/wy7Zir23gI9biWEjYdrWgQ88n8ys15DiBvlyJLpq7K
	 woQXkmJV83+iRtKNpVxxWN5XMjGgW2slJewort5GEB9rkJNrnmISKBErTHEQ/d5Stj
	 tIG2Dr+CA8Vm4dnZ+Yqh/V9Ap7H2jqPg5I3rQHsbNstBKH2g7uS8u/FhVbaWGGyAiI
	 pABxFjut7OtZjshTSvFG2tNApPr7esiX50iF56GaDn1B4Al1oqtk8Qm7kHRxWM8ljw
	 yXkvrujtjluXA==
Date: Wed, 22 Oct 2025 09:41:57 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] perf tools: Some improvements on data type
 profiler
Message-ID: <aPgoVTfCFxqTpCaK@google.com>
References: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>

Hello,

On Mon, Oct 13, 2025 at 06:15:57PM +0000, Zecheng Li wrote:
> Hi all,
> 
> I've identified several missing data type annotations within the perf
> tools when annotating the Linux kernel. This patch series improves the
> coverage and correctness of data type annotations.
> 
> Some patches from the previous version of this series were
> cherry-picked. This revision adds new improvements based on feedback and
> further development.
> 
> Here's a breakdown of the changes in this revision:
> 
> Patch 1 skips annotations for LEA instructions in x86, as these do not
> involve memory access. It now returns NO_TYPE.
> 
> Patches 2 implements the TSR_KIND_POINTER to represent registers holding
> memory addresses of the type. We are using the size of void* to get the
> pointer size. This could be improved to use an architecture dependent
> pointer size, but may require more work.
> 
> Patches 3-5 implement a basic approach for register offset tracking that
> supports add, sub, and lea operations. The register state is invalidated
> when an unsupported arithmetic instruction is encountered. This revision
> uses TSR_KIND_POINTER to avoid finding the pointer type in DWARF and
> preserves the pointer offset information in the stack state.

I've applied up to this to perf-tools-next, will review the rest later.

Thanks,
Namhyung

> 
> Patches 6-8 split patch 8 from v2 with some minor improvements. It skips
> check_variable when the type is found directly by register, since
> sufficient checking is already performed in match_var_offset.
> check_variable lacks some DWARF information to correctly determine if a
> variable is valid. I also found it is able to find members for
> typedef'd types so I preserve them in match_var_offset.
> 
> Patch 9 implements support for DW_OP_piece. Currently, this is allowed
> in check_allowed_ops but is handled like other single location
> expressions. This patch splits any expression containing DW_OP_piece
> into multiple parts and handle them separately.
> 
> I have tested each patch on a vmlinux and manually checked the results.
> After applying all patches, there are less missing or incorrect
> annotations. No obvious regressions were observed.
> 
> v4:
> Merged patch in v3:
> perf annotate: Rename TSR_KIND_POINTER to TSR_KIND_PERCPU_POINTER
> 
> Updated patches 1-5 based on the feedback from Namhyung.
> 
> v3:
> https://lore.kernel.org/all/20250917195808.2514277-1-zecheng@google.com/
> Merged patches in v2:
> 
> perf dwarf-aux: Use signed variable types in match_var_offset
> perf dwarf-aux: More accurate variable type match for breg
> perf dwarf-aux: Better variable collection for insn tracking
> perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
> 
> v2:
> https://lore.kernel.org/all/20250825195412.223077-1-zecheng@google.com/
> 1. update the match_var_offset function signature to s64
> 2. correct the comment for is_breg_access_indirect. Use simpler logic to
> match the expressions we support.
> 3. add is_reg_var_addr to indicate whether a register holds an address
> of the variable. This defers the type dereference logic to
> update_var_state.
> 4. invalidate register state for unsupported instructions.
> 5. include two new patches related to improving data type profiler.
> 
> v1:
> https://lore.kernel.org/linux-perf-users/20250725202809.1230085-1-zecheng@google.com/
> 
> Zecheng Li (9):
>   perf annotate: Skip annotating data types to lea instructions
>   perf annotate: Track address registers via TSR_KIND_POINTER
>   perf annotate: Track arithmetic instructions on pointers
>   perf annotate: Save pointer offset in stack state
>   perf annotate: Invalidate register states for untracked instructions
>   perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
>   perf dwarf-aux: Preserve typedefs in match_var_offset
>   perf annotate: Improve type comparison from different scopes
>   perf dwarf-aux: Support DW_OP_piece expressions
> 
>  tools/perf/arch/x86/annotate/instructions.c | 183 +++++++++++++-
>  tools/perf/util/annotate-data.c             | 102 ++++++--
>  tools/perf/util/annotate-data.h             |  14 +-
>  tools/perf/util/annotate.c                  |  20 ++
>  tools/perf/util/dwarf-aux.c                 | 266 +++++++++++++++-----
>  tools/perf/util/dwarf-aux.h                 |   2 +-
>  6 files changed, 493 insertions(+), 94 deletions(-)
> 
> -- 
> 2.51.0
> 
