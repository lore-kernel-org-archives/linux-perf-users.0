From: Manuel Selva <selva.manuel@gmail.com>
Subject: Fwd: Intel PEBS Load Latency Measurement
Date: Tue, 29 Oct 2013 10:12:39 +0100
Message-ID: <CALbiyZyOUYL3dKo_OaXK6SMXmMBF3N47gGv0MAjRirsFzyPDMw@mail.gmail.com>
References: <52380863.4090606@insa-lyon.fr>
	<526E4A46.2060003@insa-lyon.fr>
	<87r4b47qgv.fsf@sejong.aot.lge.com>
	<CALbiyZy_JE+wai7d_=r-XzE+FdHRitTiAuPmANtRt7Qpet8fTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:56721 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3J2JMl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Oct 2013 05:12:41 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so3870897lbj.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2013 02:12:39 -0700 (PDT)
In-Reply-To: <CALbiyZy_JE+wai7d_=r-XzE+FdHRitTiAuPmANtRt7Qpet8fTg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org

Hi Namhyung,

Many thanks for your answer and the function you pointed. I think I
now have all the required understanding of the perf_event_open syscall
to do what I want.

I still have two questions regarding Intel (I am on a Westmere-Ep Xeon
X5650) Load latency feature and its usage by the perf mem tool.

1- In the Intel software developer guide we can read: "load operations
are randomly selected by hardware and tagged to carry information
related to data source locality and latency" I am wondering what does
it mean, are we doing sampling at two different levels ? First the
hardware chooses some load instructions to tag, and then each time X
(sampling period in events count specified by software) such tagged
instructions with a latency greater than a software specify threshold
we record a sample with some information. What is the sampling rate of
the hardware tagging mechanism, is it enough to get some interesting
results ?

2- How does the perf mem tool (with the load option) with of course
the help of the kernel uses this feature ? After a quick browsing of
the code, here is my understanding, is it correct ?
The PEBS load latency feature is enabled with the minimal possible
latency (3 cycles) to do sampling on all loads and with a given
default sampling period (x tagged load events with latency greater or
equal to 3). In addition to these "loads events" the perf mem tool
asks the kernel to record events about processes naming, and memory
mappings of code to be able to retrieve offline the source code
associated to instruction pointers present in samples.

Thanks again for your help,

Manu


2013/10/29 Namhyung Kim <namhyung@kernel.org>
>
> Hi Manuel,
>
> On Mon, 28 Oct 2013 12:28:06 +0100, Manuel Selva wrote:
> > Hi,
> >
> > I am coming back on this subject after working on other stuff for
> > several weeks. Andi pointed me to the userland tool 'perf mem'
> > introduced in "recent" kernels (can't find the version) that is using
> > the kernel perf_event_open system call to profile memory accesses.
> >
> > I guess the answer to my question is in the code of this tool, but
> > before stepping deeper inside it, I wanted to ask you (Linux perf
> > experts) few questions, to be sure I am on the right track.
> >
> > For now, I just configured a perf_event_attr to perform sampling of
> > PERF_COUNT_HW_INSTRUCTIONS at a given period. Can you confirm than the
> > sample_period means "the kernel will generate a sample (with fields
> > asked through sample_type) every sample_period instructions ?
>
> Yes.
>
> >
> > Then after calling the perf_event_open system call I mmap the file
> > descriptor returned with an arbitrary size of X pages (with X = 1 +
> > 2^n).
> >
> > I then start recording events with ioctl on the file descriptor
> > returned by perf_event_open. I am now wondering how to access the
> > samples. My main concern is about the meaning of the data_head and
> > data_tail fields of the metadata page located at the beginning of the
> > memory mmaped. In understand that my samples are located just after
> > this metadata page, and that these head and tail pointers are used to
> > indicate where we are in the reading of the samples, is it correct ?
>
> Correct.
>
>
> > While reading samples, should I use/modify these head and tail
> > pointers, if yes what is the purpose of that ?
>
> The head is updated by kernel, you only need to update the tail after
> reading.  Please see perf_record__mmap_read().
>
> >
> > I am going now to look for the perf mem code, to try to understand
> > that from my side, but I am interested in any hint on the subject that
> > may help me.
> >
> > Many thanks in advance for your help,
>
> Hope this helps,
> Namhyung
