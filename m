From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Re: Intel PEBS  Load Latency Measurement
Date: Mon, 28 Oct 2013 12:28:06 +0100
Message-ID: <526E4A46.2060003@insa-lyon.fr>
References: <52380863.4090606@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from criges14.insa-lyon.fr ([134.214.76.242]:60625 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab3J1Lpk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 28 Oct 2013 07:45:40 -0400
In-Reply-To: <52380863.4090606@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>, linux-perf-users@vger.kernel.org

Hi,

I am coming back on this subject after working on other stuff for 
several weeks. Andi pointed me to the userland tool 'perf mem' 
introduced in "recent" kernels (can't find the version) that is using 
the kernel perf_event_open system call to profile memory accesses.

I guess the answer to my question is in the code of this tool, but 
before stepping deeper inside it, I wanted to ask you (Linux perf 
experts) few questions, to be sure I am on the right track.

For now, I just configured a perf_event_attr to perform sampling of 
PERF_COUNT_HW_INSTRUCTIONS at a given period. Can you confirm than the 
sample_period means "the kernel will generate a sample (with fields 
asked through sample_type) every sample_period instructions ?

Then after calling the perf_event_open system call I mmap the file 
descriptor returned with an arbitrary size of X pages (with X = 1 + 2^n).

I then start recording events with ioctl on the file descriptor returned 
by perf_event_open. I am now wondering how to access the samples. My 
main concern is about the meaning of the data_head and data_tail fields 
of the metadata page located at the beginning of the memory mmaped. In 
understand that my samples are located just after this metadata page, 
and that these head and tail pointers are used to indicate where we are 
in the reading of the samples, is it correct ? While reading samples, 
should I use/modify these head and tail pointers, if yes what is the 
purpose of that ?

I am going now to look for the perf mem code, to try to understand that 
from my side, but I am interested in any hint on the subject that may 
help me.

Many thanks in advance for your help,

Manu

On 09/17/2013 09:44 AM, Manuel Selva wrote:
> Hi all,
>
> I am trying to use PMU on a 2 sockets workstation (2x Intel Xeon X5650
> currently running Linux 3.6.11) processor to identify memory controller
> unbalance.
>
> For this purpose I successfully used some uncore events to count the
> load on each memory controller through the perf_event_open system call.
> I am now planning to use Intel PEBS Load Latency Measurement to identify
> if these loads result in "unusual" long memory latencies.
>
> Looking at Vince Weaver web page discussing about kernel support for PMU
> here:
> http://web.eece.maine.edu/~vweaver/projects/perf_events/features.html I
> saw that the kernel 3.10 supports Load Latency Measurement.
> Unfortunately I can't find a man page describing how this works. Before
> looking at kernel sources, I wanted to ask here for confirmation about
> Load Latency Measurement in recent Linux kernels.
>
> Can anyone confirm that this functionality is available and usable ? Is
> the perf userland tool using it to provide the functionality to end users ?
>
> Thanks in advance for your help,
>
