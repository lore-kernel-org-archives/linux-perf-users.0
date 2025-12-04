Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E64DF6C
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764807872; cv=none; b=VzruUjG1aJyaFJ3QHz8XquiE0ollYYKg7XIYNhei4v675ZRjQKwI6SQxggloEUkO3R/lUQpXDSIkjxKAqUqIsXgQ4Yx7kJuwV8Q5OrjlH6vXuNP6p3oGLcM/RqmgQD0sl3sKBH9M/Tyv2ij8eB462QF+1ufyMk3RD+yfQz1v5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764807872; c=relaxed/simple;
	bh=6Tfa3AMLbypBfTAyBUA3np8avYbkc5BpXZu0C39U06g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfUYdTBOP5yj9LrgYYYhlt+dLy+92GOVykiEkPpRTo/7PcyNWGsvLYN/09i0TC/cGzojKKTZFGdKlPmmM0dHbzMo6TsF+5YcXoHOubYlOUb2Nf40u4piXosmX2sy705M1ksu79uGqj+WKkFSgGxQfA8D8XurYGl0+k1B8977rNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MracsAbX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MracsAbX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29852dafa7dso41935ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 16:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764807870; x=1765412670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWJC1qlMUI/r0xyezxePg/T/bKZCHCkQB2rgKkeSdO0=;
        b=MracsAbXd8fYc0WIWWVOv4mvJNxxJVgfOKEfMoL3dr/gHaoMenzScWZ7MVL2oKKIHu
         KATZVqy7Bb2M/4TlJnROrhP9xKnnvqhbLn1lWurfRfIowVlC317x7k75lVoW3P2B9EqG
         kYkE4aWgoKyrXWoekGamL+uDlsaDaYcpzMleCSClRsieiEzpajIaaPV7xRuMHokIk5u5
         a1NR2iByW0qpl0H7xB03AmEvu0uSk2D31PN+YnYlv7UVoBSXcLf+1LhA1SZinVL8K03u
         cygdC14Y+3955u87V7qXRX6lbTbd3YNBlbp12Nhxk+4TKEdp/mWI0trkj/G65qoNid2p
         yyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764807870; x=1765412670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWJC1qlMUI/r0xyezxePg/T/bKZCHCkQB2rgKkeSdO0=;
        b=OsjlH919YPsQaEXCDhusqKUVMtFaCBeCe6oHJmEXM2vgaQByryuu+vRa1yHQv50mDy
         FNvJhoAg+SRQtH1ZV0PFEpdRPN3EfvEKBLSn6G71Sb+z19DydMgt2gKe0i2Pj0NdLnPn
         Z+Aku+TlSQMdNPCbBxxkw45D91KWQT2SYh9i0O6Vk6r0UuZktXaj+pkEDb3Od27a20BH
         laRmCS6egeBrF2qYrGYGAqPEZAz3ukNQFEEX/LSP3AsN841rYzvc/gJhix1qF51oEd7m
         W8PjTvcVweu8qh+F5PPmJPHeYtlqBl3ER84blHPupmedoOV7K1+sb7+aschRWWy+8b1q
         15dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcNP5HUwONEahGmZqZRjzzZo4lQKKxwBSgpLyoc2rwsGNDVtaUoPAflwHoeCVwCcGc6//eTbvpEbwaP2OUZIBt@vger.kernel.org
X-Gm-Message-State: AOJu0YzYe7sru91aaXZKbQOtuj8AacfPUSaC0XWqFaVAyOkqVgT8HA7w
	7XbAbBXP9Db5WXSfGByFJ0bpImIOb0jrtWKKarAr9WirCOvU70MXAc3oTY6surT0b+0QYqaSvgH
	BnaWSu0ExySVrLvmEBZ1n5GQQZ+YsZrz11+w8ezBJ
X-Gm-Gg: ASbGnctlslW0fVXbky54Z1B+a61KUzbYjN6Be7+CSlfcc/J8z4Mxf0bz0rEmrBYYqmW
	eEPJVSdJmyUa+i03hytIwDTLrK0asmtYFjvQG5Y14nrGMFskWEB3VXc5BfQ0mLBZMDScmd3VLjC
	sdFp7+DYa2W9Dr1hHis2OOGRRagzzNyfkgQYv80nG3Hxc43cL4YFI7fFsdwKp1es3z3HMrGfWc9
	NQSXRXAFLBzS5a7ZKy3TZDXa8YdGtfL+83vkUtjh1Mx6Hi72U6D9nlnIgCCM+ko7arXwIZ8
X-Google-Smtp-Source: AGHT+IHGeqmz+MxsH57WON0oyD/N6qxbX77pmnKBF2xleSxn6aSYOcjr+8wEVFd61m0hRq+uX6y5iPM+Me4Lc2er3hU=
X-Received: by 2002:a17:902:c947:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-29da3f8069cmr1272595ad.6.1764807869626; Wed, 03 Dec 2025
 16:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 16:24:18 -0800
X-Gm-Features: AWmQ_bmXifxm_FuA2iZGx2TniDrXbsd8UC4MdOSQjLjcKHkzz_mBwU3U3ZbJKZw
Message-ID: <CAP-5=fW=qZzAsmc7CKj-GGbABBgCB7KhK+Xa8K1LiUGJJBC9Hg@mail.gmail.com>
Subject: Re: [Patch v5 00/19] Support SIMD/eGPRs/SSP registers sampling for perf
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 10:58=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Changes since V4:
> - Rewrite some functions comments and commit messages (Dave)
> - Add arch-PEBS based SIMD/eGPRs/SSP sampling support (Patch 15/19)
> - Fix "suspecious NMI" warnning observed on PTL/NVL P-core and DMR by
>   activating back-to-back NMI detection mechanism (Patch 16/19)
> - Fix some minor issues on perf-tool patches (Patch 18/19)
>
> Changes since V3:
> - Drop the SIMD registers if an NMI hits kernel mode for REGS_USER.
> - Only dump the available regs, rather than zero and dump the
>   unavailable regs. It's possible that the dumped registers are a subset
>   of the requested registers.
> - Some minor updates to address Dapeng's comments in V3.
>
> Changes since V2:
> - Use the FPU format for the x86_pmu.ext_regs_mask as well
> - Add a check before invoking xsaves_nmi()
> - Add perf_simd_reg_check() to retrieve the number of available
>   registers. If the kernel fails to get the requested registers, e.g.,
>   XSAVES fails, nothing dumps to the userspace (the V2 dumps all 0s).
> - Add POC perf tool patches
>
> Changes since V1:
> - Apply the new interfaces to configure and dump the SIMD registers
> - Utilize the existing FPU functions, e.g., xstate_calculate_size,
>   get_xsave_addr().
>
> Starting from Intel Ice Lake, XMM registers can be collected in a PEBS
> record. Future Architecture PEBS will include additional registers such
> as YMM, ZMM, OPMASK, SSP and APX eGPRs, contingent on hardware support.
>
> This patch set introduces a software solution to mitigate the hardware
> requirement by utilizing the XSAVES command to retrieve the requested
> registers in the overflow handler. This feature is no longer limited to
> PEBS events or specific platforms. While the hardware solution remains
> preferable due to its lower overhead and higher accuracy, this software
> approach provides a viable alternative.
>
> The solution is theoretically compatible with all x86 platforms but is
> currently enabled on newer platforms, including Sapphire Rapids and
> later P-core server platforms, Sierra Forest and later E-core server
> platforms and recent Client platforms, like Arrow Lake, Panther Lake and
> Nova Lake.
>
> Newly supported registers include YMM, ZMM, OPMASK, SSP, and APX eGPRs.
> Due to space constraints in sample_regs_user/intr, new fields have been
> introduced in the perf_event_attr structure to accommodate these
> registers.
>
> After a long discussion in V1,
> https://lore.kernel.org/lkml/3f1c9a9e-cb63-47ff-a5e9-06555fa6cc9a@linux.i=
ntel.com/
> The below new fields are introduced.
>
> @@ -543,6 +545,25 @@ struct perf_event_attr {
>         __u64   sig_data;
>
>         __u64   config3; /* extension of config2 */
> +
> +
> +       /*
> +        * Defines set of SIMD registers to dump on samples.
> +        * The sample_simd_regs_enabled !=3D0 implies the
> +        * set of SIMD registers is used to config all SIMD registers.
> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
> +        * config some SIMD registers on X86.
> +        */
> +       union {
> +               __u16 sample_simd_regs_enabled;
> +               __u16 sample_simd_pred_reg_qwords;
> +       };
> +       __u32 sample_simd_pred_reg_intr;
> +       __u32 sample_simd_pred_reg_user;
> +       __u16 sample_simd_vec_reg_qwords;
> +       __u64 sample_simd_vec_reg_intr;
> +       __u64 sample_simd_vec_reg_user;
> +       __u32 __reserved_4;
>  };
> @@ -1016,7 +1037,15 @@ enum perf_event_type {
>          *      } && PERF_SAMPLE_BRANCH_STACK
>          *
>          *      { u64                   abi; # enum perf_sample_regs_abi
> -        *        u64                   regs[weight(mask)]; } && PERF_SAM=
PLE_REGS_USER
> +        *        u64                   regs[weight(mask)];
> +        *        struct {
> +        *              u16 nr_vectors;
> +        *              u16 vector_qwords;
> +        *              u16 nr_pred;
> +        *              u16 pred_qwords;
> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * p=
red_qwords];
> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +        *      } && PERF_SAMPLE_REGS_USER
>          *
>          *      { u64                   size;
>          *        char                  data[size];
> @@ -1043,7 +1072,15 @@ enum perf_event_type {
>          *      { u64                   data_src; } && PERF_SAMPLE_DATA_S=
RC
>          *      { u64                   transaction; } && PERF_SAMPLE_TRA=
NSACTION
>          *      { u64                   abi; # enum perf_sample_regs_abi
> -        *        u64                   regs[weight(mask)]; } && PERF_SAM=
PLE_REGS_INTR
> +        *        u64                   regs[weight(mask)];
> +        *        struct {
> +        *              u16 nr_vectors;
> +        *              u16 vector_qwords;
> +        *              u16 nr_pred;
> +        *              u16 pred_qwords;
> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * p=
red_qwords];
> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +        *      } && PERF_SAMPLE_REGS_INTR
>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_A=
DDR
>          *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
>          *      { u64                   data_page_size;} && PERF_SAMPLE_D=
ATA_PAGE_SIZE
>
>
> To maintain simplicity, a single field, sample_{simd|pred}_vec_reg_qwords=
,
> is introduced to indicate register width. For example:
> - sample_simd_vec_reg_qwords =3D 2 for XMM registers (128 bits) on x86
> - sample_simd_vec_reg_qwords =3D 4 for YMM registers (256 bits) on x86
>
> Four additional fields, sample_{simd|pred}_vec_reg_{intr|user}, represent
> the bitmap of sampling registers. For instance, the bitmap for x86
> XMM registers is 0xffff (16 XMM registers). Although users can
> theoretically sample a subset of registers, the current perf-tool
> implementation supports sampling all registers of each type to avoid
> complexity.
>
> A new ABI, PERF_SAMPLE_REGS_ABI_SIMD, is introduced to signal user space
> tools about the presence of SIMD registers in sampling records. When this
> flag is detected, tools should recognize that extra SIMD register data
> follows the general register data. The layout of the extra SIMD register
> data is displayed as follow.
>
>    u16 nr_vectors;
>    u16 vector_qwords;
>    u16 nr_pred;
>    u16 pred_qwords;
>    u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>
> With this patch set, sampling for the aforementioned registers is
> supported on the Intel Nova Lake platform.
>
> Examples:
>  $perf record -I?
>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7

nit: It seems strange in this output to mix ranges like "XMM0-15" but
then list out "R8....R31". That said we have tests that explicitly
look for the non-range pattern:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next#n106

Thanks,
Ian

>  $perf record --user-regs=3D?
>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
>
>  $perf record -e branches:p -Iax,bx,r8,r16,r31,ssp,xmm,ymm,zmm,opmask -c =
100000 ./test
>  $perf report -D
>
>  ... ...
>  14027761992115 0xcf30 [0x8a8]: PERF_RECORD_SAMPLE(IP, 0x1): 29964/29964:
>  0xffffffff9f085e24 period: 100000 addr: 0
>  ... intr regs: mask 0x18001010003 ABI 64-bit
>  .... AX    0xdffffc0000000000
>  .... BX    0xffff8882297685e8
>  .... R8    0x0000000000000000
>  .... R16   0x0000000000000000
>  .... R31   0x0000000000000000
>  .... SSP   0x0000000000000000
>  ... SIMD ABI nr_vectors 32 vector_qwords 8 nr_pred 8 pred_qwords 1
>  .... ZMM  [0] 0xffffffffffffffff
>  .... ZMM  [0] 0x0000000000000001
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [1] 0x003a6b6165506d56
>  ... ...
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... OPMASK[0] 0x00000000fffffe00
>  .... OPMASK[1] 0x0000000000ffffff
>  .... OPMASK[2] 0x000000000000007f
>  .... OPMASK[3] 0x0000000000000000
>  .... OPMASK[4] 0x0000000000010080
>  .... OPMASK[5] 0x0000000000000000
>  .... OPMASK[6] 0x0000400004000000
>  .... OPMASK[7] 0x0000000000000000
>  ... ...
>
>
> History:
>   v4: https://lore.kernel.org/all/20250925061213.178796-1-dapeng1.mi@linu=
x.intel.com/
>   v3: https://lore.kernel.org/lkml/20250815213435.1702022-1-kan.liang@lin=
ux.intel.com/
>   v2: https://lore.kernel.org/lkml/20250626195610.405379-1-kan.liang@linu=
x.intel.com/
>   v1: https://lore.kernel.org/lkml/20250613134943.3186517-1-kan.liang@lin=
ux.intel.com/
>
> Dapeng Mi (3):
>   perf: Eliminate duplicate arch-specific functions definations
>   perf/x86/intel: Enable arch-PEBS based SIMD/eGPRs/SSP sampling
>   perf/x86: Activate back-to-back NMI detection for arch-PEBS induced
>     NMIs
>
> Kan Liang (16):
>   perf/x86: Use x86_perf_regs in the x86 nmi handler
>   perf/x86: Introduce x86-specific x86_pmu_setup_regs_data()
>   x86/fpu/xstate: Add xsaves_nmi() helper
>   perf: Move and rename has_extended_regs() for ARCH-specific use
>   perf/x86: Add support for XMM registers in non-PEBS and REGS_USER
>   perf: Add sampling support for SIMD registers
>   perf/x86: Enable XMM sampling using sample_simd_vec_reg_* fields
>   perf/x86: Enable YMM sampling using sample_simd_vec_reg_* fields
>   perf/x86: Enable ZMM sampling using sample_simd_vec_reg_* fields
>   perf/x86: Enable OPMASK sampling using sample_simd_pred_reg_* fields
>   perf/x86: Enable eGPRs sampling using sample_regs_* fields
>   perf/x86: Enable SSP sampling using sample_regs_* fields
>   perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
>   perf headers: Sync with the kernel headers
>   perf parse-regs: Support new SIMD sampling format
>   perf regs: Enable dumping of SIMD registers
>
>  arch/arm/kernel/perf_regs.c                   |   8 +-
>  arch/arm64/kernel/perf_regs.c                 |   8 +-
>  arch/csky/kernel/perf_regs.c                  |   8 +-
>  arch/loongarch/kernel/perf_regs.c             |   8 +-
>  arch/mips/kernel/perf_regs.c                  |   8 +-
>  arch/parisc/kernel/perf_regs.c                |   8 +-
>  arch/powerpc/perf/perf_regs.c                 |   2 +-
>  arch/riscv/kernel/perf_regs.c                 |   8 +-
>  arch/s390/kernel/perf_regs.c                  |   2 +-
>  arch/x86/events/core.c                        | 326 +++++++++++-
>  arch/x86/events/intel/core.c                  | 117 ++++-
>  arch/x86/events/intel/ds.c                    | 134 ++++-
>  arch/x86/events/perf_event.h                  |  85 +++-
>  arch/x86/include/asm/fpu/xstate.h             |   3 +
>  arch/x86/include/asm/msr-index.h              |   7 +
>  arch/x86/include/asm/perf_event.h             |  38 +-
>  arch/x86/include/uapi/asm/perf_regs.h         |  62 +++
>  arch/x86/kernel/fpu/xstate.c                  |  25 +-
>  arch/x86/kernel/perf_regs.c                   | 131 ++++-
>  include/linux/perf_event.h                    |  16 +
>  include/linux/perf_regs.h                     |  36 +-
>  include/uapi/linux/perf_event.h               |  45 +-
>  kernel/events/core.c                          | 132 ++++-
>  tools/arch/x86/include/uapi/asm/perf_regs.h   |  62 +++
>  tools/include/uapi/linux/perf_event.h         |  45 +-
>  tools/perf/arch/x86/util/perf_regs.c          | 470 +++++++++++++++++-
>  tools/perf/util/evsel.c                       |  47 ++
>  tools/perf/util/parse-regs-options.c          | 151 +++++-
>  .../perf/util/perf-regs-arch/perf_regs_x86.c  |  43 ++
>  tools/perf/util/perf_event_attr_fprintf.c     |   6 +
>  tools/perf/util/perf_regs.c                   |  59 +++
>  tools/perf/util/perf_regs.h                   |  11 +
>  tools/perf/util/record.h                      |   6 +
>  tools/perf/util/sample.h                      |  10 +
>  tools/perf/util/session.c                     |  78 ++-
>  35 files changed, 2012 insertions(+), 193 deletions(-)
>
>
> base-commit: 9929dffce5ed7e2988e0274f4db98035508b16d9
> prerequisite-patch-id: a15bcd62a8dcd219d17489eef88b66ea5488a2a0
> --
> 2.34.1
>
