Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A802C3258;
	Wed, 18 Jun 2025 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247443; cv=none; b=UaIDVaDr4XiVtpsmzOh0kmberU+qo6oXdxODhNixOpi5JET6z/eHbDdfoDa3ObRS6u+VXQUmmh+cLyZOpc+ZTAglJt+mhWAKog48dOgyMv3obKbHsO2Eiw1Krrv1HHjc4GDPc1Ob4Gjr3PlIXZszATQ0LbbXPKcfZ3v7g7mn2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247443; c=relaxed/simple;
	bh=58scXsAkA4t48fEoJuCh83iHGTHverEVaA23zpz119U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PLNELBpfJw5FOwfMgK0862TgKkr0IqhNJCvVrohKeWCQz+oDtaBZs567BZG5Rz43ODKMOoSwHEHIBXSEcqdA4kv1Ecl0uMGx9n729e+xFJUncgylkLqUicD6Vb8v9JhNDHTGrjfFczQVYgIeOvXFJ7rlcNwsiUdO9Fg8Ae0d8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bMhgf51jhz9scZ;
	Wed, 18 Jun 2025 13:42:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fmCp2zo6kAVw; Wed, 18 Jun 2025 13:42:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bMhgf4Fcxz9scH;
	Wed, 18 Jun 2025 13:42:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B7228B780;
	Wed, 18 Jun 2025 13:42:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id KNGxpyBZzbGS; Wed, 18 Jun 2025 13:42:54 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 18F7F8B776;
	Wed, 18 Jun 2025 13:42:54 +0200 (CEST)
Message-ID: <51bc73ca-3b1f-4f1a-b75b-7bdeffd7a395@csgroup.eu>
Date: Wed, 18 Jun 2025 13:42:53 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Switch get/put unaligned to use memcpy
To: Ian Rogers <irogers@google.com>, Eric Biggers <ebiggers@google.com>,
 Yuzhuo Jing <yuzhuo@google.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Al Viro
 <viro@zeniv.linux.org.uk>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250617205320.1580946-1-irogers@google.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250617205320.1580946-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/06/2025 à 22:53, Ian Rogers a écrit :
> The existing type punning approach with packed structs requires
>   -fno-strict-aliasing to be passed to the compiler for
> correctness. This is true in the kernel tree but not in the tools
> directory resulting in this suggested patch from Eric Biggers
>   <ebiggers@google.com>:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20250614044133.660848-2-ebiggers%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf05413010ecc40ad1bdf08ddade1316a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638857904894967529%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=29QUBLnUowncZiTH4z74Ec1olUlX0OTYnUNGDvWxX1o%3D&reserved=0
> 
> Requiring -fno-strict-aliasing seems unfortunate and so this patch
> makes the unaligned code work via memcpy for type punning rather than
> the packed attribute.
> 
> v2: switch memcpy to __builtin_memcpy to avoid potential/disallowed
>      memcpy calls in vdso caused by -fno-builtin. Reported by
>      Christophe Leroy <christophe.leroy@csgroup.eu>:
>      https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2Fc57de5bf-d55c-48c5-9dfa-e2fb844dafe9%40csgroup.eu%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf05413010ecc40ad1bdf08ddade1316a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638857904894985987%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=l1LJP3XPKVuhDpiHxxkfWBiNPMYaBT9YXGBFzs6wLpY%3D&reserved=0
> 

Does this new version also fixes the failures reported by the robots:
- arm64-randconfig with clang 21
- i386-randconfig with gcc 12

Christophe

> Ian Rogers (3):
>    vdso: Switch get/put unaligned from packed struct to memcpy
>    tools headers: Update the linux/unaligned.h copy with the kernel
>      sources
>    tools headers: Remove unneeded ignoring of warnings in unaligned.h
> 
>   include/vdso/unaligned.h        | 48 ++++++++++++++++++++++++++++-----
>   tools/include/linux/unaligned.h |  4 ---
>   tools/include/vdso/unaligned.h  | 48 ++++++++++++++++++++++++++++-----
>   3 files changed, 84 insertions(+), 16 deletions(-)
> 

