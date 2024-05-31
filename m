Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A771514F9;
	Fri, 31 May 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160478; cv=none; b=bEudeLLHWKfDEC95wfU5q/oxzeewKPp3ci8zoBLDxq3GzI+o2/V746X7Kh3T9vvXeU+aoMl5jBhlJUyi7+Gra1BZfvxP+rIsunEjghSsFZf1wlUdDh0hDxChvZh4lqBebOKvYjxcarnbArNNHwD2mh86Ddr0oTtUvFYHv0uuX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160478; c=relaxed/simple;
	bh=IiatJjNSX8aG/XsQs+Kv9rtPLVrUQt7xmhSQdhiZdis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYlO0xD2GCzYfVnRvrTbrKSy+8AY7VynHCC9SOEiHm0+1o2aKdGDpak4VdaqJL/LlWhf87+NX7oHTObDjXIx8PZSmE2Yaifx2LgmrvmxfvSDlSn37TKHB1jGT+ZaezjcGjrg2+wIEQo5smOOtGvw734P9lMV+ur19Hwv7eVnjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47FA11424;
	Fri, 31 May 2024 06:01:40 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B9013F641;
	Fri, 31 May 2024 06:01:13 -0700 (PDT)
Date: Fri, 31 May 2024 14:01:08 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH V17 0/9] arm64/perf: Enable branch stack sampling
Message-ID: <ZlnKFFwv9612V81h@J2N7QTR9R3>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <80d33844-bdd2-4fee-81dd-9cd37c63d42c@arm.com>
 <Zli6Ot0TwK3Qy-ee@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zli6Ot0TwK3Qy-ee@J2N7QTR9R3>

On Thu, May 30, 2024 at 06:41:14PM +0100, Mark Rutland wrote:
> On Thu, May 30, 2024 at 10:47:34AM +0100, James Clark wrote:
> > On 05/04/2024 03:46, Anshuman Khandual wrote:
> > > ------------------ Possible 'branch_sample_type' Mismatch -----------------
> > > 
> > > Branch stack sampling attributes 'event->attr.branch_sample_type' generally
> > > remain the same for all the events during a perf record session.
> > > 
> > > $perf record -e <event_1> -e <event_2> -j <branch_filters> [workload]
> > > 
> > > event_1->attr.branch_sample_type == event_2->attr.branch_sample_type
> > > 
> > > This 'branch_sample_type' is used to configure the BRBE hardware, when both
> > > events i.e <event_1> and <event_2> get scheduled on a given PMU. But during
> > > PMU HW event's privilege filter inheritance, 'branch_sample_type' does not
> > > remain the same for all events. Let's consider the following example
> > > 
> > > $perf record -e cycles:u -e instructions:k -j any,save_type ls
> > > 
> > > cycles->attr.branch_sample_type != instructions->attr.branch_sample_type
> > > 
> > > Because cycles event inherits PERF_SAMPLE_BRANCH_USER and instruction event
> > > inherits PERF_SAMPLE_BRANCH_KERNEL. The proposed solution here configures
> > > BRBE hardware with 'branch_sample_type' from last event to be added in the
> > > PMU and hence captured branch records only get passed on to matching events
> > > during a PMU interrupt.
> > > 
> > 
> > Hi Anshuman,
> > 
> > Surely because of this example we should merge? At least we have to try
> > to make the most common basic command lines work. Unless we expect all
> > tools to know whether the branch buffer is shared between PMUs on each
> > architecture or not. The driver knows though, so can merge the settings
> > because it all has to go into one BRBE.
> 
> The difficulty here is that these are opened as independent events (not
> in the same event group), and so from the driver's PoV, this is no
> different two two users independently doing:
> 
> 	perf record -e event:u -j any,save_type -p ${SOME_PID}
> 
> 	perf record -e event:k -j any,save_type -p ${SOME_PID}
> 
> .. where either would be surprised to get the merged result.

I took a look at how x86 handles this, and it looks like they may have the
problem we'd like to avoid. AFAICT, intel_pmu_lbr_add() blats cpuc->br_sel with
the branch selection of the last event added, and 

So I took a look at what happens on my x86-64 desktop running v5.10.0-9-amd64
from Debian 11.

Running the following program:

| int main (int argc, char *argv[])
| {
|         for (;;) {
|                 asm volatile("" ::: "memory");
|         }
| 
|         return 0;
| }	

I set /proc/sys/kernel/perf_event_paranoid to 2 and started two independent
perf sessions:

	perf record -e cycles:u -j any -o perf-user.data -p 1320224

	sudo perf record -e cycles:k -j any -o perf-kernel.data -p 1320224

... after ~10 seconds, I killed both sessions with ^C.

When i susbsequently do 'perf report -i perf-kernel.data, I see:

| Samples: 295  of event 'cycles:k', Event count (approx.): 295
| Overhead  Command  Source Shared Object  Source Symbol               Target Symbol  Basic Block Cycles
|   99.66%  loop     loop                  [k] main                    [k] main       -
|    0.34%  loop     [kernel.kallsyms]     [k] native_irq_return_iret  [k] main       -

... where the user symbols are surprising.

Similarly for 'perf report -i perf-user.data', I see:

| Samples: 198K of event 'cycles:u', Event count (approx.): 198739
| Overhead  Command  Source Shared Object  Source Symbol           Target Symbol           Basic Block Cycles
|   99.99%  loop     loop                  [.] main                [.] main                -
|    0.00%  loop     [unknown]             [.] 0xffffffff87801007  [.] main                -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e05626  [.] 0xffffffff86e05629  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e0563d  [.] 0xffffffff86e0c850  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e0c86f  [.] 0xffffffff86e6b3f0  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e0c884  [.] 0xffffffff86e11ed0  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e0c88a  [.] 0xffffffff86e13850  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e11eee  [.] 0xffffffff86e0c889  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e13885  [.] 0xffffffff86e13888  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e13889  [.] 0xffffffff86e138a1  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e138a9  [.] 0xffffffff86e6b320  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e138c3  [.] 0xffffffff86e6b3f0  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e6b33a  [.] 0xffffffff86e138ae  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86e6b3fb  [.] 0xffffffff86e0c874  -
|    0.00%  loop     [unknown]             [.] 0xffffffff86ff6c91  [.] 0xffffffff87a01ca0  -
|    0.00%  loop     [unknown]             [.] 0xffffffff87a01ca0  [.] 0xffffffff87a01ca5  -
|    0.00%  loop     [unknown]             [.] 0xffffffff87a01ca5  [.] 0xffffffff87a01cb1  -
|    0.00%  loop     [unknown]             [.] 0xffffffff87a01cb5  [.] 0xffffffff86e05600  -

Where the unknown (kernel!) samples are surprising.

Peter, do you have any opinion on this?

My thinking is that the "last scheduled event branch selection wins"
isn't the behaviour we actually want, and either:

(a) Conflicting events shouldn't be scheduled concurrently (e.g. treat
    that like running out of counters).

(b) The HW filters should be configured to allow anything permited by
    any of the events, and SW filtering should remove the unexpected
    records on a per-event basis.

... but I imagine (b) is hard maybe? I don't know if LBR tells you which
CPU mode the src/dst were in.

Mark.
