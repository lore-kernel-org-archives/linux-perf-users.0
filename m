From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf symbol: Fix kernel symbol address display
Date: Fri, 24 Apr 2020 14:37:01 +0200
Message-ID: <475a5c86-2be3-4f12-56f3-7bd6587e8ec3@linux.ibm.com>
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
> And perhaps we can also show the DSO offset and the rip as it gets laid
> out in memory in the end? So we have all the informations?
> 
> - Arnaldo
> 

Arnaldo,

having verified this also works in the TUI mode using 'V', are you going to pick
this patch?

Thanks


-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
