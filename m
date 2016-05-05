From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Misleading hint to select CONFIG_PERF_EVENTS if driver sets
 PERF_PMU_CAP_NO_INTERRUPT
Date: Thu, 5 May 2016 18:51:09 +0530
Message-ID: <572B48C5.6090401@synopsys.com>
References: <1461331523.3403.11.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E9F42D@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E9F42D@us01wembx1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Lada Trimasova <Lada.Trimasova@synopsys.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Vince Weaver <vincent.weaver@maine.edu>, Will Deacon <Will.Deacon@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Tuesday 26 April 2016 06:12 PM, Vineet Gupta wrote:
> On Friday 22 April 2016 06:56 PM, Lada Trimasova wrote:
>> I have a question about user-space perf handling error numbers.
>> The problem is that PMU interrupts are not supported in arc700
>> architecture and it is impossible to evaluate `perf record` command.
>> In our perf implementation we set PERF_PMU_CAP_NO_INTERRUPT flag so
>> core perf infrastructure knows we don't have interrupts.
>>
>> Kernel `sys_perf_event_open` handler checks if PMU interrupts are
>> supported and returns ENOTSUPP (524) error code.
>> I'd expect that perf implementation checks the return value of syscalls
>> and gives the user understandable error message.
>> But now I see:
>> --------------------------------->8-----------------------------------
>> # perf record ls
>> The sys_perf_event_open() syscall returned with 524 (Unknown error 524)
>> for event (cycles:ppp).
>> /bin/dmesg may provide additional information.
>> No CONFIG_PERF_EVENTS=y kernel support configured?
>> --------------------------------->8-----------------------------------

Guys, is the ABI change for returning -EOPNOTSUPP vs. -ENOTSUPP for
is_sampling_event() && (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
acceptable ? We could use this in userspace to print pretty rather than half
cooked error msg above !

-Vineet
