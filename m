Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A356B67
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Apr 2024 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629951; cv=none; b=n27M5TVFVqx+XHP0OG6Z+5lrW9hBtrR4hbooD/zfvbc47ZfiOgzEK1LAYzlHulQ+RoxSc4W7Y4jStlXMV7D7JFJy6y7BrzJCwC4OhCUPgdyahZPslcvRsUYhCxsF6D9LuBlTyZCioMvp1W35ArfBPGgwfA51yXTxaxv/6q7L8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629951; c=relaxed/simple;
	bh=xHsqseGo45EFWIp81P0tGMdoFgzohP0SXk8wpRgIZ/M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=D/5B7EhNGzN+GHblQCfzqJ/H3Q+2paXuSrWTtLsAkHcdHcBccVYdbug3YlJnRESBK3LkZI3bRIQ51NeoInXm51ghVztMIBYlK9wfjz/Z8O0g074fHN/3Ph11xbT/ec3Q8LytXbrnitiBjYNrBmhqUIMDku5l3qRD/nGRCbfjY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRIQdS6g; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRIQdS6g"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so8681859276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Apr 2024 19:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712629949; x=1713234749; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BAUdVwmPAN+ChmE3q8Tcu1VmgKAoqUPA+AHxJ0JyqY=;
        b=KRIQdS6gSqM7Cz4ZpXf/TfjU83+ld8PARjdjgsTjZB5jsDSlyJQH1FNp6vtjdUev/V
         Ha3ouiLTbpzSfQtYQSU+HjLfut72Myxq7xmC7f7awy0FKWZN8SyVH2dXwiAimE1IVrqV
         KYphCN5vLXaSOuZ2GJs78uKk+QVwz4sBlp+A1nx9ioR8t1Eg5yFUco/cXa1jB3NHsVdq
         DRdGJMdozmX18lywuA/2Esh7RnGdVXt4mqjPOqGggEQ1T0vh8rL0FOIzTl+PvHU/P7Q8
         VYq6Ox0UYyWoC5MN/JKwopRDYGr0SdGU2LqdKscCXo2PQbSF/cCHaXLuRz+p0vHm7BvD
         yYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712629949; x=1713234749;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BAUdVwmPAN+ChmE3q8Tcu1VmgKAoqUPA+AHxJ0JyqY=;
        b=dqbyionZGVm91QFUWXCHkHZxc4gOiirNN1e8OGmi82jVffrgCuEMREM70g6YQB1iWX
         gcOddpXYrgy+Ao7KSnsmfBK0HpXS4oEUAPj0aKV7pS6LiOUeUEHYEttEwJOUjYeuOQyC
         uFr0tIN6jZOFAHfHGZTvLocT9lKCjNlcn+ze8vkqhrpHHb5FMYwK5ACu+fppK4w+i0eM
         mUo5ZOhFZDcO3g543urZodbmcL1lNs1SZ2b1y2z2ugP0MgZcw5p+8N/mRsrT1H/wCeUs
         snWZFhCSADZzl/jxnHyhvSyJUSXbX34ScW9ZVdlcYN+yyJhKdIp/7ert3VPs+/v6RKHY
         6E5w==
X-Forwarded-Encrypted: i=1; AJvYcCWFkiCfszU/+lIsEdOkHyTUiH/VKNaplMqFUSt3+m0qrqIEwb+aj1wptMNOPXEUoE1zaA9ZPFEGWV4rNQH3Yf8Q0bLFewa+lF0TD0UljgWJ2Q==
X-Gm-Message-State: AOJu0YzwPVaeU/Y2VMTsCUqteM0OB5ta2W+hpQvImwCOYV3Zj+QIZAFl
	sfl+uXC6N0dSp1N7JgceWPOvPiDc6HPxhXL5BuvoTIQ6T7RLabZRHO2PynZ/PWBIKxN2d8knvxK
	i52bGnA==
X-Google-Smtp-Source: AGHT+IGF6ZTjnu8dVcNXGrughSGYScPK3AYo0PJxMnN9RAliJjpZ62UnoVFK8B/Xe/xfHylwSeuiBANHAUhu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5520:7788:6b7d:7115])
 (user=irogers job=sendgmr) by 2002:a05:6902:70d:b0:dc6:dfd9:d431 with SMTP id
 k13-20020a056902070d00b00dc6dfd9d431mr3087229ybt.1.1712629949240; Mon, 08 Apr
 2024 19:32:29 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:32:16 -0700
In-Reply-To: <20240409023216.2342032-1-irogers@google.com>
Message-Id: <20240409023216.2342032-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409023216.2342032-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 4/4] perf trace beauty: Add shellcheck to scripts
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

Add shell check to scripts generating perf trace lookup tables. Fix
quoting issue in arch_errno_names.sh.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/trace/beauty/Build               | 14 ++++++++++++++
 tools/perf/trace/beauty/arch_errno_names.sh |  8 +++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index d8ce1b698983..cb3c1399ff40 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -20,3 +20,17 @@ perf-y += statx.o
 perf-y += sync_file_range.o
 perf-y += timespec.o
 perf-y += tracepoints/
+
+ifdef SHELLCHECK
+  SHELL_TESTS := $(wildcard trace/beauty/*.sh)
+  TEST_LOGS := $(SHELL_TESTS:trace/beauty/%=%.shellcheck_log)
+else
+  SHELL_TESTS :=
+  TEST_LOGS :=
+endif
+
+$(OUTPUT)%.shellcheck_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(TEST_LOGS)
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 7df4bf5b55a3..30d3889b2957 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -60,10 +60,12 @@ create_arch_errno_table_func()
 	printf 'arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch)\n'
 	printf '{\n'
 	for arch in $archlist; do
-		printf '\tif (!strcmp(arch, "%s"))\n' $(arch_string "$arch")
-		printf '\t\treturn errno_to_name__%s;\n' $(arch_string "$arch")
+		arch_str=$(arch_string "$arch")
+		printf '\tif (!strcmp(arch, "%s"))\n' "$arch_str"
+		printf '\t\treturn errno_to_name__%s;\n' "$arch_str"
 	done
-	printf '\treturn errno_to_name__%s;\n' $(arch_string "$default")
+	arch_str=$(arch_string "$default")
+	printf '\treturn errno_to_name__%s;\n' "$arch_str"
 	printf '}\n'
 }
 
-- 
2.44.0.478.gd926399ef9-goog

