Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27A3B71B3
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532149; cv=none; b=QTLY2byG94P0V9HzYh7v08qpnPgOVCSySZ7hLw8v+iVkqjzhi0XusAAC0D2KSdfWYhPMq8VPUdescQuTUzCSq7Mokv5F4qGqH08Ptz+JaaimoHfjw4/AdOae7bw0x4j0FXUqSJnNxhMzDcLyVp3b5XLDMgvEl4v39qLDBRZt3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532149; c=relaxed/simple;
	bh=1XyajoagXXF1cyqoxgWIfkPGgjkmx65YQW1n9q1RyH0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=C7l2933Yl1Jp+HgDIUhHzN1kq3h1J977jM5QIS3ThnBoQvvTmZclm4KgCJRyBr0NMOEFaXZGx3jUbXHXSNTdKkQ0QtfoivSXwVXtxTkm0aHVmZPeleaF8KHnkgeLdAHTdyqNvBIlmM+Y9I+M20yeqmwZWdmZfzPnRNbi3LBTdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR+q8rnQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR+q8rnQ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e347638adso4853867a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532143; x=1785136943; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nEpkUtKIjl+LLb7gWLja03h8AP/aK+y8njduXSgGt0Y=;
        b=dR+q8rnQ2wUaMyM9z74MlJ924DU/BPNhe9o+uJ8HCz/vdcAQYoAqup3+SdSsnT96hd
         NjZ1FfVK3fl8vYan3kdF3pPZzMK3fh5UukufjG5PDMeQihKtGBRbVyExfBhast/e1Q0V
         qqYaDfOpv78nq2yqc1o/D9gpGqwOYtVehLQaYtiAvw+hKAOxV+XE0N9V4/utWzfbx7Mm
         dEuYekN10AzNbsysTpMYtkswhNuDKQMfLV+DMS/1959gjAaXhUcgYjaZP1oqhOcGosZd
         jycsnPEcdm/xYBbue82hIpXYVR/zJUyhe+7A2ecEoHYfEkxiW2TqOZwJ/UtGksoMabRt
         JS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532143; x=1785136943;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEpkUtKIjl+LLb7gWLja03h8AP/aK+y8njduXSgGt0Y=;
        b=Nd/MoOVjYN61WGAtClKlxlZhhp0FMMbQnsX/hjVT1b8ay1sh/pgW5bDTtJnjfvU3SX
         4GJJCNBpRazfHZ0sLwrr85ICuGslaEbuRjqgoU262Oxy3Br7BpUCc+UuQm1dCQvSM1hw
         4AwjSARb1LQb3ZpB4peJaD2+2sJEmQCgI6O7Stu0j+iEq7FOV5yFcQo4qrNJDYOPUaaR
         cMfJ3Gq32wuOvM5wofXVeghiMT8n2BIVyRDMA6a76IHF9cnaR+j85hDfct+39zWo97P0
         t+zeuN0TpFbh13tf3TofWbvMHjuZq2hBHUyyG6NLlAiezlxBU3nSKfqe5m99exbqXkYL
         1hmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIMJfVItWhihrcZRYpakoiv5pT4b9f0egE+eJevMvyolItQrBrEOdb2x/t2TtFiCoxiOercq6yWQ6WxiccZ8Gf@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJOsFqfci0rXwrZEQe8c50mObCUnPl9/ELi+AkYZ3qpTa5XtS
	yGlxfWJ6hKBuXToOYafzP5/coluxF8zwsgIiN8h8c5Y7KA+JUoHNHksq
X-Gm-Gg: AfdE7cne5GcXU316moH2WVoGSyU8ls2SQJ+BiJFV6xd8NT8BFUe5HXveogBQR2CkF7C
	N5/DWYP6km26WpsX2yd6ETcAO+8DnqC5LZ4rW7dqE1ukx80fEE5Z0DjNI8yxC8XXuXcAA4EnOs8
	ogucp4LtUZa/1m7EP+pTFbtOoQH2Gk/7729MQvhoFkorXnRhts7QqNWR2IoFUXgfSn4p0+KcSxU
	esfpM5vcfpvaLXprhCaO3y5Nui+5e8z3mAk4esGby/a4cAyu3NWYbKIoZXP7MAol1KegtA5XV0d
	ZDD9fTDFp7kSlmt6fiYUj/YUAyOSNn62PrLbGWtLHMt553rw8Db5YtmU5DEhALQZhgkGt23gcbH
	qYU6Ioc5Foxcgo7pizKm2Iu6elVtEUxWXv7j4hRa+lN3qoVdB0O9zDhTzIlAaAmla1ix+MFSA8n
	OMhny7keeLmK873djl0TkaglEa+NUD
X-Received: by 2002:a17:90b:2692:b0:38e:79f:76ad with SMTP id 98e67ed59e1d1-38e4b52efd9mr13633934a91.23.1784532143064;
        Mon, 20 Jul 2026 00:22:23 -0700 (PDT)
Received: from [10.0.0.29] ([2601:647:4000:5070::51d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc067sm5153318a91.1.2026.07.20.00.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 13/22] RISC-V: perf: Add a mechanism to defined
 legacy event encoding
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
In-Reply-To: <20260701-counter_delegation-v8-13-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-13-7909f863a645@meta.com>
Date: Mon, 20 Jul 2026 00:21:59 -0700
Message-Id: <178453211939.543975.5882607179348590229.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532124; l=570;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=1XyajoagXXF1cyqoxgWIfkPGgjkmx65YQW1n9q1RyH0=;
 b=/MLFbEGJ3IvpPk1FcJeLIXZiS0wo7JcDujhTqTtOlA+FU5IZmLeIwq10e5fvUIQgKvN3oOFa1
 ueKKBNO9KuQC2Cd5dsoxEo+onzv+Zm5J6b8itUxDO/M/Am3bOLROYHJ
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Wed, 01 Jul 2026 01:47:01 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> RISC-V ISA doesn't define any standard event encodings or specify
> any event to counter mapping. Thus, event encoding information
> and corresponding counter mapping fot those events needs to be
> provided in the driver for each vendor.
> 
> Add a framework to support that. The individual platform events
> will be added later.
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

