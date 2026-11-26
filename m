Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716137;
	b=LhplA5lXvBappZIUy0i9D3bgf4bDmRh9dhrdZvfSjaM3X/I5OaDJJ/j/K0vgGYwlNxdL
	 jtr6qy9UTgNyvaPAN4omWy+X0EpXtB6EsQP95DPYP/dBasoLdGOmG3hKqpr0tIAy4wTov
	 UrUpB6wUz0WmJoExUzzgf+hiW1GvRRDN4tkVF8H8le3uhvZy2v7bETns13pYOXVQ9v3CA
	 TnMXk4anFfqY96i/WZG2NrkLqdSnjAlVZ7N/z6186vJ+yxRkXRyuWEO9lFaKoOOJ0ODGU
	 JUCuMUelwsW9H0YjEEKGEAg0+PJ7a617zD/HCyMU53LNWFGoSCYNLHbgmF7k9nvj4aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716137;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EIBFveu7yYmEbvuiFTdZCk87YQ1EZPQ1DqdLI+hGjog=;
	b=UItHoj153Bvi5/OGHCiMUDzBVrGjzVm10W4cNQhXksp7wcU3ybUvflUXxD/QoeZhl5Ge
	 Djm5Z1w03jdza24yV0RxpgkxqAYoArNZQa3l29dkHKnH/1CIQM1U9FlgyCUCkAt+Je3/A
	 zB9THnPp0DvgCVDjh9oP8smMDu+ROjqsphhDAnzxG/uxzdn3vUNA/3/z9bI939SnOtl+4
	 M6La37/2W8qW26h9a1R/AD2VfHj8II0JqjnZM5ZKD6QeKyxgc4dyAIHM0PcEGiEVF6p6V
	 aJedrc18X5GAMDvsEUylEW/W73I39V4WrxSu6h07/f+pIQZoKgm2ze6OIo78R+t/FGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kEnZJDat;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F3606A31E;
	Thu, 26 Nov 2026 18:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kEnZJDat
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BE7E1BA8;
	Thu, 26 Nov 2026 10:02:13 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E78513F632;
	Thu, 26 Nov 2026 10:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795716136; bh=ek6pWiEzSoxsFDDVTU1wdcAfubRIURJGSjuHrb5FqjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEnZJDatTGHmsf3CzvHuDgAQ56PvD0PVRCks3UzHlNqJLRKPG9QI4ikwsTOvjY//O
	 yr0hUZn90UwjrAXiehDySwVhfIJ/hZ1omwRPqZ1vbSgtVWzuHv2lbBvnf6QOG9LcM8
	 kP0UZVtEqNMWMRBL5mMS+/Xf075VH9+Y4x0QyI3Y=
Date: Thu, 26 Nov 2026 18:02:14 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: vladimir.murzin@arm.com, Puranjay Mohan <puranjay12@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>, Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v6 0/3] arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Message-ID: <20261126180214.GB809232@e132581.arm.com>
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <CANk7y0ixo5a3Vfzj_HVhVHRNce2Rsit4pP27GCtXd4jHHzmiKg@mail.gmail.com>
 <CAEf4BzapC=7YM2QLMyKKfyOWGgBTfEJmPPN8e9Jf5xT9SutBTQ@mail.gmail.com>
 <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
 <CAEf4BzZ=ahQNtA-1KdZFRONXMOEkV9Nb1OUY==JRQCarkbMM0Q@mail.gmail.com>
 <5c7f4a5f-fe5e-4367-9c60-86f1818346e8@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7f4a5f-fe5e-4367-9c60-86f1818346e8@linaro.org>

On Thu, Nov 26, 2026 at 12:39:52PM +0000, James Clark wrote:

[...]

> > > > Mark, Will, you guys seems to be designated as maintainers for
> > > > drivers/perf/arm_brbe.c, can you please take a look and give your
> > > > feedback as well? This is important and useful feature for newer arm64
> > > > CPUs, it would be great to get access to this functionality that we
> > > > had on x86-64 side for a long while now. Please help get this upstream
> > > > or, if it's not in the right shape, guide Puranjay towards a better
> > > > implementation. Thank you!

...

> + Vladimir
> 
> Hi Mark, Will, Vladimir,
> 
> Any thoughts on this approach where NMIs need to be disabled? Alternatively
> we could do something like track where the PMU interrupts and BPF snapshots
> overlap and then discard the BRBE buffer and make sure they don't trample on
> each other etc, but it looks like it would be significantly more
> complicated.

Could we restrict bpf_get_branch_snapshot() on arm64 to a free-running
BRBE mode? On a given CPU, at least one active event would have to
request a branch stack, and every such event would have to be a
counting event.

This seems to fit in this series. The selftest opens a CPU-cycles event
with PERF_SAMPLE_BRANCH_STACK and sample_period = 0, then takes the
snapshot from an fexit program.

Counting events can still generate overflow interrupts for bookkeeping.
It requires to refactor the PMU driver to leave BRBCR_ELx.FZP clear so
an overflow doesn't freeze BRBE. The interrupt handler could service the
counters without touching BRBE and losing the branch records.

Thanks,
Leo
