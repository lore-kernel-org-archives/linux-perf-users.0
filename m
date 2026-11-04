Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793829420;
	b=Wlanfswo02+7R/U5FTj1duQrWGMpxLMAaoqdgx72dEDYmy6A00JdrfobOCPLiHIqF+HF
	 GWU6UGaHPY6bgQkr3lnBoFg5EBRgZ4MKbD0tc2MqFilyxoWmyBwYUt44xVGVJM423WCTR
	 Qs8cDQ9oh62FpNTx3BqnQG3oGL2rGZgt0yreMW7bbFSfJgZ1aVk+y32mPlxvb45aUFbpT
	 EUhTVsHR45Q5LUQghShU/8NzLPSu1SO/TYXfCNCOAveUf1fUflpei2io7oBe083BVuqDm
	 /e/zeisDG4a9IanFi31rUY9m71PshyWJrxBot5pB2+8+f3Fk0k87M25v60p/c7gz7iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SfUwspt8oKwE6fmkvVkDaSTqfrh6S31qCJ1SV27baGk=;
	b=ruCuP8WQiuGMYkvTlInCknSRGXqRfB7aqJUCsRakWxEQPU2D0zN1FQ0Ph//rnFwqfbOU
	 084CLU3tcm9OQb8jAh5RUM76RlyC0P6oVgbGb9+ifaLOR9OSldCQ/+9rL9714OstP9vfc
	 n9o5IYRRa8r98QdB3p5fzYGcD/aBqo67uXVmZdD79stB25pMMS7M3hx9UztdPyM9t0SDw
	 vX7lxnFoHYHXco9Tsl4y7TeA5bIc/OOL40ohXtMsmQ89WuqzTMmzybD0GeMabMYAx98Gs
	 dOhkp+0j7ma7xAZZ54HJgyedvonA3Gz9+7rhSpkzIFC/QqA/z+o+i4Wr1O+EDMQxgTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDpP7uVD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9B6082BCC
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E9B6082BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDpP7uVD
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-7143451981fso800364eaf.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 13:56:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793829418; cv=none;
        d=google.com; s=arc-20260327;
        b=EtpfboU8xoRn4xuxaNKZk8n9drVoZxvqWg+T/rmv61mKpuScOfQd6o4cVS8Yd+oOBM
         tHbIVq1k2iwnY84IgTFTJxZyN4OuFsfNAVOo2+dzAuEErndNTCSh4dUUnv5o7lTaIjXL
         hRtm5XnsosUr0qT3Jz4/2YyNiUZ0pR/rTli0UF5hoT5SvRcLJtjzxTwzlmC6lRLhB2MZ
         q3hCDFqmc9NQc1PJLKYuYmg8p/NuTAVpg1LVP9uT8urtNthhhrtSH1X2/GobrXcz+/wB
         BCxE0Wvin7AbI5xx+SeMPu/d8N3UmfafhvFnZi/LkJu4ILcVRKCjdPfOgT0NUQ4ki96S
         j93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SfUwspt8oKwE6fmkvVkDaSTqfrh6S31qCJ1SV27baGk=;
        fh=jjzSUEYMgaYLGXcWw8v/O7PBa+fcNrVmTtCTunay7fM=;
        b=NC/KMJc86FcKYdrxY3LwnOsiFsNKipmFbAml+YjyVguQgZc09AhsWdUrl/2pJdn528
         9aH0IcsZbSbGhIDZmY+964qc5+jUz8JuiUW5eMyviQ8SHhK9TrvhqUgF7OrRK6Jx4eab
         JR94HhsODOEvO4DWqdjUdrWScpETN4+d4cvIQ1aNGuzb4xOC5i/CGNG9WC/SF4b0cbXN
         3rfyXHDlxXz32QZ0JFoMJqUc+n5xr8+h1cXoU5PSKIqhGzTcnrle4iD/s/a9GKbRUc7C
         zmreDfNov5pOtgVfmE6s3qi/d5QPx005dtWCxRk8m+aNmxl8vz1uiUeAZ9N3VvsAxfFv
         Cu/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829418; x=1794434218; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfUwspt8oKwE6fmkvVkDaSTqfrh6S31qCJ1SV27baGk=;
        b=WDpP7uVDYFAphNh2cr1S8QMzgBe0TfOTEMmSk+3XASpDwyHR7cGJGkDRhkAUyKn3BI
         YNOBQ53Hr1KaQCaV/6yO2gJUx8pLiJRIwDwBa+FuBilCCa19wqyWHgkAv62BbcTor2Bo
         WxDQnOoJaXc+8rR9aVnkh3aQVnPx6XX9x0p6/Z/ZaJVkkdlBBn73zZnhEUNTYLfOBvjL
         SuQJ04G6BitGoo7BynUe1bk/1p8QJJQwIFp0ER0LUJGx2YTK7ZL6AiV/H/+N4SCkuk1G
         60y+WA3W2Fc5Vpp8I0pCXvJxPKDQJttbpNLKH5rGvhA3/K3Z8USL+t+B2QbZjNuvLh95
         BTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829418; x=1794434218;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SfUwspt8oKwE6fmkvVkDaSTqfrh6S31qCJ1SV27baGk=;
        b=GpW/u2XGt1YdyJ2dAEXdd/UqBz6Cj4Uk2RVcOReAI30op4zFFwZXlzNkvBS+3RRfng
         hTt9c1wnqCpcAbo1co9RoWSKD2+SqFpDKqMuXjYzT7cCl17u33EmVr3g8eUjVZ3pK3vT
         rMQPDjiTeOWJc7qdpFr97axuFfeJUnbbpguxiA4yNefLX80e92nrLvGh7tK3hGVAWiVX
         YIMEbgOmYdqK3u0H7zpwBTVBqO+7X8AWZIPYPH/FDRVOkWvm+gke6Ue1Gf6eblgv7s7s
         Cf2MUFpdVHIX9t1LKT/zhPzK5s4IUYO6SgB4qaCgpCA5eEcYdtthI7vsnSoCtuqQhcrL
         SnKw==
X-Forwarded-Encrypted: i=1; AKwUvByMUTKRrPq05StY3PtS8zSqmx/UD9HXEQR1hrDv/oKqPSIYfHWxc12xfxyjBG4FAAGP41JAD+uuyJqkX98ICOzX@vger.kernel.org
X-Gm-Message-State: APuU4Z+leW1IjGBGFHhCV52hmMAnVrkoVtWX5rd6jTeA93INqkPgSdBh
	GZqLN9Vqrd0L9DY2T5D+Imfcbb5D1s+ySsldFRp7Blk1a1zvQ8wVR7BJosA4JC2jxs7ZnMImHtm
	ja/6eoIvvjWF9+yr30VNNt+AFE1fY9nI=
X-Gm-Gg: AYBFou1c8R13EUs7Klnh8ZH/jCHpIAg6Dxz4a8A1E+L9g3+cuAgHJ1mmiBqiX4Rj9uC
	RgWyQdoexNvS7tT2c227rms6kfvkBpRCrbjFkOGOYvsVpVDvNFaJHr1lr+kul6lTQrWEiuuw/7J
	2ehZhr612d49Z9yKikykkXbsUDZfiVomunuhdDIOYB0UV2F5jhRrohDBNhWHBMHkAk45m3uqHWp
	PG3IEuribYPPSD9YZaBjz1284WBJr51o8MzNavDF+lhN+5lUKPr7cSYWICh5udTMphNCvn+0AHn
	kI4h2WhXJLMU0+VU62Ar97fUI8hCJMhJgP7pBIXmxoPsYqgyySw2nvLe4asdPuYzroXQI2VPRLK
	MhsMEsKkWTLr2Pm5mncAIsyvKW7n5kzLgkmXrAegOGP2dO97nmhpjO/wcA8JssSlpV4V0Boxg3t
	S9B1Zk91lM4QsXk5jLQLSm1hA=
X-Received: by 2002:a05:6820:3397:10b0:716:d48a:ee93 with SMTP id
 006d021491bc7-716d48b1058mr110387eaf.61.1793829418068; Wed, 04 Nov 2026
 13:56:58 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018070110.927636-1-lalitmaganti@gmail.com> <20261023134045.GJ26205@e132581.arm.com>
In-Reply-To: <20261023134045.GJ26205@e132581.arm.com>
From: Lalit Maganti <lalitmaganti@gmail.com>
Date: Wed, 4 Nov 2026 13:56:46 -0800
X-Gm-Features: AclHuK97e-BEXuAh93M086_12Yhr3pLcM6rPD9lOD_boebmkiY4fPIieK9jujdw
Message-ID: <CALuTzHHLWjmVEoaCZAMNdtzS1vRWKMEv94JTj0WQCo3aVvdVYQ@mail.gmail.com>
Subject: Re: perf build: default build fails in pylint (pylint 4, missing
 optional modules)
To: Leo Yan <leo.yan@arm.com>
Cc: irogers@google.com, alice.mei.rogers@gmail.com, acme@kernel.org, 
	namhyung@kernel.org, james.clark@linaro.org, leo.yan@linux.dev, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Just wanted to bump this patch in case it was missed. I believe this
is still an issue in main today.

Best,
Lalit
