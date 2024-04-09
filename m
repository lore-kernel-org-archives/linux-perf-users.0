Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657BE54BED
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Apr 2024 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629946; cv=none; b=LQHv3QHJHlz3pEmUPLNgfR0YusuU72HaDTi9iALFcN85F30XcqnKrMqTw5b6ijoBXF41ZzmM6dAaZyRsfxgCt5D6A3DFfoIWGlHEBM8Mxhbz5NCPdzdkdPFjOSHLy31I+LdTaoJJ/6LyTTyIJhOlBp2S7C6ewwwYnF7ZKNoObmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629946; c=relaxed/simple;
	bh=g5FISTb0SUz4N5bO73qDIESdt6Zvkkf5ticX23tz8Bc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=u0UgGpaBnTyPnSnmyno3c/35AvBsvpuM/1+jzFKQwFNbl5h9FYIdLWDvYk2plYqezpJNpD593zLCFF5WZo9SUCOg9dmp+C+JYGJoU+Yol7JaL5yV1n7TQsTnDtsmqs7rOXaYpy4N4eB8wqInsyKWyqmuLmvRqt61/DWvdAqkJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtHKB4cu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtHKB4cu"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6144244c60cso75194227b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Apr 2024 19:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712629944; x=1713234744; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUCLlDEOF+eDEIPKja8ueM/Rrqkxl5/XYQOKdkpQkzo=;
        b=rtHKB4cu7defFE4KGVpxM94EV2s7SxXiEi5eWRjTaKIJXmgdqcZI8c2QdnkZY586En
         62t4x2Y6ISckkcB1H77Jx/IcN6HQUMxNijUJWysA/fLdebJ/kTJxbYi/5fkLroiJ/UAt
         hqKjiCzJoC6kZ+QyrEAN28Ulv1RKlFUSZe4Xiq/OcvDOi9YHM5Y5EwdySOzQ1H6UfX7i
         nV7PDdH3Pn0lZ1i+19V4G60gbvQfgZZzpQOYuPv70MLKaYbT/gyjDoQ4gFtxf4tSLfUo
         RCdXcoIALCPq17t459Q41kCkS2MA2Z6e9QI2yB+ptre0ZhO1UvxCymnG+QUmQ0qYLu9J
         ZD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712629944; x=1713234744;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUCLlDEOF+eDEIPKja8ueM/Rrqkxl5/XYQOKdkpQkzo=;
        b=fmYVUMhXMCX6KAbN184NZs+xdEE/ya3P1C1sFqwLwf+8QSjCn3b4pwIjVDZXSPz+zF
         xKkW3kl/GGz+R0k1weiCsNv63jPl4xcDnT1rGDaO60FrSxyLsDwub8qFQojhyhu9Ejho
         fYOKInvJVlzxnxD9dcTovgVvredGkNnVXnEdkZKDv7rCQlTrUy/7J8ynLjtHdwNjrJFO
         0zH93MW7tqfPtfE/tJSwGqD8Pg9kmpu3JZv+l0H4sXrM/eaz6DSsCZBwGesMTrGmYhxQ
         tl0x/I29Vesh86kdxWiirwrUkpV4ojXh6OGfrVmK5r83g0j4vdeGn9ZaQIdpchzT+Ub6
         92KA==
X-Forwarded-Encrypted: i=1; AJvYcCWS5Hvl69+Tjkaj/spF8YzEemyvPpSYD4P1pjt4zoMaAewPdkQMUM2b10ZBZh9WI+bDASdhJbblIRhIKpFiT+7q38fwNMztYYk+SItmVZ3LFg==
X-Gm-Message-State: AOJu0Yz9Rc8oYx6BWf06SOSRr9btxCqCOkAQWS3BpoR6uGUl/8UQd/Ad
	Sv43+HisOYcoxteOAK+jcCHJr1Fb9X49vUiO42zzBczUTBodk24iX+Kx8AmqWK1q3SxXMixIUpm
	hZHp2Qw==
X-Google-Smtp-Source: AGHT+IGvQTYCP5+xDoLlENaNXCS0algoYiy4sK2dX6WUL4feZ6IfsnScgDm7nhrevc/FNjddvi6LrIbefbqr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5520:7788:6b7d:7115])
 (user=irogers job=sendgmr) by 2002:a05:6902:727:b0:dcc:8927:7496 with SMTP id
 l7-20020a056902072700b00dcc89277496mr873262ybt.5.1712629944477; Mon, 08 Apr
 2024 19:32:24 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:32:14 -0700
In-Reply-To: <20240409023216.2342032-1-irogers@google.com>
Message-Id: <20240409023216.2342032-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409023216.2342032-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 2/4] perf arch x86: Add shellcheck to build
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add shellcheck for:
tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
Address a minor quoting issue.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/Build                     | 14 ++++++++++++++
 tools/perf/arch/x86/tests/Build               | 14 ++++++++++++++
 tools/perf/arch/x86/tests/gen-insn-x86-dat.sh |  2 +-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index a7dd46a5b678..ed37013b4289 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -1,2 +1,16 @@
 perf-y += util/
 perf-y += tests/
+
+ifdef SHELLCHECK
+  SHELL_TESTS := entry/syscalls/syscalltbl.sh
+  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+else
+  SHELL_TESTS :=
+  TEST_LOGS :=
+endif
+
+$(OUTPUT)%.shellcheck_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(TEST_LOGS)
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index b87f46e5feea..c1e3b7d39554 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -10,3 +10,17 @@ perf-$(CONFIG_AUXTRACE) += insn-x86.o
 endif
 perf-$(CONFIG_X86_64) += bp-modify.o
 perf-y += amd-ibs-via-core-pmu.o
+
+ifdef SHELLCHECK
+  SHELL_TESTS := gen-insn-x86-dat.sh
+  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+else
+  SHELL_TESTS :=
+  TEST_LOGS :=
+endif
+
+$(OUTPUT)%.shellcheck_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(TEST_LOGS)
diff --git a/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh b/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
index 0d0a003a9c5e..89c46532cd5c 100755
--- a/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
+++ b/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
@@ -11,7 +11,7 @@ if [ "$(uname -m)" != "x86_64" ]; then
 	exit 1
 fi
 
-cd $(dirname $0)
+cd "$(dirname $0)"
 
 trap 'echo "Might need a more recent version of binutils"' EXIT
 
-- 
2.44.0.478.gd926399ef9-goog

