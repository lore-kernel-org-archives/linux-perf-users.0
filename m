Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD00288A2;
	Tue, 17 Jun 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750139437; cv=none; b=S7QTQaip2F/+TVKEruTWT+5+ioT0tZMY0R1+B5JzNjjZc+H5zbacFzn+j0WXaJlE70arB6H8V0IbiUcrSZkIt0NTs18dR9cfuf4xhWKEr4V+cIQZsqM/6MUQfhFxmvCxMvbU7pTFeVVd4EzgPpojyoZu84kns5nXqrzqJTmJbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750139437; c=relaxed/simple;
	bh=uEe084MYLD20Ye47aOBf58ZkEPn9RS3l/N2vjxKMqN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fe7F9NzHMjj6PwKpc8V/j1HRl5T4CoPy5nCyAuOPAizwf4ypqvWxs4WZYJiz/v3srGa4+2Qo1kFsHfhFk7obnxhvr+r9qXWlT05pZ26aC6m/HzjaNqoObHKhoICMm4bgPyV3Y/w1dj/i8Eim5UpeZ1eWTfPhDKAftllQq27tLDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bLwHm1mlvz9sd1;
	Tue, 17 Jun 2025 07:23:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X2m2YD6YqrAt; Tue, 17 Jun 2025 07:23:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bLwHm0g9qz9s9J;
	Tue, 17 Jun 2025 07:23:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 024578B779;
	Tue, 17 Jun 2025 07:23:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id CP7EjGprw806; Tue, 17 Jun 2025 07:22:59 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 193128B776;
	Tue, 17 Jun 2025 07:22:59 +0200 (CEST)
Message-ID: <c57de5bf-d55c-48c5-9dfa-e2fb844dafe9@csgroup.eu>
Date: Tue, 17 Jun 2025 07:22:57 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
To: Ian Rogers <irogers@google.com>, Eric Biggers <ebiggers@google.com>,
 Yuzhuo Jing <yuzhuo@google.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Al Viro
 <viro@zeniv.linux.org.uk>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250617005800.1410112-1-irogers@google.com>
 <20250617005800.1410112-2-irogers@google.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250617005800.1410112-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/06/2025 à 02:57, Ian Rogers a écrit :
> Type punning is necessary for get/put unaligned but the use of a
> packed struct violates strict aliasing rules, requiring
> -fno-strict-aliasing to be passed to the C compiler. Switch to using
> memcpy so that -fno-strict-aliasing isn't necessary.

VDSO build fails with this patch:

   VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not 
supported
make[2]: *** [arch/powerpc/kernel/vdso/Makefile:79: 
arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1

Behind the relocation issue, calling memcpy() for a single 4-bytes word 
kills performance.

  170:   7f e4 fb 78     mr      r4,r31
  174:   38 a0 00 04     li      r5,4
  178:   38 61 00 10     addi    r3,r1,16
  17c:   93 81 00 10     stw     r28,16(r1)
  180:   48 00 00 01     bl      180 <__c_kernel_getrandom+0x180>
                         180: R_PPC_REL24        memcpy
  184:   38 81 00 10     addi    r4,r1,16
  188:   7f a3 eb 78     mr      r3,r29
  18c:   38 a0 00 04     li      r5,4
  190:   48 00 00 01     bl      190 <__c_kernel_getrandom+0x190>
                         190: R_PPC_REL24        memcpy
  194:   38 81 00 10     addi    r4,r1,16
  198:   7f e3 fb 78     mr      r3,r31
  19c:   38 a0 00 04     li      r5,4
  1a0:   93 81 00 10     stw     r28,16(r1)
  1a4:   48 00 00 01     bl      1a4 <__c_kernel_getrandom+0x1a4>
                         1a4: R_PPC_REL24        memcpy
  1a8:   37 de ff ff     addic.  r30,r30,-1
  1ac:   3b bd 00 04     addi    r29,r29,4
  1b0:   3b ff 00 04     addi    r31,r31,4
  1b4:   40 82 ff bc     bne     170 <__c_kernel_getrandom+0x170>
  1b8:   73 09 00 02     andi.   r9,r24,2
  1bc:   56 b5 00 3a     clrrwi  r21,r21,2
  1c0:   3b 7b 00 04     addi    r27,r27,4
  1c4:   3b f7 00 04     addi    r31,r23,4
  1c8:   7f 7b aa 14     add     r27,r27,r21
  1cc:   7f ff aa 14     add     r31,r31,r21
  1d0:   57 1e 07 be     clrlwi  r30,r24,30
  1d4:   41 82 00 48     beq     21c <__c_kernel_getrandom+0x21c>
  1d8:   7f 64 db 78     mr      r4,r27
  1dc:   38 a0 00 02     li      r5,2
  1e0:   7e c3 b3 78     mr      r3,r22
  1e4:   b1 c1 00 10     sth     r14,16(r1)
  1e8:   48 00 00 01     bl      1e8 <__c_kernel_getrandom+0x1e8>
                         1e8: R_PPC_REL24        memcpy
  1ec:   7e c4 b3 78     mr      r4,r22
  1f0:   7f e3 fb 78     mr      r3,r31
  1f4:   38 a0 00 02     li      r5,2
  1f8:   48 00 00 01     bl      1f8 <__c_kernel_getrandom+0x1f8>
                         1f8: R_PPC_REL24        memcpy
  1fc:   7f 63 db 78     mr      r3,r27
  200:   7e c4 b3 78     mr      r4,r22
  204:   38 a0 00 02     li      r5,2
  208:   b1 c1 00 10     sth     r14,16(r1)
  20c:   57 de 07 fe     clrlwi  r30,r30,31
  210:   48 00 00 01     bl      210 <__c_kernel_getrandom+0x210>
                         210: R_PPC_REL24        memcpy
  214:   3b 7b 00 02     addi    r27,r27,2
  218:   3b ff 00 02     addi    r31,r31,2
  21c:   2c 1e 00 00     cmpwi   r30,0
  220:   41 82 00 3c     beq     25c <__c_kernel_getrandom+0x25c>


Christophe


> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   include/vdso/unaligned.h | 48 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
> index ff0c06b6513e..81f632e3c5eb 100644
> --- a/include/vdso/unaligned.h
> +++ b/include/vdso/unaligned.h
> @@ -2,14 +2,50 @@
>   #ifndef __VDSO_UNALIGNED_H
>   #define __VDSO_UNALIGNED_H
>   
> -#define __get_unaligned_t(type, ptr) ({							\
> -	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
> -	__get_pptr->x;									\
> +#include <linux/string.h> // For memcpy.
> +
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
> +	memcpy(&__get_unaligned_val, (void *)(ptr), sizeof(__get_unaligned_val)); \
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
> +	memcpy((void *)(ptr), &__put_unaligned_val, sizeof(__put_unaligned_val)); \
>   } while (0)
>   
>   #endif /* __VDSO_UNALIGNED_H */

