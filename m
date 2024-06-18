Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED882374C;
	Tue, 18 Jun 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724359; cv=none; b=eorAfFoEewcGbSeKrPvfKB/4R99KS8PUpDmR5x0YmTQKnlEpQvdL50bpF2uujrUFv8WZPzEOKo8sDJvAh+teVxR9S+QClb0uUAb56e6NkyOohehVo3LMAVrFyDq0QoUxF1oWbWhA0JN3nz0r76rGUG3yiRt5qfDxfEu2hIGBzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724359; c=relaxed/simple;
	bh=VNbW377FxHKSRduBEGG5JlZNIdc6B0fFGcQgz5k1KTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QkHwO0RuxxNOBpNuXpDh6e1xHkebm0EzVRmrgEhUCxSv7sEyfDMBSxt1LMaR1BHp/MGh5fKmKEyojq9ccI/XNqXlPV1bBSCUInJe1EVawnI/jRZYaknEhZ2cpf33kpJhQs7hHfNuBC2BaVQ1SkYfCrlZHeiQ+BUAe+4TbRb6EDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWdYFCqf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWdYFCqf"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70625e8860cso359227b3a.2;
        Tue, 18 Jun 2024 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718724357; x=1719329157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxka6Zoc6sXP8lq5riW952EJ/grY1vir5clQUpUlLG4=;
        b=BWdYFCqfJOlIdYp6uIqOeYbOk26TXz0dE1rHA+tkqZQvZzzNoa84T2Fsul5Fbn/XMs
         Se2Yn7B5ivU143zqs1KCbL1y51XxWSLrNeB+J30oFLHhmoqR/zZXhVdnwNO87KFSJvY1
         J5HLALvD6Luxwhc5HxcMnl26bJdPmKyFfPn1/sQuCWjb2aN1zaQinquyw8CWbcsDmJ+l
         9FBmrYCJdPvhKGY3RWwAX/NLQI52v7b5Y7pshPrAWYgFWhNyRqh792ScPzjkt/GpAvI4
         4cn3boeCv5M9dLZ12e4nflgw92b1gtWOmqzSBzSM0N9fP8khsJjzzFsV2t+VGZTjp+MB
         cptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724357; x=1719329157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oxka6Zoc6sXP8lq5riW952EJ/grY1vir5clQUpUlLG4=;
        b=cRN9ywQUVEyBZimO0IBPy279XkAjngrRUq1rEFf6wKpnPMMoAh30jDRxI7DJNNtkUk
         EKjdFyexGySaFLotbAf2fIhr1TN8TDBi/XhJFtWWTsd1B5glt4vBsASy1OeGzGKOPp0D
         sP9lJYT+1m8N932SxbM7lXNa+P3+rhwONClZwIFDlZ2s3Fl5NvW4JKU4ypCSJc1Ogdrv
         jOpdgI/nEdy/6UF9FA5i8JyZ2FhsDpdn/sv5o9hRfX6zfaaXgAkZqewPzgeBnvveDoES
         evtefE4dlXs8b32jAdqb1HZ/qcazJRNIMGKmS7QCQer67zPqDYA+7Y0JrpC2kTWEZveJ
         8exQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFo+uyuRCe5hhaDH1/vfWSQkJjjJlSg/1xAcZf3dXhTj6vNR2HhadzcNGIb8EhCUcVLTixiuz1jmrMWymxPc+IBzXT/SqRxpuxCMUnmSCIoa/1CT3wwd4XJDkMxsivkQqBAInSpF9MgfRmylJB5Q==
X-Gm-Message-State: AOJu0YxwR3SANpMOcoPDh+tpJLqUT/RBnwTe3ViLoTsaLx2Ulyfc0/3s
	UnB7brYsxxxXtSLkP+3OfdPbHOzq3XOLTsGik9Kksi/aCzUk7oK+
X-Google-Smtp-Source: AGHT+IEO92ppLbf/qQl6G9UId7afd67i8PMLWufc89G+6MC41MGmLLyJyAVXUi1ruQtTo18vCvYzGg==
X-Received: by 2002:a62:e516:0:b0:704:3aca:7845 with SMTP id d2e1a72fcca58-705d71ba1cbmr13821331b3a.22.1718724357239;
        Tue, 18 Jun 2024 08:25:57 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4265esm9071388b3a.116.2024.06.18.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:25:57 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 0/5] perf trace: Augment enum arguments with BTF
Date: Tue, 18 Jun 2024 23:26:47 +0800
Message-ID: <20240618152652.3446472-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Augment enum arguments in perf trace, including syscall arguments and
non-syscall tracepoint arguments.

The augmentation is implemented using BTF.

This patch series also includes a bug fix, which makes more syscalls to 
be traceable by perf trace.

Test is included.

*** BLURB HERE ***

Howard Chu (5):
  perf trace: Fix iteration of syscall ids in syscalltbl->entries
  perf trace: Augment enum syscall arguments with BTF
  perf trace: Augment enum tracepoint arguments with BTF
  perf trace: Filter enum arguments with enum names
  perf trace: Add test for enum augmentation

 tools/perf/builtin-trace.c               | 214 ++++++++++++++++++++---
 tools/perf/tests/shell/trace_btf_enum.sh | 104 +++++++++++
 tools/perf/util/syscalltbl.c             |   7 +
 tools/perf/util/syscalltbl.h             |   1 +
 4 files changed, 301 insertions(+), 25 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh

-- 
2.45.2

