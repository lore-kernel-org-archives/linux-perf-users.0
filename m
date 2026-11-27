Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777892;
	b=jG9/GpBTYJfnNtPDe3+bR4I24rFKxuhPzVQ5ZCaai4lTa2GmtomqPXL/FXTgQgO3r1ll
	 ImDkoq7UkPlhpbU2M6xoX85+dx8nIghu1GAHt1wxv00Ph++tzDv3+UhN45Y55MULR6PAl
	 6uGxkOjNKruSWsKIr1ob8tcy9NWoJoKlrGMtOfsMeVR+2zycAthGA5nNWY+Kc9XcnEt7f
	 yC1OmViVn62yN2XgUUvMj5D2DhJ5LuOd7KrMHtH8kynrClu7VGbgh6yEeXE28G1hatL5e
	 uMOrjGkc8/CNDNFxArlYsq5FNyILJcg86o1rPvMZN3k7gyvfAumTX4e7SSWIfQt8qxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777892;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ntucoBJTEaHY4nS4xGinqu4auOiGQOC/h2sxnNGH6F0=;
	b=msMWKM0KqPzfREZDWr3FzjMKSf3jho7ZbYzbZ9GlURV7cPBNHTK4dfntuJrRzRmO38J7
	 sEVduC8QAJb9h8qWDinvXHUTHgXOjIVV6oebMXiTlMm/mnmt3h9M/A/pc3ueujzpjnYb7
	 clul987Jalupy2je3yXBILFxFskEGq3yVEaURFCZnRdQAOsKemhWHzlwbrKfa5TTMeT6d
	 HUQXmxmsHBXBBTJTqxK0qw/Z89HP8+TC6HwJZhRIK2t9kNyT2mLj7xCVB0Bf+Yri5tWk1
	 e0zk8Ujl5v0afESuLt/qwOUiFkVqksb4Ud8LC0E43SAmF/d3qoHV92kGhghgT8OM1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XAubkvTI;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E791B606A336;
	Fri, 27 Nov 2026 11:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E791B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XAubkvTI
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 033EC1756;
	Fri, 27 Nov 2026 03:11:28 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FD1F3F632;
	Fri, 27 Nov 2026 03:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795777890; bh=ntucoBJTEaHY4nS4xGinqu4auOiGQOC/h2sxnNGH6F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAubkvTIvWQmtGwwh0Lui5Pw4zp9veJEvuEOcvujRLkNv++5qc6SoWo/GW5AlSQl6
	 PgIau2CJndplgHI3uAEWKBwn7RGP6JWE+1RW9hDpLE9y06g/euKPpYtIfRzAut7vKE
	 pfJILfoOkaWjEC5EtOAXJ6zpZlfQxguXEus0BLvo=
Date: Fri, 27 Nov 2026 11:11:28 +0000
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
Message-ID: <20261127111128.GB861809@e132581.arm.com>
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <CANk7y0ixo5a3Vfzj_HVhVHRNce2Rsit4pP27GCtXd4jHHzmiKg@mail.gmail.com>
 <CAEf4BzapC=7YM2QLMyKKfyOWGgBTfEJmPPN8e9Jf5xT9SutBTQ@mail.gmail.com>
 <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
 <CAEf4BzZ=ahQNtA-1KdZFRONXMOEkV9Nb1OUY==JRQCarkbMM0Q@mail.gmail.com>
 <5c7f4a5f-fe5e-4367-9c60-86f1818346e8@linaro.org>
 <20261126180214.GB809232@e132581.arm.com>
 <9a471409-04c2-4f6e-aec9-0b23bb9b69f0@linaro.org>
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
In-Reply-To: <9a471409-04c2-4f6e-aec9-0b23bb9b69f0@linaro.org>

On Fri, Nov 27, 2026 at 10:56:27AM +0000, James Clark wrote:

> > Could we restrict bpf_get_branch_snapshot() on arm64 to a free-running
> > BRBE mode? On a given CPU, at least one active event would have to
> > request a branch stack, and every such event would have to be a
> > counting event.

> Yeah I think this is a pretty good idea. It looks like it would avoid having
> to disable NMIs. You only need a local_irq_save() to avoid new events from
> reconfiguring BRBE while taking a snapshot, and you don't have to disable
> the PMU counters either.

I'd like to avoid local_irq_save() if we can protect BRBE snapshot
reentry in another way.

> If any sampling BRBE event gets scheduled then the snapshots just start
> skipping and returning empty.

BPF program can be attached to interrupt handlers (even it can be
attached to PMU interrupt handler). As you suggested, we can use per-CPU
flag to return an empty snapshot for the nested call.

Thanks,
Leo
