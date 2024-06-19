Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265FC224D4;
	Wed, 19 Jun 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785188; cv=none; b=tCydbFXFPxny3lhJesD1KalmnDsUXsyctb3K/dBG2jOdNcnAIf2NuYcfI8j/Tjrby3OeDw4c6Zv2XQmJ+ivb06kBdR8TDQPhsLpS94QjU5JBTa7F7VQI7XFVmsAaAQsjbSgNrYGPo7+EtFLRVq1zIHVz801nmncSp9GdIOCzVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785188; c=relaxed/simple;
	bh=U/6PaVd0sn6BuQ1Z8uJo+QV1aXzlBdtU3YjkF0Qnd9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zx6eD4gWIzwFb3OYzh24KeWocsxk/72kOzRaYe01ygAzFvUxW/d53kZ0W9yP0Lj3QiiqjX687r3DKUW9Xc+DDL/diPjDxF/zHJ0P7k46PPZUQyzSSVLfANaKQlEN7Oq3/6qXhtKYKkNbATdPYnoT+ZNtaHG/Trs4tFmyLFzhWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8sRKKI5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8sRKKI5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f6a837e9a3so40520505ad.1;
        Wed, 19 Jun 2024 01:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718785186; x=1719389986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIsaiR0+0fhceiTdrnHdlRIEev/J+ctV391EE8b9p48=;
        b=B8sRKKI5tN1a+04e7KcCHQU5snr/7THl20rVL9HSsL5PFiROZFoxOwN4DQ5+GSVHJu
         mlrhDgMk/4eNgyNGm+EJMD9avem9Ny3iRJ1vhswqxuI9ZA1l17w3qzHP5l5a+svBMeEw
         iDZAarscX688DhquF0UGyu74CD94lpiZ/NQt5S0q8RNipV8IZUrMUJNMKHcmiUtfrMy9
         /rG2byK7yXIHod/pO5B8rky+ptALNejjV+2bFTB0P896KTOriY4NjpIxn0tNVbcDU0NW
         f1yxlypCqhJNeLpF+oFexiuDgGGi891/QIuQuOBVWflaEsk5/EopnMtH28psHY1zsolu
         lh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785186; x=1719389986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIsaiR0+0fhceiTdrnHdlRIEev/J+ctV391EE8b9p48=;
        b=aETceJ5ANubOeiM/SUmUBcrPFB1SgW7R8rzkJfppdcYDnUZKVxB7MptoDOF56TxSEW
         ZCYefegeZ59FtqL+GniGfmSNqsD9ewJ4ypP3wG1UZiTx0nObJbxF03MF8wlNk4nsngdw
         PZ5RjKM59zV6CtYNeEghNJg+qWOe7ZyIXxFBdNLOotcKkkhba74DJxJ+qIlF03geykoc
         073Z7nfnzH2zRkTBUsHBOPztY5DVl4mswG/Ikid6mmTxQWp9JqV5tzJPopfMYf78uTZf
         CSwaaDuCbs5crlQtFKsHpnKDX8V4ycfh5eCxhEJly4oiLNtZ14BXEMV/xSJmDIUFDSKe
         sE9A==
X-Forwarded-Encrypted: i=1; AJvYcCXBtt89wPh5QAEMiXQpv3YI+oOLdLwerZ98RLQwWmcOiKDaaoQdND5xA8Vssztbd6RiWsXaNCuaHND6tn5ES1wfaJAQka4XhzaasNH4pYtl5FiXmZivqrzBEErVex3Mr3fcbohABcSFvUt/7+ccUA==
X-Gm-Message-State: AOJu0Yze3n8o8ILvtbuWtkinUzHI2/ktwEB9WYCgHQ8cZoT2HXz0KrUz
	3QBfJzyTdMQJnNL8WvfSdukZaIg+TdNEdFMmieFNThrHAJajbZAz
X-Google-Smtp-Source: AGHT+IFHjm4QqIVzAWWScaMIxReIlqu5KnL2XmtdtYV1eTUAB6vdAFn8U9TsfVwZxoP2CnacwQ3tdA==
X-Received: by 2002:a17:902:d2c5:b0:1f7:2bfe:87a2 with SMTP id d9443c01a7336-1f9aa4734ccmr22528415ad.62.1718785186391;
        Wed, 19 Jun 2024 01:19:46 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1decfsm110368105ad.250.2024.06.19.01.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:19:46 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/5] perf trace: Augment enum arguments with BTF
Date: Wed, 19 Jun 2024 16:20:37 +0800
Message-ID: <20240619082042.4173621-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

changes in v2:
- Move inline landlock_add_rule c code to tests/workloads
- Rename 'enum_aug_prereq' to 'check_vmlinux'

Augment enum arguments in perf trace, including syscall arguments and
non-syscall tracepoint arguments. The augmentation is implemented using
BTF.

This patch series also includes a bug fix by Arnaldo Carvalho de Melo 
<acme@redhat.com>, which makes more syscalls to be traceable by perf trace.

Test is included.

Howard Chu (5):
  perf trace: Fix iteration of syscall ids in syscalltbl->entries
  perf trace: Augment enum syscall arguments with BTF
  perf trace: Augment enum tracepoint arguments with BTF
  perf trace: Filter enum arguments with enum names
  perf trace: Add test for enum augmentation

 tools/perf/builtin-trace.c                    | 214 ++++++++++++++++--
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/shell/trace_btf_enum.sh      |  57 +++++
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/tests/workloads/Build              |   1 +
 .../perf/tests/workloads/landlock_add_rule.c  |  32 +++
 tools/perf/util/syscalltbl.c                  |   7 +
 tools/perf/util/syscalltbl.h                  |   1 +
 8 files changed, 289 insertions(+), 25 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
 create mode 100644 tools/perf/tests/workloads/landlock_add_rule.c

-- 
2.45.2

