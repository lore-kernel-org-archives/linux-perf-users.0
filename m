Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70319F489;
	Thu,  9 Jan 2025 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736405404; cv=none; b=b1Ixp2bx4TixWLBuUGmZDSjuK0dfqHprn5Y5XAoCmVX18CaJHsXaAIIa/Hov2YL4HupYpQJO0uMCLNRcZ4o4V8s3sJfX+58f7+sHXn7RziSaGKmXCCzKFvpKLHiRsQH4HZ5qY8OUgSkD/y1euTq6Nth2z66CXmvLE6Ka+f2LEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736405404; c=relaxed/simple;
	bh=q545NYg0HNANPRHZ5jsJMwYZnq4S0dVTEliVOsCQEb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjulWhTNtUdE0FkelXiHxW4SLZgqXWrTOavdbApV/YYjh8DPYZnvULShpTXZPt+/WnkVUkpU5KGVIgC+dkLfvjY4qTqshI8QjbbD3ltNaw4+HAoBLtutn6+trtz7ydC/UFPS5bje6YHOLpsx6iawsx7lnInpgd9lbMGtzozUPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YTFV64Thlz9sPd;
	Thu,  9 Jan 2025 07:38:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wFVIK4wTVg1Y; Thu,  9 Jan 2025 07:38:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YTFV63Lt0z9rvV;
	Thu,  9 Jan 2025 07:38:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C7298B783;
	Thu,  9 Jan 2025 07:38:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id novq1XGp-0SK; Thu,  9 Jan 2025 07:38:22 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B8D7C8B768;
	Thu,  9 Jan 2025 07:38:21 +0100 (CET)
Message-ID: <e2ec27b9-77d5-4224-b66a-1ef353e6c848@csgroup.eu>
Date: Thu, 9 Jan 2025 07:38:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf machine: Don't ignore _etext when not a text symbol
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Song Liu <songliubraving@fb.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-perf-users@vger.kernel.org
References: <b3ee1994d95257cb7f2de037c5030ba7d1bed404.1736327613.git.christophe.leroy@csgroup.eu>
 <Z37cuobj6NVRUKoo@x1>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z37cuobj6NVRUKoo@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/01/2025 à 21:14, Arnaldo Carvalho de Melo a écrit :
> On Wed, Jan 08, 2025 at 10:15:24AM +0100, Christophe Leroy wrote:
>> Depending on how vmlinux.lds is written, _etext might be the very
>> first data symbol instead of the very last text symbol.
>>
>> Don't require it to be a text symbol, accept any symbol type.
> 
> I'm adding a Link:
> 
> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F752a31b0-4370-4f52-b7cc-45f0078c1d6c%40csgroup.eu&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C914f4c7995574ee91f5c08dd30211dd6%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638719640997470461%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=kqCNbhhgKri3TlJaUb3mkTU6NyFRzhnb%2BDiK93h9aSQ%3D&reserved=0
> 
> To give more context as where this has been observed, and also add a
> snippet of your explanation there, this:
> 
> ----
> # grep -e _stext -e _etext -e _edata /proc/kallsyms
> c0000000 T _stext
> c08b8000 D _etext
> 
> So there is no _edata and _etext is not text

For the absence of _edata, I sent another patch, will you take it as 
well ? :

https://lore.kernel.org/linux-perf-users/2fec8c50c271dff59f0177ff0884b6c374486ba5.1736327770.git.christophe.leroy@csgroup.eu/T/#u

Thanks
Christophe

