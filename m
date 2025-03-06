Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE418DB3F
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254321; cv=none; b=X/rqbh3pU/XTGYyENiAMZfjJgev5tsjGGwa3xQ6p5oK1UELF2pWnkIGWhGNYAlwMp+upws7Rl2cdwSmlrwsJEgk9VMNzAJ66QFxdh2QfLqkrLVEkiYFvPD79KTGd+u1aST1xF/Q1wTW05nNtpidJLlu00AND1IdZ5acb+AiY5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254321; c=relaxed/simple;
	bh=Zkn2YMbLE5rJEZ/XpFzCZ5UU2Mpoh8gNHID/nc10nTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdC4BBjA/70NsVoyZkA2qiB7IXLrhAnzdM7xdSkOWK+pmDsw5qHVx7yfKNBqbu8unHmeZp1O0dstwp+c520fPjN8NaIFFPRK/vx9wM3D4+s3uCyQOFV3l9ramqkb4VEUUEwvh3vjHczPjGRS1UyxI9jwI26ENMt5pmckToRon20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hm8eLHeD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hm8eLHeD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bcbdf79cdso2434155e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 01:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254317; x=1741859117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgG9H+/yLUvbzNY3rv9rX7GNNFG7+EB7vNcdFV5CSGA=;
        b=hm8eLHeDX4Kswn3ATDts8Iv7V77H5WhmjgKPC3KMW/PSB27lPOq93ev5Le/QRq287G
         abV5NuEiyRbYjrNkwrV+/3D/3M4iGEwwuUjzzznbEkI2fololh64COcEjMC7JueOvsnw
         zPDu6RtHktjgK6pa/F0/fwRnZETCaZzJNges+wQwmNRzgttFiUINz0pkOAnHR8rwAauc
         NcOB0Nvf0+/xS8I07N7cSxywTuCHuYld+phdohdo9QIpAUac4LUbCcWXcajy3k+bSDly
         wSDTFWTk1Ja2a9LtEC/Pl9VMTwTMBEnfVzF7fGIJFE/LmcOuGj7O0iLsRYlvHngNujTe
         S86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254317; x=1741859117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgG9H+/yLUvbzNY3rv9rX7GNNFG7+EB7vNcdFV5CSGA=;
        b=XKj8hQTY6mHKMeSh7Doq2KLOS43Gse6mVIUMxyfy3DdCwB8OlLaAS9adIMBmYFkpQ9
         by2F4EpAWTiRczzLBNTCYbTEsF4Q382l7Z6bqygNLzz6KZ4kdJGGUUzjv+6cH3/svALW
         kHbHzquZlnXjQYZiOxZ1QX/9lAAmxXhtjoAqr9P0WplmRZ+XfkAd9I+85jIAOVmskSQs
         aFC2S1Hk36JBIQEynrtRzNaAbLpueRQWZVydnVL/BNMWSbXNIA7Uy3QESLomWZTHtu2Y
         9mUG8Y6Hh2hGjAV7ehhFsL6nNywE5zcbLW6Q3kDAKK+gB8FZyuaQsSKqyorTYVflN25V
         U/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIxhVw5JDhvHhVR74ZU5MKb7W3ygpcp45K0us2XKXS84Fen00IRFHocvP9R/JKRfRXRzsZmxu9GQ/zsOP50vgs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cTsp19PRBUQ7T5GwMtUnXYbG7Fk04vspQpLNHljVlWSGkzWS
	hEhY1y9HRdTZpSjL6JLaWeODs3nUPE/985OF4JiLUwyTm4vs0QGtNb2O+R6gUT8=
X-Gm-Gg: ASbGncviFcx87r1KCSKVYW8bizzRb+T+eYF9jQoxKRqJVRRfaO3vkE00uA4nSTBytQY
	iA2M8+2Ql45Wq1/xgeCw+0nv2j3QBYEL9mX8p08F/HadU0A3ZrOFe9zaTvAD0QUa/LfGOBtcRBk
	+PtguqypuU4bTvJAhOm3EfwECmACeSpqTB7+qWAGD8e6GdWuOezN5QvPht9r4MPBcx/8NbiE8Fd
	LgITtsFqUzGwi1+ONzy0pPtvVc0P8h8V/1QV8xmb+A1aMfBbvaX2cHYrQN438JaKVBChiMuDIDK
	IKbkphu3HF7qTF514QGv4J6qh6L7bhYIENMwNIJyNtMDwxzPTQRvJw==
X-Google-Smtp-Source: AGHT+IEISP1nQtvK9hy0m6H6pYOyqBNm8mOvrsmIxOtK6VYosAFmYZyHfZakap513Qj/EeP2jmSvqw==
X-Received: by 2002:a05:600c:2d16:b0:43b:cc3c:60bc with SMTP id 5b1f17b1804b1-43bd2989f68mr52790685e9.15.1741254316983;
        Thu, 06 Mar 2025 01:45:16 -0800 (PST)
Received: from [192.168.1.247] ([145.224.67.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdff57sm1515867f8f.37.2025.03.06.01.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:45:16 -0800 (PST)
Message-ID: <749f9235-d7cb-4807-b671-2809b5e8b948@linaro.org>
Date: Thu, 6 Mar 2025 09:45:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf/arm_cspmu: Generalise event filtering
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc: mark.rutland@arm.com, bwicaksono@nvidia.com,
 ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <cover.1741190362.git.robin.murphy@arm.com>
 <c0cd4d4c12566dbf1b062ccd60241b3e0639f4cc.1741190362.git.robin.murphy@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <c0cd4d4c12566dbf1b062ccd60241b3e0639f4cc.1741190362.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 4:10 pm, Robin Murphy wrote:
> The notion of a single u32 filter value for any event doesn't scale well
> when the potential architectural scope is already two 64-bit values, and
> implementations may add custom stuff on the side too. Rather than try to
> thread arbitrary filter data through the common path, let's just make
> the set_ev_filter op self-contained in terms of parsing and configuring
> any and all filtering for the given event - splitting out a distinct op
> for cycles events which inherently differ - and let implementations
> override the whole thing if they want to do something different. This
> already allows the Ampere code to stop looking a bit hacky.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

