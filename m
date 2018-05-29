From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf docu: Update section on cpu topology
Date: Tue, 29 May 2018 09:44:29 +0200
Message-ID: <7a8d7174-0fe5-5492-9c40-8cf65a65bab9@linux.ibm.com>
References: <20180528074433.16652-1-tmricht@linux.ibm.com>
 <20180528195412.GI25467@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180528195412.GI25467@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andi Kleen <andi@firstfloor.org>
List-Id: linux-perf-users.vger.kernel.org

On 05/28/2018 09:54 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 28, 2018 at 09:44:33AM +0200, Thomas Richter escreveu:
>> Add an explanation of each cpu's core and socket
>> identifier to the documentation.
> 
> Thanks, applying. I guess it is not that worth to mention that older
> files may have just the string lists, right?
> 
> - Arnaldo

Ah, sorry but that did not cross my mind....

It was introduced with commit 
2bb00d2f95193 ("perf tools: Store the cpu socket and core ids in the perf.data header")
and is available since Linux 4.4

Hope this helps...

>  
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/Documentation/perf.data-file-format.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>> index d00f0d51cab8..c57904a526ce 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -153,10 +153,18 @@ struct {
>>  	HEADER_CPU_TOPOLOGY = 13,
>>  
>>  String lists defining the core and CPU threads topology.
>> +The string lists are followed by a variable length array
>> +which contains core_id and socket_id of each cpu.
>> +The number of entries can be determined by the size of the
>> +section minus the sizes of both string lists.
>>  
>>  struct {
>>         struct perf_header_string_list cores; /* Variable length */
>>         struct perf_header_string_list threads; /* Variable length */
>> +       struct {
>> +	      uint32_t core_id;
>> +	      uint32_t socket_id;
>> +       } cpus[nr]; /* Variable length records */
>>  };
>>  
>>  Example:
>> -- 
>> 2.14.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
