Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4903B6364
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533200; cv=none; b=kikxXMT5GEvNwpZo5Fb3nqIGzTQsMWBxMl2flKoN48XoGzq7au72or9v7qyOilYXVjDO7lW8PHci8Iapzbs5v64btwzjvDUiGGY/FnrAh5SqEFdk+bkonecKaG8HAfPaCRWQ4MojdZGOvzIs75oRa21xn4zcOwt0YXxbFbTduiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533200; c=relaxed/simple;
	bh=i3yMFamnMcSND3qD1hXqHP9PPBJPlUElTiSuWnu9XyM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xb81kte1bSpa/kAupP83bqPZ4dVWGD5QG9LPMjI6XttYucyofiIsf9GDQ1H+O635FtFBp6dM5KXZc6OzCnMhYW0CxES1D4dzDsXtjNo6rQvPiNyY3VZ4OSpihyXkpDmsqxIVdTcdDl0Atz/0kQZloUPqeJ2bxQpkou4hbfDkL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sio7bEw4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sio7bEw4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88d7a75507so56165a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783533199; x=1784137999; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88+KphSI/HZMfYWVVRdeAK34sjJgWCEj3JmhdvhwEUs=;
        b=Sio7bEw4+fsvCUkJiyvIW254mWN88VLHrsH9WVnsR4YawJZ9jLryg2BwwS/fpToLg2
         Lbz0+HAsZ12teRJPW2T7O4tJulJbLeMBdLLZwJEwpmPvWIICQ3Xxlbd2C429ct1KdA7x
         VWc2a7yK02LBqoUkN5SnL2vPKO8eI2oPwz4g035/vRfN07qipDU1XFry40Dirlkxi0fO
         J+GMxXUfnsLwqEShoiZI/t5DcrrgK54GdI3DfAAEj3PDzPXft5uxTYAZaL1HvDSgE7yr
         yASIN1Mmlx+Blnq+SgbBQWjhF3Da+oxiIIMsbABQqu9wNlg1/qoSDJ25ZXPIk/fwgQIw
         iN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783533199; x=1784137999;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=88+KphSI/HZMfYWVVRdeAK34sjJgWCEj3JmhdvhwEUs=;
        b=kEbteB64fHQU2dgJe4ktQKAKVzjzQYaqwcYNT1rdqZASFDMSJIRmYuq/Qi3aI/AQyl
         rilwxgR0NmTowxSeZxrYxejuew8jv14Vh/LmO+azWEYnV/Q8TTJKkoI9l1cC4cjm+YK7
         xDB+WEtrF9DZ6MAw//Er4hO1K6YAPgh1EZ+HZpFkRyX8N+8E6b/+c8qU62lGSABazwo3
         LoL4L2qV7JB1NYA4xx2JY8MSJbl2rIrAkJcxkXi/xunFIYG18hHqQtJvT2ZcQ2CQOVWW
         KLUV4Nv9DZLJI6307LwKhZbZ5dm0e7bWb/sB6nK8junDEoEL5jC40+2kIQK52xgySCBr
         tSsw==
X-Forwarded-Encrypted: i=1; AHgh+Rpu8LvDQtqIC6muUXMmNsc1YkrDiPn01maniDQqWMhnPp1mPH2tAYoNatEIvg/LuB2WIIuknZmNG2vz/D+Ws/5q@vger.kernel.org
X-Gm-Message-State: AOJu0YygV+ACyar54MvwRcmSTYwcSkIk3uvFCeqKG0yzeDZOXqBo0PjE
	WOLW0o1hPT1TZF7ujmyPX8um/DQTBqg/tZnKtjdWkC2qRj5mBjPDbAvTnTA1GyE4ZVUOW/Wu6cb
	sSxukWEmmpg==
X-Received: from dled4-n1.prod.google.com ([2002:a05:701b:42c4:10b0:138:90f:8181])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a95:b0:3bf:6c08:fb9d
 with SMTP id adf61e73a8af0-3c0bcead1b1mr4571803637.49.1783533198529; Wed, 08
 Jul 2026 10:53:18 -0700 (PDT)
Date: Wed,  8 Jul 2026 10:53:11 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708175311.858850-1-irogers@google.com>
Subject: [PATCH v1] perf tests: Restore -p flag to lock contention test
From: Ian Rogers <irogers@google.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit ae42a2a2a3ae ("perf tests: Speed up lock contention analysis shell test")
in linux-next heavily optimized the test runtimes by switching the workload from
the default of 10 process groups down to 1 (`perf bench sched messaging -g 1`).

However, this change inadvertently dropped the original `-p` flag, causing the
benchmark to default to `socketpair()` instead of `pipe()`. While `socketpair()`
still generates some lock events on x86, it fails to trigger enough samples on
architectures like s390, causing the test suite to fail due to lack of captured
data.

Restore the omitted `-p` pipe flag. The test retains the massive speedups
achieved through the `-g 1` scaling, while producing a massive density of lock
events across all architectures to fully satisfy the BPF trace filtering logic.

Fixes: ae42a2a2a3ae ("perf tests: Speed up lock contention analysis shell test")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/tests/shell/lock_contention.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index ba598370be73..5df9a0cd48a3 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -11,7 +11,8 @@ errout=$(mktemp /tmp/__perf_test.errout.XXXXX)
 
 # Workload to generate lock contention.
 # Using 1 group (-g 1) keeps runtime low while generating sufficient lock events.
-msg_workload="perf bench sched messaging -g 1"
+# We include -p (pipes) because socketpairs don't generate enough lock events on s390.
+msg_workload="perf bench sched messaging -g 1 -p"
 
 cleanup() {
 	rm -f ${perfdata}
-- 
2.55.0.795.g602f6c329a-goog

