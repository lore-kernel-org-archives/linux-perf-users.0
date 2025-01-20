Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1AF12CDA5
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394345; cv=none; b=HzbAIIDTeUnSF1MZgdV401rnLSyvXfjHAXmFM0ySeXVJmDfHcjCUuAsqsYV+Ehik2ZxbKL/FsDlJz06VTt9TR0ipvyhEf3zbNRSb8pJ33pbk9/KldFy2xq/713tkrBczgLyNnZClzAfNFz0YvHW4sfYtk++wjZguitXClG2Ed9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394345; c=relaxed/simple;
	bh=XoxEYV+VDCUQVGr/fXdELyMg5VnHtJqPGO/sRS5XXiA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=h2iAPRN/JhacbJh0rlMM9vawkSouf+pN7pcu5pOzoV+aQPV52J5yccLmFIWJ3zYSfqv93y85Q+7CADd75Imm/erfn/8ftYF3VmPCQZiI5GRGhLWlWl5Nshrfh7rn1Jjn1/dMctucJZhqutynarhBM1lFwafHamgz6Mn+gsklL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvzMPhr/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvzMPhr/"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e54cb50c3baso406012276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737394343; x=1737999143; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tkLT2dzsqbCe/JB8KOi2Tl3KKIFyxEh2X9A7KSrmrTY=;
        b=EvzMPhr/4fhd/ktYoOrl+d+diiXS7OXa6KVNaTvrWY4HAsFSXXP93g/VT0CW4YbN2k
         1hTRmQfJvPXFM2b+UboI6f49jxNmS1T1UfcL/K0yI2Z1Oiv4GovzzaIGwTrD14YRknLM
         zZ5Z0MRX1yEgKT+cyP9sMCJEY1sBhNTxAN+DdZGE5au7iLKFirY2IppzMSGX0moXxxoN
         KrXAfa1UowjqQ+qp8KCflhitUM9V4PfjMwWlJVguLIIynvnbCRCA7PiQOohwDM0leXAd
         ZQNQU44ypyiHULAjIq/jD8i3QzkK344jcA8BGuwwlJDpKs9Rggb3+dPOKqkRc1AEwD+L
         9aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394343; x=1737999143;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkLT2dzsqbCe/JB8KOi2Tl3KKIFyxEh2X9A7KSrmrTY=;
        b=I5v5PdULEfjY2n62taWyo1gjgaKWAA0HkTrYe2BxywL1+gbf17j4LVPj+pwwXP275l
         3SOCVeYIgM02AFslLraWOPpoGSK4cy3Qu8UUBHQgHc7esJG/ggKT+YYGd4tI2e0/OgkK
         X5ZUPHM9RmfyobzzwDm+2cRB8x4B9rCHoOWRObEe/6p4txjt1on3UYF4XLwUDmn1alEA
         bQNbPnH+aJMAzZnpS+xZBEp4ipNUxi8A49ZBlD/KHH2FY/lh9Q59q/Rfxo5gLqszj5Q3
         bCTUxUAFgB0wgeXzlELYAzvEoXCO/95xrpaG1rSymB7aVdvgU11q5MrPsrCcegR+HXAY
         +D6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZA/KawnxCXBG+pXB2Co8A5NjCvNgPWsOL2QoWYNTyW868w9jAaZN1HE7onVQxalXSnqSYDiCJZd2HQAXcVPM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxizg3DQy5AUhrGLB5QWvLf4ni0gtse/ZTdBXfiN5onOYoOWkB9
	y1VTmKnehvlUtQSTaity6+clmwWEXp6dVK0CUHdvkbWxpVeQBRGgb0EQRZvPpQ5LaU16yVkobx6
	QQ9pEbg==
X-Google-Smtp-Source: AGHT+IGyt38/W4/BJDU9pXXSoXiIU1Y17e/2AaBaByDFhkf5NXiPNpYen3rqRmeKMY//v6VlvxwMbsh0wDML
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:fc95:312:c7ce:d18e])
 (user=irogers job=sendgmr) by 2002:a25:d642:0:b0:e38:225a:c3be with SMTP id
 3f1490d57ef6-e578a3e1d28mr61426276.5.1737394342834; Mon, 20 Jan 2025 09:32:22
 -0800 (PST)
Date: Mon, 20 Jan 2025 09:32:03 -0800
Message-Id: <20250120173208.344231-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v1 0/5] Support dynamic opening of capstone and libLLVM
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Linking against libcapstone and libLLVM can be a significant increase
in dependencies and size of memory footprint. For something like `perf
record` the disassembler and addr2line functionality won't be
used. Support dynamically loading these libraries using dlopen and
then calling the appropriate functions found using dlsym.

The patch series:
1) moves the capstone and LLVM code to their own C files,
2) simplifies a little the capstone code,
3) adds perf_ variants of the functions that will either directly call
   the function or use dlsym to discover it.

The addr2line LLVM functionality is written in C++. To avoid linking
against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
the C++ code with the libLLVM dependency will be built into a
libperf-llvm.so and that dlsym-ed and called against.

Ian Rogers (5):
  perf capstone: Move capstone functionality into its own file
  perf llvm: Move llvm functionality into its own file
  perf capstone: Remove open_capstone_handle
  perf capstone: Support for dlopen-ing libcapstone.so
  perf llvm: Support for dlopen-ing libLLVM.so

 tools/perf/Makefile.config         |  13 +
 tools/perf/Makefile.perf           |  23 +-
 tools/perf/builtin-script.c        |   2 -
 tools/perf/tests/make              |   2 +
 tools/perf/util/Build              |   4 +-
 tools/perf/util/capstone.c         | 723 +++++++++++++++++++++++++++++
 tools/perf/util/capstone.h         |  24 +
 tools/perf/util/disasm.c           | 612 +-----------------------
 tools/perf/util/disasm.h           |   2 +
 tools/perf/util/llvm-c-helpers.cpp | 113 ++++-
 tools/perf/util/llvm.c             | 537 +++++++++++++++++++++
 tools/perf/util/llvm.h             |  24 +
 tools/perf/util/print_insn.c       | 117 +----
 tools/perf/util/srcline.c          |  65 +--
 tools/perf/util/srcline.h          |   6 +
 15 files changed, 1481 insertions(+), 786 deletions(-)
 create mode 100644 tools/perf/util/capstone.c
 create mode 100644 tools/perf/util/capstone.h
 create mode 100644 tools/perf/util/llvm.c
 create mode 100644 tools/perf/util/llvm.h

-- 
2.48.0.rc2.279.g1de40edade-goog

