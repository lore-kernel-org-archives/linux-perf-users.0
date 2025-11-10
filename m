Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C434D389
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738369; cv=none; b=SxS1wlwBTp85TLdL2CP88dgKjnv2Y/YfdCFFSBfMbKlIbbQGVtwZyhqpgo8hmAofn2CoOcEmZUcDkCzMZvlqsgAB94FmgxlVIQKwUmyuvPT24QysHy0ROr3rbpnQSK/tr64fF/wBQ/ku+qLhCWNrqJIZy9IvcBsIKTcs2EhyqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738369; c=relaxed/simple;
	bh=RrP5cmOeQR9Y8f3CwrvpfIOMIUrubjWp3XxjQEmTq4Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=l54p1UykH/4h+MH3bcAAVCOPJBnSBw9kyvy/9e7gHy1PahPQgwXBKSPLlZDD9com7JOFg+ulwW8EdzyUUKY+3DdvV8frZkqM7aInLlZxWT7d+A0syEx7n2FV0QHZL587QtMrijfM4IdclAOyXgEesmpknZ/waUTFdbsCj4nCnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OzpGzCf+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzpGzCf+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297fbfb4e53so15550185ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Nov 2025 17:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762738367; x=1763343167; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2tczW/jlPJtWBafr4BCvC87kJC9YZnw6YI3s5HGD1V0=;
        b=OzpGzCf+zjCUGcBoaie6fJ3YS3JqY7dk0SMgbX9qzdZTyo/vR8jSBBBPItWNe2YtUl
         nw1/lPp1/684P88IC4gZmjquwZGIQUKbzH/bH5/dYSKjUc9c8dWY1dGHYOMG+AzUd29S
         Np0qJzcaFA+MG02/OG5J9t0eIgEiIBLAXeqrTda4bOOyveJLAAl5nVUrTuHNp9ao7xr+
         6bTbVfje16g5PeloJvYoVJuGz893/Ma639expIxwp7l2vIO5/qavOYK2RWeHBdbNcYyC
         v+NJlzycdk5FQnZKmnX5nt4EWalxvM2lVjRTredFhkWX4Lz+q0d4yQgiNkMp0BtynUFs
         PlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762738367; x=1763343167;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tczW/jlPJtWBafr4BCvC87kJC9YZnw6YI3s5HGD1V0=;
        b=PHaymkcmb157gV83FBtqwx9ZtAmf1Z7Dj26f45hXvjzbEN4Tn9ALtoDEQrW7NQg1UF
         sDxToKqD2VCgajy7y5ly3OeQzM9InSYr5lwWQ4b2yLjTUo6pwLmfD/hW5NoeSKzuaLS4
         wF71a5ZQOP0VnM30/03NGZjsKZn5h9KXMG6PcTzRF18Odnw3VmhQrXJQOiADSlLrWLem
         EmnyvCNq7o6PakK80hyWac/VJEawFb1dnH2pvyvk8hxXBGXAZlrxUC+vlT4r9UEJnOkL
         A4OjNjDDH3nSm0ckp/8JZTwZHXvjyBjp3F8/bJGaC7WOqYNtXlgIcwJnegyRCQLGJol1
         B8ug==
X-Forwarded-Encrypted: i=1; AJvYcCVNRx3tnfhP+zgm2az71qGlpYZRedgk2qh1FK1xpxLspl0h9ptyIb0hC7C4s1ecKydXC+QnxXg9Z065AV6sIOOu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18lcUHJ08+2G6b63OzhCHcNxhJfmRQSu8QXDThtgA6wnnmbYV
	28vPJkHfq87pgKXtgtdfmLk6dc5KbLg+2o/vDTxz99Ii/fQCsbfHYqGrS5yMFr3nZkGDtw+WtUl
	YIxNUJcCHHg==
X-Google-Smtp-Source: AGHT+IEJZFhdZ78j4YCJKrIb16jeaTnnO4cKpy7FS06LlgJ1nhegCHFM2808wGFe++O0VOMLbtoy0MZiyWE8
X-Received: from plrd2.prod.google.com ([2002:a17:902:aa82:b0:295:50ce:4dd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c5:b0:295:f508:9d32
 with SMTP id d9443c01a7336-297e56d8f5fmr82645775ad.37.1762738366732; Sun, 09
 Nov 2025 17:32:46 -0800 (PST)
Date: Sun,  9 Nov 2025 17:31:47 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110013152.3099080-1-irogers@google.com>
Subject: [PATCH v1 0/5] Remove NO_AUXTRACE build option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Tomas Glozar <tglozar@redhat.com>, 
	Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>, Blake Jones <blakejones@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Collin Funk <collin.funk1@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>, 
	Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
	Markus Elfring <Markus.Elfring@web.de>, Colin Ian King <colin.i.king@gmail.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch the __get_cpuid feature for intel-pt to use the provided cpuid
function in perf, this removes the need for NO_AUXTRACE when the
feature detection fails. Remove the now unnecessary feature
detection. Remove NO_AUXTRACE as it just builds a more broken version
of perf and isn't guarding dependencies on any libraries, etc. Clean
up headers files for auxtrace.h.

This was prompted by needing to make a v2 patch set of:
https://lore.kernel.org/lkml/20251107170712.2302714-1-irogers@google.com/
due to a broken NO_AUXTRACE configuration.

Ian Rogers (5):
  perf intel-pt: Use the perf provided "cpuid.h"
  perf build: Don't add NO_AUXTRACE if missing feature-get_cpuid
  tool build: Remove __get_cpuid feature test
  perf build: Remove NO_AUXTRACE build option
  perf auxtrace: Remove errno.h from auxtrace.h and fix transitive
    dependencies

 tools/build/Makefile.feature                  |   2 -
 tools/build/feature/Makefile                  |   4 -
 tools/build/feature/test-all.c                |   5 -
 tools/build/feature/test-get_cpuid.c          |   8 -
 tools/perf/Documentation/perf-check.txt       |   1 -
 tools/perf/Makefile.config                    |  13 --
 tools/perf/Makefile.perf                      |   2 -
 tools/perf/arch/arm/annotate/instructions.c   |   1 +
 tools/perf/arch/arm/util/Build                |   2 +-
 tools/perf/arch/arm/util/auxtrace.c           |   1 +
 tools/perf/arch/arm/util/pmu.c                |   2 -
 tools/perf/arch/arm64/annotate/instructions.c |   1 +
 tools/perf/arch/arm64/util/Build              |  19 +-
 tools/perf/arch/arm64/util/arm-spe.c          |   1 +
 tools/perf/arch/arm64/util/hisi-ptt.c         |   1 +
 tools/perf/arch/powerpc/util/Build            |   2 +-
 tools/perf/arch/powerpc/util/auxtrace.c       |   2 +-
 tools/perf/arch/s390/util/Build               |   2 +-
 tools/perf/arch/s390/util/auxtrace.c          |   1 +
 tools/perf/arch/x86/tests/Build               |   4 +-
 tools/perf/arch/x86/tests/arch-tests.c        |   4 -
 tools/perf/arch/x86/tests/intel-pt-test.c     |   6 +-
 tools/perf/arch/x86/tests/topdown.c           |   1 +
 tools/perf/arch/x86/util/Build                |   6 +-
 tools/perf/arch/x86/util/intel-pt.c           |   4 +-
 tools/perf/arch/x86/util/pmu.c                |   2 -
 tools/perf/arch/x86/util/topdown.c            |   1 +
 tools/perf/bench/evlist-open-close.c          |   1 +
 tools/perf/bench/futex.c                      |   1 +
 tools/perf/bench/pmu-scan.c                   |   1 +
 tools/perf/bench/synthesize.c                 |   1 +
 tools/perf/builtin-check.c                    |   1 -
 tools/perf/builtin-inject.c                   |  15 --
 tools/perf/builtin-mem.c                      |   1 +
 tools/perf/builtin-record.c                   |  36 ---
 tools/perf/builtin-script.c                   |  12 -
 tools/perf/tests/hwmon_pmu.c                  |   1 +
 tools/perf/tests/make                         |   4 +-
 tools/perf/tests/parse-metric.c               |   1 +
 tools/perf/tests/pfm.c                        |   1 +
 tools/perf/ui/hist.c                          |   1 +
 tools/perf/util/Build                         |  24 +-
 tools/perf/util/annotate-data.c               |   2 +-
 tools/perf/util/arm-spe-decoder/Build         |   2 +-
 tools/perf/util/auxtrace.h                    | 221 +-----------------
 tools/perf/util/bpf-filter.h                  |   2 +
 tools/perf/util/bpf-trace-summary.c           |   1 +
 tools/perf/util/bpf_counter_cgroup.c          |   1 +
 tools/perf/util/bpf_ftrace.c                  |   3 +-
 tools/perf/util/bpf_map.c                     |   1 +
 tools/perf/util/cgroup.c                      |   1 +
 tools/perf/util/cs-etm-decoder/Build          |   2 +-
 tools/perf/util/drm_pmu.c                     |   1 +
 tools/perf/util/evswitch.c                    |   1 +
 tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
 tools/perf/util/intel-pt-decoder/Build        |   8 +-
 tools/perf/util/intel-tpebs.c                 |   1 +
 tools/perf/util/kvm-stat.h                    |   1 +
 tools/perf/util/mmap.c                        |   1 +
 tools/perf/util/pfm.c                         |   1 +
 tools/perf/util/powerpc-vpadtl.c              |   1 +
 tools/perf/util/stat-shadow.c                 |   1 +
 tools/perf/util/synthetic-events.h            |  15 --
 63 files changed, 77 insertions(+), 391 deletions(-)
 delete mode 100644 tools/build/feature/test-get_cpuid.c

-- 
2.51.2.1041.gc1ab5b90ca-goog

