Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC1381EA1
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068570; cv=none; b=W4INjVv7ez32l5sszYcZKV8Fjf+NLfAiRFROONfraI3AJR+d2A3xbKGc5/6KFMHnfGVktRwfH/s5tMJmTFaCbYFTB9HMt4kE01Mgp+ECw6PDdAWMGpEaTwpby5W64gkbsiFP38AZ884PTIW4ZTlhW378P+Fg+AlSb9BMRlu79eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068570; c=relaxed/simple;
	bh=EWnv07DWloHMIzkcvB+TMe7XnJ2cm6FV6nkeNMADT+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb7w9RbtX6H2NdST+ki0HuMOsuA7mw9hHbkGYSMRfFZ+uBPlz6/mqAtYXYyXamM7alvk5AbiyP3mQDEQt6ONv1J8iDwT2PsUwKzmqKnHftXuskMWM+eajZR+smrUxGvITM0V8A298DzBypwxb0e7WOCFvPumLnY9gUPeiFfr7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE1m9exK; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE1m9exK"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aa9606ddadso1488883eaf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785068567; x=1785673367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWX/ZZduUGn7dvOGbkdZ90gJ+u5X4idkSvz+SXiZQGM=;
        b=FE1m9exKHLvAS5o8BjC4LgdZqTAQmeDiCRP6Fm/+xbACJcyN1TzGYr92GoWNuxLmlg
         j3J5VYJhIbyD2BsKoBD1M0yVoqpIrMV5H9nRLTky6fVIpq6tEN9QwGDwEvlzClzVJ3LM
         iB9OWMUT04IuUPiq/DRCNGKnPG/n7LWU91GQiLYvBkgMSvav8SxCIf0Oj0p73W2bIBzG
         bISQ96f7jbbiUmHBlm6s09ZkCZHY6si2+sn9zDXNTomkDQKiZVAo8SHgTeDw/J7M7wZ+
         IicURTfq2sHn8lcR3infjIWyp2tBVOUtMCOATzyRhKI3AhfBsjEvsxpnHuF9PZbNYdJf
         SQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785068567; x=1785673367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWX/ZZduUGn7dvOGbkdZ90gJ+u5X4idkSvz+SXiZQGM=;
        b=n+/o9PM3zXMPWDwt7m1PTZ8nIPN+581Ndnp7Kzg4yx7NTX/h/NrIZHnfrAUptfIxdQ
         KCMa8ejDN6WNSPKwxzIrpuaNXabgVbt1xWV68ECWfHmbm8i8F3yowlUx1BPZ2c/aGPS8
         brTHz2wgGND6mKDCP+K3KKooleqrmonxI9O7ZUimz0hsSQbJiIX34ML8Dnh/Go18fS9o
         EAZ95eFp2vLw/uSyNW9bi2MRDW2QaLUC9QVee40NMCIugdqQbPfgfdXznIFSvTUU9+zT
         P9hlarHGahxKv0wavlQvQfQ/Hj8jtq0/KydijBVkZgq8nHtU5+a1NspDTe3bKV2b2OTe
         DSMA==
X-Forwarded-Encrypted: i=1; AHgh+RrBMmFtMJQ6UPm0GAJ4JOQoij/atw0K+i9KLkzXEIsSt/3J0fJZLH2F1MctYPvqKlfNsuSkKJmbiTtpNZgwYH8y@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9X3ll70oMAHqVUcXBKnJx2621VxQ5u9/jwFLuFYLRXU4+A5/
	gtIZH+NDjPaUZhr16cT30kj71MAefS1AMqTfGrcSuXgLwtWpDoTg8U7X
X-Gm-Gg: AR+sD12tsxQoTlzkMIrEbgINaPyzaJn+W511WXUOMbTnWG4wDZ/+ZzpYINuWFZiKmFK
	6y/+CqDmwbU5Xm5o3Oq9BOitjEvkR0pt7xinz0l/wNMmw8oB9+BOUnMWK3tclR9q5X+K7h1Yu53
	01RULcER5+mnbcFiEpjDAbrKFZ21iDpErFvOD57iohOpD2O1YyLbPGSweBkPgKpMrK4B3fEA0FJ
	MoA7L3ohC4ClEXjng6Z08JbDo1HI6QvFzdG1/nxY0sF8supMgcR8cQh4rg1i9QTL1aO3ORT291Y
	Ot2q3hDYuB32dp1W5daZZgLGRr6kp5WZktg2eQv0F91wZPHa1AlHuSy0AIJRRS8UmrE14iMyJK9
	k82hiKSZSW88BhDgvcpkwJyUtCemAdgkcDUWUPdxrfpwFJ9keD2nKeaOeg1ulPi1AAV+y671KDx
	tm0Q==
X-Received: by 2002:a05:6820:450a:b0:6aa:dfcb:3daf with SMTP id 006d021491bc7-6aaffa204f3mr3158838eaf.51.1785068567318;
        Sun, 26 Jul 2026 05:22:47 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf9363793sm3403006eaf.5.2026.07.26.05.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 05:22:46 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 0/3] hw_breakpoint: Fix and simplify local address updates for wprobe
Date: Sun, 26 Jul 2026 20:22:29 +0800
Message-ID: <cover.1785067572.git.wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178476143000.26117.9810509272687580410.stgit@devnote2>
References: <178476143000.26117.9810509272687580410.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

While reviewing wprobe v10, I prepared three patches to fix and simplify
the HWBP support required by wprobe.

This series is based on linux-trace/probes/for-next, the same base used by
wprobe v10. It is intended to replace patches 5-7 in v10, so it should not
be applied on top of topic/wprobe-v2.

Patch 1 fixes the x86 HWBP slot and DR7 races when an operation is
interrupted by an NMI.

Patch 2 adds arch_modify_local_hw_breakpoint_addr(), which updates only
the watched address of an installed breakpoint on the local CPU.

Patch 3 adds the matching generic modify_local_hw_breakpoint_addr() API.
It keeps the original patch structure and Masami's authorship, while
removing attribute parsing, type/length updates and rollback.

With the address-only interface, the install/uninstall refactoring in the
old patch 5 is no longer needed.

I can take care of follow-up maintenance related to fast local HWBP
watched-address updates.

The patches passed checkpatch and the relevant x86_32 and x86_64 object
builds.

Jinchao Wang (2):
  x86/hw_breakpoints: Make DR7 updates NMI safe
  x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

Masami Hiramatsu (Google) (1):
  HWBP: Add modify_local_hw_breakpoint_addr() API

 arch/Kconfig                         |   8 ++
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/debugreg.h      |  36 ++++++---
 arch/x86/include/asm/hw_breakpoint.h |   2 +
 arch/x86/kernel/cpu/mce/core.c       |  20 +++--
 arch/x86/kernel/hw_breakpoint.c      | 114 ++++++++++++++++-----------
 arch/x86/kernel/nmi.c                |  10 ++-
 arch/x86/kernel/traps.c              |  10 ++-
 include/linux/hw_breakpoint.h        |   6 ++
 kernel/events/hw_breakpoint.c        |  30 +++++++
 10 files changed, 166 insertions(+), 71 deletions(-)


base-commit: 1a416ae446afa42d2d8500ce25bd61c564508721
-- 
2.53.0
