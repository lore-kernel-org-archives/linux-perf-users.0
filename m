Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476035B13E
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555617; cv=none; b=pRldh+lEg5BEXFzAxSVQlWlTzvvoGhLEMkrCy7r7Wt8YmhnykPyZCegSl3l0TDf96jndNcxTX4d8Pn+W6Q5kvY8Z2DSdcNAy6eB3dc7FiB4N1CAwKkaBckIfXl89+CM4yxzXvA4f+EaPPF826AwbjKMCOSR1TtjJK/4sXycOyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555617; c=relaxed/simple;
	bh=GFLtMROpQw9A+PEPUreRaLxQRhO+LyU0XUmlP/JZmBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=V+RPM2aawF2+TKiLqR09dZXbpRFUZwbZP3T4GTyUy178tV3LMIVst0Wfh/wSo84WzGJtLCsGtUPT8oJo83i91uubEDD/Ny3aeT9piU3FFT/qmSJ/lZ+MFwbYAszDN/DUWDhWe33ZswT0eseIaVtc8Wd/UJdB0WX5hw3Zl4PSQcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QSpa9RMk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSpa9RMk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso4172092f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 04:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763555611; x=1764160411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVOK/gZwGH/qAUHEfz1NMpjUaPUGidGp5/ImMSGMGpc=;
        b=QSpa9RMk2Gawp1omHaxLWpUlbRDwxPSY7OBZsnsiJJdGj59IB4vILkfOA0L85qnnTR
         TnNGaUCbX7hIxsQQSb1Sl1NbNoOT3fL+bHnsGNuT27kxEvygBUZXTUZf9vkUCTXaZ4wT
         JyWaEK0VIdP5l3oZnL1N5dd0KXDTLFtdiaGFiViWB8QA0ngHLOtLnfnaGFzr7JKUdM08
         VZ9A2JXpuaaMrOJVF2csFXPH6ImNgV6v+0gb4PuS1YekS4PuIxo0xuHtc4BSfDMC4ri2
         cRRjgYBF+OFeWgjgvdIH8VI29YGsropgWtGcRk7bvhUg2KN6fTyo9dnCDwYlCF15UrdO
         Z4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555611; x=1764160411;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVOK/gZwGH/qAUHEfz1NMpjUaPUGidGp5/ImMSGMGpc=;
        b=RIVoBsxNH1wtA2Fv17eMxQFWcdeEMVkWPP/i8J2IP8OwmlEATHT3K2qFl4UF/BNwAH
         ktnPVUC/fuZbTeU1jtUAcJIwRLVaccqnTkjBebt16mFXAJM8OD4nbLg5KH3ZG8hW2cFF
         eNLvx+VfpHUuRs+t/5zPtio0q7H+xw+OEsgmbSt0A9D8rWfKXp/r1KcslIi6mbf4eAyV
         o2W0tcDfx8xOtPzRuMXgWiFqJZLZgq12PD4XtIQpv9bwHZCiK1lV+khSVAGHpzqPfhlM
         wE8Rto6BuFxIduZ3GXRBSLBK3SEZVxNm1oFsEL0XZ/munGumloHnOU1+IMYyU82RpYcA
         /PBg==
X-Forwarded-Encrypted: i=1; AJvYcCU5VGgi403tHsMBsNK/VgGHJHYii9PQEvF2e2dIoIiW5iV6PQxqEq0YV6fGuRm40pyIV+C9XuHZlYSDsXvqdgpo@vger.kernel.org
X-Gm-Message-State: AOJu0YxRmtmCiARuCi7mh0rxn33oHLoE806pafOj7qEoFFRNzl9KGdeD
	UG5xoJu3fPusBQaYR6Y0M2+akNrsI2lK1gH6VrGKJfRt8u52o9B0WFqyz2PojdEP9sU=
X-Gm-Gg: ASbGncshZvYYzszR2w7AhYzGO7zqhkPzwJFcf0RPVQYbXM0oQVmpIayMwzctLSlKNl7
	qrRoyO1dpdGepaYjSKxmBAX5oDjKuKaEPREjrGLyBh6z9mKZ05UDMnfLQOkQmq/IieY3ZKZurxY
	fpT/bKQaa9Z1AT45zblmvMy1ua80zvf7ct3Rx1ErqWQ1rgThk2NI/aq1otwW4TzFoDMgCtT91WO
	/MIKBZNeNm9+pc5PwXyQeZ3ohSB5lrqBhYywfrcqRwtownrwhqEFvr4pWK+lKBL2gRUNKZ5PAB2
	OztDi4aEkSwm4s8eXajXGRuxQmLX//2ev7tJPvbWo6bXZtfUNO9pb52NM6hp+j3DsW8c2iRlTta
	0opDjrEU8g8YylpDs9yjE6gi8m9NV5gGy0Rw4RRQqeOCEOXBMop9sfmocI/nXghsXQDU/YImcjn
	PA/ot2kK2AirEGvpUD7rQuaI+Jnac=
X-Google-Smtp-Source: AGHT+IHrVclBtR9HfIguZZfrK6wQUJjCLe6CJI/4hqbAdl79ZudAPdTK9Mp+h1vilglUyVf/wTs04g==
X-Received: by 2002:a05:6000:2509:b0:42b:3e0a:649e with SMTP id ffacd0b85a97d-42b59328f9fmr20589260f8f.13.1763555610867;
        Wed, 19 Nov 2025 04:33:30 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85627sm39778524f8f.16.2025.11.19.04.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 04:33:30 -0800 (PST)
Message-ID: <fe28fdc7-7c5c-420f-ac5c-903438d4d62b@linaro.org>
Date: Wed, 19 Nov 2025 12:33:29 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf maps: Avoid RC_CHK use after free
To: Ian Rogers <irogers@google.com>
References: <20251119050555.2017758-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251119050555.2017758-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/11/2025 5:05 am, Ian Rogers wrote:
> The case of __maps__fixup_overlap_and_insert where the "new" maps
> covers existing mappings can create a use-after-free with reference
> count checking enabled. The issue is that "pos" holds a map pointer
> from maps_by_address that is put from maps_by_address but then used to
> look for a map in maps_by_name (the compared map is now a
> use-after-free). The issue stems from using maps__remove which redoes
> some of the searches already done by __maps__fixup_overlap_and_insert,
> so optimize the code (by avoiding repeated searches) and avoid the
> use-after-free by inlining the appropriate removal code.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202511141407.f9edcfa6-lkp@intel.com
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/util/maps.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 779f6230130a..c321d4f4d846 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -931,8 +931,9 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>   			return err;
>   		} else {
>   			struct map *next = NULL;
> +			unsigned int nr_maps = maps__nr_maps(maps);
>   
> -			if (i + 1 < maps__nr_maps(maps))
> +			if (i + 1 < nr_maps)
>   				next = maps_by_address[i + 1];
>   
>   			if (!next  || map__start(next) >= map__end(new)) {
> @@ -953,7 +954,24 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>   				check_invariants(maps);
>   				return err;
>   			}
> -			__maps__remove(maps, pos);
> +			/*
> +			 * pos fully covers the previous mapping so remove
> +			 * it. The following is an inlined version of
> +			 * maps__remove that reuses the already computed
> +			 * indices.
> +			 */
> +			map__put(maps_by_address[i]);
> +			memmove(&maps_by_address[i],
> +				&maps_by_address[i + 1],
> +				(nr_maps - i - 1) * sizeof(*maps_by_address));
> +
> +			if (maps_by_name) {
> +				map__put(maps_by_name[ni]);
> +				memmove(&maps_by_name[ni],
> +					&maps_by_name[ni + 1],
> +					(nr_maps - ni - 1) *  sizeof(*maps_by_name));
> +			}
> +			--RC_CHK_ACCESS(maps)->nr_maps;
>   			check_invariants(maps);
>   			/*
>   			 * Maps are ordered but no need to increase `i` as the

