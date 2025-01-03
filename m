Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD31F9426
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735908607; cv=none; b=JRH0KfY9q3F4NxdosJoJm0S3eLxufdQsVVf7MK65wUAEA4x67Slnzvt9BgEu747wz4GWo5zbXEC73rh5Ma+1x1P+lCjOQq+Gm3YbOxA0yVg8jjoOmm8cREoiiHrXE4qcEi5bQT0AFyY70lysh1KnXSgA2l2ubxfqDKTy9irhpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735908607; c=relaxed/simple;
	bh=oyaGhIQ49KEJ6V7MgMLGYLNBnvl1WPw+gSvd+m9C8jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTaokFC2CHSmPPo8OdW4PPxLiXYtrNMsGET4p2tqJVoo/qbc43kcjHlSXNFdYBuTdv1YrPe9v4StuMszpDs4bcNyxCr5cdgURxuA4B2Q9IVV6mgnJ6KRUpKuSCAxOj8I0jzSBfbs8I7hgQcHXhgFQjxOeEpygRpoorTAiizxtsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YPjpd4lCdz9shv;
	Fri,  3 Jan 2025 13:40:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QFyVORTGStgJ; Fri,  3 Jan 2025 13:40:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YPjpd3rspz9sht;
	Fri,  3 Jan 2025 13:40:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CC098B767;
	Fri,  3 Jan 2025 13:40:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id cgx72whqZTiV; Fri,  3 Jan 2025 13:40:25 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F6AA8B763;
	Fri,  3 Jan 2025 13:40:25 +0100 (CET)
Message-ID: <5b8ec160-4b50-4736-8012-30ae35c45028@csgroup.eu>
Date: Fri, 3 Jan 2025 13:40:24 +0100
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
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org> <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu> <Z3bYltoidQpqtyJ_@x1>
 <48724052-4003-4140-8106-f9ea098cedcb@csgroup.eu> <Z3c4nupM-UENN5LM@x1>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z3c4nupM-UENN5LM@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/01/2025 à 02:08, Arnaldo Carvalho de Melo a écrit :
>>     PerfTop:     524 irqs/sec  kernel:51.1%  exact:  0.0% lost: 0/0 drop: 0/0
>> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
>> -------------------------------------------------------------------------------
>>
>>      17.18%  [unknown]      [k] 0xc0891c14
>>       7.63%  [unknown]      [k] 0xc005f11c
> 
> I think I hadn't notice this '[unknown]' one bit before :-\ the [k] is
> there, so having unknown is odd
> 

Problem found, it's in maps__find_next_entry(), this leads to both 
map->start and map->end of kernel map being set to 0xc0000000, which 
leads to the failure of bsearch() in maps__find().

Second problem is a build issue in perf-tools-next due to commit 
e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS"), see 
commit 21b8732eb447 ("perf tools: Allow overriding MAX_NR_CPUS at 
compile time") to know why this is needed.

By the way I'm wondering why we need a duplicated definition of 
MAX_NR_CPUS with different values. Second definition was added by commit 
9c3516d1b850 ("libperf: Add perf_cpu_map__new()/perf_cpu_map__read() 
functions")

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index fcc47214062a..12eaa6955121 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -13,7 +13,9 @@
  #include "internal.h"
  #include <api/fs/fs.h>

+#ifndef MAX_NR_CPUS
  #define MAX_NR_CPUS 4096
+#endif

  void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
  {
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 432399cbe5dd..d39bf27a5fdd 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1137,7 +1137,7 @@ struct map *maps__find_next_entry(struct maps 
*maps, struct map *map)

  	down_read(maps__lock(maps));
  	i = maps__by_address_index(maps, map);
-	if (i < maps__nr_maps(maps))
+	if (++i < maps__nr_maps(maps))
  		result = map__get(maps__maps_by_address(maps)[i]);

  	up_read(maps__lock(maps));


Christophe

