Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C01BF7F8;
	Thu, 10 Oct 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547913; cv=none; b=QCaHe9crxwDLLBlhJs4Co+Hp5eRmZhDabnC1YY9s8AISYQ6gar9abFuwfJKprnV6oEGPcZO4/iFL045QuekvjDWFdUKFScbZ535CyU91RGQnYFzc2crJJYTbkDaHLfKDuJDVELMRHOP8SgyICP65lNa6B4x1Wv+vzZyyEeupbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547913; c=relaxed/simple;
	bh=RonZ3hSjGgshuYkoxdbMPh4vHd+Rs00t1uKRillG9SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUis6qQU6LCiTJUhBKx7mmGn0K4EHWvbVGW/6MSXuQooyK+5rqKjNmFlL1F7kU+pAYNbmpjeRmRUSeF+uOOJtb+QzJzgKuP98MIsIWNNrwpqiHeh4rf4e5qwVRQGcvSUAWzHqUQRk1b80VjTyjZzYFX++Pbtk+arzEs/RVwLWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so657059a12.2;
        Thu, 10 Oct 2024 01:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728547910; x=1729152710;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfqMeH+J/4r/lnn561HWP5i9jaarFNaeoldpWmQw6AE=;
        b=KWUoRWf1LYCSf5XkFBPEkm2iKhrZukf1Qzv9RsyMdMrEgEh/Vfyw+MVHhmRGb6M1ns
         B2TSOB+bsmO5N5RExJCD5dq8pMbiTD9d0GBaEPDdVtOrVzoIGKGusFGBwgEmDOwD+/dG
         yVXkjDkBa181qTioSf6VVVtDZlmGCJaVtdtgQkGc9HNNejBzI8kwe85X4kBxEjalA6ih
         l0w+d7VgsQDrrhuFhFVNue8AddU2MEX4Gq4PxOq7d2ZhahdXkWHR69etjY5jYj9m9jh/
         b6NfBxzPFJCuOaLiFvMTwP/AoeR27hfWgm0ffRWw0nn9xNmL6CQ5MXkENcJjwS2vL7E5
         3LIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqIThouFvXgz2Y5skn3vZUj+Hbq9v/ylm54TcKIGnApHX6Ub20JBl8x1qu7mKMdYzmg5qsJ9eN0F46Vkyb5lzhNA==@vger.kernel.org, AJvYcCVc3b20KcmkRhgTH4ybLLMc2EvAbKrkeCqNFmP2cTasBkw3Dh9gqa7MPTapFn3wRYc8JosTFCF/VS9BVJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JQhvdW79cH+hl2nhUeG4Cf+b8BhHYUYvQUcgOhtuGIQHcnGn
	CEFvLAZH+xG3mIGlygTA/ln2v65PliUwOBTdwCwiy+earSga9yon
X-Google-Smtp-Source: AGHT+IE45JzFAPGR+1CywK5sIXQ9jFrkH0H+cfgQldddNMLQx2kLoYPs7eWuXVImDy6JrwargYLhvg==
X-Received: by 2002:a05:6402:1f0f:b0:5c9:3ff:1cca with SMTP id 4fb4d7f45d1cf-5c91d5a0a01mr4264386a12.16.1728547909545;
        Thu, 10 Oct 2024 01:11:49 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93726036esm434263a12.74.2024.10.10.01.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:11:48 -0700 (PDT)
Message-ID: <271cde84-26f5-4e51-8cf4-2aa45a220025@kernel.org>
Date: Thu, 10 Oct 2024 10:11:47 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Howard Chu <howardchu95@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com>
 <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org> <ZtJWEVn8-w07Wm0q@x1>
 <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org> <ZtYJ0z8f-1jwYSbV@x1>
 <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ZwYbQswnGHSstClc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09. 10. 24, 7:57, Namhyung Kim wrote:
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 7c15dec6900d8aaa..b7465a879d8bf416 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -46,6 +46,11 @@ static const char *const *syscalltbl_native = syscalltbl_mips_n64;
>   #include <asm/syscalls.c>
>   const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
>   static const char *const *syscalltbl_native = syscalltbl_loongarch;
> +#else
> +const int syscalltbl_native_max_id = 1;
> +static const char *const syscalltbl_native[] = {
> +       [0] = "unknown",
> +};

Hi,

provided the error was:
undefined reference to `syscalltbl__id_at_idx'

this cannot help on its own, obviously.

Checking with the other diff.

thanks,
-- 
js
suse labs

