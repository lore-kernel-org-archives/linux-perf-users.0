Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85F1662EF
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277191; cv=none; b=omB1khhzXNw1d6p5AoiB/xteDf2GbIq0y3lSXriBejfzM79UHZslUUEmAn9BYqZ7sPo3dLflQHVaT5hh0sDUxlQVh6mV09YTcdPJBIQSSgPy2XgE4AhdKqwaSirxxRzqvfDR555seM8yxsXci0Li7/G1bNbo2YMWXbLdmaEhLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277191; c=relaxed/simple;
	bh=mCX7ZespUD3P/oxNqGTSO8756McUqLba+pIo/Bcv0iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hi1HcpWhjkiEJCS1cgoMd6u5if7GMS40XMLzkOaroim3fcc2tpzElB+ZobjxHsRqjkjq5o34jhfwIDovUmMPzIzeOWIPTgPm8/vvJWZMizyGkpdjFU66S0ncEWDd8LlIqhvXflhrwSJfvCI9roVDMN1SlkPL0i2SN4+Zpg/05po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d895n1VQ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d895n1VQ"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39641271f2aso14832675ab.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722277188; x=1722881988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLZornX8WAGKa8yt077Nm/8QnebdQj4sROMMiTvI2j4=;
        b=d895n1VQs0tTW0Aum/je/et4tYtaB7fH21Nx7p+8TRmOJKxiPUWC1doVtQMfEoLXY2
         3ydJghHTyEzKNz4TITuvQrilJAD6uNbPbob/qlbuaxL2Rg8fXwRmusPzxn1kIYo+Lxe/
         beR/87B/NcGkmjiWJunzGRlv+WuSyd82w94wdAhHrBM0pqveY3FkJd+k8ZqiAIc7nv6A
         k693bG1SdX1XSAV9DBimLMt358vSPO4Zl5lVxQbqA0B9oui/+XAAi/zUIK4Fw4husyPQ
         ldBtGYyfhbV3Vkm/D6H2gm+6HtUUN1QITFOVh9Lp3GVK7cZXfxMJEmNQLF8HbP24UfEM
         y40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277188; x=1722881988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLZornX8WAGKa8yt077Nm/8QnebdQj4sROMMiTvI2j4=;
        b=HukksTsUOIvjKcAyOhvl68S7+xvhjFw/YqbLpbXfq4M3ozWDEqqvE2Gx8WTjknKqDO
         bSVRxLvhy/nfEvcjRSbo5e5zRNGtwhded9JuReOQnpVEMwA0Uq168xMPu3IgXN2ET6aM
         ehmWcJRfTUuXPY5K1JJz1ROqnBXhs0vOg6127ve3tYWPXEmJoRzOgc30N9LNWFkLLR4a
         LJ5WieBukHmxbddatPDXjtG5CUAYafVfStFbpdVfn022OlkXiMfCXP4MZ1g/fOsMOHwz
         E7kpud12hejt1VIQ9gG07QAhyiXNEu2I8iwI5GSZZm6vwQLuTd2slnDh1omyMWs8ndXe
         N/9g==
X-Forwarded-Encrypted: i=1; AJvYcCVZGnkgQq3erP4f3luZvGKl18COa0Szaa7YjUOuuGM511K90zqj8gdW0zDEbWW9gBlvpeZc3m3ndTp/5PoultR2uOZxQPUqqt/dnvLKENXmfw==
X-Gm-Message-State: AOJu0YzW9QPlTVGzPGVB9K5oX1VsBMyOn4x/+EiyxSpp2WLOgAfq/d/m
	4PW7e58N7dMH4ShSzNiO37Nw4IQdveq6Ca1afoGOceL0oZD89+uRBXq6ZxBq2/U=
X-Google-Smtp-Source: AGHT+IF4BTnbGjnQsdqxs/SVCkJGOF3dKX/SjJGZrcZt0TOaKi/Hz3g0YG9awyZqFcTslL1Na/jssQ==
X-Received: by 2002:a05:6e02:1546:b0:374:983b:6ff2 with SMTP id e9e14a558f8ab-39aec410470mr103773605ab.20.1722277187784;
        Mon, 29 Jul 2024 11:19:47 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa5a3760sm7377373a12.94.2024.07.29.11.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:19:47 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: eric.lin@sifive.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	peterlin@andestech.com,
	dminus@andestech.com,
	locus84@andestech.com,
	jisheng.teoh@starfivetech.com,
	inochiama@outlook.com,
	n.shubin@yadro.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [v2] perf arch events: Fix duplicate RISC-V SBI firmware event name
Date: Mon, 29 Jul 2024 11:19:27 -0700
Message-Id: <20240729181927.1712841-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719115018.27356-1-eric.lin@sifive.com>
References: 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Currently, the RISC-V firmware JSON file has duplicate event name
> "FW_SFENCE_VMA_RECEIVED". According to the RISC-V SBI PMU extension[1],
> the event name should be "FW_SFENCE_VMA_ASID_SENT".
> 
> Before this patch:
> $ perf list
> 
> firmware:
>   fw_access_load
>        [Load access trap event. Unit: cpu]
>   fw_access_store
>        [Store access trap event. Unit: cpu]
> ....
>  fw_set_timer
>        [Set timer event. Unit: cpu]
>   fw_sfence_vma_asid_received
>        [Received SFENCE.VMA with ASID request from other HART event. Unit: cpu]
>   fw_sfence_vma_received
>        [Sent SFENCE.VMA with ASID request to other HART event. Unit: cpu]
> 
> After this patch:
> $ perf list
> 
> firmware:
>   fw_access_load
>        [Load access trap event. Unit: cpu]
>   fw_access_store
>        [Store access trap event. Unit: cpu]
> .....
>   fw_set_timer
>        [Set timer event. Unit: cpu]
>   fw_sfence_vma_asid_received
>        [Received SFENCE.VMA with ASID request from other HART event. Unit: cpu]
>   fw_sfence_vma_asid_sent
>        [Sent SFENCE.VMA with ASID request to other HART event. Unit: cpu]
>   fw_sfence_vma_received
>        [Received SFENCE.VMA request from other HART event. Unit: cpu]
> 
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-pmu.adoc#event-firmware-events-type-15 [1]
> Fixes: 8f0dcb4e7364 ("perf arch events: riscv sbi firmware std event files")
> Fixes: c4f769d4093d ("perf vendor events riscv: add Sifive U74 JSON file")
> Fixes: acbf6de674ef ("perf vendor events riscv: Add StarFive Dubhe-80 JSON file")
> Fixes: 7340c6df49df ("perf vendor events riscv: add T-HEAD C9xx JSON file")
> Fixes: f5102e31c209 ("riscv: andes: Support specifying symbolic firmware and hardware raw event")
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Nikita Shubin <n.shubin@yadro.com>
> ---
> Changes since V1:
>  - Add "Fixes:" tag for every patch that copied firmware.json
> ---
>  tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json       | 2 +-
>  tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json        | 2 +-
>  tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json       | 2 +-
>  .../perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json  | 2 +-
>  .../perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> index 9b4a032186a7..7149caec4f80 100644
> --- a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> @@ -36,7 +36,7 @@
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
>    {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
>    },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> diff --git a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> index a9939823b14b..0c9b9a2d2958 100644
> --- a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> @@ -74,7 +74,7 @@
>    {
>      "PublicDescription": "Sent SFENCE.VMA with ASID request to other HART event",
>      "ConfigCode": "0x800000000000000c",
> -    "EventName": "FW_SFENCE_VMA_RECEIVED",
> +    "EventName": "FW_SFENCE_VMA_ASID_SENT",
>      "BriefDescription": "Sent SFENCE.VMA with ASID request to other HART event"
>    },
>    {
> diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
> index 9b4a032186a7..7149caec4f80 100644
> --- a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
> @@ -36,7 +36,7 @@
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
>    {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
>    },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> diff --git a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
> index 9b4a032186a7..7149caec4f80 100644
> --- a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
> @@ -36,7 +36,7 @@
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
>    {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
>    },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> index 9b4a032186a7..7149caec4f80 100644
> --- a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> @@ -36,7 +36,7 @@
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
>    {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
>    },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> 

Reviewed-by: Atish Patra <atishp@rivosinc.com>
