Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B613D243;
	Fri,  5 Jul 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185648; cv=none; b=T1NjpzSRqZWq9Di3X4emReIV8MRY9jb88TUyhgtZ1ZaJpmhddW0Qzy/iwf2AIfzcpN8JtC34yfsUPgiQNOtQ1RpCl+kIGXfvEw7i3u1DwSsfMgoG26vRNkwOLj1+ge3g+UHZKyEGFZp8/oQ9AK+wQz2qHT6LF5yuezAImVgZ0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185648; c=relaxed/simple;
	bh=rTvNpJokC0lG2aO9D2Q7qgzGqbzrym7I10xGbDEqtQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nGamkjJAS9nNIVIpepFgNGpKUawNCzmkq9TkN1lFxjKbxxJwbpTgmh1x99/DnGZCVOMXiEs/DZes3MCtamzB1XXHYV7R71zGP87wFGIcrzaf9+1hzLX1aLaEZwLb6OThuyJC/g8Cpwzh2Xpen+32K7in9eTKkZB10Dk4MFA963s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQtx+zVb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQtx+zVb"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-707040e3017so1024259a12.3;
        Fri, 05 Jul 2024 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720185646; x=1720790446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qW+kigcKFLfW1wvMQ24dxSV2zZqmDDqCX6hcBun385k=;
        b=JQtx+zVbxMCWZ2SV+G/7aFLEVK/lKTSU46iV/uhs0QAzaZflRCIgjuPBaTqz2mSNv8
         Uv3JsCl3VdivGrB16MyljVGiS8/hUgFk28Ua4+Tj49lLbTYUHjezDqYpQPrYZ2LImMdE
         T58qr8I4bu9oBGY6KNx7n+DNplw/S3NNVNz2soB92xCKw96+lAbleb1RXuBZUHheTD3u
         GI+XT8XyNNvPapOPZdvhMz2KgDO4qen78nEamYJVS3IMwr6yrQEvKo4Goq2rgnbGnkTj
         T0xOTnaetY423JpLC3ljQ9DMFfUpzLktKg2My99BxBruIfWceRPmYk2ULVduicuDzaQq
         H8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720185646; x=1720790446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qW+kigcKFLfW1wvMQ24dxSV2zZqmDDqCX6hcBun385k=;
        b=G+G41XQhk4c9EhaZelYGOBIv7rMuR/biXr9CZWAUd1zoWfMFAW75I7zmWguii/7df0
         MG6VvFdXSiETvu4dDhj5uFuJurfK8+AdUWYItYQI3Uw9GY1KuNrOHmxXQygZ94O4YD2C
         qsDKhBCh6AXrDqEFaSom2VnWQYgp2+V9ov33JUqnB9BZty5UhxQ5DLubdz0Lm6JeR4Cz
         lUC/nj67dtHCoCkmtZyTzd/fahGpYGxonksVrQxkx/64DlQ4yNrpubkIjksHny91ni57
         UIU6vrkXmmCN2/B7s6Rv3qQt6vrnFftFrvdaZzOAPOJVz5D83wa4dH+W0c3JNGeyfM0M
         HVRg==
X-Forwarded-Encrypted: i=1; AJvYcCVhxu1psReondDuwlIrynMDcERjrNAJ4mi8/RKUacgBlkmZIqrMC+TrFd1fR40QkK4xEIoum6JDfP6vZmJJz8GVu00AMxbZllDlWsFGnbIvIqjS2wk4foVyvFViknRgUvJGVbPj2gfjqpwgH/Xskg==
X-Gm-Message-State: AOJu0YyIq5TCm8B+alGzSqT/x3Gub6ZuzbNexIusXLRXLVTm9PXurH8y
	3Fv36aoKlQ1Bm47MsKwwYv/PytuPKLsaqKdAkTnNU2EtW761PCRc
X-Google-Smtp-Source: AGHT+IHFN/lk7+EFngK+6ujr6zRCjz/N7irk0fL//TkIQ9U9VARi9fx1FXCUoCNvSm7aB8N/WGDoTA==
X-Received: by 2002:a05:6a20:1591:b0:1b4:6f79:e146 with SMTP id adf61e73a8af0-1c0cc87734amr5506858637.17.1720185646277;
        Fri, 05 Jul 2024 06:20:46 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a956260sm3328974a91.19.2024.07.05.06.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:20:46 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] perf trace: Augment enum arguments with BTF
Date: Fri,  5 Jul 2024 21:20:50 +0800
Message-ID: <20240705132059.853205-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v5:

- Use hardcoded landlock structs and macros for landlock.c workload to
make this build in older systems.

Changes in v4:

- Fix landlock workload's build error.

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

v1:

In this patch, BTF is used to turn enum value to the corresponding
enum variable name. There is only one system call that uses enum value
as its argument, that is `landlock_add_rule()`.

Enum arguments of non-syscall tracepoints can also be augmented, for
instance timer:hrtimer_start and timer:hrtimer_init's 'mode' argument.


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
 tools/perf/tests/workloads/Build         |   2 +
 tools/perf/tests/workloads/landlock.c    |  66 +++++++
 tools/perf/trace/beauty/beauty.h         |   1 +
 tools/perf/util/syscalltbl.c             |   7 +
 tools/perf/util/syscalltbl.h             |   1 +
 9 files changed, 345 insertions(+), 24 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
 create mode 100644 tools/perf/tests/workloads/landlock.c

-- 
2.45.2

