From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Date: Wed, 14 Mar 2018 16:03:31 +0100
Message-ID: <a863f62d-e460-639a-b69b-3437b9d4e4c5@linux.vnet.ibm.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <87tvtk64ld.fsf@linux.intel.com>
 <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
 <20180314131850.GA27335@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314131850.GA27335@kernel.org>
Content-Language: en-IE
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 03/14/2018 02:18 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 14, 2018 at 09:34:48AM +0100, Thomas-Mich Richter escreveu:
>> On 03/13/2018 04:23 AM, Andi Kleen wrote:
>>> Thomas Richter <tmricht@linux.vnet.ibm.com> writes:
> 
>>>> Right now there is only hard coded support for x86.
> 
>>> That's not true. There is support for generic transaction events in perf.
> 
>>> As far as I can tell your events would map 1:1 to the generic tx-* events.
> 
>> I might be wrong, but when I look at function add_default_attributes()
>> in file buildin-stat.c the string variables transaction_attrs
>> and transaction_limited_attrs are used when flag T is specified on command line:
> 
>> /* Default events used for perf stat -T */
>> static const char *transaction_attrs = {
>>         "task-clock,"
>>         "{"
>>         "instructions,"
>>         "cycles,"
>>         "cpu/cycles-t/,"
>>         "cpu/tx-start/,"
>>         "cpu/el-start/,"
>>         "cpu/cycles-ct/"
>>         "}"
>> };
> 
>> These PMU events show up on my x86 notebook but no on the s390.
>> That's why I came to this conclusion. I have not tried other architectures.
> 
> So, I think Andi is saying that the s/390 kernel should map the generic
> transaction events (cpu/cycles-t/, cpu/tx-start/, etc) to the events you
> want to make 'perf stat -T' use, that way 'perf stat' doesn't have to be
> changed, it will continue asking for the generic transaction event names
> and then the kernel does the translation.
> 
> Just like we map "cycles" to different underlying events in different
> architectures, right?
> 
> - Arnaldo

S390 has no support for Elision and uses transaction begin/end/abort
instructions. The CPU measurement counter facility provides counters for
transaction end and transaction abort.

This means s390 counter facility device driver in arch/s390/kernel/perf_cpum_cf.c
could support the tx_abort and tx_commit symbolic counter names.

I have used this table (taken from arch/x86/events/intel/core.c) as giudeline:
/* Haswell special events */
EVENT_ATTR_STR(tx-start,        tx_start,       "event=0xc9,umask=0x1");
EVENT_ATTR_STR(tx-commit,       tx_commit,      "event=0xc9,umask=0x2");
EVENT_ATTR_STR(tx-abort,        tx_abort,       "event=0xc9,umask=0x4");
EVENT_ATTR_STR(tx-capacity,     tx_capacity,    "event=0x54,umask=0x2");
EVENT_ATTR_STR(tx-conflict,     tx_conflict,    "event=0x54,umask=0x1");
EVENT_ATTR_STR(el-start,        el_start,       "event=0xc8,umask=0x1");
EVENT_ATTR_STR(el-commit,       el_commit,      "event=0xc8,umask=0x2");
EVENT_ATTR_STR(el-abort,        el_abort,       "event=0xc8,umask=0x4");
EVENT_ATTR_STR(el-capacity,     el_capacity,    "event=0x54,umask=0x2");
EVENT_ATTR_STR(el-conflict,     el_conflict,    "event=0x54,umask=0x1");
EVENT_ATTR_STR(cycles-t,        cycles_t,       "event=0x3c,in_tx=1");
EVENT_ATTR_STR(cycles-ct,       cycles_ct,      "event=0x3c,in_tx=1,in_tx_cp=1");


So s390 can only support tx_commit and tx-abort symbolic names.
None of them show up in the transactions_attrs and transaction_limited_attrs
string variables used in builtin-stat.c file.

That is the reason why I introduced the patch set v2.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
