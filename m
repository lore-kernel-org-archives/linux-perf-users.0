Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F6D1AD9D9;
	Thu,  4 Jul 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097031; cv=none; b=iYKT4Xqb8/cQ+nCDz3lno6sIDdJ6VxDEnDrqBnhFu9+6lx7wzdgZbYCb42euaL61sk3IW32z01bf6gdvv/ii1VQyT75LTzar2FPG+K7kN8S8d++3srf4H9Jdp2WCipUduAeZcrUNrb3pxvGwdVp1PgXNaNMDxuU6qwtcVGiaYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097031; c=relaxed/simple;
	bh=IGHqMQw+uzCtKVQmAQI/XdXJSDTq+gahgv7VGy9jwso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hxcGCnDzD9kYR1AjmCLb2pl63EMPCfy6YNz02TgbFy8akXD+LUAMmhgWo/IWauitRC0zF5PplX0CX5MmSde1Lam0wnbuH+sRhTKjcTwCwCCRuIG1UUHj870JM0WirtBf4hyMEEnN7p4yFJvPY0kWIpwOdD5FXIk3VZMJIBLLk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqLkEZ1V; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqLkEZ1V"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb05ac6b77so3315805ad.0;
        Thu, 04 Jul 2024 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720097029; x=1720701829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5jGG8+lM19+qEK5b+CxKOZBSC1j3+/7BVHpIAm6pWA=;
        b=VqLkEZ1V952UDKQoXwo+FXIEVuNGBVJQW8EkZXLsLcYwcrZxtKE77Q0NKdLQ+WBKKi
         3tL/WZ3+v8fDKGw82fXSCaFVMNYWwe3ZwzGiUgE+oOwDWQzZ4YJB5y+iSAIFubEFtPKg
         dTD+k4NOnxBNfcDI+Pqu0huqUlMqiBezRE70dgM0eYA5wRInf0nrN/b9o5/VHMt/D4TT
         TiXH+SiMUQUM0T0fwsI0DR4fqpV6Cq6C51TXd4ZpEWb9NeklfxmphBgHRWuPrs5CaqGj
         G5rnVrfvVAO4GQG3clYXYXxPzc9MH7JsGvLDBgoNhuUvJhGIx899Hv+KRqypA0CD2DWG
         2e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097029; x=1720701829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5jGG8+lM19+qEK5b+CxKOZBSC1j3+/7BVHpIAm6pWA=;
        b=r+V/2+qRntcPt7nFoj0f3ccoeCR2JFVt+KNXxRfjeriYAbruXTbs3bjcFrP/EEP+m2
         UNDej7F5baBxDfo6zyr1ykfSUjrPR8lnNIt1rxTYQNaOKbLITTnTF56rG91prAAoifuB
         T9EX4tK9or1gHI4WqT8FcX51KE25pWJQVof9uAgEQ0YXb7UwciM/3+m09+F/c8/4Cprp
         qczaopK5rmtSMuBDSuGaorg3RhtN406lQS+nNIF9ec4ss/C3vg8CPXze3r39zzgWCKIs
         RxP1BY7wXCnhD0OL8hj6HVBoMnt4YDRzv2V0J85URj4bVfgKvKZTzX3v9zE6vp3Iq+6z
         eHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmCdS6Zh39lm0dImBhXgEzKajRmffyk6QDzItnDiEGioJWi+VwRkUPbfwQkSXNxHh8M9V6IURK9FtcdS+OK0f6adYZv+DjClE3DNpeOPbLMxu93MRjH4Z6i+voRBM6sFyI8lt++ZoGrp+W+tvJrw==
X-Gm-Message-State: AOJu0YxVaD/P5eUSBEn5HxTrRCsW4cg9mckYOkycpIEx3ghks7xEYKQd
	PTywwCQIQ17ZB7ROT75ADCYCg/TdRq/Z7aJmfJXkv6EKEda/md4H
X-Google-Smtp-Source: AGHT+IFMcIGKwbpFRQIRMjI9fZ5gUF4T4QFHUrbsqZlpyLBPPq/ocABuuTh8eUSsNtDqgKbtYwNwAg==
X-Received: by 2002:a17:902:e744:b0:1f9:e3e8:456b with SMTP id d9443c01a7336-1fb33e12804mr12485955ad.4.1720097029032;
        Thu, 04 Jul 2024 05:43:49 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598d35sm121578245ad.285.2024.07.04.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:43:48 -0700 (PDT)
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
Date: Thu,  4 Jul 2024 20:43:46 +0800
Message-ID: <20240704124354.904540-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
 tools/perf/tests/workloads/landlock.c    |  38 ++++
 tools/perf/trace/beauty/beauty.h         |   1 +
 tools/perf/util/syscalltbl.c             |   7 +
 tools/perf/util/syscalltbl.h             |   1 +
 9 files changed, 317 insertions(+), 24 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
 create mode 100644 tools/perf/tests/workloads/landlock.c

-- 
2.45.2

