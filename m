Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591751CC8BC
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803205; cv=none; b=VpvwZoJEbbh4L7jyHK0Y/jfo4UvhFHQ5rvqzQd4VI84aogjUDFyvVesP6+tXwFBv7BJORLAF6TCJtjUsKl/+CXX/scZIV7RgB6BE4439FGGBoz3Y2/8xtyaPX5L4bQndcsMo6oVXoAE/QXHBSrjofvc/MprzWmtNuRcGQmdP7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803205; c=relaxed/simple;
	bh=g9ma8fcKQ/KKeH4mn0jEYSCX7raQWLOcBf4z6OvwRV8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Bve5jS50BO4KK7r1ph+szaNtSceRKIZpNMlq4BB1mTixdPz2QWqogMlV4YQ4QtEeCJaNk+GkKMepcYPey78zi0unMRYPBsYbB7g8DlYadqZsx/H2W/Jnf0g7oEs0exNlTJa4bd6Z1hurJcaZYvzGTzdwCJro48zecG3kvfaxPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrV5VTWK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrV5VTWK"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e000d68bb1so261627b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727803201; x=1728408001; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLp9yo+EBxidtDYAhQJMcMBSF0ofIddpnTeFkF9k/d8=;
        b=QrV5VTWKxXYTtjXLLFMOI1YVG+0CuDES05Y7FjuFZcC+ZXDwz2j+CsIN/Q5yIdjbCD
         ozH5BsTI5Mj7cSyxVQ+IYWZDiUBlKdCjRbJqtFq3hju247ico0mc2j1Ltj+wwjXf09ce
         rszkciRybP/zgFq4JJ7RuYV12+AsywMWRtqP/ve0baZvcaLpXS+corh8OcqIu9qgzDSb
         viaSFwVOsx7EMX7A3ntKZ6ciBAvKWMbZUuvFYxUlyg55aghrRBMioU5w5ogQfcpoUxWi
         u14yJaz2rkw9Q4jlLB0QNQT1w3gSHbWrla0YsaWvo6OEgUBrAygVA4kPqSxRgR7DS3uh
         tNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803201; x=1728408001;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLp9yo+EBxidtDYAhQJMcMBSF0ofIddpnTeFkF9k/d8=;
        b=HSChB0hHC4U3Yqd8c6gk88fsGIaBJHBz5CQiZyBa8j/ajvqH28B8g+42ZFdb2orA0i
         SD/DC7s61B6yPymWtwIB1uV3H365WdSKy9aI4pyFMALkhmBzdx42ifLgtJk/D/bfFCeN
         Dg/f11sLLY6nkCZU+l3wJc1K5dtAEGKhq8EROx44ULcOqd9oBwvfO/t6X0bQKWVKiilz
         65PlLrBHjcvFNPgjNTeHnYmj5VKHEKIowOa0y0MvQriY+MIFRlJ7MrW1PeEKVkZr3wbF
         MS6HnMBI26u0ZUqsi+eRHGIweNgT2p6lIpzG0S7a3tRB9HvjR87Gv0l9Tsk8arYTuHHC
         mXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCViqRH3ibpKihgdhzVUv9SHsvkHE716ydqxC+lJGx8LZiQ0kJUJssUHLivi7iXdZ1XdRJ7fFgF9wx9Ze0IQd/Mq@vger.kernel.org
X-Gm-Message-State: AOJu0YyCKrUFHxZUm7idSYp+D62yx6qc1WJJHnXK1OfqILTGPXQqZM3U
	2784DwXv/lKwqF6rSeXJ+BpReE7c8gaDhXbMnZuk5IPZ5+JoE373wSEpmcZJHjimL9urRD/Jltc
	pZqpKqA==
X-Google-Smtp-Source: AGHT+IGVXfrB0t38oE67HEVPCEAlmR76wOr0y0fVH2nbZez1o1JuA0g3F5na2ch2nD0SGwtNwpPiHx80/YQt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a05:6902:527:b0:e20:cfc2:a326 with SMTP id
 3f1490d57ef6-e2638373fedmr2537276.6.1727803201209; Tue, 01 Oct 2024 10:20:01
 -0700 (PDT)
Date: Tue,  1 Oct 2024 10:19:50 -0700
In-Reply-To: <20241001171950.233723-1-irogers@google.com>
Message-Id: <20241001171950.233723-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001171950.233723-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v1 3/3] perf test: Move attr files into shell directory where
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
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now the attr tests are shell tests move the associated python and
configuration files. Update the installation build rules for the new
directories. Recycle the lib install rules for python files allowing
the explicit attr.py install line to be dropped.

Signed-off-by: Ian Rogers <irogers@google.com>
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
 tools/perf/tests/{ => shell}/attr/test-record-group1         | 0
 tools/perf/tests/{ => shell}/attr/test-record-group2         | 0
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
 50 files changed, 3 insertions(+), 4 deletions(-)
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
 rename tools/perf/tests/{ => shell}/attr/test-record-group1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group2 (100%)
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
diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/shell/attr/test-record-group1
similarity index 100%
rename from tools/perf/tests/attr/test-record-group1
rename to tools/perf/tests/shell/attr/test-record-group1
diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/shell/attr/test-record-group2
similarity index 100%
rename from tools/perf/tests/attr/test-record-group2
rename to tools/perf/tests/shell/attr/test-record-group2
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
2.46.1.824.gd892dcdcdd-goog

