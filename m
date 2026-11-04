Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793829400;
	b=IJyUb9Bq3hbTXiYlf/EheU68EVkuwPB4X1b4xjtUIoHLgNkxoW6ZDKS85fgoOP6ib0sk
	 kKG33CtJFVnmi3pDb3DbGgjLTtfT65VPUMkDOTGYYY9/81CpLgLHX21p0maej859Q7xLm
	 pvt/MOrbqT6Kh9ut3ttu7T53vUYvatDRDJ48mf1yYDW8FYmSDKT3WNFzF8Hc+Wy1zLlsw
	 U5Cv6JGF2OXRUFMQEonlzgePvygtcAACGcb8xyIHVhaUE4REwzy/JFJmH6PJYes/gHzGQ
	 qGckYOKu9w2/UCNtQuW5uAfcSUH35FYYEwSeUh5zwbcejTRFsrXiT2yvofTlFWd4pVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=SfUwspt8oKwE6fmkvVkDaSTqfrh6S31qCJ1SV27baGk=;
	b=A8KMuvtiEfLa86YyFnFIsPEJL+Wm8fYq7Y1tbFl6Y+F5b+3Jk5vtWIRxBM5zz59WAdYR
	 MrJEQJePi9WmgseI3reUjVfNb0q7hxWDYCM5QyKRQxosZleTcfOXYLXZ2swAUFCvrHhPW
	 SaAVFmhGpS8UgWeKfknrNBpdXtttAb5OlusrWy+qyqYax/3XF3fo0r0mBeABjMn+y7oP2
	 sYaRVbRb0GeNwS6WPYjFMIDjrrywS1nZQVaY6hzf/eD/9BvcZ26C1sZgl9iCIM3i/sJeR
	 WO5CYFQ2rIw+5yvtp3xIeaYzeZaLA9r+puUvPqMnk9Re9z8dFT/8alzFou8wKq8XJWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u7stsX4G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21360C29A0
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B21360C29A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u7stsX4G
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-703be215729so532172eaf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 13:56:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793829399; cv=none;
        d=google.com; s=arc-20260327;
        b=ig0eREy9OQeKOtRPsKhi8VVViSSXfyKiNflzHv9LG9mIDH1Y1K2MLsWsIJlhtkrsIh
         Z+Cuy8Qp6dMqhBSzwIitaAEH6/RVHZZH++VM89bqf1KidKQzFEkGqtS9iIt+inY5nl4Z
         XuEt31llUajK65flIXqEE+M1hFMD073qB6kbDiU47n+cmxrEbFmu1U0PA0Eq2VftlFu6
         LiDbXw9mOo/MJdh0YMf2DPqHO1Oez7ta0NJL5j8eDdJdTT0UB38+aC3B5CMf97OxbrfH
         50Bisx4AefUMTVBbOSxjH2nCIjGN4eJf+iqTxfp2iYDZ8/+4y1dBu2cedsPvqqZHMHFA
         BcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SfUwspt8oKwE6fmkvVkDaSTqfrh6S31qCJ1SV27baGk=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=oHtjGBDfPZyt4Avg0k4PvqP3bZaoujzLO4F/s9nC/HF+15waTp1Ir1uuAl47gYlxdL
         MolmSBGRDMduCHbA4wrK/bu58KyKTaQpCsWkfjCNpDdotAI4YzHPXacQhc/x/fSa+z2O
         JaMyNf96Jh2MM+QsoOm63ZNxVW/VnhdR22f+r1zn/iEEqHmzAMSPus2wk+X+vvg4anQU
         B3+FDwFkcZeqNLXn4RZOnuuP68kVFNDf4smb/hcKeXLRl5BuRauSU6vfuFrYxqGUz/D3
         VKMuOScC92VAZylOlidYF6z6VQnuz3Mva8LthC7lqYLRnZJTWY/PGOJsEDDdFmYE0PNZ
         v0KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829399; x=1794434199; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfUwspt8oKwE6fmkvVkDaSTqfrh6S31qCJ1SV27baGk=;
        b=u7stsX4GzUVPZxTH23lEbB991UcDDRCDzIv1hJUdPg8OfF/H8PiwTY/htlkobuYfUR
         wU9ENlzu5MleB0HS0eseBerEZ5UPOJOPmAXjk7Hrgi6pPzbrXqgCTigfj8vxNEObh+0+
         AoPAqDz/Isl24lQcihujiFpLFmuom7PoswUlo7F1hdVxJy2I9vdrn/PDwbXVQASylRJT
         dslmp7tpJEW/XRvS0L3O+5Cb1+SMBqyFEKO+q33qdpxERuqML6vAQXA12WfYEsEKTgZP
         jCqFInEhQU/h2Eej4uHmYzFok+ts5ctz1lFSYT9htvBfM1V+CkTlUmD9I5v+Dig1ULYT
         MEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829399; x=1794434199;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SfUwspt8oKwE6fmkvVkDaSTqfrh6S31qCJ1SV27baGk=;
        b=rf56ZXjRndQxTTfidowiXIqG1YVUcuZqJHyGvXr/edZTubZe20lAZxf2vGdmh5wGY8
         CLJyU9ET2PVaoLuVbllDeMPN8OGfKJIHrzmnb0rtYkH73SbSW1XwL/CpcyUPvVC00QEi
         Pc0pIUwTR3XXO8x9KPBHPWIj64L5fNiRdfJOCoLce333zpqltOmqh14/0op4C7p3TL8G
         zrgX76YsrTMcMnfVmlcYGbb1ObUQVV7jc2BMelpSJeemPpf+x3sS89n0MAX3vj1Jqpgg
         9JOj7Ym0I9HgJvjsAtHoAr6h7ZTieDzQEkGCg/fnfIUBphwuNmtU0AiCghBkwiIdrfhp
         4fFQ==
X-Gm-Message-State: APuU4Z9OCDJtzZuE21nkM6df0s6QKNNqJ8Q9quvPWi/emDSY8vWvN1hz
	hmQKIh/gYWFJh+wwL1vLSJuR6hWM0n1eaWvYsRM+2X0Br0RNOvJ9q4k0AI6qcInVTouTYSSk1i0
	taIXpbDywCnWH6LF/dwzbbc5ip30uuJr2qXMm
X-Gm-Gg: AYBFou0uRrSTzJMHu1ho+n8NzJOPOLh1O6OEhnKeKKSFwy/nPRHVmG5gWZAX4f5uToL
	tJZEMalyAeZOzpflCSDxpFdEkDuWrZT9CJCcfaGVpVIiSFXTHJ+PAbdWtkPl7Vzbo6hSFKcB2WX
	5h95AlkzQR9NyjU3eQAUCgFj707mBQr0ufReO3thOjc/2JuNCjTE/5GWyVg0oFF/M2gRNwRn+hk
	Z13iRMaBYo4NpQvnWTIAaqAprnLClwO7nfo8gNwVeS3DC2O5QJOY/lrcoBOiAae5KQGCvvqv0Yu
	gln9JaVg5RQW8A9Zde0oLhJgnKdBAnFmPfXq7cQeU72FIx4d0Q3bLIEPrZwlANNQz7dgSHBSvA7
	QlJ6BKDN53X35W2nHW1B7yTAu8DEjrWEZaaZ0wf5ZD6vLCfdnAN1fYTthYyuHQHI/UQOXDPb2hV
	xQBs9h0/hE62XY9hPFcfcwNSc=
X-Received: by 2002:a05:6820:603:b0:6de:1071:8b1f with SMTP id
 006d021491bc7-714f2a0429dmr9962373eaf.55.1793829399087; Wed, 04 Nov 2026
 13:56:39 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018074528.974953-1-lalitmaganti@gmail.com> <sashiko-outbox-176006@kernel.org>
In-Reply-To: <sashiko-outbox-176006@kernel.org>
From: Lalit Maganti <lalitmaganti@gmail.com>
Date: Wed, 4 Nov 2026 13:56:26 -0800
X-Gm-Features: AclHuK8NpuRRp80yN1mGeRCYx_90ftTOvJ9RuOxDbLKOCu_Y0da17iLCXb0Bq6c
Message-ID: <CALuTzHHthGbGDM6+hH9quVrZx4j-hCtHY64HmpbwzVgbutZ=Ww@mail.gmail.com>
Subject: Re: [PATCH] perf python: Accept events larger than union perf_event
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Just wanted to bump this patch in case it was missed. I believe this
is still an issue in main today.

Best,
Lalit
