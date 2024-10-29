Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A0196D9D;
	Tue, 29 Oct 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224188; cv=none; b=Gz8Ip4OMTC6Flx5HAJGC3AxLycqvIeCoRX2wF49ufDrSKQ1+kNODeNv1X1B9tGzTzXzG4zwGr5GH0lz30Ovyi+kXa7CQFmVrts6dYQ/s8K3bVICNpCPkWmRDXCkKpN1H23xoiFcJpmaz0NwmS3tiChGTiwxdPMuIRrguVGcC94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224188; c=relaxed/simple;
	bh=pCP6F22tvxZvOWh5+5TuquBz9CFZUn5EBro1iIOV/jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKORUOvNykhgGPzVHDGKkx0CNcUJABilMiutVaPM4b3H1OIv8IOyLcSrDdVtVDRMcFZLv8AAvzNyvL0mTaz4TPSVRqmKS8dhSt6b4jO0qQwnTeyFB6Olo/RhijA4mSkpNH6r4INuYNDZAix4xpP9fX/ndDi7NIvhezCaymuqf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DHTO3wKp; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DHTO3wKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730224178;
	bh=pCP6F22tvxZvOWh5+5TuquBz9CFZUn5EBro1iIOV/jM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DHTO3wKpMyFkzyj1slQsywEGxFO7vENCZNeRQvxQAGbwqAXjSjYBQ0YUgZDKGYuLv
	 oQBp3+xr3FPLtI7I6sLrUuYi/S908UnwNuLw6YOtz1yNhWS2zIRfrlr3dvKhDiNbm3
	 AvOnqkLP8s8tqFJXMx2jH5RMMqdgt59w/CEufKlvf1odZD909gpeZMFx+q/mjCBJG8
	 oHZ5wmbBaCc5Tlm7R7s2W2/HVX6ZW07M+PSKwODVpBcxbC0KkVVRHD1pIDg88Ux/bK
	 uACboB6x2FU4z3kraJDMEqu48/mzNeU0xGa4LenQCJ4AJQ0rPkMs+2TLOw5L5Y+YRq
	 R0f9jtVhjbBAw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XdHns74T4z166T;
	Tue, 29 Oct 2024 13:49:37 -0400 (EDT)
Message-ID: <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
Date: Tue, 29 Oct 2024 13:47:59 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
 <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-29 13:17, Josh Poimboeuf wrote:
> On Tue, Oct 29, 2024 at 02:56:17PM +0100, Peter Zijlstra wrote:
>> On Mon, Oct 28, 2024 at 02:47:38PM -0700, Josh Poimboeuf wrote:
>>
>>> + * The only exception is when the task has migrated to another CPU, *and* this
>>> + * is called while the task work is running (or has already run).  Then a new
>>> + * cookie will be generated and the callback will be called again for the new
>>> + * cookie.
>>
>> So that's a bit crap. The user stack won't change for having been
>> migrated.
>>
>> So perf can readily use the full u64 cookie value as a sequence number,
>> since the whole perf record will already have the TID of the task in.
>> Mixing in this CPU number for no good reason and causing trouble like
>> this just doesn't make sense to me.
>>
>> If ftrace needs brain damage like this, can't we push this to the user?
>>
>> That is, do away with the per-cpu sequence crap, and add a per-task
>> counter that is incremented for every return-to-userspace.
> 
> That would definitely make things easier for me, though IIRC Steven and
> Mathieu had some concerns about TID wrapping over days/months/years.
> 
> With that mindset I suppose the per-CPU counter could also wrap, though
> that could be mitigated by making the cookie a struct with more bits.
> 

AFAIR, the scheme we discussed in Prague was different than the
implementation here.

We discussed having a free-running counter per-cpu, and combining it
with the cpu number as top (or low) bits, to effectively make a 64-bit
value that is unique across the entire system, but without requiring a
global counter with its associated cache line bouncing.

Here is part where the implementation here differs from our discussion:
I recall we discussed keeping a snapshot of the counter value within
the task struct of the thread. So we only snapshot the per-cpu value
on first use after entering the kernel, and after that we use the same
per-cpu value snapshot (from task struct) up until return to userspace.
We clear the task struct cookie snapshot on return to userspace.

This way, even if the thread is migrated during the system call, the
cookie value does not change: it simply depends on the point where it
was first snapshotted (either before or after migration). From that
point until return to userspace, we just use the per-thread snapshot
value.

This should allow us to keep a global cookie semantic (no need to
tie this to tracer-specific knowledge about current TID), without the
migration corner cases discussed in the comment above.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

