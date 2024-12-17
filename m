Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE21F63CB
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447045; cv=none; b=toD1hmVfd0Miuie/lwEo78bLIYSpzW5VUIVcst1/CbMTSsmHyN8GHGoTRjhGEOgz9QL5DRmj88gb6WX6mkG2ItuhGXSefllCw1tosmU0q9x6wGYChgiwMWNpM/fR4yIrrRmNspZnlngEirRk4eLaPOeqJ799mbkiHJ0AHffDLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447045; c=relaxed/simple;
	bh=evz3FSlt2HDUhy2SfqQBsX1MC9PLNcb0SiqRUtBnb+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgGCs1x/VbHya5FbS2x50iLj1+s3AoKblwQBMkPQGxORTK77gZIZIOwzDVWaTqh1PzrdZ/A3iIjj56dv1hGo7/yv0RpoTSMEDOgY1W+0zKU/vQTmxtqdJFZv0AgasbOtIoRaYDe7HdeIerGI1bZi+7ngQQoPF3NKuAeJqoV4yuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YCKVn133Cz9sPd;
	Tue, 17 Dec 2024 15:50:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eijtt5s9l1qs; Tue, 17 Dec 2024 15:50:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YCKVn0DZ9z9rvV;
	Tue, 17 Dec 2024 15:50:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EA5F08B770;
	Tue, 17 Dec 2024 15:50:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id cho00yuRFv8a; Tue, 17 Dec 2024 15:50:40 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 77BCA8B763;
	Tue, 17 Dec 2024 15:50:40 +0100 (CET)
Message-ID: <587e97b9-3c7a-4a34-a792-a8208896f316@csgroup.eu>
Date: Tue, 17 Dec 2024 15:50:40 +0100
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
To: James Clark <james.clark@linaro.org>,
 "irogers@google.com" <irogers@google.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/12/2024 à 15:18, James Clark a écrit :
> [Vous ne recevez pas souvent de courriers de james.clark@linaro.org. 
> Découvrez pourquoi ceci est important à https://aka.ms/ 
> LearnAboutSenderIdentification ]
> 
> On 16/12/2024 7:01 am, Christophe Leroy wrote:
>> Hi,
>>
>> I noticed with 6.12 LTS Kernel that perf top and perf record/report
>> don't display kernel symbols anymore, instead it displays the raw
>> address with [unknown] as object.
>>
>> After bisect I see that the problem appears with commit 659ad3492b91
>> ("perf maps: Switch from rbtree to lazily sorted array for addresses").
> 
> Hi Christophe,

Hi James,

> 
> You might want to try applying 0b90dfda222e3 as it claims to fix this
> commit. I doubt that will fix your issue but it's worth being sure.

It doesn't fix the problem.

> 
> There was also another fix recently that could be related: 23c44f6c83
> 
> Did you try the perf-tools-next branch? Maybe something that's already
> fixed needs to be backported.
> 

I didn't, trying it now and facing the following issue:

A new definition of MAX_NR_CPUS is added by commit e8399d34d568 
("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS"), conflicting with 
the -DMAX_NR_CPUS=1 that I provide as EXTRA_CFLAGS for the reason 
explained in commit 21b8732eb447 ("perf tools: Allow overriding 
MAX_NR_CPUS at compile time")

After fixing that, I'm now able to build it and test it. Unfortunately 
it doesn't solve the issue.

Christophe
