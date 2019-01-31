From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Thu, 31 Jan 2019 13:28:34 +0530
Message-ID: <33d300b5-f8b0-4987-4d4c-b5175b6b6c60@linux.ibm.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190125160056.GG6118@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125160056.GG6118@tassilo.jf.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Andi,

On 1/25/19 9:30 PM, Andi Kleen wrote:
>> [Fri Jan 25 10:28:53 2019] perf: interrupt took too long (2501 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
>> [Fri Jan 25 10:29:08 2019] perf: interrupt took too long (3136 > 3126), lowering kernel.perf_event_max_sample_rate to 63750
>> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (4140 > 3920), lowering kernel.perf_event_max_sample_rate to 48250
>> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (5231 > 5175), lowering kernel.perf_event_max_sample_rate to 38000
>> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (6736 > 6538), lowering kernel.perf_event_max_sample_rate to 29500
> 
> These are fairly normal.

I understand that throttling mechanism is designed exactly to do this.
But I've observed that, everytime I run the fuzzer, max_sample_rates is
been throttled down to 250 (which is CONFIG_HZ I guess). Doesn't this
mean the interrupt time is somehow increasing gradually? Is that fine?

Here is the sample dmesg:

[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (2928 > 2500), lowering kernel.perf_event_max_sample_rate to 68250
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (4363 > 3660), lowering kernel.perf_event_max_sample_rate to 45750
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 2.183 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (21382 > 5453), lowering kernel.perf_event_max_sample_rate to 9250
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (34548 > 26727), lowering kernel.perf_event_max_sample_rate to 5750
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 3.509 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (61682 > 43185), lowering kernel.perf_event_max_sample_rate to 3000
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 3.593 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (89206 > 77102), lowering kernel.perf_event_max_sample_rate to 2000
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 3.619 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (120188 > 111507), lowering kernel.perf_event_max_sample_rate to 1500
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 3.782 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (171065 > 150235), lowering kernel.perf_event_max_sample_rate to 1000
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 4.066 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (226815 > 213831), lowering kernel.perf_event_max_sample_rate to 750
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 5.364 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (300844 > 283518), lowering kernel.perf_event_max_sample_rate to 500
[Thu Jan 31 09:33:43 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 6.136 msecs
[Thu Jan 31 09:50:35 2019] perf: interrupt took too long (378352 > 376055), lowering kernel.perf_event_max_sample_rate to 500
[Thu Jan 31 09:53:47 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 6.456 msecs
[Thu Jan 31 09:57:31 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 11.002 msecs
[Thu Jan 31 10:01:30 2019] perf: interrupt took too long (478447 > 472940), lowering kernel.perf_event_max_sample_rate to 250
[Thu Jan 31 12:28:31 2019] perf: interrupt took too long (601630 > 598058), lowering kernel.perf_event_max_sample_rate to 250
[Thu Jan 31 12:28:31 2019] perf: interrupt took too long (754288 > 752037), lowering kernel.perf_event_max_sample_rate to 250
[Thu Jan 31 12:43:13 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 12.781 msecs
[Thu Jan 31 12:43:13 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 13.583 msecs

Thanks,
Ravi
