Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160E292908;
	Tue, 17 Jun 2025 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152037; cv=none; b=Zo8mx6aKdxJaja8I0hqLLo65UWv+S3OXu/Zaufku6hNf+c5Uk0BdQrOuMVEUNPY80muesOwyTv6PzTe8AhLlPAiYuOu2RDpONcjeo8iLH4jSRvpYovyqzehYHOWmo3didcIFWRQMTjrfQF9LIfMqrrKHbh9p8QwP27ndZVAnoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152037; c=relaxed/simple;
	bh=1rW3HyzSPxA0/G9x8QtoS7aCPRrs9W8sVGPbPsEVwEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYClOlQbPYBU8/8D8SsllbjIRh4PSu8tv2ARaLJ3Qhe+sbN3f5z0JiWWS4geIAruF0T4aff+oZtqxHGElio57czdLBcejVZaZUfARpZ3LfEfmjs2cUs20VStt/4h2V16s8lLpOg2ofwCSleYUL9ZwnC60mmWoVOlkZGAnmZ4ufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bM1Pg14fhz9t0K;
	Tue, 17 Jun 2025 11:13:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ezM8RTf2JjnU; Tue, 17 Jun 2025 11:13:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bM1Pg09FTz9syQ;
	Tue, 17 Jun 2025 11:13:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 007768B77E;
	Tue, 17 Jun 2025 11:13:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Vgg_-T-pTeIY; Tue, 17 Jun 2025 11:13:26 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CA048B776;
	Tue, 17 Jun 2025 11:13:26 +0200 (CEST)
Message-ID: <cc895e8c-5dd5-4207-bb35-58e6b923b7bc@csgroup.eu>
Date: Tue, 17 Jun 2025 11:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Yuzhuo Jing <yuzhuo@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Al Viro
 <viro@zeniv.linux.org.uk>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20250617005800.1410112-1-irogers@google.com>
 <20250617005800.1410112-2-irogers@google.com>
 <c57de5bf-d55c-48c5-9dfa-e2fb844dafe9@csgroup.eu> <20250617063236.GI8289@sol>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250617063236.GI8289@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+linuxppc list

Le 17/06/2025 à 08:32, Eric Biggers a écrit :
> On Tue, Jun 17, 2025 at 07:22:57AM +0200, Christophe Leroy wrote:
>>
>>
>> Le 17/06/2025 à 02:57, Ian Rogers a écrit :
>>> Type punning is necessary for get/put unaligned but the use of a
>>> packed struct violates strict aliasing rules, requiring
>>> -fno-strict-aliasing to be passed to the C compiler. Switch to using
>>> memcpy so that -fno-strict-aliasing isn't necessary.
>>
>> VDSO build fails with this patch:
>>
>>    VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
>> arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not
>> supported
>> make[2]: *** [arch/powerpc/kernel/vdso/Makefile:79:
>> arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1
>>
>> Behind the relocation issue, calling memcpy() for a single 4-bytes word
>> kills performance.
> 
> memcpy() does normally do the right thing for unaligned accesses of 1, 2, 4, or
> 8-byte values.  The snag here seems to be that the VDSO is built with
> -fno-builtin (and -ffreestanding which implies -fno-builtin).  That causes the
> compiler to no longer optimize out the calls to memcpy().  If __builtin_memcpy()
> is used instead of memcpy(), it does work and generates the same code as before.

Yes right, changing memcpy() to __builtin_memcpy() seems to work, the 
exact same code is generated.

Christophe
