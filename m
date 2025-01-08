Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E514F9FD;
	Wed,  8 Jan 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736356806; cv=none; b=FsRklac+y+H7iyK5MXdofI9tw96dYjbfTDFlJOewVB2aNrOQr/Y1ABqYUapEP49HTkIXzRToBkAfG8JJVD6flSJDQYtBA7hF5C4iAVhmJjfTm7C4gLuzP8ZK3c58DX8QUr6kXa4BZVinP86CjhQpgesIGqP8lYKhu10f2WjKue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736356806; c=relaxed/simple;
	bh=xxQJqbxd3v6L+1p5RlNNTsjeXDKHHo6uGfrffY8XRys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsA78QDPRH2ERFffo+o1u7NjYZcHRR3E6P1aKh/qqj6aDgzsZC2J/CtM7ddXxLkUw/3Exl8IYSE31+uWc29mWswkTm6Q8FvGurwF6eE5ZJzASY5oO38bNn1yvpQhNJiwibcIVO7B+3T3BuhpMD7wfnau9IYFfEkVyxURPjpjUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YSvSs1ctnz9sPd;
	Wed,  8 Jan 2025 18:06:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8u17lnlhSuRt; Wed,  8 Jan 2025 18:06:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YSvSs0m5Cz9rvV;
	Wed,  8 Jan 2025 18:06:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 076A68B783;
	Wed,  8 Jan 2025 18:06:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id wBdH3uy-PuNr; Wed,  8 Jan 2025 18:06:04 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CA318B768;
	Wed,  8 Jan 2025 18:06:04 +0100 (CET)
Message-ID: <590b2f02-f7f0-48b2-b45e-8a31bbadef2a@csgroup.eu>
Date: Wed, 8 Jan 2025 18:06:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf: Fix display of kernel symbols
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <2ea4501209d5363bac71a6757fe91c0747558a42.1736329923.git.christophe.leroy@csgroup.eu>
 <Z36Ra23US_zC3n2v@x1>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z36Ra23US_zC3n2v@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/01/2025 à 15:53, Arnaldo Carvalho de Melo a écrit :
> On Wed, Jan 08, 2025 at 10:54:20AM +0100, Christophe Leroy wrote:
>> Since commit 659ad3492b91 ("perf maps: Switch from rbtree to lazily
>> sorted array for addresses"), perf doesn't display anymore kernel
>> symbols on powerpc, allthough it still detects them as kernel addresses.
>>
>> 	# Overhead  Command     Shared Object  Symbol
>> 	# ........  ..........  ............. ......................................
>> 	#
>> 	    80.49%  Coeur main  [unknown]      [k] 0xc005f0f8
>> 	     3.91%  Coeur main  gau            [.] engine_loop.constprop.0.isra.0
>> 	     1.72%  Coeur main  [unknown]      [k] 0xc005f11c
>> 	     1.09%  Coeur main  [unknown]      [k] 0xc01f82c8
>> 	     0.44%  Coeur main  libc.so.6      [.] epoll_wait
>> 	     0.38%  Coeur main  [unknown]      [k] 0xc0011718
>> 	     0.36%  Coeur main  [unknown]      [k] 0xc01f45c0
>>
>> This is because function maps__find_next_entry() now returns current
>> entry instead of next entry, leading to kernel map end address
>> getting mis-configured with its own start address instead of the
>> start address of the following map.
>>
>> Fix it by really taking the next entry, also make sure that entry
>> follows current one by making sure entries are sorted.
>>
>> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> ---
>> v2: Make sure the entries are sorted, if not sort them.
> 
> Since you have changed what I reviewed I'll have to re-review :-) Will
> try to do it after some calls.

Ah yes sorry, should have removed your Reviewed-by.

Based on Ian's feedback "Using the next entry in this way won't work if 
the entries aren't sorted", I added the following block in front of the 
initial change:

+	while (!maps__maps_by_address_sorted(maps)) {
+		up_read(maps__lock(maps));
+		maps__sort_by_address(maps);
+		down_read(maps__lock(maps));
+	}

Christophe

