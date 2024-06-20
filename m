Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1B1AD491;
	Thu, 20 Jun 2024 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891951; cv=none; b=FJQy3YPdETOF6N9pqfOGZ4e3tDn+xr4K0s0qfi8YwCEuDqJ4ayIwzILktiTkulMj1eV6VYy/ecotDQ9H8cPb+O8r81VHM5Qiif2BnzN1qEmAm91xEIAFrL/9Ng+B4iJmvmt04tOmGw/2cLPc2xGJXM9IZbqown3VQ9KLCNSWr40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891951; c=relaxed/simple;
	bh=lksZ8VJcoa6+dcROVfr/oRLVM94ZSm0pB9WTINjKpNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBDfUa6gAoA07wo8hNuzaV7lt+4jmaxD4Y4m0SYjGHnGOFdbJnxDlWrPdsopYQaG8XHqAMG2H/f4meZHv2lG8T8SkOVKuSMXb2UCqgLfmWZ2oJ9K6cklRjRega6eYNiamuY9t4gJNoM9bY7vOBhMriTVluYPo/cbYrmkVsAPkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xmromx6Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xmromx6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526B1C2BD10;
	Thu, 20 Jun 2024 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718891950;
	bh=lksZ8VJcoa6+dcROVfr/oRLVM94ZSm0pB9WTINjKpNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xmromx6QAZ3vslIX5ixykSUVpHJ1uLzJucSNzzSsJl/ZfMXTbu8za/IWNKHQwM3WJ
	 yZqGuoYZzySC473QzftNYk2pK+uV+uWLA49p53qFNQLjRn54OdIvHnxrB2d6/eM5za
	 2YLLTWHVzv2hYHdjbrCIAWlexNq4HGoOxmMoD7VgEwtHVSdc1yUBO3ecO8Hp4IKVu7
	 cuJ3Fbwedvmjl7pl9LkXfWNwzULvcPOj2g8z7Nw3jts5Yl7phbSzbTkFEXgnrC8nlU
	 H/HxxW2isGWfqpxm0afQZ8dSR7tI6O855QF4cJoPpwugxbD5yqm+QNQR1f15KoU8XR
	 v8ngJ1eXYq0qg==
Date: Thu, 20 Jun 2024 10:59:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: namhyung@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	yangjihong1@huawei.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, sandipan.das@amd.com,
	ananth.narayan@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH v2] perf doc: Add AMD IBS usage document
Message-ID: <ZnQ1q-EGKA1qCHdh@x1>
References: <20240620054104.815-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620054104.815-1-ravi.bangoria@amd.com>

On Thu, Jun 20, 2024 at 05:41:04AM +0000, Ravi Bangoria wrote:
> Add a perf man page document that describes how to exploit AMD IBS with
> Linux perf. Brief intro about IBS and simple one-liner examples will help
> naive users to get started. This is not meant to be an exhaustive IBS
> guide. User should refer latest AMD64 Architecture Programmer's Manual
> for detailed description of IBS.
> 
> Usage:
> 
>   $ man perf-amd-ibs

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> v1: https://lore.kernel.org/r/20240619092234.1165-1-ravi.bangoria@amd.com
> v1->v2:
>  - Describe core PMU to IBS event forwarding
>  - Describe perf mem and perf c2c in brief
>  - Add example of IBS register raw dump
>  - Describe rand_en flag of IBS Fetch PMU
> 
>  tools/perf/Documentation/perf-amd-ibs.txt | 189 ++++++++++++++++++++++
>  tools/perf/Documentation/perf.txt         |   3 +-
>  2 files changed, 191 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/Documentation/perf-amd-ibs.txt
> 
> diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
> new file mode 100644
> index 000000000000..ce8ac51d4ce2
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-amd-ibs.txt
> @@ -0,0 +1,189 @@
> +perf-amd-ibs(1)
> +===============
> +
> +NAME
> +----
> +perf-amd-ibs - Support for AMD Instruction-Based Sampling (IBS) with perf tool
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'perf record' -e ibs_op//
> +'perf record' -e ibs_fetch//
> +
> +DESCRIPTION
> +-----------
> +
> +Instruction-Based Sampling (IBS) provides precise Instruction Pointer (IP)
> +profiling support on AMD platforms. IBS has two independent components: IBS
> +Op and IBS Fetch. IBS Op sampling provides information about instruction
> +execution (micro-op execution to be precise) with details like d-cache
> +hit/miss, d-TLB hit/miss, cache miss latency, load/store data source, branch
> +behavior etc. IBS Fetch sampling provides information about instruction fetch
> +with details like i-cache hit/miss, i-TLB hit/miss, fetch latency etc. IBS is
> +per-smt-thread i.e. each SMT hardware thread contains standalone IBS units.
> +
> +Both, IBS Op and IBS Fetch, are exposed as PMUs by Linux and can be exploited
> +using the Linux perf utility. The following files will be created at boot time
> +if IBS is supported by the hardware and kernel.
> +
> +  /sys/bus/event_source/devices/ibs_op/
> +  /sys/bus/event_source/devices/ibs_fetch/
> +
> +IBS Op PMU supports two events: cycles and micro ops. IBS Fetch PMU supports
> +one event: fetch ops.
> +
> +IBS PMUs do not have user/kernel filtering capability and thus it requires
> +CAP_SYS_ADMIN or CAP_PERFMON privilege.
> +
> +IBS VS. REGULAR CORE PMU
> +------------------------
> +
> +IBS gives samples with precise IP, i.e. the IP recorded with IBS sample has
> +no skid. Whereas the IP recorded by regular core PMU will have some skid
> +(sample was generated at IP X but perf would record it at IP X+n). Hence,
> +regular core PMU might not help for profiling with instruction level
> +precision. Further, IBS provides additional information about the sample in
> +question. On the other hand, regular core PMU has it's own advantages like
> +plethora of events, counting mode (less interference), up to 6 parallel
> +counters, event grouping support, filtering capabilities etc.
> +
> +Three regular core PMU events are internally forwarded to IBS Op PMU when
> +precise_ip attribute is set:
> +
> +	-e cpu-cycles:p becomes -e ibs_op//
> +	-e r076:p becomes -e ibs_op//
> +	-e r0C1:p becomes -e ibs_op/cnt_ctl=1/
> +
> +EXAMPLES
> +--------
> +
> +IBS Op PMU
> +~~~~~~~~~~
> +
> +System-wide profile, cycles event, sampling period: 100000
> +
> +	# perf record -e ibs_op// -c 100000 -a
> +
> +Per-cpu profile (cpu10), cycles event, sampling period: 100000
> +
> +	# perf record -e ibs_op// -c 100000 -C 10
> +
> +Per-cpu profile (cpu10), cycles event, sampling freq: 1000
> +
> +	# perf record -e ibs_op// -F 1000 -C 10
> +
> +System-wide profile, uOps event, sampling period: 100000
> +
> +	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -a
> +
> +Same command, but also capture IBS register raw dump along with perf sample:
> +
> +	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -a --raw-samples
> +
> +System-wide profile, uOps event, sampling period: 100000, L3MissOnly (Zen4 onward)
> +
> +	# perf record -e ibs_op/cnt_ctl=1,l3missonly=1/ -c 100000 -a
> +
> +Per process(upstream v6.2 onward), uOps event, sampling period: 100000
> +
> +	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -p 1234
> +
> +Per process(upstream v6.2 onward), uOps event, sampling period: 100000
> +
> +	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -- ls
> +
> +To analyse recorded profile in aggregate mode
> +
> +	# perf report
> +	/* Select a line and press 'a' to drill down at instruction level. */
> +
> +To go over each sample
> +
> +	# perf script
> +
> +Raw dump of IBS registers when profiled with --raw-samples
> +
> +	# perf report -D
> +	/* Look for PERF_RECORD_SAMPLE */
> +
> +	Example register raw dump:
> +
> +	ibs_op_ctl:     000002c30006186a MaxCnt    100000 L3MissOnly 0 En 1
> +		Val 1 CntCtl 0=cycles CurCnt       707
> +	IbsOpRip:       ffffffff8204aea7
> +	ibs_op_data:    0000010002550001 CompToRetCtr     1 TagToRetCtr   597
> +		BrnRet 0  RipInvalid 0 BrnFuse 0 Microcode 1
> +	ibs_op_data2:   0000000000000013 RmtNode 1 DataSrc 3=DRAM
> +	ibs_op_data3:   0000000031960092 LdOp 0 StOp 1 DcL1TlbMiss 0
> +		DcL2TlbMiss 0 DcL1TlbHit2M 1 DcL1TlbHit1G 0 DcL2TlbHit2M 0
> +		DcMiss 1 DcMisAcc 0 DcWcMemAcc 0 DcUcMemAcc 0 DcLockedOp 0
> +		DcMissNoMabAlloc 0 DcLinAddrValid 1 DcPhyAddrValid 1
> +		DcL2TlbHit1G 0 L2Miss 1 SwPf 0 OpMemWidth 32 bytes
> +		OpDcMissOpenMemReqs 12 DcMissLat     0 TlbRefillLat     0
> +	IbsDCLinAd:     ff110008a5398920
> +	IbsDCPhysAd:    00000008a5398920
> +
> +IBS applied in a real world usecase
> +
> +	~90% regression was observed in tbench with specific scheduler hint
> +	which was counter intuitive. IBS profile of good and bad run captured
> +	using perf helped in identifying exact cause of the problem:
> +
> +	https://lore.kernel.org/r/20220921063638.2489-1-kprateek.nayak@amd.com
> +
> +IBS Fetch PMU
> +~~~~~~~~~~~~~
> +
> +Similar commands can be used with Fetch PMU as well.
> +
> +System-wide profile, fetch ops event, sampling period: 100000
> +
> +	# perf record -e ibs_fetch// -c 100000 -a
> +
> +System-wide profile, fetch ops event, sampling period: 100000, Random enable
> +
> +	# perf record -e ibs_fetch/rand_en=1/ -c 100000 -a
> +
> +	Random enable adds small degree of variability to sample period. This
> +	helps in cases like long running loops where PMU is tagging the same
> +	instruction over and over because of fixed sample period.
> +
> +etc.
> +
> +PERF MEM AND PERF C2C
> +---------------------
> +
> +perf mem is a memory access profiler tool and perf c2c is a shared data
> +cacheline analyser tool. Both of them internally uses IBS Op PMU on AMD.
> +Below is a simple example of the perf mem tool.
> +
> +	# perf mem record -c 100000 -- make
> +	# perf mem report
> +
> +A normal perf mem report output will provide detailed memory access profile.
> +However, it can also be aggregated based on output fields. For example:
> +
> +	# perf mem report -F mem,sample,snoop
> +	Samples: 3M of event 'ibs_op//', Event count (approx.): 23524876
> +	Memory access                                 Samples  Snoop
> +	N/A                                           1903343  N/A
> +	L1 hit                                        1056754  N/A
> +	L2 hit                                          75231  N/A
> +	L3 hit                                           9496  HitM
> +	L3 hit                                           2270  N/A
> +	RAM hit                                          8710  N/A
> +	Remote node, same socket RAM hit                 3241  N/A
> +	Remote core, same node Any cache hit             1572  HitM
> +	Remote core, same node Any cache hit              514  N/A
> +	Remote node, same socket Any cache hit           1216  HitM
> +	Remote node, same socket Any cache hit            350  N/A
> +	Uncached hit                                       18  N/A
> +
> +Please refer to their man page for more detail.
> +
> +SEE ALSO
> +--------
> +
> +linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1],
> +linkperf:perf-mem[1], linkperf:perf-c2c[1]
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> index 09f516f3fdfb..cbcc2e4d557e 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -82,7 +82,8 @@ linkperf:perf-stat[1], linkperf:perf-top[1],
>  linkperf:perf-record[1], linkperf:perf-report[1],
>  linkperf:perf-list[1]
>  
> -linkperf:perf-annotate[1],linkperf:perf-archive[1],linkperf:perf-arm-spe[1],
> +linkperf:perf-amd-ibs[1], linkperf:perf-annotate[1],
> +linkperf:perf-archive[1], linkperf:perf-arm-spe[1],
>  linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
>  linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
>  linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
> -- 
> 2.45.2
