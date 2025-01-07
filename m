Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356EF1D7E47;
	Tue,  7 Jan 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239807; cv=none; b=LnUpNYfQbV70XljxKeHIrIxKXpOQt9J1grDAswAB/5kaAPtw0/lMoBEXzJUHHY4vgHwJYytMBdaNfJjkPHksP6PBBVGcWkzKOE8TAw8kyAmLSyP9F/g9hVgjTAfi6ip9bDMgQlmYwuytEoHW9fd/Vw1AdGTxKBp22kyN7BAilqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239807; c=relaxed/simple;
	bh=YQTMNIxSLGB/Wa5Ta6pq+NW3OJ76deWxc6uMXXiW7Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTzPkvyoAD+lczbKQ7OYHuJ6wsksfFFnXi8b3j+wmR4Tvas2TIjTFH+2IcndxMwQ95AhvcAXNFwYyyVTl2EiOcsy3VViGrnzQUquVvk5S86aTHDdhcByaKIIi3Ax8KRZhakYCaJc7un1PNWgEESHHeIYGgkn3sTwfwAdbcPbO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YS45p0dpCz9sPd;
	Tue,  7 Jan 2025 09:31:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jk1VJOcVdokO; Tue,  7 Jan 2025 09:31:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YS45n6XFfz9rvV;
	Tue,  7 Jan 2025 09:31:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CAFA08B765;
	Tue,  7 Jan 2025 09:31:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id EimS5cl3j85D; Tue,  7 Jan 2025 09:31:41 +0100 (CET)
Received: from [10.25.209.139] (unknown [10.25.209.139])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7488B8B764;
	Tue,  7 Jan 2025 09:31:41 +0100 (CET)
Message-ID: <fa5dfd6d-3b8d-4086-9604-e5abddd324c9@csgroup.eu>
Date: Tue, 7 Jan 2025 09:31:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libperf: Add back guard on MAX_NR_CPUS
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
References: <8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu>
 <CAP-5=fWVHaVpJbDf=afn5MhZ972uEq=sGEmsULoD=LRff2Vouw@mail.gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <CAP-5=fWVHaVpJbDf=afn5MhZ972uEq=sGEmsULoD=LRff2Vouw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/01/2025 à 21:05, Ian Rogers a écrit :
> On Mon, Jan 6, 2025 at 11:38 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>> Building perf with EXTRA_CFLAGS="-DMAX_NR_CPUS=1" fails:
>>
>>            CC      /home/chleroy/linux-powerpc/tools/perf/libperf/cpumap.o
>>          cpumap.c:16: error: "MAX_NR_CPUS" redefined [-Werror]
>>             16 | #define MAX_NR_CPUS 4096
>>                |
>>          <command-line>: note: this is the location of the previous definition
>>
>> Commit e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS")
>> moved definition of MAX_NR_CPUS from lib/perf/include/internal/cpumap.h
>> to lib/perf/cpumap.c but the guard surrounding that definition got lost
>> in the move.
>>
>> See commit 21b8732eb447 ("perf tools: Allow overriding MAX_NR_CPUS at
>> compile time") to see why it is needed.
>>
>> Note that MAX_NR_CPUS was initialy defined in perf/perf.h and a
>> redundant definition was added by commit 9c3516d1b850 ("libperf:
>> Add perf_cpu_map__new()/perf_cpu_map__read() functions").
>>
>> A cleaner fix would be to remove that duplicate but for the time
>> being fix the problem by bringing back the guard for when MAX_NR_CPUS
>> is already defined.
>>
>> Fixes: e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hello,
> 
> I believe this change might be unnecessary. The only use of
> MAX_NR_CPUS is in a warning message within perf_cpu_map__new, which
> takes a string and produces a perf_cpu_map. Other similar functions
> like cpu_map__new_sysconf don't check MAX_NR_CPUS. Therefore,
> specifying a -DMAX_NR_CPUS value on the build command line has little
> effect—it only impacts a warning message for certain kinds of
> perf_cpu_map creation. It's also unclear what the intended outcome is
> on the build command line.
> 
> Given that specifying the value doesn't seem to have a clear purpose,
> allowing the build to break might be the best option. This would alert
> the person building perf that they are doing something that doesn't
> make sense.
> 

Ok so I looked at it once more and indeed it looks like it has changed 
since 2017. See commit 21b8732eb447 ("perf tools: Allow overriding 
MAX_NR_CPUS at compile time") to understand why it was required at that 
time.

Now I don't have much size difference anymore between a build with 
MAX_NR_CPUS=1 and the default MAX_NR_CPUS=4096:

$ size perf perf-1cpu
    text	   data	    bss	    dec	    hex	filename
3415908	 104164	  17148	3537220	 35f944	perf
3415904	 104164	  16124	3536192	 35f540	perf-1cpu

Apparently that was changed by commit 6a1e2c5c2673 ("perf stat: Remove a 
set of shadow stats static variables")

So I agree with you, it is apparently not worth reducing MAX_NR_CPUS 
anymore, I'll give it a try.

Thanks
Christophe
