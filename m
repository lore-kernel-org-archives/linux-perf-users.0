Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646B92DBF48;
	Wed, 18 Jun 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247439; cv=none; b=IY/LD1qQqKwsUPkqswNpEuRPe3Uze0Al88xvPORHssyXB5Umdn6hoPuWV1c/oH3NYQKcSl1yRreIGUzNEiaNQwO9+VtYP8l8rbnOxiokTIb8zTMDwFlO42ZCYh4Ik369e3zeRnRn6lpuRi9S1iGTWh0gaolyhkpmGNr9mh/xeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247439; c=relaxed/simple;
	bh=f5OXUnIUEcf+xZ62f4DGz/lDYYcIVdbgfqa0hCHMayc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TnjzIimciJSxU4q8g6aQH9/ZSqqu5XGNELCsySMrJjbvJlqq2oURZH6vHYwWKACS67NjxRO7h8fFcPXrandDkVXHo3fyrlTm6qdUXGvpmOfnCIp3ifEHINNR6lt+XnPHDGhv39bPvixS1A5gQR2D1fZ5q5L/UAl6RIerri6XVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bMhd413gfz9sbF;
	Wed, 18 Jun 2025 13:40:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KVjq-hlsqxck; Wed, 18 Jun 2025 13:40:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bMhd40JLRz9s92;
	Wed, 18 Jun 2025 13:40:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0464B8B780;
	Wed, 18 Jun 2025 13:40:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id piyRZmYCKMVs; Wed, 18 Jun 2025 13:40:39 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 962D28B776;
	Wed, 18 Jun 2025 13:40:39 +0200 (CEST)
Message-ID: <407e34df-522a-40fb-943c-74351bcb28d5@csgroup.eu>
Date: Wed, 18 Jun 2025 13:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
To: Ian Rogers <irogers@google.com>, Eric Biggers <ebiggers@google.com>,
 Yuzhuo Jing <yuzhuo@google.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Al Viro
 <viro@zeniv.linux.org.uk>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250617205320.1580946-1-irogers@google.com>
 <20250617205320.1580946-2-irogers@google.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250617205320.1580946-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/06/2025 à 22:53, Ian Rogers a écrit :
> Type punning is necessary for get/put unaligned but the use of a
> packed struct violates strict aliasing rules, requiring
> -fno-strict-aliasing to be passed to the C compiler. Switch to using
> memcpy so that -fno-strict-aliasing isn't necessary.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>



> ---
>   include/vdso/unaligned.h | 48 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
> index ff0c06b6513e..f33c1eefbf68 100644
> --- a/include/vdso/unaligned.h
> +++ b/include/vdso/unaligned.h
> @@ -2,14 +2,50 @@
>   #ifndef __VDSO_UNALIGNED_H
>   #define __VDSO_UNALIGNED_H
>   
> -#define __get_unaligned_t(type, ptr) ({							\
> -	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
> -	__get_pptr->x;									\
> +#define ____get_unaligned_type(type) type: (type)0
> +/**
> + * __get_unaligned_t - read an unaligned value from memory.
> + * @ptr:	the pointer to load from.
> + * @type:	the type to load from the pointer.
> + *
> + * Use memcpy to affect an unaligned type sized load avoiding undefined behavior
> + * from approaches like type punning that require -fno-strict-aliasing in order
> + * to be correct. As type may be const, use _Generic to map to a non-const type
> + * - you can't memcpy into a const type. The void* cast silences ubsan warnings.
> + */
> +#define __get_unaligned_t(type, ptr) ({					\
> +	type __get_unaligned_map_ctrl = 0;				\
> +	typeof(_Generic(__get_unaligned_map_ctrl,			\
> +		____get_unaligned_type(short int),			\
> +		____get_unaligned_type(unsigned short int),		\
> +		____get_unaligned_type(int),				\
> +		____get_unaligned_type(unsigned int),			\
> +		____get_unaligned_type(long),				\
> +		____get_unaligned_type(unsigned long),			\
> +		____get_unaligned_type(long long),			\
> +		____get_unaligned_type(unsigned long long),		\
> +		default: (type)0					\
> +		)) __get_unaligned_val;					\
> +	(void)__get_unaligned_map_ctrl;					\
> +	__builtin_memcpy(&__get_unaligned_val, (void *)(ptr),		\
> +			 sizeof(__get_unaligned_val));			\
> +	__get_unaligned_val;						\
>   })
>   
> -#define __put_unaligned_t(type, val, ptr) do {						\
> -	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
> -	__put_pptr->x = (val);								\
> +/**
> + * __put_unaligned_t - write an unaligned value to memory.
> + * @type:	the type of the value to store.
> + * @val:	the value to store.
> + * @ptr:	the pointer to store to.
> + *
> + * Use memcpy to affect an unaligned type sized store avoiding undefined
> + * behavior from approaches like type punning that require -fno-strict-aliasing
> + * in order to be correct. The void* cast silences ubsan warnings.
> + */
> +#define __put_unaligned_t(type, val, ptr) do {				\
> +	type __put_unaligned_val = (val);				\
> +	__builtin_memcpy((void *)(ptr), &__put_unaligned_val,		\
> +			 sizeof(__put_unaligned_val));			\
>   } while (0)
>   
>   #endif /* __VDSO_UNALIGNED_H */

