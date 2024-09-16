Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0279CD;
	Tue, 17 Sep 2024 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726533278; cv=none; b=dldrW+JqwrWMKNbbwJJ0ilRyZfgXSJK3hu43x3qhQP20uSeTNb7ZdpL/bmKrgAVYH0TvXadIoCBh/VBPfO8R0BR/h3m93s4F3W3plGCDkF0fKaC4zWL5vGWbUeTXAvX2GmNRdn5HYqB5KQdFEXpk2dAleB4Q0CHXYBPzEFDcq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726533278; c=relaxed/simple;
	bh=Sr+Kyc75B0ipZ0/2iN96n2ESqpcNHWuJWcqTEjmW/b4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZcwrjN7hHT9zJ/BRnMhQoEUAYw6CK3qWnMNf/NpSPIXp5qDDmClcBdgCa3Uckm+evP0uOKwERxh0/OYchULzTsRgSSOMC1sRn5Gt0fN5izmI4dP/nmjtaSCD1SaVdM8CF5VOGSz+WLbAHCaxEVIcJaJ1SfugNtAFpVUHZoW03nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SRwbW1Lw; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SRwbW1Lw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1726533274;
	bh=Sr+Kyc75B0ipZ0/2iN96n2ESqpcNHWuJWcqTEjmW/b4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SRwbW1Lwu/7etfbjQkAmN0eVIZqXpVjEsorshRteH96ukYZmOqiQDxyTLkZXmk90c
	 Okft1IpWKERvR6XIVK6dx6r238JkjeyfD8TnIlty3hAlMVOGSbQJ8lc5Ys0oFlmL7Q
	 qnyghvU00WysUyy0pqg9LeMfRAne6uQZNgVQeCXVommmZjz0Phob9EgTsusS9HcPtw
	 d58IQx0jD7b2Fqh6pPS7IwcPfZ7HZYU+JrTZ43LzmiojMoZ3o/ctmfnXtuyCGmaFBR
	 6nn+eMp/gfcxpbmtqSGIrFoZrwz4jjv0hFBFGChAWHlHMZZeTN3xpQUFYYBN2EEvVF
	 kZKEOP2xIbjYQ==
Received: from [IPV6:2001:4bc9:a47:b4b6:50af:bb4c:5411:8fdd] (unknown [IPv6:2001:4bc9:a47:b4b6:50af:bb4c:5411:8fdd])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X72pt0nC2z1L91;
	Mon, 16 Sep 2024 20:34:29 -0400 (EDT)
Message-ID: <790edc54-97b9-462d-90e1-067662b561a9@efficios.com>
Date: Mon, 16 Sep 2024 02:33:47 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
 Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <20240914081246.1e07090c@rorschach.local.home>
 <20240915111111.taq3sb5xzqamhb7f@treble>
 <20240916140856.GB4723@noisy.programming.kicks-ass.net>
 <20240916153953.7fq5fmch5uqg7tjj@treble>
 <20240916181545.GD4723@noisy.programming.kicks-ass.net>
 <36f32c27-3cab-48ea-b8de-8df91b91836d@efficios.com>
Content-Language: en-US
In-Reply-To: <36f32c27-3cab-48ea-b8de-8df91b91836d@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-16 02:15, Mathieu Desnoyers wrote:
> On 2024-09-16 20:15, Peter Zijlstra wrote:
> [...]
>> The point being that it is possible to wrap one CPU into the id space of
>> another CPU. It is not trivial, but someone who wants to can make it
>> happen.
> 
> I agree that the overflow of the free-running counter bleeding into the
> CPU numbers is something we want to prevent. We don't care if this
> counter overflows after day/months/years for sake of correlation
> within a system call, but we do care about the fact that this
> free-running counter could be made to overflow after a very long
> time while the system runs, and then we reach a state where the
> CPU numbers are mixed up, which leads to short-term correlation
> issues.
> 
> I would recommend this layout for this 64-bit value instead:
> 
> low-bits: cpu number
> high-bits: free-running counter
> 
> This way, we eliminate any carry from overflow into the cpu number bits.

Even better: AFAIR from the discussion I had with Steven and Josh, we intend
to have the cookie stored to/read from the task struct with interrupts off,
we can simply do:

struct stackwalk_cookie {
	uint64_t counter;	/* free running per-cpu counter value */
	int cpu;		/* cpu on which the counter was snapshot. */
};

So we don't have to deal with any overflow trickiness, there is no need for
bit-shifting, and we get a full 64-bit free-running counter independently of
the number of CPUs.

Thanks,

Mathieu



> 
> Thanks,
> 
> Mathieu
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

