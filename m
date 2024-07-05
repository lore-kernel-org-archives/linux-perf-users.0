Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E4144D34;
	Fri,  5 Jul 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172571; cv=none; b=IDZAl/6LHeBa/abmc+Wpz5ToLBLSf+wpiPFtoCq4YNMBflMo33Pw3pMENc7F5RaCvMy5cELsDq2/z9GqUszIpWY71pfS1Zd2AuIhPRZ1EATK45hv+M2WQzJymQ24u5ft4G0VcUkxcXE/DVCMH6jbHyf25qNQ8v5WH4lVGsBO94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172571; c=relaxed/simple;
	bh=rTvNpJokC0lG2aO9D2Q7qgzGqbzrym7I10xGbDEqtQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YP+4LPo34LGjv/FxQvmQnOL5KzeTnjdAhireQjYnuDaS+CXXoSde8EKbKRcyQsO7OvKT/GDIMEV8VImwKkZRvH2Ba12sJ217Bn6ykh25GTJ7tcw5d0JUW6cmySkj4VkHYI1v3CyFJztzQ11fKx0bKYTEp0ku1+kdrijWqu4klME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqDOF8X0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqDOF8X0"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b0e9ee7bcso305123b3a.1;
        Fri, 05 Jul 2024 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172570; x=1720777370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qW+kigcKFLfW1wvMQ24dxSV2zZqmDDqCX6hcBun385k=;
        b=BqDOF8X0s0X6I1ox7XjvUiKTm8I8ukZmshRrlHYoHVQKGBmVsP57AZrTnYQqqooLwF
         UyIN8zI8sfwTpRQBspd5SlBgHM/YiDlPlukz+lNcr3GLI4uIMa8ZbcZHHwdgx3o+QzAy
         EQjduomtvAKynn/eQAdoPcKCpi7bIAQuBA2IBYzGm7SYVy75aAe9wZxlG2d3HBfQoH9b
         jIqgZMI0v4I53ZY+QactDo4N+cCRcR7T7dTeYbXWzKt5GuXFH5PwVQAfE9pR0LseErxD
         h2d405R687Y87d76K/nFfalx4rDJLUfcZB1j6Bs2Kic3n57ZVF51xnNcziP1TclqNyrJ
         Mdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172570; x=1720777370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qW+kigcKFLfW1wvMQ24dxSV2zZqmDDqCX6hcBun385k=;
        b=aaD4SlNvcMe8dSysIPopgUXUxrrBAArvqHNitIL3mKp/Q/SS3eMzHLmi5+O69Dya7U
         Oe8Z9ue/2lA8tvJlcfPONQc3qGZ5w3xzi9FBQaE1mUdHXIcQZMZCUmjbayYjXIrsR4FD
         O9o/I3QDMR9HNZdj0kmTfaGz2kJUNNKomFYvvGsDqojinO1cTVQ30sqA3KbkwiRvFdb3
         +bQrTmOVbJFC//L9GQR3iT31H/oTJOUYX++Bk5b7KLvX9Ui+G4hvtWAn5r0DbOAX4lUg
         D/TEW1J4Kuw+iAnEaIAzNOwTKU0xnqAQfmiguGpy39lK432779+tmLnfrdYsaRdEi+I5
         8T3A==
X-Forwarded-Encrypted: i=1; AJvYcCXW3WX9Q7qEzsQFyoTkoWUhBMyemG/i9gsFP3yfHqFxIdrt1Brht/n+K3wWp2HH9HxRrMKMKCafRC5laBvB4Qo1+zV/UDdfwkpDp4dgo34pY6yYiXIdSjFexzR/W4gWfyfcF241+u1DTnQCjYndpw==
X-Gm-Message-State: AOJu0YwHeUF+Tc5S9iGz4kDRj8mROVnWZgAAuolEmULriHVxJ8KXm34i
	rpgfE7zZJ6IlxhwhqK4+FRbkFDMqHUWi881d9xM5/gIezaVNqphN
X-Google-Smtp-Source: AGHT+IGIIDmof9plM75cbzvPSgKJDOhze3lOAZjJF4Yz6URnqy+t30gr6BKtaQ8riYJFmraMVK8Cqw==
X-Received: by 2002:a05:6a20:7344:b0:1be:d703:bc47 with SMTP id adf61e73a8af0-1c0cc8f66eamr5563951637.49.1720172569643;
        Fri, 05 Jul 2024 02:42:49 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9cd133sm2958138a91.38.2024.07.05.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:42:49 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] perf trace: Augment enum arguments with BTF
Date: Fri,  5 Jul 2024 17:42:52 +0800
Message-ID: <20240705094300.585156-1-howardchu95@gmail.com>
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

