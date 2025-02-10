Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F143AA1
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212502; cv=none; b=ng8EilFpKH8IcAc5KFxAnDKOMKhnkLNt9CAKNndjbGw8HaXK6Oi/9O/hrZGaRLM67GU7qttl/n+4qcnwPnssQj+KYfb7HQzv9GqwCDZHKJETHFb3sZiBPGu7O7pTTndiXsUwlL9yRwN+9etSktB+ob2hRaiEh4Afm6mSOxNZvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212502; c=relaxed/simple;
	bh=Fet6okgf36tAqXpewfQLTQxQKGOhhrsK1Q0AOZ9/Pjs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PfIYLd9dNP7oVjPDv4av182/3bcnvRaAdLcWSnZpd58mDJ8slQRhZ27p5obL3PfRLjSUgcivjEXv3QmuTVUZ2aTH57+JjpEnL01quF6yc4UVBD3Wi5rWeWm2vi3t1YAoJyGzHGP+eq1sJ4Xidi7RX2mWx0VzrDcJEVgLMnwUur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wdvvakOT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wdvvakOT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f7f1e1194so46626805ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739212501; x=1739817301; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RhlEJGyqamWG33JWVRBIx1wW5JbkDOwIRtN2Z4M+TTw=;
        b=wdvvakOT5i4wkWWew3IxRKeLgj5OCrPzweUevk8Iq3hGLguyraFOVVBHGkq1VZ4rxx
         xsNUzog/f+xrfJAVSm04dRMGghOwEYCnOXK37PtvD7+C/uEd8iZLCoFQ98ZPns0s+p14
         napg0JFTAN2KpQVdZDMIIczO8J8JCkBzHyOigUQp5Ur0lWjNBdruSVzCvYFGDHo3ok2G
         ZM7X4QqrBB1Yt8PMmkL49JVY5WA4jpABlcJxi3gIFEco7VjqK83RSMe1Q2eNKBCr/oHt
         2oXw8/tzg5tzQ0HU34XdbN9PB+YkHGWXEzbMfjvqOy7tpm6rIqPGtsOE072YFdwnX3XQ
         ORQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212501; x=1739817301;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhlEJGyqamWG33JWVRBIx1wW5JbkDOwIRtN2Z4M+TTw=;
        b=FQHZX3HELhVJKdvm8Tabrt5CnsRzgB1NxxlKF38RTm3gRw9LGoB3F/ZwSR2U9mBpGI
         PEKqLUowXXDRFWjRSrSXcfoAI6UT4gZoBYf3E8Voho5R9F9DRPSFRitaX4VX1j9kFuxV
         uTZOte8CvG6nocHBYeV9jzwYI+atbnnrMub6F6MLNkOCa69wpUPZ0hM6lzbndbisVLAs
         U61QiHc+Nl9fitGdvTlosaH+Rq0Ymz5+MYLyRs50dVK2/nOGv/vNxVGDzZr9zIhG8LJc
         Gv2qCVQEY2qdQ6szTnG+RoWYNDoh9GiE6k8P3MJJ3NTqAsh/eLuxQ7l/mM3h+FlIKoto
         N8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR8TY2+/rjQjh/fwHZNnH6IL5MiP5JcZODW/0+/af6fr2uKTDYNpkLT46SR+pwzisOcVFht8Zs+VexO9fvAljl@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdrEUeH1Dki+8rnarcTG5XWup/Z1xhvyfTmxZB3KWehNci0ZW
	1nUShkoflml7uxZ87SMn0tPGv5nFFdTnhlB4C5qpgxQJH8oL4hv5uj4rKyILco4=
X-Gm-Gg: ASbGncvfg1iJfdwdxe1GfMhNaRtLrd/ziIVpMAbA/p4p8iWU74Mp4IZM9gZMlQRX3+n
	y8ReyJPn8N1rOSYxpyqm4QM88/zAR03as9s3lYMUBQ27Ec3IA8xtugi9AGry5po9bSlJFpjtPFn
	mYwL/JMV+cLheT7BAsPRn7j2zVgNuEEPj7prOipLwcUYnMAj19j0Mj7NtNka18mMIT4IDNAAyES
	izvLPwlBb2VXhnoPRUEi0G+xingVwyKIiV4aKA/PR6iQrvPm0W5F5tW+CsRweZKNVqBEOP0y5wc
	7Xr0nCxfqPND0V1lU1SUYcH0B1VYQUg=
X-Google-Smtp-Source: AGHT+IGcshiyYeyUumTAxl/O5zl1bGxAtjZfhKbFcjYP8aCSk0OlMXDbqBJ+Y4zN2NdWMp46o5bnIA==
X-Received: by 2002:a17:902:dac7:b0:21f:b404:5110 with SMTP id d9443c01a7336-21fb40451d5mr20090975ad.34.1739212500849;
        Mon, 10 Feb 2025 10:35:00 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e6b5sm82534815ad.46.2025.02.10.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:35:00 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/2] tools: Unify top-level quiet infrastructure
Date: Mon, 10 Feb 2025 10:34:41 -0800
Message-Id: <20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMFGqmcC/23M0QoCIRCF4VdZ5jrDNZTsqveIJUSndqC0HJNi8
 d2zve7yP3C+BRgzIcNhWCBjJaYUe6jNAH528YqCQm9QUmmp5E48X4TlXFK6sbDOoLPBaDda6I9
 Hxgu9V+009Z6JS8qfFa/jb/3v1FFIEZT2e6sNauuOmWpiin7r0x2m1toXG5jhDKkAAAA=
X-Change-ID: 20250203-quiet_tools-9a6ea9d65a19
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Quentin Monnet <qmo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=Fet6okgf36tAqXpewfQLTQxQKGOhhrsK1Q0AOZ9/Pjs=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/oqt1NPEzb84l/zyGE146GrwY9bFd7J1Dz3FjzpdTzr9
 dSmlEsXOkpZGMS4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZjITgaG/9HW/y407VmbHOFu
 tFAyYTOXt7S4nZ4Nq+R7RasCqdXyMowMS3fb1G+rypyu+E5kzUbPPp1a85cX3rrwNm+x/jG595A
 wPwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The quiet infrastructure was moved out of Makefile.build to accomidate
the new syscall table generation scripts in perf. Syscall table
generation wanted to also be able to be quiet, so instead of again
copying the code to set the quiet variables, the code was moved into
Makefile.perf to be used globally. This was not the right solution. It
should have been moved even further upwards in the call chain.
Makefile.include is imported in many files so this seems like a proper
place to put it.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Fix spacing around Q= (Andrii)
- Link to v1: https://lore.kernel.org/r/20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com

---
Charlie Jenkins (2):
      tools: Unify top-level quiet infrastructure
      tools: Remove redundant quiet setup

 tools/arch/arm64/tools/Makefile           |  6 -----
 tools/bpf/Makefile                        |  6 -----
 tools/bpf/bpftool/Documentation/Makefile  |  6 -----
 tools/bpf/bpftool/Makefile                |  6 -----
 tools/bpf/resolve_btfids/Makefile         |  2 --
 tools/bpf/runqslower/Makefile             |  5 +---
 tools/build/Makefile                      |  8 +-----
 tools/lib/bpf/Makefile                    | 13 ----------
 tools/lib/perf/Makefile                   | 13 ----------
 tools/lib/thermal/Makefile                | 13 ----------
 tools/objtool/Makefile                    |  6 -----
 tools/perf/Makefile.perf                  | 41 -------------------------------
 tools/scripts/Makefile.include            | 31 ++++++++++++++++++++++-
 tools/testing/selftests/bpf/Makefile.docs |  6 -----
 tools/testing/selftests/hid/Makefile      |  2 --
 tools/thermal/lib/Makefile                | 13 ----------
 tools/tracing/latency/Makefile            |  6 -----
 tools/tracing/rtla/Makefile               |  6 -----
 tools/verification/rv/Makefile            |  6 -----
 19 files changed, 32 insertions(+), 163 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250203-quiet_tools-9a6ea9d65a19
-- 
- Charlie

