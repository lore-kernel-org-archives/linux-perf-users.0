From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Intel PEBS  Load Latency Measurement
Date: Tue, 29 Oct 2013 11:36:48 +0900
Message-ID: <87r4b47qgv.fsf@sejong.aot.lge.com>
References: <52380863.4090606@insa-lyon.fr> <526E4A46.2060003@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:58411 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab3J2Cgv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 28 Oct 2013 22:36:51 -0400
In-Reply-To: <526E4A46.2060003@insa-lyon.fr> (Manuel Selva's message of "Mon,
	28 Oct 2013 12:28:06 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: Manuel Selva <selva.manuel@gmail.com>, linux-perf-users@vger.kernel.org

Hi Manuel,

On Mon, 28 Oct 2013 12:28:06 +0100, Manuel Selva wrote:
> Hi,
>
> I am coming back on this subject after working on other stuff for
> several weeks. Andi pointed me to the userland tool 'perf mem'
> introduced in "recent" kernels (can't find the version) that is using
> the kernel perf_event_open system call to profile memory accesses.
>
> I guess the answer to my question is in the code of this tool, but
> before stepping deeper inside it, I wanted to ask you (Linux perf
> experts) few questions, to be sure I am on the right track.
>
> For now, I just configured a perf_event_attr to perform sampling of
> PERF_COUNT_HW_INSTRUCTIONS at a given period. Can you confirm than the
> sample_period means "the kernel will generate a sample (with fields
> asked through sample_type) every sample_period instructions ?

Yes.

>
> Then after calling the perf_event_open system call I mmap the file
> descriptor returned with an arbitrary size of X pages (with X = 1 +
> 2^n).
>
> I then start recording events with ioctl on the file descriptor
> returned by perf_event_open. I am now wondering how to access the
> samples. My main concern is about the meaning of the data_head and
> data_tail fields of the metadata page located at the beginning of the
> memory mmaped. In understand that my samples are located just after
> this metadata page, and that these head and tail pointers are used to
> indicate where we are in the reading of the samples, is it correct ?

Correct.


> While reading samples, should I use/modify these head and tail
> pointers, if yes what is the purpose of that ?

The head is updated by kernel, you only need to update the tail after
reading.  Please see perf_record__mmap_read().

>
> I am going now to look for the perf mem code, to try to understand
> that from my side, but I am interested in any hint on the subject that
> may help me.
>
> Many thanks in advance for your help,

Hope this helps,
Namhyung
