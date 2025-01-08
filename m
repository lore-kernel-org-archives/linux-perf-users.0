Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4719A15853B
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360408; cv=none; b=qqQaJRcI6kHL07vAqHNVgOPHia2JvrfAjPRDJnBE8D1O12gNJdICie9rOaqAwCPvowaMIA/odWbeS8qzTpDA7R21/bB3b/vI/QTCIksfBdbEZxiQsC0mKFI+CvZkUNfiQO+24GOd/CTN9ih6CDWBELaj8G76V3S9Df1gO6KrvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360408; c=relaxed/simple;
	bh=FDLSo8zCSBrZilXL2MyxJ65EFR6amqNwWX7yPlpdMUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeAPb5XJAsh//D24x5jjuKcoMqpUtKq3MxuaQSTdEF5kxYWFL8SqTzg7xkCICq0I3TDGS8oYhIg3OHnFUZ4P7rrg+avlnNT/oP5vZVNnpUObnuGKKFTvu/zY6cAZIA2aYIpn4us59T20q4MIyUEtsnMnAdgVC+Ae/gxeBWe6R84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YSwYZ4lk8z9sPd;
	Wed,  8 Jan 2025 18:55:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ATU5y-duZQVG; Wed,  8 Jan 2025 18:55:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YSwYZ408mz9rvV;
	Wed,  8 Jan 2025 18:55:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7853E8B783;
	Wed,  8 Jan 2025 18:55:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id JyxhuDd45FHW; Wed,  8 Jan 2025 18:55:14 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 17D168B768;
	Wed,  8 Jan 2025 18:55:14 +0100 (CET)
Message-ID: <4e4ffc4f-e8dd-4771-bf97-8b372b1c97e0@csgroup.eu>
Date: Wed, 8 Jan 2025 18:55:13 +0100
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
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@linaro.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Ian Rogers <irogers@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org> <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu> <Z3bYltoidQpqtyJ_@x1>
 <48724052-4003-4140-8106-f9ea098cedcb@csgroup.eu> <Z3c4nupM-UENN5LM@x1>
 <5b8ec160-4b50-4736-8012-30ae35c45028@csgroup.eu> <Z3gPncBcCnZiNy57@x1>
 <752a31b0-4370-4f52-b7cc-45f0078c1d6c@csgroup.eu>
 <Z3xPHSrVInsc6W6I@google.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z3xPHSrVInsc6W6I@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/01/2025 à 22:46, Namhyung Kim a écrit :
>>
>> And in System.map I have:
>>
>> c136a000 D __start___bug_table
>> c1377c14 D __stop___bug_table
>> c1378000 B __bss_start
>> c1378000 B _edata
>> c1378000 B initcall_debug
>> c1378004 B reset_devices
>>
>> Should perf try to locate the very last symbol when it doesn't find _edata ?
>> Or should architecture's link script be modified ? Otherwise commit
>> 69a87a32f5cd ("perf machine: Include data symbols in the kernel map") is
>> just pointless.
> 
> Let's go with kallsyms__get_symbol_start().  I think it's the most
> straight-forward and simplest fix.
> 

Ok, I did that, see patch 
https://lore.kernel.org/linux-perf-users/b3ee1994d95257cb7f2de037c5030ba7d1bed404.1736327613.git.christophe.leroy@csgroup.eu/T/#u

And for the _edata which is sometimes missing, I send patch 
https://lore.kernel.org/linux-perf-users/2fec8c50c271dff59f0177ff0884b6c374486ba5.1736327770.git.christophe.leroy@csgroup.eu/T/#u

Christophe
