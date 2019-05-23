From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 1/3] perf report: Fix OOM error in TUI mode on s390
Date: Thu, 23 May 2019 10:12:45 +0200
Message-ID: <872a9844-2464-d92d-21b9-311174c0bae4@linux.ibm.com>
References: <20190522144601.50763-1-tmricht@linux.ibm.com>
 <20190522144601.50763-2-tmricht@linux.ibm.com>
 <20190522180812.GI30271@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522180812.GI30271@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 5/22/19 8:08 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 22, 2019 at 04:45:59PM +0200, Thomas Richter escreveu:
>


.....

>>
>> This size kills the TUI interface when executing the following
>> code:
>>
>>   process_sample_event()
>>     hist_entry_iter__add()
>>       hist_iter__report_callback()
>>         hist_entry__inc_addr_samples()
>>           symbol__inc_addr_samples(symbol = __bss_stop)
>>             symbol__cycles_hist()
>>                annotated_source__alloc_histograms(...,
>> 				                symbol__size(sym),
>> 		                                ...)
>>
>> This function allocates memory to save sample histograms.
>> The symbol_size() marco is defined as sym->end - sym->start, which
>> results in above value of 0x3fe6e64a850 bytes and
>> the call to calloc() in annotated_source__alloc_histograms() fails.
> 
> Humm, why are we getting samples in that area? Is it some JITted thing
> like BPF? What is it?
> 
> Why not just not consider the calloc failure as fatal, and when/if the
> user asks for annotation on such symbol, tell the user that it wasn't
> possible to allocate N bytes for it?
> 
> - Arnaldo


I have not debugged why this sample address was recorded. BPF code was not
running.

I have no problem with making calloc() failure no fatal, however we might
still allocate large memory...

I will send a new patch.

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
