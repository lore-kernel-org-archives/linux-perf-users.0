Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278BA19FA82;
	Mon, 24 Jun 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252729; cv=none; b=Ln54cvBz2jkjY/AncDlIwtZ7ELeLUIlV/vjLwThuHiKcUYQHYKO/J2o/wnbGZBX85kDNiynJQudnKDTqsto69k9pm8+GfLmi1aSzUNdcW1tCwGUOl04xjKbDeNOVyOEXf/BDh8pRGKT6fImGUf5+a7N3UHc/bAiMOUeBr9Q67BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252729; c=relaxed/simple;
	bh=nWtXz8km4Zo72fEoC7NIOWvBSF+VEpTyKBgyQtbbg8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d4Rz72XvIfrFw1hvg1uNPp9jsT7Exsm6x6HXYf2iGJhjUPlRHJinIEOT/AUDsmy1PISFavL1GyvmP0WUH7VWlv0d0ThOcGeUwEh/13qubPbOu3JD2ZoN/u2jxS8V8B50W3k5cydSVIs6fZ1DWBddPAUZ6YlYUkUY8PKn39rmsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn9cSoR5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn9cSoR5"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706524adf91so2454030b3a.2;
        Mon, 24 Jun 2024 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252727; x=1719857527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SrZt8FZ7JyxLkVvewiRjkX5CzGN+V0siheiique/A+c=;
        b=Nn9cSoR5zIhi+43x9aAcNHnAUY01/55saeweZnYlwwOETeVajVRUkhirUZI0W+zJUB
         vWyAE2YXVuH5qbadvD+8MzIjo2IWcvwcNLN+3x4f4q8S6zGaxvgJBXbwZGxxWwv6OoCs
         bvDq4mUKxJ1V/0vxLNiT/iT472pYQO8JX257o3E4v28vk31llSo82b+VQl4HtmOTc0/D
         vD2dkUDHFGvHi0qeTrn8hEKV2EdUPKAp1QYNww2oCfXSWdfnUqPhW6T3D0443iXApQBB
         OONyFLi6hOoAbn1g1ccNqpJp9+NpWQzHoVgkKpOClb9Bx1KYhCpNYRYbqJ6GAha64uiZ
         QF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252727; x=1719857527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrZt8FZ7JyxLkVvewiRjkX5CzGN+V0siheiique/A+c=;
        b=pet2YekKfj09uUeZZvTFM24xQq4gMimZwWf4N5Hz1d+Opj6nDehcrMM6RSrIfQP7FU
         Q/hgoRXDeQ/KB4dHnS4l8izRgQLjE8kyyft3nE7T0sDfLbilVcsHeD/i9rAX/DeOzoAU
         adjsqgYxT1UZ69mP2o1zMMQSTbZ+QHAjSO4+z6iKOg6N+OHej12Fd2Xor2ElP1uQAbfh
         +7zqUelPU5IWSGMkkt6dG+rqPeBimuDzAK1pqqe4zwymsgRjvSBV5Ch9cfhTJPBtrM3n
         w1itmmHXSNaemOInN7V+tbnzacy4zfLni/KHHMqd3yqzvHaY+OswM5LWtIyTcJzNIQoo
         Oh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5n2+eraDsDD5E8IHwMrBOZCHf5ThVtWKf8PVkiS+0yPPSYmbuSuW0zma30e5IA/xU1SY19J5k/UX26HgHnYD/Do9V/kqw3xjTyldWSlZ0ldRG7IGRPxWB8Ps4kbsLEOMdUKa9WfoNEiYYnkBpkQ==
X-Gm-Message-State: AOJu0YwSL6XqBt7/dJ902e0FCBZiYsP55brB1zco7TYK+H/sq374bMTS
	604kqAWb5twQhjSphH7wX05XtRGd6dlbgqDTk8ZkuG7hsMeGFXPRKju9eoZU8pQ=
X-Google-Smtp-Source: AGHT+IHt+3IaxEIIWBB3IA/LTpIc9L0kOoEBraXaBhI1Wm3HUlvt2hjILSfNr/EfR/YEGpGbBTcFwg==
X-Received: by 2002:a05:6a00:2c2:b0:6f8:e1c0:472f with SMTP id d2e1a72fcca58-70670eaed1cmr5036950b3a.8.1719252727510;
        Mon, 24 Jun 2024 11:12:07 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651290157sm6525157b3a.150.2024.06.24.11.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:12:07 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] perf trace: Augment enum arguments with BTF
Date: Tue, 25 Jun 2024 02:13:37 +0800
Message-ID: <20240624181345.124764-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In this patch, BTF is used to turn enum value to the corresponding
enum variable name. There is only one system call that uses enum value
as its argument, that is `landlock_add_rule()`.

Enum arguments of non-syscall tracepoints can also be augmented, for
instance timer:hrtimer_start and timer:hrtimer_init's 'mode' argument.

Changes in v3:

- Add trace__btf_scnprintf() helper function
- Remove is_enum memeber in struct syscall_arg_fmt, replace it with 
btf_is_enum()
- Add syscall_arg_fmt__cache_btf_enum() to cache btf_type only
- Resolve NO_LIBBPF=1 build error
- Skip BTF augmentation test if landlock_add_rule syscall and LIBBPF are not
available
- Rename landlock.c workload, add a comment to landlock.c workload
- Change the way of skipping 'enum ' prefix
- Add type_name member to struct syscall_arg

Changes in v2:

- Add trace_btf_enum regression test, and landlock workload

Arnaldo Carvalho de Melo (2):
  perf trace: Introduce trace__btf_scnprintf()
  perf trace: Remove arg_fmt->is_enum, we can get that from the BTF type

Howard Chu (6):
  perf trace: Fix iteration of syscall ids in syscalltbl->entries
  perf trace: BTF-based enum pretty printing for syscall args
  perf trace: Augment non-syscall tracepoints with enum arguments with
    BTF
  perf trace: Filter enum arguments with enum names
  perf test: Add landlock workload
  perf test trace_btf_enum: Add regression test for the BTF augmentation
    of enums in 'perf trace'

 tools/perf/builtin-trace.c               | 229 ++++++++++++++++++++---
 tools/perf/tests/builtin-test.c          |   1 +
 tools/perf/tests/shell/trace_btf_enum.sh |  61 ++++++
 tools/perf/tests/tests.h                 |   1 +
 tools/perf/tests/workloads/Build         |   1 +
 tools/perf/tests/workloads/landlock.c    |  39 ++++
 tools/perf/trace/beauty/beauty.h         |   1 +
 tools/perf/util/syscalltbl.c             |   7 +
 tools/perf/util/syscalltbl.h             |   1 +
 9 files changed, 317 insertions(+), 24 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
 create mode 100644 tools/perf/tests/workloads/landlock.c

-- 
2.45.2

