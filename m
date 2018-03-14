From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Date: Wed, 14 Mar 2018 09:34:48 +0100
Message-ID: <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <87tvtk64ld.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87tvtk64ld.fsf@linux.intel.com>
Content-Language: en-IE
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 03/13/2018 04:23 AM, Andi Kleen wrote:
> Thomas Richter <tmricht@linux.vnet.ibm.com> writes:
> 
>> Right now there is only hard coded support for x86.
> 
> That's not true. There is support for generic transaction events in perf.
> 
> As far as I can tell your events would map 1:1 to the generic tx-* events.
> 
> -Andi
> 

I might be wrong, but when I look at function add_default_attributes()
in file buildin-stat.c the string variables transaction_attrs
and transaction_limited_attrs are used when flag T is specified on command line:

/* Default events used for perf stat -T */
static const char *transaction_attrs = {
        "task-clock,"
        "{"
        "instructions,"
        "cycles,"
        "cpu/cycles-t/,"
        "cpu/tx-start/,"
        "cpu/el-start/,"
        "cpu/cycles-ct/"
        "}"
};

These PMU events show up on my x86 notebook but no on the s390.
That's why I came to this conclusion. I have not tried other architectures.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
