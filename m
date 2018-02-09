From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Recording memory addresses on ARM
Date: Thu, 08 Feb 2018 21:21:55 -0800
Message-ID: <87y3k2vito.fsf@linux.intel.com>
References: <42BDBD72-87FE-4DFA-8A5D-6CEB2DAF1262@cisco.com>
        <20180208212021.3bc3adc85abdcfb2cd4fd2e7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17710 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeBIFWJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Feb 2018 00:22:09 -0500
In-Reply-To: <20180208212021.3bc3adc85abdcfb2cd4fd2e7@arm.com> (Kim Phillips's
        message of "Thu, 8 Feb 2018 21:20:21 -0600")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: "Christian Hansen (chansen3)" <chansen3@cisco.com>, coresight@lists.linaro.org, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Kim Phillips <kim.phillips@arm.com> writes:
>
> I see ./perf report --help says:
>
>        --mem-mode
>            Use the data addresses of samples in addition to instruction addresses to build the histograms. To generate meaningful output,
>            the perf.data file must have been obtained using perf record -d -W and using a special event -e cpu/mem-loads/ or -e
>            cpu/mem-stores/. See perf mem for simpler access.
>
> yet perf record's -W switch isn't on record's manpage, and trying the
> invocation sequence on x86 using a perf built from today's acme's
> perf/urgent branch:
>
> $ ./perf version
> perf version 4.13.rc5.g59410f5
> $ ./perf record -e cpu/mem-loads/u -d -W -p 3722 sleep 1


The help suggestion seems to be incorrect, this needs to be cpu/mem-loads/upp
(pp to enable PEBS)

With PEBS the event produces no samples.


-Andi
