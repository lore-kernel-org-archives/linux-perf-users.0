Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C113792B;
	Wed, 18 Sep 2024 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726636509; cv=none; b=toYAI3Q/adUMmPkybemUsHUFaomrWq/N4dqpwQfMiUvOP4OUb8JtTDGv1UDV4chK8xA+O/ETSbW54U/DF8KS5ayiCyH5W/EqIsJyKjb17fq6S1q2p2nUEiy+7Rokw69kkt0PKT5LZyfeknI5riubyUnf87GB+hwbTRJGqBLyd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726636509; c=relaxed/simple;
	bh=awBMI1Dk7zdadkzIRUyRmARSK8r8NR+KUbSGpfJNcIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ+cacbTWXf9W0FQU6aiMsjRN/a1d4cQrMsIg8sdDQcvYMeB9HzpQnnG4cIC2si5+LYNwcqPkrDdEiVukDlXLVpRiLzoIUpn9e5yqHzPllnpBFKW9bKLKtXd5afPEKQavDXtrIXr+ew707qp4Upm8tWqv1pdn6f5lu2Svp/y+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Jzu4Gel7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Jzu4Gel7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1726636498;
	bh=awBMI1Dk7zdadkzIRUyRmARSK8r8NR+KUbSGpfJNcIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jzu4Gel7FH7csyCRZgWVUdadv5Zez1/9ITJjgN8lv0eYz16McVW0OmPNcFKppDFtD
	 rgJb51tpnRrClksGsHxXcL/na33zylIbjbSPBDOPY1+yNDdN6gbcMJ0CRROxCEJu9g
	 XXBrVW8KXPAASB1OBGplAboNisNVDzvonmhzsG3aBFgQTgEqC4mpJsRs3UjVO/HzPX
	 oqguW7labm2OMKybpE/RJ8LJQ7gdlbH8TM+SPAKAexURsinQjdC3BfB5vHasQqef4H
	 2aYr7RWYJCPKOv1xbuqaRBgUcXEH5KJJajIasBtao4Le7N3un4ZI1bFuJJWy1wZ/yc
	 HQhvNzIBItBKg==
Received: from [192.168.42.112] (213142097191.public.telering.at [213.142.97.191])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X7mzw6pjGz1L4b;
	Wed, 18 Sep 2024 01:14:52 -0400 (EDT)
Message-ID: <8e329554-0042-4265-8247-180f4e87dfe3@efficios.com>
Date: Wed, 18 Sep 2024 07:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
To: Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <20240914081246.1e07090c@rorschach.local.home>
 <20240915111111.taq3sb5xzqamhb7f@treble>
 <20240916140856.GB4723@noisy.programming.kicks-ass.net>
 <20240916153953.7fq5fmch5uqg7tjj@treble>
 <20240916181545.GD4723@noisy.programming.kicks-ass.net>
 <20240916184645.142face1@rorschach.local.home> <Zun7nKFzWz2J2rSz@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Zun7nKFzWz2J2rSz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-17 23:58, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Sep 16, 2024 at 06:46:45PM -0400, Steven Rostedt wrote:
>> On Mon, 16 Sep 2024 20:15:45 +0200
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Mon, Sep 16, 2024 at 05:39:53PM +0200, Josh Poimboeuf wrote:
>>>
>>>> The cookie is incremented once per entry from userspace, when needed.
>>>>
>>>> It's a unique id used by the tracers which is emitted with both kernel
>>>> and user stacktrace samples so the userspace tool can stitch them back
>>>> together.  Even if you have multiple tracers triggering at the same time
>>>> they can all share a single user trace.
>>>
>>> But perf don't need this at all, right? It knows that the next deferred
>>> trace for that tid will be the one.
> 
> Well.. technically you can sample without tid.  But I'm not sure how
> much it'd be useful if you collect callchains without tid.
> 
>>
>> Is that because perf uses per task buffers? Will perf know this if it
>> uses a global buffer? What does perf do with "-a"?
> 
> Then it'd use per-cpu ring buffers.  But each sample would have pid/tid
> pair and time so perf tools can match it with a deferred callchian.

That semantic correlation based on trace information should work fine if
you do not miss important events in the trace. What the unique id cookie
provides is robustness against confusion that can arise when events are
discarded.

Discarded events happen when the event throughput is too high for the
ring buffer to handle. The following type of confusion can then arise:

- If you miss a stack trace event and then a stack-sample-request
event, then the post-processing tools can incorrectly infer causality
between a prior stack-sample-request and a following stack trace for
the same tid.

- If you miss even more information about the end/beginning of lifetime
of two threads, post-processing can be confused and associate a prior
stack-sample-request from tid=N with a later stack trace for tid=N where
N was re-used due to an exit/clone sequence.

Saving the unique id cookie along with the stack-sample-request and with
the stack trace allows more robust causality relationship between the
two. Showing reliable causality information may not be super important
for profiling use-cases, but it is important for event tracers.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

