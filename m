Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784165;
	b=wEU3IA1YX3jqqYahYp0FVIGed+P/Gbye8hXm7pPdS6VW09nBTeTxWXsWNlOSQbab5I6M
	 YNatvh8u5i4QyNqZi02D7+JK0Z/bKwY53TcjYj7p7MTL9l4xJm8kazLTGPFqxVG3o2M/f
	 RQmClRysjZceIMpg+F5e9+l+aabPfkMqpPlh6QyKZm9/oDIDuMoaPUpxFII4uuJjCHi9U
	 TEJWAfsRYJeiLGpeC0T60bQz5TXcm76k4aj3+0erhRSeaQbE8i4kEKZxXpbteC+y2Ehil
	 nt71h33R8lqvKEo4mTmnq/0CF0/CYwkrCvwi8tFSfseXGXR+A4MWzZEjSHddg+fDF5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BDX9/YwW4F/DFICBRzzjsXdCNJ9F1302zx4p3uYHie4=;
	b=co9mv/enpdo/CpGdudiIy0u6stq7+lLiQAmhrC5cmYvs0CMdNtTl8Ps/vC5v0mFTbNnF
	 ky6iitRR+t2+K6a5EMGwhjfdX/1OO4nXeFlCOC8Tu5AmPW2gCYbPshzQlHxbXLKdCRWKs
	 LbRg34IsJerL1d8FwMsVgVrAAR3c5T4Lb5C3mIWaRffiP0lw8YiMkUlQzNBgRUS0hMbPA
	 960aWO0s/QSNE9nb53xfX42hrdA2wbq8GpTdOJYj29wjsYCGyiA07lDc+L5tCJHsXGEIK
	 yW0ZO2KGVIP4SdP60MoGiEe9tPOPlbVAqK8g9Dx5y30GG6KOFFGqCLpvX5xrjUGunrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yKx9xA1A;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F69606A328
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 09:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82F69606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yKx9xA1A
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so3740575e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 01:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793784164; x=1794388964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BDX9/YwW4F/DFICBRzzjsXdCNJ9F1302zx4p3uYHie4=;
        b=yKx9xA1A/OJJaG2Ga9Za6SnP0CEKqQ79l1zbcyS8UTJQX9WklzQ3Z7tBx5iDKFH9uC
         lsXNvmFvIEVsjp01VDegpZeZYD75JLDpgU323XY91t/o72zACl9ft/FIdR/uwkABI5r3
         nK0CLEiKcC1IQ7Gz148yucTtnP16VcbA0PDBb+7O5tAjlGIgWLUaaInuSqEbIGM/ieJo
         3mlW3RpgacoW/U0qkfdg9gSNlhFWBtjBDtal9wLvth0SBU1E3lmCs47xkZO7QLU7TMDX
         NHyiMxuljCYrlXA3gRvu5n2c9+H0H/Pq/y58x7M4pfd/ZFasXAPeTlOxU/JuPXrXg2zN
         5BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793784164; x=1794388964;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDX9/YwW4F/DFICBRzzjsXdCNJ9F1302zx4p3uYHie4=;
        b=mvWVbTBxRZb13V3l2jsZilVDWJjJ4xCkeHRfZ/aPtjZsWGLoohr49V/TYhsZbcQ4V+
         7EtzSrtwdUkqxATJ4KWKFtcFwoA5jujTK4/rUBhym1IvAAdX8MNzo4QOtg5GN8vOLVdp
         1799WE8XZ47Ggl48BMwcQ107wyoo7fx3WubvQa/E1BFCbG12wW+nealWyCo0sjMMaK/W
         3R9aC56MyePgpE/xrY2rs9CjVZAH5cN1YcIP7s5NMcuq8wG+UV2ItG14IUoyFOAPdfCy
         FbsqrIWnLwoOnKOIqFmo9PMGQXjJALzRIgJnsFOZ7TtTWNkyLPHu+l7x8n0pv0Y/n4F/
         nh/w==
X-Forwarded-Encrypted: i=1; AKwUvBysEoBRgAMRFrADfPMs8JGWclR+Akl4/URp3eZxWsLiI3xj7Kmbxfum1gmdAf36nI6Qw0c8ZywI0h16wxTT1ypO@vger.kernel.org
X-Gm-Message-State: APuU4Z8JpNcfQu5EmX/q0BP4lWXF6MqIyM3DFoSM947xCmM97mcAZ0hB
	GJy9I+E7tYJ3hhjFUfTY+hqmuay4kCE7sTcaYZf4sKUbLb5xsqWgpScpCpsldnaU9A0=
X-Gm-Gg: AYBFou0le4FZVX4TiBzkpYTRbCI44UYxsmnz3eboRl4D/qqeYltrQqSrbjpFM+sw41a
	sRNbQ/xTija7QPN3vWxE/ETJuds+o5F8VinniePKvcnLiiSsgugsbYu0k2KCLwTdN/ZuD+crJdc
	hjAfPx6MIMskyY7cJnOdpeyVFqYAKG4tBjYU9b4HNF3SOrbyO/MbypjCoTl8iGNWeEvFAtI3j+t
	19i1/etEVvo0amoiHvRs/XFhdkW00E7YEzQLmq+jWXx46RUJXmr82Hyds4EQs+2hn2UHMtgrwjF
	cCYi/2N2KpazY94zy1rdDdHsy1aAd1v1dfvIwci9XPBQW2u5idBlu0r6OekTcH6mU6osfSL0pns
	BanpL74hIQw3VEyi9DPgRh+WCZsZRsC0cHG026f2tUsucVhYGZHWzI7H8RXPaVmXkcdPgQp0xPE
	zm22PxTBURo9pEktcfA9kg01UmQqAGALpzHo9gU0VVqTECUVGesp4N8r+UjplRwSEBjpyUSWrn+
	9sxrjhv5D5P4qnFNFkqeiRBgj9CPjffn+KtGV5FT3Pjfta6zon/KX36jSCeHVvGKZRX1AdSdxju
	ZqpcZ+CRGwludcdqUflH+FxUdc/TWFJESWkpR/f81TQNKdXNX1e4bg==
X-Received: by 2002:a05:600c:3547:b0:4a5:cfc:1e95 with SMTP id 5b1f17b1804b1-4ac182dbb5emr339576395e9.33.1793784163886;
        Wed, 04 Nov 2026 01:22:43 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm230175975e9.14.2026.11.04.01.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 01:22:43 -0800 (PST)
Message-ID: <0f57d95c-fb84-4e70-8c86-e5314c0ca8f2@linaro.org>
Date: Wed, 4 Nov 2026 09:22:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf hist: Fix branch_info index for sample weight
To: Gu Bin <gubin@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20261104090229.1870-1-gubin@cmss.chinamobile.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261104090229.1870-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/11/2026 09:02, Gu Bin wrote:
> iter_add_next_branch_entry() is called once per branch and uses &bi[i]
> for the hist entry, but reads the weight from bi->flags.cycles (i.e.
> bi[0]) for every branch, so every entry is weighted with the first
> branch's cycle count. This is incorrect when the branch stack contains
> more than one entry with different cycle counts, as the weight of each
> hist entry fails to reflect the cycles of its own branch.
> 
> Use bi[i].flags.cycles, as the surrounding code already does.
> 
> Fixes: 0e332f033a82 ("perf tools: Add support for cycles, weight branch_info field")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
> ---
>   tools/perf/util/hist.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index e75a4fcce975..364754e9d12a 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -1055,7 +1055,7 @@ iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *a
>   	 * and not events sampled. Thus we use a pseudo period of 1.
>   	 */
>   	sample->period = 1;
> -	sample->weight = bi->flags.cycles ? bi->flags.cycles : 1;
> +	sample->weight = bi[i].flags.cycles ? bi[i].flags.cycles : 1;
>   
>   	he = hists__add_entry(hists, al, iter->parent, &bi[i], NULL, NULL,
>   			      sample, true);

Reviewed-by: James Clark <james.clark@linaro.org>

