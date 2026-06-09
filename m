Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0E3FF892
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029276; cv=none; b=VhWUPHGyc1bZkpEca/QpeUJ6PK9jsluHoKuxGPou1HnVW+3GgbHOyblpYXappif8ohDaOSK5Z0QkXvnKz3pSuMwZ5Mk4pW1v7RHexF4/ZKtzF00cgglSBT/Ue1Alu5Ht5Tz+/P4bJz0KbtCGCnIvEKnbM9B9pTXJZdKeGh+/tuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029276; c=relaxed/simple;
	bh=ijfXJCyLJzXirjWJc5msyptD7T30quGrk7BJZPFsKRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uthxy0A+L+s3oEmnnof793PgZzTx07cznh2aKn/O2FfcFijWVkSiqSDOPaETvdC8OxVKJu8bJtw0DskvXgY8Nwm6vfNdM1MWzNfkAiuAPnZzzzI5EsvqCuor1DJPU7m13ZpWnyoVIqeKpfnFIz63zrrE2nBJU9MvsAOquWcMhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqA1nz2k; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqA1nz2k"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fc90b1so5909038eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029273; x=1781634073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pI4Sj5ylWb+/s3gLU2p9k0E6nXQu+1DAkq2Jz2ttj48=;
        b=nqA1nz2ka3s7PBH0WGquasqlgrHccmzPApoV29/QC64dt7SPpOVmr61G4v7cL/86c3
         bnfRU92kGg38FvkAr6VCo3nAAznC12fzAooIUIgfooJiFV7Rcgxp7Q4UHiAWFN2NFIt5
         q/Pk1LyBSzXomJ1/o7lK3+uMD1JJVAVq/12NHEP25J3RJCXQCpNWs79oTLzO5ZavmvjL
         6hmAGdJWrDwbmhwy1HdHwzuXu0FrZCaQEe3J2IybkbbgigiP6akUhex5EPIwgcdLql9g
         wOFL9EPGixWkjqU8Q5qt5UGky3A7LD79lNDWdPxLsL1z/ONyZBhhRWcQM/o4CE7rEY3D
         IJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029273; x=1781634073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pI4Sj5ylWb+/s3gLU2p9k0E6nXQu+1DAkq2Jz2ttj48=;
        b=a0kyuKmHxXWj5UuYh5A5vAamOKYGHSTtsqA6RFB/fo3qb+GkMMONa3nmVtGqPtRtlh
         3HSuSpTLikb2fggRq1duQGYZZgiSE0hNEQxB2tWUCpY+CLigAkhMfXxkqk5qP2bNFcTs
         plAlB9L4n5PD7dzitzlbKSiNxXRCt0il6Jp0LSpdd7EordLhT2/nVI8jbdWS9v5cb1BO
         YHXjrEbF6bgQhD4rIn8p4MBlYXESTDiooOmDeiv5Uzp892CZrL4A7W3zlL3ij5/EeRo3
         TcMs7Gkh20LdWiN1A5trzOwMb2k1eIss526znTz2gb8EK+doSKyH5x/9cEcXpikotb9J
         CaRA==
X-Forwarded-Encrypted: i=1; AFNElJ+riPhELGyiZysfclapc92NjTqF+33zQenXZjqBKg52LsRqAha5lPAjqZEETrkWdPbapH09dQjlo6A5a7rO7eMh@vger.kernel.org
X-Gm-Message-State: AOJu0YxVce2Svno2CTN+rmQFEHw3cgFvYc8qbZ0ts19mlW+tkQ82++fR
	NSi/JUYkYNOGVA1eFFo1rrYMBzbrnKzNmkwK8AzY52ymH+acWfY3X9B//M6Khb7l0y3grok6374
	FmUJlMwx6vA==
X-Received: from dycpq23.prod.google.com ([2002:a05:7301:fd17:b0:2d9:8c75:b19e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2209:b0:304:c651:bdea
 with SMTP id 5a478bee46e88-3077b22a913mr13706536eec.21.1781029273034; Tue, 09
 Jun 2026 11:21:13 -0700 (PDT)
Date: Tue,  9 Jun 2026 11:21:01 -0700
In-Reply-To: <20260609070732.545416-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609182108.975586-1-irogers@google.com>
Subject: [PATCH v3 0/7] perf annotate: Add elfutils libasm disassembler and
 BPF JIT disassembly support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, blakejones@google.com, bpf@vger.kernel.org, 
	costa.shul@redhat.com, dsterba@suse.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark@klomp.org, mingo@redhat.com, 
	mjeanson@efficios.com, nathan@kernel.org, peterz@infradead.org, 
	rong.bao@csmantle.top, serhei@serhei.io, terrelln@fb.com, tglozar@redhat.com, 
	tianyou.li@intel.com, yuzhuo@google.com, zecheng@google.com
Content-Type: text/plain; charset="UTF-8"

This patch series introduces support for using the elfutils `libasm` library
as a disassembler backend in `perf annotate`. This provides a lightweight,
library-based alternative to LLVM and Capstone for in-process disassembly.

Additionally, this series implements disassembly support for in-memory BPF
JITted programs by writing the JITted instruction buffer to a temporary ELF
file on the fly and disassembling it using the ELF-based backends (`objdump`
and `libasm`).

Changes in v3:
- Address review comments on v2 series.
- Explicitly link against `-lasm -ldw -lelf` in the feature check.
- Document that older versions of elfutils that require explicitly linking
  `-lebl` statically are unsupported.
- Fix instruction-by-instruction disassembly loop logic in `libasm.c` by
  returning 1 from output callback and checking for `ret != 1`.
- Pass the correct ELF machine (`e_machine`) to `jit_write_elf` instead of
  hardcoding host architecture.
- Update `annotate.sh` tests to use `perf test -w` workload instead of `free`
  to avoid CI environment issues.
- Expand test coverage to test all disassemblers (including libasm) on BPF
  JIT symbols when run with root privileges.


Ian Rogers (7):
  tools build: Add feature check for elfutils libasm
  perf build: Add build support and capability for elfutils libasm
  perf annotate: Implement elfutils libasm disassembler backend
  perf annotate: Add --disassembler command-line option
  perf test: Enhance annotate test coverage and isolate config
  perf annotate: Support BPF JIT disassembly via genelf
  perf test: Add BPF JIT annotation test coverage for all disassemblers

 tools/build/Makefile.feature       |   2 +
 tools/build/feature/Makefile       |   9 ++
 tools/build/feature/test-libasm.c  |  20 ++++
 tools/perf/Makefile.config         |  22 ++++
 tools/perf/builtin-annotate.c      |  10 ++
 tools/perf/builtin-check.c         |   1 +
 tools/perf/tests/genelf.c          |   2 +-
 tools/perf/tests/shell/annotate.sh | 153 ++++++++++++++++++++++++
 tools/perf/util/Build              |   1 +
 tools/perf/util/annotate.c         |   8 +-
 tools/perf/util/annotate.h         |   3 +
 tools/perf/util/disasm.c           | 114 +++++++++++++++++-
 tools/perf/util/disasm.h           |   1 +
 tools/perf/util/genelf.c           |  16 +--
 tools/perf/util/genelf.h           |   2 +-
 tools/perf/util/jitdump.c          |   3 +-
 tools/perf/util/libasm.c           | 184 +++++++++++++++++++++++++++++
 tools/perf/util/libasm.h           |  27 +++++
 18 files changed, 559 insertions(+), 19 deletions(-)
 create mode 100644 tools/build/feature/test-libasm.c
 create mode 100644 tools/perf/util/libasm.c
 create mode 100644 tools/perf/util/libasm.h

-- 
2.54.0.1099.g489fc7bff1-goog

