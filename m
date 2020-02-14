From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH v3] perf test: Fix test trace+probe_vfs_getname.sh
Date: Fri, 14 Feb 2020 14:54:11 +0100
Message-ID: <6d57be05-abaa-4ff5-1a07-6deb34fbb3d4@linux.ibm.com>
References: <20200213122009.31810-1-tmricht@linux.ibm.com>
 <20200213143048.GA22170@kernel.org>
 <20200214020151.c93187535a8ccd0fb146a301@kernel.org>
 <20200213181140.GA28626@kernel.org>
 <20200214094550.228422235c7785519c7f24cc@kernel.org>
 <c249efd1-f705-4739-baad-c94257706489@linux.ibm.com>
 <20200214130057.GB13462@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214130057.GB13462@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 2/14/20 2:00 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 14, 2020 at 10:44:06AM +0100, Thomas Richter escreveu:
>> On 2/14/20 1:45 AM, Masami Hiramatsu wrote:
>>> On Thu, 13 Feb 2020 15:11:40 -0300
>>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>
>>>> Em Fri, Feb 14, 2020 at 02:01:51AM +0900, Masami Hiramatsu escreveu:
>>>>> On Thu, 13 Feb 2020 11:30:48 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>  
>>>>>> Em Thu, Feb 13, 2020 at 01:20:09PM +0100, Thomas Richter escreveu:
>>>>>>> This test places a kprobe to function getname_flags() in the kernel
>>>>>>> which has the following prototype:
>>>>  
>>>>>>>   struct filename *
>>>>>>>   getname_flags(const char __user *filename, int flags, int *empty)
>>>>  
>>>>>>> Variable filename points to a filename located in user space memory.
>>>>>>> Looking at
>>>>>>> commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
>>>>>>> the kprobe should indicate that user space memory is accessed.
>>>>  
>>>>>>> The following patch specifies user space memory access first and if this
>>>>>>> fails use type 'string' in case 'ustring' is not supported.
>>>>  
>>>>>> What are you fixing?
>>>>  
>>>>>> I haven't seen any example of this test failing, and right now testing
>>>>>> it with:
>>>>  
>>>>>> [root@quaco ~]# uname -a
>>>>>> Linux quaco 5.6.0-rc1+ #1 SMP Wed Feb 12 15:42:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>>>> [root@quaco ~]#
>>>>  
>>>>> This bug doesn't happen on x86 or other archs on which user-address space and
>>>>> kernel address space is same. On some arch (ppc64 in this case?) user-address
>>>>> space is partially or completely same as kernel address space. (Yes, they switch
>>>>> the world when running into the kernel) In this case, we need to use different
>>>>> data access functions for each spaces. That is why I introduced "ustring" type
>>>>> for kprobe event.
>>>>> As far as I can see, Thomas's patch is sane.
>>>>
>>>> Well, without his patch, on x86, the test he is claiming to be fixing
>>>> works well, with his patch it stops working, see the rest of my reply.
>>>
>>> OK, let me see.
>>>
>>>
>>>> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>>>> index 7cb99b433888..30c1eadbc5be 100644
>>>> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>>>> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>>>> @@ -13,7 +13,9 @@ add_probe_vfs_getname() {
>>>>  	local verbose=$1
>>>>  	if [ $had_vfs_getname -eq 1 ] ; then
>>>>  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
>>>> -		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
>>>> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
>>>> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
>>>> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:string" || \
>>>>  		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
>>>>  	fi
>>>>  }
>>>
>>> This looks no good (depends on architecture or debuginfo). In fs/namei.c,
>>>
>>> struct filename *
>>> getname_flags(const char __user *filename, int flags, int *empty)
>>> ...
>>>         kname = (char *)result->iname;
>>>         result->name = kname;
>>> ...
>>>         result->uptr = filename;
>>>         result->aname = NULL;
>>>         audit_getname(result);
>>>         return result;
>>> }
>>>
>>> And the line number script, egreps below line.
>>>
>>>         result->uptr = filename;
>>>
>>> However, the probe on this line will hit *before* execute this line.
>>> Note that kprobes is a breakpoint, which breaks into this line execution,
>>> not after executed.
>>>
>>> So, I thik at this point, result->uptr should be NULL, but filename and
>>> result->name already have assigned value.
>>>
>>> Thus, the fix should be something like below.
>>>
>>>> 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
>>>> - 		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
>>>> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
>>>
>>> Thomas, is this OK for you too, or would you have any reason to trace
>>> result->uptr?
>>>
>>> Thank you,
>>>
>>
>> Thank you very much for your help!!!
>>
>> I started from scratch and just installed linux 5.6.0rc1 without
>> any changes and got this failure:
>>
>> [root@m35lp76 perf]# ./perf test  66 67
>> 66: Use vfs_getname probe to get syscall args filenames   : FAILED!
>> 67: Check open filename arg using perf trace + vfs_getname: FAILED!
>> [root@m35lp76 perf]#
>>
>> Now I applied Masami's patch and this is the result
>>
>> [root@m35lp76 perf]# ./perf test  66 67
>> 66: Use vfs_getname probe to get syscall args filenames   : Ok
>> 67: Check open filename arg using perf trace + vfs_getname: Ok
>> [root@m35lp76 perf        
>>
>> Can we commit this patch?
>> Thanks a lot
> 
> So, I'll keep authorship to Thomas but will add a committer note stating
> Masami's correction, is that ok?
> 
> - Arnaldo
> 

Sure go ahead.


-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
