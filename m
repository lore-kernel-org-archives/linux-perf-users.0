Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C71741D9
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276752; cv=none; b=CvixHKstzHxYB0ip5X1FrceD6Kw7C1OekGV1+MEIJeY57BxZI7u1uhakZXlErTLIodBe1nsSjvFApCmeNMTC0a78qADr+mTj9ZOAzdg3Zrn6Kxuu3J7pQWQrk+/u12MF3pvNX+IW63F8rn8+fiMsR1NcXEPRWnQeiBFaa/bPwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276752; c=relaxed/simple;
	bh=g+bIymRfLKdNCWnmqGLhZflwa7/fmi5J+ue4x91nCvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCTkiMxLYYbTyO2svuSe/I0WvfHcVUD8zv9icwKWARM1u5e6sI/EE3m45FvloiwnGdwE367eHQdgk2HffHqFhneWKpXUnn8GK3br1vlkIQDYwnqlzeSikwE4hajdSjQ9YPS2EoMmz0+uSRknQbVT04ss3mU8mupCJ9MsEguIN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zp0fZmlJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zp0fZmlJ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so3197411b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722276749; x=1722881549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMq7wNNFkACLtIEFF1Sm/WrnsanjDAmU+DNeQs049lE=;
        b=zp0fZmlJ4dmb8IccRuQloxNKiZ9M+lOPX3Mt521auNTli1ezy+Y6bhrAGCaWv0pfmj
         KSODTLeyc/OXGkDUCBqEK3vhoCDnOPKVb1dAt7zmh5EJBWkzEtcAKhan8UJofNzcul3o
         zf3UrGJi4dsDJP8vd7srMetb9/Yb/trW9ws9h9oMv0F9IfoVGn7lst3OBqSzL97/H8i0
         AszsZOBDulJd8IxhmKmTsolHDJJKO7jptFtIVDJU1QVnbDi8gKTzYgmJ173uQymr4Hng
         zRPnybF98leO40ccjGYOd88AZ2u4uDJe1bwCCDEImYxcUtjK/6eEaOX3aPHR733kAQlN
         aK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722276749; x=1722881549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMq7wNNFkACLtIEFF1Sm/WrnsanjDAmU+DNeQs049lE=;
        b=OSIAgSz8dx8VU6awiZx/vHyLeCtlgJVDD1NsS2xC0TuMagbF3QYwmOIQumU9PBvBMs
         jT9WgQx9eFsXqC1Dz9KSXBf1/C94uEoWHFYGEDlZpvVJCx/nK9KBgPvnyiIbj6qyCZFF
         /79R1XC4VEZIU3wo3KRZplPrVRLDmELU4rFJjLj3JD0bLvxEWfmtoNXyR3MW+opJiUbf
         awMGM3RHL8LWpuKk1aQjyXqPYYzPQH+/j3z35sECZCnhTn6GL8+HiF8GiWOr6TL6MAA3
         /ZM3PT2/SJqzFZ8pxAx1yItTNPGi9rVA6Ph6ecJhu/6nTquagWHXel44gHy7or/PpJ/J
         Ez6A==
X-Forwarded-Encrypted: i=1; AJvYcCV5+qCOVoNE1qinGfj5UfYtlVCIImAA3/Y6rrWCDcNIydCG4p1esTKS2EO8mBNLT2X/BAGqQBSOOzfqsl31LBoqmbxDgwl8tq0apdfjdxm1CQ==
X-Gm-Message-State: AOJu0YxfH9lQ3MmSVwv40iD0082ir5OgX+A7HY6hTL9SOEXq7Jse2lvM
	1umM1/7Za0k++vWmjJ+SNF8d7RnEoD1xJe6VvsDmIVC3BZWTs4UZdH0DVC8Vg/c=
X-Google-Smtp-Source: AGHT+IGZPAFCVBLn6KPFdsUdG1pJTnQRQdxlqkE0IiPTY/LUVPpXHEHYA4ONndyS0YLuN1mMZ9EPHg==
X-Received: by 2002:a05:6a00:1826:b0:706:6384:a826 with SMTP id d2e1a72fcca58-70eceda1f46mr13855706b3a.20.1722276749228;
        Mon, 29 Jul 2024 11:12:29 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9fbd4b0sm6434433a12.72.2024.07.29.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:12:28 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [v2] perf arch events: Fix duplicate RISC-V SBI firmware event name
Date: Mon, 29 Jul 2024 11:12:18 -0700
Message-Id: <20240729181218.1712102-1-atishp@rivosinc.com>
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
