Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F9D13AA5D
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jan 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842006; cv=none; b=dqqZuvzk6Q2btHbHV17iDb3emgMeF1tqVeqpJu83MhQGiSthMrz1kjL32jzGqAUY41qWlkQFv5luAWxJkd2Oq1S7Oje6Tif3Msp2rhzoHTcqD3mEoH8ULInkDqJVuINXWjSTptwyhyvaLfJsbtCVUMng7piTKknsH4xW2BMhK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842006; c=relaxed/simple;
	bh=mv6IG6jcudcu+zSSj8HOUtGiXmBQwFu9xvnRZ+XtFok=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RCFqXDSUIPCXOOvK5JZy7gCjbLGVCthOmQi1m2yYZp+0+5VQFJ1N5VEaCDFy93EP3hABDxEs1drj01nqykZpCCTCr5F4lcSf2BzEXnQeqbfbjYU0b2myk6vr31ciVt81c9M7K/2ftHMflxQeprFRhGYNz0XAA1UCVObMERFOjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YPDnW2WG3z9sgV;
	Thu,  2 Jan 2025 18:52:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yH5RnWn7cIZc; Thu,  2 Jan 2025 18:52:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YPDnW1MXKz9sgJ;
	Thu,  2 Jan 2025 18:52:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 15FE98B767;
	Thu,  2 Jan 2025 18:52:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id IXLGYi8gKoA5; Thu,  2 Jan 2025 18:52:46 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A4BE58B763;
	Thu,  2 Jan 2025 18:52:46 +0100 (CET)
Message-ID: <2411a5c7-16df-4c8f-8416-f34d3d048b39@csgroup.eu>
Date: Thu, 2 Jan 2025 18:52:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@linaro.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org> <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/01/2025 à 15:41, Christophe Leroy a écrit :
> Hi Arnaldo,
> 
> Le 26/12/2024 à 16:51, Arnaldo Carvalho de Melo a écrit :
>> On Tue, Dec 17, 2024 at 02:18:07PM +0000, James Clark wrote:
>>> On 16/12/2024 7:01 am, Christophe Leroy wrote:
>>>> I noticed with 6.12 LTS Kernel that perf top and perf record/report
>>>> don't display kernel symbols anymore, instead it displays the raw
>>>> address with [unknown] as object.
>>
>>>> After bisect I see that the problem appears with commit 659ad3492b91
>>>> ("perf maps: Switch from rbtree to lazily sorted array for addresses").
>>> You might want to try applying 0b90dfda222e3 as it claims to fix this
>>> commit. I doubt that will fix your issue but it's worth being sure.
>>> There was also another fix recently that could be related: 23c44f6c83
>>> Did you try the perf-tools-next branch? Maybe something that's 
>>> already fixed
>>> needs to be backported.
>>
>> Right, I tried reproducing this on perf-tools-next and couldn't, so
>> please test it there.
>>
> 
> I tested it again on latest perf-tools-next (ed60738a9b7e ("perf stat: 
> Document and clarify outstate members")) and still have the same 
> problem, all kernel symbols appear as [unknown]:
> 
>     PerfTop:    4163 irqs/sec  kernel:28.3%  exact:  0.0% lost: 0/0 
> drop: 0/14199 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------------
> 
>       5.75%  [unknown]      [k] 0xc005f11c
>       4.96%  gau            [.] engine_loop.constprop.0.isra.0
>       4.31%  perf           [.] hists__findnew_entry
>       4.13%  [unknown]      [k] 0xc0891c14
>       3.43%  libc.so.6      [.] memset
>       3.11%  perf           [.] dso__find_symbol
>       2.63%  perf           [.] evsel__parse_sample
>       2.23%  perf           [.] deliver_event
>       2.06%  perf           [.] sort__dso_cmp
>       2.02%  perf           [.] sort__sym_cmp
>       1.92%  perf           [.] machine__resolve
>       1.72%  libc.so.6      [.] _int_free
>       1.59%  perf           [.] perf_hpp__is_dynamic_entry
>       1.38%  perf           [.] __hists__add_entry.constprop.0
>       1.37%  perf           [.] maps__find
>       1.26%  [unknown]      [k] 0xc01f82c8
>       1.24%  libc.so.6      [.] pthread_rwlock_unlock@@GLIBC_2.34
>       1.20%  perf           [.] down_read
>       1.18%  libc.so.6      [.] cfree@GLIBC_2.0
>       1.12%  libc.so.6      [.] pthread_rwlock_rdlock@@GLIBC_2.34

If it helps, here is how I build perf:

make ARCH=powerpc CROSS_COMPILE=ppc-linux- WERROR=0 NO_SLANG=y NO_GTK2=y 
NO_LIBPYTHON=y NO_LIBAUDIT=y NO_LIBNUMA=y NO_LIBBPF=y 
EXTRA_CFLAGS="-DMAX_NR_CPUS=1 -fPIE" NO_LIBTRACEEVENT=1

Christophe
