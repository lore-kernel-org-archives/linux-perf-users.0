From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
Date: Thu, 10 May 2018 13:29:28 +0300
Message-ID: <6be7739b-8c6c-bbd8-6866-a26d8d25266d@linux.intel.com>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net>
 <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com>
 <20180510101406.GA12217@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510101406.GA12217@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hi,

On 10.05.2018 13:14, Peter Zijlstra wrote:
> On Thu, May 10, 2018 at 12:42:38PM +0300, Alexey Budankov wrote:
>>> The Changelog needs to state that user_regs->bp is in fact valid and
>>
>> That actually was tested on binaries compiled without and with BP exposed 
>> and in the latter case proved the value of that change.
> 
> Mostly works is not the same as 'always initialized', if there are entry
> paths that do not store that register, then using the value might leak
> values from the kernel stack, which would be bad.

Yep, absolutely agree. Extra care needs to be taken here.

> 
> But like said, I think much of the kernel entry code was sanitized with
> the PTI effort and I suspect things are in fact fine now, but lets wait
> for Andy to confirm.
> 

Thanks,
Alexey
