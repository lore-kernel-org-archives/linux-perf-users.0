Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2B1C230F
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008873; cv=none; b=thrj4epsItVD1EwSTv4X+2cSAsc2s0UOEb0NHq7YiZqnVPbNJ0lvDe0DaP38o8JRnrGWMCOKdJhix/unvTCipLbeTZfOUhmMKVRmKWUAfjvqma46UhAoexG33TkCXrn0fBkEXsLR4GFZ3IbzCj4ef9OljJ8tLB458kffRS4v8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008873; c=relaxed/simple;
	bh=7N6NVD+r8WHKaEsnTC0j/a0agPLkWKMhqBAGQA+8Dz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fTLWtSVQzJEEjsN3JaTYebNM4aOBLDG4174d5J6I8r9PVgcAah3/CvjeWyKgGmIZPhI/ByYY1wemrOIQGRBvNRDJrupNa+YuAUiUxKkUdhFCAlmxI0LuCqSX4y5PT/BSur2tiyW0SEGR3SEHlvMsE64jhk2xF6v83yvGtnsmB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZrrUO6eg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZrrUO6eg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354df3ee1a9so39356f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717008870; x=1717613670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIic4JMyc/4c63XW9p+6fbZplpp0iCITvAcX9Knosjg=;
        b=ZrrUO6egu5mYiEqRVEwkA6aBxq88BppAGfQO2gpuLNAGW8CfJaVrzZ1Zu8E/B9Xv+u
         EkZrYXUpIcsloGgO95w8TZefU24xxREzalvOkQDmZ6qAzRaeQNnYI/Q4fOuZ7rtEfM5M
         Ekd5Xm6/qoKBy77b/714EZXNIczdCpfFtSGYCkFL+GY+nN5QQ6/jG2QFi4/3ux+kEF81
         zMqckJm5Dz7CruTZ7z+xgxgZrfrqILyOXdm9CCbycK8GVenXYJfKqC5hz+21UPP2DRHo
         XbXOUoxLnFO9o1tDE0Z/LS+OEfUwP0Mffkcppae8Jul91xh3OZEGHEeRErSDgzZlYPJX
         qdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717008870; x=1717613670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIic4JMyc/4c63XW9p+6fbZplpp0iCITvAcX9Knosjg=;
        b=JWLV/FGwDGyQD4+KJb16pMpOY+HwKNAPSUHzFrOHZ3xmj5RyoI8Y/4idftfXPBjMQJ
         qlKrkBmHYYNdgclF64wu/1WlXO+InVwrzI4WziITfMTvtDfto/Hi6VMu9O6qvuxSmfcH
         Dz4EAURisvuGhv24bZv60Jlpknj4mae+NYk/RUPeKP/PorQTcnM2kwxWPpe0W+7ziNHI
         SRNzTs29/zpKRMOe4iTeJ+twKogXl/A4j4E6LXbuIC0GEmmDykEeElgyoQeAf7IGFo1/
         kgkO0VMfTTgqyjX3vrPirMdPWxbSdb/+JxYzEXySU3ommNTOKz2gNwfRnpIw4/iH/CHn
         48dg==
X-Gm-Message-State: AOJu0Yy8/t5G0MDkITdINKvmSHu7n1m4YQf4vVhs0WiFkkTAZwfDQmDi
	QqZEtxi5UWS7sWWLd60HNx3DqPt7skpCcvlLVdjWNdERwve3FEy7TRaaeN886II=
X-Google-Smtp-Source: AGHT+IHjVdn4dC57WqV/+1RRT5q3fW+n/nZ4ue2S8a0hdIxSFd8EjP08PNXy9B40Ht2SXbol1HVG6Q==
X-Received: by 2002:a05:600c:b8f:b0:41c:f64:2f5 with SMTP id 5b1f17b1804b1-4212792d887mr210975e9.36.1717008869932;
        Wed, 29 May 2024 11:54:29 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706a23csm2787885e9.27.2024.05.29.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:54:29 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
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
	tech-control-transfer-records@lists.riscv.org,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH RFC 0/6] riscv: perf: Add support for Control Transfer Records Ext.
Date: Wed, 29 May 2024 19:53:31 +0100
Message-Id: <20240529185337.182722-1-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables Control Transfer Records extension support on riscv
platform. CTR extension is similar to Arch LBR in x86 and BRBE in ARM. The
Extension is in stable state but not yet frozen and the latest release can
be found here [0]

CTR extension provides a method to record a limited branch history in
register-accessible internal core storage. CTR allows to selectively record
branches using filter bitmask. On a counter overflow, CTR stops recording and
the kernel samples the recorded branches in the overflow handler. CTR also
supports RASEMU mode. In RASEMU mode, a call is recorded on every function call
and on every return an entry is removed from the buffer.

CTR extension depends on couple of other extensions:

1. S[m|s]csrind : The indirect CSR extension [1] which defines additional
   ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
   RISC-V CSR address space. CTR access ctrsource, ctrtartget and ctrdata
   CSRs using sscsrind extension.

2. Smstateen: The mstateen bit[54] controls the access to the CTR ext to
   S-mode.

3. Sscofpmf: Counter overflow and privilege mode filtering. [2]

The series is based on Smcdeleg/Ssccfg counter delegation extension [3]
patches [4]. CTR itself doesn't depend on counter delegation support. This
rebase is basically to include the Smcsrind patches.

The last patch is in the perf tool to allow processing 256 entries. Without
this perf seems to consider that sample as corrupted and discards it.

Here is the link to a quick guide [5] to setup and run a basic perf demo on
Linux to use CTR Ext.

The Qemu patches can be found here:
https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream

The opensbi patch can be found here:
https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream

The Linux kernel patches can be found here:
https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream

[0]: https://github.com/riscv/riscv-control-transfer-records/release
[1]: https://github.com/riscv/riscv-indirect-csr-access
[2]: https://github.com/riscvarchive/riscv-count-overflow/tree/main
[3]: https://github.com/riscv/riscv-smcdeleg-ssccfg
[4]: https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
[5]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine

Rajnesh Kanwal (6):
  perf: Increase the maximum number of samples to 256.
  riscv: perf: Add Control transfer records CSR definations.
  riscv: perf: Add Control Transfer Records extension parsing
  riscv: perf: Add infrastructure for Control Transfer Record
  riscv: perf: Add driver for Control Transfer Records Ext.
  riscv: perf: Integrate CTR Ext support in riscv_pmu_dev driver

 MAINTAINERS                     |   1 +
 arch/riscv/include/asm/csr.h    |  83 ++++++
 arch/riscv/include/asm/hwcap.h  |   4 +
 arch/riscv/kernel/cpufeature.c  |   2 +
 drivers/perf/Kconfig            |  11 +
 drivers/perf/Makefile           |   1 +
 drivers/perf/riscv_ctr.c        | 469 ++++++++++++++++++++++++++++++++
 drivers/perf/riscv_pmu_common.c |  18 +-
 drivers/perf/riscv_pmu_dev.c    |  84 +++++-
 include/linux/perf/riscv_pmu.h  |  49 ++++
 tools/perf/util/machine.c       |  21 +-
 11 files changed, 722 insertions(+), 21 deletions(-)
 create mode 100644 drivers/perf/riscv_ctr.c

-- 
2.34.1

