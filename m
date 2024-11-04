Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006A18BBB6
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715959; cv=none; b=X5F9vG1PT3ztFF5Eh6cenhhOoB2KHwsw/Zv6SIzVXe4Ty39b/ykos/tqvinqyxXvUj3qSHMDxinOfW9v0pN1cu2A22dn9J0XjFbYCkWSsT3ArLU/LRM222gKYZgZYOzqyk7H6MExreLyMIrZo9MDr8rvwVqljhE9UeyRRO4Jmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715959; c=relaxed/simple;
	bh=IAytfkWaxSpCWWNS2mgqR2jRA3ZfShQpRdFffHUhKrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gNj6xRxGaEJGuWqIFGg097UIZ8ThotJdPLJOzsbopcuJa54fn7UVokDkwYjKxPNo8D/xHIlQsKfQc4GIOUJ2qPv0nrFr0xQ4lpL+agXTsyET0EuoUaJwVD1dDqlWKKU5WxWij/M6vFZRQiypqziQ9dFjCCfqZxy3WFX+MI5dJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RiDLQWTc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiDLQWTc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so35228195e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 02:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730715955; x=1731320755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gcHX9y8K+xEl/vxDS1h1dNPYSKOS/f3blhvp7DupZd4=;
        b=RiDLQWTcU/Ki2kfnN1ciB1syv5Sy8AGrjynPjFC/fj9IWwW84kk//C3k8BynS9xWxA
         at7kKjHjyaqDmdk0PdWMB5rUrseiyNsplSv31syGUpzwn4JSkNmwhrj4eH3YtsgyDJPo
         VZ6cWZWY7E8tS7MxFGceMGt/pivtkKOh3xI+9XDlnmJGI8RC7jO3jYT+qG+TCbdPNFkw
         hvI4b0axLGuDgmlK3ejDTX+ZXHK2mMm7fLiMR87ryrj3cpe6fTR0V3YsfZ5n6zluF+6b
         Mf31IeTod5kE3WhLXogeG10jszaz3Q3Y/Uk69+FRY6AWjvWplijz4Suc2bWpNiloLcUM
         xA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730715955; x=1731320755;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcHX9y8K+xEl/vxDS1h1dNPYSKOS/f3blhvp7DupZd4=;
        b=NHboj+tStiyt2fUtdA9fp8vutKpBI7QlyGj3SqfFZ1eMxC+E9ThD0WrhfkTGcrUL1S
         Cc4g29utzC6cOR5kP+flTUK9jpc04co2be9gEARIJWTMcRwP2d4DOmWiGBkIMtJ8pnDC
         R9TZ6L2HMCNdKRWf8ro4ApnoDxXL9MECR+8p+9mbP1vsuXMwnlfIgqDHAr0XrtCjHq4u
         hhjSi0azQeW/oTByWPjoBzsfshWPTVlRidRRE5dEJ1SJ1QSaSbbybyf8Ih59XwFpuYV7
         yEp+ExiV6ZJAx2vnjUsI8IF1BmnuhGShTrgkk4kmyjG76Xc4ApM0Ii3V1mfCbhLP3p90
         vECQ==
X-Gm-Message-State: AOJu0YxSkvJZ/BPDMbZ3of7kI3VcwGPKhods/opQhCXFIIqV4KfLKI6Q
	mH+Wj8VjFJ34O0EGrYTEx8C0d58i/cOyqw5mdRItjJki4XOZuGRSzvRU7309N5Q=
X-Google-Smtp-Source: AGHT+IGUpMoqoZLiDfOgxeJUAm8ZHBb1rIbbYA6EvrIoyUjQ5itWNImJ5Lp2//6sqt/sp10mJDiOTA==
X-Received: by 2002:a05:6000:1867:b0:37d:4d80:34ae with SMTP id ffacd0b85a97d-381be7adff4mr13159726f8f.4.1730715955465;
        Mon, 04 Nov 2024 02:25:55 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c11898easm12824851f8f.117.2024.11.04.02.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 02:25:55 -0800 (PST)
Message-ID: <b53d4d92-7d2d-4bb2-b9b4-9ecf353cf80f@linaro.org>
Date: Mon, 4 Nov 2024 10:25:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can perf record make buildid-mmap the default
To: Ian Rogers <irogers@google.com>
References: <CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com>
Content-Language: en-US
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/11/2024 6:03 am, Ian Rogers wrote:
> Hi,
> 
> Without command line flags perf record will post process samples
> adding DSO buildid events with samples it will also populate the
> buildid cache. The --buildid-mmap option is superior as mmap events
> have buildids within them and the buildid cache isn't generated. As
> buildid-mmap has been available since 5.12, a full major release, can
> we just make its defaults the defaults for perf record?
> 
> Thanks,
> Ian
> 

There's already the perf_can_record_build_id() check when it's 
requested, so seems easy enough to have it on by default only when it's 
supported.

Ubuntu 20 is still in support and on 5.4 kernel so there could be a 
small potential to break someones workflow if we had it on unconditionally.




