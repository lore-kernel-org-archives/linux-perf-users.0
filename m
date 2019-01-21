From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
Date: Mon, 21 Jan 2019 15:10:58 +0100
Message-ID: <1277920e-4e04-88fd-9510-08ce9950da04@linux.ibm.com>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org> <20190120181814.GB8591@krava>
 <20190121131336.GC3852@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121131336.GC3852@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 01/21/2019 02:13 PM, Jiri Olsa wrote:
> On Sun, Jan 20, 2019 at 07:18:14PM +0100, Jiri Olsa wrote:
>> On Thu, Jan 17, 2019 at 11:00:53AM -0300, Arnaldo Carvalho de Melo wrote:
>>
>> SNIP
>>
>>> --- a/tools/perf/util/python-ext-sources
>>> +++ b/tools/perf/util/python-ext-sources
>>> @@ -25,6 +25,7 @@ util/parse-branch-options.c
>>>  util/rblist.c
>>>  util/counts.c
>>>  util/print_binary.c
>>> +util/s390-sample-raw.c
>>>  util/strlist.c
>>>  util/trace-event.c
>>>  ../lib/rbtree.c
>>
>> hi,
>> this change breaks the python module:
>>
>>   >>> import perf
>>   Traceback (most recent call last):
>>     File "<stdin>", line 1, in <module>
>>   ImportError: ./perf.so: undefined symbol: color_fprintf
>>
>> changelog doesn't say anything about python related change
> 
> I made some chenages and movedthat raw sample code
> under s390.. which cured the python module, but
> I haven't tested it on s390.
> 
> Could you please check if code in here works for you:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/s390
> 
> if it works, I'll post it
> 
> thanks,
> jirka
> 

I downloaded your repository and checked out branch perf/s390. 
It works nicely, you have my tested by:
-
Tested-by: Thomas Richter <tmricht@linux.ibm.com>

PS: This looks very similar to my version 1 submitted around Jan 11th.
Arnaldo wanted a rework to be able to get these counter values on 
non-s390 platforms, that why we came up with version 2(which unfortunately
broke the perf.so python module).

PS2: This was my first encounter to python and I played around a bit
to include the necessary modules to get rid of the undefined warning.
However this ended up in a larger list of C files to include and
stopped at modules
1. util/pmu.c which refers to symbol perf_buf_in which is a FILE pointer
   used by some yacc input file.
2. perf_config_bool() which is located in util/config.c and emits a 
   compile error when included in the util/python-ext-sources file
   for python/perf.so module.

So I think this road is a dead end.

Thanks for fixing this.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
