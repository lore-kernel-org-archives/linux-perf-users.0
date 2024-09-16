Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB97F6;
	Tue, 17 Sep 2024 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532157; cv=none; b=uISKWDBHDuaC2KgATG2pB/He2NwguW+9ks/vCHlc9XGq/sRNi7DYvIcFU8mAtQSFwDxA7NLvwm8YktwyTsehfc9GrLPwAS086S/jmFQkAoSi5fPTykXJ8lxtYJGbtRql75JTth/HV7oxLVkeM3ql+dTuXgfZ3TJCNsp+s06lHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532157; c=relaxed/simple;
	bh=IhvtUALtetb+5cT24mW7YoCgzIElp8a/SYC7XDM9vig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5WK3oV5g7MOIZyG3s1stPPWSDEnCFzn0NaX0usiq0+PQQUpqT0Oj20fKzppz7VBbCwPfzV5uhgbnPGNQlojOZmpOs/BfJIXZaeJyQrflBI6nSNpsV73kADvqtH8JzviJSTkM+Sg77hGKhkvO06wuefolGDdZs2X8wirbFdl7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=r7759Aev; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="r7759Aev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1726532148;
	bh=IhvtUALtetb+5cT24mW7YoCgzIElp8a/SYC7XDM9vig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r7759AevHHC0Ecw4RZqh7CR74QJIPQZotaIAg5T8yKtU3NN2wmjDsXlSlNpe30anD
	 nuYPdfne06v3q8OmxOqRasH+i2888f0UUBgzQnE+H2xWCLhgJ8BuQoqPJ1REk0txcb
	 kTeOepUGtOfaNl8v7Nm01Tq3WqYEfWcE9IpTBV3swPqWCYmuzOSaUt2dFfPl0caNJp
	 6PunyLGhHpR4cHBZdD7h/FQGN/YUKjBzzujtTJ/tJdCJE0YcjZAfUu8HwGYGlHYkS9
	 +Bjet4sxgogNUOzVJmF4KjDPVoA0LvqPV//Exb4DHtNO/04JJ4Hrh/oz+6U4C3gqz1
	 dSrikSHen0f1Q==
Received: from [IPV6:2001:4bc9:a47:b4b6:50af:bb4c:5411:8fdd] (unknown [IPv6:2001:4bc9:a47:b4b6:50af:bb4c:5411:8fdd])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X72PD2KDMz1LTd;
	Mon, 16 Sep 2024 20:15:44 -0400 (EDT)
Message-ID: <36f32c27-3cab-48ea-b8de-8df91b91836d@efficios.com>
Date: Mon, 16 Sep 2024 02:15:01 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240916181545.GD4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-16 20:15, Peter Zijlstra wrote:
[...]
> The point being that it is possible to wrap one CPU into the id space of
> another CPU. It is not trivial, but someone who wants to can make it
> happen.

I agree that the overflow of the free-running counter bleeding into the
CPU numbers is something we want to prevent. We don't care if this
counter overflows after day/months/years for sake of correlation
within a system call, but we do care about the fact that this
free-running counter could be made to overflow after a very long
time while the system runs, and then we reach a state where the
CPU numbers are mixed up, which leads to short-term correlation
issues.

I would recommend this layout for this 64-bit value instead:

low-bits: cpu number
high-bits: free-running counter

This way, we eliminate any carry from overflow into the cpu number bits.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

