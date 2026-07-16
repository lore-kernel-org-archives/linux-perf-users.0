Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA998412270
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205766; cv=none; b=BlpURmK2NgMG2qSWi62bbP5DjCtP3XODjzil9/lbsxrzNh89PWLEePrwwrZiworpg4aHU6gcnr6BS2WklVHr6gYs5hmKhv8UoI/QHp606yN+70LwUgzbzdAKlFxIAqCbZEXbE94vW6Q0roT7ZQOEGiUOGJVR3fV0EzZxgKRl8sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205766; c=relaxed/simple;
	bh=KoU3jsnnA0LPxfAs14/DKdbgfb7G6JNo4LfiKF8vP0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gd458P2DcfTjkj+xJeL8eO9s+m2J9Oj2Hlz5EKAdMOGf3y8nxBBgkmy2Fd2ZtAzaxd0jecy8HUN+SdZpUP3OB+hlto6uSbLqxBrURxqqXh2o8xNa+F5kQdwoSy5Yqa9GeG3RYPUGu0bvYiQFhUxxUt9vxmGUqjDkjhlyh4kl/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DCL6GzBX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DCL6GzBX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84867f07d63so7460890b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205762; x=1784810562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXHE9RUaBpTIzBZsLxmZxoZ7/zzqOF995lpxXageMRM=;
        b=DCL6GzBXuZIrpg5r4Dn7bmiec2yTU3ygsAk6XwK6sevV+7plqUyDAbaLoVIOIeJNjW
         wzPQfXizcKLAqeFJ5/0Uv/sUHhiXwumIhDwy+NjLZwH9Zg75ixLw9zL5UzPsHg7pGbOk
         Uwt2/qOSctOOcArx3Wx7zx8cwq5yPE4BlLsfeiN4Rm8HVpTk5dZO41HajxR+si6xWYw5
         tWMgQX91KXhXZb+tgoAteFh2TdWeHGNcYS4pYwOXj0rsNbIGQNTAV3uC4F0DWYmVJTra
         LpFZFFw25HJiUKzLsTg8JzR/0ialUkomNAL6K31BudhwuzOiiKrJfmRd04GoO0H0MC26
         LQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205762; x=1784810562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXHE9RUaBpTIzBZsLxmZxoZ7/zzqOF995lpxXageMRM=;
        b=ed6YgQ15z2dp1RVtzCGTGs5F4racqOFlrD21BAD1/y0F/jYWqlV/YxkAYSBVuBS7f5
         I09v8ImHOdXy5idXUkE5J0tj+wmqUP2dDD+Cdg9AqpjYndi1OCO+Pp8fhZsmrOkNWGyT
         58eNe3fDC9NVPiTsYc1NLORp0XgQNLnzNhpyqIHqZoRL/Zj+Ujraidr3uP7kDlotzZhF
         QdzR25KKtE1yVajXaiFhS/ldOzGXWK4zoqjbDwBd7n01Ug/l5re7tjXzngKtuQ/Nogfe
         +wwI+BepkYAnybEb70ko670Ykz5nlzp0X7ffnX8KZZlAETYzpeNqzEn3DdPkJ94fK4fz
         yiYA==
X-Forwarded-Encrypted: i=1; AHgh+Rpzj4hEx0HSA+zDEnJKfl8nyyGVdPUM67trKf26SHD4qrLpbJ1euk5n+ilqrXK8JlwL4I7kzwpfzsiL3UCW34lP@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4jsmC0bwPx9WyX8CIbVD36ReNy+JdaF1Fir062YyV4NYdq6O
	dCdomm+gjPsjK2CA22oBssNOd8fSHHUG+J7qxZsBbAOzTMWVP4kffGF2u8Dymd2X9Ig=
X-Gm-Gg: AfdE7cm/veuTpPwR96o4Ctn9nE0FwePWs+NG4Rl2ELPV8RiblJzh0bF351W8ZnRT549
	8vwo14708SvAcWWEwTZMBlCKYcAtMYOIMln5gAyUTBS81IXzi74kKYCg22fOfme34JJ8MBh4TE+
	ko2czHtQ1XSo3RU2HBtDigIboPUvVw557Z4ONO8P3SNI1wUBNk4a3RoD1XSsJyl8EP3SIQFOddR
	vxo+b0vlHyLVnJQdA2nlU/Qa2qW6ArdKg0bYAQlPH6yoxxVsHOHRx2x6pUIHOW0dWRabZACz40v
	FibdXob/0z2YG/ek4zivTv+i5zXGiK4a3XuJpI5prWrc4S+mUIcEZfeNb9eIwGDvPgZiKXXCJrK
	YLydWadqOHjy97sgCNhSiwfSciD5ZdPlWzaBPvH6vpuYKtPAp8bKJDS3/PQA4oGjbCmtB2kkj3Z
	o6Ixssm0xaofAmwUKSlNPtkLc=
X-Received: by 2002:a05:6a00:815:b0:847:7f38:27c6 with SMTP id d2e1a72fcca58-84a672b4789mr6422956b3a.50.1784205761835;
        Thu, 16 Jul 2026 05:42:41 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.42.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:42:41 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: linux-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 00/15] riscv: add Svnapot PTE folding support
Date: Thu, 16 Jul 2026 20:41:35 +0800
Message-Id: <cover.1784201104.git.cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Svnapot can encode a naturally aligned 64KB range as a single folded
PTE block. This series adds the RISC-V MM support needed to use that
encoding for suitable user mappings while preserving the generic MM view
of PAGE_SIZE PTEs.

The series starts by adding raw PTE helpers and switching architecture
page-table users that must see the encoded page-table entry to those raw
helpers. It then introduces Svnapot read-side and update helpers for
folded PTE ranges. Later patches make the generic PTE batch and leaf-size
interfaces work with the raw encoded view where required, avoid redundant
A/D aggregation and TLB flushes, optimize mprotect() for Svnapot ranges,
and request 64KB executable folios when Svnapot is available so text
mappings can benefit from lower iTLB pressure.

Dependency:
  - This series depends on the prerequisite RISC-V patch posted at:
    https://lore.kernel.org/all/20260618064406.14508-1-cuiyunhui@bytedance.com/

Changes in v2:
  - Rework the v1 7-patch series into 15 smaller patches: split raw PTE
    helper introduction from the architecture-user conversion, and split
    Svnapot contpte handling into read-side and update-side pieces.
  - Add the generic MM helper changes needed by folded Svnapot mappings,
    including folio-batch comparison flags, raw-entry leaf-size queries and
    fast-GUP-specific lockless PTE helpers.
  - Make the RISC-V pte_batch_hint() implementation honor folio batch
    flags, and preserve Svnapot leaf-size semantics via __ptep_leaf_size().
  - Add follow-up fixes and optimizations that were not in v1: avoid
    redundant A/D aggregation, avoid Svnapot consistency checks in
    ptep_get(), avoid A/D aggregation in fast-GUP, remove a redundant TLB
    flush, optimize mprotect() for Svnapot mappings, and request large
    executable folios when Svnapot is available.

Yunhui Cui (15):
  riscv: introduce raw PTE helpers
  riscv: switch arch page-table users to raw PTE helpers
  riscv/mm: implement Svnapot contpte read-side helpers
  riscv/mm: implement Svnapot contpte update helpers
  mm: extend pte batch and leaf-size helpers
  riscv: make pte_batch_hint() honor folio batch flags
  riscv/mm: preserve Svnapot leaf-size semantics for page-table
    consumers
  riscv/mm: avoid redundant Svnapot A/D aggregation
  riscv/mm: avoid Svnapot consistency checks in ptep_get()
  mm/gup: add fast-GUP specific lockless PTE helpers
  riscv: mm: avoid Svnapot A/D aggregation in fast-GUP
  arm64: mm: avoid contpte A/D aggregation in fast-GUP
  riscv/mm: remove redundant TLB flush in napotpte_convert
  riscv/mm: optimize mprotect for Svnapot mappings
  riscv: mm: Request large exec folios for Svnapot

 arch/arm64/include/asm/pgtable.h |  25 +-
 arch/riscv/include/asm/kfence.h  |   4 +-
 arch/riscv/include/asm/pgtable.h | 480 +++++++++++++++++-
 arch/riscv/kernel/efi.c          |   4 +-
 arch/riscv/kernel/hibernate.c    |   3 +-
 arch/riscv/kvm/gstage.c          |  25 +-
 arch/riscv/kvm/mmu.c             |   4 +-
 arch/riscv/mm/Makefile           |   1 +
 arch/riscv/mm/contpte.c          | 804 +++++++++++++++++++++++++++++++
 arch/riscv/mm/fault.c            |   4 +-
 arch/riscv/mm/hugetlbpage.c      | 135 ++++--
 arch/riscv/mm/init.c             |   8 +-
 arch/riscv/mm/kasan_init.c       |  16 +-
 arch/riscv/mm/pageattr.c         |  12 +-
 arch/riscv/mm/pgtable.c          |  52 +-
 include/linux/pgtable.h          |  71 ++-
 kernel/events/core.c             |   2 +-
 mm/gup.c                         |   6 +-
 mm/internal.h                    |  39 +-
 mm/mincore.c                     |   2 +-
 mm/mremap.c                      |   2 +-
 21 files changed, 1542 insertions(+), 157 deletions(-)
 create mode 100644 arch/riscv/mm/contpte.c


base-commit: b8809969e1d7a591e0f49dd464a5d04b3cf02ab1
-- 
2.39.5

