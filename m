Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778669;
	b=2PsxNNN6dmcQqEl+BqmO4EspepPeCLR9wGwlCOAKabsDq9F9+4jYNOhMsXw2uqW4tROh
	 fLw2X6oc9Rp1jbadvhfeCXGuOhmzO611lBJNsEMiMm6syQeu/g/2twuKVTXgkCTnawWzv
	 HnaVZlDQkALjd8cTAnVhIQLdyAoOK8Peex/RijL2w+TtV/qjHuqQ6OEgL0vhFcov/t1X2
	 a17hpPmn3j7NG5LrfTPN5SdkplVjKKzzYGukYyYgPVszLtuzg55qcpexMprK7+sRkIPPQ
	 4hDsg+sdNfV4m0ANv2/BdMuFBJrKXCX5Ognvuu2PDs7tVMBeG1Og3ieecjdnxySh5GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778669;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=T9EauWO6cQ2WfpHoCweGwNuAL/bymTltRgB04eRJXrU=;
	b=ViylIpD0UZM1GLrMHPMqdYxOzZimsYevku97Y7UIkI7ciA7vmmMemlOSEArpVivEdBDv
	 Nk6PfrGjpHhL94ytxOPGdtAIJpTX+pf2vrMWT5X+VaeClOu2hyJSsoNf4bm6LWY6ax6xr
	 GfXZ4sYtAq+HwqTOOlW3/3w4U5EdCXgmPlkSIJQQbmveD4Lo+xfc+fN/JY578HQokScA0
	 ENI9oZa65dJ+l1Ut6v09jGdvk+C+IznXF3Q/M8Bs5wtcQvmtspPWNTiMc4Eermmo3aAcg
	 64GQ1f4L0v4GP3m/svfn/MibpF3pzmtT7xNYnue6TLeFQLaAyFwwujRV17QeDckgC3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="n/GcYhyF";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6798C606A31C;
	Fri, 27 Nov 2026 11:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6798C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n/GcYhyF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F85152B;
	Fri, 27 Nov 2026 03:24:25 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 568983F632;
	Fri, 27 Nov 2026 03:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795778668; bh=ElfG0zfwSKVhwzHS3lUakxTIG4KBhbx2STHreNU7ca4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/GcYhyFjXnGZ05+0HmsOhEouFkUBNZJZnREWcBBYEYuJ1UiwwsIFkQa2gz9QrcnK
	 2O96p/rgEtjPJhflYAbG1IAWB5NouXC2E+U1y7TiTuEY5GiY3sxYhB3bjL+KZkx5sL
	 MKcfLY+XRJyus9eAfxFYyw0sgV1FXh3NSITUHfsM=
Date: Fri, 27 Nov 2026 11:24:26 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, vladimir.murzin@arm.com,
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
Message-ID: <20261127112426.GC861809@e132581.arm.com>
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <CANk7y0ixo5a3Vfzj_HVhVHRNce2Rsit4pP27GCtXd4jHHzmiKg@mail.gmail.com>
 <CAEf4BzapC=7YM2QLMyKKfyOWGgBTfEJmPPN8e9Jf5xT9SutBTQ@mail.gmail.com>
 <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
 <CAEf4BzZ=ahQNtA-1KdZFRONXMOEkV9Nb1OUY==JRQCarkbMM0Q@mail.gmail.com>
 <5c7f4a5f-fe5e-4367-9c60-86f1818346e8@linaro.org>
 <20261126180214.GB809232@e132581.arm.com>
 <9a471409-04c2-4f6e-aec9-0b23bb9b69f0@linaro.org>
 <20261127111128.GB861809@e132581.arm.com>
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
In-Reply-To: <20261127111128.GB861809@e132581.arm.com>

On Fri, Nov 27, 2026 at 11:11:28AM +0000, Leo Yan wrote:

[...]

> > If any sampling BRBE event gets scheduled then the snapshots just start
> > skipping and returning empty.
> 
> BPF program can be attached to interrupt handlers (even it can be
> attached to PMU interrupt handler). As you suggested, we can use per-CPU
> flag to return an empty snapshot for the nested call.

I should have distinguished the two cases in my previous reply.

BRBE driver could return an empty snapshot if a sampling event is active
on the CPU. In free-running mode, a nested call could do the same while
another snapshot is in progress on that CPU.
