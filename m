Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A17E574;
	Mon, 14 Oct 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908404; cv=none; b=Bf0xpycgnFzWO3QR1+V9NKgkKyjN6lDhcHsAolQcsLuQ60dEyJrFmGETX7cqvEm1BI80FJg6ZFg2Pn7xt2PGXaW8wsDwg45FmbAB4a5RghG9dVkdV2GfKJtNWCUsyR5yOFIKNGDF7V6ZjrCmHrR+oKZDoFyLVhhp8a43GhBGWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908404; c=relaxed/simple;
	bh=mQqrgzwu0jt5rSoYM4spEu8ef/QuqM6sL/+T+yEJBHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZACQjOLrguhnXTq97tFkewhmWRLr3mUSvg6U/5+HhSSEzMNK1rGqvCmciCdbVEL5FbIJ1wfLQh8eRaexaOn1zzXZePCBhKAz/mIoGsCtOvbvhiQrwqgMcwVNq24RWze+or0Rjueorcs/ZQBh9t+8lke8IG/LdBYz77qBhGSU+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431291b27f1so17167705e9.0;
        Mon, 14 Oct 2024 05:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728908401; x=1729513201;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHuFg0NK+zjmEx/G5vz8OO9LP1BHrzCHldS9Ixk4MPE=;
        b=Cv1GTx/gANrac8Jd0AfGP7eeeInqsTXLt/OhDkAJ0cQbf9wFBRP16r+dId9PwojC/D
         lAHYx6MlM5N5xIbc5CHWz9I6+zkYW7Jf2yPasEF1pFjtuIoX9kZd4Qu8Z3GMpgyH4lAz
         c1Q6omP7vuiVn0xAEE3Mtq7PflD3vwZppyS6/BfQFoqm970C2kLqAu1tRKe1kLAbyeRo
         LhYNFlQvLFQpycZlnkOkQLdpGCIjKxojKonkKIlA4ILwYqTUYWOEcVpPaYviaCK/o/+C
         XuVsRcvzqaNogBSafqvI8TTM3wgbz51wiIQ5xxufnj4sDMyAEC22OIUmD681PbbC+t4p
         R8mw==
X-Forwarded-Encrypted: i=1; AJvYcCV1XLYruKzinNRBk/v5Psq2Oj7b0L9f+kdRzC4286kkwofomrx40aLmtMy4hlMONdEv0cDTkr9lR0rF5zY=@vger.kernel.org, AJvYcCV8UaZ/rXed0hzE9HQUzT4P3bfyHF7Uk3/Ad/dy2tcmIWNsDqUzn/0VLmAZrDgCuNZZZZPLdNS5Le8RblbqUeIwXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGLEhFXJFCJh/Y5gKN+g4Ju7R7F7uEPcTsGlCSLUQLweokWe0o
	4YKADU+z6vgU+TldifcdTkpInnpG16/pobgQxeCeUesX4gpk3kyf
X-Google-Smtp-Source: AGHT+IGGGoOpWmsT49gBqmtSXih/51qistlF1wSVcDiURBl7YsgBSvUB9EehrRpBfVgUhn1qbmXt7g==
X-Received: by 2002:a05:600c:350f:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-4311dee8073mr111030045e9.17.1728908400729;
        Mon, 14 Oct 2024 05:20:00 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4420sm152753405e9.34.2024.10.14.05.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 05:19:59 -0700 (PDT)
Message-ID: <2a91f9d0-8950-4936-9776-7ba59ab1d42a@kernel.org>
Date: Mon, 14 Oct 2024 14:19:58 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>
 <ZtYJ0z8f-1jwYSbV@x1> <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
 <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
 <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
 <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>
 <ZwgAzde-jVyo4cSu@google.com> <ZwgBenahw7EImQLk@google.com>
 <ZwhA1SL706f60ynd@x1>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <ZwhA1SL706f60ynd@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10. 10. 24, 23:02, Arnaldo Carvalho de Melo wrote:
> On Thu, Oct 10, 2024 at 09:31:54AM -0700, Namhyung Kim wrote:
>> On Thu, Oct 10, 2024 at 09:29:01AM -0700, Namhyung Kim wrote:
>>> On Thu, Oct 10, 2024 at 10:22:12AM +0200, Jiri Slaby wrote:
>>>>  From 3d4f06d79c949a8f155c20652b4f685540899ad4 Mon Sep 17 00:00:00 2001
>>>> From: Jiri Slaby <jslaby@suse.cz>
>>>> Date: Thu, 10 Oct 2024 09:57:07 +0200
>>>> Subject: [PATCH] perf: fix non-listed archs
> 
>>>> Suggested-by: Howard Chu <howardchu95@gmail.com>
>>>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> 
>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>   
>> Also with,
>   
>> Fixes: 7a2fb5619cc1fb53 ("perf trace: Fix iteration of syscall ids in syscalltbl->entries")
>   
>>> Arnaldo, can you please pick this up for v6.12?
> 
> Sure, probably the safest bet now, but just in case, Jiri, can you test
> the following?
> 
> - Arnaldo
> 
>  From a93dff5b66fb319d700c968de1906a0868a505dc Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Thu, 10 Oct 2024 17:52:19 -0300
> Subject: [PATCH 1/1] perf tools arm: Generate syscalltbl.c from arm's
>   syscall.tbl
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

With this:
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
  ifneq ($(NO_SYSCALL_TABLE),1)
    NO_SYSCALL_TABLE := 1

-  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 powerpc arm64 s390 mips 
loongarch))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 powerpc arm arm64 s390 mips 
loongarch))
      NO_SYSCALL_TABLE := 0
    endif



and this:
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -39,7 +39,7 @@ static const char *const *syscalltbl_native = 
syscalltbl_powerpc_32;
  const int syscalltbl_native_max_id = SYSCALLTBL_ARM64_MAX_ID;
  static const char *const *syscalltbl_native = syscalltbl_arm64;
  #elif defined(__arm__)
-#include <asm/syscalls.c>
+#include <asm/syscalls_32.c>
  const int syscalltbl_native_max_id = SYSCALLTBL_ARM_MAX_ID;
  static const char *const *syscalltbl_native = syscalltbl_arm;
  #elif defined(__mips__)



and this:
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -61,6 +61,7 @@ ifeq ($(SRCARCH),x86)
  endif

  ifeq ($(SRCARCH),arm)
+  CFLAGS += -I$(OUTPUT)arch/arm/include/generated
    LIBUNWIND_LIBS = -lunwind -lunwind-arm
  endif



it builds ;).

thanks,
-- 
js
suse labs

