Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D631B833;
	Tue, 17 Mar 2026 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773719399; cv=none; b=g2094Eg9hvgrU3NiWTmG4HqGaOs4AfNe10VMh6JjuCpP6F/OXfv438kWhs63puPbREWBWHlAJJR6N/HGqrT3aLR/LWbn3aL4UIjWfG4FowNUcFDJufGzCx5s8iXiyKTHgt+FH99tU4su6WfQLUHJFOoB1K670pFTk2cpumpFl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773719399; c=relaxed/simple;
	bh=ZQgKbejojpdPVLIXZPk70F97zS4m1Dp7lkV4cIgWVQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tEdwVC+CZNzb4Zu4I9Sq78MEb0oF+zf3jG8X3rG9Pa9rofCk94lIAblR5iTnF9GQKWtdhCvny0hV7ObLweirCAVW/Bi+h2YhrT4QsL/5ekn1giJoFV+P78u+lKc97Gk8ly3xfgUajIs+TkUjEi1M/o9OZONFt2S73G97Gt960/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hB4pWCPj; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hB4pWCPj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773719383; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xWngtpObbjeyx2KTcz5ogpg82L+5SXTyDpUJYBAyjEY=;
	b=hB4pWCPjtlcaY/f8tdTeckIgxAg7g4tzTJi7JJQHZJolZcaJqBFbJ3iMh29F+AZg+NBU7QyTdFwY+uS9CgbHbtVwEVr0NC7FSRicS47fVlfHkBPdSXxJX4gYOObdXxO+bOZ7kGdcTrnEX7GoYcwKorDJ4ThaoB7toZvROf8tHFI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X.9XpQ6_1773719378;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X.9XpQ6_1773719378 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 11:49:43 +0800
From: cp0613@linux.alibaba.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	pjw@kernel.org,
	alex@ghiti.fr,
	guoren@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH] perf symbol: Add RISCV case in get_plt_sizes
Date: Tue, 17 Mar 2026 11:48:47 +0800
Message-ID: <20260317034847.4136-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

According to RISC-V psABI specification, the PLT (Program Linkage Table)
has the following layout:
- The first PLT entry occupies two 16-byte entries (32 bytes total)
- Subsequent PLT entries take up 16 bytes each

This aligns with the binutils-gdb implementation which defines the same
PLT sizes for RISC-V architecture.

Update get_plt_sizes() to set plt_header_size=32 and plt_entry_size=16
for EM_RISCV, matching the architecture's standard ABI.

Since AARCH64, LOONGARCH, and RISCV have the same PLT size definition,
they are merged together.

Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=bfd/elfnn-riscv.c

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/perf/util/symbol-elf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 76912c62b6a0..806936d95523 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -372,10 +372,8 @@ static bool get_plt_sizes(struct dso *dso, GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
 		*plt_entry_size = 12;
 		return true;
 	case EM_AARCH64:
-		*plt_header_size = 32;
-		*plt_entry_size = 16;
-		return true;
 	case EM_LOONGARCH:
+	case EM_RISCV:
 		*plt_header_size = 32;
 		*plt_entry_size = 16;
 		return true;
-- 
2.50.1

