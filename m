Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9B11917D0
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jan 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735829405; cv=none; b=IXQ8GkN5FVgFAf1XaoVc/2V4i8mgslroQHX8C3+6admLWsPOcNQDkb6rb6BAImuFfnUQEUl+q4oF+TeoHi9rE/ZI0ug0daQHYLvLb6Zo0uQ3yG6AjasKoWeO+gbdHnVf82WPVnocNKyizB5+rjHFw9zRJF1gIvR38siztbfWKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735829405; c=relaxed/simple;
	bh=FcvCM4x8AqXf8N0nyO/U2/pKvsDg8b7/cAGPA4LXcsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxY5rYO9MWpi/XgcMLLygkKIVmKkzgIgF8bp49yiUDi4JpdxnrQeB2EpH69nOw6p3gTtixBUw/zvX65Xwk2OuiHcYs80Kv2bjOxGRrb5Nk/PN/aBTtK3xBOMpM28aei5qwJ27LlU2tOGTO/dsHeTyYUgLaQHGH0eQaosex84gEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YP8XY6F8Rz9sj2;
	Thu,  2 Jan 2025 15:41:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id McPaInIxtxE5; Thu,  2 Jan 2025 15:41:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YP8XY5P4Fz9sj0;
	Thu,  2 Jan 2025 15:41:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A8DD58B767;
	Thu,  2 Jan 2025 15:41:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gkKaBOgMy8sy; Thu,  2 Jan 2025 15:41:17 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 581898B763;
	Thu,  2 Jan 2025 15:41:17 +0100 (CET)
Message-ID: <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu>
Date: Thu, 2 Jan 2025 15:41:17 +0100
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
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@linaro.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org> <Z217eBsXIaSgKuSs@x1>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z217eBsXIaSgKuSs@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arnaldo,

Le 26/12/2024 à 16:51, Arnaldo Carvalho de Melo a écrit :
> On Tue, Dec 17, 2024 at 02:18:07PM +0000, James Clark wrote:
>> On 16/12/2024 7:01 am, Christophe Leroy wrote:
>>> I noticed with 6.12 LTS Kernel that perf top and perf record/report
>>> don't display kernel symbols anymore, instead it displays the raw
>>> address with [unknown] as object.
> 
>>> After bisect I see that the problem appears with commit 659ad3492b91
>>> ("perf maps: Switch from rbtree to lazily sorted array for addresses").
>   
>> You might want to try applying 0b90dfda222e3 as it claims to fix this
>> commit. I doubt that will fix your issue but it's worth being sure.
>   
>> There was also another fix recently that could be related: 23c44f6c83
>   
>> Did you try the perf-tools-next branch? Maybe something that's already fixed
>> needs to be backported.
> 
> Right, I tried reproducing this on perf-tools-next and couldn't, so
> please test it there.
> 

I tested it again on latest perf-tools-next (ed60738a9b7e ("perf stat: 
Document and clarify outstate members")) and still have the same 
problem, all kernel symbols appear as [unknown]:

    PerfTop:    4163 irqs/sec  kernel:28.3%  exact:  0.0% lost: 0/0 
drop: 0/14199 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

      5.75%  [unknown]      [k] 0xc005f11c
      4.96%  gau            [.] engine_loop.constprop.0.isra.0
      4.31%  perf           [.] hists__findnew_entry
      4.13%  [unknown]      [k] 0xc0891c14
      3.43%  libc.so.6      [.] memset
      3.11%  perf           [.] dso__find_symbol
      2.63%  perf           [.] evsel__parse_sample
      2.23%  perf           [.] deliver_event
      2.06%  perf           [.] sort__dso_cmp
      2.02%  perf           [.] sort__sym_cmp
      1.92%  perf           [.] machine__resolve
      1.72%  libc.so.6      [.] _int_free
      1.59%  perf           [.] perf_hpp__is_dynamic_entry
      1.38%  perf           [.] __hists__add_entry.constprop.0
      1.37%  perf           [.] maps__find
      1.26%  [unknown]      [k] 0xc01f82c8
      1.24%  libc.so.6      [.] pthread_rwlock_unlock@@GLIBC_2.34
      1.20%  perf           [.] down_read
      1.18%  libc.so.6      [.] cfree@GLIBC_2.0
      1.12%  libc.so.6      [.] pthread_rwlock_rdlock@@GLIBC_2.34

Thanks,
Christophe
