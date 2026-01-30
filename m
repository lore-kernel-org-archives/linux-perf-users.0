Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8238A297
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769816151; cv=none; b=OJxs1SYUA5jDorDLWBg0Dce3oGpwgTPMUd1p+22X/Avq3r1rzAiiP52DLUK9t5IfkMdrHH5FzUvc8hvQsFNiX0+hDChdv7Ez0I8S8Ysc6ebv+OT+SiNW4LOKrfNZsxZgtl8lTWb3heTHazQpxhtXeo1CVGVHjsa/T1G666Vd+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769816151; c=relaxed/simple;
	bh=4povVCWc/uOwDyXyZgP1NZh7UFpxzBSi+gimE0ulTt4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=dEjWdMkLqtby9QpaI4mnWeh9sVeRGLBUTKTHKK2UfeNXqEnCbspTUsLwDzFDNO0kWUoAR3TYu/ZWmWMzaM8gMfJtjhurJzrptFE+4+K/ze0fND0Uu057CBtuEe1CgQgcv8OhEXwsfs/m3bav2DNF56q92az257xFFzHpkoT3bnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIghKRFA; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIghKRFA"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11b94abc09dso3965352c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 15:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769816149; x=1770420949; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SOExR1o1xpQiK2TtbFX75aFUmhaOzHbXYkENmPUuitI=;
        b=eIghKRFATLka+hWMNBEONQgG/urNxprCCSVTQYWhRtEl7LrE92EDSDt2DLO+hkO9mA
         uBh3dDxqNERX/ADXwbXvGkFNjPFf1Oka2u8yH90MBipIUgnuV5ydJa/40rG1jO6OkXCF
         0Spx7XhVgyXhZBADf0e4yQjrEDkYSZpz2FjXm+xANOi8Rxkqr8K5Yu8FbK5JLqyZJOZM
         l1n8P378lmr+Xv/rJNrYPQXv/0zGFmwCY/nKey7tGCfrlmWjuPcfMJIxCIMHk7P7Vu7L
         SQXECVLlFyizsK1cIVuhdgTIuArKgdU9N/ElqZWLEFPC/Jcg1x/TtQRB/gMeD9vZOzzm
         cmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769816149; x=1770420949;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOExR1o1xpQiK2TtbFX75aFUmhaOzHbXYkENmPUuitI=;
        b=MPJsXmn2utoxcs6DZGrvaok/xkAgc/jcysOJEYddze2YzZ1T7S5TZr8lSYBA3psLcu
         4lHF6UZf8DAkuxRV5SdaMgsBqecxGAqtE+in0iZUdwNsIFCwDrFmK+KEsaL7a7or7X0Q
         Ov1zzJrKBmJFs7qe6e6+qdM9gGpbu3jGojUc9XIrfRYlNC3bUAXQnHuBnjHURiP2X0ix
         b7d5Or1mjUwihhu3BI092uPcAp3mzBsAjSNAXbTujGaQYApQB5xD2JE/R4PPiXkKGptt
         kkj70FEr0O5t+zuLt6qoKvcjgteSAQ3R5yhBHGC8bTWIja2q65qW74qfwnxTbPdXXglY
         j72Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPIFXFkGtADYsN8wtauiouf8fDOVbjiW5/b55aigtmpvAYMDarva+YkG3lMmoH8UcMoUBk+Tt6TBDWx4gSTRiU@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAO7RDnDV30v29A7Ifd6Zoh6PEOHXH1i2a5AB9AvHS59tmOoa
	4yDEfRrVlBi6JOwsZz1+FRZ3eHMP6cYkzgsj3jPM+ARCAqpmZ4YrXcvdoNYUDaDVGO+Bnvl2uVd
	XqFXJ0bc2cQ==
X-Received: from dll4.prod.google.com ([2002:a05:7022:204:b0:123:350a:ef0b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:49b:b0:119:e56c:18ab
 with SMTP id a92af1059eb24-125c0fafff6mr2496553c88.19.1769816149534; Fri, 30
 Jan 2026 15:35:49 -0800 (PST)
Date: Fri, 30 Jan 2026 15:35:39 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130233539.648186-1-irogers@google.com>
Subject: [PATCH v1] perf build: Remove NO_LIBCAP that controls nothing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using libcap was removed in commit e25ebda78e23 ("perf cap: Tidy up
and improve capability testing"), however, some build documentation
and a use of the NO_LIBCAP=1 were lingering. Remove these left over
bits.

Fixes: e25ebda78e23 ("perf cap: Tidy up and improve capability testing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 --
 tools/perf/tests/make    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b6edc8100c8e..2a7e5814b159 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -86,8 +86,6 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBBPF if you do not want BPF support
 #
-# Define NO_LIBCAP if you do not want process capabilities considered by perf
-#
 # Define NO_SDT if you do not want to define SDT event in perf tools,
 # note that it doesn't disable SDT scanning support.
 #
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 767ad9e147a8..0b16c9c81c7f 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -121,7 +121,7 @@ make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
 make_minimal        += NO_LIBBPF=1
 make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
-make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
+make_minimal        += NO_CAPSTONE=1
 
 # binutils 2_42 and newer have bfd_thread_init()
 new_libbfd := $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep bfd_thread_init)
-- 
2.53.0.rc1.225.gd81095ad13-goog

