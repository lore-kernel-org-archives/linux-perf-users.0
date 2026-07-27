Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D0422E2A
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169896; cv=none; b=d1u26QP/JgmpL342r80eE1rxnuemmSIr4GnMkQHmL0XCLBvYvii+HOxEQY+dq7dhSHYaeSun9x/caTFkNnHy8kRpgBBnsDbaht9HMEofoz7OzDII4vQZuQAyW1Hdbu24whABu5TcgM8V9Nl+rX7UOXJ8eiwCZKf95oQgQcyEWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169896; c=relaxed/simple;
	bh=TBM/ZHsiWJAzbb7q0Px6Yb7cMUeos26DNoh+MT9oXGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDUv6Oqv0n1v23MJDq6ME4HTEX2Y0Jh8Z/uC3tOnnG4gMpup8mgMxCbZ/n48I45nrlGouKLGG7JRyQ8BphRTrKq7EvosEQz1lWrdWnbBhhq4EdPyhWMeppV4C1TZ67XnjVQBPQ0ZXOpALtQlU7TMOPtpL592C+YeQXJJkQ2l8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UYS5VynZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYS5VynZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f75f7172so24953075e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785169891; x=1785774691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUWwYF9bQTDgsPrNQzc5tTQtPSp1qyE0UfW4AXxm6fg=;
        b=UYS5VynZhNQD3lENgy3c7NHTs4GqInNFA7/zHDYSGn1HbykE0KeAkIwIYKnfYxs92Q
         WVxUcJKe8w6Y8ejb0/HFyrnY0tAqUZEoj/C8N5ijhtgZSNShbLbsMiMkXZ74+vayn32L
         rBxaW5lGKZUIGuXn4w772Ii6xCP9ZH6vxbTNypXHJoIZudWcJ80ySVASDQkrbbr3pvej
         NXAy8Q8WIbDRgLNWkFG7ayEKsBm9m30R3kDBgDwO2Z56vJbcTRY29Y7S38DgNLHPFZS/
         jp5NmRC2O58TM5NvfUDrlhNDsh0IrCd5SDbCfvMwotDmA4aW+fRCP3L7/6v/3KOnQ6hJ
         HeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169891; x=1785774691;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUWwYF9bQTDgsPrNQzc5tTQtPSp1qyE0UfW4AXxm6fg=;
        b=NeUYmLNRuvSYrDcqFFY7qqeuSpg2tYSbWafi9hJlhc2u4krlq49LebsmnJRRgt8qUl
         z5d08BBgZaKbbQKY0DsoPWqjzJy0wcZIKwwlTgpW73omJXsw2dyvPF9kNbIfa81YWNw4
         mO1URSegfgJF8ILBdRYdGXitlERYTyOQpaNOV+kbg+ut7OqsX3YTlzO23eruVDrrxPXv
         w4uFyfnZrrmEzwxiA3hrzzuyNAgUFaPUpaorBoqtaNV8n6BbZgC+J+sLhVmM42l9l7kG
         UoTiBD4PFZlJu6RPbIaBhulSPd9ruW3laHOif1PfvbtsSP0TwpkfVgfG8Xv8RbHWUpgg
         fo7w==
X-Forwarded-Encrypted: i=1; AHgh+RomihgJXAFpnuJtrzZ3F//scUDiVnTAhPdVkL9A2ApIxAU4TpS+2qwjyIPlG8IHj6eyzYpnTVCJ8t5KM6ze7oTv@vger.kernel.org
X-Gm-Message-State: AOJu0YxCf85zLFYIUQFQIvfH2E0eiqcg18P9/SKe4YiiktQpNuXd6qTx
	vq9nhfG0S/HGzq1sYFBE3c5rsXbpbDUEnRjIhO0dl3zdAlzBMlBFM+SyS/ZVrhT9Ua0=
X-Gm-Gg: AR+sD12Fl+QGPoZV2v060qP6DxHmx0sEi2W3bozPM8C/q6C/oRlq1FsNr1/6/wQVY9F
	/hoYIybhl3In+d4hMnYqZI8dpW3g0sprys4Q9HHHGXNXFB6a7xNQe02VVdFjqVYZwfzD3iIvW8M
	zOJ/ZjSn2R851/+Ki0+IP/PnUQvx5XJvwgbAjDnLFdIE0KPl81+mReJRuqXnJj7FHJh06LfwmCy
	XnGKqI2K5012hpmNaowyUtIkOqBoHZsNZdr/JKh/2UZ1aaMFD6GwcPR0tZv36iDeF3YfmhlD4L6
	cMNtOdAjGI0ChILc8578AjLUzB5EkSINWvd3SpUDtt46y0wUlJYhygciwOlNXAE9iyM40RYwraJ
	ATv8xQseeO4pTjGzUQWJaDokVZt1F+KIRR8mzrLBSHdok9yqi26EsimCxAaLAD5xUM/aV/x4P7O
	GFYh2Ft2M=
X-Received: by 2002:a05:600c:630d:b0:495:7952:64df with SMTP id 5b1f17b1804b1-496b570d9e3mr127529465e9.36.1785169891640;
        Mon, 27 Jul 2026 09:31:31 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44afaecsm4829975e9.2.2026.07.27.09.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:31:30 -0700 (PDT)
Message-ID: <ee11c4ba-6002-4722-bc84-da0234373431@linaro.org>
Date: Mon, 27 Jul 2026 17:31:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES 0/5 v1] perf tools auxtrace hardening series
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Clark Williams
 <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260727161705.64807-1-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260727161705.64807-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/07/2026 5:17 pm, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Please consider applying,
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (5):
>    perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
>    perf auxtrace: Fix queue grow overflow and old array leak
>    perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
>    perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
>    perf arm-spe: Reject zero nr_cpu in metadata to prevent division by zero
> 
>   tools/perf/util/arm-spe.c      |  4 ++++
>   tools/perf/util/auxtrace.c     | 15 ++++++++++-----
>   tools/perf/util/intel-bts.c    |  2 +-
>   tools/perf/util/intel-pt.c     |  2 +-
>   tools/perf/util/thread-stack.c |  2 +-
>   5 files changed, 17 insertions(+), 8 deletions(-)
> 


Reviewed-by: James Clark <james.clark@linaro.org>

