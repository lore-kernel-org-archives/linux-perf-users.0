From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf symbol: Fix kernel symbol address display
Date: Tue, 21 Apr 2020 13:18:03 +0200
Message-ID: <6239b798-3bf5-c1a6-8acf-d4e293089145@linux.ibm.com>
References: <20200415070744.59919-1-tmricht@linux.ibm.com>
 <20200420204617.GA23638@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420204617.GA23638@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 4/20/20 10:46 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 15, 2020 at 09:07:44AM +0200, Thomas Richter escreveu:
>> Running commands
>>
>>    ./perf record -e rb0000 -- find .
>>    ./perf report -v
> 
> Or when pressing 'V' in the TUI.
>  
>> reveals symbol names and its addresses. There is a mismatch between
> 
> Yeah, an address that at some point was put there to help with debugging
> the symbol resolution, IIRC how it looked like when looking at
> 
>   readelf -sW vmlinux
> 
> Or any other DSO, for instance, for a glibc symbol here:
> 
> Using 'perf report -s pid,dso,sym' then pressing 'V':
> 
>    1.55%    20325:perf  /usr/lib64/libc-2.30.so   0x161825   B [.] __strlen_avx2
> 
> [acme@five perf]$ readelf -sW /usr/lib64/libc-2.30.so | grep strlen_avx2
>  24371: 0000000000161810   414 FUNC    LOCAL  DEFAULT   15 __strlen_avx2
> [acme@five perf]$ 
> 
> Can you check if doing in /lib/modules/.../build/vmlinux produces what
> appears when 'V' is in place?
> 

Yes, I used latest 5.7.0rc2 and did
./perf record -e rb0000 -- find 
./perf report -s pid,dso,sym 
and pressed 'V' in the TUI.

This gives 
     6.06%     9986:find     /lib/modules/5.7  0x1f0c86           v [k] check_chain_key 
and 
[root@m35lp76 ~]# readelf -sW /lib/modules/5.7.0-rc2d-perf+/build/vmlinux | fgrep  check_chain_key
 20698: 00000000001f0c70   486 FUNC    LOCAL  DEFAULT    1 check_chain_key
[root@m35lp76 ~]# 

which is perfectly good and in the range. 

> And perhaps we can also show the DSO offset and the rip as it gets laid
> out in memory in the end? So we have all the informations?
> 
> - Arnaldo
> 

I do not follow you here, do you mean something like DSO-name+offset
for example libc-2.30.so+0x123?

Thanks

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
