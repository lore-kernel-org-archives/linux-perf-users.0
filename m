Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E578B7C
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549116; cv=none; b=ULYj4g6h530psr5QoQbigMws55hJ6Hpt5Ozaqhz/IZQtMxQEzgSjxj9zH9CyHVFFAZb+LJ7a7/H6xO6gTz3wjsY+9AP4bkuzM8Wba+79mqB4OWG0c4V+XUmCvZ2PedxeP9Rj0APLElBNHkNrEW0WHINKCvPgCgdeZFQY9ezK4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549116; c=relaxed/simple;
	bh=tIfAN6Hn6WlpR3POiJk+EFCBQH73UzWzhzRdaXRRW+Q=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=mwjAlO1dBOkxFOoePdtRut3DTLO3FeO0F+B0T16GVCRW1++KfWrkvIKSmBZIh+e8jRxerjNfnPQTIzmDGDfK5e1WX8t0i2xGZsVq//UW4OBcm0+LaC6Xe5Y+JAOouueDzcqOLi2al1HTDEyq4u5EiR/gd27+YN5Bh+DG1ajmuq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=lb80KnHi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="lb80KnHi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dbf1fe91fcso32884245ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 12:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1708549113; x=1709153913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+tU7eObkjYjs1vfTPBX473q/rKEbyH/Wex2trZa7yA=;
        b=lb80KnHiRfTK7eTJqNmugGxR1fa8rxj+keTj91HnrCxZjXghWal5k2w42RkTsIStaG
         ZqFvmIRtyfoNtxDrvfFRX51QKR8EI0q/jA+njraq7jPFLKKqbVBA1742CFs0QgHh3CZO
         3iuKbTx0AREJFt+DixYMiAC/3oYMS9R1tdvaS7qIaBbf0LdfK/O3UdOoRYnazwosoRr2
         9oDRCIGlC64caUYJF6vg12QATQ747CLHIskp4969Sp6Ox4TFiscR7VVyOy6b33jNmByZ
         IS5LYMR3Cua0EcuSrDSxLDMfeABEZmkpI+ST+rWUZ8M4jns7mOXFDQctg8LDe5tkDz7I
         gXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549113; x=1709153913;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+tU7eObkjYjs1vfTPBX473q/rKEbyH/Wex2trZa7yA=;
        b=tmpq+ov76G/HsibANcE67AaJIZksvrcsiOf1hNWOhv7JaMr6T9bzzslGloNOGMGkhs
         M2EbmbSCirHUD6pgWVF5NPXXVSFnqUV+tP8ZVWIwkN+JiulA9fopCg/2/xC5UXs+o8rM
         H4Zi2XJFbDnLwHKMd0kiAp4yjTWOClD0bojM2MUorR/Lugo8PRJp/gnYnMgPp0F4Mo+M
         9cXmlZl63mTUxdDtolLOljzGuNjXEibsZ+h48JNQTDbc76Qno3YY5Qjhf8OyoUYkCnb5
         hrDiAI5DUOKfbHMqrTelQNADH461c13LaFuYUenP2a65xDkUVx1DF2pxCQDHscI02Zr1
         FE0g==
X-Forwarded-Encrypted: i=1; AJvYcCUO519bu308OHRRjIMvY1bKeYzVbR2lwizg7nr/zaZcay/DelsHUxEaK3zFH4x7gCBT7GpN96V3bB23Qh5wFpucCkyw5IcjNdmFAr0Jf7RbNg==
X-Gm-Message-State: AOJu0YzVUQ029OS2ixosLCISW1Yijon9QkfIq6mPTF120fnosyFXtr+l
	5En/jnqsxrfAA+aL79VqC86vmjd+qK+UlkEGjQVmj0wsa/JZsCrQViR9yA/pLoT/8rpdTAc/98r
	tJB0=
X-Google-Smtp-Source: AGHT+IFE+PZQn+UmaaW8t5TQcd5db2AP8n7T//Ds6WRmFRk+fZnuSEKbOzi1SIKbGiLp5zwIJMhyjw==
X-Received: by 2002:a17:90a:15cf:b0:299:3c25:4248 with SMTP id w15-20020a17090a15cf00b002993c254248mr3727507pjd.38.1708549113387;
        Wed, 21 Feb 2024 12:58:33 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id st4-20020a17090b1fc400b00296a7ac8b5fsm2374093pjb.6.2024.02.21.12.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 12:58:31 -0800 (PST)
Date: Wed, 21 Feb 2024 12:58:31 -0800 (PST)
X-Google-Original-Date: Wed, 21 Feb 2024 12:58:29 PST (-0800)
Subject:     Re: [PATCH v8 00/10] Support Andes PMU extension
In-Reply-To: <20240129092553.2058043-1-peterlin@andestech.com>
CC: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
  alexander.shishkin@linux.intel.com, andre.przywara@arm.com, anup@brainfault.org, aou@eecs.berkeley.edu,
  atishp@atishpatra.org, conor+dt@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
  Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, Evan Green <evan@rivosinc.com>,
  geert+renesas@glider.be, guoren@kernel.org, Heiko Stuebner <heiko@sntech.de>, irogers@google.com,
  jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
  linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
  locus84@andestech.com, magnus.damm@gmail.com, Mark Rutland <mark.rutland@arm.com>, mingo@redhat.com,
  n.shubin@yadro.com, namhyung@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
  peterlin@andestech.com, peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
  rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org, Sunil V L <sunilvl@ventanamicro.com>,
  tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me, wens@csie.org,
  Will Deacon <will@kernel.org>, inochiama@outlook.com, unicorn_wang@outlook.com, wefu@redhat.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: peterlin@andestech.com
Message-ID: <mhng-b85cfae6-43ef-42ac-94b4-d0f4ce2d0940@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 01:25:43 PST (-0800), peterlin@andestech.com wrote:
> Hi All,
>
> This patch series introduces the Andes PMU extension, which serves the
> same purpose as Sscofpmf and Smcntrpmf. Its non-standard local interrupt
> is assigned to bit 18 in the custom S-mode local interrupt enable and
> pending registers (slie/slip), while the interrupt cause is (256 + 18).
>
> Linux patches based on:
> - ed5b7cf ("riscv: errata: andes: Probe for IOCP only once in boot stage")
> It can be found on Andes Technology GitHub:
> - https://github.com/andestech/linux/commits/andes-pmu-support-v8
>
> The PMU device tree node used on AX45MP:
> - https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md#example-3
>
> Locus Wei-Han Chen (1):
>   riscv: andes: Support specifying symbolic firmware and hardware raw
>     events
>
> Yu Chien Peter Lin (9):
>   riscv: errata: Rename defines for Andes
>   irqchip/riscv-intc: Allow large non-standard interrupt number
>   irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
>   dt-bindings: riscv: Add Andes interrupt controller compatible string
>   riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes
>     INTC
>   perf: RISC-V: Eliminate redundant interrupt enable/disable operations
>   perf: RISC-V: Introduce Andes PMU to support perf event sampling
>   dt-bindings: riscv: Add Andes PMU extension description
>   riscv: dts: renesas: Add Andes PMU extension for r9a07g043f
>
>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +-
>  .../devicetree/bindings/riscv/extensions.yaml |   7 +
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +-
>  arch/riscv/errata/andes/errata.c              |  10 +-
>  arch/riscv/include/asm/errata_list.h          |  13 +-
>  arch/riscv/include/asm/hwcap.h                |   1 +
>  arch/riscv/include/asm/vendorid_list.h        |   2 +-
>  arch/riscv/kernel/alternative.c               |   2 +-
>  arch/riscv/kernel/cpufeature.c                |   1 +
>  drivers/irqchip/irq-riscv-intc.c              |  88 ++++++++++--
>  drivers/perf/Kconfig                          |  14 ++
>  drivers/perf/riscv_pmu_sbi.c                  |  37 ++++-
>  include/linux/soc/andes/irq.h                 |  18 +++
>  .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
>  .../arch/riscv/andes/ax45/instructions.json   | 127 ++++++++++++++++++
>  .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
>  .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
>  18 files changed, 494 insertions(+), 39 deletions(-)
>  create mode 100644 include/linux/soc/andes/irq.h
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case someone wants to take this via another tree.  I'm also OK taking 
it via the RISC-V tree, pending a resolution to Thomas' comments on 
patch 2.  For now I'm going to assume there's a v9 coming.

Thanks!
