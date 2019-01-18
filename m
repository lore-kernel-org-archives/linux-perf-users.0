From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
Date: Fri, 18 Jan 2019 09:39:10 +0100
Message-ID: <9c856ac0-ef23-72b5-901d-a1f815508976@linux.ibm.com>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117140053.GJ11922@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 01/17/2019 03:00 PM, Arnaldo Carvalho de Melo wrote:
> erf report: Display arch specific diagnostic counter sets, starting with s390
>     
>     On s390 the event bc000 (also named CF_DIAG) extracts the CPU
>     Measurement Facility diagnostic counter sets and displays them as
>     counter number and counter value pairs sorted by counter set number.
>     
>     Output:
>      [root@s35lp76 perf]# ./perf report -D --stdio
>     
>      [00000000] Counterset:0 Counters:6
>        Counter:000 Value:0x000000000085ec36 Counter:001 Value:0x0000000000796c94
>        Counter:002 Value:0x0000000000005ada Counter:003 Value:0x0000000000092460
>        Counter:004 Value:0x0000000000006073 Counter:005 Value:0x00000000001a9a73
>      [0x000038] Counterset:1 Counters:2
>        Counter:000 Value:0x000000000007c59f Counter:001 Value:0x000000000002fad6
>      [0x000050] Counterset:2 Counters:16
>        Counter:000 Value:000000000000000000 Counter:001 Value:000000000000000000
>        Counter:002 Value:000000000000000000 Counter:003 Value:000000000000000000
>        Counter:004 Value:000000000000000000 Counter:005 Value:000000000000000000
>        Counter:006 Value:000000000000000000 Counter:007 Value:000000000000000000
>        Counter:008 Value:000000000000000000 Counter:009 Value:000000000000000000
>        Counter:010 Value:000000000000000000 Counter:011 Value:000000000000000000
>        Counter:012 Value:000000000000000000 Counter:013 Value:000000000000000000
>        Counter:014 Value:000000000000000000 Counter:015 Value:000000000000000000
>      [0x0000d8] Counterset:3 Counters:128
>        Counter:000 Value:0x000000000000020f Counter:001 Value:0x00000000000001d8
>        Counter:002 Value:0x000000000000d7fa Counter:003 Value:0x000000000000008b
>        ...
>     
>     The number in brackets is the offset into the raw data field of the
>     sample.
>     
>     New functions trace_event_sample_raw__init() and s390_sample_raw() are
>     introduced in the code path to enable interpretation on non s390
>     platforms. This event bc000 attached raw data is generated only on s390
>     platform. Correct display on other platforms requires correct endianness
>     handling.
>     
>     Committer notes:
>     
>     Added a init function that sets up a evlist function pointer to avoid
>     repeated tests on evlist->env and calls to perf_env__name() that
>     involves normalizing, etc, for each PERF_RECORD_SAMPLE.
>     
>     Removed needless __maybe_unused from the trace_event_raw()
>     prototype in session.h, move it to be an static function in evlist.
>     
>     Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

I have applied your changed patch. Works great. Thanks a lot.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
