Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232103;
	b=fP2uoI7g+Tcyk2IW72Hsu4GrmynbBo/5V4ibBPAXdYZwM3GIidvmWf4m0jpHHQ0sUQOV
	 MOtGOBTnt2nkV9wmhCwJ1UbffALAz3O9unGvrPvOHnDuu8RqRfPJdqQn/DHqEEGa8sNWT
	 6cxYWNW8MVf4323tmej78f3Rs4zs24IEDYzGK57V7agloiqOSstRreTfRGdyMHTmSXTZ2
	 yV/7CYcVIK8hvhYErcEG7e6eWfiVItTZLMXBh8Pewez+7y0ZXRLdfBy6GPAuhNktR9roj
	 JYp2s2uV9NzNhSmKCbAceC/PJNSK9/UWEYftxzxle1IcCkbyIrLDuCg3m8kjOR7sdYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=2xFblzM1dSzR/Kh3l6RiwUKC3aSm0Lww3LXjNnffbow=;
	b=PT+8xTYC3H4VavYV2V38e3MV+Q5VyjjDPpGmTvdjZKYX3cMXTkdhIy/JGc5poMO09uPr
	 gzqq2Mj6iGsSU7YNuRXztGKIdITEZVIv9ZlXBzDWEF0qcykOPrc/F/WpyImGGxsyUBmyW
	 jUmfj8TuMbOloiEQtqZZcNyoTp/JQQOOWE6V6xoZ3ky/tqGBs7E8l04pJuj6FOIyJLfah
	 Bt2GBlZ3JYOQoT4eVNaOs6vt2ePAy70L8EOyU9kQZ4u1cPk/94TbWEyNLLMIc0cPMxPrP
	 3YR24hkFFpuKhnD+9AK/W3zNFO9uTj00iAzrcuDomXdnpFF9i6Cr9E14Z5Jxzq6RA4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LuwJxS0W;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B608606A323
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 13:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B608606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LuwJxS0W
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso6374685e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 05:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794232102; x=1794836902; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2xFblzM1dSzR/Kh3l6RiwUKC3aSm0Lww3LXjNnffbow=;
        b=LuwJxS0WW1EpJ45qqhmjeMoKS+KeGs6OBOKD25AdVoZ7hmTx9JNOSapXm/pA+abz55
         B3zD3MyB+swCViEi9CuJQoNniMI6hYQsrsd2ize6DNka5kZDiet4m9hbXxPYaZ6Jm0xA
         WAvVMuET5F9Fs589JOnIykSJ8v7EcRa84JW5ZQx0J2Utz7saAQnTZ2JK2zu8v0aFPfpD
         FY9jP1vwsdPUYE/Fq91Nf4BwHJoCKZsaSjt3LGDHIrwHlDeYxaCW+onzkczZZuvBLnWg
         m9w1kmiCCVYuxMB6CLBCAXpQj2M7PYShNcEUFLwM3hK2yxnRAxzJ+6QXyO4rlt+jw9cw
         cSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232102; x=1794836902;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2xFblzM1dSzR/Kh3l6RiwUKC3aSm0Lww3LXjNnffbow=;
        b=y4o/h/D1PhnBVJ5Oifahe/LdjCj814nzKG/UnANHy0l3IElaxXpKrN0WklppeJQgux
         PWJxfI1w9STqPR8lnNbu/9Ks8nQgwmyY4LZVR5a8QanvjMmSK6Ejq7JtPE3AaNX/Exd1
         Q1+6VSeltsJ/JqFl5Yttgw5Yb81/cQxA2o0wNNqzSGts/UNtXrF7b8E7n3/NDrCTYpVN
         gf+i6DGs5udmJ9dvfmLgXgzzcpWeujp1wHuqGrwry7c5cwB2NxMOL/z6uEr1o3VL/sEk
         eK9De85bPl1/BqOOPEAucPe5M6pvGdSzTNdfItoBLDscd3SKs40TTc+Xw+RhAq3bn6yW
         BEKg==
X-Forwarded-Encrypted: i=1; AL+hErF9cg9GZtzC8+r/01Ff3AR89bgo4vvHJrb4EPl09ALGQBpUBCdfiVFjL2qbKDr0sx7ta2xYWbefs9IcSxXYLyjZ@vger.kernel.org
X-Gm-Message-State: APuU4Z92vdGz6UAP0D2LdAFrGiuI1KNRQn12YqYXJxsfHVBbrgB41/lv
	+zayYvKKe386JFSaLBP4qV3MsQ6pJwMEb84SNw9l0EbUFgSzOyRn7yYONKp3z39CSrY=
X-Gm-Gg: AYBFou1ez5Op4iFUjd75AEpAZDkLkOVPJxBNGSeSsQ1VcoENN9HSHfFLIh1pWniuGx/
	NUFAOlMPK1Vo1iNySmpTFJ2wurUD8O2dgX4OHASt4PQEoITFlESfYjmh1d3DpYcdCzadEGOUPIZ
	tUkEI/yWaQp7GXz5D0GclEqddk3EkqVq28uoQOKv74cX5haLJ1PFLBc42eryOe2IBJTYrGdf9r5
	qpwIbLzOzEGy/WMR1VOSMLDQdVNl+NpgjQZfksBD755lTmHHvvQcyqCONZwmF6nKDhbFh0BBNIT
	SW587SQev+cvOzCXpS1Tw8PRPNU8dybC9id/JXTh+VeJfgfztfUYUe+dHme1yBJ5KaDplJVvH7m
	bYmQmeo/ptuJOB5QHXRk32lTFnVyZ7hKgKflBWprR2C9VPdkck4Gkw6FGX8WIYWUIJ26FMTh3d3
	1t8DNBEZrJwf92cqJXYQbhYBTcoBkHyjETmPz7q21fEIF19/NIPvGQcqpvKHavXm/tjI68WdUYj
	nBK/H+d5iSz470oy2J5KddGHmYB/quTZCYQulUOnm+a0RpYyRhKXgq4LRpaT9bKJD5ae/s/mAS2
	4xHJmnVGTcWcOVjQzqht0//AN9M6KdWAs+4PRKjp0yG2uC40jXBHRA==
X-Received: by 2002:a05:600c:8b72:b0:4a1:efba:511 with SMTP id 5b1f17b1804b1-4b963c953eamr76345915e9.35.1794232101787;
        Mon, 09 Nov 2026 05:48:21 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7bb101537sm98522045e9.0.2026.11.09.05.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:48:21 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v4 0/4] perf tools: LLVM dwarf and flaky test fixes
Date: Mon, 09 Nov 2026 13:48:07 +0000
Message-Id: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABfP8WoC/3XNQQ6CMBAF0KuQrq1pB1rAlfcwLgpMoUSBtEg0h
 LvbYkwwhuXPzH9/Jg6tQUdO0UwsTsaZvvMhOUSkbFRXIzWVzwQYSM5ZQlt1R0cHtJqO6EaqzdN
 nnQJIIWJecUV8d7C4Hnz1cv1k9yhaLMeAhY/GuLG3r3V44uHvuyF2NiZOGWUFpHmBKLKYnW+mU
 7Y/9rYmYWSCLSP3GPBMrnIOUoLOAP6YeMvke0zsGcwqpqRAyTP1wyzL8gZmUBJTWwEAAA==
X-Change-ID: 20261104-james-perf-test-fixes-f72265531d1a
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Running the tests on an LLVM build results in some dwarf issues that
need fixing. And there is an easy fix for some flakiness caused when
tests are run in parallel.

Assisted by Claude Opus 5.5

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v4:
- Remove unused add_probe_vfs_getname() argument to fix shellcheck.
- Link to v3: https://patch.msgid.link/20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org

Changes in v3:
- Rebase to resolve new conflicts
- Link to v2: https://patch.msgid.link/20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org

Changes in v2:
- Break perf probe line (Namhyung)
- Use a software event instead of cycles for VM compatibility (Namhyung)
- Link to v1: https://patch.msgid.link/20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org

---
James Clark (4):
      perf libdw: Find the CU by iterating all CUs when aranges are missing
      perf dwarf-aux: Support DW_OP_addrx locations for global variables
      perf test probe_vfs_getname: Fix missing debuginfo detection
      perf test: Don't starve per-process tests with system-wide events

 tools/perf/tests/shell/lib/probe_vfs_getname.sh |  9 ++--
 tools/perf/tests/shell/record.sh                |  6 +--
 tools/perf/tests/shell/record_lbr.sh            |  2 +-
 tools/perf/tests/shell/record_sideband.sh       |  4 +-
 tools/perf/util/annotate-data.c                 | 27 +---------
 tools/perf/util/dwarf-aux.c                     | 70 ++++++++++++++++++++++---
 tools/perf/util/dwarf-aux.h                     |  3 ++
 tools/perf/util/libdw.c                         | 19 +++----
 8 files changed, 90 insertions(+), 50 deletions(-)
---
base-commit: 13a8d580433a3b72b10be34f0e26787fe5659d3c
change-id: 20261104-james-perf-test-fixes-f72265531d1a

Best regards,
--  
James Clark <james.clark@linaro.org>

