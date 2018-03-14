From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Date: Wed, 14 Mar 2018 10:18:50 -0300
Message-ID: <20180314131850.GA27335@kernel.org>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <87tvtk64ld.fsf@linux.intel.com>
 <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Mar 14, 2018 at 09:34:48AM +0100, Thomas-Mich Richter escreveu:
> On 03/13/2018 04:23 AM, Andi Kleen wrote:
> > Thomas Richter <tmricht@linux.vnet.ibm.com> writes:

> >> Right now there is only hard coded support for x86.

> > That's not true. There is support for generic transaction events in perf.

> > As far as I can tell your events would map 1:1 to the generic tx-* events.
 
> I might be wrong, but when I look at function add_default_attributes()
> in file buildin-stat.c the string variables transaction_attrs
> and transaction_limited_attrs are used when flag T is specified on command line:
 
> /* Default events used for perf stat -T */
> static const char *transaction_attrs = {
>         "task-clock,"
>         "{"
>         "instructions,"
>         "cycles,"
>         "cpu/cycles-t/,"
>         "cpu/tx-start/,"
>         "cpu/el-start/,"
>         "cpu/cycles-ct/"
>         "}"
> };
 
> These PMU events show up on my x86 notebook but no on the s390.
> That's why I came to this conclusion. I have not tried other architectures.

So, I think Andi is saying that the s/390 kernel should map the generic
transaction events (cpu/cycles-t/, cpu/tx-start/, etc) to the events you
want to make 'perf stat -T' use, that way 'perf stat' doesn't have to be
changed, it will continue asking for the generic transaction event names
and then the kernel does the translation.

Just like we map "cycles" to different underlying events in different
architectures, right?

- Arnaldo
