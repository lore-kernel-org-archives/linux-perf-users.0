Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214A1946C7
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523448; cv=none; b=dt0Er4/WB8o5kppnglNTdWiI6svmN0XgO3qD1DuLqWTV+GxcrHkwC5dUJB4Fm4w8yAiaTKFieej/z+K03KrmKx5+k860wUddAj5liw5iB3WhKSAyWscW1G+F2STIpmNCwLhWEsnFpB27IS1QVvJc0UrigtVLmEHg/3+Zz/NCiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523448; c=relaxed/simple;
	bh=S1dZ7REYJvvKLV4kXaRfkTSGb+kFtWJjWR5CNqP70fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FlqsFF7aVt38U85rS7lG6klflPUZvURU2nLzvbmt7mhRTXZeTY3L6M4n0wuYmfd3Cqzz4KGrcQMD3JSFx3ig2hW9kAksdl/FH/VibISnwD6+2eS+JCWZHvKhwuZSPtvqLeLFDp3QK/R3XZJ1WMPlBih/+DW0s9UZXrOpGxB09FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SoWvV6a1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoWvV6a1"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9e44654ae3so988302266b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 04:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734523445; x=1735128245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KtNhOq23ExUq/9KecQTGduTg9YM5UXK2XCKNylBnoc=;
        b=SoWvV6a16Zn+r7qPywgbkWc9D2/GgmCygRBmTZBdsSG0EeGalTJDEhNT1UEnav1mKb
         Bif+80+RJJR7o4LyaUNLJ9DT1sLuCMRywfWuek1su+W64GGMzP+mYl6y7gPUIE3jrmcy
         SnZlab2+ITVTRklEbBZ1y+Qr6VBKYX2kINsK+3u/4T1brW/CAYl7vC9AyNBsySVQTueu
         qog+uLcFJpNkPdiiIB5s3rGSzYlwWJijZnf57oVah6VfTPfyYjq+oYD6DAX5xHKsVlI/
         tcq/xdR9OaWdjznYLTvLDCKu6bRYRRoTNKhVatZLidEiFL96ObgZsb/eiAvuea3YVGJr
         6FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734523445; x=1735128245;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KtNhOq23ExUq/9KecQTGduTg9YM5UXK2XCKNylBnoc=;
        b=hiHLKW2E0h8f5c9McUtiQQvZjndMG7BOcPK7eU9MIyDJ5765v8y+WHI25Bky6QBKrU
         dHyIjTD1BL089FQRbVc/QWTPbzOIO8h/rfsCqdNeT0neVTjfOyuNpiqaZIZyCQPV8e1G
         eE8i+yhtzUu8yaSSlPsWdtInfIlufTesuu8BY5FNYSJDBgsvdSY9rFgogiyn6IUNPzSg
         TeKSCditeCrhFycNWAx7XKfOUSPqLM2BXw54RGJ4xNCkRQ46jQjzwYASZrDOjQv0CUUS
         J55qJgPx8NNeBZHJgLODnZBT8Imf7dSebXfg1abPcUlI2Qj1HTjOCY2AzTZDYpoKEhM2
         373w==
X-Forwarded-Encrypted: i=1; AJvYcCX0SRi7nFeuXchzt3CDB5TO+V4QT/Suuest22ohBe1il1YohDSBAjQYhLkl00rJcYxCeEljD7KdrR/8aTdu4YX0@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtDlFg+Dl/lBWmw3T1l3KU9LP6z22VQjSMu8Ws/8Ze4zavdtZ
	/BMMykVqBnByRSa1Wl8d1m8E2QKZjEcPJ6+ukoDy90+Htw3WnDvUBnjynJpTcVsPqz2iTIEW/wg
	M
X-Gm-Gg: ASbGnctNjIUjsE7UJK+or9mgZp9Xrgc93eu85ZP/pvC6DA0UjPW+X6i1vXInMGb1l3/
	tjmWlLApflAkCyj/GV7al0y3zRJ8Y2YN7GWIYkqMaOEzv5FENGudkmW/TYkZxO8Iwmo6QdDCmpV
	AIk8hpxchJu79f6OblkAcLAV0NUNtvFxsD4GL9q59t7xKN5g8FmwNE0VxGHoJbC+k47yYPki/Kk
	EK0zG0PTzIS2L4LhdZXCh74WvIxll5SUxWin3+FGUDfH/0naIHPg1FZY6kusVaKN1U=
X-Google-Smtp-Source: AGHT+IEIploq19qvtSVx5i1P6HWfUUlzgeSE4IAvQCe4cHTY3KR53cmUJ0tS0/78VyTR917XQYwDIA==
X-Received: by 2002:a17:907:7801:b0:aa6:7ec4:8bac with SMTP id a640c23a62f3a-aabf474fa3amr201644266b.17.1734523444882;
        Wed, 18 Dec 2024 04:04:04 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963b2672sm544593566b.177.2024.12.18.04.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 04:04:04 -0800 (PST)
Message-ID: <855f50a5-f397-4a08-8298-78bd040e5328@linaro.org>
Date: Wed, 18 Dec 2024 12:04:02 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] perf cpumap: If the die_id is missing use
 socket/physical_package_id
To: Ian Rogers <irogers@google.com>
References: <20241216232459.427642-1-irogers@google.com>
 <20241216232459.427642-2-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>,
 Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241216232459.427642-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/12/2024 11:24 pm, Ian Rogers wrote:
> An error value for a missing die_id may be written into things like
> the cpu_topology_map. As the topology needs to be fully written out,
> including the die_id, to allow perf.data file features to be aligned
> we can't allow error values to be written out. Instead base the
> missing die_id value off of the socket/physical_package_id assuming
> they correlate 1:1.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/cpumap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 27094211edd8..d362272f8466 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -283,7 +283,8 @@ int cpu__get_die_id(struct perf_cpu cpu)
>   {
>   	int value, ret = cpu__get_topology_int(cpu.cpu, "die_id", &value);
>   
> -	return ret ?: value;
> +        /* If die_id is missing fallback on using the socket/physical_package_id. */
> +	return ret || value < 0 ? cpu__get_socket_id(cpu) : value;
>   }
>   
>   struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)

Hi Ian,

I sent a fix for the same or a similar problem here [1]. For this one 
I'm not sure why we'd want to use the socket ID for die when it's always 
been 0 for not present. I wonder if this change is mingling two things: 
fixing the negative error value appearing and replacing die with socket ID.

Personally I would prefer to keep the 0 to fix the error value, that way 
nobody gets surprised by the change.

Also it looks like cpu__get_cluster_id() can suffer from the same issue, 
and if we do it this way we should drop these as they aren't valid anymore:

	/* There is no die_id on legacy system. */
	if (die < 0)
		die = 0;

And last minor comment this could do with a fixes: 05be17eed774

[1]: 
https://lore.kernel.org/linux-perf-users/20241218115552.912517-1-james.clark@linaro.org/T/#u

