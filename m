Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04D2D3217
	for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956381; cv=none; b=FQCOy+OwtnJNCm7MiTsiARfMEh+RsEsV4AePYyjExCQORxzXoaE3CjmHBLOdIoGd80cJCtI+e2d1lOYTO/GuEA8apKCFcqBNxxUQLo2AU9AffVaTD4qvsl4u//e/hw5CYAKxkBCdmwLjwRAsT/kB/niCCeLWXT8EKLbsqUZDOfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956381; c=relaxed/simple;
	bh=Xt+9J5CINKC67/Xf9FTS32L9c6buwlWjqj4FpG7qyTQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FcHGf/FK2bBc0qjItPt2nOpzxxjUv++b4KVH3o+1EIEtW9wopQyF/MbtMbJiMEeSZ5ny/nYR/LH4i5wNDPFc0yEK/kCKa+Puf291ode3+0Tgak6e4MyrX/5Q5eO1jWXksELZiHQ6EDi8ZxTTV11q+pPbxoXpdRvpreIKcTQfeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VuS0Wz1w; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VuS0Wz1w"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so52970265e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747956376; x=1748561176; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8XVL2AzLr3r7KuN+VtnlIKRIu/pZqkSiU9SK0eyPQ0=;
        b=VuS0Wz1wlK53wX53HMbyZymqFXpoVMBypRb2ZCvhKOlRGDU4uk8R1dr84voOSrJpWf
         O3qbDRfGbB7KrkSCjdSYq+vVSh85IEpLD0+mLSWQGPxtzA/KW/7eu/J/NbhuZ8Dfmfww
         uZ3YSfOSrPsr0wVw6n4EScv7jEFAMqpDwLWbaHSwsL8SrZEbZEOPJSu3WPsUIN7IvA4N
         Ao6eF84d9cv3R8qCziO6ZT0HbSUuG4dggwd2tJzzCxNaQgkAxRJWvUb8NV0wnP75h9K9
         Pkf9kDCIwTckTv0Vl15lINjiEev0hYiLbBWH/f6e7eP3qL2NCuBMWPernQOz4gdVXoGL
         Lbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956376; x=1748561176;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8XVL2AzLr3r7KuN+VtnlIKRIu/pZqkSiU9SK0eyPQ0=;
        b=I7IMtA3b/HFyDqy6XiLuY4Ex4lMNPv9DUYXLtbRoupHuElnxqWOxXe+VluhveN5/+L
         tzcUDsvnmjWX72zdJprYfSBO7Qwe/aUKIhibjRkDRHjuOmYrDwTizBXwo9pDArzWRq2F
         AWO11EyWbowvfEA8IqWf2wqhrnBjVZKyfSMNFNomJoqQgkMl4rFBPC/UGxFn0u8SrwvE
         GgOBHWX48nJ8bDF5nSPqiUdgg+OOqv3caAt7i2Lfl7TxTQ1XfW9tB/3gRuEvqDiGV4yA
         xuU4GW1dORU5idLrtCR5yckCYqEXNACP1msaT1lbZnLoKFCEN+7tWTJakJuHgV+sPllB
         mR8A==
X-Gm-Message-State: AOJu0Yz93uastjupfVcUabba2OOmjQogbso5pBMzutrpVA54CU+/l4dO
	MnJTvh7rTpOqvIuX2hoE2JREeo29u6RCKSGvo5dmGf4VCSXArGKeIyEJd9anM9v508w=
X-Gm-Gg: ASbGncup7iMzqfG2pKziT6sFQfACKmLjWgwD5Zvqk49qa9QSCExrB5cYWmgkXSmIxGn
	necfwu6MroegAblZcp6HHTyLk3K30LVMHbpsyHIAe76MqqIPRmWZoRdD7W5eCfO7zCaDTw+CqvD
	VWFKCEhy1b41TkqVKhsRZLtXmBU/n2qYgVIf34TmXFvr9eAwpraJfImXbYMArlzFFEeFP9PgxFG
	SxpdZIC0HULUasDaYEYZDnJ4V8DaEdPXOyumg3k5HW3sjF7j1Bk/w3pqT4gp1NcSlep8Ekp/PTC
	ZItb3oFZGUwRsmHZW7sEfzkm7ohrjYIovW3B/L/NIzYX6fUH/i0D/w==
X-Google-Smtp-Source: AGHT+IGEJr3BKVh5rl646evQq6jfB80g3xvgIKAUhdZFT4W8GWtoUdBDEHTxPzLL+VQCxlsQGQXhTw==
X-Received: by 2002:a05:600c:34c4:b0:43c:ee62:33f5 with SMTP id 5b1f17b1804b1-442fd6752e7mr277601475e9.27.1747956376376;
        Thu, 22 May 2025 16:26:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a02:c7c:75ac:6300:c05a:35d:17ae:e731])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f04334sm117825395e9.10.2025.05.22.16.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:26:16 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH v3 0/7] riscv: pmu: Add support for Control Transfer
 Records Ext.
Date: Fri, 23 May 2025 00:25:06 +0100
Message-Id: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFKyL2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0Mz3SQT3eSSovjSguKSotTE3PgyY10jA5M0kySDJHMTC0MloMaCotS
 0zAqwodGxtbUA8z9ytWQAAAA=
X-Change-ID: 20250416-b4-ctr_upstream_v3-204f4b0b7481
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beeman Strong <beeman@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, Rajnesh Kanwal <rkanwal@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747956375; l=5043;
 i=rkanwal@rivosinc.com; s=20250522; h=from:subject:message-id;
 bh=Xt+9J5CINKC67/Xf9FTS32L9c6buwlWjqj4FpG7qyTQ=;
 b=voXbtY/BvjLgr1Qk+pdKoA/M9txQ+Uo8IZDt/nVzmOvCl9hu8Lrpi2vmzjOnKtVTdNeWIIAkS
 zuOwbL5C0z1CmtoSdzyA2XjmkKpBnAPcjkCDaiTFuIC9KKpMB7oMk1P
X-Developer-Key: i=rkanwal@rivosinc.com; a=ed25519;
 pk=aw8nvncslGKHEmTBTJqvkP/4tj6pijL8fwRRym/GuS8=

This series enables Control Transfer Records extension support on riscv
architecture. This extension is similar to Arch LBR in x86 and BRBE in ARM.
The Extension has been ratified and latest release can be found here [0]

CTR extension depends on both the implementation of S-mode and Sscsrind
extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CSRs
using sscsrind extension.

The series is based on Smcdeleg/Ssccfg counter delegation extension [2]
patches [3]. CTR itself doesn't depend on counter delegation support. This
rebase is basically to include the Smcsrind patches.

The last patch is in the perf tool to allow processing 256 entries. Without
this perf seems to consider that sample as corrupted and discards it.

Here is the link to a quick guide [4] to setup and run a basic perf demo on
Linux to use CTR Ext.

Qemu patches are merged upstream:
https://lore.kernel.org/qemu-devel/20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com/

Opensbi patch is merged upstream:
https://lore.kernel.org/opensbi/20250307124451.122828-1-rkanwal@rivosinc.com/

Linux kernel patches can be found here:
https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v3

[0]: https://github.com/riscv/riscv-control-transfer-records/releases/tag/v1.0
[1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases/tag/v1.0.0
[2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag/v1.0.0
[3]: https://lore.kernel.org/lkml/20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com/
[4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: Liang, Kan <kan.liang@linux.intel.com>
To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Atish Kumar Patra <atishp@rivosinc.com>
To: Anup Patel <anup@brainfault.org>
To: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Beeman Strong <beeman@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
Changelog:
v3:
- Added missing To/Cc, especially devicetree@vger.kernel.org
- Changed the commit description to better describe the need of
  perf tool change that increases max sample size processing
  capacity of remove_loops function.
- Minor fixes found while doing a virtualization PoC.
- Added the missing commit and repository information to dt-bindings,
  indicating where the extension was ratified.

v2
- Added context save/restore support for tasks using CTR feature.
- https://lore.kernel.org/lkml/20250116230955.867152-1-rkanwal@rivosinc.com/ 

v1:
- https://lore.kernel.org/lkml/20240529185337.182722-1-rkanwal@rivosinc.com/
---

---
Rajnesh Kanwal (7):
      perf: Increase the maximum number of branches remove_loops() can process.
      riscv: pmu: Add Control transfer records CSR definations.
      riscv: Add Control Transfer Records extension parsing
      riscv: pmu: Add infrastructure for Control Transfer Record
      riscv: pmu: Add driver for Control Transfer Records Ext.
      riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver
      dt-bindings: riscv: add Sxctr ISA extension description

 .../devicetree/bindings/riscv/extensions.yaml      |  28 +
 MAINTAINERS                                        |   1 +
 arch/riscv/include/asm/csr.h                       |  83 +++
 arch/riscv/include/asm/hwcap.h                     |   4 +
 arch/riscv/kernel/cpufeature.c                     |   2 +
 drivers/perf/Kconfig                               |  11 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/riscv_ctr.c                           | 612 +++++++++++++++++++++
 drivers/perf/riscv_pmu_common.c                    |  25 +-
 drivers/perf/riscv_pmu_dev.c                       |  82 +++
 drivers/perf/riscv_pmu_legacy.c                    |   2 +
 include/linux/perf/riscv_pmu.h                     |  55 ++
 tools/perf/util/machine.c                          |  21 +-
 13 files changed, 918 insertions(+), 9 deletions(-)
---
base-commit: e0200e37637e573cd68f522ecd550be87e304c6c
change-id: 20250416-b4-ctr_upstream_v3-204f4b0b7481

Best regards,
-- 
Rajnesh Kanwal

