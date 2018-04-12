From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf record: Remove unnecessary warning for missing sysfs
 entry
Date: Thu, 12 Apr 2018 15:19:31 +0200
Message-ID: <53a2face-d26c-8851-d594-5f78da5814c3@linux.vnet.ibm.com>
References: <20180412114723.48550-1-tmricht@linux.ibm.com>
 <20180412130513.GB9818@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412130513.GB9818@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 04/12/2018 03:05 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 12, 2018 at 01:47:23PM +0200, Thomas Richter escreveu:
>> Using perf on 4.16.0 kernel on s390 shows warning
>>    failed: can't open node sysfs data
>> each time I run command perf record ... for example:
>>
>> [root@s35lp76 perf]# ./perf record -e rB0000 -- sleep 1
>> [ perf record: Woken up 1 times to write data ]
>> failed: can't open node sysfs data
>> [ perf record: Captured and wrote 0.001 MB perf.data (4 samples) ]
>> [root@s35lp76 perf]#
>>
>> BTW: I find this error message not very informative.
> 
> What an understatement :-)
>  
>> It turns out commit e2091cedd51bf ("perf tools: Add MEM_TOPOLOGY
>> feature to perf data file") tries to open directory named
>> /sys/devices/system/node/ which does not exist on s390.
>>
>> This is the call stack:
>>  __cmd_record
>>  +---> perf_session__write_header
>>        +---> perf_header__adds_write
>>              +---> do_write_feat
>> 	           +---> write_mem_topology
>> 		         +---> build_mem_topology
>> 			       prints warning
>> The issue starts in do_write_feat() which unconditionally
>> loops over all features and now includes HEADER_MEM_TOPOLOGY and calls
>> write_mem_topology().
>> Function record__init_features() at the beginning of __cmd_record()
>> sets all features and then turns off some.
>>
>> Fix this by removed the warning, if the directory is not present
>> memory node information is not available and won't be displayed.
> 
> Can't we instead improve the error message and turn this into a
> pr_debug2? Isn't it a reasonable scenario that the user expects this
> topology information to be present and then ends up without it?
> 
> Perhaps something like:
> 
> 	pr_debug2("%s: could't read %s, does this arch have topology information?\n", __func__, path);
> 
> - Arnaldo
>  

Fine with me, I will provide a version 2....

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
