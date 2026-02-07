Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4B2FDC5D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770452685; cv=none; b=WQ3xW8E+YfxQWVkvateRqwPr3m83uW8UyeyYUhIa3F9jOJ1x1OBuJG29ATMiElXcswKs1M2MPv2GjDOtCjkdWblT2RJd0GEPZWWSbR1RMNbt5jA1CIL9zaa/coVjSiaRV236AVuLaCPIsSFBTKSl9hmBf/DR1udTD01YZH+OVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770452685; c=relaxed/simple;
	bh=rdi2MXI8heJyjekQyn2R5rAIkpJM4Kx8NfeSx8dnGh0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fCh1DRV067ngXaw4qWrpdpPs0ULAwyv/ho5dSXeUblK8Xb9O85cznAYCKnvClr9STzJ6awelHLNP7jmUR7zXT42B8LRvcOOm7qB63P/sBFAE/9l0wSMnmsQxgRzPu8JNIt1v7R3Tc6KoCIUdoQauNChPQYXI5FLKyyNqttkcYLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eaGB0yEt; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eaGB0yEt"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so91275c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 00:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770452684; x=1771057484; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n+jHbdTp2KMGHVgTilE1vSNYmbwVB4D9lxQT9xEHluw=;
        b=eaGB0yEtiDdDL5CRjlEHkOb9ZkRmEvosmDL8+tkxLXc8O9Z/U2CoIUYcfoFZSnqwCE
         iJM6C5pLfbryUzdfVF6DiZG48xbX4PHkR8qdq6DZ6VAd8rJEpwkh22lp2Zr1nHC3Ne60
         tpeG9E8I6Bpcxn8+h742DBsvY5b9UJnO0y15B/MFoKmoaBs70efJx/gcUpwDHY6wSdtO
         JCk3Rdk6S9/j1mnLTv9MtX8wCI4jkeBN96LMssmWmogcNxRFut99vVLXkDm97bJVOTVZ
         W64VZhpCuNBunY5f63z8ln+1BZvn9uIMK+FJ1upnxobSs5ZcaWeYesRWwvKzklnUgS5D
         rdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770452684; x=1771057484;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+jHbdTp2KMGHVgTilE1vSNYmbwVB4D9lxQT9xEHluw=;
        b=vI4g2a5++MpjvBLdBe7ncMCwb1BlV7P+h5dpxKprDZdq0q1QF+rZrFxJ3iP1cExj3x
         E9o1eMSfDO/PcLjvRQ4P53pfezsO1pKo3o/uHxHpiUo8SN+Vn/UwuU8XuNkaBBNOrHHa
         IY3WDuh+RdMK3LeQnTWumNc9GvN/Qoc2F320JCT3lgXToNhty+gvnmpnTcPQ/klUJ+1v
         hDQVdOfgnyw/RoMcLRusMybgXvPl2nISQY/xpHs9Edum0SZaHp98l4ZkQRYbIl29uqxZ
         JMmqWZ/mN/KsObmUZkAJsYeneT9ihaxAc/fuddNsdW1hyOtAB0dy2kY2brwnX+HIZnlP
         ty3g==
X-Forwarded-Encrypted: i=1; AJvYcCV38a82kQHmH8TE6S+gJD5lOPNSVwNXbaqvNbwykgXxyYyquQCGblQT7xUPaptl7N1akhbzySU70JfwNYRtO3X4@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlDI7XcnQj/GgLrmOkQ3zicQrhVetQCs3PEhbJAhXp6uT0Mvs
	xo9Jxa8kc3sbruc1vfpkaH6tihkdG6CVQw9VgioU6j1/0cQYpjnN7ZdqbaZgcQbEHQYIXEL57PV
	vQdewlsnOJQ==
X-Received: from dlbeg13.prod.google.com ([2002:a05:7022:f8d:b0:124:a511:1ddf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:45a7:b0:11b:d561:bc10
 with SMTP id a92af1059eb24-12704020b8cmr3424579c88.41.1770452684014; Sat, 07
 Feb 2026 00:24:44 -0800 (PST)
Date: Sat,  7 Feb 2026 00:24:23 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260207082428.1742209-1-irogers@google.com>
Subject: [PATCH v1 0/5] perf tool: Minor code clean ups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Eric Biggers <ebiggers@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove some unused functions, files, etc. Reduce scope of variables
and functions. Constify arrays in perf.c.

Ian Rogers (5):
  perf symbol: Reduce scope of elf__needs_adjust_symbols
  perf dump-insn: Remove dump-insn.c
  perf tool: Constify the command and option arrays
  perf bpf_map: Remove unused code
  perf record: Remove unused cpu-set-sched.h

 tools/perf/builtin-record.c     |  1 -
 tools/perf/builtin-trace.c      |  1 -
 tools/perf/perf.c               | 12 +++---
 tools/perf/util/Build           |  2 -
 tools/perf/util/bpf_map.c       | 70 ---------------------------------
 tools/perf/util/bpf_map.h       | 23 -----------
 tools/perf/util/cpu-set-sched.h | 50 -----------------------
 tools/perf/util/dump-insn.c     | 23 -----------
 tools/perf/util/symbol-elf.c    |  8 ++--
 tools/perf/util/symbol.h        |  1 -
 10 files changed, 10 insertions(+), 181 deletions(-)
 delete mode 100644 tools/perf/util/bpf_map.c
 delete mode 100644 tools/perf/util/bpf_map.h
 delete mode 100644 tools/perf/util/cpu-set-sched.h
 delete mode 100644 tools/perf/util/dump-insn.c

-- 
2.53.0.239.g8d8fc8a987-goog

