Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708719992C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069021; cv=none; b=YB1bRTpBkhd2qjRVSTFtEWR7OXcASQffwQNU9jy/mOIINUO1FYyxXi1ISd2gwu877UGrdAkyO4N6yOVdkV/1ZzbUVfFpz84ghE5EE/beTfKkTc9C/AQJWXvoxw9xuADLGNC/8l+fWVZpxcCXUiAQrUgRR7cArWZox+7Fq8BDPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069021; c=relaxed/simple;
	bh=zuY3O18Tj3s5bv1IKSxkNZURrCa+mFTlRFzYQgPqel4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LFUUwKN/cnUC69Z8WmX2i5n7la1PJHWS6SVVbnISbnW2SSIzMShQzOwW9Sd+VUv8F0MnIAri8bsCa49UFtStgxGjJG3eyFNIwkAQAy9RhTTOu5E5XiXDoQeqzR4LRliPQEfHjZP27Qn+nN2WBQXJ7qqoTUuMevvVxZE8cuQ4zmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CzelOHE1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CzelOHE1"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385de9f789cso1128503f8f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737069017; x=1737673817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q8uJh+xH3eI/c9V3pGChrDiSvCKIcHtU+7c19/VbDB0=;
        b=CzelOHE1a5BZSJOJI/ZeIXs9pVgm5fsnJ7uRteGalCT51Hy1yD09u8meaQ227JVrxq
         Ffq6OpdmUa23L9bZK8+S9DmG6/ltGLy6YLC/ljPS6GhhP7s4imwlb9awhksgg//b6n5C
         jmCHbTZBRRo4TAGIrR6nMVVco8Ux72sLtTdPhH0t3ZeVfcqVfwY7OseK7N0iqCILXs63
         1t/GuccR9Wcaoj1jDDtDhGmZMmdwc2llnY4PUj80BT2h3AOLzNlx4/HjT0F9vgmvPt1S
         B9fDzVW4eBZ442+qxvZytOcRqiJ+PNoJycFHYiZy0vWErOJFI/zLEI0sfOUWvHaniPKL
         VBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069017; x=1737673817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8uJh+xH3eI/c9V3pGChrDiSvCKIcHtU+7c19/VbDB0=;
        b=HYHq3+HV4Z25OShUxINaQJEat1SB2d0hety8BgrV6jG7TkPD0BfXkMxtKr9PfRN+sA
         htAuIML8JXvYnZPPuCtO0deGYs6n2IomIP6mXy0bboTzIcR+F/yZPWjNiXcb1+9Y5PJM
         ogd5O1rueGnwzOIAQrEsF5NIuOnVuLvi+tJ0OEnroyrdZrXfXJxesuG31J405+QpDCmA
         ASQwRnjcff1SrpJoTQUJ3iotK7aYaewKFog+MIPcKMjtYZUYdZRPtU7oSs5XzjoPfMHC
         9Iv97YzyXu5xzD6f+T+AqK56Hl3J6nHwxqp+uTeHMUF7PNR+QyAa6ipEOVSK+u3aaPKM
         WHKA==
X-Gm-Message-State: AOJu0Yxqt4SBPt72b1p6Pbnk4fZCXEC26/StusZBeAPHQGdiqKV7Ch3t
	L6wFYk9m9eTtUJCD6bQwCe5sB3CiOKw/1efukKi8coKIOhfV+XbTbWSRURSpigxV1shdDwlMQ1u
	J
X-Gm-Gg: ASbGncuiKy5uB94yV/dXhoIYGn4/nEZAvfRL/OcNdRXSVX+Xkwwjpvgu7GKPkoXWFoS
	woxHVYoR3d2dAJYe/kLz49BwE+rSQjW7QnHGEX4CfpFrpZqf9IL2XoMQtUSN/jv5jDLPwZ8qsKq
	+uHcd6mBjjfPMPWE6zUncTAVX/AUxk3A8mjMtZSx2mfHf6gFBEMBaXQkPqlNxlN3mH5/iv0wKjj
	6MZ+E2Wyxk92qS4gyDmj6Usw+/OL0kBcp5QOY28+fTx5j/UT1jGozBZ2WtlRiLSoGFpbRgQBuIX
	o+cvL1ZifQKnpzUZ
X-Google-Smtp-Source: AGHT+IF0eMc8RsiD3vYznSPkvx/UK3bXs0kRUnvDYnuRW301R33pMrAUnJVLjjR2VGZTLTvqShRQuA==
X-Received: by 2002:a5d:5848:0:b0:38b:e1b3:16dc with SMTP id ffacd0b85a97d-38bf57d339amr277724f8f.50.1737069017185;
        Thu, 16 Jan 2025 15:10:17 -0800 (PST)
Received: from rkanwal-XPS-15-9520.uk.rivosinc.com ([2a02:c7c:75ac:6300:b3f2:3a24:1767:7db0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322b337sm974991f8f.59.2025.01.16.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:10:16 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	acme@kernel.org,
	atishp@rivosinc.com,
	beeman@rivosinc.com,
	brauner@kernel.org,
	conor@kernel.org,
	heiko@sntech.de,
	irogers@google.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	jisheng.teoh@starfivetech.com,
	palmer@dabbelt.com,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	vincent.chen@sifive.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH v2 0/7] riscv: pmu: Add support for Control Transfer Records Ext.
Date: Thu, 16 Jan 2025 23:09:48 +0000
Message-Id: <20250116230955.867152-1-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables Control Transfer Records extension support on riscv
architecture. This extension is similar to Arch LBR in x86 and BRBE in ARM.
The Extension has been ratified and the latest release can be found here [0]

CTR extension depends on both the implementation of S-mode and Sscsrind
extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CSRs using
sscsrind extension.

The series is based on Smcdeleg/Ssccfg counter delegation extension [2]
patches [3]. CTR itself doesn't depend on counter delegation support. This
rebase is basically to include the Smcsrind patches.

The last patch is in the perf tool to allow processing 256 entries. Without
this perf seems to consider that sample as corrupted and discards it.

Here is the link to a quick guide [4] to setup and run a basic perf demo on
Linux to use CTR Ext.

Qemu patches can be found here:
https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v5

Opensbi patch can be found here:
https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2

Linux kernel patches can be found here:
https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2

[0]: https://github.com/riscv/riscv-control-transfer-records/releases/tag/v1.0
[1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases/tag/v1.0.0
[2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag/v1.0.0
[3]: https://lore.kernel.org/lkml/20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com/
[4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine

Rajnesh Kanwal (7):
  perf: Increase the maximum number of samples to 256.
  riscv: pmu: Add Control transfer records CSR definations.
  riscv: Add Control Transfer Records extension parsing
  dt-bindings: riscv: add Sxctr ISA extension description
  riscv: pmu: Add infrastructure for Control Transfer Record
  riscv: pmu: Add driver for Control Transfer Records Ext.
  riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver

 .../devicetree/bindings/riscv/extensions.yaml |  14 +
 MAINTAINERS                                   |   1 +
 arch/riscv/include/asm/csr.h                  |  83 +++
 arch/riscv/include/asm/hwcap.h                |   4 +
 arch/riscv/kernel/cpufeature.c                |   2 +
 drivers/perf/Kconfig                          |  11 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/riscv_ctr.c                      | 608 ++++++++++++++++++
 drivers/perf/riscv_pmu_common.c               |  23 +-
 drivers/perf/riscv_pmu_dev.c                  |  82 +++
 drivers/perf/riscv_pmu_legacy.c               |   2 +
 include/linux/perf/riscv_pmu.h                |  55 ++
 tools/perf/util/machine.c                     |  21 +-
 13 files changed, 898 insertions(+), 9 deletions(-)
 create mode 100644 drivers/perf/riscv_ctr.c

-- 
2.34.1

