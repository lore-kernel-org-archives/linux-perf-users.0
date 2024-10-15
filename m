Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393CA156243
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950533; cv=none; b=vEcB0iNBAgE3YlVOxg746AB2d2Wv9Eo+o5GtlmZ5/5DpD31W3SsgMLbI3cFEcbxDwKZaSD0/JTXR7S1STcTKwkykJNsDGBPzaAQEet26JYJbBsrXJYvNTqbcPaw/b6mYsxhYlc1B8XZWwClry2aHFIiiijTB76urIkoOEnsBrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950533; c=relaxed/simple;
	bh=5V0HYfJIoCqORROOyQxgxCGkVp4lqZYz2wWzhJxbol0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=smlp69keee/asC/FBRRz4aR6Gp2nSgryuvV5xlHizZ3pI3RvbG1E1mIsp9r8GQEMSOgheqv3CvxlcBEAOZL2b2pTL23OLsB6RsIdK5/UlRcB1M5G0yYt2YVFZ/1rDq5ZX6EdVbIJLpIoUk5i8qHiH6pVjwh2Crmg2sBwMC+CsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gN5a3UnW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gN5a3UnW"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35199eb2bso51395077b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728950530; x=1729555330; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5AyR3CEmAHSsZGpk4O76mSgfPIu474vcsykhPTnG9Y=;
        b=gN5a3UnW8w+Ixs99tGPUM5OINsyPZFF+opkq/iY5JPUFRUhHd1HJ+Twdfuuuc65YgD
         dtpX7KY2FO8EyK+dAgpiqMszKJPfKpQ2h/qQodG3EYD/c9BCk06E7RGlEe80pGlNzdCi
         uC/3DxQoOTb41/W8U/zCjCG2NRDQA0Ic6UTy/v89rTV2QOjKyrb+nS4ezfOoooKA9uzp
         o6qGMwWe4rqOTzS7PLyJZBahBedTd4LOf6e3ElgfGp2PQO5OLUDBDRm6Rbqca9P09dEn
         pMKsI+Z6tXrjzYBN0xGj1keMPy0+wkj2141gjqS45kl2I/OUd8J6zQgLE9g6jrEzU4j8
         al/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950530; x=1729555330;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5AyR3CEmAHSsZGpk4O76mSgfPIu474vcsykhPTnG9Y=;
        b=LGn7RYwSDS1nWo9NwjxOdNLlHapKfmpsNqRcAUUdqO5iJ60bfdPXjiXlvM+uwZlsMS
         uXUVGKa3MteogP9G2UjidW8HuOf/T3qtRKd442cjvVzAxBffoC3UKT0TLTmgBP7Bfcx1
         rJ8GT3dATRcIL/0WFd3B9/3XPuWN6OykYbvRt1McGWl4XelA4cqLur0NKeMk9LNaSRiK
         44Ijgw70BehUtZ/UUwqfwOo4KCosy7EEcnAqQiPvcmddSCKHUJx1elyI5AaC/7wc8zyx
         LLgJ5uBOLcJfRaAPshRPbSQ/6SZr277MqcQ7B50/0igJIeQ6q/VTA95fDsg+6R1XtPru
         LHqw==
X-Forwarded-Encrypted: i=1; AJvYcCXveyfvHaNd+iIXW6o/vxl4QRdEmC+d3iJWiYrR0/NMMsvhhqzs/gUjleh5Sm6t1U794ROX6wBGda7lL7hoLGvl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Bjd68PHg5fVt/QZ2K0ip+YJqEfhPPa9oBlZapAuP97w+qNX4
	0ZVKcQwdM+nzsr344L8o2XV/DUHw5xPdNZEMltmf9TAVuFrNMFJVPBWLlRvG6W2HE6tlh820rmy
	hFoTFgA==
X-Google-Smtp-Source: AGHT+IF6M1b/mOXdPo+NfGA6vsUb9d0doLOHoCglmRsIwn3yki8stDt9Wl700p5+nakgabzGXEiq+4mVsW4L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f1f9:f6b6:68bc:5a14])
 (user=irogers job=sendgmr) by 2002:a05:690c:290b:b0:6e2:b263:103f with SMTP
 id 00721157ae682-6e3471dcd1emr1036107b3.0.1728950530193; Mon, 14 Oct 2024
 17:02:10 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:01:58 -0700
In-Reply-To: <20241015000158.871828-1-irogers@google.com>
Message-Id: <20241015000158.871828-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015000158.871828-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 3/3] perf test: Move attr files into shell directory where
 they are used
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

Now the attr tests are shell tests move the associated python and
configuration files. Update the installation build rules for the new
directories. Recycle the lib install rules for python files allowing
the explicit attr.py install line to be dropped.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/Makefile.perf                                     | 5 ++---
 tools/perf/tests/shell/attr.sh                               | 2 +-
 tools/perf/tests/{ => shell}/attr/README                     | 0
 tools/perf/tests/{ => shell}/attr/base-record                | 0
 tools/perf/tests/{ => shell}/attr/base-record-spe            | 0
 tools/perf/tests/{ => shell}/attr/base-stat                  | 0
 tools/perf/tests/{ => shell}/attr/system-wide-dummy          | 0
 tools/perf/tests/{ => shell}/attr/test-record-C0             | 0
 tools/perf/tests/{ => shell}/attr/test-record-basic          | 0
 tools/perf/tests/{ => shell}/attr/test-record-branch-any     | 0
 .../tests/{ => shell}/attr/test-record-branch-filter-any     | 0
 .../{ => shell}/attr/test-record-branch-filter-any_call      | 0
 .../tests/{ => shell}/attr/test-record-branch-filter-any_ret | 0
 .../perf/tests/{ => shell}/attr/test-record-branch-filter-hv | 0
 .../{ => shell}/attr/test-record-branch-filter-ind_call      | 0
 .../perf/tests/{ => shell}/attr/test-record-branch-filter-k  | 0
 .../perf/tests/{ => shell}/attr/test-record-branch-filter-u  | 0
 tools/perf/tests/{ => shell}/attr/test-record-count          | 0
 tools/perf/tests/{ => shell}/attr/test-record-data           | 0
 tools/perf/tests/{ => shell}/attr/test-record-dummy-C0       | 0
 tools/perf/tests/{ => shell}/attr/test-record-freq           | 0
 tools/perf/tests/{ => shell}/attr/test-record-graph-default  | 0
 .../tests/{ => shell}/attr/test-record-graph-default-aarch64 | 0
 tools/perf/tests/{ => shell}/attr/test-record-graph-dwarf    | 0
 tools/perf/tests/{ => shell}/attr/test-record-graph-fp       | 0
 .../perf/tests/{ => shell}/attr/test-record-graph-fp-aarch64 | 0
 tools/perf/tests/{ => shell}/attr/test-record-group-sampling | 0
 .../perf/tests/{ => shell}/attr/test-record-group-sampling1  | 0
 .../perf/tests/{ => shell}/attr/test-record-group-sampling2  | 0
 tools/perf/tests/{ => shell}/attr/test-record-group1         | 0
 tools/perf/tests/{ => shell}/attr/test-record-group2         | 0
 tools/perf/tests/{ => shell}/attr/test-record-group3         | 0
 tools/perf/tests/{ => shell}/attr/test-record-no-buffering   | 0
 tools/perf/tests/{ => shell}/attr/test-record-no-inherit     | 0
 tools/perf/tests/{ => shell}/attr/test-record-no-samples     | 0
 tools/perf/tests/{ => shell}/attr/test-record-period         | 0
 tools/perf/tests/{ => shell}/attr/test-record-pfm-period     | 0
 tools/perf/tests/{ => shell}/attr/test-record-raw            | 0
 tools/perf/tests/{ => shell}/attr/test-record-spe-period     | 0
 .../perf/tests/{ => shell}/attr/test-record-spe-period-term  | 0
 .../tests/{ => shell}/attr/test-record-spe-physical-address  | 0
 .../{ => shell}/attr/test-record-user-regs-no-sve-aarch64    | 0
 .../{ => shell}/attr/test-record-user-regs-old-sve-aarch64   | 0
 .../tests/{ => shell}/attr/test-record-user-regs-sve-aarch64 | 0
 tools/perf/tests/{ => shell}/attr/test-stat-C0               | 0
 tools/perf/tests/{ => shell}/attr/test-stat-basic            | 0
 tools/perf/tests/{ => shell}/attr/test-stat-default          | 0
 tools/perf/tests/{ => shell}/attr/test-stat-detailed-1       | 0
 tools/perf/tests/{ => shell}/attr/test-stat-detailed-2       | 0
 tools/perf/tests/{ => shell}/attr/test-stat-detailed-3       | 0
 tools/perf/tests/{ => shell}/attr/test-stat-group1           | 0
 tools/perf/tests/{ => shell}/attr/test-stat-no-inherit       | 0
 tools/perf/tests/{ => shell/lib}/attr.py                     | 0
 53 files changed, 3 insertions(+), 4 deletions(-)
 rename tools/perf/tests/{ => shell}/attr/README (100%)
 rename tools/perf/tests/{ => shell}/attr/base-record (100%)
 rename tools/perf/tests/{ => shell}/attr/base-record-spe (100%)
 rename tools/perf/tests/{ => shell}/attr/base-stat (100%)
 rename tools/perf/tests/{ => shell}/attr/system-wide-dummy (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-C0 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-basic (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-any (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_call (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_ret (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-hv (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-ind_call (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-k (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-u (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-count (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-data (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-dummy-C0 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-freq (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-default (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-default-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-dwarf (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group-sampling (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group-sampling1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group-sampling2 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group2 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group3 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-no-buffering (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-no-inherit (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-no-samples (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-period (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-pfm-period (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-raw (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-spe-period (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-spe-period-term (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-spe-physical-address (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-no-sve-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-old-sve-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-sve-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-C0 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-basic (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-default (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-2 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-3 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-group1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-no-inherit (100%)
 rename tools/perf/tests/{ => shell/lib}/attr.py (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9dd2e8d3f3c9..105f734b6820 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1128,12 +1128,11 @@ endif
 install-tests: all install-gtk
 	$(call QUIET_INSTALL, tests) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
-		$(INSTALL) tests/attr.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
 		$(INSTALL) tests/pe-file.exe* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
-		$(INSTALL) tests/attr/* -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/attr'; \
+		$(INSTALL) tests/shell/attr/* -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/attr'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
diff --git a/tools/perf/tests/shell/attr.sh b/tools/perf/tests/shell/attr.sh
index e094f3baffb7..5a4e43b2471d 100755
--- a/tools/perf/tests/shell/attr.sh
+++ b/tools/perf/tests/shell/attr.sh
@@ -17,6 +17,6 @@ trap trap_cleanup EXIT TERM INT
 
 shelldir=$(dirname "$0")
 perf_path=$(which perf)
-python "${shelldir}"/../attr.py -d "${shelldir}"/../attr -v -p "$perf_path"
+python "${shelldir}"/lib/attr.py -d "${shelldir}"/attr -v -p "$perf_path"
 cleanup
 exit $err
diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/shell/attr/README
similarity index 100%
rename from tools/perf/tests/attr/README
rename to tools/perf/tests/shell/attr/README
diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/shell/attr/base-record
similarity index 100%
rename from tools/perf/tests/attr/base-record
rename to tools/perf/tests/shell/attr/base-record
diff --git a/tools/perf/tests/attr/base-record-spe b/tools/perf/tests/shell/attr/base-record-spe
similarity index 100%
rename from tools/perf/tests/attr/base-record-spe
rename to tools/perf/tests/shell/attr/base-record-spe
diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/shell/attr/base-stat
similarity index 100%
rename from tools/perf/tests/attr/base-stat
rename to tools/perf/tests/shell/attr/base-stat
diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/shell/attr/system-wide-dummy
similarity index 100%
rename from tools/perf/tests/attr/system-wide-dummy
rename to tools/perf/tests/shell/attr/system-wide-dummy
diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/shell/attr/test-record-C0
similarity index 100%
rename from tools/perf/tests/attr/test-record-C0
rename to tools/perf/tests/shell/attr/test-record-C0
diff --git a/tools/perf/tests/attr/test-record-basic b/tools/perf/tests/shell/attr/test-record-basic
similarity index 100%
rename from tools/perf/tests/attr/test-record-basic
rename to tools/perf/tests/shell/attr/test-record-basic
diff --git a/tools/perf/tests/attr/test-record-branch-any b/tools/perf/tests/shell/attr/test-record-branch-any
similarity index 100%
rename from tools/perf/tests/attr/test-record-branch-any
rename to tools/perf/tests/shell/attr/test-record-branch-any
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any b/tools/perf/tests/shell/attr/test-record-branch-filter-any
similarity index 100%
rename from tools/perf/tests/attr/test-record-branch-filter-any
rename to tools/perf/tests/shell/attr/test-record-branch-filter-any
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_call b/tools/perf/tests/shell/attr/test-record-branch-filter-any_call
similarity index 100%
rename from tools/perf/tests/attr/test-record-branch-filter-any_call
rename to tools/perf/tests/shell/attr/test-record-branch-filter-any_call
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_ret b/tools/perf/tests/shell/attr/test-record-branch-filter-any_ret
similarity index 100%
rename from tools/perf/tests/attr/test-record-branch-filter-any_ret
rename to tools/perf/tests/shell/attr/test-record-branch-filter-any_ret
diff --git a/tools/perf/tests/attr/test-record-branch-filter-hv b/tools/perf/tests/shell/attr/test-record-branch-filter-hv
similarity index 100%
rename from tools/perf/tests/attr/test-record-branch-filter-hv
rename to tools/perf/tests/shell/attr/test-record-branch-filter-hv
diff --git a/tools/perf/tests/attr/test-record-branch-filter-ind_call b/tools/perf/tests/shell/attr/test-record-branch-filter-ind_call
similarity index 100%
rename from tools/perf/tests/attr/test-record-branch-filter-ind_call
rename to tools/perf/tests/shell/attr/test-record-branch-filter-ind_call
diff --git a/tools/perf/tests/attr/test-record-branch-filter-k b/tools/perf/tests/shell/attr/test-record-branch-filter-k
similarity index 100%
rename from tools/perf/tests/attr/test-record-branch-filter-k
rename to tools/perf/tests/shell/attr/test-record-branch-filter-k
diff --git a/tools/perf/tests/attr/test-record-branch-filter-u b/tools/perf/tests/shell/attr/test-record-branch-filter-u
similarity index 100%
rename from tools/perf/tests/attr/test-record-branch-filter-u
rename to tools/perf/tests/shell/attr/test-record-branch-filter-u
diff --git a/tools/perf/tests/attr/test-record-count b/tools/perf/tests/shell/attr/test-record-count
similarity index 100%
rename from tools/perf/tests/attr/test-record-count
rename to tools/perf/tests/shell/attr/test-record-count
diff --git a/tools/perf/tests/attr/test-record-data b/tools/perf/tests/shell/attr/test-record-data
similarity index 100%
rename from tools/perf/tests/attr/test-record-data
rename to tools/perf/tests/shell/attr/test-record-data
diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/shell/attr/test-record-dummy-C0
similarity index 100%
rename from tools/perf/tests/attr/test-record-dummy-C0
rename to tools/perf/tests/shell/attr/test-record-dummy-C0
diff --git a/tools/perf/tests/attr/test-record-freq b/tools/perf/tests/shell/attr/test-record-freq
similarity index 100%
rename from tools/perf/tests/attr/test-record-freq
rename to tools/perf/tests/shell/attr/test-record-freq
diff --git a/tools/perf/tests/attr/test-record-graph-default b/tools/perf/tests/shell/attr/test-record-graph-default
similarity index 100%
rename from tools/perf/tests/attr/test-record-graph-default
rename to tools/perf/tests/shell/attr/test-record-graph-default
diff --git a/tools/perf/tests/attr/test-record-graph-default-aarch64 b/tools/perf/tests/shell/attr/test-record-graph-default-aarch64
similarity index 100%
rename from tools/perf/tests/attr/test-record-graph-default-aarch64
rename to tools/perf/tests/shell/attr/test-record-graph-default-aarch64
diff --git a/tools/perf/tests/attr/test-record-graph-dwarf b/tools/perf/tests/shell/attr/test-record-graph-dwarf
similarity index 100%
rename from tools/perf/tests/attr/test-record-graph-dwarf
rename to tools/perf/tests/shell/attr/test-record-graph-dwarf
diff --git a/tools/perf/tests/attr/test-record-graph-fp b/tools/perf/tests/shell/attr/test-record-graph-fp
similarity index 100%
rename from tools/perf/tests/attr/test-record-graph-fp
rename to tools/perf/tests/shell/attr/test-record-graph-fp
diff --git a/tools/perf/tests/attr/test-record-graph-fp-aarch64 b/tools/perf/tests/shell/attr/test-record-graph-fp-aarch64
similarity index 100%
rename from tools/perf/tests/attr/test-record-graph-fp-aarch64
rename to tools/perf/tests/shell/attr/test-record-graph-fp-aarch64
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/shell/attr/test-record-group-sampling
similarity index 100%
rename from tools/perf/tests/attr/test-record-group-sampling
rename to tools/perf/tests/shell/attr/test-record-group-sampling
diff --git a/tools/perf/tests/attr/test-record-group-sampling1 b/tools/perf/tests/shell/attr/test-record-group-sampling1
similarity index 100%
rename from tools/perf/tests/attr/test-record-group-sampling1
rename to tools/perf/tests/shell/attr/test-record-group-sampling1
diff --git a/tools/perf/tests/attr/test-record-group-sampling2 b/tools/perf/tests/shell/attr/test-record-group-sampling2
similarity index 100%
rename from tools/perf/tests/attr/test-record-group-sampling2
rename to tools/perf/tests/shell/attr/test-record-group-sampling2
diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/shell/attr/test-record-group1
similarity index 100%
rename from tools/perf/tests/attr/test-record-group1
rename to tools/perf/tests/shell/attr/test-record-group1
diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/shell/attr/test-record-group2
similarity index 100%
rename from tools/perf/tests/attr/test-record-group2
rename to tools/perf/tests/shell/attr/test-record-group2
diff --git a/tools/perf/tests/attr/test-record-group3 b/tools/perf/tests/shell/attr/test-record-group3
similarity index 100%
rename from tools/perf/tests/attr/test-record-group3
rename to tools/perf/tests/shell/attr/test-record-group3
diff --git a/tools/perf/tests/attr/test-record-no-buffering b/tools/perf/tests/shell/attr/test-record-no-buffering
similarity index 100%
rename from tools/perf/tests/attr/test-record-no-buffering
rename to tools/perf/tests/shell/attr/test-record-no-buffering
diff --git a/tools/perf/tests/attr/test-record-no-inherit b/tools/perf/tests/shell/attr/test-record-no-inherit
similarity index 100%
rename from tools/perf/tests/attr/test-record-no-inherit
rename to tools/perf/tests/shell/attr/test-record-no-inherit
diff --git a/tools/perf/tests/attr/test-record-no-samples b/tools/perf/tests/shell/attr/test-record-no-samples
similarity index 100%
rename from tools/perf/tests/attr/test-record-no-samples
rename to tools/perf/tests/shell/attr/test-record-no-samples
diff --git a/tools/perf/tests/attr/test-record-period b/tools/perf/tests/shell/attr/test-record-period
similarity index 100%
rename from tools/perf/tests/attr/test-record-period
rename to tools/perf/tests/shell/attr/test-record-period
diff --git a/tools/perf/tests/attr/test-record-pfm-period b/tools/perf/tests/shell/attr/test-record-pfm-period
similarity index 100%
rename from tools/perf/tests/attr/test-record-pfm-period
rename to tools/perf/tests/shell/attr/test-record-pfm-period
diff --git a/tools/perf/tests/attr/test-record-raw b/tools/perf/tests/shell/attr/test-record-raw
similarity index 100%
rename from tools/perf/tests/attr/test-record-raw
rename to tools/perf/tests/shell/attr/test-record-raw
diff --git a/tools/perf/tests/attr/test-record-spe-period b/tools/perf/tests/shell/attr/test-record-spe-period
similarity index 100%
rename from tools/perf/tests/attr/test-record-spe-period
rename to tools/perf/tests/shell/attr/test-record-spe-period
diff --git a/tools/perf/tests/attr/test-record-spe-period-term b/tools/perf/tests/shell/attr/test-record-spe-period-term
similarity index 100%
rename from tools/perf/tests/attr/test-record-spe-period-term
rename to tools/perf/tests/shell/attr/test-record-spe-period-term
diff --git a/tools/perf/tests/attr/test-record-spe-physical-address b/tools/perf/tests/shell/attr/test-record-spe-physical-address
similarity index 100%
rename from tools/perf/tests/attr/test-record-spe-physical-address
rename to tools/perf/tests/shell/attr/test-record-spe-physical-address
diff --git a/tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64 b/tools/perf/tests/shell/attr/test-record-user-regs-no-sve-aarch64
similarity index 100%
rename from tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
rename to tools/perf/tests/shell/attr/test-record-user-regs-no-sve-aarch64
diff --git a/tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64 b/tools/perf/tests/shell/attr/test-record-user-regs-old-sve-aarch64
similarity index 100%
rename from tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64
rename to tools/perf/tests/shell/attr/test-record-user-regs-old-sve-aarch64
diff --git a/tools/perf/tests/attr/test-record-user-regs-sve-aarch64 b/tools/perf/tests/shell/attr/test-record-user-regs-sve-aarch64
similarity index 100%
rename from tools/perf/tests/attr/test-record-user-regs-sve-aarch64
rename to tools/perf/tests/shell/attr/test-record-user-regs-sve-aarch64
diff --git a/tools/perf/tests/attr/test-stat-C0 b/tools/perf/tests/shell/attr/test-stat-C0
similarity index 100%
rename from tools/perf/tests/attr/test-stat-C0
rename to tools/perf/tests/shell/attr/test-stat-C0
diff --git a/tools/perf/tests/attr/test-stat-basic b/tools/perf/tests/shell/attr/test-stat-basic
similarity index 100%
rename from tools/perf/tests/attr/test-stat-basic
rename to tools/perf/tests/shell/attr/test-stat-basic
diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/shell/attr/test-stat-default
similarity index 100%
rename from tools/perf/tests/attr/test-stat-default
rename to tools/perf/tests/shell/attr/test-stat-default
diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/tests/shell/attr/test-stat-detailed-1
similarity index 100%
rename from tools/perf/tests/attr/test-stat-detailed-1
rename to tools/perf/tests/shell/attr/test-stat-detailed-1
diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/tests/shell/attr/test-stat-detailed-2
similarity index 100%
rename from tools/perf/tests/attr/test-stat-detailed-2
rename to tools/perf/tests/shell/attr/test-stat-detailed-2
diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/tests/shell/attr/test-stat-detailed-3
similarity index 100%
rename from tools/perf/tests/attr/test-stat-detailed-3
rename to tools/perf/tests/shell/attr/test-stat-detailed-3
diff --git a/tools/perf/tests/attr/test-stat-group1 b/tools/perf/tests/shell/attr/test-stat-group1
similarity index 100%
rename from tools/perf/tests/attr/test-stat-group1
rename to tools/perf/tests/shell/attr/test-stat-group1
diff --git a/tools/perf/tests/attr/test-stat-no-inherit b/tools/perf/tests/shell/attr/test-stat-no-inherit
similarity index 100%
rename from tools/perf/tests/attr/test-stat-no-inherit
rename to tools/perf/tests/shell/attr/test-stat-no-inherit
diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/shell/lib/attr.py
similarity index 100%
rename from tools/perf/tests/attr.py
rename to tools/perf/tests/shell/lib/attr.py
-- 
2.47.0.rc1.288.g06298d1525-goog

