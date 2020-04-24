From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf symbol: Fix kernel symbol address display
Date: Fri, 24 Apr 2020 20:01:22 +0200
Message-ID: <db6de799-564a-273e-99ad-40817f2b970a@linux.ibm.com>
References: <20200415070744.59919-1-tmricht@linux.ibm.com>
 <20200420204617.GA23638@kernel.org>
 <475a5c86-2be3-4f12-56f3-7bd6587e8ec3@linux.ibm.com>
 <20200424150631.GN19437@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200424150631.GN19437@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 4/24/20 5:06 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 24, 2020 at 02:37:01PM +0200, Thomas Richter escreveu:
>> On 4/20/20 10:46 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Apr 15, 2020 at 09:07:44AM +0200, Thomas Richter escreveu:
>>>> Running commands
>>>>
>>>>    ./perf record -e rb0000 -- find .
>>>>    ./perf report -v
>>>
>>> Or when pressing 'V' in the TUI.
>>>  
>>>> reveals symbol names and its addresses. There is a mismatch between
>>>
>>> Yeah, an address that at some point was put there to help with debugging
>>> the symbol resolution, IIRC how it looked like when looking at
>>>
>>>   readelf -sW vmlinux
>>>
>>> Or any other DSO, for instance, for a glibc symbol here:
>>>
>>> Using 'perf report -s pid,dso,sym' then pressing 'V':
>>>
>>>    1.55%    20325:perf  /usr/lib64/libc-2.30.so   0x161825   B [.] __strlen_avx2
>>>
>>> [acme@five perf]$ readelf -sW /usr/lib64/libc-2.30.so | grep strlen_avx2
>>>  24371: 0000000000161810   414 FUNC    LOCAL  DEFAULT   15 __strlen_avx2
>>> [acme@five perf]$ 
>>>
>>> Can you check if doing in /lib/modules/.../build/vmlinux produces what
>>> appears when 'V' is in place?
>>>
>>> And perhaps we can also show the DSO offset and the rip as it gets laid
>>> out in memory in the end? So we have all the informations?
>>>
>>> - Arnaldo
>>>
>>
>> Arnaldo,
>>
>> having verified this also works in the TUI mode using 'V', are you going to pick
>> this patch?
> 
> That would be a change in behaviour, the original intent was to show the
> value one would get from the ELF symbol table, isn't that the case?
> 

I think there is a misunderstanding.

Your example above refers to libc, which shows the addresses
correctly (on x86 and s390). I was refering to the kernel dso.
The issue only shows up on the kernel DSO (vmlinux and kallsyms)

When I use the -v option (or 'V' in TUI) I get this

  3.55%  find /lib/modules/.../build/vmlinux  0xf11ec  v [k] check_chain_key
                                              ^^^^^^^
This address is not correct as compared to readelf on vmlinux file:

[root@m35lp76 linux]# readelf -sW vmlinux| fgrep check_chain_key
 20698: 00000000001f0c70   486 FUNC    LOCAL  DEFAULT    1 check_chain_key
[root@m35lp76 linux]# 

The problem are the mapping functions with are applied for the kernel DSO.
In dso__process_kernel_symbol() the mapping is adjusted (around line 903)
and  function hist_entry_iter_add() saves the modified address in the
struct hist_entry->ip. This address is used from now on and printed.

Let me know and I will double check this and rework the commit message
as it was not good enough.

Thanks.


> That is why I asked if you would think that providing the information
> you want, which is matching to what is in kallsyms, would be
> interesting, which I think it is, but how? showing the vmlinux offset
> somehow?
>  

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
