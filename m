Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CE41DE2DB
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736167805; cv=none; b=C4zArXJbTjHnwiJO9+sA+IXj5OxsqzsuY8zotKJd3HjSNT0+NssSmdSFYYC5RbNCXYNdihGKsg0o3fp53dQskvB60sVrprlH9MzzK+tvstROIwiJzPmsJSXDs6Jmwy+aM+wS2afntagoW74/uChmjCGoS78jUV/GcAfobOfHyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736167805; c=relaxed/simple;
	bh=tekkDN89VKqc4PjOMOIsCJEoUReT6b4y1qLe4BurqyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1iZUlJG95KGzAuUrEPSoWReVFm80HhrKh+747V9IvFIQpgrrP++VkIpNwc5o1tIfn69Nm6lv9bS7v3bJU3/9EFI8ajwc4T8JdD+RQrRDUZLnmvBRj1gY31XIgKmTkrnEOoLwVMh5foQ2F6a/3DF6hFGBkw0Ol8ybbLaGVt3vKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YRYdT2hXyz9sPd;
	Mon,  6 Jan 2025 13:38:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FVLpbuyQA70k; Mon,  6 Jan 2025 13:38:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YRYdT1g9Gz9rvV;
	Mon,  6 Jan 2025 13:38:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 25DFC8B76D;
	Mon,  6 Jan 2025 13:38:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id BJWV85ZgAz44; Mon,  6 Jan 2025 13:38:53 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AB4BF8B763;
	Mon,  6 Jan 2025 13:38:52 +0100 (CET)
Message-ID: <752a31b0-4370-4f52-b7cc-45f0078c1d6c@csgroup.eu>
Date: Mon, 6 Jan 2025 13:38:52 +0100
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
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org> <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu> <Z3bYltoidQpqtyJ_@x1>
 <48724052-4003-4140-8106-f9ea098cedcb@csgroup.eu> <Z3c4nupM-UENN5LM@x1>
 <5b8ec160-4b50-4736-8012-30ae35c45028@csgroup.eu> <Z3gPncBcCnZiNy57@x1>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z3gPncBcCnZiNy57@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/01/2025 à 17:26, Arnaldo Carvalho de Melo a écrit :
> On Fri, Jan 03, 2025 at 01:40:24PM +0100, Christophe Leroy wrote:
>> Le 03/01/2025 à 02:08, Arnaldo Carvalho de Melo a écrit :
>>>>      PerfTop:     524 irqs/sec  kernel:51.1%  exact:  0.0% lost: 0/0 drop: 0/0
>>>> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
>>>> -------------------------------------------------------------------------------
> 
>>>>       17.18%  [unknown]      [k] 0xc0891c14
>>>>        7.63%  [unknown]      [k] 0xc005f11c
> 
>>> I think I hadn't notice this '[unknown]' one bit before :-\ the [k] is
>>> there, so having unknown is odd
>   
>> Problem found, it's in maps__find_next_entry(), this leads to both
>> map->start and map->end of kernel map being set to 0xc0000000, which leads
>> to the failure of bsearch() in maps__find().
> 
> Right, and since you don't have any module (CONFIG_MODULES not set),
> and most machines do, that is when the buggy function is called:
> 
> machine__create_kernel_maps()
> 	if (!machine__get_running_kernel_start(machine, &name, &start, &end))
> <SNIP>
>          if (end == ~0ULL) {
>                  /* update end address of the kernel map using adjacent module address */
>                  struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
>                                                           machine__kernel_map(machine));
> 
>                  if (next) {
>                          machine__set_kernel_mmap(machine, start, map__start(next));
>                          map__put(next);
>                  }
>          }
> <SNIP>
> 
> So machine__get_running_kernel_start() doesn't manage to fill end with
> either because it doesn't find the ref_reloc_sym, one of:
> 
> const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL}
> 
> And returns -1, so that first if block fails, and then start also
> doesn't get set and remains 0, which doesn't seem to be the case, as you
> get 0xc0000000 in it, or this fails:
> 
>          err = kallsyms__get_symbol_start(filename, "_edata", &addr);
>          if (err)
>                  err = kallsyms__get_function_start(filename, "_etext", &addr);
>          if (!err)
>                  *end = addr;
> 

Indeed yes that one fails, because:

~# grep -e _stext -e _etext -e _edata /proc/kallsyms
c0000000 T _stext
c08b8000 D _etext

So there is no _edata and _etext is not text

$ ppc-linux-objdump -x vmlinux | grep -e _stext -e _etext -e _edata
c0000000 g       .head.text	00000000 _stext
c08b8000 g       .rodata	00000000 _etext
c1378000 g       .sbss	00000000 _edata

Changing

	kallsyms__get_function_start(filename, "_etext", &addr);

to

	kallsyms__get_symbol_start(filename, "_etext", &addr);

works.


The following change works as well:

diff --git a/arch/powerpc/kernel/vmlinux.lds.S 
b/arch/powerpc/kernel/vmlinux.lds.S
index b4c9decc7a75..b7b2cd7e2a20 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -123,10 +123,11 @@ SECTIONS
  		 */
  		*(.sfpr);
  		*(.text.asan.* .text.tsan.*)
+
+		. = ALIGN(PAGE_SIZE);
+		_etext = .;
  	} :text

-	. = ALIGN(PAGE_SIZE);
-	_etext = .;
  	PROVIDE32 (etext = .);

  	/* Read-only data */

As it leads to:

~# grep -e _stext -e _etext -e _edata /proc/kallsyms
c0000000 T _stext
c08b8000 T _etext

$ ppc-linux-objdump -x vmlinux | grep -e _stext -e _etext -e _edata
c0000000 g       .head.text	00000000 _stext
c08b8000 g       .text	00000000 _etext
c1378000 g       .sbss	00000000 _edata

So what is the most correct fix ? Change architectures link script or 
make perf _etext lookup more flexible, allowing non-text ?

Looking at vmlinux.lds.S from various architectures, I have the feeling 
several of them are affected.

Now, regarding _edata, what I see is:

~# tail -2 /proc/kallsyms
c136a000 D __start___bug_table
c1377c14 D __stop___bug_table

And in System.map I have:

c136a000 D __start___bug_table
c1377c14 D __stop___bug_table
c1378000 B __bss_start
c1378000 B _edata
c1378000 B initcall_debug
c1378004 B reset_devices

Should perf try to locate the very last symbol when it doesn't find 
_edata ? Or should architecture's link script be modified ? Otherwise 
commit 69a87a32f5cd ("perf machine: Include data symbols in the kernel 
map") is just pointless.

Christophe
