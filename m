From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: perf trace syscall table generation for powerpc with syscall.tbl
Date: Wed, 9 Jan 2019 09:17:25 +0530
Message-ID: <aa2a9559-37c3-a21d-2801-6fbdfec35c9a@linux.ibm.com>
References: <20190108170440.GF28965@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108170440.GF28965@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

Yes. I'm aware of it. Just that I was busy with something else so couldn't do it.

Thanks for reminding :). Will post a patch soon.

Ravi

On 1/8/19 10:34 PM, Arnaldo Carvalho de Melo wrote:
> Hi Ravi,
> 
> 	I noticed that in:
> 
>   commit ab66dcc76d6ab8fae9d69d149ae38c42605e7fc5
>   Author: Firoz Khan <firoz.khan@linaro.org>
>   Date:   Mon Dec 17 16:10:36 2018 +0530
> 
>     powerpc: generate uapi header and system call table files
> 
> powerpc now generates its syscall tables headers from a syscall.tbl just
> like x86 and s390, could you please switch to using it, taking the x86
> and s390 scripts as a starting point, then test on your systems
> everything works?
> 
> Thanks,
> 
> - Arnaldo
> 
