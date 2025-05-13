Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37611E5B9C;
	Tue, 13 May 2025 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747168507; cv=none; b=hjOtZ7O1a9OxD7hcKwUnFimbSgSK1Y7JkrI+JgVMafY7NUIy1w6Z8zFwDdPBgScnFytpIZF7KeWXt3oyje10fflOfDJhcQkdVc32ZuGJnsfCRL1/8dSeesaFtbcwZ2yapJXVau70O37mMKjEK+6rdTj81NOnovYv+H8moiOn8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747168507; c=relaxed/simple;
	bh=3ndkBJYgA05ocnj8PxFif4Me/1SAcJEAmyhjvLl6Tfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLZLj+snFq3Z9l0my8tC/4a1lKWJebXdFJFjqg3YFr1e4e7jnZFYlbMb8lRqWK0Ap2RResW4HoNO5sdSCVF52bFQphfwADPWpfr+kXzA3//vEvl2d1lTiMSOuUbpkbwi1lMAzt5WAGgU/aqfaOBRKxK21T4RIYDJEGFIw/IGUu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPYFSqWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPYFSqWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9041EC4CEE4;
	Tue, 13 May 2025 20:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747168506;
	bh=3ndkBJYgA05ocnj8PxFif4Me/1SAcJEAmyhjvLl6Tfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPYFSqWKPs2St3bWvqVb5pAJVsYq6C/DNTdjU4XgB13MQklb4QGZ2cLxWEUz5oAVN
	 2nL5R34+UWZlzkpDLB28ruevKww5QCgXYXDY82CF+10m18QBGEEmQNUzB6RcB2kOTO
	 b5EFp5Q0qa68IGgGoahfob+EYMuJJpTH9e1eSQBWnRivyZsZ4atI+COFmHGORFM50t
	 k6M9jNysXJj32i7jwJOIbA6CuZH0oZu00iwPXvZXYr2wMAXB7bJYCEHfXG3KsgDPh0
	 j72/vfaPP8FLCK6JBs+kssRSPSUjXc4Se1fF+2shbcs7ZnTIh2GwZiYZBouZdhTPy2
	 tdtAcuIwNb0Bg==
Date: Tue, 13 May 2025 17:35:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix arm64 source package build
Message-ID: <aCOs9zc4ipY5E40R@x1>
References: <20250513-james-perf-src-pkg-fix-v1-1-bcfd0486dbd6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513-james-perf-src-pkg-fix-v1-1-bcfd0486dbd6@linaro.org>

On Tue, May 13, 2025 at 10:57:30AM +0100, James Clark wrote:
> Syscall tables are generated from rules in the kernel tree. Add the
> related files to the MANIFEST to fix the Perf source package build.
> 
> Fixes: bfb713ea53c7 ("perf tools: Fix arm64 build by generating unistd_64.h")
> Signed-off-by: James Clark <james.clark@linaro.org>

Thanks, tested, applied and added:

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

BTW, this was caught by using a real system, not my build containers:

acme@raspberrypi:~/git/perf-tools-next $ git log --oneline -1 ; time make -C tools/perf build-test
aea3496bbc7c (HEAD -> perf-tools-next, number/perf-tools-next, number/HEAD) perf tools: Fix arm64 source package build
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j4  DESTDIR=/tmp/tmp.mPjuK60sKX
<SNIP ongoing further tests>

This is a:

acme@raspberrypi:~ $ grep -B2 ^Model /proc/cpuinfo 
Revision	: e04171
Serial		: f48d97e03c925068
Model		: Raspberry Pi 5 Model B Rev 1.1
acme@raspberrypi:~ $ uname -a
Linux raspberrypi 6.12.25+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.25-1+rpt1 (2025-04-30) aarch64 GNU/Linux
acme@raspberrypi:~ $ head -5 /etc/os-release 
PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
NAME="Debian GNU/Linux"
VERSION_ID="12"
VERSION="12 (bookworm)"
VERSION_CODENAME=bookworm
acme@raspberrypi:~ $ free
               total        used        free      shared  buff/cache   available
Mem:        16608944      772160    13666928       30144     2323216    15836784
Swap:         524272           0      524272
acme@raspberrypi:~ $ lspci -vv | grep NVM
0001:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO (prog-if 02 [NVM Express])
	Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO (SSD 980 PRO)
acme@raspberrypi:~ $

root@raspberrypi:~# lspci -vv | grep NVM -A 70
0001:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO (prog-if 02 [NVM Express])
	Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO (SSD 980 PRO)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 38
	Region 0: Memory at 1b80000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (downgraded), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: Upstream Port
	Capabilities: [b0] MSI-X: Enable+ Count=130 Masked-
		Vector table: BAR=0 offset=00003000
		PBA: BAR=0 offset=00002000
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [168 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [178 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [198 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [1bc v1] Lane Margining at the Receiver <?>
	Capabilities: [214 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [21c v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Capabilities: [3a0 v1] Data Link Feature <?>
	Kernel driver in use: nvme

0002:00:00.0 PCI bridge: Broadcom Inc. and subsidiaries BCM2712 PCIe Bridge (rev 30) (prog-if 00 [Normal decode])
root@raspberrypi:~# 

I'll reply to the question about my build containers in the other
thread.

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/MANIFEST | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
> index 364b55b00b4841fc7b3505e8f27ea9f3f246e3be..34af57b8ec2a9cb7f8ff75b4515f32f866452e3e 100644
> --- a/tools/perf/MANIFEST
> +++ b/tools/perf/MANIFEST
> @@ -1,8 +1,10 @@
>  COPYING
>  LICENSES/preferred/GPL-2.0
>  arch/arm64/tools/gen-sysreg.awk
> +arch/arm64/tools/syscall_64.tbl
>  arch/arm64/tools/sysreg
>  arch/*/include/uapi/asm/bpf_perf_event.h
> +include/uapi/asm-generic/Kbuild
>  tools/perf
>  tools/arch
>  tools/scripts
> @@ -25,6 +27,10 @@ tools/lib/str_error_r.c
>  tools/lib/vsprintf.c
>  tools/lib/zalloc.c
>  scripts/bpf_doc.py
> +scripts/Kbuild.include
> +scripts/Makefile.asm-headers
> +scripts/syscall.tbl
> +scripts/syscallhdr.sh
>  tools/bpf/bpftool
>  kernel/bpf/disasm.c
>  kernel/bpf/disasm.h
> 
> ---
> base-commit: 8988c4b91945173a6b5505764915d470f0238fdc
> change-id: 20250513-james-perf-src-pkg-fix-59e5ec53c404
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
