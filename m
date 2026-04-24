Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720993F0AB6
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049397; cv=none; b=iR22zPcVPJu1lfgGVFeq8D4mDIEereW/MWIUhA4Qc8Jh6Fi5TSYWqtTvw+XfacXvbsUwzmqZH90EY4YHbb+k85SVN7CdVcnaQ3h+V5Oe+RsQKf28kpI6GHPVHXE0v9w8O5hs+UYUOY+EsKn1ewaoQVWAqNuU5oJfSf3dEgG6ec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049397; c=relaxed/simple;
	bh=suhKH/X6rHSnzfPbYVCym/ED9Hcx6beqB9unaRKDwmk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dguFJnair9PNc0owDMbLRa+lZJhNolLWg8C2sDfVWGYb7nUXEnh2Zg7DsZsWzdult/q4XTFmp7QA0D81wslAh4eTslXCMctAGylV4WvIv1tiMH7AUaP21CER24RPfEl+6r9MoqITZi19VB/ml0VFbdR4rMpw7PCkBWqyUHKsgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJysSfyx; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJysSfyx"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8de02a4dso9870743c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049379; x=1777654179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9852UW3HJiKdSu5O/COuiyZzvq9ct+oPaCPAjtl8xn4=;
        b=XJysSfyxQB7isoUy7xNm6krfsqUqRJWdPX9UZzSuCcE16GyHpscWcfi8NlmBZgiBrQ
         Udhb6KN+jyGaKRZoaTojN2tFiTwGKNwgczCTE/01JxhpJ9itsIQWZ3seY1jwqEtIfIKQ
         MFdxch9diPuRTvzuQzFjl3hzluBQXP5BEuriyjStbPlkHkD2ERpW0d2Qqsd9pW6f6M7j
         YiPN6/tZr8xXK9OjsXz85M2NjSng332RAdLUV1RurTHDsANqPTmnjv0bo8J0JJniX1w7
         8XGa9i37iTyUUv8raUEpUm023KCM/kTYC96iVzk1VdS+xBfTRndUMj6pmLx7uUsEcv5P
         HJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049380; x=1777654180;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9852UW3HJiKdSu5O/COuiyZzvq9ct+oPaCPAjtl8xn4=;
        b=RQAfozEpy3kmG/7QPVD1zArdKfrbZcR2tVII2LQ0jQyKvxFX5emDjGU16gvD2vuQcc
         Y2nObZ32QsCG2Iwgp13LogSqjPDUsgaYHuSmN7utltgdswHjh81PwgMWa6HD2Sqcgxe1
         UD+Bu9CLQt/CRqbz7c4RbQnuG/cCl1kKabMJ42UEo9+fcYwFzQjaqBHHv4SUiUz7a57P
         YxIh952gY8LAQP8cT85+MTGk0q6GRMRQRHDPd8TuXUFo1ZPdri6eggrw/lUFo8IKMqnd
         m1jMfuuUE0UBzUyjaYpqsgX3oZsv+o7ZD95/lQZ1NuvD97RNhQSSFAKmYTawGdhIa/F7
         vj5A==
X-Forwarded-Encrypted: i=1; AFNElJ9/HM+9A2j8Zhh54WBgXVgWgRTemHjevVruBY0zz+TS3FodxicxEuWQmty2hJViCU0tAUTOIJ5iG7/tWH4VvKYM@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrKJbrCOec7qXy0BQDuBrRrpGtIeCdXcA9YH5FSc9Ozvd2xFf
	aRRIJNnVeMibfW32EJ30TJGn/dhWc8iIrh5VT/aehdId6WVpPpyM/CvF3+2/Kol+L8Uim8UqWz8
	DWnPm9cHisQ==
X-Received: from dlbtu24.prod.google.com ([2002:a05:7022:3c18:b0:12c:3dfa:518e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ff41:b0:12c:8e70:c33b
 with SMTP id a92af1059eb24-12c8e70c6d6mr13899821c88.8.1777049378947; Fri, 24
 Apr 2026 09:49:38 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:16 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-55-irogers@google.com>
Subject: [PATCH v5 54/58] perf: Remove libpython support and legacy Python scripts
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit removes embedded Python interpreter support from perf, as
all legacy Python scripts have been ported to standalone Python
scripts or are no longer needed.

Changes include:
- Removal of libpython detection and flags from Makefile.config.
- Removal of Python script installation rules from Makefile.perf.
- Deletion of tools/perf/util/scripting-engines/trace-event-python.c.
- Removal of Python scripting operations and setup from
  trace-event-scripting.c.
- Removal of setup_python_scripting() call from builtin-script.c and
  declaration from trace-event.h.
- Removal of Python checks in the script browser (scripts.c).
- Removal of libpython from the supported features list in builtin-check.c
  and Documentation/perf-check.txt.
- Deletion of the legacy Python scripts in tools/perf/scripts/python.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-check.txt       |    1 -
 tools/perf/Makefile.config                    |    4 -
 tools/perf/Makefile.perf                      |    7 +-
 tools/perf/builtin-check.c                    |    1 -
 tools/perf/scripts/Build                      |    2 -
 .../perf/scripts/python/Perf-Trace-Util/Build |    4 -
 .../scripts/python/Perf-Trace-Util/Context.c  |  225 --
 .../Perf-Trace-Util/lib/Perf/Trace/Core.py    |  116 -
 .../lib/Perf/Trace/EventClass.py              |   97 -
 .../lib/Perf/Trace/SchedGui.py                |  184 --
 .../Perf-Trace-Util/lib/Perf/Trace/Util.py    |   92 -
 .../scripts/python/arm-cs-trace-disasm.py     |  355 ---
 .../python/bin/compaction-times-record        |    2 -
 .../python/bin/compaction-times-report        |    4 -
 .../python/bin/event_analyzing_sample-record  |    8 -
 .../python/bin/event_analyzing_sample-report  |    3 -
 .../python/bin/export-to-postgresql-record    |    8 -
 .../python/bin/export-to-postgresql-report    |   29 -
 .../python/bin/export-to-sqlite-record        |    8 -
 .../python/bin/export-to-sqlite-report        |   29 -
 .../python/bin/failed-syscalls-by-pid-record  |    3 -
 .../python/bin/failed-syscalls-by-pid-report  |   10 -
 .../perf/scripts/python/bin/flamegraph-record |    2 -
 .../perf/scripts/python/bin/flamegraph-report |    3 -
 .../python/bin/futex-contention-record        |    2 -
 .../python/bin/futex-contention-report        |    4 -
 tools/perf/scripts/python/bin/gecko-record    |    2 -
 tools/perf/scripts/python/bin/gecko-report    |    7 -
 .../scripts/python/bin/intel-pt-events-record |   13 -
 .../scripts/python/bin/intel-pt-events-report |    3 -
 .../scripts/python/bin/mem-phys-addr-record   |   19 -
 .../scripts/python/bin/mem-phys-addr-report   |    3 -
 .../scripts/python/bin/net_dropmonitor-record |    2 -
 .../scripts/python/bin/net_dropmonitor-report |    4 -
 .../scripts/python/bin/netdev-times-record    |    8 -
 .../scripts/python/bin/netdev-times-report    |    5 -
 .../scripts/python/bin/powerpc-hcalls-record  |    2 -
 .../scripts/python/bin/powerpc-hcalls-report  |    2 -
 .../scripts/python/bin/sched-migration-record |    2 -
 .../scripts/python/bin/sched-migration-report |    3 -
 tools/perf/scripts/python/bin/sctop-record    |    3 -
 tools/perf/scripts/python/bin/sctop-report    |   24 -
 .../scripts/python/bin/stackcollapse-record   |    8 -
 .../scripts/python/bin/stackcollapse-report   |    3 -
 .../python/bin/syscall-counts-by-pid-record   |    3 -
 .../python/bin/syscall-counts-by-pid-report   |   10 -
 .../scripts/python/bin/syscall-counts-record  |    3 -
 .../scripts/python/bin/syscall-counts-report  |   10 -
 .../scripts/python/bin/task-analyzer-record   |    2 -
 .../scripts/python/bin/task-analyzer-report   |    3 -
 tools/perf/scripts/python/check-perf-trace.py |   84 -
 tools/perf/scripts/python/compaction-times.py |  311 ---
 .../scripts/python/event_analyzing_sample.py  |  192 --
 .../scripts/python/export-to-postgresql.py    | 1114 ---------
 tools/perf/scripts/python/export-to-sqlite.py |  799 ------
 .../scripts/python/failed-syscalls-by-pid.py  |   79 -
 tools/perf/scripts/python/flamegraph.py       |  267 --
 tools/perf/scripts/python/futex-contention.py |   57 -
 tools/perf/scripts/python/gecko.py            |  395 ---
 tools/perf/scripts/python/intel-pt-events.py  |  494 ----
 tools/perf/scripts/python/libxed.py           |  107 -
 tools/perf/scripts/python/mem-phys-addr.py    |  127 -
 tools/perf/scripts/python/net_dropmonitor.py  |   78 -
 tools/perf/scripts/python/netdev-times.py     |  473 ----
 tools/perf/scripts/python/powerpc-hcalls.py   |  202 --
 tools/perf/scripts/python/sched-migration.py  |  462 ----
 tools/perf/scripts/python/sctop.py            |   89 -
 tools/perf/scripts/python/stackcollapse.py    |  127 -
 tools/perf/scripts/python/stat-cpi.py         |   79 -
 .../scripts/python/syscall-counts-by-pid.py   |   75 -
 tools/perf/scripts/python/syscall-counts.py   |   65 -
 tools/perf/scripts/python/task-analyzer.py    |  934 -------
 tools/perf/tests/shell/script_python.sh       |  113 -
 tools/perf/util/scripting-engines/Build       |    8 +-
 .../scripting-engines/trace-event-python.c    | 2209 -----------------
 tools/perf/util/trace-event-scripting.c       |   14 +-
 76 files changed, 4 insertions(+), 10297 deletions(-)
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Build
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Context.c
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trac=
e/Core.py
 delete mode 100755 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trac=
e/EventClass.py
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trac=
e/SchedGui.py
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trac=
e/Util.py
 delete mode 100755 tools/perf/scripts/python/arm-cs-trace-disasm.py
 delete mode 100644 tools/perf/scripts/python/bin/compaction-times-record
 delete mode 100644 tools/perf/scripts/python/bin/compaction-times-report
 delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-re=
cord
 delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-re=
port
 delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-reco=
rd
 delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-repo=
rt
 delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-record
 delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-report
 delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-re=
cord
 delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-re=
port
 delete mode 100755 tools/perf/scripts/python/bin/flamegraph-record
 delete mode 100755 tools/perf/scripts/python/bin/flamegraph-report
 delete mode 100644 tools/perf/scripts/python/bin/futex-contention-record
 delete mode 100644 tools/perf/scripts/python/bin/futex-contention-report
 delete mode 100644 tools/perf/scripts/python/bin/gecko-record
 delete mode 100755 tools/perf/scripts/python/bin/gecko-report
 delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-record
 delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-report
 delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-record
 delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-report
 delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-record
 delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-report
 delete mode 100644 tools/perf/scripts/python/bin/netdev-times-record
 delete mode 100644 tools/perf/scripts/python/bin/netdev-times-report
 delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-record
 delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-report
 delete mode 100644 tools/perf/scripts/python/bin/sched-migration-record
 delete mode 100644 tools/perf/scripts/python/bin/sched-migration-report
 delete mode 100644 tools/perf/scripts/python/bin/sctop-record
 delete mode 100644 tools/perf/scripts/python/bin/sctop-report
 delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-record
 delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-report
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-rec=
ord
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-rep=
ort
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-record
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-report
 delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-record
 delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-report
 delete mode 100644 tools/perf/scripts/python/check-perf-trace.py
 delete mode 100644 tools/perf/scripts/python/compaction-times.py
 delete mode 100644 tools/perf/scripts/python/event_analyzing_sample.py
 delete mode 100644 tools/perf/scripts/python/export-to-postgresql.py
 delete mode 100644 tools/perf/scripts/python/export-to-sqlite.py
 delete mode 100644 tools/perf/scripts/python/failed-syscalls-by-pid.py
 delete mode 100755 tools/perf/scripts/python/flamegraph.py
 delete mode 100644 tools/perf/scripts/python/futex-contention.py
 delete mode 100644 tools/perf/scripts/python/gecko.py
 delete mode 100644 tools/perf/scripts/python/intel-pt-events.py
 delete mode 100644 tools/perf/scripts/python/libxed.py
 delete mode 100644 tools/perf/scripts/python/mem-phys-addr.py
 delete mode 100755 tools/perf/scripts/python/net_dropmonitor.py
 delete mode 100644 tools/perf/scripts/python/netdev-times.py
 delete mode 100644 tools/perf/scripts/python/powerpc-hcalls.py
 delete mode 100644 tools/perf/scripts/python/sched-migration.py
 delete mode 100644 tools/perf/scripts/python/sctop.py
 delete mode 100755 tools/perf/scripts/python/stackcollapse.py
 delete mode 100644 tools/perf/scripts/python/stat-cpi.py
 delete mode 100644 tools/perf/scripts/python/syscall-counts-by-pid.py
 delete mode 100644 tools/perf/scripts/python/syscall-counts.py
 delete mode 100755 tools/perf/scripts/python/task-analyzer.py
 delete mode 100755 tools/perf/tests/shell/script_python.sh
 delete mode 100644 tools/perf/util/scripting-engines/trace-event-python.c

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documenta=
tion/perf-check.txt
index 60fa9ea43a58..32d6200e7b20 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -59,7 +59,6 @@ feature::
                 libnuma                 /  HAVE_LIBNUMA_SUPPORT
                 libopencsd              /  HAVE_CSTRACE_SUPPORT
                 libpfm4                 /  HAVE_LIBPFM
-                libpython               /  HAVE_LIBPYTHON_SUPPORT
                 libslang                /  HAVE_SLANG_SUPPORT
                 libtraceevent           /  HAVE_LIBTRACEEVENT
                 libunwind               /  HAVE_LIBUNWIND_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index db30e73c5efc..ecddd91229c8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -852,8 +852,6 @@ else
       ifneq ($(feature-libpython), 1)
         $(call disable-python,No 'Python.h' was found: disables Python sup=
port - please install python-devel/python-dev)
       else
-         LDFLAGS +=3D $(PYTHON_EMBED_LDFLAGS)
-         EXTLIBS +=3D $(PYTHON_EMBED_LIBADD)
          PYTHON_SETUPTOOLS_INSTALLED :=3D $(shell $(PYTHON) -c 'import set=
uptools;' 2> /dev/null && echo "yes" || echo "no")
          ifeq ($(PYTHON_SETUPTOOLS_INSTALLED), yes)
            PYTHON_EXTENSION_SUFFIX :=3D $(shell $(PYTHON) -c 'from importl=
ib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
@@ -864,8 +862,6 @@ else
 	 else
            $(warning Missing python setuptools, the python binding won't b=
e built, please install python3-setuptools or equivalent)
          endif
-         CFLAGS +=3D -DHAVE_LIBPYTHON_SUPPORT
-         $(call detected,CONFIG_LIBPYTHON)
          ifeq ($(filter -fPIC,$(CFLAGS)),)
            # Building a shared library requires position independent code.
            CFLAGS +=3D -fPIC
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7bf349198622..2020532bab9c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1101,11 +1101,8 @@ endif
=20
 ifndef NO_LIBPYTHON
 	$(call QUIET_INSTALL, python-scripts) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python=
/Perf-Trace-Util/lib/Perf/Trace'; \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python=
/bin'; \
-		$(INSTALL) scripts/python/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(=
DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/T=
race'; \
-		$(INSTALL) scripts/python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdi=
r_SQ)/scripts/python'; \
-		$(INSTALL) scripts/python/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/=
scripts/python/bin'
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python=
'; \
+		$(INSTALL) python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/sc=
ripts/python'
 endif
 	$(call QUIET_INSTALL, dlfilters) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/dlfilters'; \
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 944038814d62..73391d182039 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -53,7 +53,6 @@ struct feature_status supported_features[] =3D {
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
=20
 	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
-	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
 	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
 	FEATURE_STATUS("libtraceevent", HAVE_LIBTRACEEVENT),
 	FEATURE_STATUS_TIP("libunwind", HAVE_LIBUNWIND_SUPPORT, "Deprecated, use =
LIBUNWIND=3D1 and install libunwind-dev[el] to build with it"),
diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
index d72cf9ad45fe..d066864369ed 100644
--- a/tools/perf/scripts/Build
+++ b/tools/perf/scripts/Build
@@ -1,6 +1,4 @@
=20
-perf-util-$(CONFIG_LIBPYTHON) +=3D python/Perf-Trace-Util/
-
 ifdef MYPY
   PY_TESTS :=3D $(shell find python -type f -name '*.py')
   MYPY_TEST_LOGS :=3D $(PY_TESTS:python/%=3Dpython/%.mypy_log)
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Build b/tools/perf/s=
cripts/python/Perf-Trace-Util/Build
deleted file mode 100644
index be3710c61320..000000000000
--- a/tools/perf/scripts/python/Perf-Trace-Util/Build
+++ /dev/null
@@ -1,4 +0,0 @@
-perf-util-y +=3D Context.o
-
-# -Wno-declaration-after-statement: The python headers have mixed code wit=
h declarations (decls after asserts, for instance)
-CFLAGS_Context.o +=3D $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-str=
ict-prototypes -Wno-unused-parameter -Wno-nested-externs -Wno-declaration-a=
fter-statement
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/pe=
rf/scripts/python/Perf-Trace-Util/Context.c
deleted file mode 100644
index c19f44610983..000000000000
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ /dev/null
@@ -1,225 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Context.c.  Python interfaces for perf script.
- *
- * Copyright (C) 2010 Tom Zanussi <tzanussi@gmail.com>
- */
-
-/*
- * Use Py_ssize_t for '#' formats to avoid DeprecationWarning: PY_SSIZE_T_=
CLEAN
- * will be required for '#' formats.
- */
-#define PY_SSIZE_T_CLEAN
-
-#include <Python.h>
-#include "../../../util/config.h"
-#include "../../../util/trace-event.h"
-#include "../../../util/event.h"
-#include "../../../util/symbol.h"
-#include "../../../util/thread.h"
-#include "../../../util/map.h"
-#include "../../../util/maps.h"
-#include "../../../util/auxtrace.h"
-#include "../../../util/session.h"
-#include "../../../util/srcline.h"
-#include "../../../util/srccode.h"
-
-#define _PyCapsule_GetPointer(arg1, arg2) \
-  PyCapsule_GetPointer((arg1), (arg2))
-#define _PyBytes_FromStringAndSize(arg1, arg2) \
-  PyBytes_FromStringAndSize((arg1), (arg2))
-#define _PyUnicode_AsUTF8(arg) \
-  PyUnicode_AsUTF8(arg)
-
-PyMODINIT_FUNC PyInit_perf_trace_context(void);
-
-static struct scripting_context *get_args(PyObject *args, const char *name=
, PyObject **arg2)
-{
-	int cnt =3D 1 + !!arg2;
-	PyObject *context;
-
-	if (!PyArg_UnpackTuple(args, name, 1, cnt, &context, arg2))
-		return NULL;
-
-	return _PyCapsule_GetPointer(context, NULL);
-}
-
-static struct scripting_context *get_scripting_context(PyObject *args)
-{
-	return get_args(args, "context", NULL);
-}
-
-#ifdef HAVE_LIBTRACEEVENT
-static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *arg=
s)
-{
-	struct scripting_context *c =3D get_scripting_context(args);
-
-	if (!c)
-		return NULL;
-
-	return Py_BuildValue("i", common_pc(c));
-}
-
-static PyObject *perf_trace_context_common_flags(PyObject *obj,
-						 PyObject *args)
-{
-	struct scripting_context *c =3D get_scripting_context(args);
-
-	if (!c)
-		return NULL;
-
-	return Py_BuildValue("i", common_flags(c));
-}
-
-static PyObject *perf_trace_context_common_lock_depth(PyObject *obj,
-						      PyObject *args)
-{
-	struct scripting_context *c =3D get_scripting_context(args);
-
-	if (!c)
-		return NULL;
-
-	return Py_BuildValue("i", common_lock_depth(c));
-}
-#endif
-
-static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
-{
-	struct scripting_context *c =3D get_scripting_context(args);
-
-	if (!c)
-		return NULL;
-
-	if (c->sample->ip && !c->sample->insn_len && thread__maps(c->al->thread))=
 {
-		struct machine *machine =3D  maps__machine(thread__maps(c->al->thread));
-
-		perf_sample__fetch_insn(c->sample, c->al->thread, machine);
-	}
-	if (!c->sample->insn_len)
-		Py_RETURN_NONE; /* N.B. This is a return statement */
-
-	return _PyBytes_FromStringAndSize(c->sample->insn, c->sample->insn_len);
-}
-
-static PyObject *perf_set_itrace_options(PyObject *obj, PyObject *args)
-{
-	struct scripting_context *c;
-	const char *itrace_options;
-	int retval =3D -1;
-	PyObject *str;
-
-	c =3D get_args(args, "itrace_options", &str);
-	if (!c)
-		return NULL;
-
-	if (!c->session || !c->session->itrace_synth_opts)
-		goto out;
-
-	if (c->session->itrace_synth_opts->set) {
-		retval =3D 1;
-		goto out;
-	}
-
-	itrace_options =3D _PyUnicode_AsUTF8(str);
-
-	retval =3D itrace_do_parse_synth_opts(c->session->itrace_synth_opts, itra=
ce_options, 0);
-out:
-	return Py_BuildValue("i", retval);
-}
-
-static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_s=
rccode)
-{
-	struct scripting_context *c =3D get_scripting_context(args);
-	unsigned int line =3D 0;
-	char *srcfile =3D NULL;
-	char *srccode =3D NULL;
-	PyObject *result;
-	struct map *map;
-	struct dso *dso;
-	int len =3D 0;
-	u64 addr;
-
-	if (!c)
-		return NULL;
-
-	map =3D c->al->map;
-	addr =3D c->al->addr;
-	dso =3D map ? map__dso(map) : NULL;
-
-	if (dso)
-		srcfile =3D get_srcline_split(dso, map__rip_2objdump(map, addr), &line);
-
-	if (get_srccode) {
-		if (srcfile)
-			srccode =3D find_sourceline(srcfile, line, &len);
-		result =3D Py_BuildValue("(sIs#)", srcfile, line, srccode, (Py_ssize_t)l=
en);
-	} else {
-		result =3D Py_BuildValue("(sI)", srcfile, line);
-	}
-
-	free(srcfile);
-
-	return result;
-}
-
-static PyObject *perf_sample_srcline(PyObject *obj, PyObject *args)
-{
-	return perf_sample_src(obj, args, false);
-}
-
-static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
-{
-	return perf_sample_src(obj, args, true);
-}
-
-static PyObject *__perf_config_get(PyObject *obj, PyObject *args)
-{
-	const char *config_name;
-
-	if (!PyArg_ParseTuple(args, "s", &config_name))
-		return NULL;
-	return Py_BuildValue("s", perf_config_get(config_name));
-}
-
-static PyMethodDef ContextMethods[] =3D {
-#ifdef HAVE_LIBTRACEEVENT
-	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
-	  "Get the common preempt count event field value."},
-	{ "common_flags", perf_trace_context_common_flags, METH_VARARGS,
-	  "Get the common flags event field value."},
-	{ "common_lock_depth", perf_trace_context_common_lock_depth,
-	  METH_VARARGS,	"Get the common lock depth event field value."},
-#endif
-	{ "perf_sample_insn", perf_sample_insn,
-	  METH_VARARGS,	"Get the machine code instruction."},
-	{ "perf_set_itrace_options", perf_set_itrace_options,
-	  METH_VARARGS,	"Set --itrace options."},
-	{ "perf_sample_srcline", perf_sample_srcline,
-	  METH_VARARGS,	"Get source file name and line number."},
-	{ "perf_sample_srccode", perf_sample_srccode,
-	  METH_VARARGS,	"Get source file name, line number and line."},
-	{ "perf_config_get", __perf_config_get, METH_VARARGS, "Get perf config en=
try"},
-	{ NULL, NULL, 0, NULL}
-};
-
-PyMODINIT_FUNC PyInit_perf_trace_context(void)
-{
-	static struct PyModuleDef moduledef =3D {
-		PyModuleDef_HEAD_INIT,
-		"perf_trace_context",	/* m_name */
-		"",			/* m_doc */
-		-1,			/* m_size */
-		ContextMethods,		/* m_methods */
-		NULL,			/* m_reload */
-		NULL,			/* m_traverse */
-		NULL,			/* m_clear */
-		NULL,			/* m_free */
-	};
-	PyObject *mod;
-
-	mod =3D PyModule_Create(&moduledef);
-	/* Add perf_script_context to the module so it can be imported */
-	PyObject_SetAttrString(mod, "perf_script_context", Py_None);
-
-	return mod;
-}
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.=
py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
deleted file mode 100644
index 54ace2f6bc36..000000000000
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
+++ /dev/null
@@ -1,116 +0,0 @@
-# Core.py - Python extension for perf script, core functions
-#
-# Copyright (C) 2010 by Tom Zanussi <tzanussi@gmail.com>
-#
-# This software may be distributed under the terms of the GNU General
-# Public License ("GPL") version 2 as published by the Free Software
-# Foundation.
-
-from collections import defaultdict
-
-def autodict():
-    return defaultdict(autodict)
-
-flag_fields =3D autodict()
-symbolic_fields =3D autodict()
-
-def define_flag_field(event_name, field_name, delim):
-    flag_fields[event_name][field_name]['delim'] =3D delim
-
-def define_flag_value(event_name, field_name, value, field_str):
-    flag_fields[event_name][field_name]['values'][value] =3D field_str
-
-def define_symbolic_field(event_name, field_name):
-    # nothing to do, really
-    pass
-
-def define_symbolic_value(event_name, field_name, value, field_str):
-    symbolic_fields[event_name][field_name]['values'][value] =3D field_str
-
-def flag_str(event_name, field_name, value):
-    string =3D ""
-
-    if flag_fields[event_name][field_name]:
-        print_delim =3D 0
-        for idx in sorted(flag_fields[event_name][field_name]['values']):
-            if not value and not idx:
-                string +=3D flag_fields[event_name][field_name]['values'][=
idx]
-                break
-            if idx and (value & idx) =3D=3D idx:
-                if print_delim and flag_fields[event_name][field_name]['de=
lim']:
-                    string +=3D " " + flag_fields[event_name][field_name][=
'delim'] + " "
-                string +=3D flag_fields[event_name][field_name]['values'][=
idx]
-                print_delim =3D 1
-                value &=3D ~idx
-
-    return string
-
-def symbol_str(event_name, field_name, value):
-    string =3D ""
-
-    if symbolic_fields[event_name][field_name]:
-        for idx in sorted(symbolic_fields[event_name][field_name]['values'=
]):
-            if not value and not idx:
-                string =3D symbolic_fields[event_name][field_name]['values=
'][idx]
-                break
-            if (value =3D=3D idx):
-                string =3D symbolic_fields[event_name][field_name]['values=
'][idx]
-                break
-
-    return string
-
-trace_flags =3D { 0x00: "NONE", \
-                    0x01: "IRQS_OFF", \
-                    0x02: "IRQS_NOSUPPORT", \
-                    0x04: "NEED_RESCHED", \
-                    0x08: "HARDIRQ", \
-                    0x10: "SOFTIRQ" }
-
-def trace_flag_str(value):
-    string =3D ""
-    print_delim =3D 0
-
-    for idx in trace_flags:
-        if not value and not idx:
-            string +=3D "NONE"
-            break
-
-        if idx and (value & idx) =3D=3D idx:
-            if print_delim:
-                string +=3D " | ";
-            string +=3D trace_flags[idx]
-            print_delim =3D 1
-            value &=3D ~idx
-
-    return string
-
-
-def taskState(state):
-	states =3D {
-		0 : "R",
-		1 : "S",
-		2 : "D",
-		64: "DEAD"
-	}
-
-	if state not in states:
-		return "Unknown"
-
-	return states[state]
-
-
-class EventHeaders:
-	def __init__(self, common_cpu, common_secs, common_nsecs,
-		     common_pid, common_comm, common_callchain):
-		self.cpu =3D common_cpu
-		self.secs =3D common_secs
-		self.nsecs =3D common_nsecs
-		self.pid =3D common_pid
-		self.comm =3D common_comm
-		self.callchain =3D common_callchain
-
-	def ts(self):
-		return (self.secs * (10 ** 9)) + self.nsecs
-
-	def ts_format(self):
-		return "%d.%d" % (self.secs, int(self.nsecs / 1000))
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Event=
Class.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventCl=
ass.py
deleted file mode 100755
index 21a7a1298094..000000000000
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.p=
y
+++ /dev/null
@@ -1,97 +0,0 @@
-# EventClass.py
-# SPDX-License-Identifier: GPL-2.0
-#
-# This is a library defining some events types classes, which could
-# be used by other scripts to analyzing the perf samples.
-#
-# Currently there are just a few classes defined for examples,
-# PerfEvent is the base class for all perf event sample, PebsEvent
-# is a HW base Intel x86 PEBS event, and user could add more SW/HW
-# event classes based on requirements.
-from __future__ import print_function
-
-import struct
-
-# Event types, user could add more here
-EVTYPE_GENERIC  =3D 0
-EVTYPE_PEBS     =3D 1     # Basic PEBS event
-EVTYPE_PEBS_LL  =3D 2     # PEBS event with load latency info
-EVTYPE_IBS      =3D 3
-
-#
-# Currently we don't have good way to tell the event type, but by
-# the size of raw buffer, raw PEBS event with load latency data's
-# size is 176 bytes, while the pure PEBS event's size is 144 bytes.
-#
-def create_event(name, comm, dso, symbol, raw_buf):
-        if (len(raw_buf) =3D=3D 144):
-                event =3D PebsEvent(name, comm, dso, symbol, raw_buf)
-        elif (len(raw_buf) =3D=3D 176):
-                event =3D PebsNHM(name, comm, dso, symbol, raw_buf)
-        else:
-                event =3D PerfEvent(name, comm, dso, symbol, raw_buf)
-
-        return event
-
-class PerfEvent(object):
-        event_num =3D 0
-        def __init__(self, name, comm, dso, symbol, raw_buf, ev_type=3DEVT=
YPE_GENERIC):
-                self.name       =3D name
-                self.comm       =3D comm
-                self.dso        =3D dso
-                self.symbol     =3D symbol
-                self.raw_buf    =3D raw_buf
-                self.ev_type    =3D ev_type
-                PerfEvent.event_num +=3D 1
-
-        def show(self):
-                print("PMU event: name=3D%12s, symbol=3D%24s, comm=3D%8s, =
dso=3D%12s" %
-                      (self.name, self.symbol, self.comm, self.dso))
-
-#
-# Basic Intel PEBS (Precise Event-based Sampling) event, whose raw buffer
-# contains the context info when that event happened: the EFLAGS and
-# linear IP info, as well as all the registers.
-#
-class PebsEvent(PerfEvent):
-        pebs_num =3D 0
-        def __init__(self, name, comm, dso, symbol, raw_buf, ev_type=3DEVT=
YPE_PEBS):
-                tmp_buf=3Draw_buf[0:80]
-                flags, ip, ax, bx, cx, dx, si, di, bp, sp =3D struct.unpac=
k('QQQQQQQQQQ', tmp_buf)
-                self.flags =3D flags
-                self.ip    =3D ip
-                self.ax    =3D ax
-                self.bx    =3D bx
-                self.cx    =3D cx
-                self.dx    =3D dx
-                self.si    =3D si
-                self.di    =3D di
-                self.bp    =3D bp
-                self.sp    =3D sp
-
-                PerfEvent.__init__(self, name, comm, dso, symbol, raw_buf,=
 ev_type)
-                PebsEvent.pebs_num +=3D 1
-                del tmp_buf
-
-#
-# Intel Nehalem and Westmere support PEBS plus Load Latency info which lie
-# in the four 64 bit words write after the PEBS data:
-#       Status: records the IA32_PERF_GLOBAL_STATUS register value
-#       DLA:    Data Linear Address (EIP)
-#       DSE:    Data Source Encoding, where the latency happens, hit or mi=
ss
-#               in L1/L2/L3 or IO operations
-#       LAT:    the actual latency in cycles
-#
-class PebsNHM(PebsEvent):
-        pebs_nhm_num =3D 0
-        def __init__(self, name, comm, dso, symbol, raw_buf, ev_type=3DEVT=
YPE_PEBS_LL):
-                tmp_buf=3Draw_buf[144:176]
-                status, dla, dse, lat =3D struct.unpack('QQQQ', tmp_buf)
-                self.status =3D status
-                self.dla =3D dla
-                self.dse =3D dse
-                self.lat =3D lat
-
-                PebsEvent.__init__(self, name, comm, dso, symbol, raw_buf,=
 ev_type)
-                PebsNHM.pebs_nhm_num +=3D 1
-                del tmp_buf
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Sched=
Gui.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.=
py
deleted file mode 100644
index cac7b2542ee8..000000000000
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
+++ /dev/null
@@ -1,184 +0,0 @@
-# SchedGui.py - Python extension for perf script, basic GUI code for
-#		traces drawing and overview.
-#
-# Copyright (C) 2010 by Frederic Weisbecker <fweisbec@gmail.com>
-#
-# This software is distributed under the terms of the GNU General
-# Public License ("GPL") version 2 as published by the Free Software
-# Foundation.
-
-
-try:
-	import wx
-except ImportError:
-	raise ImportError("You need to install the wxpython lib for this script")
-
-
-class RootFrame(wx.Frame):
-	Y_OFFSET =3D 100
-	RECT_HEIGHT =3D 100
-	RECT_SPACE =3D 50
-	EVENT_MARKING_WIDTH =3D 5
-
-	def __init__(self, sched_tracer, title, parent =3D None, id =3D -1):
-		wx.Frame.__init__(self, parent, id, title)
-
-		(self.screen_width, self.screen_height) =3D wx.GetDisplaySize()
-		self.screen_width -=3D 10
-		self.screen_height -=3D 10
-		self.zoom =3D 0.5
-		self.scroll_scale =3D 20
-		self.sched_tracer =3D sched_tracer
-		self.sched_tracer.set_root_win(self)
-		(self.ts_start, self.ts_end) =3D sched_tracer.interval()
-		self.update_width_virtual()
-		self.nr_rects =3D sched_tracer.nr_rectangles() + 1
-		self.height_virtual =3D RootFrame.Y_OFFSET + (self.nr_rects * (RootFrame=
.RECT_HEIGHT + RootFrame.RECT_SPACE))
-
-		# whole window panel
-		self.panel =3D wx.Panel(self, size=3D(self.screen_width, self.screen_hei=
ght))
-
-		# scrollable container
-		self.scroll =3D wx.ScrolledWindow(self.panel)
-		self.scroll.SetScrollbars(self.scroll_scale, self.scroll_scale, self.wid=
th_virtual / self.scroll_scale, self.height_virtual / self.scroll_scale)
-		self.scroll.EnableScrolling(True, True)
-		self.scroll.SetFocus()
-
-		# scrollable drawing area
-		self.scroll_panel =3D wx.Panel(self.scroll, size=3D(self.screen_width - =
15, self.screen_height / 2))
-		self.scroll_panel.Bind(wx.EVT_PAINT, self.on_paint)
-		self.scroll_panel.Bind(wx.EVT_KEY_DOWN, self.on_key_press)
-		self.scroll_panel.Bind(wx.EVT_LEFT_DOWN, self.on_mouse_down)
-		self.scroll.Bind(wx.EVT_PAINT, self.on_paint)
-		self.scroll.Bind(wx.EVT_KEY_DOWN, self.on_key_press)
-		self.scroll.Bind(wx.EVT_LEFT_DOWN, self.on_mouse_down)
-
-		self.scroll.Fit()
-		self.Fit()
-
-		self.scroll_panel.SetDimensions(-1, -1, self.width_virtual, self.height_=
virtual, wx.SIZE_USE_EXISTING)
-
-		self.txt =3D None
-
-		self.Show(True)
-
-	def us_to_px(self, val):
-		return val / (10 ** 3) * self.zoom
-
-	def px_to_us(self, val):
-		return (val / self.zoom) * (10 ** 3)
-
-	def scroll_start(self):
-		(x, y) =3D self.scroll.GetViewStart()
-		return (x * self.scroll_scale, y * self.scroll_scale)
-
-	def scroll_start_us(self):
-		(x, y) =3D self.scroll_start()
-		return self.px_to_us(x)
-
-	def paint_rectangle_zone(self, nr, color, top_color, start, end):
-		offset_px =3D self.us_to_px(start - self.ts_start)
-		width_px =3D self.us_to_px(end - self.ts_start)
-
-		offset_py =3D RootFrame.Y_OFFSET + (nr * (RootFrame.RECT_HEIGHT + RootFr=
ame.RECT_SPACE))
-		width_py =3D RootFrame.RECT_HEIGHT
-
-		dc =3D self.dc
-
-		if top_color is not None:
-			(r, g, b) =3D top_color
-			top_color =3D wx.Colour(r, g, b)
-			brush =3D wx.Brush(top_color, wx.SOLID)
-			dc.SetBrush(brush)
-			dc.DrawRectangle(offset_px, offset_py, width_px, RootFrame.EVENT_MARKIN=
G_WIDTH)
-			width_py -=3D RootFrame.EVENT_MARKING_WIDTH
-			offset_py +=3D RootFrame.EVENT_MARKING_WIDTH
-
-		(r ,g, b) =3D color
-		color =3D wx.Colour(r, g, b)
-		brush =3D wx.Brush(color, wx.SOLID)
-		dc.SetBrush(brush)
-		dc.DrawRectangle(offset_px, offset_py, width_px, width_py)
-
-	def update_rectangles(self, dc, start, end):
-		start +=3D self.ts_start
-		end +=3D self.ts_start
-		self.sched_tracer.fill_zone(start, end)
-
-	def on_paint(self, event):
-		dc =3D wx.PaintDC(self.scroll_panel)
-		self.dc =3D dc
-
-		width =3D min(self.width_virtual, self.screen_width)
-		(x, y) =3D self.scroll_start()
-		start =3D self.px_to_us(x)
-		end =3D self.px_to_us(x + width)
-		self.update_rectangles(dc, start, end)
-
-	def rect_from_ypixel(self, y):
-		y -=3D RootFrame.Y_OFFSET
-		rect =3D y / (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)
-		height =3D y % (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)
-
-		if rect < 0 or rect > self.nr_rects - 1 or height > RootFrame.RECT_HEIGH=
T:
-			return -1
-
-		return rect
-
-	def update_summary(self, txt):
-		if self.txt:
-			self.txt.Destroy()
-		self.txt =3D wx.StaticText(self.panel, -1, txt, (0, (self.screen_height =
/ 2) + 50))
-
-
-	def on_mouse_down(self, event):
-		(x, y) =3D event.GetPositionTuple()
-		rect =3D self.rect_from_ypixel(y)
-		if rect =3D=3D -1:
-			return
-
-		t =3D self.px_to_us(x) + self.ts_start
-
-		self.sched_tracer.mouse_down(rect, t)
-
-
-	def update_width_virtual(self):
-		self.width_virtual =3D self.us_to_px(self.ts_end - self.ts_start)
-
-	def __zoom(self, x):
-		self.update_width_virtual()
-		(xpos, ypos) =3D self.scroll.GetViewStart()
-		xpos =3D self.us_to_px(x) / self.scroll_scale
-		self.scroll.SetScrollbars(self.scroll_scale, self.scroll_scale, self.wid=
th_virtual / self.scroll_scale, self.height_virtual / self.scroll_scale, xp=
os, ypos)
-		self.Refresh()
-
-	def zoom_in(self):
-		x =3D self.scroll_start_us()
-		self.zoom *=3D 2
-		self.__zoom(x)
-
-	def zoom_out(self):
-		x =3D self.scroll_start_us()
-		self.zoom /=3D 2
-		self.__zoom(x)
-
-
-	def on_key_press(self, event):
-		key =3D event.GetRawKeyCode()
-		if key =3D=3D ord("+"):
-			self.zoom_in()
-			return
-		if key =3D=3D ord("-"):
-			self.zoom_out()
-			return
-
-		key =3D event.GetKeyCode()
-		(x, y) =3D self.scroll.GetViewStart()
-		if key =3D=3D wx.WXK_RIGHT:
-			self.scroll.Scroll(x + 1, y)
-		elif key =3D=3D wx.WXK_LEFT:
-			self.scroll.Scroll(x - 1, y)
-		elif key =3D=3D wx.WXK_DOWN:
-			self.scroll.Scroll(x, y + 1)
-		elif key =3D=3D wx.WXK_UP:
-			self.scroll.Scroll(x, y - 1)
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.=
py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
deleted file mode 100644
index b75d31858e54..000000000000
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
+++ /dev/null
@@ -1,92 +0,0 @@
-# Util.py - Python extension for perf script, miscellaneous utility code
-#
-# Copyright (C) 2010 by Tom Zanussi <tzanussi@gmail.com>
-#
-# This software may be distributed under the terms of the GNU General
-# Public License ("GPL") version 2 as published by the Free Software
-# Foundation.
-from __future__ import print_function
-
-import errno, os
-
-FUTEX_WAIT =3D 0
-FUTEX_WAKE =3D 1
-FUTEX_PRIVATE_FLAG =3D 128
-FUTEX_CLOCK_REALTIME =3D 256
-FUTEX_CMD_MASK =3D ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
-
-NSECS_PER_SEC    =3D 1000000000
-
-def avg(total, n):
-    return total / n
-
-def nsecs(secs, nsecs):
-    return secs * NSECS_PER_SEC + nsecs
-
-def nsecs_secs(nsecs):
-    return nsecs / NSECS_PER_SEC
-
-def nsecs_nsecs(nsecs):
-    return nsecs % NSECS_PER_SEC
-
-def nsecs_str(nsecs):
-    str =3D "%5u.%09u" % (nsecs_secs(nsecs), nsecs_nsecs(nsecs)),
-    return str
-
-def add_stats(dict, key, value):
-	if key not in dict:
-		dict[key] =3D (value, value, value, 1)
-	else:
-		min, max, avg, count =3D dict[key]
-		if value < min:
-			min =3D value
-		if value > max:
-			max =3D value
-		avg =3D (avg + value) / 2
-		dict[key] =3D (min, max, avg, count + 1)
-
-def clear_term():
-    print("\x1b[H\x1b[2J")
-
-audit_package_warned =3D False
-
-try:
-	import audit
-	machine_to_id =3D {
-		'x86_64': audit.MACH_86_64,
-		'aarch64': audit.MACH_AARCH64,
-		'alpha'	: audit.MACH_ALPHA,
-		'ia64'	: audit.MACH_IA64,
-		'ppc'	: audit.MACH_PPC,
-		'ppc64'	: audit.MACH_PPC64,
-		'ppc64le' : audit.MACH_PPC64LE,
-		's390'	: audit.MACH_S390,
-		's390x'	: audit.MACH_S390X,
-		'i386'	: audit.MACH_X86,
-		'i586'	: audit.MACH_X86,
-		'i686'	: audit.MACH_X86,
-	}
-	try:
-		machine_to_id['armeb'] =3D audit.MACH_ARMEB
-	except:
-		pass
-	machine_id =3D machine_to_id[os.uname()[4]]
-except:
-	if not audit_package_warned:
-		audit_package_warned =3D True
-		print("Install the python-audit package to get syscall names.\n"
-                    "For example:\n  # apt-get install python3-audit (Ubun=
tu)"
-                    "\n  # yum install python3-audit (Fedora)"
-                    "\n  etc.\n")
-
-def syscall_name(id):
-	try:
-		return audit.audit_syscall_to_name(id, machine_id)
-	except:
-		return str(id)
-
-def strerror(nr):
-	try:
-		return errno.errorcode[abs(nr)]
-	except:
-		return "Unknown %d errno" % nr
diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/=
scripts/python/arm-cs-trace-disasm.py
deleted file mode 100755
index ba208c90d631..000000000000
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ /dev/null
@@ -1,355 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# arm-cs-trace-disasm.py: ARM CoreSight Trace Dump With Disassember
-#
-# Author: Tor Jeremiassen <tor@ti.com>
-#         Mathieu Poirier <mathieu.poirier@linaro.org>
-#         Leo Yan <leo.yan@linaro.org>
-#         Al Grant <Al.Grant@arm.com>
-
-from __future__ import print_function
-import os
-from os import path
-import re
-from subprocess import *
-import argparse
-import platform
-
-from perf_trace_context import perf_sample_srccode, perf_config_get
-
-# Below are some example commands for using this script.
-# Note a --kcore recording is required for accurate decode
-# due to the alternatives patching mechanism. However this
-# script only supports reading vmlinux for disassembly dump,
-# meaning that any patched instructions will appear
-# as unpatched, but the instruction ranges themselves will
-# be correct. In addition to this, source line info comes
-# from Perf, and when using kcore there is no debug info. The
-# following lists the supported features in each mode:
-#
-# +-----------+-----------------+------------------+------------------+
-# | Recording | Accurate decode | Source line dump | Disassembly dump |
-# +-----------+-----------------+------------------+------------------+
-# | --kcore   | yes             | no               | yes              |
-# | normal    | no              | yes              | yes              |
-# +-----------+-----------------+------------------+------------------+
-#
-# Output disassembly with objdump and auto detect vmlinux
-# (when running on same machine.)
-#  perf script -s scripts/python/arm-cs-trace-disasm.py -d
-#
-# Output disassembly with llvm-objdump:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py \
-#		-- -d llvm-objdump-11 -k path/to/vmlinux
-#
-# Output only source line and symbols:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py
-
-def default_objdump():
-	config =3D perf_config_get("annotate.objdump")
-	return config if config else "objdump"
-
-# Command line parsing.
-def int_arg(v):
-	v =3D int(v)
-	if v < 0:
-		raise argparse.ArgumentTypeError("Argument must be a positive integer")
-	return v
-
-args =3D argparse.ArgumentParser()
-args.add_argument("-k", "--vmlinux",
-		  help=3D"Set path to vmlinux file. Omit to autodetect if running on sam=
e machine")
-args.add_argument("-d", "--objdump", nargs=3D"?", const=3Ddefault_objdump(=
),
-		  help=3D"Show disassembly. Can also be used to change the objdump path"=
),
-args.add_argument("-v", "--verbose", action=3D"store_true", help=3D"Enable=
 debugging log")
-args.add_argument("--start-time", type=3Dint_arg, help=3D"Monotonic clock =
time of sample to start from. "
-		  "See 'time' field on samples in -v mode.")
-args.add_argument("--stop-time", type=3Dint_arg, help=3D"Monotonic clock t=
ime of sample to stop at. "
-		  "See 'time' field on samples in -v mode.")
-args.add_argument("--start-sample", type=3Dint_arg, help=3D"Index of sampl=
e to start from. "
-		  "See 'index' field on samples in -v mode.")
-args.add_argument("--stop-sample", type=3Dint_arg, help=3D"Index of sample=
 to stop at. "
-		  "See 'index' field on samples in -v mode.")
-
-options =3D args.parse_args()
-if (options.start_time and options.stop_time and
-    options.start_time >=3D options.stop_time):
-	print("--start-time must less than --stop-time")
-	exit(2)
-if (options.start_sample and options.stop_sample and
-    options.start_sample >=3D options.stop_sample):
-	print("--start-sample must less than --stop-sample")
-	exit(2)
-
-# Initialize global dicts and regular expression
-disasm_cache =3D dict()
-cpu_data =3D dict()
-disasm_re =3D re.compile(r"^\s*([0-9a-fA-F]+):")
-disasm_func_re =3D re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
-cache_size =3D 64*1024
-sample_idx =3D -1
-
-glb_source_file_name	=3D None
-glb_line_number		=3D None
-glb_dso			=3D None
-
-kver =3D platform.release()
-vmlinux_paths =3D [
-	f"/usr/lib/debug/boot/vmlinux-{kver}.debug",
-	f"/usr/lib/debug/lib/modules/{kver}/vmlinux",
-	f"/lib/modules/{kver}/build/vmlinux",
-	f"/usr/lib/debug/boot/vmlinux-{kver}",
-	f"/boot/vmlinux-{kver}",
-	f"/boot/vmlinux",
-	f"vmlinux"
-]
-
-def get_optional(perf_dict, field):
-       if field in perf_dict:
-               return perf_dict[field]
-       return "[unknown]"
-
-def get_offset(perf_dict, field):
-	if field in perf_dict:
-		return "+%#x" % perf_dict[field]
-	return ""
-
-def find_vmlinux():
-	if hasattr(find_vmlinux, "path"):
-		return find_vmlinux.path
-
-	for v in vmlinux_paths:
-		if os.access(v, os.R_OK):
-			find_vmlinux.path =3D v
-			break
-	else:
-		find_vmlinux.path =3D None
-
-	return find_vmlinux.path
-
-def get_dso_file_path(dso_name, dso_build_id):
-	if (dso_name =3D=3D "[kernel.kallsyms]" or dso_name =3D=3D "vmlinux"):
-		if (options.vmlinux):
-			return options.vmlinux;
-		else:
-			return find_vmlinux() if find_vmlinux() else dso_name
-
-	if (dso_name =3D=3D "[vdso]") :
-		append =3D "/vdso"
-	else:
-		append =3D "/elf"
-
-	dso_path =3D os.environ['PERF_BUILDID_DIR'] + "/" + dso_name + "/" + dso_=
build_id + append;
-	# Replace duplicate slash chars to single slash char
-	dso_path =3D dso_path.replace('//', '/', 1)
-	return dso_path
-
-def read_disam(dso_fname, dso_start, start_addr, stop_addr):
-	addr_range =3D str(start_addr) + ":" + str(stop_addr) + ":" + dso_fname
-
-	# Don't let the cache get too big, clear it when it hits max size
-	if (len(disasm_cache) > cache_size):
-		disasm_cache.clear();
-
-	if addr_range in disasm_cache:
-		disasm_output =3D disasm_cache[addr_range];
-	else:
-		start_addr =3D start_addr - dso_start;
-		stop_addr =3D stop_addr - dso_start;
-		disasm =3D [ options.objdump, "-d", "-z",
-			   "--start-address=3D"+format(start_addr,"#x"),
-			   "--stop-address=3D"+format(stop_addr,"#x") ]
-		disasm +=3D [ dso_fname ]
-		disasm_output =3D check_output(disasm).decode('utf-8').split('\n')
-		disasm_cache[addr_range] =3D disasm_output
-
-	return disasm_output
-
-def print_disam(dso_fname, dso_start, start_addr, stop_addr):
-	for line in read_disam(dso_fname, dso_start, start_addr, stop_addr):
-		m =3D disasm_func_re.search(line)
-		if m is None:
-			m =3D disasm_re.search(line)
-			if m is None:
-				continue
-		print("\t" + line)
-
-def print_sample(sample):
-	print("Sample =3D { cpu: %04d addr: 0x%016x phys_addr: 0x%016x ip: 0x%016=
x " \
-	      "pid: %d tid: %d period: %d time: %d index: %d}" % \
-	      (sample['cpu'], sample['addr'], sample['phys_addr'], \
-	       sample['ip'], sample['pid'], sample['tid'], \
-	       sample['period'], sample['time'], sample_idx))
-
-def trace_begin():
-	print('ARM CoreSight Trace Data Assembler Dump')
-
-def trace_end():
-	print('End')
-
-def trace_unhandled(event_name, context, event_fields_dict):
-	print(' '.join(['%s=3D%s'%(k,str(v))for k,v in sorted(event_fields_dict.i=
tems())]))
-
-def common_start_str(comm, sample):
-	sec =3D int(sample["time"] / 1000000000)
-	ns =3D sample["time"] % 1000000000
-	cpu =3D sample["cpu"]
-	pid =3D sample["pid"]
-	tid =3D sample["tid"]
-	return "%16s %5u/%-5u [%04u] %9u.%09u  " % (comm, pid, tid, cpu, sec, ns)
-
-# This code is copied from intel-pt-events.py for printing source code
-# line and symbols.
-def print_srccode(comm, param_dict, sample, symbol, dso):
-	ip =3D sample["ip"]
-	if symbol =3D=3D "[unknown]":
-		start_str =3D common_start_str(comm, sample) + ("%x" % ip).rjust(16).lju=
st(40)
-	else:
-		offs =3D get_offset(param_dict, "symoff")
-		start_str =3D common_start_str(comm, sample) + (symbol + offs).ljust(40)
-
-	global glb_source_file_name
-	global glb_line_number
-	global glb_dso
-
-	source_file_name, line_number, source_line =3D perf_sample_srccode(perf_s=
cript_context)
-	if source_file_name:
-		if glb_line_number =3D=3D line_number and glb_source_file_name =3D=3D so=
urce_file_name:
-			src_str =3D ""
-		else:
-			if len(source_file_name) > 40:
-				src_file =3D ("..." + source_file_name[-37:]) + " "
-			else:
-				src_file =3D source_file_name.ljust(41)
-
-			if source_line is None:
-				src_str =3D src_file + str(line_number).rjust(4) + " <source not found=
>"
-			else:
-				src_str =3D src_file + str(line_number).rjust(4) + " " + source_line
-		glb_dso =3D None
-	elif dso =3D=3D glb_dso:
-		src_str =3D ""
-	else:
-		src_str =3D dso
-		glb_dso =3D dso
-
-	glb_line_number =3D line_number
-	glb_source_file_name =3D source_file_name
-
-	print(start_str, src_str)
-
-def process_event(param_dict):
-	global cache_size
-	global options
-	global sample_idx
-
-	sample =3D param_dict["sample"]
-	comm =3D param_dict["comm"]
-
-	name =3D param_dict["ev_name"]
-	dso =3D get_optional(param_dict, "dso")
-	dso_bid =3D get_optional(param_dict, "dso_bid")
-	dso_start =3D get_optional(param_dict, "dso_map_start")
-	dso_end =3D get_optional(param_dict, "dso_map_end")
-	symbol =3D get_optional(param_dict, "symbol")
-	map_pgoff =3D get_optional(param_dict, "map_pgoff")
-	# check for valid map offset
-	if (str(map_pgoff) =3D=3D '[unknown]'):
-		map_pgoff =3D 0
-
-	cpu =3D sample["cpu"]
-	ip =3D sample["ip"]
-	addr =3D sample["addr"]
-
-	sample_idx +=3D 1
-
-	if (options.start_time and sample["time"] < options.start_time):
-		return
-	if (options.stop_time and sample["time"] > options.stop_time):
-		exit(0)
-	if (options.start_sample and sample_idx < options.start_sample):
-		return
-	if (options.stop_sample and sample_idx > options.stop_sample):
-		exit(0)
-
-	if (options.verbose =3D=3D True):
-		print("Event type: %s" % name)
-		print_sample(sample)
-
-	# Initialize CPU data if it's empty, and directly return back
-	# if this is the first tracing event for this CPU.
-	if (cpu_data.get(str(cpu) + 'addr') =3D=3D None):
-		cpu_data[str(cpu) + 'addr'] =3D addr
-		return
-
-	# If cannot find dso so cannot dump assembler, bail out
-	if (dso =3D=3D '[unknown]'):
-		return
-
-	# Validate dso start and end addresses
-	if ((dso_start =3D=3D '[unknown]') or (dso_end =3D=3D '[unknown]')):
-		print("Failed to find valid dso map for dso %s" % dso)
-		return
-
-	if (name[0:12] =3D=3D "instructions"):
-		print_srccode(comm, param_dict, sample, symbol, dso)
-		return
-
-	# Don't proceed if this event is not a branch sample, .
-	if (name[0:8] !=3D "branches"):
-		return
-
-	# The format for packet is:
-	#
-	#		  +------------+------------+------------+
-	#  sample_prev:   |    addr    |    ip	    |	 cpu	 |
-	#		  +------------+------------+------------+
-	#  sample_next:   |    addr    |    ip	    |	 cpu	 |
-	#		  +------------+------------+------------+
-	#
-	# We need to combine the two continuous packets to get the instruction
-	# range for sample_prev::cpu:
-	#
-	#     [ sample_prev::addr .. sample_next::ip ]
-	#
-	# For this purose, sample_prev::addr is stored into cpu_data structure
-	# and read back for 'start_addr' when the new packet comes, and we need
-	# to use sample_next::ip to calculate 'stop_addr', plusing extra 4 for
-	# 'stop_addr' is for the sake of objdump so the final assembler dump can
-	# include last instruction for sample_next::ip.
-	start_addr =3D cpu_data[str(cpu) + 'addr']
-	stop_addr  =3D ip + 4
-
-	# Record for previous sample packet
-	cpu_data[str(cpu) + 'addr'] =3D addr
-
-	# Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON pack=
et
-	if (start_addr =3D=3D 0):
-		if ((stop_addr =3D=3D 4) and (options.verbose =3D=3D True)):
-			print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
-		return
-
-	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
-		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" %=
 (start_addr, int(dso_start), int(dso_end), dso))
-		return
-
-	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
-		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % =
(stop_addr, int(dso_start), int(dso_end), dso))
-		return
-
-	if (options.objdump !=3D None):
-		# It doesn't need to decrease virtual memory offset for disassembly
-		# for kernel dso and executable file dso, so in this case we set
-		# vm_start to zero.
-		if (dso =3D=3D "[kernel.kallsyms]" or dso_start =3D=3D 0x400000):
-			dso_vm_start =3D 0
-			map_pgoff =3D 0
-		else:
-			dso_vm_start =3D int(dso_start)
-
-		dso_fname =3D get_dso_file_path(dso, dso_bid)
-		if path.exists(dso_fname):
-			print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr =
+ map_pgoff)
-		else:
-			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso=
, start_addr + map_pgoff, stop_addr + map_pgoff))
-
-	print_srccode(comm, param_dict, sample, symbol, dso)
diff --git a/tools/perf/scripts/python/bin/compaction-times-record b/tools/=
perf/scripts/python/bin/compaction-times-record
deleted file mode 100644
index 6edcd40e14e8..000000000000
--- a/tools/perf/scripts/python/bin/compaction-times-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -e compaction:mm_compaction_begin -e compaction:mm_compaction_=
end -e compaction:mm_compaction_migratepages -e compaction:mm_compaction_is=
olate_migratepages -e compaction:mm_compaction_isolate_freepages $@
diff --git a/tools/perf/scripts/python/bin/compaction-times-report b/tools/=
perf/scripts/python/bin/compaction-times-report
deleted file mode 100644
index 3dc13897cfde..000000000000
--- a/tools/perf/scripts/python/bin/compaction-times-report
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-#description: display time taken by mm compaction
-#args: [-h] [-u] [-p|-pv] [-t | [-m] [-fs] [-ms]] [pid|pid-range|comm-rege=
x]
-perf script -s "$PERF_EXEC_PATH"/scripts/python/compaction-times.py $@
diff --git a/tools/perf/scripts/python/bin/event_analyzing_sample-record b/=
tools/perf/scripts/python/bin/event_analyzing_sample-record
deleted file mode 100644
index 5ce652dabd02..000000000000
--- a/tools/perf/scripts/python/bin/event_analyzing_sample-record
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-
-#
-# event_analyzing_sample.py can cover all type of perf samples including
-# the tracepoints, so no special record requirements, just record what
-# you want to analyze.
-#
-perf record $@
diff --git a/tools/perf/scripts/python/bin/event_analyzing_sample-report b/=
tools/perf/scripts/python/bin/event_analyzing_sample-report
deleted file mode 100644
index 0941fc94e158..000000000000
--- a/tools/perf/scripts/python/bin/event_analyzing_sample-report
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-# description: analyze all perf samples
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/event_analyzing_sample.=
py
diff --git a/tools/perf/scripts/python/bin/export-to-postgresql-record b/to=
ols/perf/scripts/python/bin/export-to-postgresql-record
deleted file mode 100644
index 221d66e05713..000000000000
--- a/tools/perf/scripts/python/bin/export-to-postgresql-record
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-
-#
-# export perf data to a postgresql database. Can cover
-# perf ip samples (excluding the tracepoints). No special
-# record requirements, just record what you want to export.
-#
-perf record $@
diff --git a/tools/perf/scripts/python/bin/export-to-postgresql-report b/to=
ols/perf/scripts/python/bin/export-to-postgresql-report
deleted file mode 100644
index cd335b6e2a01..000000000000
--- a/tools/perf/scripts/python/bin/export-to-postgresql-report
+++ /dev/null
@@ -1,29 +0,0 @@
-#!/bin/bash
-# description: export perf data to a postgresql database
-# args: [database name] [columns] [calls]
-n_args=3D0
-for i in "$@"
-do
-    if expr match "$i" "-" > /dev/null ; then
-	break
-    fi
-    n_args=3D$(( $n_args + 1 ))
-done
-if [ "$n_args" -gt 3 ] ; then
-    echo "usage: export-to-postgresql-report [database name] [columns] [ca=
lls]"
-    exit
-fi
-if [ "$n_args" -gt 2 ] ; then
-    dbname=3D$1
-    columns=3D$2
-    calls=3D$3
-    shift 3
-elif [ "$n_args" -gt 1 ] ; then
-    dbname=3D$1
-    columns=3D$2
-    shift 2
-elif [ "$n_args" -gt 0 ] ; then
-    dbname=3D$1
-    shift
-fi
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/export-to-postgresql.py=
 $dbname $columns $calls
diff --git a/tools/perf/scripts/python/bin/export-to-sqlite-record b/tools/=
perf/scripts/python/bin/export-to-sqlite-record
deleted file mode 100644
index 070204fd6d00..000000000000
--- a/tools/perf/scripts/python/bin/export-to-sqlite-record
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-
-#
-# export perf data to a sqlite3 database. Can cover
-# perf ip samples (excluding the tracepoints). No special
-# record requirements, just record what you want to export.
-#
-perf record $@
diff --git a/tools/perf/scripts/python/bin/export-to-sqlite-report b/tools/=
perf/scripts/python/bin/export-to-sqlite-report
deleted file mode 100644
index 5ff6033e70ba..000000000000
--- a/tools/perf/scripts/python/bin/export-to-sqlite-report
+++ /dev/null
@@ -1,29 +0,0 @@
-#!/bin/bash
-# description: export perf data to a sqlite3 database
-# args: [database name] [columns] [calls]
-n_args=3D0
-for i in "$@"
-do
-    if expr match "$i" "-" > /dev/null ; then
-	break
-    fi
-    n_args=3D$(( $n_args + 1 ))
-done
-if [ "$n_args" -gt 3 ] ; then
-    echo "usage: export-to-sqlite-report [database name] [columns] [calls]=
"
-    exit
-fi
-if [ "$n_args" -gt 2 ] ; then
-    dbname=3D$1
-    columns=3D$2
-    calls=3D$3
-    shift 3
-elif [ "$n_args" -gt 1 ] ; then
-    dbname=3D$1
-    columns=3D$2
-    shift 2
-elif [ "$n_args" -gt 0 ] ; then
-    dbname=3D$1
-    shift
-fi
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/export-to-sqlite.py $db=
name $columns $calls
diff --git a/tools/perf/scripts/python/bin/failed-syscalls-by-pid-record b/=
tools/perf/scripts/python/bin/failed-syscalls-by-pid-record
deleted file mode 100644
index 74685f318379..000000000000
--- a/tools/perf/scripts/python/bin/failed-syscalls-by-pid-record
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-(perf record -e raw_syscalls:sys_exit $@ || \
- perf record -e syscalls:sys_exit $@) 2> /dev/null
diff --git a/tools/perf/scripts/python/bin/failed-syscalls-by-pid-report b/=
tools/perf/scripts/python/bin/failed-syscalls-by-pid-report
deleted file mode 100644
index fda5096d0cbf..000000000000
--- a/tools/perf/scripts/python/bin/failed-syscalls-by-pid-report
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/bash
-# description: system-wide failed syscalls, by pid
-# args: [comm]
-if [ $# -gt 0 ] ; then
-    if ! expr match "$1" "-" > /dev/null ; then
-	comm=3D$1
-	shift
-    fi
-fi
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/failed-syscalls-by-pid.=
py $comm
diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/s=
cripts/python/bin/flamegraph-record
deleted file mode 100755
index 7df5a19c0163..000000000000
--- a/tools/perf/scripts/python/bin/flamegraph-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/s=
cripts/python/bin/flamegraph-report
deleted file mode 100755
index 453a6918afbe..000000000000
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-# description: create flame graphs
-perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py "$@"
diff --git a/tools/perf/scripts/python/bin/futex-contention-record b/tools/=
perf/scripts/python/bin/futex-contention-record
deleted file mode 100644
index b1495c9a9b20..000000000000
--- a/tools/perf/scripts/python/bin/futex-contention-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -e syscalls:sys_enter_futex -e syscalls:sys_exit_futex $@
diff --git a/tools/perf/scripts/python/bin/futex-contention-report b/tools/=
perf/scripts/python/bin/futex-contention-report
deleted file mode 100644
index 6c44271091ab..000000000000
--- a/tools/perf/scripts/python/bin/futex-contention-report
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-# description: futext contention measurement
-
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/futex-contention.py
diff --git a/tools/perf/scripts/python/bin/gecko-record b/tools/perf/script=
s/python/bin/gecko-record
deleted file mode 100644
index f0d1aa55f171..000000000000
--- a/tools/perf/scripts/python/bin/gecko-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -F 99 -g "$@"
diff --git a/tools/perf/scripts/python/bin/gecko-report b/tools/perf/script=
s/python/bin/gecko-report
deleted file mode 100755
index 1867ec8d9757..000000000000
--- a/tools/perf/scripts/python/bin/gecko-report
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-# description: create firefox gecko profile json format from perf.data
-if [ "$*" =3D "-i -" ]; then
-perf script -s "$PERF_EXEC_PATH"/scripts/python/gecko.py
-else
-perf script -s "$PERF_EXEC_PATH"/scripts/python/gecko.py -- "$@"
-fi
diff --git a/tools/perf/scripts/python/bin/intel-pt-events-record b/tools/p=
erf/scripts/python/bin/intel-pt-events-record
deleted file mode 100644
index 6b9877cfe23e..000000000000
--- a/tools/perf/scripts/python/bin/intel-pt-events-record
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/bash
-
-#
-# print Intel PT Events including Power Events and PTWRITE. The intel_pt P=
MU
-# event needs to be specified with appropriate config terms.
-#
-if ! echo "$@" | grep -q intel_pt ; then
-	echo "Options must include the Intel PT event e.g. -e intel_pt/pwr_evt,pt=
w/"
-	echo "and for power events it probably needs to be system wide i.e. -a op=
tion"
-	echo "For example: -a -e intel_pt/pwr_evt,branch=3D0/ sleep 1"
-	exit 1
-fi
-perf record $@
diff --git a/tools/perf/scripts/python/bin/intel-pt-events-report b/tools/p=
erf/scripts/python/bin/intel-pt-events-report
deleted file mode 100644
index beeac3fde9db..000000000000
--- a/tools/perf/scripts/python/bin/intel-pt-events-report
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-# description: print Intel PT Events including Power Events and PTWRITE
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/intel-pt-events.py
diff --git a/tools/perf/scripts/python/bin/mem-phys-addr-record b/tools/per=
f/scripts/python/bin/mem-phys-addr-record
deleted file mode 100644
index 5a875122a904..000000000000
--- a/tools/perf/scripts/python/bin/mem-phys-addr-record
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/bash
-
-#
-# Profiling physical memory by all retired load instructions/uops event
-# MEM_INST_RETIRED.ALL_LOADS or MEM_UOPS_RETIRED.ALL_LOADS
-#
-
-load=3D`perf list | grep mem_inst_retired.all_loads`
-if [ -z "$load" ]; then
-	load=3D`perf list | grep mem_uops_retired.all_loads`
-fi
-if [ -z "$load" ]; then
-	echo "There is no event to count all retired load instructions/uops."
-	exit 1
-fi
-
-arg=3D$(echo $load | tr -d ' ')
-arg=3D"$arg:P"
-perf record --phys-data -e $arg $@
diff --git a/tools/perf/scripts/python/bin/mem-phys-addr-report b/tools/per=
f/scripts/python/bin/mem-phys-addr-report
deleted file mode 100644
index 3f2b847e2eab..000000000000
--- a/tools/perf/scripts/python/bin/mem-phys-addr-report
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-# description: resolve physical address samples
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/mem-phys-addr.py
diff --git a/tools/perf/scripts/python/bin/net_dropmonitor-record b/tools/p=
erf/scripts/python/bin/net_dropmonitor-record
deleted file mode 100755
index 423fb81dadae..000000000000
--- a/tools/perf/scripts/python/bin/net_dropmonitor-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -e skb:kfree_skb $@
diff --git a/tools/perf/scripts/python/bin/net_dropmonitor-report b/tools/p=
erf/scripts/python/bin/net_dropmonitor-report
deleted file mode 100755
index 8d698f5a06aa..000000000000
--- a/tools/perf/scripts/python/bin/net_dropmonitor-report
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-# description: display a table of dropped frames
-
-perf script -s "$PERF_EXEC_PATH"/scripts/python/net_dropmonitor.py $@
diff --git a/tools/perf/scripts/python/bin/netdev-times-record b/tools/perf=
/scripts/python/bin/netdev-times-record
deleted file mode 100644
index 558754b840a9..000000000000
--- a/tools/perf/scripts/python/bin/netdev-times-record
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-perf record -e net:net_dev_xmit -e net:net_dev_queue		\
-		-e net:netif_receive_skb -e net:netif_rx		\
-		-e skb:consume_skb -e skb:kfree_skb			\
-		-e skb:skb_copy_datagram_iovec -e napi:napi_poll	\
-		-e irq:irq_handler_entry -e irq:irq_handler_exit	\
-		-e irq:softirq_entry -e irq:softirq_exit		\
-		-e irq:softirq_raise $@
diff --git a/tools/perf/scripts/python/bin/netdev-times-report b/tools/perf=
/scripts/python/bin/netdev-times-report
deleted file mode 100644
index 8f759291da86..000000000000
--- a/tools/perf/scripts/python/bin/netdev-times-report
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/bash
-# description: display a process of packet and processing time
-# args: [tx] [rx] [dev=3D] [debug]
-
-perf script -s "$PERF_EXEC_PATH"/scripts/python/netdev-times.py $@
diff --git a/tools/perf/scripts/python/bin/powerpc-hcalls-record b/tools/pe=
rf/scripts/python/bin/powerpc-hcalls-record
deleted file mode 100644
index b7402aa9147d..000000000000
--- a/tools/perf/scripts/python/bin/powerpc-hcalls-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -e "{powerpc:hcall_entry,powerpc:hcall_exit}" $@
diff --git a/tools/perf/scripts/python/bin/powerpc-hcalls-report b/tools/pe=
rf/scripts/python/bin/powerpc-hcalls-report
deleted file mode 100644
index dd32ad7465f6..000000000000
--- a/tools/perf/scripts/python/bin/powerpc-hcalls-report
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/powerpc-hcalls.py
diff --git a/tools/perf/scripts/python/bin/sched-migration-record b/tools/p=
erf/scripts/python/bin/sched-migration-record
deleted file mode 100644
index 7493fddbe995..000000000000
--- a/tools/perf/scripts/python/bin/sched-migration-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -m 16384 -e sched:sched_wakeup -e sched:sched_wakeup_new -e sc=
hed:sched_switch -e sched:sched_migrate_task $@
diff --git a/tools/perf/scripts/python/bin/sched-migration-report b/tools/p=
erf/scripts/python/bin/sched-migration-report
deleted file mode 100644
index 68b037a1849b..000000000000
--- a/tools/perf/scripts/python/bin/sched-migration-report
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-# description: sched migration overview
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/sched-migration.py
diff --git a/tools/perf/scripts/python/bin/sctop-record b/tools/perf/script=
s/python/bin/sctop-record
deleted file mode 100644
index d6940841e54f..000000000000
--- a/tools/perf/scripts/python/bin/sctop-record
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-(perf record -e raw_syscalls:sys_enter $@ || \
- perf record -e syscalls:sys_enter $@) 2> /dev/null
diff --git a/tools/perf/scripts/python/bin/sctop-report b/tools/perf/script=
s/python/bin/sctop-report
deleted file mode 100644
index c32db294124d..000000000000
--- a/tools/perf/scripts/python/bin/sctop-report
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-# description: syscall top
-# args: [comm] [interval]
-n_args=3D0
-for i in "$@"
-do
-    if expr match "$i" "-" > /dev/null ; then
-	break
-    fi
-    n_args=3D$(( $n_args + 1 ))
-done
-if [ "$n_args" -gt 2 ] ; then
-    echo "usage: sctop-report [comm] [interval]"
-    exit
-fi
-if [ "$n_args" -gt 1 ] ; then
-    comm=3D$1
-    interval=3D$2
-    shift 2
-elif [ "$n_args" -gt 0 ] ; then
-    interval=3D$1
-    shift
-fi
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/sctop.py $comm $interva=
l
diff --git a/tools/perf/scripts/python/bin/stackcollapse-record b/tools/per=
f/scripts/python/bin/stackcollapse-record
deleted file mode 100755
index 9d8f9f0f3a17..000000000000
--- a/tools/perf/scripts/python/bin/stackcollapse-record
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-
-#
-# stackcollapse.py can cover all type of perf samples including
-# the tracepoints, so no special record requirements, just record what
-# you want to analyze.
-#
-perf record "$@"
diff --git a/tools/perf/scripts/python/bin/stackcollapse-report b/tools/per=
f/scripts/python/bin/stackcollapse-report
deleted file mode 100755
index 21a356bd27f6..000000000000
--- a/tools/perf/scripts/python/bin/stackcollapse-report
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-# description: produce callgraphs in short form for scripting use
-perf script -s "$PERF_EXEC_PATH"/scripts/python/stackcollapse.py "$@"
diff --git a/tools/perf/scripts/python/bin/syscall-counts-by-pid-record b/t=
ools/perf/scripts/python/bin/syscall-counts-by-pid-record
deleted file mode 100644
index d6940841e54f..000000000000
--- a/tools/perf/scripts/python/bin/syscall-counts-by-pid-record
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-(perf record -e raw_syscalls:sys_enter $@ || \
- perf record -e syscalls:sys_enter $@) 2> /dev/null
diff --git a/tools/perf/scripts/python/bin/syscall-counts-by-pid-report b/t=
ools/perf/scripts/python/bin/syscall-counts-by-pid-report
deleted file mode 100644
index 16eb8d65c543..000000000000
--- a/tools/perf/scripts/python/bin/syscall-counts-by-pid-report
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/bash
-# description: system-wide syscall counts, by pid
-# args: [comm]
-if [ $# -gt 0 ] ; then
-    if ! expr match "$1" "-" > /dev/null ; then
-	comm=3D$1
-	shift
-    fi
-fi
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/syscall-counts-by-pid.p=
y $comm
diff --git a/tools/perf/scripts/python/bin/syscall-counts-record b/tools/pe=
rf/scripts/python/bin/syscall-counts-record
deleted file mode 100644
index d6940841e54f..000000000000
--- a/tools/perf/scripts/python/bin/syscall-counts-record
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-(perf record -e raw_syscalls:sys_enter $@ || \
- perf record -e syscalls:sys_enter $@) 2> /dev/null
diff --git a/tools/perf/scripts/python/bin/syscall-counts-report b/tools/pe=
rf/scripts/python/bin/syscall-counts-report
deleted file mode 100644
index 0f0e9d453bb4..000000000000
--- a/tools/perf/scripts/python/bin/syscall-counts-report
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/bash
-# description: system-wide syscall counts
-# args: [comm]
-if [ $# -gt 0 ] ; then
-    if ! expr match "$1" "-" > /dev/null ; then
-	comm=3D$1
-	shift
-    fi
-fi
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/syscall-counts.py $comm
diff --git a/tools/perf/scripts/python/bin/task-analyzer-record b/tools/per=
f/scripts/python/bin/task-analyzer-record
deleted file mode 100755
index 0f6b51bb2767..000000000000
--- a/tools/perf/scripts/python/bin/task-analyzer-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -e sched:sched_switch -e sched:sched_migrate_task "$@"
diff --git a/tools/perf/scripts/python/bin/task-analyzer-report b/tools/per=
f/scripts/python/bin/task-analyzer-report
deleted file mode 100755
index 4b16a8cc40a0..000000000000
--- a/tools/perf/scripts/python/bin/task-analyzer-report
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-# description: analyze timings of tasks
-perf script -s "$PERF_EXEC_PATH"/scripts/python/task-analyzer.py -- "$@"
diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scr=
ipts/python/check-perf-trace.py
deleted file mode 100644
index d2c22954800d..000000000000
--- a/tools/perf/scripts/python/check-perf-trace.py
+++ /dev/null
@@ -1,84 +0,0 @@
-# perf script event handlers, generated by perf script -g python
-# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
-# Licensed under the terms of the GNU GPL License version 2
-#
-# This script tests basic functionality such as flag and symbol
-# strings, common_xxx() calls back into perf, begin, end, unhandled
-# events, etc.  Basically, if this script runs successfully and
-# displays expected results, Python scripting support should be ok.
-
-from __future__ import print_function
-
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from Core import *
-from perf_trace_context import *
-
-unhandled =3D autodict()
-
-def trace_begin():
-	print("trace_begin")
-	pass
-
-def trace_end():
-	print_unhandled()
-
-def irq__softirq_entry(event_name, context, common_cpu,
-		       common_secs, common_nsecs, common_pid, common_comm,
-		       common_callchain, vec):
-	print_header(event_name, common_cpu, common_secs, common_nsecs,
-		common_pid, common_comm)
-
-	print_uncommon(context)
-
-	print("vec=3D%s" % (symbol_str("irq__softirq_entry", "vec", vec)))
-
-def kmem__kmalloc(event_name, context, common_cpu,
-		  common_secs, common_nsecs, common_pid, common_comm,
-		  common_callchain, call_site, ptr, bytes_req, bytes_alloc,
-		  gfp_flags):
-	print_header(event_name, common_cpu, common_secs, common_nsecs,
-		common_pid, common_comm)
-
-	print_uncommon(context)
-
-	print("call_site=3D%u, ptr=3D%u, bytes_req=3D%u, "
-		"bytes_alloc=3D%u, gfp_flags=3D%s" %
-		(call_site, ptr, bytes_req, bytes_alloc,
-		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)))
-
-def trace_unhandled(event_name, context, event_fields_dict):
-	try:
-		unhandled[event_name] +=3D 1
-	except TypeError:
-		unhandled[event_name] =3D 1
-
-def print_header(event_name, cpu, secs, nsecs, pid, comm):
-	print("%-20s %5u %05u.%09u %8u %-20s " %
-		(event_name, cpu, secs, nsecs, pid, comm),
-		end=3D' ')
-
-# print trace fields not included in handler args
-def print_uncommon(context):
-	print("common_preempt_count=3D%d, common_flags=3D%s, "
-		"common_lock_depth=3D%d, " %
-		(common_pc(context), trace_flag_str(common_flags(context)),
-		common_lock_depth(context)))
-
-def print_unhandled():
-	keys =3D unhandled.keys()
-	if not keys:
-		return
-
-	print("\nunhandled events:\n")
-
-	print("%-40s  %10s" % ("event", "count"))
-	print("%-40s  %10s" % ("----------------------------------------",
-				"-----------"))
-
-	for event_name in keys:
-		print("%-40s  %10d\n" % (event_name, unhandled[event_name]))
diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scr=
ipts/python/compaction-times.py
deleted file mode 100644
index 9401f7c14747..000000000000
--- a/tools/perf/scripts/python/compaction-times.py
+++ /dev/null
@@ -1,311 +0,0 @@
-# report time spent in compaction
-# Licensed under the terms of the GNU GPL License version 2
-
-# testing:
-# 'echo 1 > /proc/sys/vm/compact_memory' to force compaction of all zones
-
-import os
-import sys
-import re
-
-import signal
-signal.signal(signal.SIGPIPE, signal.SIG_DFL)
-
-usage =3D "usage: perf script report compaction-times.py -- [-h] [-u] [-p|=
-pv] [-t | [-m] [-fs] [-ms]] [pid|pid-range|comm-regex]\n"
-
-class popt:
-	DISP_DFL =3D 0
-	DISP_PROC =3D 1
-	DISP_PROC_VERBOSE=3D2
-
-class topt:
-	DISP_TIME =3D 0
-	DISP_MIG =3D 1
-	DISP_ISOLFREE =3D 2
-	DISP_ISOLMIG =3D 4
-	DISP_ALL =3D 7
-
-class comm_filter:
-	def __init__(self, re):
-		self.re =3D re
-
-	def filter(self, pid, comm):
-		m =3D self.re.search(comm)
-		return m =3D=3D None or m.group() =3D=3D ""
-
-class pid_filter:
-	def __init__(self, low, high):
-		self.low =3D (0 if low =3D=3D "" else int(low))
-		self.high =3D (0 if high =3D=3D "" else int(high))
-
-	def filter(self, pid, comm):
-		return not (pid >=3D self.low and (self.high =3D=3D 0 or pid <=3D self.h=
igh))
-
-def set_type(t):
-	global opt_disp
-	opt_disp =3D (t if opt_disp =3D=3D topt.DISP_ALL else opt_disp|t)
-
-def ns(sec, nsec):
-	return (sec * 1000000000) + nsec
-
-def time(ns):
-	return "%dns" % ns if opt_ns else "%dus" % (round(ns, -3) / 1000)
-
-class pair:
-	def __init__(self, aval, bval, alabel =3D None, blabel =3D None):
-		self.alabel =3D alabel
-		self.blabel =3D blabel
-		self.aval =3D aval
-		self.bval =3D bval
-
-	def __add__(self, rhs):
-		self.aval +=3D rhs.aval
-		self.bval +=3D rhs.bval
-		return self
-
-	def __str__(self):
-		return "%s=3D%d %s=3D%d" % (self.alabel, self.aval, self.blabel, self.bv=
al)
-
-class cnode:
-	def __init__(self, ns):
-		self.ns =3D ns
-		self.migrated =3D pair(0, 0, "moved", "failed")
-		self.fscan =3D pair(0,0, "scanned", "isolated")
-		self.mscan =3D pair(0,0, "scanned", "isolated")
-
-	def __add__(self, rhs):
-		self.ns +=3D rhs.ns
-		self.migrated +=3D rhs.migrated
-		self.fscan +=3D rhs.fscan
-		self.mscan +=3D rhs.mscan
-		return self
-
-	def __str__(self):
-		prev =3D 0
-		s =3D "%s " % time(self.ns)
-		if (opt_disp & topt.DISP_MIG):
-			s +=3D "migration: %s" % self.migrated
-			prev =3D 1
-		if (opt_disp & topt.DISP_ISOLFREE):
-			s +=3D "%sfree_scanner: %s" % (" " if prev else "", self.fscan)
-			prev =3D 1
-		if (opt_disp & topt.DISP_ISOLMIG):
-			s +=3D "%smigration_scanner: %s" % (" " if prev else "", self.mscan)
-		return s
-
-	def complete(self, secs, nsecs):
-		self.ns =3D ns(secs, nsecs) - self.ns
-
-	def increment(self, migrated, fscan, mscan):
-		if (migrated !=3D None):
-			self.migrated +=3D migrated
-		if (fscan !=3D None):
-			self.fscan +=3D fscan
-		if (mscan !=3D None):
-			self.mscan +=3D mscan
-
-
-class chead:
-	heads =3D {}
-	val =3D cnode(0);
-	fobj =3D None
-
-	@classmethod
-	def add_filter(cls, filter):
-		cls.fobj =3D filter
-
-	@classmethod
-	def create_pending(cls, pid, comm, start_secs, start_nsecs):
-		filtered =3D 0
-		try:
-			head =3D cls.heads[pid]
-			filtered =3D head.is_filtered()
-		except KeyError:
-			if cls.fobj !=3D None:
-				filtered =3D cls.fobj.filter(pid, comm)
-			head =3D cls.heads[pid] =3D chead(comm, pid, filtered)
-
-		if not filtered:
-			head.mark_pending(start_secs, start_nsecs)
-
-	@classmethod
-	def increment_pending(cls, pid, migrated, fscan, mscan):
-		head =3D cls.heads[pid]
-		if not head.is_filtered():
-			if head.is_pending():
-				head.do_increment(migrated, fscan, mscan)
-			else:
-				sys.stderr.write("missing start compaction event for pid %d\n" % pid)
-
-	@classmethod
-	def complete_pending(cls, pid, secs, nsecs):
-		head =3D cls.heads[pid]
-		if not head.is_filtered():
-			if head.is_pending():
-				head.make_complete(secs, nsecs)
-			else:
-				sys.stderr.write("missing start compaction event for pid %d\n" % pid)
-
-	@classmethod
-	def gen(cls):
-		if opt_proc !=3D popt.DISP_DFL:
-			for i in cls.heads:
-				yield cls.heads[i]
-
-	@classmethod
-	def str(cls):
-		return cls.val
-
-	def __init__(self, comm, pid, filtered):
-		self.comm =3D comm
-		self.pid =3D pid
-		self.val =3D cnode(0)
-		self.pending =3D None
-		self.filtered =3D filtered
-		self.list =3D []
-
-	def __add__(self, rhs):
-		self.ns +=3D rhs.ns
-		self.val +=3D rhs.val
-		return self
-
-	def mark_pending(self, secs, nsecs):
-		self.pending =3D cnode(ns(secs, nsecs))
-
-	def do_increment(self, migrated, fscan, mscan):
-		self.pending.increment(migrated, fscan, mscan)
-
-	def make_complete(self, secs, nsecs):
-		self.pending.complete(secs, nsecs)
-		chead.val +=3D self.pending
-
-		if opt_proc !=3D popt.DISP_DFL:
-			self.val +=3D self.pending
-
-			if opt_proc =3D=3D popt.DISP_PROC_VERBOSE:
-				self.list.append(self.pending)
-		self.pending =3D None
-
-	def enumerate(self):
-		if opt_proc =3D=3D popt.DISP_PROC_VERBOSE and not self.is_filtered():
-			for i, pelem in enumerate(self.list):
-				sys.stdout.write("%d[%s].%d: %s\n" % (self.pid, self.comm, i+1, pelem)=
)
-
-	def is_pending(self):
-		return self.pending !=3D None
-
-	def is_filtered(self):
-		return self.filtered
-
-	def display(self):
-		if not self.is_filtered():
-			sys.stdout.write("%d[%s]: %s\n" % (self.pid, self.comm, self.val))
-
-
-def trace_end():
-	sys.stdout.write("total: %s\n" % chead.str())
-	for i in chead.gen():
-		i.display(),
-		i.enumerate()
-
-def compaction__mm_compaction_migratepages(event_name, context, common_cpu=
,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, nr_migrated, nr_failed):
-
-	chead.increment_pending(common_pid,
-		pair(nr_migrated, nr_failed), None, None)
-
-def compaction__mm_compaction_isolate_freepages(event_name, context, commo=
n_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
-
-	chead.increment_pending(common_pid,
-		None, pair(nr_scanned, nr_taken), None)
-
-def compaction__mm_compaction_isolate_migratepages(event_name, context, co=
mmon_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
-
-	chead.increment_pending(common_pid,
-		None, None, pair(nr_scanned, nr_taken))
-
-def compaction__mm_compaction_end(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, zone_start, migrate_start, free_start, zone_end,
-	sync, status):
-
-	chead.complete_pending(common_pid, common_secs, common_nsecs)
-
-def compaction__mm_compaction_begin(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, zone_start, migrate_start, free_start, zone_end,
-	sync):
-
-	chead.create_pending(common_pid, common_comm, common_secs, common_nsecs)
-
-def pr_help():
-	global usage
-
-	sys.stdout.write(usage)
-	sys.stdout.write("\n")
-	sys.stdout.write("-h	display this help\n")
-	sys.stdout.write("-p	display by process\n")
-	sys.stdout.write("-pv	display by process (verbose)\n")
-	sys.stdout.write("-t	display stall times only\n")
-	sys.stdout.write("-m	display stats for migration\n")
-	sys.stdout.write("-fs	display stats for free scanner\n")
-	sys.stdout.write("-ms	display stats for migration scanner\n")
-	sys.stdout.write("-u	display results in microseconds (default nanoseconds=
)\n")
-
-
-comm_re =3D None
-pid_re =3D None
-pid_regex =3D r"^(\d*)-(\d*)$|^(\d*)$"
-
-opt_proc =3D popt.DISP_DFL
-opt_disp =3D topt.DISP_ALL
-
-opt_ns =3D True
-
-argc =3D len(sys.argv) - 1
-if argc >=3D 1:
-	pid_re =3D re.compile(pid_regex)
-
-	for i, opt in enumerate(sys.argv[1:]):
-		if opt[0] =3D=3D "-":
-			if opt =3D=3D "-h":
-				pr_help()
-				exit(0);
-			elif opt =3D=3D "-p":
-				opt_proc =3D popt.DISP_PROC
-			elif opt =3D=3D "-pv":
-				opt_proc =3D popt.DISP_PROC_VERBOSE
-			elif opt =3D=3D '-u':
-				opt_ns =3D False
-			elif opt =3D=3D "-t":
-				set_type(topt.DISP_TIME)
-			elif opt =3D=3D "-m":
-				set_type(topt.DISP_MIG)
-			elif opt =3D=3D "-fs":
-				set_type(topt.DISP_ISOLFREE)
-			elif opt =3D=3D "-ms":
-				set_type(topt.DISP_ISOLMIG)
-			else:
-				sys.exit(usage)
-
-		elif i =3D=3D argc - 1:
-			m =3D pid_re.search(opt)
-			if m !=3D None and m.group() !=3D "":
-				if m.group(3) !=3D None:
-					f =3D pid_filter(m.group(3), m.group(3))
-				else:
-					f =3D pid_filter(m.group(1), m.group(2))
-			else:
-				try:
-					comm_re=3Dre.compile(opt)
-				except:
-					sys.stderr.write("invalid regex '%s'" % opt)
-					sys.exit(usage)
-				f =3D comm_filter(comm_re)
-
-			chead.add_filter(f)
diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/pe=
rf/scripts/python/event_analyzing_sample.py
deleted file mode 100644
index aa1e2cfa26a6..000000000000
--- a/tools/perf/scripts/python/event_analyzing_sample.py
+++ /dev/null
@@ -1,192 +0,0 @@
-# event_analyzing_sample.py: general event handler in python
-# SPDX-License-Identifier: GPL-2.0
-#
-# Current perf report is already very powerful with the annotation integra=
ted,
-# and this script is not trying to be as powerful as perf report, but
-# providing end user/developer a flexible way to analyze the events other
-# than trace points.
-#
-# The 2 database related functions in this script just show how to gather
-# the basic information, and users can modify and write their own function=
s
-# according to their specific requirement.
-#
-# The first function "show_general_events" just does a basic grouping for =
all
-# generic events with the help of sqlite, and the 2nd one "show_pebs_ll" i=
s
-# for a x86 HW PMU event: PEBS with load latency data.
-#
-
-from __future__ import print_function
-
-import os
-import sys
-import math
-import struct
-import sqlite3
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-        '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from EventClass import *
-
-#
-# If the perf.data has a big number of samples, then the insert operation
-# will be very time consuming (about 10+ minutes for 10000 samples) if the
-# .db database is on disk. Move the .db file to RAM based FS to speedup
-# the handling, which will cut the time down to several seconds.
-#
-con =3D sqlite3.connect("/dev/shm/perf.db")
-con.isolation_level =3D None
-
-def trace_begin():
-        print("In trace_begin:\n")
-
-        #
-        # Will create several tables at the start, pebs_ll is for PEBS dat=
a with
-        # load latency info, while gen_events is for general event.
-        #
-        con.execute("""
-                create table if not exists gen_events (
-                        name text,
-                        symbol text,
-                        comm text,
-                        dso text
-                );""")
-        con.execute("""
-                create table if not exists pebs_ll (
-                        name text,
-                        symbol text,
-                        comm text,
-                        dso text,
-                        flags integer,
-                        ip integer,
-                        status integer,
-                        dse integer,
-                        dla integer,
-                        lat integer
-                );""")
-
-#
-# Create and insert event object to a database so that user could
-# do more analysis with simple database commands.
-#
-def process_event(param_dict):
-        event_attr =3D param_dict["attr"]
-        sample     =3D param_dict["sample"]
-        raw_buf    =3D param_dict["raw_buf"]
-        comm       =3D param_dict["comm"]
-        name       =3D param_dict["ev_name"]
-
-        # Symbol and dso info are not always resolved
-        if ("dso" in param_dict):
-                dso =3D param_dict["dso"]
-        else:
-                dso =3D "Unknown_dso"
-
-        if ("symbol" in param_dict):
-                symbol =3D param_dict["symbol"]
-        else:
-                symbol =3D "Unknown_symbol"
-
-        # Create the event object and insert it to the right table in data=
base
-        event =3D create_event(name, comm, dso, symbol, raw_buf)
-        insert_db(event)
-
-def insert_db(event):
-        if event.ev_type =3D=3D EVTYPE_GENERIC:
-                con.execute("insert into gen_events values(?, ?, ?, ?)",
-                                (event.name, event.symbol, event.comm, eve=
nt.dso))
-        elif event.ev_type =3D=3D EVTYPE_PEBS_LL:
-                event.ip &=3D 0x7fffffffffffffff
-                event.dla &=3D 0x7fffffffffffffff
-                con.execute("insert into pebs_ll values (?, ?, ?, ?, ?, ?,=
 ?, ?, ?, ?)",
-                        (event.name, event.symbol, event.comm, event.dso, =
event.flags,
-                                event.ip, event.status, event.dse, event.d=
la, event.lat))
-
-def trace_end():
-        print("In trace_end:\n")
-        # We show the basic info for the 2 type of event classes
-        show_general_events()
-        show_pebs_ll()
-        con.close()
-
-#
-# As the event number may be very big, so we can't use linear way
-# to show the histogram in real number, but use a log2 algorithm.
-#
-
-def num2sym(num):
-        # Each number will have at least one '#'
-        snum =3D '#' * (int)(math.log(num, 2) + 1)
-        return snum
-
-def show_general_events():
-
-        # Check the total record number in the table
-        count =3D con.execute("select count(*) from gen_events")
-        for t in count:
-                print("There is %d records in gen_events table" % t[0])
-                if t[0] =3D=3D 0:
-                        return
-
-        print("Statistics about the general events grouped by thread/symbo=
l/dso: \n")
-
-         # Group by thread
-        commq =3D con.execute("select comm, count(comm) from gen_events gr=
oup by comm order by -count(comm)")
-        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "=3D=
"*42))
-        for row in commq:
-             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
-
-        # Group by symbol
-        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "=
=3D"*58))
-        symbolq =3D con.execute("select symbol, count(symbol) from gen_eve=
nts group by symbol order by -count(symbol)")
-        for row in symbolq:
-             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
-
-        # Group by dso
-        print("\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "=3D"=
*74))
-        dsoq =3D con.execute("select dso, count(dso) from gen_events group=
 by dso order by -count(dso)")
-        for row in dsoq:
-             print("%40s %8d     %s" % (row[0], row[1], num2sym(row[1])))
-
-#
-# This function just shows the basic info, and we could do more with the
-# data in the tables, like checking the function parameters when some
-# big latency events happen.
-#
-def show_pebs_ll():
-
-        count =3D con.execute("select count(*) from pebs_ll")
-        for t in count:
-                print("There is %d records in pebs_ll table" % t[0])
-                if t[0] =3D=3D 0:
-                        return
-
-        print("Statistics about the PEBS Load Latency events grouped by th=
read/symbol/dse/latency: \n")
-
-        # Group by thread
-        commq =3D con.execute("select comm, count(comm) from pebs_ll group=
 by comm order by -count(comm)")
-        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "=3D=
"*42))
-        for row in commq:
-             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
-
-        # Group by symbol
-        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "=
=3D"*58))
-        symbolq =3D con.execute("select symbol, count(symbol) from pebs_ll=
 group by symbol order by -count(symbol)")
-        for row in symbolq:
-             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
-
-        # Group by dse
-        dseq =3D con.execute("select dse, count(dse) from pebs_ll group by=
 dse order by -count(dse)")
-        print("\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "=3D"=
*58))
-        for row in dseq:
-             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
-
-        # Group by latency
-        latq =3D con.execute("select lat, count(lat) from pebs_ll group by=
 lat order by lat")
-        print("\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "=
=3D"*58))
-        for row in latq:
-             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
-
-def trace_unhandled(event_name, context, event_fields_dict):
-        print (' '.join(['%s=3D%s'%(k,str(v))for k,v in sorted(event_field=
s_dict.items())]))
diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf=
/scripts/python/export-to-postgresql.py
deleted file mode 100644
index 3a6bdcd74e60..000000000000
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ /dev/null
@@ -1,1114 +0,0 @@
-# export-to-postgresql.py: export perf data to a postgresql database
-# Copyright (c) 2014, Intel Corporation.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms and conditions of the GNU General Public License,
-# version 2, as published by the Free Software Foundation.
-#
-# This program is distributed in the hope it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License fo=
r
-# more details.
-
-from __future__ import print_function
-
-import os
-import sys
-import struct
-import datetime
-
-# To use this script you will need to have installed package python-pyside=
 which
-# provides LGPL-licensed Python bindings for Qt.  You will also need the p=
ackage
-# libqt4-sql-psql for Qt postgresql support.
-#
-# The script assumes postgresql is running on the local machine and that t=
he
-# user has postgresql permissions to create databases. Examples of install=
ing
-# postgresql and adding such a user are:
-#
-# fedora:
-#
-#	$ sudo yum install postgresql postgresql-server qt-postgresql
-#	$ sudo su - postgres -c initdb
-#	$ sudo service postgresql start
-#	$ sudo su - postgres
-#	$ createuser -s <your user id here>    # Older versions may not support =
-s, in which case answer the prompt below:
-#	Shall the new role be a superuser? (y/n) y
-#	$ sudo yum install python-pyside
-#
-#	Alternately, to use Python3 and/or pyside 2, one of the following:
-#		$ sudo yum install python3-pyside
-#		$ pip install --user PySide2
-#		$ pip3 install --user PySide2
-#
-# ubuntu:
-#
-#	$ sudo apt-get install postgresql
-#	$ sudo su - postgres
-#	$ createuser -s <your user id here>
-#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
-#
-#	Alternately, to use Python3 and/or pyside 2, one of the following:
-#
-#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
-#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
-#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
-#
-# An example of using this script with Intel PT:
-#
-#	$ perf record -e intel_pt//u ls
-#	$ perf script -s ~/libexec/perf-core/scripts/python/export-to-postgresql=
.py pt_example branches calls
-#	2015-05-29 12:49:23.464364 Creating database...
-#	2015-05-29 12:49:26.281717 Writing to intermediate files...
-#	2015-05-29 12:49:27.190383 Copying to database...
-#	2015-05-29 12:49:28.140451 Removing intermediate files...
-#	2015-05-29 12:49:28.147451 Adding primary keys
-#	2015-05-29 12:49:28.655683 Adding foreign keys
-#	2015-05-29 12:49:29.365350 Done
-#
-# To browse the database, psql can be used e.g.
-#
-#	$ psql pt_example
-#	pt_example=3D# select * from samples_view where id < 100;
-#	pt_example=3D# \d+
-#	pt_example=3D# \d+ samples_view
-#	pt_example=3D# \q
-#
-# An example of using the database is provided by the script
-# exported-sql-viewer.py.  Refer to that script for details.
-#
-# Tables:
-#
-#	The tables largely correspond to perf tools' data structures.  They are =
largely self-explanatory.
-#
-#	samples
-#
-#		'samples' is the main table. It represents what instruction was executi=
ng at a point in time
-#		when something (a selected event) happened.  The memory address is the =
instruction pointer or 'ip'.
-#
-#	calls
-#
-#		'calls' represents function calls and is related to 'samples' by 'call_=
id' and 'return_id'.
-#		'calls' is only created when the 'calls' option to this script is speci=
fied.
-#
-#	call_paths
-#
-#		'call_paths' represents all the call stacks.  Each 'call' has an associ=
ated record in 'call_paths'.
-#		'calls_paths' is only created when the 'calls' option to this script is=
 specified.
-#
-#	branch_types
-#
-#		'branch_types' provides descriptions for each type of branch.
-#
-#	comm_threads
-#
-#		'comm_threads' shows how 'comms' relates to 'threads'.
-#
-#	comms
-#
-#		'comms' contains a record for each 'comm' - the name given to the execu=
table that is running.
-#
-#	dsos
-#
-#		'dsos' contains a record for each executable file or library.
-#
-#	machines
-#
-#		'machines' can be used to distinguish virtual machines if virtualizatio=
n is supported.
-#
-#	selected_events
-#
-#		'selected_events' contains a record for each kind of event that has bee=
n sampled.
-#
-#	symbols
-#
-#		'symbols' contains a record for each symbol.  Only symbols that have sa=
mples are present.
-#
-#	threads
-#
-#		'threads' contains a record for each thread.
-#
-# Views:
-#
-#	Most of the tables have views for more friendly display.  The views are:
-#
-#		calls_view
-#		call_paths_view
-#		comm_threads_view
-#		dsos_view
-#		machines_view
-#		samples_view
-#		symbols_view
-#		threads_view
-#
-# More examples of browsing the database with psql:
-#   Note that some of the examples are not the most optimal SQL query.
-#   Note that call information is only available if the script's 'calls' o=
ption has been used.
-#
-#	Top 10 function calls (not aggregated by symbol):
-#
-#		SELECT * FROM calls_view ORDER BY elapsed_time DESC LIMIT 10;
-#
-#	Top 10 function calls (aggregated by symbol):
-#
-#		SELECT symbol_id,(SELECT name FROM symbols WHERE id =3D symbol_id) AS s=
ymbol,
-#			SUM(elapsed_time) AS tot_elapsed_time,SUM(branch_count) AS tot_branch_=
count
-#			FROM calls_view GROUP BY symbol_id ORDER BY tot_elapsed_time DESC LIMI=
T 10;
-#
-#		Note that the branch count gives a rough estimation of cpu usage, so fu=
nctions
-#		that took a long time but have a relatively low branch count must have =
spent time
-#		waiting.
-#
-#	Find symbols by pattern matching on part of the name (e.g. names contain=
ing 'alloc'):
-#
-#		SELECT * FROM symbols_view WHERE name LIKE '%alloc%';
-#
-#	Top 10 function calls for a specific symbol (e.g. whose symbol_id is 187=
):
-#
-#		SELECT * FROM calls_view WHERE symbol_id =3D 187 ORDER BY elapsed_time =
DESC LIMIT 10;
-#
-#	Show function calls made by function in the same context (i.e. same call=
 path) (e.g. one with call_path_id 254):
-#
-#		SELECT * FROM calls_view WHERE parent_call_path_id =3D 254;
-#
-#	Show branches made during a function call (e.g. where call_id is 29357 a=
nd return_id is 29370 and tid is 29670)
-#
-#		SELECT * FROM samples_view WHERE id >=3D 29357 AND id <=3D 29370 AND ti=
d =3D 29670 AND event LIKE 'branches%';
-#
-#	Show transactions:
-#
-#		SELECT * FROM samples_view WHERE event =3D 'transactions';
-#
-#		Note transaction start has 'in_tx' true whereas, transaction end has 'i=
n_tx' false.
-#		Transaction aborts have branch_type_name 'transaction abort'
-#
-#	Show transaction aborts:
-#
-#		SELECT * FROM samples_view WHERE event =3D 'transactions' AND branch_ty=
pe_name =3D 'transaction abort';
-#
-# To print a call stack requires walking the call_paths table.  For exampl=
e this python script:
-#   #!/usr/bin/python2
-#
-#   import sys
-#   from PySide.QtSql import *
-#
-#   if __name__ =3D=3D '__main__':
-#           if (len(sys.argv) < 3):
-#                   print >> sys.stderr, "Usage is: printcallstack.py <dat=
abase name> <call_path_id>"
-#                   raise Exception("Too few arguments")
-#           dbname =3D sys.argv[1]
-#           call_path_id =3D sys.argv[2]
-#           db =3D QSqlDatabase.addDatabase('QPSQL')
-#           db.setDatabaseName(dbname)
-#           if not db.open():
-#                   raise Exception("Failed to open database " + dbname + =
" error: " + db.lastError().text())
-#           query =3D QSqlQuery(db)
-#           print "    id          ip  symbol_id  symbol                  =
        dso_id  dso_short_name"
-#           while call_path_id !=3D 0 and call_path_id !=3D 1:
-#                   ret =3D query.exec_('SELECT * FROM call_paths_view WHE=
RE id =3D ' + str(call_path_id))
-#                   if not ret:
-#                           raise Exception("Query failed: " + query.lastE=
rror().text())
-#                   if not query.next():
-#                           raise Exception("Query failed")
-#                   print "{0:>6}  {1:>10}  {2:>9}  {3:<30}  {4:>6}  {5:<3=
0}".format(query.value(0), query.value(1), query.value(2), query.value(3), =
query.value(4), query.value(5))
-#                   call_path_id =3D query.value(6)
-
-pyside_version_1 =3D True
-if not "pyside-version-1" in sys.argv:
-	try:
-		from PySide2.QtSql import *
-		pyside_version_1 =3D False
-	except:
-		pass
-
-if pyside_version_1:
-	from PySide.QtSql import *
-
-if sys.version_info < (3, 0):
-	def toserverstr(str):
-		return str
-	def toclientstr(str):
-		return str
-else:
-	# Assume UTF-8 server_encoding and client_encoding
-	def toserverstr(str):
-		return bytes(str, "UTF_8")
-	def toclientstr(str):
-		return bytes(str, "UTF_8")
-
-# Need to access PostgreSQL C library directly to use COPY FROM STDIN
-from ctypes import *
-libpq =3D CDLL("libpq.so.5")
-PQconnectdb =3D libpq.PQconnectdb
-PQconnectdb.restype =3D c_void_p
-PQconnectdb.argtypes =3D [ c_char_p ]
-PQfinish =3D libpq.PQfinish
-PQfinish.argtypes =3D [ c_void_p ]
-PQstatus =3D libpq.PQstatus
-PQstatus.restype =3D c_int
-PQstatus.argtypes =3D [ c_void_p ]
-PQexec =3D libpq.PQexec
-PQexec.restype =3D c_void_p
-PQexec.argtypes =3D [ c_void_p, c_char_p ]
-PQresultStatus =3D libpq.PQresultStatus
-PQresultStatus.restype =3D c_int
-PQresultStatus.argtypes =3D [ c_void_p ]
-PQputCopyData =3D libpq.PQputCopyData
-PQputCopyData.restype =3D c_int
-PQputCopyData.argtypes =3D [ c_void_p, c_void_p, c_int ]
-PQputCopyEnd =3D libpq.PQputCopyEnd
-PQputCopyEnd.restype =3D c_int
-PQputCopyEnd.argtypes =3D [ c_void_p, c_void_p ]
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-# These perf imports are not used at present
-#from perf_trace_context import *
-#from Core import *
-
-perf_db_export_mode =3D True
-perf_db_export_calls =3D False
-perf_db_export_callchains =3D False
-
-def printerr(*args, **kw_args):
-	print(*args, file=3Dsys.stderr, **kw_args)
-
-def printdate(*args, **kw_args):
-        print(datetime.datetime.today(), *args, sep=3D' ', **kw_args)
-
-def usage():
-	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [=
<calls>] [<callchains>] [<pyside-version-1>]");
-	printerr("where:  columns            'all' or 'branches'");
-	printerr("        calls              'calls' =3D> create calls and call_p=
aths table");
-	printerr("        callchains         'callchains' =3D> create call_paths =
table");
-	printerr("        pyside-version-1   'pyside-version-1' =3D> use pyside v=
ersion 1");
-	raise Exception("Too few or bad arguments")
-
-if (len(sys.argv) < 2):
-	usage()
-
-dbname =3D sys.argv[1]
-
-if (len(sys.argv) >=3D 3):
-	columns =3D sys.argv[2]
-else:
-	columns =3D "all"
-
-if columns not in ("all", "branches"):
-	usage()
-
-branches =3D (columns =3D=3D "branches")
-
-for i in range(3,len(sys.argv)):
-	if (sys.argv[i] =3D=3D "calls"):
-		perf_db_export_calls =3D True
-	elif (sys.argv[i] =3D=3D "callchains"):
-		perf_db_export_callchains =3D True
-	elif (sys.argv[i] =3D=3D "pyside-version-1"):
-		pass
-	else:
-		usage()
-
-output_dir_name =3D os.getcwd() + "/" + dbname + "-perf-data"
-os.mkdir(output_dir_name)
-
-def do_query(q, s):
-	if (q.exec_(s)):
-		return
-	raise Exception("Query failed: " + q.lastError().text())
-
-printdate("Creating database...")
-
-db =3D QSqlDatabase.addDatabase('QPSQL')
-query =3D QSqlQuery(db)
-db.setDatabaseName('postgres')
-db.open()
-try:
-	do_query(query, 'CREATE DATABASE ' + dbname)
-except:
-	os.rmdir(output_dir_name)
-	raise
-query.finish()
-query.clear()
-db.close()
-
-db.setDatabaseName(dbname)
-db.open()
-
-query =3D QSqlQuery(db)
-do_query(query, 'SET client_min_messages TO WARNING')
-
-do_query(query, 'CREATE TABLE selected_events ('
-		'id		bigint		NOT NULL,'
-		'name		varchar(80))')
-do_query(query, 'CREATE TABLE machines ('
-		'id		bigint		NOT NULL,'
-		'pid		integer,'
-		'root_dir 	varchar(4096))')
-do_query(query, 'CREATE TABLE threads ('
-		'id		bigint		NOT NULL,'
-		'machine_id	bigint,'
-		'process_id	bigint,'
-		'pid		integer,'
-		'tid		integer)')
-do_query(query, 'CREATE TABLE comms ('
-		'id		bigint		NOT NULL,'
-		'comm		varchar(16),'
-		'c_thread_id	bigint,'
-		'c_time		bigint,'
-		'exec_flag	boolean)')
-do_query(query, 'CREATE TABLE comm_threads ('
-		'id		bigint		NOT NULL,'
-		'comm_id	bigint,'
-		'thread_id	bigint)')
-do_query(query, 'CREATE TABLE dsos ('
-		'id		bigint		NOT NULL,'
-		'machine_id	bigint,'
-		'short_name	varchar(256),'
-		'long_name	varchar(4096),'
-		'build_id	varchar(64))')
-do_query(query, 'CREATE TABLE symbols ('
-		'id		bigint		NOT NULL,'
-		'dso_id		bigint,'
-		'sym_start	bigint,'
-		'sym_end	bigint,'
-		'binding	integer,'
-		'name		varchar(2048))')
-do_query(query, 'CREATE TABLE branch_types ('
-		'id		integer		NOT NULL,'
-		'name		varchar(80))')
-
-if branches:
-	do_query(query, 'CREATE TABLE samples ('
-		'id		bigint		NOT NULL,'
-		'evsel_id	bigint,'
-		'machine_id	bigint,'
-		'thread_id	bigint,'
-		'comm_id	bigint,'
-		'dso_id		bigint,'
-		'symbol_id	bigint,'
-		'sym_offset	bigint,'
-		'ip		bigint,'
-		'time		bigint,'
-		'cpu		integer,'
-		'to_dso_id	bigint,'
-		'to_symbol_id	bigint,'
-		'to_sym_offset	bigint,'
-		'to_ip		bigint,'
-		'branch_type	integer,'
-		'in_tx		boolean,'
-		'call_path_id	bigint,'
-		'insn_count	bigint,'
-		'cyc_count	bigint,'
-		'flags		integer)')
-else:
-	do_query(query, 'CREATE TABLE samples ('
-		'id		bigint		NOT NULL,'
-		'evsel_id	bigint,'
-		'machine_id	bigint,'
-		'thread_id	bigint,'
-		'comm_id	bigint,'
-		'dso_id		bigint,'
-		'symbol_id	bigint,'
-		'sym_offset	bigint,'
-		'ip		bigint,'
-		'time		bigint,'
-		'cpu		integer,'
-		'to_dso_id	bigint,'
-		'to_symbol_id	bigint,'
-		'to_sym_offset	bigint,'
-		'to_ip		bigint,'
-		'period		bigint,'
-		'weight		bigint,'
-		'transaction	bigint,'
-		'data_src	bigint,'
-		'branch_type	integer,'
-		'in_tx		boolean,'
-		'call_path_id	bigint,'
-		'insn_count	bigint,'
-		'cyc_count	bigint,'
-		'flags		integer)')
-
-if perf_db_export_calls or perf_db_export_callchains:
-	do_query(query, 'CREATE TABLE call_paths ('
-		'id		bigint		NOT NULL,'
-		'parent_id	bigint,'
-		'symbol_id	bigint,'
-		'ip		bigint)')
-if perf_db_export_calls:
-	do_query(query, 'CREATE TABLE calls ('
-		'id		bigint		NOT NULL,'
-		'thread_id	bigint,'
-		'comm_id	bigint,'
-		'call_path_id	bigint,'
-		'call_time	bigint,'
-		'return_time	bigint,'
-		'branch_count	bigint,'
-		'call_id	bigint,'
-		'return_id	bigint,'
-		'parent_call_path_id	bigint,'
-		'flags		integer,'
-		'parent_id	bigint,'
-		'insn_count	bigint,'
-		'cyc_count	bigint)')
-
-do_query(query, 'CREATE TABLE ptwrite ('
-	'id		bigint		NOT NULL,'
-	'payload	bigint,'
-	'exact_ip	boolean)')
-
-do_query(query, 'CREATE TABLE cbr ('
-	'id		bigint		NOT NULL,'
-	'cbr		integer,'
-	'mhz		integer,'
-	'percent	integer)')
-
-do_query(query, 'CREATE TABLE mwait ('
-	'id		bigint		NOT NULL,'
-	'hints		integer,'
-	'extensions	integer)')
-
-do_query(query, 'CREATE TABLE pwre ('
-	'id		bigint		NOT NULL,'
-	'cstate		integer,'
-	'subcstate	integer,'
-	'hw		boolean)')
-
-do_query(query, 'CREATE TABLE exstop ('
-	'id		bigint		NOT NULL,'
-	'exact_ip	boolean)')
-
-do_query(query, 'CREATE TABLE pwrx ('
-	'id		bigint		NOT NULL,'
-	'deepest_cstate	integer,'
-	'last_cstate	integer,'
-	'wake_reason	integer)')
-
-do_query(query, 'CREATE TABLE context_switches ('
-		'id		bigint		NOT NULL,'
-		'machine_id	bigint,'
-		'time		bigint,'
-		'cpu		integer,'
-		'thread_out_id	bigint,'
-		'comm_out_id	bigint,'
-		'thread_in_id	bigint,'
-		'comm_in_id	bigint,'
-		'flags		integer)')
-
-do_query(query, 'CREATE VIEW machines_view AS '
-	'SELECT '
-		'id,'
-		'pid,'
-		'root_dir,'
-		'CASE WHEN id=3D0 THEN \'unknown\' WHEN pid=3D-1 THEN \'host\' ELSE \'gu=
est\' END AS host_or_guest'
-	' FROM machines')
-
-do_query(query, 'CREATE VIEW dsos_view AS '
-	'SELECT '
-		'id,'
-		'machine_id,'
-		'(SELECT host_or_guest FROM machines_view WHERE id =3D machine_id) AS ho=
st_or_guest,'
-		'short_name,'
-		'long_name,'
-		'build_id'
-	' FROM dsos')
-
-do_query(query, 'CREATE VIEW symbols_view AS '
-	'SELECT '
-		'id,'
-		'name,'
-		'(SELECT short_name FROM dsos WHERE id=3Ddso_id) AS dso,'
-		'dso_id,'
-		'sym_start,'
-		'sym_end,'
-		'CASE WHEN binding=3D0 THEN \'local\' WHEN binding=3D1 THEN \'global\' E=
LSE \'weak\' END AS binding'
-	' FROM symbols')
-
-do_query(query, 'CREATE VIEW threads_view AS '
-	'SELECT '
-		'id,'
-		'machine_id,'
-		'(SELECT host_or_guest FROM machines_view WHERE id =3D machine_id) AS ho=
st_or_guest,'
-		'process_id,'
-		'pid,'
-		'tid'
-	' FROM threads')
-
-do_query(query, 'CREATE VIEW comm_threads_view AS '
-	'SELECT '
-		'comm_id,'
-		'(SELECT comm FROM comms WHERE id =3D comm_id) AS command,'
-		'thread_id,'
-		'(SELECT pid FROM threads WHERE id =3D thread_id) AS pid,'
-		'(SELECT tid FROM threads WHERE id =3D thread_id) AS tid'
-	' FROM comm_threads')
-
-if perf_db_export_calls or perf_db_export_callchains:
-	do_query(query, 'CREATE VIEW call_paths_view AS '
-		'SELECT '
-			'c.id,'
-			'to_hex(c.ip) AS ip,'
-			'c.symbol_id,'
-			'(SELECT name FROM symbols WHERE id =3D c.symbol_id) AS symbol,'
-			'(SELECT dso_id FROM symbols WHERE id =3D c.symbol_id) AS dso_id,'
-			'(SELECT dso FROM symbols_view  WHERE id =3D c.symbol_id) AS dso_short_=
name,'
-			'c.parent_id,'
-			'to_hex(p.ip) AS parent_ip,'
-			'p.symbol_id AS parent_symbol_id,'
-			'(SELECT name FROM symbols WHERE id =3D p.symbol_id) AS parent_symbol,'
-			'(SELECT dso_id FROM symbols WHERE id =3D p.symbol_id) AS parent_dso_id=
,'
-			'(SELECT dso FROM symbols_view  WHERE id =3D p.symbol_id) AS parent_dso=
_short_name'
-		' FROM call_paths c INNER JOIN call_paths p ON p.id =3D c.parent_id')
-if perf_db_export_calls:
-	do_query(query, 'CREATE VIEW calls_view AS '
-		'SELECT '
-			'calls.id,'
-			'thread_id,'
-			'(SELECT pid FROM threads WHERE id =3D thread_id) AS pid,'
-			'(SELECT tid FROM threads WHERE id =3D thread_id) AS tid,'
-			'(SELECT comm FROM comms WHERE id =3D comm_id) AS command,'
-			'call_path_id,'
-			'to_hex(ip) AS ip,'
-			'symbol_id,'
-			'(SELECT name FROM symbols WHERE id =3D symbol_id) AS symbol,'
-			'call_time,'
-			'return_time,'
-			'return_time - call_time AS elapsed_time,'
-			'branch_count,'
-			'insn_count,'
-			'cyc_count,'
-			'CASE WHEN cyc_count=3D0 THEN CAST(0 AS NUMERIC(20, 2)) ELSE CAST((CAST=
(insn_count AS FLOAT) / cyc_count) AS NUMERIC(20, 2)) END AS IPC,'
-			'call_id,'
-			'return_id,'
-			'CASE WHEN flags=3D0 THEN \'\' WHEN flags=3D1 THEN \'no call\' WHEN fla=
gs=3D2 THEN \'no return\' WHEN flags=3D3 THEN \'no call/return\' WHEN flags=
=3D6 THEN \'jump\' ELSE CAST ( flags AS VARCHAR(6) ) END AS flags,'
-			'parent_call_path_id,'
-			'calls.parent_id'
-		' FROM calls INNER JOIN call_paths ON call_paths.id =3D call_path_id')
-
-do_query(query, 'CREATE VIEW samples_view AS '
-	'SELECT '
-		'id,'
-		'time,'
-		'cpu,'
-		'(SELECT pid FROM threads WHERE id =3D thread_id) AS pid,'
-		'(SELECT tid FROM threads WHERE id =3D thread_id) AS tid,'
-		'(SELECT comm FROM comms WHERE id =3D comm_id) AS command,'
-		'(SELECT name FROM selected_events WHERE id =3D evsel_id) AS event,'
-		'to_hex(ip) AS ip_hex,'
-		'(SELECT name FROM symbols WHERE id =3D symbol_id) AS symbol,'
-		'sym_offset,'
-		'(SELECT short_name FROM dsos WHERE id =3D dso_id) AS dso_short_name,'
-		'to_hex(to_ip) AS to_ip_hex,'
-		'(SELECT name FROM symbols WHERE id =3D to_symbol_id) AS to_symbol,'
-		'to_sym_offset,'
-		'(SELECT short_name FROM dsos WHERE id =3D to_dso_id) AS to_dso_short_na=
me,'
-		'(SELECT name FROM branch_types WHERE id =3D branch_type) AS branch_type=
_name,'
-		'in_tx,'
-		'insn_count,'
-		'cyc_count,'
-		'CASE WHEN cyc_count=3D0 THEN CAST(0 AS NUMERIC(20, 2)) ELSE CAST((CAST(=
insn_count AS FLOAT) / cyc_count) AS NUMERIC(20, 2)) END AS IPC,'
-		'flags'
-	' FROM samples')
-
-do_query(query, 'CREATE VIEW ptwrite_view AS '
-	'SELECT '
-		'ptwrite.id,'
-		'time,'
-		'cpu,'
-		'to_hex(payload) AS payload_hex,'
-		'CASE WHEN exact_ip=3DFALSE THEN \'False\' ELSE \'True\' END AS exact_ip=
'
-	' FROM ptwrite'
-	' INNER JOIN samples ON samples.id =3D ptwrite.id')
-
-do_query(query, 'CREATE VIEW cbr_view AS '
-	'SELECT '
-		'cbr.id,'
-		'time,'
-		'cpu,'
-		'cbr,'
-		'mhz,'
-		'percent'
-	' FROM cbr'
-	' INNER JOIN samples ON samples.id =3D cbr.id')
-
-do_query(query, 'CREATE VIEW mwait_view AS '
-	'SELECT '
-		'mwait.id,'
-		'time,'
-		'cpu,'
-		'to_hex(hints) AS hints_hex,'
-		'to_hex(extensions) AS extensions_hex'
-	' FROM mwait'
-	' INNER JOIN samples ON samples.id =3D mwait.id')
-
-do_query(query, 'CREATE VIEW pwre_view AS '
-	'SELECT '
-		'pwre.id,'
-		'time,'
-		'cpu,'
-		'cstate,'
-		'subcstate,'
-		'CASE WHEN hw=3DFALSE THEN \'False\' ELSE \'True\' END AS hw'
-	' FROM pwre'
-	' INNER JOIN samples ON samples.id =3D pwre.id')
-
-do_query(query, 'CREATE VIEW exstop_view AS '
-	'SELECT '
-		'exstop.id,'
-		'time,'
-		'cpu,'
-		'CASE WHEN exact_ip=3DFALSE THEN \'False\' ELSE \'True\' END AS exact_ip=
'
-	' FROM exstop'
-	' INNER JOIN samples ON samples.id =3D exstop.id')
-
-do_query(query, 'CREATE VIEW pwrx_view AS '
-	'SELECT '
-		'pwrx.id,'
-		'time,'
-		'cpu,'
-		'deepest_cstate,'
-		'last_cstate,'
-		'CASE     WHEN wake_reason=3D1 THEN \'Interrupt\''
-			' WHEN wake_reason=3D2 THEN \'Timer Deadline\''
-			' WHEN wake_reason=3D4 THEN \'Monitored Address\''
-			' WHEN wake_reason=3D8 THEN \'HW\''
-			' ELSE CAST ( wake_reason AS VARCHAR(2) )'
-		'END AS wake_reason'
-	' FROM pwrx'
-	' INNER JOIN samples ON samples.id =3D pwrx.id')
-
-do_query(query, 'CREATE VIEW power_events_view AS '
-	'SELECT '
-		'samples.id,'
-		'samples.time,'
-		'samples.cpu,'
-		'selected_events.name AS event,'
-		'FORMAT(\'%6s\', cbr.cbr) AS cbr,'
-		'FORMAT(\'%6s\', cbr.mhz) AS MHz,'
-		'FORMAT(\'%5s\', cbr.percent) AS percent,'
-		'to_hex(mwait.hints) AS hints_hex,'
-		'to_hex(mwait.extensions) AS extensions_hex,'
-		'FORMAT(\'%3s\', pwre.cstate) AS cstate,'
-		'FORMAT(\'%3s\', pwre.subcstate) AS subcstate,'
-		'CASE WHEN pwre.hw=3DFALSE THEN \'False\' WHEN pwre.hw=3DTRUE THEN \'Tru=
e\' ELSE NULL END AS hw,'
-		'CASE WHEN exstop.exact_ip=3DFALSE THEN \'False\' WHEN exstop.exact_ip=
=3DTRUE THEN \'True\' ELSE NULL END AS exact_ip,'
-		'FORMAT(\'%3s\', pwrx.deepest_cstate) AS deepest_cstate,'
-		'FORMAT(\'%3s\', pwrx.last_cstate) AS last_cstate,'
-		'CASE     WHEN pwrx.wake_reason=3D1 THEN \'Interrupt\''
-			' WHEN pwrx.wake_reason=3D2 THEN \'Timer Deadline\''
-			' WHEN pwrx.wake_reason=3D4 THEN \'Monitored Address\''
-			' WHEN pwrx.wake_reason=3D8 THEN \'HW\''
-			' ELSE FORMAT(\'%2s\', pwrx.wake_reason)'
-		'END AS wake_reason'
-	' FROM cbr'
-	' FULL JOIN mwait ON mwait.id =3D cbr.id'
-	' FULL JOIN pwre ON pwre.id =3D cbr.id'
-	' FULL JOIN exstop ON exstop.id =3D cbr.id'
-	' FULL JOIN pwrx ON pwrx.id =3D cbr.id'
-	' INNER JOIN samples ON samples.id =3D coalesce(cbr.id, mwait.id, pwre.id=
, exstop.id, pwrx.id)'
-	' INNER JOIN selected_events ON selected_events.id =3D samples.evsel_id'
-	' ORDER BY samples.id')
-
-do_query(query, 'CREATE VIEW context_switches_view AS '
-	'SELECT '
-		'context_switches.id,'
-		'context_switches.machine_id,'
-		'context_switches.time,'
-		'context_switches.cpu,'
-		'th_out.pid AS pid_out,'
-		'th_out.tid AS tid_out,'
-		'comm_out.comm AS comm_out,'
-		'th_in.pid AS pid_in,'
-		'th_in.tid AS tid_in,'
-		'comm_in.comm AS comm_in,'
-		'CASE	  WHEN context_switches.flags =3D 0 THEN \'in\''
-			' WHEN context_switches.flags =3D 1 THEN \'out\''
-			' WHEN context_switches.flags =3D 3 THEN \'out preempt\''
-			' ELSE CAST ( context_switches.flags AS VARCHAR(11) )'
-		'END AS flags'
-	' FROM context_switches'
-	' INNER JOIN threads AS th_out ON th_out.id   =3D context_switches.thread=
_out_id'
-	' INNER JOIN threads AS th_in  ON th_in.id    =3D context_switches.thread=
_in_id'
-	' INNER JOIN comms AS comm_out ON comm_out.id =3D context_switches.comm_o=
ut_id'
-	' INNER JOIN comms AS comm_in  ON comm_in.id  =3D context_switches.comm_i=
n_id')
-
-file_header =3D struct.pack("!11sii", b"PGCOPY\n\377\r\n\0", 0, 0)
-file_trailer =3D b"\377\377"
-
-def open_output_file(file_name):
-	path_name =3D output_dir_name + "/" + file_name
-	file =3D open(path_name, "wb+")
-	file.write(file_header)
-	return file
-
-def close_output_file(file):
-	file.write(file_trailer)
-	file.close()
-
-def copy_output_file_direct(file, table_name):
-	close_output_file(file)
-	sql =3D "COPY " + table_name + " FROM '" + file.name + "' (FORMAT 'binary=
')"
-	do_query(query, sql)
-
-# Use COPY FROM STDIN because security may prevent postgres from accessing=
 the files directly
-def copy_output_file(file, table_name):
-	conn =3D PQconnectdb(toclientstr("dbname =3D " + dbname))
-	if (PQstatus(conn)):
-		raise Exception("COPY FROM STDIN PQconnectdb failed")
-	file.write(file_trailer)
-	file.seek(0)
-	sql =3D "COPY " + table_name + " FROM STDIN (FORMAT 'binary')"
-	res =3D PQexec(conn, toclientstr(sql))
-	if (PQresultStatus(res) !=3D 4):
-		raise Exception("COPY FROM STDIN PQexec failed")
-	data =3D file.read(65536)
-	while (len(data)):
-		ret =3D PQputCopyData(conn, data, len(data))
-		if (ret !=3D 1):
-			raise Exception("COPY FROM STDIN PQputCopyData failed, error " + str(re=
t))
-		data =3D file.read(65536)
-	ret =3D PQputCopyEnd(conn, None)
-	if (ret !=3D 1):
-		raise Exception("COPY FROM STDIN PQputCopyEnd failed, error " + str(ret)=
)
-	PQfinish(conn)
-
-def remove_output_file(file):
-	name =3D file.name
-	file.close()
-	os.unlink(name)
-
-evsel_file		=3D open_output_file("evsel_table.bin")
-machine_file		=3D open_output_file("machine_table.bin")
-thread_file		=3D open_output_file("thread_table.bin")
-comm_file		=3D open_output_file("comm_table.bin")
-comm_thread_file	=3D open_output_file("comm_thread_table.bin")
-dso_file		=3D open_output_file("dso_table.bin")
-symbol_file		=3D open_output_file("symbol_table.bin")
-branch_type_file	=3D open_output_file("branch_type_table.bin")
-sample_file		=3D open_output_file("sample_table.bin")
-if perf_db_export_calls or perf_db_export_callchains:
-	call_path_file		=3D open_output_file("call_path_table.bin")
-if perf_db_export_calls:
-	call_file		=3D open_output_file("call_table.bin")
-ptwrite_file		=3D open_output_file("ptwrite_table.bin")
-cbr_file		=3D open_output_file("cbr_table.bin")
-mwait_file		=3D open_output_file("mwait_table.bin")
-pwre_file		=3D open_output_file("pwre_table.bin")
-exstop_file		=3D open_output_file("exstop_table.bin")
-pwrx_file		=3D open_output_file("pwrx_table.bin")
-context_switches_file	=3D open_output_file("context_switches_table.bin")
-
-def trace_begin():
-	printdate("Writing to intermediate files...")
-	# id =3D=3D 0 means unknown.  It is easier to create records for them tha=
n replace the zeroes with NULLs
-	evsel_table(0, "unknown")
-	machine_table(0, 0, "unknown")
-	thread_table(0, 0, 0, -1, -1)
-	comm_table(0, "unknown", 0, 0, 0)
-	dso_table(0, 0, "unknown", "unknown", "")
-	symbol_table(0, 0, 0, 0, 0, "unknown")
-	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, =
0, 0, 0, 0, 0)
-	if perf_db_export_calls or perf_db_export_callchains:
-		call_path_table(0, 0, 0, 0)
-		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
-
-unhandled_count =3D 0
-
-def is_table_empty(table_name):
-	do_query(query, 'SELECT * FROM ' + table_name + ' LIMIT 1');
-	if query.next():
-		return False
-	return True
-
-def drop(table_name):
-	do_query(query, 'DROP VIEW ' + table_name + '_view');
-	do_query(query, 'DROP TABLE ' + table_name);
-
-def trace_end():
-	printdate("Copying to database...")
-	copy_output_file(evsel_file,		"selected_events")
-	copy_output_file(machine_file,		"machines")
-	copy_output_file(thread_file,		"threads")
-	copy_output_file(comm_file,		"comms")
-	copy_output_file(comm_thread_file,	"comm_threads")
-	copy_output_file(dso_file,		"dsos")
-	copy_output_file(symbol_file,		"symbols")
-	copy_output_file(branch_type_file,	"branch_types")
-	copy_output_file(sample_file,		"samples")
-	if perf_db_export_calls or perf_db_export_callchains:
-		copy_output_file(call_path_file,	"call_paths")
-	if perf_db_export_calls:
-		copy_output_file(call_file,		"calls")
-	copy_output_file(ptwrite_file,		"ptwrite")
-	copy_output_file(cbr_file,		"cbr")
-	copy_output_file(mwait_file,		"mwait")
-	copy_output_file(pwre_file,		"pwre")
-	copy_output_file(exstop_file,		"exstop")
-	copy_output_file(pwrx_file,		"pwrx")
-	copy_output_file(context_switches_file,	"context_switches")
-
-	printdate("Removing intermediate files...")
-	remove_output_file(evsel_file)
-	remove_output_file(machine_file)
-	remove_output_file(thread_file)
-	remove_output_file(comm_file)
-	remove_output_file(comm_thread_file)
-	remove_output_file(dso_file)
-	remove_output_file(symbol_file)
-	remove_output_file(branch_type_file)
-	remove_output_file(sample_file)
-	if perf_db_export_calls or perf_db_export_callchains:
-		remove_output_file(call_path_file)
-	if perf_db_export_calls:
-		remove_output_file(call_file)
-	remove_output_file(ptwrite_file)
-	remove_output_file(cbr_file)
-	remove_output_file(mwait_file)
-	remove_output_file(pwre_file)
-	remove_output_file(exstop_file)
-	remove_output_file(pwrx_file)
-	remove_output_file(context_switches_file)
-	os.rmdir(output_dir_name)
-	printdate("Adding primary keys")
-	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE comms           ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE comm_threads    ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE dsos            ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE symbols         ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE branch_types    ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE samples         ADD PRIMARY KEY (id)')
-	if perf_db_export_calls or perf_db_export_callchains:
-		do_query(query, 'ALTER TABLE call_paths      ADD PRIMARY KEY (id)')
-	if perf_db_export_calls:
-		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE ptwrite         ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE cbr             ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE mwait           ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE pwre            ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE exstop          ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE pwrx            ADD PRIMARY KEY (id)')
-	do_query(query, 'ALTER TABLE context_switches ADD PRIMARY KEY (id)')
-
-	printdate("Adding foreign keys")
-	do_query(query, 'ALTER TABLE threads '
-					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES mach=
ines   (id),'
-					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES thre=
ads    (id)')
-	do_query(query, 'ALTER TABLE comms '
-					'ADD CONSTRAINT threadfk   FOREIGN KEY (c_thread_id)  REFERENCES thre=
ads    (id)')
-	do_query(query, 'ALTER TABLE comm_threads '
-					'ADD CONSTRAINT commfk     FOREIGN KEY (comm_id)      REFERENCES comm=
s      (id),'
-					'ADD CONSTRAINT threadfk   FOREIGN KEY (thread_id)    REFERENCES thre=
ads    (id)')
-	do_query(query, 'ALTER TABLE dsos '
-					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES mach=
ines   (id)')
-	do_query(query, 'ALTER TABLE symbols '
-					'ADD CONSTRAINT dsofk      FOREIGN KEY (dso_id)       REFERENCES dsos=
       (id)')
-	do_query(query, 'ALTER TABLE samples '
-					'ADD CONSTRAINT evselfk    FOREIGN KEY (evsel_id)     REFERENCES sele=
cted_events (id),'
-					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES mach=
ines   (id),'
-					'ADD CONSTRAINT threadfk   FOREIGN KEY (thread_id)    REFERENCES thre=
ads    (id),'
-					'ADD CONSTRAINT commfk     FOREIGN KEY (comm_id)      REFERENCES comm=
s      (id),'
-					'ADD CONSTRAINT dsofk      FOREIGN KEY (dso_id)       REFERENCES dsos=
       (id),'
-					'ADD CONSTRAINT symbolfk   FOREIGN KEY (symbol_id)    REFERENCES symb=
ols    (id),'
-					'ADD CONSTRAINT todsofk    FOREIGN KEY (to_dso_id)    REFERENCES dsos=
       (id),'
-					'ADD CONSTRAINT tosymbolfk FOREIGN KEY (to_symbol_id) REFERENCES symb=
ols    (id)')
-	if perf_db_export_calls or perf_db_export_callchains:
-		do_query(query, 'ALTER TABLE call_paths '
-					'ADD CONSTRAINT parentfk    FOREIGN KEY (parent_id)    REFERENCES cal=
l_paths (id),'
-					'ADD CONSTRAINT symbolfk    FOREIGN KEY (symbol_id)    REFERENCES sym=
bols    (id)')
-	if perf_db_export_calls:
-		do_query(query, 'ALTER TABLE calls '
-					'ADD CONSTRAINT threadfk    FOREIGN KEY (thread_id)    REFERENCES thr=
eads    (id),'
-					'ADD CONSTRAINT commfk      FOREIGN KEY (comm_id)      REFERENCES com=
ms      (id),'
-					'ADD CONSTRAINT call_pathfk FOREIGN KEY (call_path_id) REFERENCES cal=
l_paths (id),'
-					'ADD CONSTRAINT callfk      FOREIGN KEY (call_id)      REFERENCES sam=
ples    (id),'
-					'ADD CONSTRAINT returnfk    FOREIGN KEY (return_id)    REFERENCES sam=
ples    (id),'
-					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) =
REFERENCES call_paths (id)')
-		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
-		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
-		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
-		do_query(query, 'UPDATE comms SET has_calls =3D TRUE WHERE comms.id IN (=
SELECT DISTINCT comm_id FROM calls)')
-	do_query(query, 'ALTER TABLE ptwrite '
-					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES sam=
ples   (id)')
-	do_query(query, 'ALTER TABLE  cbr '
-					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES sam=
ples   (id)')
-	do_query(query, 'ALTER TABLE  mwait '
-					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES sam=
ples   (id)')
-	do_query(query, 'ALTER TABLE  pwre '
-					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES sam=
ples   (id)')
-	do_query(query, 'ALTER TABLE  exstop '
-					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES sam=
ples   (id)')
-	do_query(query, 'ALTER TABLE  pwrx '
-					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES sam=
ples   (id)')
-	do_query(query, 'ALTER TABLE  context_switches '
-					'ADD CONSTRAINT machinefk   FOREIGN KEY (machine_id)    REFERENCES ma=
chines (id),'
-					'ADD CONSTRAINT toutfk      FOREIGN KEY (thread_out_id) REFERENCES th=
reads  (id),'
-					'ADD CONSTRAINT tinfk       FOREIGN KEY (thread_in_id)  REFERENCES th=
reads  (id),'
-					'ADD CONSTRAINT coutfk      FOREIGN KEY (comm_out_id)   REFERENCES co=
mms    (id),'
-					'ADD CONSTRAINT cinfk       FOREIGN KEY (comm_in_id)    REFERENCES co=
mms    (id)')
-
-	printdate("Dropping unused tables")
-	if is_table_empty("ptwrite"):
-		drop("ptwrite")
-	if is_table_empty("mwait") and is_table_empty("pwre") and is_table_empty(=
"exstop") and is_table_empty("pwrx"):
-		do_query(query, 'DROP VIEW power_events_view');
-		drop("mwait")
-		drop("pwre")
-		drop("exstop")
-		drop("pwrx")
-		if is_table_empty("cbr"):
-			drop("cbr")
-	if is_table_empty("context_switches"):
-		drop("context_switches")
-
-	if (unhandled_count):
-		printdate("Warning: ", unhandled_count, " unhandled events")
-	printdate("Done")
-
-def trace_unhandled(event_name, context, event_fields_dict):
-	global unhandled_count
-	unhandled_count +=3D 1
-
-def sched__sched_switch(*x):
-	pass
-
-def evsel_table(evsel_id, evsel_name, *x):
-	evsel_name =3D toserverstr(evsel_name)
-	n =3D len(evsel_name)
-	fmt =3D "!hiqi" + str(n) + "s"
-	value =3D struct.pack(fmt, 2, 8, evsel_id, n, evsel_name)
-	evsel_file.write(value)
-
-def machine_table(machine_id, pid, root_dir, *x):
-	root_dir =3D toserverstr(root_dir)
-	n =3D len(root_dir)
-	fmt =3D "!hiqiii" + str(n) + "s"
-	value =3D struct.pack(fmt, 3, 8, machine_id, 4, pid, n, root_dir)
-	machine_file.write(value)
-
-def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
-	value =3D struct.pack("!hiqiqiqiiii", 5, 8, thread_id, 8, machine_id, 8, =
process_id, 4, pid, 4, tid)
-	thread_file.write(value)
-
-def comm_table(comm_id, comm_str, thread_id, time, exec_flag, *x):
-	comm_str =3D toserverstr(comm_str)
-	n =3D len(comm_str)
-	fmt =3D "!hiqi" + str(n) + "s" + "iqiqiB"
-	value =3D struct.pack(fmt, 5, 8, comm_id, n, comm_str, 8, thread_id, 8, t=
ime, 1, exec_flag)
-	comm_file.write(value)
-
-def comm_thread_table(comm_thread_id, comm_id, thread_id, *x):
-	fmt =3D "!hiqiqiq"
-	value =3D struct.pack(fmt, 3, 8, comm_thread_id, 8, comm_id, 8, thread_id=
)
-	comm_thread_file.write(value)
-
-def dso_table(dso_id, machine_id, short_name, long_name, build_id, *x):
-	short_name =3D toserverstr(short_name)
-	long_name =3D toserverstr(long_name)
-	build_id =3D toserverstr(build_id)
-	n1 =3D len(short_name)
-	n2 =3D len(long_name)
-	n3 =3D len(build_id)
-	fmt =3D "!hiqiqi" + str(n1) + "si"  + str(n2) + "si" + str(n3) + "s"
-	value =3D struct.pack(fmt, 5, 8, dso_id, 8, machine_id, n1, short_name, n=
2, long_name, n3, build_id)
-	dso_file.write(value)
-
-def symbol_table(symbol_id, dso_id, sym_start, sym_end, binding, symbol_na=
me, *x):
-	symbol_name =3D toserverstr(symbol_name)
-	n =3D len(symbol_name)
-	fmt =3D "!hiqiqiqiqiii" + str(n) + "s"
-	value =3D struct.pack(fmt, 6, 8, symbol_id, 8, dso_id, 8, sym_start, 8, s=
ym_end, 4, binding, n, symbol_name)
-	symbol_file.write(value)
-
-def branch_type_table(branch_type, name, *x):
-	name =3D toserverstr(name)
-	n =3D len(name)
-	fmt =3D "!hiii" + str(n) + "s"
-	value =3D struct.pack(fmt, 2, 4, branch_type, n, name)
-	branch_type_file.write(value)
-
-def sample_table(sample_id, evsel_id, machine_id, thread_id, comm_id, dso_=
id, symbol_id, sym_offset, ip, time, cpu, to_dso_id, to_symbol_id, to_sym_o=
ffset, to_ip, period, weight, transaction, data_src, branch_type, in_tx, ca=
ll_path_id, insn_cnt, cyc_cnt, flags, *x):
-	if branches:
-		value =3D struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiiiBiqiqiqii", 21=
, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, ds=
o_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8,=
 to_symbol_id, 8, to_sym_offset, 8, to_ip, 4, branch_type, 1, in_tx, 8, cal=
l_path_id, 8, insn_cnt, 8, cyc_cnt, 4, flags)
-	else:
-		value =3D struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiqiqiqiqiiiBiqiqi=
qii", 25, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_i=
d, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_ds=
o_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 8, period, 8, weight, 8,=
 transaction, 8, data_src, 4, branch_type, 1, in_tx, 8, call_path_id, 8, in=
sn_cnt, 8, cyc_cnt, 4, flags)
-	sample_file.write(value)
-
-def call_path_table(cp_id, parent_id, symbol_id, ip, *x):
-	fmt =3D "!hiqiqiqiq"
-	value =3D struct.pack(fmt, 4, 8, cp_id, 8, parent_id, 8, symbol_id, 8, ip=
)
-	call_path_file.write(value)
-
-def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, =
return_time, branch_count, call_id, return_id, parent_call_path_id, flags, =
parent_id, insn_cnt, cyc_cnt, *x):
-	fmt =3D "!hiqiqiqiqiqiqiqiqiqiqiiiqiqiq"
-	value =3D struct.pack(fmt, 14, 8, cr_id, 8, thread_id, 8, comm_id, 8, cal=
l_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, re=
turn_id, 8, parent_call_path_id, 4, flags, 8, parent_id, 8, insn_cnt, 8, cy=
c_cnt)
-	call_file.write(value)
-
-def ptwrite(id, raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	flags =3D data[0]
-	payload =3D data[1]
-	exact_ip =3D flags & 1
-	value =3D struct.pack("!hiqiqiB", 3, 8, id, 8, payload, 1, exact_ip)
-	ptwrite_file.write(value)
-
-def cbr(id, raw_buf):
-	data =3D struct.unpack_from("<BBBBII", raw_buf)
-	cbr =3D data[0]
-	MHz =3D (data[4] + 500) / 1000
-	percent =3D ((cbr * 1000 / data[2]) + 5) / 10
-	value =3D struct.pack("!hiqiiiiii", 4, 8, id, 4, cbr, 4, int(MHz), 4, int=
(percent))
-	cbr_file.write(value)
-
-def mwait(id, raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	payload =3D data[1]
-	hints =3D payload & 0xff
-	extensions =3D (payload >> 32) & 0x3
-	value =3D struct.pack("!hiqiiii", 3, 8, id, 4, hints, 4, extensions)
-	mwait_file.write(value)
-
-def pwre(id, raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	payload =3D data[1]
-	hw =3D (payload >> 7) & 1
-	cstate =3D (payload >> 12) & 0xf
-	subcstate =3D (payload >> 8) & 0xf
-	value =3D struct.pack("!hiqiiiiiB", 4, 8, id, 4, cstate, 4, subcstate, 1,=
 hw)
-	pwre_file.write(value)
-
-def exstop(id, raw_buf):
-	data =3D struct.unpack_from("<I", raw_buf)
-	flags =3D data[0]
-	exact_ip =3D flags & 1
-	value =3D struct.pack("!hiqiB", 2, 8, id, 1, exact_ip)
-	exstop_file.write(value)
-
-def pwrx(id, raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	payload =3D data[1]
-	deepest_cstate =3D payload & 0xf
-	last_cstate =3D (payload >> 4) & 0xf
-	wake_reason =3D (payload >> 8) & 0xf
-	value =3D struct.pack("!hiqiiiiii", 4, 8, id, 4, deepest_cstate, 4, last_=
cstate, 4, wake_reason)
-	pwrx_file.write(value)
-
-def synth_data(id, config, raw_buf, *x):
-	if config =3D=3D 0:
-		ptwrite(id, raw_buf)
-	elif config =3D=3D 1:
-		mwait(id, raw_buf)
-	elif config =3D=3D 2:
-		pwre(id, raw_buf)
-	elif config =3D=3D 3:
-		exstop(id, raw_buf)
-	elif config =3D=3D 4:
-		pwrx(id, raw_buf)
-	elif config =3D=3D 5:
-		cbr(id, raw_buf)
-
-def context_switch_table(id, machine_id, time, cpu, thread_out_id, comm_ou=
t_id, thread_in_id, comm_in_id, flags, *x):
-	fmt =3D "!hiqiqiqiiiqiqiqiqii"
-	value =3D struct.pack(fmt, 9, 8, id, 8, machine_id, 8, time, 4, cpu, 8, t=
hread_out_id, 8, comm_out_id, 8, thread_in_id, 8, comm_in_id, 4, flags)
-	context_switches_file.write(value)
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scr=
ipts/python/export-to-sqlite.py
deleted file mode 100644
index 73c992feb1b9..000000000000
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ /dev/null
@@ -1,799 +0,0 @@
-# export-to-sqlite.py: export perf data to a sqlite3 database
-# Copyright (c) 2017, Intel Corporation.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms and conditions of the GNU General Public License,
-# version 2, as published by the Free Software Foundation.
-#
-# This program is distributed in the hope it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License fo=
r
-# more details.
-
-from __future__ import print_function
-
-import os
-import sys
-import struct
-import datetime
-
-# To use this script you will need to have installed package python-pyside=
 which
-# provides LGPL-licensed Python bindings for Qt.  You will also need the p=
ackage
-# libqt4-sql-sqlite for Qt sqlite3 support.
-#
-# Examples of installing pyside:
-#
-# ubuntu:
-#
-#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
-#
-#	Alternately, to use Python3 and/or pyside 2, one of the following:
-#
-#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
-#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
-#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
-# fedora:
-#
-#	$ sudo yum install python-pyside
-#
-#	Alternately, to use Python3 and/or pyside 2, one of the following:
-#		$ sudo yum install python3-pyside
-#		$ pip install --user PySide2
-#		$ pip3 install --user PySide2
-#
-# An example of using this script with Intel PT:
-#
-#	$ perf record -e intel_pt//u ls
-#	$ perf script -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py =
pt_example branches calls
-#	2017-07-31 14:26:07.326913 Creating database...
-#	2017-07-31 14:26:07.538097 Writing records...
-#	2017-07-31 14:26:09.889292 Adding indexes
-#	2017-07-31 14:26:09.958746 Done
-#
-# To browse the database, sqlite3 can be used e.g.
-#
-#	$ sqlite3 pt_example
-#	sqlite> .header on
-#	sqlite> select * from samples_view where id < 10;
-#	sqlite> .mode column
-#	sqlite> select * from samples_view where id < 10;
-#	sqlite> .tables
-#	sqlite> .schema samples_view
-#	sqlite> .quit
-#
-# An example of using the database is provided by the script
-# exported-sql-viewer.py.  Refer to that script for details.
-#
-# The database structure is practically the same as created by the script
-# export-to-postgresql.py. Refer to that script for details.  A notable
-# difference is  the 'transaction' column of the 'samples' table which is
-# renamed 'transaction_' in sqlite because 'transaction' is a reserved wor=
d.
-
-pyside_version_1 =3D True
-if not "pyside-version-1" in sys.argv:
-	try:
-		from PySide2.QtSql import *
-		pyside_version_1 =3D False
-	except:
-		pass
-
-if pyside_version_1:
-	from PySide.QtSql import *
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-# These perf imports are not used at present
-#from perf_trace_context import *
-#from Core import *
-
-perf_db_export_mode =3D True
-perf_db_export_calls =3D False
-perf_db_export_callchains =3D False
-
-def printerr(*args, **keyword_args):
-	print(*args, file=3Dsys.stderr, **keyword_args)
-
-def printdate(*args, **kw_args):
-        print(datetime.datetime.today(), *args, sep=3D' ', **kw_args)
-
-def usage():
-	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<cal=
ls>] [<callchains>] [<pyside-version-1>]");
-	printerr("where:  columns            'all' or 'branches'");
-	printerr("        calls              'calls' =3D> create calls and call_p=
aths table");
-	printerr("        callchains         'callchains' =3D> create call_paths =
table");
-	printerr("        pyside-version-1   'pyside-version-1' =3D> use pyside v=
ersion 1");
-	raise Exception("Too few or bad arguments")
-
-if (len(sys.argv) < 2):
-	usage()
-
-dbname =3D sys.argv[1]
-
-if (len(sys.argv) >=3D 3):
-	columns =3D sys.argv[2]
-else:
-	columns =3D "all"
-
-if columns not in ("all", "branches"):
-	usage()
-
-branches =3D (columns =3D=3D "branches")
-
-for i in range(3,len(sys.argv)):
-	if (sys.argv[i] =3D=3D "calls"):
-		perf_db_export_calls =3D True
-	elif (sys.argv[i] =3D=3D "callchains"):
-		perf_db_export_callchains =3D True
-	elif (sys.argv[i] =3D=3D "pyside-version-1"):
-		pass
-	else:
-		usage()
-
-def do_query(q, s):
-	if (q.exec_(s)):
-		return
-	raise Exception("Query failed: " + q.lastError().text())
-
-def do_query_(q):
-	if (q.exec_()):
-		return
-	raise Exception("Query failed: " + q.lastError().text())
-
-printdate("Creating database ...")
-
-db_exists =3D False
-try:
-	f =3D open(dbname)
-	f.close()
-	db_exists =3D True
-except:
-	pass
-
-if db_exists:
-	raise Exception(dbname + " already exists")
-
-db =3D QSqlDatabase.addDatabase('QSQLITE')
-db.setDatabaseName(dbname)
-db.open()
-
-query =3D QSqlQuery(db)
-
-do_query(query, 'PRAGMA journal_mode =3D OFF')
-do_query(query, 'BEGIN TRANSACTION')
-
-do_query(query, 'CREATE TABLE selected_events ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'name		varchar(80))')
-do_query(query, 'CREATE TABLE machines ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'pid		integer,'
-		'root_dir 	varchar(4096))')
-do_query(query, 'CREATE TABLE threads ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'machine_id	bigint,'
-		'process_id	bigint,'
-		'pid		integer,'
-		'tid		integer)')
-do_query(query, 'CREATE TABLE comms ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'comm		varchar(16),'
-		'c_thread_id	bigint,'
-		'c_time		bigint,'
-		'exec_flag	boolean)')
-do_query(query, 'CREATE TABLE comm_threads ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'comm_id	bigint,'
-		'thread_id	bigint)')
-do_query(query, 'CREATE TABLE dsos ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'machine_id	bigint,'
-		'short_name	varchar(256),'
-		'long_name	varchar(4096),'
-		'build_id	varchar(64))')
-do_query(query, 'CREATE TABLE symbols ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'dso_id		bigint,'
-		'sym_start	bigint,'
-		'sym_end	bigint,'
-		'binding	integer,'
-		'name		varchar(2048))')
-do_query(query, 'CREATE TABLE branch_types ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'name		varchar(80))')
-
-if branches:
-	do_query(query, 'CREATE TABLE samples ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'evsel_id	bigint,'
-		'machine_id	bigint,'
-		'thread_id	bigint,'
-		'comm_id	bigint,'
-		'dso_id		bigint,'
-		'symbol_id	bigint,'
-		'sym_offset	bigint,'
-		'ip		bigint,'
-		'time		bigint,'
-		'cpu		integer,'
-		'to_dso_id	bigint,'
-		'to_symbol_id	bigint,'
-		'to_sym_offset	bigint,'
-		'to_ip		bigint,'
-		'branch_type	integer,'
-		'in_tx		boolean,'
-		'call_path_id	bigint,'
-		'insn_count	bigint,'
-		'cyc_count	bigint,'
-		'flags		integer)')
-else:
-	do_query(query, 'CREATE TABLE samples ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'evsel_id	bigint,'
-		'machine_id	bigint,'
-		'thread_id	bigint,'
-		'comm_id	bigint,'
-		'dso_id		bigint,'
-		'symbol_id	bigint,'
-		'sym_offset	bigint,'
-		'ip		bigint,'
-		'time		bigint,'
-		'cpu		integer,'
-		'to_dso_id	bigint,'
-		'to_symbol_id	bigint,'
-		'to_sym_offset	bigint,'
-		'to_ip		bigint,'
-		'period		bigint,'
-		'weight		bigint,'
-		'transaction_	bigint,'
-		'data_src	bigint,'
-		'branch_type	integer,'
-		'in_tx		boolean,'
-		'call_path_id	bigint,'
-		'insn_count	bigint,'
-		'cyc_count	bigint,'
-		'flags		integer)')
-
-if perf_db_export_calls or perf_db_export_callchains:
-	do_query(query, 'CREATE TABLE call_paths ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'parent_id	bigint,'
-		'symbol_id	bigint,'
-		'ip		bigint)')
-if perf_db_export_calls:
-	do_query(query, 'CREATE TABLE calls ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'thread_id	bigint,'
-		'comm_id	bigint,'
-		'call_path_id	bigint,'
-		'call_time	bigint,'
-		'return_time	bigint,'
-		'branch_count	bigint,'
-		'call_id	bigint,'
-		'return_id	bigint,'
-		'parent_call_path_id	bigint,'
-		'flags		integer,'
-		'parent_id	bigint,'
-		'insn_count	bigint,'
-		'cyc_count	bigint)')
-
-do_query(query, 'CREATE TABLE ptwrite ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'payload	bigint,'
-		'exact_ip	integer)')
-
-do_query(query, 'CREATE TABLE cbr ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'cbr		integer,'
-		'mhz		integer,'
-		'percent	integer)')
-
-do_query(query, 'CREATE TABLE mwait ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'hints		integer,'
-		'extensions	integer)')
-
-do_query(query, 'CREATE TABLE pwre ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'cstate		integer,'
-		'subcstate	integer,'
-		'hw		integer)')
-
-do_query(query, 'CREATE TABLE exstop ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'exact_ip	integer)')
-
-do_query(query, 'CREATE TABLE pwrx ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'deepest_cstate	integer,'
-		'last_cstate	integer,'
-		'wake_reason	integer)')
-
-do_query(query, 'CREATE TABLE context_switches ('
-		'id		integer		NOT NULL	PRIMARY KEY,'
-		'machine_id	bigint,'
-		'time		bigint,'
-		'cpu		integer,'
-		'thread_out_id	bigint,'
-		'comm_out_id	bigint,'
-		'thread_in_id	bigint,'
-		'comm_in_id	bigint,'
-		'flags		integer)')
-
-# printf was added to sqlite in version 3.8.3
-sqlite_has_printf =3D False
-try:
-	do_query(query, 'SELECT printf("") FROM machines')
-	sqlite_has_printf =3D True
-except:
-	pass
-
-def emit_to_hex(x):
-	if sqlite_has_printf:
-		return 'printf("%x", ' + x + ')'
-	else:
-		return x
-
-do_query(query, 'CREATE VIEW machines_view AS '
-	'SELECT '
-		'id,'
-		'pid,'
-		'root_dir,'
-		'CASE WHEN id=3D0 THEN \'unknown\' WHEN pid=3D-1 THEN \'host\' ELSE \'gu=
est\' END AS host_or_guest'
-	' FROM machines')
-
-do_query(query, 'CREATE VIEW dsos_view AS '
-	'SELECT '
-		'id,'
-		'machine_id,'
-		'(SELECT host_or_guest FROM machines_view WHERE id =3D machine_id) AS ho=
st_or_guest,'
-		'short_name,'
-		'long_name,'
-		'build_id'
-	' FROM dsos')
-
-do_query(query, 'CREATE VIEW symbols_view AS '
-	'SELECT '
-		'id,'
-		'name,'
-		'(SELECT short_name FROM dsos WHERE id=3Ddso_id) AS dso,'
-		'dso_id,'
-		'sym_start,'
-		'sym_end,'
-		'CASE WHEN binding=3D0 THEN \'local\' WHEN binding=3D1 THEN \'global\' E=
LSE \'weak\' END AS binding'
-	' FROM symbols')
-
-do_query(query, 'CREATE VIEW threads_view AS '
-	'SELECT '
-		'id,'
-		'machine_id,'
-		'(SELECT host_or_guest FROM machines_view WHERE id =3D machine_id) AS ho=
st_or_guest,'
-		'process_id,'
-		'pid,'
-		'tid'
-	' FROM threads')
-
-do_query(query, 'CREATE VIEW comm_threads_view AS '
-	'SELECT '
-		'comm_id,'
-		'(SELECT comm FROM comms WHERE id =3D comm_id) AS command,'
-		'thread_id,'
-		'(SELECT pid FROM threads WHERE id =3D thread_id) AS pid,'
-		'(SELECT tid FROM threads WHERE id =3D thread_id) AS tid'
-	' FROM comm_threads')
-
-if perf_db_export_calls or perf_db_export_callchains:
-	do_query(query, 'CREATE VIEW call_paths_view AS '
-		'SELECT '
-			'c.id,'
-			+ emit_to_hex('c.ip') + ' AS ip,'
-			'c.symbol_id,'
-			'(SELECT name FROM symbols WHERE id =3D c.symbol_id) AS symbol,'
-			'(SELECT dso_id FROM symbols WHERE id =3D c.symbol_id) AS dso_id,'
-			'(SELECT dso FROM symbols_view  WHERE id =3D c.symbol_id) AS dso_short_=
name,'
-			'c.parent_id,'
-			+ emit_to_hex('p.ip') + ' AS parent_ip,'
-			'p.symbol_id AS parent_symbol_id,'
-			'(SELECT name FROM symbols WHERE id =3D p.symbol_id) AS parent_symbol,'
-			'(SELECT dso_id FROM symbols WHERE id =3D p.symbol_id) AS parent_dso_id=
,'
-			'(SELECT dso FROM symbols_view  WHERE id =3D p.symbol_id) AS parent_dso=
_short_name'
-		' FROM call_paths c INNER JOIN call_paths p ON p.id =3D c.parent_id')
-if perf_db_export_calls:
-	do_query(query, 'CREATE VIEW calls_view AS '
-		'SELECT '
-			'calls.id,'
-			'thread_id,'
-			'(SELECT pid FROM threads WHERE id =3D thread_id) AS pid,'
-			'(SELECT tid FROM threads WHERE id =3D thread_id) AS tid,'
-			'(SELECT comm FROM comms WHERE id =3D comm_id) AS command,'
-			'call_path_id,'
-			+ emit_to_hex('ip') + ' AS ip,'
-			'symbol_id,'
-			'(SELECT name FROM symbols WHERE id =3D symbol_id) AS symbol,'
-			'call_time,'
-			'return_time,'
-			'return_time - call_time AS elapsed_time,'
-			'branch_count,'
-			'insn_count,'
-			'cyc_count,'
-			'CASE WHEN cyc_count=3D0 THEN CAST(0 AS FLOAT) ELSE ROUND(CAST(insn_cou=
nt AS FLOAT) / cyc_count, 2) END AS IPC,'
-			'call_id,'
-			'return_id,'
-			'CASE WHEN flags=3D0 THEN \'\' WHEN flags=3D1 THEN \'no call\' WHEN fla=
gs=3D2 THEN \'no return\' WHEN flags=3D3 THEN \'no call/return\' WHEN flags=
=3D6 THEN \'jump\' ELSE flags END AS flags,'
-			'parent_call_path_id,'
-			'calls.parent_id'
-		' FROM calls INNER JOIN call_paths ON call_paths.id =3D call_path_id')
-
-do_query(query, 'CREATE VIEW samples_view AS '
-	'SELECT '
-		'id,'
-		'time,'
-		'cpu,'
-		'(SELECT pid FROM threads WHERE id =3D thread_id) AS pid,'
-		'(SELECT tid FROM threads WHERE id =3D thread_id) AS tid,'
-		'(SELECT comm FROM comms WHERE id =3D comm_id) AS command,'
-		'(SELECT name FROM selected_events WHERE id =3D evsel_id) AS event,'
-		+ emit_to_hex('ip') + ' AS ip_hex,'
-		'(SELECT name FROM symbols WHERE id =3D symbol_id) AS symbol,'
-		'sym_offset,'
-		'(SELECT short_name FROM dsos WHERE id =3D dso_id) AS dso_short_name,'
-		+ emit_to_hex('to_ip') + ' AS to_ip_hex,'
-		'(SELECT name FROM symbols WHERE id =3D to_symbol_id) AS to_symbol,'
-		'to_sym_offset,'
-		'(SELECT short_name FROM dsos WHERE id =3D to_dso_id) AS to_dso_short_na=
me,'
-		'(SELECT name FROM branch_types WHERE id =3D branch_type) AS branch_type=
_name,'
-		'in_tx,'
-		'insn_count,'
-		'cyc_count,'
-		'CASE WHEN cyc_count=3D0 THEN CAST(0 AS FLOAT) ELSE ROUND(CAST(insn_coun=
t AS FLOAT) / cyc_count, 2) END AS IPC,'
-		'flags'
-	' FROM samples')
-
-do_query(query, 'CREATE VIEW ptwrite_view AS '
-	'SELECT '
-		'ptwrite.id,'
-		'time,'
-		'cpu,'
-		+ emit_to_hex('payload') + ' AS payload_hex,'
-		'CASE WHEN exact_ip=3D0 THEN \'False\' ELSE \'True\' END AS exact_ip'
-	' FROM ptwrite'
-	' INNER JOIN samples ON samples.id =3D ptwrite.id')
-
-do_query(query, 'CREATE VIEW cbr_view AS '
-	'SELECT '
-		'cbr.id,'
-		'time,'
-		'cpu,'
-		'cbr,'
-		'mhz,'
-		'percent'
-	' FROM cbr'
-	' INNER JOIN samples ON samples.id =3D cbr.id')
-
-do_query(query, 'CREATE VIEW mwait_view AS '
-	'SELECT '
-		'mwait.id,'
-		'time,'
-		'cpu,'
-		+ emit_to_hex('hints') + ' AS hints_hex,'
-		+ emit_to_hex('extensions') + ' AS extensions_hex'
-	' FROM mwait'
-	' INNER JOIN samples ON samples.id =3D mwait.id')
-
-do_query(query, 'CREATE VIEW pwre_view AS '
-	'SELECT '
-		'pwre.id,'
-		'time,'
-		'cpu,'
-		'cstate,'
-		'subcstate,'
-		'CASE WHEN hw=3D0 THEN \'False\' ELSE \'True\' END AS hw'
-	' FROM pwre'
-	' INNER JOIN samples ON samples.id =3D pwre.id')
-
-do_query(query, 'CREATE VIEW exstop_view AS '
-	'SELECT '
-		'exstop.id,'
-		'time,'
-		'cpu,'
-		'CASE WHEN exact_ip=3D0 THEN \'False\' ELSE \'True\' END AS exact_ip'
-	' FROM exstop'
-	' INNER JOIN samples ON samples.id =3D exstop.id')
-
-do_query(query, 'CREATE VIEW pwrx_view AS '
-	'SELECT '
-		'pwrx.id,'
-		'time,'
-		'cpu,'
-		'deepest_cstate,'
-		'last_cstate,'
-		'CASE     WHEN wake_reason=3D1 THEN \'Interrupt\''
-			' WHEN wake_reason=3D2 THEN \'Timer Deadline\''
-			' WHEN wake_reason=3D4 THEN \'Monitored Address\''
-			' WHEN wake_reason=3D8 THEN \'HW\''
-			' ELSE wake_reason '
-		'END AS wake_reason'
-	' FROM pwrx'
-	' INNER JOIN samples ON samples.id =3D pwrx.id')
-
-do_query(query, 'CREATE VIEW power_events_view AS '
-	'SELECT '
-		'samples.id,'
-		'time,'
-		'cpu,'
-		'selected_events.name AS event,'
-		'CASE WHEN selected_events.name=3D\'cbr\' THEN (SELECT cbr FROM cbr WHER=
E cbr.id =3D samples.id) ELSE "" END AS cbr,'
-		'CASE WHEN selected_events.name=3D\'cbr\' THEN (SELECT mhz FROM cbr WHER=
E cbr.id =3D samples.id) ELSE "" END AS mhz,'
-		'CASE WHEN selected_events.name=3D\'cbr\' THEN (SELECT percent FROM cbr =
WHERE cbr.id =3D samples.id) ELSE "" END AS percent,'
-		'CASE WHEN selected_events.name=3D\'mwait\' THEN (SELECT ' + emit_to_hex=
('hints') + ' FROM mwait WHERE mwait.id =3D samples.id) ELSE "" END AS hint=
s_hex,'
-		'CASE WHEN selected_events.name=3D\'mwait\' THEN (SELECT ' + emit_to_hex=
('extensions') + ' FROM mwait WHERE mwait.id =3D samples.id) ELSE "" END AS=
 extensions_hex,'
-		'CASE WHEN selected_events.name=3D\'pwre\' THEN (SELECT cstate FROM pwre=
 WHERE pwre.id =3D samples.id) ELSE "" END AS cstate,'
-		'CASE WHEN selected_events.name=3D\'pwre\' THEN (SELECT subcstate FROM p=
wre WHERE pwre.id =3D samples.id) ELSE "" END AS subcstate,'
-		'CASE WHEN selected_events.name=3D\'pwre\' THEN (SELECT hw FROM pwre WHE=
RE pwre.id =3D samples.id) ELSE "" END AS hw,'
-		'CASE WHEN selected_events.name=3D\'exstop\' THEN (SELECT exact_ip FROM =
exstop WHERE exstop.id =3D samples.id) ELSE "" END AS exact_ip,'
-		'CASE WHEN selected_events.name=3D\'pwrx\' THEN (SELECT deepest_cstate F=
ROM pwrx WHERE pwrx.id =3D samples.id) ELSE "" END AS deepest_cstate,'
-		'CASE WHEN selected_events.name=3D\'pwrx\' THEN (SELECT last_cstate FROM=
 pwrx WHERE pwrx.id =3D samples.id) ELSE "" END AS last_cstate,'
-		'CASE WHEN selected_events.name=3D\'pwrx\' THEN (SELECT '
-			'CASE     WHEN wake_reason=3D1 THEN \'Interrupt\''
-				' WHEN wake_reason=3D2 THEN \'Timer Deadline\''
-				' WHEN wake_reason=3D4 THEN \'Monitored Address\''
-				' WHEN wake_reason=3D8 THEN \'HW\''
-				' ELSE wake_reason '
-			'END'
-		' FROM pwrx WHERE pwrx.id =3D samples.id) ELSE "" END AS wake_reason'
-	' FROM samples'
-	' INNER JOIN selected_events ON selected_events.id =3D evsel_id'
-	' WHERE selected_events.name IN (\'cbr\',\'mwait\',\'exstop\',\'pwre\',\'=
pwrx\')')
-
-do_query(query, 'CREATE VIEW context_switches_view AS '
-	'SELECT '
-		'context_switches.id,'
-		'context_switches.machine_id,'
-		'context_switches.time,'
-		'context_switches.cpu,'
-		'th_out.pid AS pid_out,'
-		'th_out.tid AS tid_out,'
-		'comm_out.comm AS comm_out,'
-		'th_in.pid AS pid_in,'
-		'th_in.tid AS tid_in,'
-		'comm_in.comm AS comm_in,'
-		'CASE	  WHEN context_switches.flags =3D 0 THEN \'in\''
-			' WHEN context_switches.flags =3D 1 THEN \'out\''
-			' WHEN context_switches.flags =3D 3 THEN \'out preempt\''
-			' ELSE context_switches.flags '
-		'END AS flags'
-	' FROM context_switches'
-	' INNER JOIN threads AS th_out ON th_out.id   =3D context_switches.thread=
_out_id'
-	' INNER JOIN threads AS th_in  ON th_in.id    =3D context_switches.thread=
_in_id'
-	' INNER JOIN comms AS comm_out ON comm_out.id =3D context_switches.comm_o=
ut_id'
-	' INNER JOIN comms AS comm_in  ON comm_in.id  =3D context_switches.comm_i=
n_id')
-
-do_query(query, 'END TRANSACTION')
-
-evsel_query =3D QSqlQuery(db)
-evsel_query.prepare("INSERT INTO selected_events VALUES (?, ?)")
-machine_query =3D QSqlQuery(db)
-machine_query.prepare("INSERT INTO machines VALUES (?, ?, ?)")
-thread_query =3D QSqlQuery(db)
-thread_query.prepare("INSERT INTO threads VALUES (?, ?, ?, ?, ?)")
-comm_query =3D QSqlQuery(db)
-comm_query.prepare("INSERT INTO comms VALUES (?, ?, ?, ?, ?)")
-comm_thread_query =3D QSqlQuery(db)
-comm_thread_query.prepare("INSERT INTO comm_threads VALUES (?, ?, ?)")
-dso_query =3D QSqlQuery(db)
-dso_query.prepare("INSERT INTO dsos VALUES (?, ?, ?, ?, ?)")
-symbol_query =3D QSqlQuery(db)
-symbol_query.prepare("INSERT INTO symbols VALUES (?, ?, ?, ?, ?, ?)")
-branch_type_query =3D QSqlQuery(db)
-branch_type_query.prepare("INSERT INTO branch_types VALUES (?, ?)")
-sample_query =3D QSqlQuery(db)
-if branches:
-	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?,=
 ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
-else:
-	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?,=
 ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
-if perf_db_export_calls or perf_db_export_callchains:
-	call_path_query =3D QSqlQuery(db)
-	call_path_query.prepare("INSERT INTO call_paths VALUES (?, ?, ?, ?)")
-if perf_db_export_calls:
-	call_query =3D QSqlQuery(db)
-	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, =
?, ?, ?, ?, ?)")
-ptwrite_query =3D QSqlQuery(db)
-ptwrite_query.prepare("INSERT INTO ptwrite VALUES (?, ?, ?)")
-cbr_query =3D QSqlQuery(db)
-cbr_query.prepare("INSERT INTO cbr VALUES (?, ?, ?, ?)")
-mwait_query =3D QSqlQuery(db)
-mwait_query.prepare("INSERT INTO mwait VALUES (?, ?, ?)")
-pwre_query =3D QSqlQuery(db)
-pwre_query.prepare("INSERT INTO pwre VALUES (?, ?, ?, ?)")
-exstop_query =3D QSqlQuery(db)
-exstop_query.prepare("INSERT INTO exstop VALUES (?, ?)")
-pwrx_query =3D QSqlQuery(db)
-pwrx_query.prepare("INSERT INTO pwrx VALUES (?, ?, ?, ?)")
-context_switch_query =3D QSqlQuery(db)
-context_switch_query.prepare("INSERT INTO context_switches VALUES (?, ?, ?=
, ?, ?, ?, ?, ?, ?)")
-
-def trace_begin():
-	printdate("Writing records...")
-	do_query(query, 'BEGIN TRANSACTION')
-	# id =3D=3D 0 means unknown.  It is easier to create records for them tha=
n replace the zeroes with NULLs
-	evsel_table(0, "unknown")
-	machine_table(0, 0, "unknown")
-	thread_table(0, 0, 0, -1, -1)
-	comm_table(0, "unknown", 0, 0, 0)
-	dso_table(0, 0, "unknown", "unknown", "")
-	symbol_table(0, 0, 0, 0, 0, "unknown")
-	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, =
0, 0, 0, 0, 0)
-	if perf_db_export_calls or perf_db_export_callchains:
-		call_path_table(0, 0, 0, 0)
-		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
-
-unhandled_count =3D 0
-
-def is_table_empty(table_name):
-	do_query(query, 'SELECT * FROM ' + table_name + ' LIMIT 1');
-	if query.next():
-		return False
-	return True
-
-def drop(table_name):
-	do_query(query, 'DROP VIEW ' + table_name + '_view');
-	do_query(query, 'DROP TABLE ' + table_name);
-
-def trace_end():
-	do_query(query, 'END TRANSACTION')
-
-	printdate("Adding indexes")
-	if perf_db_export_calls:
-		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
-		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
-		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
-		do_query(query, 'UPDATE comms SET has_calls =3D 1 WHERE comms.id IN (SEL=
ECT DISTINCT comm_id FROM calls)')
-
-	printdate("Dropping unused tables")
-	if is_table_empty("ptwrite"):
-		drop("ptwrite")
-	if is_table_empty("mwait") and is_table_empty("pwre") and is_table_empty(=
"exstop") and is_table_empty("pwrx"):
-		do_query(query, 'DROP VIEW power_events_view');
-		drop("mwait")
-		drop("pwre")
-		drop("exstop")
-		drop("pwrx")
-		if is_table_empty("cbr"):
-			drop("cbr")
-	if is_table_empty("context_switches"):
-		drop("context_switches")
-
-	if (unhandled_count):
-		printdate("Warning: ", unhandled_count, " unhandled events")
-	printdate("Done")
-
-def trace_unhandled(event_name, context, event_fields_dict):
-	global unhandled_count
-	unhandled_count +=3D 1
-
-def sched__sched_switch(*x):
-	pass
-
-def bind_exec(q, n, x):
-	for xx in x[0:n]:
-		q.addBindValue(str(xx))
-	do_query_(q)
-
-def evsel_table(*x):
-	bind_exec(evsel_query, 2, x)
-
-def machine_table(*x):
-	bind_exec(machine_query, 3, x)
-
-def thread_table(*x):
-	bind_exec(thread_query, 5, x)
-
-def comm_table(*x):
-	bind_exec(comm_query, 5, x)
-
-def comm_thread_table(*x):
-	bind_exec(comm_thread_query, 3, x)
-
-def dso_table(*x):
-	bind_exec(dso_query, 5, x)
-
-def symbol_table(*x):
-	bind_exec(symbol_query, 6, x)
-
-def branch_type_table(*x):
-	bind_exec(branch_type_query, 2, x)
-
-def sample_table(*x):
-	if branches:
-		for xx in x[0:15]:
-			sample_query.addBindValue(str(xx))
-		for xx in x[19:25]:
-			sample_query.addBindValue(str(xx))
-		do_query_(sample_query)
-	else:
-		bind_exec(sample_query, 25, x)
-
-def call_path_table(*x):
-	bind_exec(call_path_query, 4, x)
-
-def call_return_table(*x):
-	bind_exec(call_query, 14, x)
-
-def ptwrite(id, raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	flags =3D data[0]
-	payload =3D data[1]
-	exact_ip =3D flags & 1
-	ptwrite_query.addBindValue(str(id))
-	ptwrite_query.addBindValue(str(payload))
-	ptwrite_query.addBindValue(str(exact_ip))
-	do_query_(ptwrite_query)
-
-def cbr(id, raw_buf):
-	data =3D struct.unpack_from("<BBBBII", raw_buf)
-	cbr =3D data[0]
-	MHz =3D (data[4] + 500) / 1000
-	percent =3D ((cbr * 1000 / data[2]) + 5) / 10
-	cbr_query.addBindValue(str(id))
-	cbr_query.addBindValue(str(cbr))
-	cbr_query.addBindValue(str(MHz))
-	cbr_query.addBindValue(str(percent))
-	do_query_(cbr_query)
-
-def mwait(id, raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	payload =3D data[1]
-	hints =3D payload & 0xff
-	extensions =3D (payload >> 32) & 0x3
-	mwait_query.addBindValue(str(id))
-	mwait_query.addBindValue(str(hints))
-	mwait_query.addBindValue(str(extensions))
-	do_query_(mwait_query)
-
-def pwre(id, raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	payload =3D data[1]
-	hw =3D (payload >> 7) & 1
-	cstate =3D (payload >> 12) & 0xf
-	subcstate =3D (payload >> 8) & 0xf
-	pwre_query.addBindValue(str(id))
-	pwre_query.addBindValue(str(cstate))
-	pwre_query.addBindValue(str(subcstate))
-	pwre_query.addBindValue(str(hw))
-	do_query_(pwre_query)
-
-def exstop(id, raw_buf):
-	data =3D struct.unpack_from("<I", raw_buf)
-	flags =3D data[0]
-	exact_ip =3D flags & 1
-	exstop_query.addBindValue(str(id))
-	exstop_query.addBindValue(str(exact_ip))
-	do_query_(exstop_query)
-
-def pwrx(id, raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	payload =3D data[1]
-	deepest_cstate =3D payload & 0xf
-	last_cstate =3D (payload >> 4) & 0xf
-	wake_reason =3D (payload >> 8) & 0xf
-	pwrx_query.addBindValue(str(id))
-	pwrx_query.addBindValue(str(deepest_cstate))
-	pwrx_query.addBindValue(str(last_cstate))
-	pwrx_query.addBindValue(str(wake_reason))
-	do_query_(pwrx_query)
-
-def synth_data(id, config, raw_buf, *x):
-	if config =3D=3D 0:
-		ptwrite(id, raw_buf)
-	elif config =3D=3D 1:
-		mwait(id, raw_buf)
-	elif config =3D=3D 2:
-		pwre(id, raw_buf)
-	elif config =3D=3D 3:
-		exstop(id, raw_buf)
-	elif config =3D=3D 4:
-		pwrx(id, raw_buf)
-	elif config =3D=3D 5:
-		cbr(id, raw_buf)
-
-def context_switch_table(*x):
-	bind_exec(context_switch_query, 9, x)
diff --git a/tools/perf/scripts/python/failed-syscalls-by-pid.py b/tools/pe=
rf/scripts/python/failed-syscalls-by-pid.py
deleted file mode 100644
index 310efe5e7e23..000000000000
--- a/tools/perf/scripts/python/failed-syscalls-by-pid.py
+++ /dev/null
@@ -1,79 +0,0 @@
-# failed system call counts, by pid
-# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
-# Licensed under the terms of the GNU GPL License version 2
-#
-# Displays system-wide failed system call totals, broken down by pid.
-# If a [comm] arg is specified, only syscalls called by [comm] are display=
ed.
-
-from __future__ import print_function
-
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from Util import *
-
-usage =3D "perf script -s syscall-counts-by-pid.py [comm|pid]\n";
-
-for_comm =3D None
-for_pid =3D None
-
-if len(sys.argv) > 2:
-	sys.exit(usage)
-
-if len(sys.argv) > 1:
-	try:
-		for_pid =3D int(sys.argv[1])
-	except:
-		for_comm =3D sys.argv[1]
-
-syscalls =3D autodict()
-
-def trace_begin():
-	print("Press control+C to stop and show the summary")
-
-def trace_end():
-	print_error_totals()
-
-def raw_syscalls__sys_exit(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, id, ret):
-	if (for_comm and common_comm !=3D for_comm) or \
-	   (for_pid  and common_pid  !=3D for_pid ):
-		return
-
-	if ret < 0:
-		try:
-			syscalls[common_comm][common_pid][id][ret] +=3D 1
-		except TypeError:
-			syscalls[common_comm][common_pid][id][ret] =3D 1
-
-def syscalls__sys_exit(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, ret):
-	raw_syscalls__sys_exit(**locals())
-
-def print_error_totals():
-	if for_comm is not None:
-		print("\nsyscall errors for %s:\n" % (for_comm))
-	else:
-		print("\nsyscall errors:\n")
-
-	print("%-30s  %10s" % ("comm [pid]", "count"))
-	print("%-30s  %10s" % ("------------------------------", "----------"))
-
-	comm_keys =3D syscalls.keys()
-	for comm in comm_keys:
-		pid_keys =3D syscalls[comm].keys()
-		for pid in pid_keys:
-			print("\n%s [%d]" % (comm, pid))
-			id_keys =3D syscalls[comm][pid].keys()
-			for id in id_keys:
-				print("  syscall: %-16s" % syscall_name(id))
-				ret_keys =3D syscalls[comm][pid][id].keys()
-				for ret, val in sorted(syscalls[comm][pid][id].items(), key =3D lambda=
 kv: (kv[1], kv[0]), reverse =3D True):
-					print("    err =3D %-20s  %10d" % (strerror(ret), val))
diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/p=
ython/flamegraph.py
deleted file mode 100755
index ad735990c5be..000000000000
--- a/tools/perf/scripts/python/flamegraph.py
+++ /dev/null
@@ -1,267 +0,0 @@
-# flamegraph.py - create flame graphs from perf samples
-# SPDX-License-Identifier: GPL-2.0
-#
-# Usage:
-#
-#     perf record -a -g -F 99 sleep 60
-#     perf script report flamegraph
-#
-# Combined:
-#
-#     perf script flamegraph -a -F 99 sleep 60
-#
-# Written by Andreas Gerstmayr <agerstmayr@redhat.com>
-# Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
-# Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
-#
-# pylint: disable=3Dmissing-module-docstring
-# pylint: disable=3Dmissing-class-docstring
-# pylint: disable=3Dmissing-function-docstring
-
-import argparse
-import hashlib
-import io
-import json
-import os
-import subprocess
-import sys
-from typing import Dict, Optional, Union
-import urllib.request
-
-MINIMAL_HTML =3D """<head>
-  <link rel=3D"stylesheet" type=3D"text/css" href=3D"https://cdn.jsdelivr.=
net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
-</head>
-<body>
-  <div id=3D"chart"></div>
-  <script type=3D"text/javascript" src=3D"https://d3js.org/d3.v7.js"></scr=
ipt>
-  <script type=3D"text/javascript" src=3D"https://cdn.jsdelivr.net/npm/d3-=
flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
-  <script type=3D"text/javascript">
-  const stacks =3D [/** @flamegraph_json **/];
-  // Note, options is unused.
-  const options =3D [/** @options_json **/];
-
-  var chart =3D flamegraph();
-  d3.select("#chart")
-        .datum(stacks[0])
-        .call(chart);
-  </script>
-</body>
-"""
-
-# pylint: disable=3Dtoo-few-public-methods
-class Node:
-    def __init__(self, name: str, libtype: str):
-        self.name =3D name
-        # "root" | "kernel" | ""
-        # "" indicates user space
-        self.libtype =3D libtype
-        self.value: int =3D 0
-        self.children: list[Node] =3D []
-
-    def to_json(self) -> Dict[str, Union[str, int, list[Dict]]]:
-        return {
-            "n": self.name,
-            "l": self.libtype,
-            "v": self.value,
-            "c": [x.to_json() for x in self.children]
-        }
-
-
-class FlameGraphCLI:
-    def __init__(self, args):
-        self.args =3D args
-        self.stack =3D Node("all", "root")
-
-    @staticmethod
-    def get_libtype_from_dso(dso: Optional[str]) -> str:
-        """
-        when kernel-debuginfo is installed,
-        dso points to /usr/lib/debug/lib/modules/*/vmlinux
-        """
-        if dso and (dso =3D=3D "[kernel.kallsyms]" or dso.endswith("/vmlin=
ux")):
-            return "kernel"
-
-        return ""
-
-    @staticmethod
-    def find_or_create_node(node: Node, name: str, libtype: str) -> Node:
-        for child in node.children:
-            if child.name =3D=3D name:
-                return child
-
-        child =3D Node(name, libtype)
-        node.children.append(child)
-        return child
-
-    def process_event(self, event) -> None:
-        # ignore events where the event name does not match
-        # the one specified by the user
-        if self.args.event_name and event.get("ev_name") !=3D self.args.ev=
ent_name:
-            return
-
-        pid =3D event.get("sample", {}).get("pid", 0)
-        # event["dso"] sometimes contains /usr/lib/debug/lib/modules/*/vml=
inux
-        # for user-space processes; let's use pid for kernel or user-space=
 distinction
-        if pid =3D=3D 0:
-            comm =3D event["comm"]
-            libtype =3D "kernel"
-        else:
-            comm =3D f"{event['comm']} ({pid})"
-            libtype =3D ""
-        node =3D self.find_or_create_node(self.stack, comm, libtype)
-
-        if "callchain" in event:
-            for entry in reversed(event["callchain"]):
-                name =3D entry.get("sym", {}).get("name", "[unknown]")
-                libtype =3D self.get_libtype_from_dso(entry.get("dso"))
-                node =3D self.find_or_create_node(node, name, libtype)
-        else:
-            name =3D event.get("symbol", "[unknown]")
-            libtype =3D self.get_libtype_from_dso(event.get("dso"))
-            node =3D self.find_or_create_node(node, name, libtype)
-        node.value +=3D 1
-
-    def get_report_header(self) -> str:
-        if self.args.input =3D=3D "-":
-            # when this script is invoked with "perf script flamegraph",
-            # no perf.data is created and we cannot read the header of it
-            return ""
-
-        try:
-            # if the file name other than perf.data is given,
-            # we read the header of that file
-            if self.args.input:
-                output =3D subprocess.check_output(["perf", "report", "--h=
eader-only",
-                                                  "-i", self.args.input])
-            else:
-                output =3D subprocess.check_output(["perf", "report", "--h=
eader-only"])
-
-            result =3D output.decode("utf-8")
-            if self.args.event_name:
-                result +=3D "\nFocused event: " + self.args.event_name
-            return result
-        except Exception as err:  # pylint: disable=3Dbroad-except
-            print(f"Error reading report header: {err}", file=3Dsys.stderr=
)
-            return ""
-
-    def trace_end(self) -> None:
-        stacks_json =3D json.dumps(self.stack, default=3Dlambda x: x.to_js=
on())
-
-        if self.args.format =3D=3D "html":
-            report_header =3D self.get_report_header()
-            options =3D {
-                "colorscheme": self.args.colorscheme,
-                "context": report_header
-            }
-            options_json =3D json.dumps(options)
-
-            template_md5sum =3D None
-            if self.args.format =3D=3D "html":
-                if os.path.isfile(self.args.template):
-                    template =3D f"file://{self.args.template}"
-                else:
-                    if not self.args.allow_download:
-                        print(f"""Warning: Flame Graph template '{self.arg=
s.template}'
-does not exist. To avoid this please install a package such as the
-js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
-graph template (--template PATH) or use another output format (--format
-FORMAT).""",
-                              file=3Dsys.stderr)
-                        if self.args.input =3D=3D "-":
-                            print(
-"""Not attempting to download Flame Graph template as script command line
-input is disabled due to using live mode. If you want to download the
-template retry without live mode. For example, use 'perf record -a -g
--F 99 sleep 60' and 'perf script report flamegraph'. Alternatively,
-download the template from:
-https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flameg=
raph-base.html
-and place it at:
-/usr/share/d3-flame-graph/d3-flamegraph-base.html""",
-                                  file=3Dsys.stderr)
-                            sys.exit(1)
-                        s =3D None
-                        while s not in ["y", "n"]:
-                            s =3D input("Do you wish to download a templat=
e from cdn.jsdelivr.net?" +
-                                      "(this warning can be suppressed wit=
h --allow-download) [yn] "
-                                      ).lower()
-                        if s =3D=3D "n":
-                            sys.exit(1)
-                    template =3D ("https://cdn.jsdelivr.net/npm/d3-flame-g=
raph@4.1.3/dist/templates/"
-                                "d3-flamegraph-base.html")
-                    template_md5sum =3D "143e0d06ba69b8370b9848dcd6ae3f36"
-
-            try:
-                with urllib.request.urlopen(template) as url_template:
-                    output_str =3D "".join([
-                        l.decode("utf-8") for l in url_template.readlines(=
)
-                    ])
-            except Exception as err:
-                print(f"Error reading template {template}: {err}\n"
-                      "a minimal flame graph will be generated", file=3Dsy=
s.stderr)
-                output_str =3D MINIMAL_HTML
-                template_md5sum =3D None
-
-            if template_md5sum:
-                download_md5sum =3D hashlib.md5(output_str.encode("utf-8")=
).hexdigest()
-                if download_md5sum !=3D template_md5sum:
-                    s =3D None
-                    while s not in ["y", "n"]:
-                        s =3D input(f"""Unexpected template md5sum.
-{download_md5sum} !=3D {template_md5sum}, for:
-{output_str}
-continue?[yn] """).lower()
-                    if s =3D=3D "n":
-                        sys.exit(1)
-
-            output_str =3D output_str.replace("/** @options_json **/", opt=
ions_json)
-            output_str =3D output_str.replace("/** @flamegraph_json **/", =
stacks_json)
-
-            output_fn =3D self.args.output or "flamegraph.html"
-        else:
-            output_str =3D stacks_json
-            output_fn =3D self.args.output or "stacks.json"
-
-        if output_fn =3D=3D "-":
-            with io.open(sys.stdout.fileno(), "w", encoding=3D"utf-8", clo=
sefd=3DFalse) as out:
-                out.write(output_str)
-        else:
-            print(f"dumping data to {output_fn}")
-            try:
-                with io.open(output_fn, "w", encoding=3D"utf-8") as out:
-                    out.write(output_str)
-            except IOError as err:
-                print(f"Error writing output file: {err}", file=3Dsys.stde=
rr)
-                sys.exit(1)
-
-
-if __name__ =3D=3D "__main__":
-    parser =3D argparse.ArgumentParser(description=3D"Create flame graphs.=
")
-    parser.add_argument("-f", "--format",
-                        default=3D"html", choices=3D["json", "html"],
-                        help=3D"output file format")
-    parser.add_argument("-o", "--output",
-                        help=3D"output file name")
-    parser.add_argument("--template",
-                        default=3D"/usr/share/d3-flame-graph/d3-flamegraph=
-base.html",
-                        help=3D"path to flame graph HTML template")
-    parser.add_argument("--colorscheme",
-                        default=3D"blue-green",
-                        help=3D"flame graph color scheme",
-                        choices=3D["blue-green", "orange"])
-    parser.add_argument("-i", "--input",
-                        help=3Dargparse.SUPPRESS)
-    parser.add_argument("--allow-download",
-                        default=3DFalse,
-                        action=3D"store_true",
-                        help=3D"allow unprompted downloading of HTML templ=
ate")
-    parser.add_argument("-e", "--event",
-                        default=3D"",
-                        dest=3D"event_name",
-                        type=3Dstr,
-                        help=3D"specify the event to generate flamegraph f=
or")
-
-    cli_args =3D parser.parse_args()
-    cli =3D FlameGraphCLI(cli_args)
-
-    process_event =3D cli.process_event
-    trace_end =3D cli.trace_end
diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scr=
ipts/python/futex-contention.py
deleted file mode 100644
index 7e884d46f920..000000000000
--- a/tools/perf/scripts/python/futex-contention.py
+++ /dev/null
@@ -1,57 +0,0 @@
-# futex contention
-# (c) 2010, Arnaldo Carvalho de Melo <acme@redhat.com>
-# Licensed under the terms of the GNU GPL License version 2
-#
-# Translation of:
-#
-# http://sourceware.org/systemtap/wiki/WSFutexContention
-#
-# to perf python scripting.
-#
-# Measures futex contention
-
-from __future__ import print_function
-
-import os
-import sys
-sys.path.append(os.environ['PERF_EXEC_PATH'] +
-                '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-from Util import *
-
-process_names =3D {}
-thread_thislock =3D {}
-thread_blocktime =3D {}
-
-lock_waits =3D {}  # long-lived stats on (tid,lock) blockage elapsed time
-process_names =3D {}  # long-lived pid-to-execname mapping
-
-
-def syscalls__sys_enter_futex(event, ctxt, cpu, s, ns, tid, comm, callchai=
n,
-                              nr, uaddr, op, val, utime, uaddr2, val3):
-    cmd =3D op & FUTEX_CMD_MASK
-    if cmd !=3D FUTEX_WAIT:
-        return  # we don't care about originators of WAKE events
-
-    process_names[tid] =3D comm
-    thread_thislock[tid] =3D uaddr
-    thread_blocktime[tid] =3D nsecs(s, ns)
-
-
-def syscalls__sys_exit_futex(event, ctxt, cpu, s, ns, tid, comm, callchain=
,
-                             nr, ret):
-    if tid in thread_blocktime:
-        elapsed =3D nsecs(s, ns) - thread_blocktime[tid]
-        add_stats(lock_waits, (tid, thread_thislock[tid]), elapsed)
-        del thread_blocktime[tid]
-        del thread_thislock[tid]
-
-
-def trace_begin():
-    print("Press control+C to stop and show the summary")
-
-
-def trace_end():
-    for (tid, lock) in lock_waits:
-        min, max, avg, count =3D lock_waits[tid, lock]
-        print("%s[%d] lock %x contended %d times, %d avg ns [max: %d ns, m=
in %d ns]" %
-              (process_names[tid], tid, lock, count, avg, max, min))
diff --git a/tools/perf/scripts/python/gecko.py b/tools/perf/scripts/python=
/gecko.py
deleted file mode 100644
index bc5a72f94bfa..000000000000
--- a/tools/perf/scripts/python/gecko.py
+++ /dev/null
@@ -1,395 +0,0 @@
-# gecko.py - Convert perf record output to Firefox's gecko profile format
-# SPDX-License-Identifier: GPL-2.0
-#
-# The script converts perf.data to Gecko Profile Format,
-# which can be read by https://profiler.firefox.com/.
-#
-# Usage:
-#
-#     perf record -a -g -F 99 sleep 60
-#     perf script report gecko
-#
-# Combined:
-#
-#     perf script gecko -F 99 -a sleep 60
-
-import os
-import sys
-import time
-import json
-import string
-import random
-import argparse
-import threading
-import webbrowser
-import urllib.parse
-from os import system
-from functools import reduce
-from dataclasses import dataclass, field
-from http.server import HTTPServer, SimpleHTTPRequestHandler, test
-from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
-
-# Add the Perf-Trace-Util library to the Python path
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-
-StringID =3D int
-StackID =3D int
-FrameID =3D int
-CategoryID =3D int
-Milliseconds =3D float
-
-# start_time is intialiazed only once for the all event traces.
-start_time =3D None
-
-# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7=
457fee1d66cd4e2737/src/types/profile.js#L425
-# Follow Brendan Gregg's Flamegraph convention: orange for kernel and yell=
ow for user space by default.
-CATEGORIES =3D None
-
-# The product name is used by the profiler UI to show the Operating system=
 and Processor.
-PRODUCT =3D os.popen('uname -op').read().strip()
-
-# store the output file
-output_file =3D None
-
-# Here key =3D tid, value =3D Thread
-tid_to_thread =3D dict()
-
-# The HTTP server is used to serve the profile to the profiler UI.
-http_server_thread =3D None
-
-# The category index is used by the profiler UI to show the color of the f=
lame graph.
-USER_CATEGORY_INDEX =3D 0
-KERNEL_CATEGORY_INDEX =3D 1
-
-# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7=
457fee1d66cd4e2737/src/types/gecko-profile.js#L156
-class Frame(NamedTuple):
-	string_id: StringID
-	relevantForJS: bool
-	innerWindowID: int
-	implementation: None
-	optimizations: None
-	line: None
-	column: None
-	category: CategoryID
-	subcategory: int
-
-# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7=
457fee1d66cd4e2737/src/types/gecko-profile.js#L216
-class Stack(NamedTuple):
-	prefix_id: Optional[StackID]
-	frame_id: FrameID
-
-# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7=
457fee1d66cd4e2737/src/types/gecko-profile.js#L90
-class Sample(NamedTuple):
-	stack_id: Optional[StackID]
-	time_ms: Milliseconds
-	responsiveness: int
-
-@dataclass
-class Thread:
-	"""A builder for a profile of the thread.
-
-	Attributes:
-		comm: Thread command-line (name).
-		pid: process ID of containing process.
-		tid: thread ID.
-		samples: Timeline of profile samples.
-		frameTable: interned stack frame ID -> stack frame.
-		stringTable: interned string ID -> string.
-		stringMap: interned string -> string ID.
-		stackTable: interned stack ID -> stack.
-		stackMap: (stack prefix ID, leaf stack frame ID) -> interned Stack ID.
-		frameMap: Stack Frame string -> interned Frame ID.
-		comm: str
-		pid: int
-		tid: int
-		samples: List[Sample] =3D field(default_factory=3Dlist)
-		frameTable: List[Frame] =3D field(default_factory=3Dlist)
-		stringTable: List[str] =3D field(default_factory=3Dlist)
-		stringMap: Dict[str, int] =3D field(default_factory=3Ddict)
-		stackTable: List[Stack] =3D field(default_factory=3Dlist)
-		stackMap: Dict[Tuple[Optional[int], int], int] =3D field(default_factory=
=3Ddict)
-		frameMap: Dict[str, int] =3D field(default_factory=3Ddict)
-	"""
-	comm: str
-	pid: int
-	tid: int
-	samples: List[Sample] =3D field(default_factory=3Dlist)
-	frameTable: List[Frame] =3D field(default_factory=3Dlist)
-	stringTable: List[str] =3D field(default_factory=3Dlist)
-	stringMap: Dict[str, int] =3D field(default_factory=3Ddict)
-	stackTable: List[Stack] =3D field(default_factory=3Dlist)
-	stackMap: Dict[Tuple[Optional[int], int], int] =3D field(default_factory=
=3Ddict)
-	frameMap: Dict[str, int] =3D field(default_factory=3Ddict)
-
-	def _intern_stack(self, frame_id: int, prefix_id: Optional[int]) -> int:
-		"""Gets a matching stack, or saves the new stack. Returns a Stack ID."""
-		key =3D f"{frame_id}" if prefix_id is None else f"{frame_id},{prefix_id}=
"
-		# key =3D (prefix_id, frame_id)
-		stack_id =3D self.stackMap.get(key)
-		if stack_id is None:
-			# return stack_id
-			stack_id =3D len(self.stackTable)
-			self.stackTable.append(Stack(prefix_id=3Dprefix_id, frame_id=3Dframe_id=
))
-			self.stackMap[key] =3D stack_id
-		return stack_id
-
-	def _intern_string(self, string: str) -> int:
-		"""Gets a matching string, or saves the new string. Returns a String ID.=
"""
-		string_id =3D self.stringMap.get(string)
-		if string_id is not None:
-			return string_id
-		string_id =3D len(self.stringTable)
-		self.stringTable.append(string)
-		self.stringMap[string] =3D string_id
-		return string_id
-
-	def _intern_frame(self, frame_str: str) -> int:
-		"""Gets a matching stack frame, or saves the new frame. Returns a Frame =
ID."""
-		frame_id =3D self.frameMap.get(frame_str)
-		if frame_id is not None:
-			return frame_id
-		frame_id =3D len(self.frameTable)
-		self.frameMap[frame_str] =3D frame_id
-		string_id =3D self._intern_string(frame_str)
-
-		symbol_name_to_category =3D KERNEL_CATEGORY_INDEX if frame_str.find('kal=
lsyms') !=3D -1 \
-		or frame_str.find('/vmlinux') !=3D -1 \
-		or frame_str.endswith('.ko)') \
-		else USER_CATEGORY_INDEX
-
-		self.frameTable.append(Frame(
-			string_id=3Dstring_id,
-			relevantForJS=3DFalse,
-			innerWindowID=3D0,
-			implementation=3DNone,
-			optimizations=3DNone,
-			line=3DNone,
-			column=3DNone,
-			category=3Dsymbol_name_to_category,
-			subcategory=3DNone,
-		))
-		return frame_id
-
-	def _add_sample(self, comm: str, stack: List[str], time_ms: Milliseconds)=
 -> None:
-		"""Add a timestamped stack trace sample to the thread builder.
-		Args:
-			comm: command-line (name) of the thread at this sample
-			stack: sampled stack frames. Root first, leaf last.
-			time_ms: timestamp of sample in milliseconds.
-		"""
-		# Ihreads may not set their names right after they are created.
-		# Instead, they might do it later. In such situations, to use the latest=
 name they have set.
-		if self.comm !=3D comm:
-			self.comm =3D comm
-
-		prefix_stack_id =3D reduce(lambda prefix_id, frame: self._intern_stack
-						(self._intern_frame(frame), prefix_id), stack, None)
-		if prefix_stack_id is not None:
-			self.samples.append(Sample(stack_id=3Dprefix_stack_id,
-									time_ms=3Dtime_ms,
-									responsiveness=3D0))
-
-	def _to_json_dict(self) -> Dict:
-		"""Converts current Thread to GeckoThread JSON format."""
-		# Gecko profile format is row-oriented data as List[List],
-		# And a schema for interpreting each index.
-		# Schema:
-		# https://github.com/firefox-devtools/profiler/blob/main/docs-developer/=
gecko-profile-format.md
-		# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26=
d7457fee1d66cd4e2737/src/types/gecko-profile.js#L230
-		return {
-			"tid": self.tid,
-			"pid": self.pid,
-			"name": self.comm,
-			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e2=
6d7457fee1d66cd4e2737/src/types/gecko-profile.js#L51
-			"markers": {
-				"schema": {
-					"name": 0,
-					"startTime": 1,
-					"endTime": 2,
-					"phase": 3,
-					"category": 4,
-					"data": 5,
-				},
-				"data": [],
-			},
-
-			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e2=
6d7457fee1d66cd4e2737/src/types/gecko-profile.js#L90
-			"samples": {
-				"schema": {
-					"stack": 0,
-					"time": 1,
-					"responsiveness": 2,
-				},
-				"data": self.samples
-			},
-
-			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e2=
6d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
-			"frameTable": {
-				"schema": {
-					"location": 0,
-					"relevantForJS": 1,
-					"innerWindowID": 2,
-					"implementation": 3,
-					"optimizations": 4,
-					"line": 5,
-					"column": 6,
-					"category": 7,
-					"subcategory": 8,
-				},
-				"data": self.frameTable,
-			},
-
-			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e2=
6d7457fee1d66cd4e2737/src/types/gecko-profile.js#L216
-			"stackTable": {
-				"schema": {
-					"prefix": 0,
-					"frame": 1,
-				},
-				"data": self.stackTable,
-			},
-			"stringTable": self.stringTable,
-			"registerTime": 0,
-			"unregisterTime": None,
-			"processType": "default",
-		}
-
-# Uses perf script python interface to parse each
-# event and store the data in the thread builder.
-def process_event(param_dict: Dict) -> None:
-	global start_time
-	global tid_to_thread
-	time_stamp =3D (param_dict['sample']['time'] // 1000) / 1000
-	pid =3D param_dict['sample']['pid']
-	tid =3D param_dict['sample']['tid']
-	comm =3D param_dict['comm']
-
-	# Start time is the time of the first sample
-	if not start_time:
-		start_time =3D time_stamp
-
-	# Parse and append the callchain of the current sample into a stack.
-	stack =3D []
-	if param_dict['callchain']:
-		for call in param_dict['callchain']:
-			if 'sym' not in call:
-				continue
-			stack.append(f'{call["sym"]["name"]} (in {call["dso"]})')
-		if len(stack) !=3D 0:
-			# Reverse the stack, as root come first and the leaf at the end.
-			stack =3D stack[::-1]
-
-	# During perf record if -g is not used, the callchain is not available.
-	# In that case, the symbol and dso are available in the event parameters.
-	else:
-		func =3D param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'
-		dso =3D param_dict['dso'] if 'dso' in param_dict else '[unknown]'
-		stack.append(f'{func} (in {dso})')
-
-	# Add sample to the specific thread.
-	thread =3D tid_to_thread.get(tid)
-	if thread is None:
-		thread =3D Thread(comm=3Dcomm, pid=3Dpid, tid=3Dtid)
-		tid_to_thread[tid] =3D thread
-	thread._add_sample(comm=3Dcomm, stack=3Dstack, time_ms=3Dtime_stamp)
-
-def trace_begin() -> None:
-	global output_file
-	if (output_file is None):
-		print("Staring Firefox Profiler on your default browser...")
-		global http_server_thread
-		http_server_thread =3D threading.Thread(target=3Dtest, args=3D(CORSReque=
stHandler, HTTPServer,))
-		http_server_thread.daemon =3D True
-		http_server_thread.start()
-
-# Trace_end runs at the end and will be used to aggregate
-# the data into the final json object and print it out to stdout.
-def trace_end() -> None:
-	global output_file
-	threads =3D [thread._to_json_dict() for thread in tid_to_thread.values()]
-
-	# Schema: https://github.com/firefox-devtools/profiler/blob/53970305b51b9=
b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L305
-	gecko_profile_with_meta =3D {
-		"meta": {
-			"interval": 1,
-			"processType": 0,
-			"product": PRODUCT,
-			"stackwalk": 1,
-			"debug": 0,
-			"gcpoison": 0,
-			"asyncstack": 1,
-			"startTime": start_time,
-			"shutdownTime": None,
-			"version": 24,
-			"presymbolicated": True,
-			"categories": CATEGORIES,
-			"markerSchema": [],
-			},
-		"libs": [],
-		"threads": threads,
-		"processes": [],
-		"pausedRanges": [],
-	}
-	# launch the profiler on local host if not specified --save-only args, ot=
herwise print to file
-	if (output_file is None):
-		output_file =3D 'gecko_profile.json'
-		with open(output_file, 'w') as f:
-			json.dump(gecko_profile_with_meta, f, indent=3D2)
-		launchFirefox(output_file)
-		time.sleep(1)
-		print(f'[ perf gecko: Captured and wrote into {output_file} ]')
-	else:
-		print(f'[ perf gecko: Captured and wrote into {output_file} ]')
-		with open(output_file, 'w') as f:
-			json.dump(gecko_profile_with_meta, f, indent=3D2)
-
-# Used to enable Cross-Origin Resource Sharing (CORS) for requests coming =
from 'https://profiler.firefox.com', allowing it to access resources from t=
his server.
-class CORSRequestHandler(SimpleHTTPRequestHandler):
-	def end_headers (self):
-		self.send_header('Access-Control-Allow-Origin', 'https://profiler.firefo=
x.com')
-		SimpleHTTPRequestHandler.end_headers(self)
-
-# start a local server to serve the gecko_profile.json file to the profile=
r.firefox.com
-def launchFirefox(file):
-	safe_string =3D urllib.parse.quote_plus(f'http://localhost:8000/{file}')
-	url =3D 'https://profiler.firefox.com/from-url/' + safe_string
-	webbrowser.open(f'{url}')
-
-def main() -> None:
-	global output_file
-	global CATEGORIES
-	parser =3D argparse.ArgumentParser(description=3D"Convert perf.data to Fi=
refox\'s Gecko Profile format which can be uploaded to profiler.firefox.com=
 for visualization")
-
-	# Add the command-line options
-	# Colors must be defined according to this:
-	# https://github.com/firefox-devtools/profiler/blob/50124adbfa488adba6e26=
74a8f2618cf34b59cd2/res/css/categories.css
-	parser.add_argument('--user-color', default=3D'yellow', help=3D'Color for=
 the User category', choices=3D['yellow', 'blue', 'purple', 'green', 'orang=
e', 'red', 'grey', 'magenta'])
-	parser.add_argument('--kernel-color', default=3D'orange', help=3D'Color f=
or the Kernel category', choices=3D['yellow', 'blue', 'purple', 'green', 'o=
range', 'red', 'grey', 'magenta'])
-	# If --save-only is specified, the output will be saved to a file instead=
 of opening Firefox's profiler directly.
-	parser.add_argument('--save-only', help=3D'Save the output to a file inst=
ead of opening Firefox\'s profiler')
-
-	# Parse the command-line arguments
-	args =3D parser.parse_args()
-	# Access the values provided by the user
-	user_color =3D args.user_color
-	kernel_color =3D args.kernel_color
-	output_file =3D args.save_only
-
-	CATEGORIES =3D [
-		{
-			"name": 'User',
-			"color": user_color,
-			"subcategories": ['Other']
-		},
-		{
-			"name": 'Kernel',
-			"color": kernel_color,
-			"subcategories": ['Other']
-		},
-	]
-
-if __name__ =3D=3D '__main__':
-	main()
diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scri=
pts/python/intel-pt-events.py
deleted file mode 100644
index 346c89bd16d6..000000000000
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ /dev/null
@@ -1,494 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# intel-pt-events.py: Print Intel PT Events including Power Events and PTW=
RITE
-# Copyright (c) 2017-2021, Intel Corporation.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms and conditions of the GNU General Public License,
-# version 2, as published by the Free Software Foundation.
-#
-# This program is distributed in the hope it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License fo=
r
-# more details.
-
-from __future__ import division, print_function
-
-import io
-import os
-import sys
-import struct
-import argparse
-import contextlib
-
-from libxed import LibXED
-from ctypes import create_string_buffer, addressof
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import perf_set_itrace_options, \
-	perf_sample_insn, perf_sample_srccode
-
-try:
-	broken_pipe_exception =3D BrokenPipeError
-except:
-	broken_pipe_exception =3D IOError
-
-glb_switch_str		=3D {}
-glb_insn		=3D False
-glb_disassembler	=3D None
-glb_src			=3D False
-glb_source_file_name	=3D None
-glb_line_number		=3D None
-glb_dso			=3D None
-glb_stash_dict		=3D {}
-glb_output		=3D None
-glb_output_pos		=3D 0
-glb_cpu			=3D -1
-glb_time		=3D 0
-
-def get_optional_null(perf_dict, field):
-	if field in perf_dict:
-		return perf_dict[field]
-	return ""
-
-def get_optional_zero(perf_dict, field):
-	if field in perf_dict:
-		return perf_dict[field]
-	return 0
-
-def get_optional_bytes(perf_dict, field):
-	if field in perf_dict:
-		return perf_dict[field]
-	return bytes()
-
-def get_optional(perf_dict, field):
-	if field in perf_dict:
-		return perf_dict[field]
-	return "[unknown]"
-
-def get_offset(perf_dict, field):
-	if field in perf_dict:
-		return "+%#x" % perf_dict[field]
-	return ""
-
-def trace_begin():
-	ap =3D argparse.ArgumentParser(usage =3D "", add_help =3D False)
-	ap.add_argument("--insn-trace", action=3D'store_true')
-	ap.add_argument("--src-trace", action=3D'store_true')
-	ap.add_argument("--all-switch-events", action=3D'store_true')
-	ap.add_argument("--interleave", type=3Dint, nargs=3D'?', const=3D4, defau=
lt=3D0)
-	global glb_args
-	global glb_insn
-	global glb_src
-	glb_args =3D ap.parse_args()
-	if glb_args.insn_trace:
-		print("Intel PT Instruction Trace")
-		itrace =3D "i0nsepwxI"
-		glb_insn =3D True
-	elif glb_args.src_trace:
-		print("Intel PT Source Trace")
-		itrace =3D "i0nsepwxI"
-		glb_insn =3D True
-		glb_src =3D True
-	else:
-		print("Intel PT Branch Trace, Power Events, Event Trace and PTWRITE")
-		itrace =3D "bepwxI"
-	global glb_disassembler
-	try:
-		glb_disassembler =3D LibXED()
-	except:
-		glb_disassembler =3D None
-	perf_set_itrace_options(perf_script_context, itrace)
-
-def trace_end():
-	if glb_args.interleave:
-		flush_stashed_output()
-	print("End")
-
-def trace_unhandled(event_name, context, event_fields_dict):
-		print(' '.join(['%s=3D%s'%(k,str(v))for k,v in sorted(event_fields_dict.=
items())]))
-
-def stash_output():
-	global glb_stash_dict
-	global glb_output_pos
-	output_str =3D glb_output.getvalue()[glb_output_pos:]
-	n =3D len(output_str)
-	if n:
-		glb_output_pos +=3D n
-		if glb_cpu not in glb_stash_dict:
-			glb_stash_dict[glb_cpu] =3D []
-		glb_stash_dict[glb_cpu].append(output_str)
-
-def flush_stashed_output():
-	global glb_stash_dict
-	while glb_stash_dict:
-		cpus =3D list(glb_stash_dict.keys())
-		# Output at most glb_args.interleave output strings per cpu
-		for cpu in cpus:
-			items =3D glb_stash_dict[cpu]
-			countdown =3D glb_args.interleave
-			while len(items) and countdown:
-				sys.stdout.write(items[0])
-				del items[0]
-				countdown -=3D 1
-			if not items:
-				del glb_stash_dict[cpu]
-
-def print_ptwrite(raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	flags =3D data[0]
-	payload =3D data[1]
-	exact_ip =3D flags & 1
-	try:
-		s =3D payload.to_bytes(8, "little").decode("ascii").rstrip("\x00")
-		if not s.isprintable():
-			s =3D ""
-	except:
-		s =3D ""
-	print("IP: %u payload: %#x" % (exact_ip, payload), s, end=3D' ')
-
-def print_cbr(raw_buf):
-	data =3D struct.unpack_from("<BBBBII", raw_buf)
-	cbr =3D data[0]
-	f =3D (data[4] + 500) / 1000
-	p =3D ((cbr * 1000 / data[2]) + 5) / 10
-	print("%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p), end=3D' ')
-
-def print_mwait(raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	payload =3D data[1]
-	hints =3D payload & 0xff
-	extensions =3D (payload >> 32) & 0x3
-	print("hints: %#x extensions: %#x" % (hints, extensions), end=3D' ')
-
-def print_pwre(raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	payload =3D data[1]
-	hw =3D (payload >> 7) & 1
-	cstate =3D (payload >> 12) & 0xf
-	subcstate =3D (payload >> 8) & 0xf
-	print("hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
-		end=3D' ')
-
-def print_exstop(raw_buf):
-	data =3D struct.unpack_from("<I", raw_buf)
-	flags =3D data[0]
-	exact_ip =3D flags & 1
-	print("IP: %u" % (exact_ip), end=3D' ')
-
-def print_pwrx(raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	payload =3D data[1]
-	deepest_cstate =3D payload & 0xf
-	last_cstate =3D (payload >> 4) & 0xf
-	wake_reason =3D (payload >> 8) & 0xf
-	print("deepest cstate: %u last cstate: %u wake reason: %#x" %
-		(deepest_cstate, last_cstate, wake_reason), end=3D' ')
-
-def print_psb(raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	offset =3D data[1]
-	print("offset: %#x" % (offset), end=3D' ')
-
-glb_cfe =3D ["", "INTR", "IRET", "SMI", "RSM", "SIPI", "INIT", "VMENTRY", =
"VMEXIT",
-		"VMEXIT_INTR", "SHUTDOWN", "", "UINT", "UIRET"] + [""] * 18
-glb_evd =3D ["", "PFA", "VMXQ", "VMXR"] + [""] * 60
-
-def print_evt(raw_buf):
-	data =3D struct.unpack_from("<BBH", raw_buf)
-	typ =3D data[0] & 0x1f
-	ip_flag =3D (data[0] & 0x80) >> 7
-	vector =3D data[1]
-	evd_cnt =3D data[2]
-	s =3D glb_cfe[typ]
-	if s:
-		print(" cfe: %s IP: %u vector: %u" % (s, ip_flag, vector), end=3D' ')
-	else:
-		print(" cfe: %u IP: %u vector: %u" % (typ, ip_flag, vector), end=3D' ')
-	pos =3D 4
-	for i in range(evd_cnt):
-		data =3D struct.unpack_from("<QQ", raw_buf)
-		et =3D data[0] & 0x3f
-		s =3D glb_evd[et]
-		if s:
-			print("%s: %#x" % (s, data[1]), end=3D' ')
-		else:
-			print("EVD_%u: %#x" % (et, data[1]), end=3D' ')
-
-def print_iflag(raw_buf):
-	data =3D struct.unpack_from("<IQ", raw_buf)
-	iflag =3D data[0] & 1
-	old_iflag =3D iflag ^ 1
-	via_branch =3D data[0] & 2
-	branch_ip =3D data[1]
-	if via_branch:
-		s =3D "via"
-	else:
-		s =3D "non"
-	print("IFLAG: %u->%u %s branch" % (old_iflag, iflag, s), end=3D' ')
-
-def common_start_str(comm, sample):
-	ts =3D sample["time"]
-	cpu =3D sample["cpu"]
-	pid =3D sample["pid"]
-	tid =3D sample["tid"]
-	if "machine_pid" in sample:
-		machine_pid =3D sample["machine_pid"]
-		vcpu =3D sample["vcpu"]
-		return "VM:%5d VCPU:%03d %16s %5u/%-5u [%03u] %9u.%09u  " % (machine_pid=
, vcpu, comm, pid, tid, cpu, ts / 1000000000, ts %1000000000)
-	else:
-		return "%16s %5u/%-5u [%03u] %9u.%09u  " % (comm, pid, tid, cpu, ts / 10=
00000000, ts %1000000000)
-
-def print_common_start(comm, sample, name):
-	flags_disp =3D get_optional_null(sample, "flags_disp")
-	# Unused fields:
-	# period      =3D sample["period"]
-	# phys_addr   =3D sample["phys_addr"]
-	# weight      =3D sample["weight"]
-	# transaction =3D sample["transaction"]
-	# cpumode     =3D get_optional_zero(sample, "cpumode")
-	print(common_start_str(comm, sample) + "%8s  %21s" % (name, flags_disp), =
end=3D' ')
-
-def print_instructions_start(comm, sample):
-	if "x" in get_optional_null(sample, "flags"):
-		print(common_start_str(comm, sample) + "x", end=3D' ')
-	else:
-		print(common_start_str(comm, sample), end=3D'  ')
-
-def disassem(insn, ip):
-	inst =3D glb_disassembler.Instruction()
-	glb_disassembler.SetMode(inst, 0) # Assume 64-bit
-	buf =3D create_string_buffer(64)
-	buf.value =3D insn
-	return glb_disassembler.DisassembleOne(inst, addressof(buf), len(insn), i=
p)
-
-def print_common_ip(param_dict, sample, symbol, dso):
-	ip   =3D sample["ip"]
-	offs =3D get_offset(param_dict, "symoff")
-	if "cyc_cnt" in sample:
-		cyc_cnt =3D sample["cyc_cnt"]
-		insn_cnt =3D get_optional_zero(sample, "insn_cnt")
-		ipc_str =3D "  IPC: %#.2f (%u/%u)" % (insn_cnt / cyc_cnt, insn_cnt, cyc_=
cnt)
-	else:
-		ipc_str =3D ""
-	if glb_insn and glb_disassembler is not None:
-		insn =3D perf_sample_insn(perf_script_context)
-		if insn and len(insn):
-			cnt, text =3D disassem(insn, ip)
-			byte_str =3D ("%x" % ip).rjust(16)
-			if sys.version_info.major >=3D 3:
-				for k in range(cnt):
-					byte_str +=3D " %02x" % insn[k]
-			else:
-				for k in xrange(cnt):
-					byte_str +=3D " %02x" % ord(insn[k])
-			print("%-40s  %-30s" % (byte_str, text), end=3D' ')
-		print("%s%s (%s)" % (symbol, offs, dso), end=3D' ')
-	else:
-		print("%16x %s%s (%s)" % (ip, symbol, offs, dso), end=3D' ')
-	if "addr_correlates_sym" in sample:
-		addr   =3D sample["addr"]
-		dso    =3D get_optional(sample, "addr_dso")
-		symbol =3D get_optional(sample, "addr_symbol")
-		offs   =3D get_offset(sample, "addr_symoff")
-		print("=3D> %x %s%s (%s)%s" % (addr, symbol, offs, dso, ipc_str))
-	else:
-		print(ipc_str)
-
-def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
-	ip =3D sample["ip"]
-	if symbol =3D=3D "[unknown]":
-		start_str =3D common_start_str(comm, sample) + ("%x" % ip).rjust(16).lju=
st(40)
-	else:
-		offs =3D get_offset(param_dict, "symoff")
-		start_str =3D common_start_str(comm, sample) + (symbol + offs).ljust(40)
-
-	if with_insn and glb_insn and glb_disassembler is not None:
-		insn =3D perf_sample_insn(perf_script_context)
-		if insn and len(insn):
-			cnt, text =3D disassem(insn, ip)
-		start_str +=3D text.ljust(30)
-
-	global glb_source_file_name
-	global glb_line_number
-	global glb_dso
-
-	source_file_name, line_number, source_line =3D perf_sample_srccode(perf_s=
cript_context)
-	if source_file_name:
-		if glb_line_number =3D=3D line_number and glb_source_file_name =3D=3D so=
urce_file_name:
-			src_str =3D ""
-		else:
-			if len(source_file_name) > 40:
-				src_file =3D ("..." + source_file_name[-37:]) + " "
-			else:
-				src_file =3D source_file_name.ljust(41)
-			if source_line is None:
-				src_str =3D src_file + str(line_number).rjust(4) + " <source not found=
>"
-			else:
-				src_str =3D src_file + str(line_number).rjust(4) + " " + source_line
-		glb_dso =3D None
-	elif dso =3D=3D glb_dso:
-		src_str =3D ""
-	else:
-		src_str =3D dso
-		glb_dso =3D dso
-
-	glb_line_number =3D line_number
-	glb_source_file_name =3D source_file_name
-
-	print(start_str, src_str)
-
-def do_process_event(param_dict):
-	sample	   =3D param_dict["sample"]
-	raw_buf	   =3D param_dict["raw_buf"]
-	comm	   =3D param_dict["comm"]
-	name	   =3D param_dict["ev_name"]
-	# Unused fields:
-	# callchain  =3D param_dict["callchain"]
-	# brstack    =3D param_dict["brstack"]
-	# brstacksym =3D param_dict["brstacksym"]
-	# event_attr =3D param_dict["attr"]
-
-	# Symbol and dso info are not always resolved
-	dso    =3D get_optional(param_dict, "dso")
-	symbol =3D get_optional(param_dict, "symbol")
-
-	cpu =3D sample["cpu"]
-	if cpu in glb_switch_str:
-		print(glb_switch_str[cpu])
-		del glb_switch_str[cpu]
-
-	if name.startswith("instructions"):
-		if glb_src:
-			print_srccode(comm, param_dict, sample, symbol, dso, True)
-		else:
-			print_instructions_start(comm, sample)
-			print_common_ip(param_dict, sample, symbol, dso)
-	elif name.startswith("branches"):
-		if glb_src:
-			print_srccode(comm, param_dict, sample, symbol, dso, False)
-		else:
-			print_common_start(comm, sample, name)
-			print_common_ip(param_dict, sample, symbol, dso)
-	elif name =3D=3D "ptwrite":
-		print_common_start(comm, sample, name)
-		print_ptwrite(raw_buf)
-		print_common_ip(param_dict, sample, symbol, dso)
-	elif name =3D=3D "cbr":
-		print_common_start(comm, sample, name)
-		print_cbr(raw_buf)
-		print_common_ip(param_dict, sample, symbol, dso)
-	elif name =3D=3D "mwait":
-		print_common_start(comm, sample, name)
-		print_mwait(raw_buf)
-		print_common_ip(param_dict, sample, symbol, dso)
-	elif name =3D=3D "pwre":
-		print_common_start(comm, sample, name)
-		print_pwre(raw_buf)
-		print_common_ip(param_dict, sample, symbol, dso)
-	elif name =3D=3D "exstop":
-		print_common_start(comm, sample, name)
-		print_exstop(raw_buf)
-		print_common_ip(param_dict, sample, symbol, dso)
-	elif name =3D=3D "pwrx":
-		print_common_start(comm, sample, name)
-		print_pwrx(raw_buf)
-		print_common_ip(param_dict, sample, symbol, dso)
-	elif name =3D=3D "psb":
-		print_common_start(comm, sample, name)
-		print_psb(raw_buf)
-		print_common_ip(param_dict, sample, symbol, dso)
-	elif name =3D=3D "evt":
-		print_common_start(comm, sample, name)
-		print_evt(raw_buf)
-		print_common_ip(param_dict, sample, symbol, dso)
-	elif name =3D=3D "iflag":
-		print_common_start(comm, sample, name)
-		print_iflag(raw_buf)
-		print_common_ip(param_dict, sample, symbol, dso)
-	else:
-		print_common_start(comm, sample, name)
-		print_common_ip(param_dict, sample, symbol, dso)
-
-def interleave_events(param_dict):
-	global glb_cpu
-	global glb_time
-	global glb_output
-	global glb_output_pos
-
-	sample  =3D param_dict["sample"]
-	glb_cpu =3D sample["cpu"]
-	ts      =3D sample["time"]
-
-	if glb_time !=3D ts:
-		glb_time =3D ts
-		flush_stashed_output()
-
-	glb_output_pos =3D 0
-	with contextlib.redirect_stdout(io.StringIO()) as glb_output:
-		do_process_event(param_dict)
-
-	stash_output()
-
-def process_event(param_dict):
-	try:
-		if glb_args.interleave:
-			interleave_events(param_dict)
-		else:
-			do_process_event(param_dict)
-	except broken_pipe_exception:
-		# Stop python printing broken pipe errors and traceback
-		sys.stdout =3D open(os.devnull, 'w')
-		sys.exit(1)
-
-def auxtrace_error(typ, code, cpu, pid, tid, ip, ts, msg, cpumode, *x):
-	if glb_args.interleave:
-		flush_stashed_output()
-	if len(x) >=3D 2 and x[0]:
-		machine_pid =3D x[0]
-		vcpu =3D x[1]
-	else:
-		machine_pid =3D 0
-		vcpu =3D -1
-	try:
-		if machine_pid:
-			print("VM:%5d VCPU:%03d %16s %5u/%-5u [%03u] %9u.%09u  error type %u co=
de %u: %s ip 0x%16x" %
-				(machine_pid, vcpu, "Trace error", pid, tid, cpu, ts / 1000000000, ts =
%1000000000, typ, code, msg, ip))
-		else:
-			print("%16s %5u/%-5u [%03u] %9u.%09u  error type %u code %u: %s ip 0x%1=
6x" %
-				("Trace error", pid, tid, cpu, ts / 1000000000, ts %1000000000, typ, c=
ode, msg, ip))
-	except broken_pipe_exception:
-		# Stop python printing broken pipe errors and traceback
-		sys.stdout =3D open(os.devnull, 'w')
-		sys.exit(1)
-
-def context_switch(ts, cpu, pid, tid, np_pid, np_tid, machine_pid, out, ou=
t_preempt, *x):
-	if glb_args.interleave:
-		flush_stashed_output()
-	if out:
-		out_str =3D "Switch out "
-	else:
-		out_str =3D "Switch In  "
-	if out_preempt:
-		preempt_str =3D "preempt"
-	else:
-		preempt_str =3D ""
-	if len(x) >=3D 2 and x[0]:
-		machine_pid =3D x[0]
-		vcpu =3D x[1]
-	else:
-		vcpu =3D None;
-	if machine_pid =3D=3D -1:
-		machine_str =3D ""
-	elif vcpu is None:
-		machine_str =3D "machine PID %d" % machine_pid
-	else:
-		machine_str =3D "machine PID %d VCPU %d" % (machine_pid, vcpu)
-	switch_str =3D "%16s %5d/%-5d [%03u] %9u.%09u %5d/%-5d %s %s" % \
-		(out_str, pid, tid, cpu, ts / 1000000000, ts %1000000000, np_pid, np_tid=
, machine_str, preempt_str)
-	if glb_args.all_switch_events:
-		print(switch_str)
-	else:
-		global glb_switch_str
-		glb_switch_str[cpu] =3D switch_str
diff --git a/tools/perf/scripts/python/libxed.py b/tools/perf/scripts/pytho=
n/libxed.py
deleted file mode 100644
index 2c70a5a7eb9c..000000000000
--- a/tools/perf/scripts/python/libxed.py
+++ /dev/null
@@ -1,107 +0,0 @@
-#!/usr/bin/env python
-# SPDX-License-Identifier: GPL-2.0
-# libxed.py: Python wrapper for libxed.so
-# Copyright (c) 2014-2021, Intel Corporation.
-
-# To use Intel XED, libxed.so must be present. To build and install
-# libxed.so:
-#            git clone https://github.com/intelxed/mbuild.git mbuild
-#            git clone https://github.com/intelxed/xed
-#            cd xed
-#            ./mfile.py --share
-#            sudo ./mfile.py --prefix=3D/usr/local install
-#            sudo ldconfig
-#
-
-import sys
-
-from ctypes import CDLL, Structure, create_string_buffer, addressof, sizeo=
f, \
-		   c_void_p, c_bool, c_byte, c_char, c_int, c_uint, c_longlong, c_ulongl=
ong
-
-# XED Disassembler
-
-class xed_state_t(Structure):
-
-	_fields_ =3D [
-		("mode", c_int),
-		("width", c_int)
-	]
-
-class XEDInstruction():
-
-	def __init__(self, libxed):
-		# Current xed_decoded_inst_t structure is 192 bytes. Use 512 to allow fo=
r future expansion
-		xedd_t =3D c_byte * 512
-		self.xedd =3D xedd_t()
-		self.xedp =3D addressof(self.xedd)
-		libxed.xed_decoded_inst_zero(self.xedp)
-		self.state =3D xed_state_t()
-		self.statep =3D addressof(self.state)
-		# Buffer for disassembled instruction text
-		self.buffer =3D create_string_buffer(256)
-		self.bufferp =3D addressof(self.buffer)
-
-class LibXED():
-
-	def __init__(self):
-		try:
-			self.libxed =3D CDLL("libxed.so")
-		except:
-			self.libxed =3D None
-		if not self.libxed:
-			self.libxed =3D CDLL("/usr/local/lib/libxed.so")
-
-		self.xed_tables_init =3D self.libxed.xed_tables_init
-		self.xed_tables_init.restype =3D None
-		self.xed_tables_init.argtypes =3D []
-
-		self.xed_decoded_inst_zero =3D self.libxed.xed_decoded_inst_zero
-		self.xed_decoded_inst_zero.restype =3D None
-		self.xed_decoded_inst_zero.argtypes =3D [ c_void_p ]
-
-		self.xed_operand_values_set_mode =3D self.libxed.xed_operand_values_set_=
mode
-		self.xed_operand_values_set_mode.restype =3D None
-		self.xed_operand_values_set_mode.argtypes =3D [ c_void_p, c_void_p ]
-
-		self.xed_decoded_inst_zero_keep_mode =3D self.libxed.xed_decoded_inst_ze=
ro_keep_mode
-		self.xed_decoded_inst_zero_keep_mode.restype =3D None
-		self.xed_decoded_inst_zero_keep_mode.argtypes =3D [ c_void_p ]
-
-		self.xed_decode =3D self.libxed.xed_decode
-		self.xed_decode.restype =3D c_int
-		self.xed_decode.argtypes =3D [ c_void_p, c_void_p, c_uint ]
-
-		self.xed_format_context =3D self.libxed.xed_format_context
-		self.xed_format_context.restype =3D c_uint
-		self.xed_format_context.argtypes =3D [ c_int, c_void_p, c_void_p, c_int,=
 c_ulonglong, c_void_p, c_void_p ]
-
-		self.xed_tables_init()
-
-	def Instruction(self):
-		return XEDInstruction(self)
-
-	def SetMode(self, inst, mode):
-		if mode:
-			inst.state.mode =3D 4 # 32-bit
-			inst.state.width =3D 4 # 4 bytes
-		else:
-			inst.state.mode =3D 1 # 64-bit
-			inst.state.width =3D 8 # 8 bytes
-		self.xed_operand_values_set_mode(inst.xedp, inst.statep)
-
-	def DisassembleOne(self, inst, bytes_ptr, bytes_cnt, ip):
-		self.xed_decoded_inst_zero_keep_mode(inst.xedp)
-		err =3D self.xed_decode(inst.xedp, bytes_ptr, bytes_cnt)
-		if err:
-			return 0, ""
-		# Use AT&T mode (2), alternative is Intel (3)
-		ok =3D self.xed_format_context(2, inst.xedp, inst.bufferp, sizeof(inst.b=
uffer), ip, 0, 0)
-		if not ok:
-			return 0, ""
-		if sys.version_info[0] =3D=3D 2:
-			result =3D inst.buffer.value
-		else:
-			result =3D inst.buffer.value.decode()
-		# Return instruction length and the disassembled instruction text
-		# For now, assume the length is in byte 166
-		return inst.xedd[166], result
diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/script=
s/python/mem-phys-addr.py
deleted file mode 100644
index 5e237a5a5f1b..000000000000
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ /dev/null
@@ -1,127 +0,0 @@
-# mem-phys-addr.py: Resolve physical address samples
-# SPDX-License-Identifier: GPL-2.0
-#
-# Copyright (c) 2018, Intel Corporation.
-
-import os
-import sys
-import re
-import bisect
-import collections
-from dataclasses import dataclass
-from typing import (Dict, Optional)
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-@dataclass(frozen=3DTrue)
-class IomemEntry:
-    """Read from a line in /proc/iomem"""
-    begin: int
-    end: int
-    indent: int
-    label: str
-
-# Physical memory layout from /proc/iomem. Key is the indent and then
-# a list of ranges.
-iomem: Dict[int, list[IomemEntry]] =3D collections.defaultdict(list)
-# Child nodes from the iomem parent.
-children: Dict[IomemEntry, set[IomemEntry]] =3D collections.defaultdict(se=
t)
-# Maximum indent seen before an entry in the iomem file.
-max_indent: int =3D 0
-# Count for each range of memory.
-load_mem_type_cnt: Dict[IomemEntry, int] =3D collections.Counter()
-# Perf event name set from the first sample in the data.
-event_name: Optional[str] =3D None
-
-def parse_iomem():
-    """Populate iomem from /proc/iomem file"""
-    global iomem
-    global max_indent
-    global children
-    with open('/proc/iomem', 'r', encoding=3D'ascii') as f:
-        for line in f:
-            indent =3D 0
-            while line[indent] =3D=3D ' ':
-                indent +=3D 1
-            if indent > max_indent:
-                max_indent =3D indent
-            m =3D re.split('-|:', line, 2)
-            begin =3D int(m[0], 16)
-            end =3D int(m[1], 16)
-            label =3D m[2].strip()
-            entry =3D IomemEntry(begin, end, indent, label)
-            # Before adding entry, search for a parent node using its begi=
n.
-            if indent > 0:
-                parent =3D find_memory_type(begin)
-                assert parent, f"Given indent expected a parent for {label=
}"
-                children[parent].add(entry)
-            iomem[indent].append(entry)
-
-def find_memory_type(phys_addr) -> Optional[IomemEntry]:
-    """Search iomem for the range containing phys_addr with the maximum in=
dent"""
-    for i in range(max_indent, -1, -1):
-        if i not in iomem:
-            continue
-        position =3D bisect.bisect_right(iomem[i], phys_addr,
-                                       key=3Dlambda entry: entry.begin)
-        if position is None:
-            continue
-        iomem_entry =3D iomem[i][position-1]
-        if  iomem_entry.begin <=3D phys_addr <=3D iomem_entry.end:
-            return iomem_entry
-    print(f"Didn't find {phys_addr}")
-    return None
-
-def print_memory_type():
-    print(f"Event: {event_name}")
-    print(f"{'Memory type':<40}  {'count':>10}  {'percentage':>10}")
-    print(f"{'-' * 40:<40}  {'-' * 10:>10}  {'-' * 10:>10}")
-    total =3D sum(load_mem_type_cnt.values())
-    # Add count from children into the parent.
-    for i in range(max_indent, -1, -1):
-        if i not in iomem:
-            continue
-        for entry in iomem[i]:
-            global children
-            for child in children[entry]:
-                if load_mem_type_cnt[child] > 0:
-                    load_mem_type_cnt[entry] +=3D load_mem_type_cnt[child]
-
-    def print_entries(entries):
-        """Print counts from parents down to their children"""
-        global children
-        for entry in sorted(entries,
-                            key =3D lambda entry: load_mem_type_cnt[entry]=
,
-                            reverse =3D True):
-            count =3D load_mem_type_cnt[entry]
-            if count > 0:
-                mem_type =3D ' ' * entry.indent + f"{entry.begin:x}-{entry=
.end:x} : {entry.label}"
-                percent =3D 100 * count / total
-                print(f"{mem_type:<40}  {count:>10}  {percent:>10.1f}")
-                print_entries(children[entry])
-
-    print_entries(iomem[0])
-
-def trace_begin():
-    parse_iomem()
-
-def trace_end():
-    print_memory_type()
-
-def process_event(param_dict):
-    if "sample" not in param_dict:
-        return
-
-    sample =3D param_dict["sample"]
-    if "phys_addr" not in sample:
-        return
-
-    phys_addr  =3D sample["phys_addr"]
-    entry =3D find_memory_type(phys_addr)
-    if entry:
-        load_mem_type_cnt[entry] +=3D 1
-
-    global event_name
-    if event_name is None:
-        event_name  =3D param_dict["ev_name"]
diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scri=
pts/python/net_dropmonitor.py
deleted file mode 100755
index a97e7a6e0940..000000000000
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ /dev/null
@@ -1,78 +0,0 @@
-# Monitor the system for dropped packets and proudce a report of drop loca=
tions and counts
-# SPDX-License-Identifier: GPL-2.0
-
-from __future__ import print_function
-
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from Util import *
-
-drop_log =3D {}
-kallsyms =3D []
-
-def get_kallsyms_table():
-	global kallsyms
-
-	try:
-		f =3D open("/proc/kallsyms", "r")
-	except:
-		return
-
-	for line in f:
-		loc =3D int(line.split()[0], 16)
-		name =3D line.split()[2]
-		kallsyms.append((loc, name))
-	kallsyms.sort()
-
-def get_sym(sloc):
-	loc =3D int(sloc)
-
-	# Invariant: kallsyms[i][0] <=3D loc for all 0 <=3D i <=3D start
-	#            kallsyms[i][0] > loc for all end <=3D i < len(kallsyms)
-	start, end =3D -1, len(kallsyms)
-	while end !=3D start + 1:
-		pivot =3D (start + end) // 2
-		if loc < kallsyms[pivot][0]:
-			end =3D pivot
-		else:
-			start =3D pivot
-
-	# Now (start =3D=3D -1 or kallsyms[start][0] <=3D loc)
-	# and (start =3D=3D len(kallsyms) - 1 or loc < kallsyms[start + 1][0])
-	if start >=3D 0:
-		symloc, name =3D kallsyms[start]
-		return (name, loc - symloc)
-	else:
-		return (None, 0)
-
-def print_drop_table():
-	print("%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT"))
-	for i in drop_log.keys():
-		(sym, off) =3D get_sym(i)
-		if sym =3D=3D None:
-			sym =3D i
-		print("%25s %25s %25s" % (sym, off, drop_log[i]))
-
-
-def trace_begin():
-	print("Starting trace (Ctrl-C to dump results)")
-
-def trace_end():
-	print("Gathering kallsyms data")
-	get_kallsyms_table()
-	print_drop_table()
-
-# called from perf, when it finds a corresponding event
-def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
-		   skbaddr, location, protocol, reason):
-	slocation =3D str(location)
-	try:
-		drop_log[slocation] =3D drop_log[slocation] + 1
-	except:
-		drop_log[slocation] =3D 1
diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts=
/python/netdev-times.py
deleted file mode 100644
index 30c4bccee5b2..000000000000
--- a/tools/perf/scripts/python/netdev-times.py
+++ /dev/null
@@ -1,473 +0,0 @@
-# Display a process of packets and processed time.
-# SPDX-License-Identifier: GPL-2.0
-# It helps us to investigate networking or network device.
-#
-# options
-# tx: show only tx chart
-# rx: show only rx chart
-# dev=3D: show only thing related to specified device
-# debug: work with debug mode. It shows buffer status.
-
-from __future__ import print_function
-
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from Util import *
-from functools import cmp_to_key
-
-all_event_list =3D []; # insert all tracepoint event related with this scr=
ipt
-irq_dic =3D {}; # key is cpu and value is a list which stacks irqs
-              # which raise NET_RX softirq
-net_rx_dic =3D {}; # key is cpu and value include time of NET_RX softirq-e=
ntry
-		 # and a list which stacks receive
-receive_hunk_list =3D []; # a list which include a sequence of receive eve=
nts
-rx_skb_list =3D []; # received packet list for matching
-		       # skb_copy_datagram_iovec
-
-buffer_budget =3D 65536; # the budget of rx_skb_list, tx_queue_list and
-		       # tx_xmit_list
-of_count_rx_skb_list =3D 0; # overflow count
-
-tx_queue_list =3D []; # list of packets which pass through dev_queue_xmit
-of_count_tx_queue_list =3D 0; # overflow count
-
-tx_xmit_list =3D [];  # list of packets which pass through dev_hard_start_=
xmit
-of_count_tx_xmit_list =3D 0; # overflow count
-
-tx_free_list =3D [];  # list of packets which is freed
-
-# options
-show_tx =3D 0;
-show_rx =3D 0;
-dev =3D 0; # store a name of device specified by option "dev=3D"
-debug =3D 0;
-
-# indices of event_info tuple
-EINFO_IDX_NAME=3D   0
-EINFO_IDX_CONTEXT=3D1
-EINFO_IDX_CPU=3D    2
-EINFO_IDX_TIME=3D   3
-EINFO_IDX_PID=3D    4
-EINFO_IDX_COMM=3D   5
-
-# Calculate a time interval(msec) from src(nsec) to dst(nsec)
-def diff_msec(src, dst):
-	return (dst - src) / 1000000.0
-
-# Display a process of transmitting a packet
-def print_transmit(hunk):
-	if dev !=3D 0 and hunk['dev'].find(dev) < 0:
-		return
-	print("%7s %5d %6d.%06dsec %12.3fmsec      %12.3fmsec" %
-		(hunk['dev'], hunk['len'],
-		nsecs_secs(hunk['queue_t']),
-		nsecs_nsecs(hunk['queue_t'])/1000,
-		diff_msec(hunk['queue_t'], hunk['xmit_t']),
-		diff_msec(hunk['xmit_t'], hunk['free_t'])))
-
-# Format for displaying rx packet processing
-PF_IRQ_ENTRY=3D "  irq_entry(+%.3fmsec irq=3D%d:%s)"
-PF_SOFT_ENTRY=3D"  softirq_entry(+%.3fmsec)"
-PF_NAPI_POLL=3D "  napi_poll_exit(+%.3fmsec %s)"
-PF_JOINT=3D     "         |"
-PF_WJOINT=3D    "         |            |"
-PF_NET_RECV=3D  "         |---netif_receive_skb(+%.3fmsec skb=3D%x len=3D%=
d)"
-PF_NET_RX=3D    "         |---netif_rx(+%.3fmsec skb=3D%x)"
-PF_CPY_DGRAM=3D "         |      skb_copy_datagram_iovec(+%.3fmsec %d:%s)"
-PF_KFREE_SKB=3D "         |      kfree_skb(+%.3fmsec location=3D%x)"
-PF_CONS_SKB=3D  "         |      consume_skb(+%.3fmsec)"
-
-# Display a process of received packets and interrputs associated with
-# a NET_RX softirq
-def print_receive(hunk):
-	show_hunk =3D 0
-	irq_list =3D hunk['irq_list']
-	cpu =3D irq_list[0]['cpu']
-	base_t =3D irq_list[0]['irq_ent_t']
-	# check if this hunk should be showed
-	if dev !=3D 0:
-		for i in range(len(irq_list)):
-			if irq_list[i]['name'].find(dev) >=3D 0:
-				show_hunk =3D 1
-				break
-	else:
-		show_hunk =3D 1
-	if show_hunk =3D=3D 0:
-		return
-
-	print("%d.%06dsec cpu=3D%d" %
-		(nsecs_secs(base_t), nsecs_nsecs(base_t)/1000, cpu))
-	for i in range(len(irq_list)):
-		print(PF_IRQ_ENTRY %
-			(diff_msec(base_t, irq_list[i]['irq_ent_t']),
-			irq_list[i]['irq'], irq_list[i]['name']))
-		print(PF_JOINT)
-		irq_event_list =3D irq_list[i]['event_list']
-		for j in range(len(irq_event_list)):
-			irq_event =3D irq_event_list[j]
-			if irq_event['event'] =3D=3D 'netif_rx':
-				print(PF_NET_RX %
-					(diff_msec(base_t, irq_event['time']),
-					irq_event['skbaddr']))
-				print(PF_JOINT)
-	print(PF_SOFT_ENTRY %
-		diff_msec(base_t, hunk['sirq_ent_t']))
-	print(PF_JOINT)
-	event_list =3D hunk['event_list']
-	for i in range(len(event_list)):
-		event =3D event_list[i]
-		if event['event_name'] =3D=3D 'napi_poll':
-			print(PF_NAPI_POLL %
-				(diff_msec(base_t, event['event_t']),
-				event['dev']))
-			if i =3D=3D len(event_list) - 1:
-				print("")
-			else:
-				print(PF_JOINT)
-		else:
-			print(PF_NET_RECV %
-				(diff_msec(base_t, event['event_t']),
-				event['skbaddr'],
-				event['len']))
-			if 'comm' in event.keys():
-				print(PF_WJOINT)
-				print(PF_CPY_DGRAM %
-					(diff_msec(base_t, event['comm_t']),
-					event['pid'], event['comm']))
-			elif 'handle' in event.keys():
-				print(PF_WJOINT)
-				if event['handle'] =3D=3D "kfree_skb":
-					print(PF_KFREE_SKB %
-						(diff_msec(base_t,
-						event['comm_t']),
-						event['location']))
-				elif event['handle'] =3D=3D "consume_skb":
-					print(PF_CONS_SKB %
-						diff_msec(base_t,
-							event['comm_t']))
-			print(PF_JOINT)
-
-def trace_begin():
-	global show_tx
-	global show_rx
-	global dev
-	global debug
-
-	for i in range(len(sys.argv)):
-		if i =3D=3D 0:
-			continue
-		arg =3D sys.argv[i]
-		if arg =3D=3D 'tx':
-			show_tx =3D 1
-		elif arg =3D=3D'rx':
-			show_rx =3D 1
-		elif arg.find('dev=3D',0, 4) >=3D 0:
-			dev =3D arg[4:]
-		elif arg =3D=3D 'debug':
-			debug =3D 1
-	if show_tx =3D=3D 0  and show_rx =3D=3D 0:
-		show_tx =3D 1
-		show_rx =3D 1
-
-def trace_end():
-	# order all events in time
-	all_event_list.sort(key=3Dcmp_to_key(lambda a,b :a[EINFO_IDX_TIME] < b[EI=
NFO_IDX_TIME]))
-	# process all events
-	for i in range(len(all_event_list)):
-		event_info =3D all_event_list[i]
-		name =3D event_info[EINFO_IDX_NAME]
-		if name =3D=3D 'irq__softirq_exit':
-			handle_irq_softirq_exit(event_info)
-		elif name =3D=3D 'irq__softirq_entry':
-			handle_irq_softirq_entry(event_info)
-		elif name =3D=3D 'irq__softirq_raise':
-			handle_irq_softirq_raise(event_info)
-		elif name =3D=3D 'irq__irq_handler_entry':
-			handle_irq_handler_entry(event_info)
-		elif name =3D=3D 'irq__irq_handler_exit':
-			handle_irq_handler_exit(event_info)
-		elif name =3D=3D 'napi__napi_poll':
-			handle_napi_poll(event_info)
-		elif name =3D=3D 'net__netif_receive_skb':
-			handle_netif_receive_skb(event_info)
-		elif name =3D=3D 'net__netif_rx':
-			handle_netif_rx(event_info)
-		elif name =3D=3D 'skb__skb_copy_datagram_iovec':
-			handle_skb_copy_datagram_iovec(event_info)
-		elif name =3D=3D 'net__net_dev_queue':
-			handle_net_dev_queue(event_info)
-		elif name =3D=3D 'net__net_dev_xmit':
-			handle_net_dev_xmit(event_info)
-		elif name =3D=3D 'skb__kfree_skb':
-			handle_kfree_skb(event_info)
-		elif name =3D=3D 'skb__consume_skb':
-			handle_consume_skb(event_info)
-	# display receive hunks
-	if show_rx:
-		for i in range(len(receive_hunk_list)):
-			print_receive(receive_hunk_list[i])
-	# display transmit hunks
-	if show_tx:
-		print("   dev    len      Qdisc        "
-			"       netdevice             free")
-		for i in range(len(tx_free_list)):
-			print_transmit(tx_free_list[i])
-	if debug:
-		print("debug buffer status")
-		print("----------------------------")
-		print("xmit Qdisc:remain:%d overflow:%d" %
-			(len(tx_queue_list), of_count_tx_queue_list))
-		print("xmit netdevice:remain:%d overflow:%d" %
-			(len(tx_xmit_list), of_count_tx_xmit_list))
-		print("receive:remain:%d overflow:%d" %
-			(len(rx_skb_list), of_count_rx_skb_list))
-
-# called from perf, when it finds a correspoinding event
-def irq__softirq_entry(name, context, cpu, sec, nsec, pid, comm, callchain=
, vec):
-	if symbol_str("irq__softirq_entry", "vec", vec) !=3D "NET_RX":
-		return
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm, vec)
-	all_event_list.append(event_info)
-
-def irq__softirq_exit(name, context, cpu, sec, nsec, pid, comm, callchain,=
 vec):
-	if symbol_str("irq__softirq_entry", "vec", vec) !=3D "NET_RX":
-		return
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm, vec)
-	all_event_list.append(event_info)
-
-def irq__softirq_raise(name, context, cpu, sec, nsec, pid, comm, callchain=
, vec):
-	if symbol_str("irq__softirq_entry", "vec", vec) !=3D "NET_RX":
-		return
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm, vec)
-	all_event_list.append(event_info)
-
-def irq__irq_handler_entry(name, context, cpu, sec, nsec, pid, comm,
-			callchain, irq, irq_name):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			irq, irq_name)
-	all_event_list.append(event_info)
-
-def irq__irq_handler_exit(name, context, cpu, sec, nsec, pid, comm, callch=
ain, irq, ret):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm, irq, ret=
)
-	all_event_list.append(event_info)
-
-def napi__napi_poll(name, context, cpu, sec, nsec, pid, comm, callchain, n=
api,
-		dev_name, work=3DNone, budget=3DNone):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			napi, dev_name, work, budget)
-	all_event_list.append(event_info)
-
-def net__netif_receive_skb(name, context, cpu, sec, nsec, pid, comm, callc=
hain, skbaddr,
-			skblen, dev_name):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			skbaddr, skblen, dev_name)
-	all_event_list.append(event_info)
-
-def net__netif_rx(name, context, cpu, sec, nsec, pid, comm, callchain, skb=
addr,
-			skblen, dev_name):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			skbaddr, skblen, dev_name)
-	all_event_list.append(event_info)
-
-def net__net_dev_queue(name, context, cpu, sec, nsec, pid, comm, callchain=
,
-			skbaddr, skblen, dev_name):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			skbaddr, skblen, dev_name)
-	all_event_list.append(event_info)
-
-def net__net_dev_xmit(name, context, cpu, sec, nsec, pid, comm, callchain,
-			skbaddr, skblen, rc, dev_name):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			skbaddr, skblen, rc ,dev_name)
-	all_event_list.append(event_info)
-
-def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
-			skbaddr, location, protocol, reason):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			skbaddr, location, protocol, reason)
-	all_event_list.append(event_info)
-
-def skb__consume_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
-			skbaddr, location):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			skbaddr)
-	all_event_list.append(event_info)
-
-def skb__skb_copy_datagram_iovec(name, context, cpu, sec, nsec, pid, comm,=
 callchain,
-	skbaddr, skblen):
-	event_info =3D (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			skbaddr, skblen)
-	all_event_list.append(event_info)
-
-def handle_irq_handler_entry(event_info):
-	(name, context, cpu, time, pid, comm, irq, irq_name) =3D event_info
-	if cpu not in irq_dic.keys():
-		irq_dic[cpu] =3D []
-	irq_record =3D {'irq':irq, 'name':irq_name, 'cpu':cpu, 'irq_ent_t':time}
-	irq_dic[cpu].append(irq_record)
-
-def handle_irq_handler_exit(event_info):
-	(name, context, cpu, time, pid, comm, irq, ret) =3D event_info
-	if cpu not in irq_dic.keys():
-		return
-	irq_record =3D irq_dic[cpu].pop()
-	if irq !=3D irq_record['irq']:
-		return
-	irq_record.update({'irq_ext_t':time})
-	# if an irq doesn't include NET_RX softirq, drop.
-	if 'event_list' in irq_record.keys():
-		irq_dic[cpu].append(irq_record)
-
-def handle_irq_softirq_raise(event_info):
-	(name, context, cpu, time, pid, comm, vec) =3D event_info
-	if cpu not in irq_dic.keys() \
-	or len(irq_dic[cpu]) =3D=3D 0:
-		return
-	irq_record =3D irq_dic[cpu].pop()
-	if 'event_list' in irq_record.keys():
-		irq_event_list =3D irq_record['event_list']
-	else:
-		irq_event_list =3D []
-	irq_event_list.append({'time':time, 'event':'sirq_raise'})
-	irq_record.update({'event_list':irq_event_list})
-	irq_dic[cpu].append(irq_record)
-
-def handle_irq_softirq_entry(event_info):
-	(name, context, cpu, time, pid, comm, vec) =3D event_info
-	net_rx_dic[cpu] =3D {'sirq_ent_t':time, 'event_list':[]}
-
-def handle_irq_softirq_exit(event_info):
-	(name, context, cpu, time, pid, comm, vec) =3D event_info
-	irq_list =3D []
-	event_list =3D 0
-	if cpu in irq_dic.keys():
-		irq_list =3D irq_dic[cpu]
-		del irq_dic[cpu]
-	if cpu in net_rx_dic.keys():
-		sirq_ent_t =3D net_rx_dic[cpu]['sirq_ent_t']
-		event_list =3D net_rx_dic[cpu]['event_list']
-		del net_rx_dic[cpu]
-	if irq_list =3D=3D [] or event_list =3D=3D 0:
-		return
-	rec_data =3D {'sirq_ent_t':sirq_ent_t, 'sirq_ext_t':time,
-			'irq_list':irq_list, 'event_list':event_list}
-	# merge information related to a NET_RX softirq
-	receive_hunk_list.append(rec_data)
-
-def handle_napi_poll(event_info):
-	(name, context, cpu, time, pid, comm, napi, dev_name,
-		work, budget) =3D event_info
-	if cpu in net_rx_dic.keys():
-		event_list =3D net_rx_dic[cpu]['event_list']
-		rec_data =3D {'event_name':'napi_poll',
-				'dev':dev_name, 'event_t':time,
-				'work':work, 'budget':budget}
-		event_list.append(rec_data)
-
-def handle_netif_rx(event_info):
-	(name, context, cpu, time, pid, comm,
-		skbaddr, skblen, dev_name) =3D event_info
-	if cpu not in irq_dic.keys() \
-	or len(irq_dic[cpu]) =3D=3D 0:
-		return
-	irq_record =3D irq_dic[cpu].pop()
-	if 'event_list' in irq_record.keys():
-		irq_event_list =3D irq_record['event_list']
-	else:
-		irq_event_list =3D []
-	irq_event_list.append({'time':time, 'event':'netif_rx',
-		'skbaddr':skbaddr, 'skblen':skblen, 'dev_name':dev_name})
-	irq_record.update({'event_list':irq_event_list})
-	irq_dic[cpu].append(irq_record)
-
-def handle_netif_receive_skb(event_info):
-	global of_count_rx_skb_list
-
-	(name, context, cpu, time, pid, comm,
-		skbaddr, skblen, dev_name) =3D event_info
-	if cpu in net_rx_dic.keys():
-		rec_data =3D {'event_name':'netif_receive_skb',
-				'event_t':time, 'skbaddr':skbaddr, 'len':skblen}
-		event_list =3D net_rx_dic[cpu]['event_list']
-		event_list.append(rec_data)
-		rx_skb_list.insert(0, rec_data)
-		if len(rx_skb_list) > buffer_budget:
-			rx_skb_list.pop()
-			of_count_rx_skb_list +=3D 1
-
-def handle_net_dev_queue(event_info):
-	global of_count_tx_queue_list
-
-	(name, context, cpu, time, pid, comm,
-		skbaddr, skblen, dev_name) =3D event_info
-	skb =3D {'dev':dev_name, 'skbaddr':skbaddr, 'len':skblen, 'queue_t':time}
-	tx_queue_list.insert(0, skb)
-	if len(tx_queue_list) > buffer_budget:
-		tx_queue_list.pop()
-		of_count_tx_queue_list +=3D 1
-
-def handle_net_dev_xmit(event_info):
-	global of_count_tx_xmit_list
-
-	(name, context, cpu, time, pid, comm,
-		skbaddr, skblen, rc, dev_name) =3D event_info
-	if rc =3D=3D 0: # NETDEV_TX_OK
-		for i in range(len(tx_queue_list)):
-			skb =3D tx_queue_list[i]
-			if skb['skbaddr'] =3D=3D skbaddr:
-				skb['xmit_t'] =3D time
-				tx_xmit_list.insert(0, skb)
-				del tx_queue_list[i]
-				if len(tx_xmit_list) > buffer_budget:
-					tx_xmit_list.pop()
-					of_count_tx_xmit_list +=3D 1
-				return
-
-def handle_kfree_skb(event_info):
-	(name, context, cpu, time, pid, comm,
-		skbaddr, location, protocol, reason) =3D event_info
-	for i in range(len(tx_queue_list)):
-		skb =3D tx_queue_list[i]
-		if skb['skbaddr'] =3D=3D skbaddr:
-			del tx_queue_list[i]
-			return
-	for i in range(len(tx_xmit_list)):
-		skb =3D tx_xmit_list[i]
-		if skb['skbaddr'] =3D=3D skbaddr:
-			skb['free_t'] =3D time
-			tx_free_list.append(skb)
-			del tx_xmit_list[i]
-			return
-	for i in range(len(rx_skb_list)):
-		rec_data =3D rx_skb_list[i]
-		if rec_data['skbaddr'] =3D=3D skbaddr:
-			rec_data.update({'handle':"kfree_skb",
-					'comm':comm, 'pid':pid, 'comm_t':time})
-			del rx_skb_list[i]
-			return
-
-def handle_consume_skb(event_info):
-	(name, context, cpu, time, pid, comm, skbaddr) =3D event_info
-	for i in range(len(tx_xmit_list)):
-		skb =3D tx_xmit_list[i]
-		if skb['skbaddr'] =3D=3D skbaddr:
-			skb['free_t'] =3D time
-			tx_free_list.append(skb)
-			del tx_xmit_list[i]
-			return
-
-def handle_skb_copy_datagram_iovec(event_info):
-	(name, context, cpu, time, pid, comm, skbaddr, skblen) =3D event_info
-	for i in range(len(rx_skb_list)):
-		rec_data =3D rx_skb_list[i]
-		if skbaddr =3D=3D rec_data['skbaddr']:
-			rec_data.update({'handle':"skb_copy_datagram_iovec",
-					'comm':comm, 'pid':pid, 'comm_t':time})
-			del rx_skb_list[i]
-			return
diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scrip=
ts/python/powerpc-hcalls.py
deleted file mode 100644
index 8b78dc790adb..000000000000
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ /dev/null
@@ -1,202 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2018 Ravi Bangoria, IBM Corporation
-#
-# Hypervisor call statisics
-
-from __future__ import print_function
-
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from Util import *
-
-# output: {
-#	opcode: {
-#		'min': minimum time nsec
-#		'max': maximum time nsec
-#		'time': average time nsec
-#		'cnt': counter
-#	} ...
-# }
-output =3D {}
-
-# d_enter: {
-#	cpu: {
-#		opcode: nsec
-#	} ...
-# }
-d_enter =3D {}
-
-hcall_table =3D {
-	4: 'H_REMOVE',
-	8: 'H_ENTER',
-	12: 'H_READ',
-	16: 'H_CLEAR_MOD',
-	20: 'H_CLEAR_REF',
-	24: 'H_PROTECT',
-	28: 'H_GET_TCE',
-	32: 'H_PUT_TCE',
-	36: 'H_SET_SPRG0',
-	40: 'H_SET_DABR',
-	44: 'H_PAGE_INIT',
-	48: 'H_SET_ASR',
-	52: 'H_ASR_ON',
-	56: 'H_ASR_OFF',
-	60: 'H_LOGICAL_CI_LOAD',
-	64: 'H_LOGICAL_CI_STORE',
-	68: 'H_LOGICAL_CACHE_LOAD',
-	72: 'H_LOGICAL_CACHE_STORE',
-	76: 'H_LOGICAL_ICBI',
-	80: 'H_LOGICAL_DCBF',
-	84: 'H_GET_TERM_CHAR',
-	88: 'H_PUT_TERM_CHAR',
-	92: 'H_REAL_TO_LOGICAL',
-	96: 'H_HYPERVISOR_DATA',
-	100: 'H_EOI',
-	104: 'H_CPPR',
-	108: 'H_IPI',
-	112: 'H_IPOLL',
-	116: 'H_XIRR',
-	120: 'H_MIGRATE_DMA',
-	124: 'H_PERFMON',
-	220: 'H_REGISTER_VPA',
-	224: 'H_CEDE',
-	228: 'H_CONFER',
-	232: 'H_PROD',
-	236: 'H_GET_PPP',
-	240: 'H_SET_PPP',
-	244: 'H_PURR',
-	248: 'H_PIC',
-	252: 'H_REG_CRQ',
-	256: 'H_FREE_CRQ',
-	260: 'H_VIO_SIGNAL',
-	264: 'H_SEND_CRQ',
-	272: 'H_COPY_RDMA',
-	276: 'H_REGISTER_LOGICAL_LAN',
-	280: 'H_FREE_LOGICAL_LAN',
-	284: 'H_ADD_LOGICAL_LAN_BUFFER',
-	288: 'H_SEND_LOGICAL_LAN',
-	292: 'H_BULK_REMOVE',
-	304: 'H_MULTICAST_CTRL',
-	308: 'H_SET_XDABR',
-	312: 'H_STUFF_TCE',
-	316: 'H_PUT_TCE_INDIRECT',
-	332: 'H_CHANGE_LOGICAL_LAN_MAC',
-	336: 'H_VTERM_PARTNER_INFO',
-	340: 'H_REGISTER_VTERM',
-	344: 'H_FREE_VTERM',
-	348: 'H_RESET_EVENTS',
-	352: 'H_ALLOC_RESOURCE',
-	356: 'H_FREE_RESOURCE',
-	360: 'H_MODIFY_QP',
-	364: 'H_QUERY_QP',
-	368: 'H_REREGISTER_PMR',
-	372: 'H_REGISTER_SMR',
-	376: 'H_QUERY_MR',
-	380: 'H_QUERY_MW',
-	384: 'H_QUERY_HCA',
-	388: 'H_QUERY_PORT',
-	392: 'H_MODIFY_PORT',
-	396: 'H_DEFINE_AQP1',
-	400: 'H_GET_TRACE_BUFFER',
-	404: 'H_DEFINE_AQP0',
-	408: 'H_RESIZE_MR',
-	412: 'H_ATTACH_MCQP',
-	416: 'H_DETACH_MCQP',
-	420: 'H_CREATE_RPT',
-	424: 'H_REMOVE_RPT',
-	428: 'H_REGISTER_RPAGES',
-	432: 'H_DISABLE_AND_GETC',
-	436: 'H_ERROR_DATA',
-	440: 'H_GET_HCA_INFO',
-	444: 'H_GET_PERF_COUNT',
-	448: 'H_MANAGE_TRACE',
-	468: 'H_FREE_LOGICAL_LAN_BUFFER',
-	472: 'H_POLL_PENDING',
-	484: 'H_QUERY_INT_STATE',
-	580: 'H_ILLAN_ATTRIBUTES',
-	592: 'H_MODIFY_HEA_QP',
-	596: 'H_QUERY_HEA_QP',
-	600: 'H_QUERY_HEA',
-	604: 'H_QUERY_HEA_PORT',
-	608: 'H_MODIFY_HEA_PORT',
-	612: 'H_REG_BCMC',
-	616: 'H_DEREG_BCMC',
-	620: 'H_REGISTER_HEA_RPAGES',
-	624: 'H_DISABLE_AND_GET_HEA',
-	628: 'H_GET_HEA_INFO',
-	632: 'H_ALLOC_HEA_RESOURCE',
-	644: 'H_ADD_CONN',
-	648: 'H_DEL_CONN',
-	664: 'H_JOIN',
-	676: 'H_VASI_STATE',
-	688: 'H_ENABLE_CRQ',
-	696: 'H_GET_EM_PARMS',
-	720: 'H_SET_MPP',
-	724: 'H_GET_MPP',
-	748: 'H_HOME_NODE_ASSOCIATIVITY',
-	756: 'H_BEST_ENERGY',
-	764: 'H_XIRR_X',
-	768: 'H_RANDOM',
-	772: 'H_COP',
-	788: 'H_GET_MPP_X',
-	796: 'H_SET_MODE',
-	61440: 'H_RTAS',
-}
-
-def hcall_table_lookup(opcode):
-	if (opcode in hcall_table):
-		return hcall_table[opcode]
-	else:
-		return opcode
-
-print_ptrn =3D '%-28s%10s%10s%10s%10s'
-
-def trace_end():
-	print(print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
-	print('-' * 68)
-	for opcode in output:
-		h_name =3D hcall_table_lookup(opcode)
-		time =3D output[opcode]['time']
-		cnt =3D output[opcode]['cnt']
-		min_t =3D output[opcode]['min']
-		max_t =3D output[opcode]['max']
-
-		print(print_ptrn % (h_name, cnt, min_t, max_t, time//cnt))
-
-def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchai=
n,
-			opcode, retval):
-	if (cpu in d_enter and opcode in d_enter[cpu]):
-		diff =3D nsecs(sec, nsec) - d_enter[cpu][opcode]
-
-		if (opcode in output):
-			output[opcode]['time'] +=3D diff
-			output[opcode]['cnt'] +=3D 1
-			if (output[opcode]['min'] > diff):
-				output[opcode]['min'] =3D diff
-			if (output[opcode]['max'] < diff):
-				output[opcode]['max'] =3D diff
-		else:
-			output[opcode] =3D {
-				'time': diff,
-				'cnt': 1,
-				'min': diff,
-				'max': diff,
-			}
-
-		del d_enter[cpu][opcode]
-#	else:
-#		print("Can't find matching hcall_enter event. Ignoring sample")
-
-def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
-			 callchain, opcode):
-		if (cpu in d_enter):
-			d_enter[cpu][opcode] =3D nsecs(sec, nsec)
-		else:
-			d_enter[cpu] =3D {opcode: nsecs(sec, nsec)}
diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scri=
pts/python/sched-migration.py
deleted file mode 100644
index 8196e3087c9e..000000000000
--- a/tools/perf/scripts/python/sched-migration.py
+++ /dev/null
@@ -1,462 +0,0 @@
-# Cpu task migration overview toy
-#
-# Copyright (C) 2010 Frederic Weisbecker <fweisbec@gmail.com>
-#
-# perf script event handlers have been generated by perf script -g python
-#
-# This software is distributed under the terms of the GNU General
-# Public License ("GPL") version 2 as published by the Free Software
-# Foundation.
-from __future__ import print_function
-
-import os
-import sys
-
-from collections import defaultdict
-try:
-	from UserList import UserList
-except ImportError:
-	# Python 3: UserList moved to the collections package
-	from collections import UserList
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-sys.path.append('scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from SchedGui import *
-
-
-threads =3D { 0 : "idle"}
-
-def thread_name(pid):
-	return "%s:%d" % (threads[pid], pid)
-
-class RunqueueEventUnknown:
-	@staticmethod
-	def color():
-		return None
-
-	def __repr__(self):
-		return "unknown"
-
-class RunqueueEventSleep:
-	@staticmethod
-	def color():
-		return (0, 0, 0xff)
-
-	def __init__(self, sleeper):
-		self.sleeper =3D sleeper
-
-	def __repr__(self):
-		return "%s gone to sleep" % thread_name(self.sleeper)
-
-class RunqueueEventWakeup:
-	@staticmethod
-	def color():
-		return (0xff, 0xff, 0)
-
-	def __init__(self, wakee):
-		self.wakee =3D wakee
-
-	def __repr__(self):
-		return "%s woke up" % thread_name(self.wakee)
-
-class RunqueueEventFork:
-	@staticmethod
-	def color():
-		return (0, 0xff, 0)
-
-	def __init__(self, child):
-		self.child =3D child
-
-	def __repr__(self):
-		return "new forked task %s" % thread_name(self.child)
-
-class RunqueueMigrateIn:
-	@staticmethod
-	def color():
-		return (0, 0xf0, 0xff)
-
-	def __init__(self, new):
-		self.new =3D new
-
-	def __repr__(self):
-		return "task migrated in %s" % thread_name(self.new)
-
-class RunqueueMigrateOut:
-	@staticmethod
-	def color():
-		return (0xff, 0, 0xff)
-
-	def __init__(self, old):
-		self.old =3D old
-
-	def __repr__(self):
-		return "task migrated out %s" % thread_name(self.old)
-
-class RunqueueSnapshot:
-	def __init__(self, tasks =3D [0], event =3D RunqueueEventUnknown()):
-		self.tasks =3D tuple(tasks)
-		self.event =3D event
-
-	def sched_switch(self, prev, prev_state, next):
-		event =3D RunqueueEventUnknown()
-
-		if taskState(prev_state) =3D=3D "R" and next in self.tasks \
-			and prev in self.tasks:
-			return self
-
-		if taskState(prev_state) !=3D "R":
-			event =3D RunqueueEventSleep(prev)
-
-		next_tasks =3D list(self.tasks[:])
-		if prev in self.tasks:
-			if taskState(prev_state) !=3D "R":
-				next_tasks.remove(prev)
-		elif taskState(prev_state) =3D=3D "R":
-			next_tasks.append(prev)
-
-		if next not in next_tasks:
-			next_tasks.append(next)
-
-		return RunqueueSnapshot(next_tasks, event)
-
-	def migrate_out(self, old):
-		if old not in self.tasks:
-			return self
-		next_tasks =3D [task for task in self.tasks if task !=3D old]
-
-		return RunqueueSnapshot(next_tasks, RunqueueMigrateOut(old))
-
-	def __migrate_in(self, new, event):
-		if new in self.tasks:
-			self.event =3D event
-			return self
-		next_tasks =3D self.tasks[:] + tuple([new])
-
-		return RunqueueSnapshot(next_tasks, event)
-
-	def migrate_in(self, new):
-		return self.__migrate_in(new, RunqueueMigrateIn(new))
-
-	def wake_up(self, new):
-		return self.__migrate_in(new, RunqueueEventWakeup(new))
-
-	def wake_up_new(self, new):
-		return self.__migrate_in(new, RunqueueEventFork(new))
-
-	def load(self):
-		""" Provide the number of tasks on the runqueue.
-		    Don't count idle"""
-		return len(self.tasks) - 1
-
-	def __repr__(self):
-		ret =3D self.tasks.__repr__()
-		ret +=3D self.origin_tostring()
-
-		return ret
-
-class TimeSlice:
-	def __init__(self, start, prev):
-		self.start =3D start
-		self.prev =3D prev
-		self.end =3D start
-		# cpus that triggered the event
-		self.event_cpus =3D []
-		if prev is not None:
-			self.total_load =3D prev.total_load
-			self.rqs =3D prev.rqs.copy()
-		else:
-			self.rqs =3D defaultdict(RunqueueSnapshot)
-			self.total_load =3D 0
-
-	def __update_total_load(self, old_rq, new_rq):
-		diff =3D new_rq.load() - old_rq.load()
-		self.total_load +=3D diff
-
-	def sched_switch(self, ts_list, prev, prev_state, next, cpu):
-		old_rq =3D self.prev.rqs[cpu]
-		new_rq =3D old_rq.sched_switch(prev, prev_state, next)
-
-		if old_rq is new_rq:
-			return
-
-		self.rqs[cpu] =3D new_rq
-		self.__update_total_load(old_rq, new_rq)
-		ts_list.append(self)
-		self.event_cpus =3D [cpu]
-
-	def migrate(self, ts_list, new, old_cpu, new_cpu):
-		if old_cpu =3D=3D new_cpu:
-			return
-		old_rq =3D self.prev.rqs[old_cpu]
-		out_rq =3D old_rq.migrate_out(new)
-		self.rqs[old_cpu] =3D out_rq
-		self.__update_total_load(old_rq, out_rq)
-
-		new_rq =3D self.prev.rqs[new_cpu]
-		in_rq =3D new_rq.migrate_in(new)
-		self.rqs[new_cpu] =3D in_rq
-		self.__update_total_load(new_rq, in_rq)
-
-		ts_list.append(self)
-
-		if old_rq is not out_rq:
-			self.event_cpus.append(old_cpu)
-		self.event_cpus.append(new_cpu)
-
-	def wake_up(self, ts_list, pid, cpu, fork):
-		old_rq =3D self.prev.rqs[cpu]
-		if fork:
-			new_rq =3D old_rq.wake_up_new(pid)
-		else:
-			new_rq =3D old_rq.wake_up(pid)
-
-		if new_rq is old_rq:
-			return
-		self.rqs[cpu] =3D new_rq
-		self.__update_total_load(old_rq, new_rq)
-		ts_list.append(self)
-		self.event_cpus =3D [cpu]
-
-	def next(self, t):
-		self.end =3D t
-		return TimeSlice(t, self)
-
-class TimeSliceList(UserList):
-	def __init__(self, arg =3D []):
-		self.data =3D arg
-
-	def get_time_slice(self, ts):
-		if len(self.data) =3D=3D 0:
-			slice =3D TimeSlice(ts, TimeSlice(-1, None))
-		else:
-			slice =3D self.data[-1].next(ts)
-		return slice
-
-	def find_time_slice(self, ts):
-		start =3D 0
-		end =3D len(self.data)
-		found =3D -1
-		searching =3D True
-		while searching:
-			if start =3D=3D end or start =3D=3D end - 1:
-				searching =3D False
-
-			i =3D (end + start) / 2
-			if self.data[i].start <=3D ts and self.data[i].end >=3D ts:
-				found =3D i
-				end =3D i
-				continue
-
-			if self.data[i].end < ts:
-				start =3D i
-
-			elif self.data[i].start > ts:
-				end =3D i
-
-		return found
-
-	def set_root_win(self, win):
-		self.root_win =3D win
-
-	def mouse_down(self, cpu, t):
-		idx =3D self.find_time_slice(t)
-		if idx =3D=3D -1:
-			return
-
-		ts =3D self[idx]
-		rq =3D ts.rqs[cpu]
-		raw =3D "CPU: %d\n" % cpu
-		raw +=3D "Last event : %s\n" % rq.event.__repr__()
-		raw +=3D "Timestamp : %d.%06d\n" % (ts.start / (10 ** 9), (ts.start % (1=
0 ** 9)) / 1000)
-		raw +=3D "Duration : %6d us\n" % ((ts.end - ts.start) / (10 ** 6))
-		raw +=3D "Load =3D %d\n" % rq.load()
-		for t in rq.tasks:
-			raw +=3D "%s \n" % thread_name(t)
-
-		self.root_win.update_summary(raw)
-
-	def update_rectangle_cpu(self, slice, cpu):
-		rq =3D slice.rqs[cpu]
-
-		if slice.total_load !=3D 0:
-			load_rate =3D rq.load() / float(slice.total_load)
-		else:
-			load_rate =3D 0
-
-		red_power =3D int(0xff - (0xff * load_rate))
-		color =3D (0xff, red_power, red_power)
-
-		top_color =3D None
-
-		if cpu in slice.event_cpus:
-			top_color =3D rq.event.color()
-
-		self.root_win.paint_rectangle_zone(cpu, color, top_color, slice.start, s=
lice.end)
-
-	def fill_zone(self, start, end):
-		i =3D self.find_time_slice(start)
-		if i =3D=3D -1:
-			return
-
-		for i in range(i, len(self.data)):
-			timeslice =3D self.data[i]
-			if timeslice.start > end:
-				return
-
-			for cpu in timeslice.rqs:
-				self.update_rectangle_cpu(timeslice, cpu)
-
-	def interval(self):
-		if len(self.data) =3D=3D 0:
-			return (0, 0)
-
-		return (self.data[0].start, self.data[-1].end)
-
-	def nr_rectangles(self):
-		last_ts =3D self.data[-1]
-		max_cpu =3D 0
-		for cpu in last_ts.rqs:
-			if cpu > max_cpu:
-				max_cpu =3D cpu
-		return max_cpu
-
-
-class SchedEventProxy:
-	def __init__(self):
-		self.current_tsk =3D defaultdict(lambda : -1)
-		self.timeslices =3D TimeSliceList()
-
-	def sched_switch(self, headers, prev_comm, prev_pid, prev_prio, prev_stat=
e,
-			 next_comm, next_pid, next_prio):
-		""" Ensure the task we sched out this cpu is really the one
-		    we logged. Otherwise we may have missed traces """
-
-		on_cpu_task =3D self.current_tsk[headers.cpu]
-
-		if on_cpu_task !=3D -1 and on_cpu_task !=3D prev_pid:
-			print("Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s=
(%d)" % \
-				headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next=
_pid)
-
-		threads[prev_pid] =3D prev_comm
-		threads[next_pid] =3D next_comm
-		self.current_tsk[headers.cpu] =3D next_pid
-
-		ts =3D self.timeslices.get_time_slice(headers.ts())
-		ts.sched_switch(self.timeslices, prev_pid, prev_state, next_pid, headers=
.cpu)
-
-	def migrate(self, headers, pid, prio, orig_cpu, dest_cpu):
-		ts =3D self.timeslices.get_time_slice(headers.ts())
-		ts.migrate(self.timeslices, pid, orig_cpu, dest_cpu)
-
-	def wake_up(self, headers, comm, pid, success, target_cpu, fork):
-		if success =3D=3D 0:
-			return
-		ts =3D self.timeslices.get_time_slice(headers.ts())
-		ts.wake_up(self.timeslices, pid, target_cpu, fork)
-
-
-def trace_begin():
-	global parser
-	parser =3D SchedEventProxy()
-
-def trace_end():
-	app =3D wx.App(False)
-	timeslices =3D parser.timeslices
-	frame =3D RootFrame(timeslices, "Migration")
-	app.MainLoop()
-
-def sched__sched_stat_runtime(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, runtime, vruntime):
-	pass
-
-def sched__sched_stat_iowait(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, delay):
-	pass
-
-def sched__sched_stat_sleep(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, delay):
-	pass
-
-def sched__sched_stat_wait(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, delay):
-	pass
-
-def sched__sched_process_fork(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, parent_comm, parent_pid, child_comm, child_pid):
-	pass
-
-def sched__sched_process_wait(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, prio):
-	pass
-
-def sched__sched_process_exit(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, prio):
-	pass
-
-def sched__sched_process_free(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, prio):
-	pass
-
-def sched__sched_migrate_task(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, prio, orig_cpu,
-	dest_cpu):
-	headers =3D EventHeaders(common_cpu, common_secs, common_nsecs,
-				common_pid, common_comm, common_callchain)
-	parser.migrate(headers, pid, prio, orig_cpu, dest_cpu)
-
-def sched__sched_switch(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm, common_callchain,
-	prev_comm, prev_pid, prev_prio, prev_state,
-	next_comm, next_pid, next_prio):
-
-	headers =3D EventHeaders(common_cpu, common_secs, common_nsecs,
-				common_pid, common_comm, common_callchain)
-	parser.sched_switch(headers, prev_comm, prev_pid, prev_prio, prev_state,
-			 next_comm, next_pid, next_prio)
-
-def sched__sched_wakeup_new(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, prio, success,
-	target_cpu):
-	headers =3D EventHeaders(common_cpu, common_secs, common_nsecs,
-				common_pid, common_comm, common_callchain)
-	parser.wake_up(headers, comm, pid, success, target_cpu, 1)
-
-def sched__sched_wakeup(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, prio, success,
-	target_cpu):
-	headers =3D EventHeaders(common_cpu, common_secs, common_nsecs,
-				common_pid, common_comm, common_callchain)
-	parser.wake_up(headers, comm, pid, success, target_cpu, 0)
-
-def sched__sched_wait_task(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid, prio):
-	pass
-
-def sched__sched_kthread_stop_ret(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, ret):
-	pass
-
-def sched__sched_kthread_stop(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, comm, pid):
-	pass
-
-def trace_unhandled(event_name, context, event_fields_dict):
-	pass
diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python=
/sctop.py
deleted file mode 100644
index 6e0278dcb092..000000000000
--- a/tools/perf/scripts/python/sctop.py
+++ /dev/null
@@ -1,89 +0,0 @@
-# system call top
-# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
-# Licensed under the terms of the GNU GPL License version 2
-#
-# Periodically displays system-wide system call totals, broken down by
-# syscall.  If a [comm] arg is specified, only syscalls called by
-# [comm] are displayed. If an [interval] arg is specified, the display
-# will be refreshed every [interval] seconds.  The default interval is
-# 3 seconds.
-
-from __future__ import print_function
-
-import os, sys, time
-
-try:
-	import thread
-except ImportError:
-	import _thread as thread
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from Util import *
-
-usage =3D "perf script -s sctop.py [comm] [interval]\n";
-
-for_comm =3D None
-default_interval =3D 3
-interval =3D default_interval
-
-if len(sys.argv) > 3:
-	sys.exit(usage)
-
-if len(sys.argv) > 2:
-	for_comm =3D sys.argv[1]
-	interval =3D int(sys.argv[2])
-elif len(sys.argv) > 1:
-	try:
-		interval =3D int(sys.argv[1])
-	except ValueError:
-		for_comm =3D sys.argv[1]
-		interval =3D default_interval
-
-syscalls =3D autodict()
-
-def trace_begin():
-	thread.start_new_thread(print_syscall_totals, (interval,))
-	pass
-
-def raw_syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, id, args):
-	if for_comm is not None:
-		if common_comm !=3D for_comm:
-			return
-	try:
-		syscalls[id] +=3D 1
-	except TypeError:
-		syscalls[id] =3D 1
-
-def syscalls__sys_enter(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	id, args):
-	raw_syscalls__sys_enter(**locals())
-
-def print_syscall_totals(interval):
-	while 1:
-		clear_term()
-		if for_comm is not None:
-			print("\nsyscall events for %s:\n" % (for_comm))
-		else:
-			print("\nsyscall events:\n")
-
-		print("%-40s  %10s" % ("event", "count"))
-		print("%-40s  %10s" %
-			("----------------------------------------",
-			"----------"))
-
-		for id, val in sorted(syscalls.items(),
-				key =3D lambda kv: (kv[1], kv[0]),
-				reverse =3D True):
-			try:
-				print("%-40s  %10d" % (syscall_name(id), val))
-			except TypeError:
-				pass
-		syscalls.clear()
-		time.sleep(interval)
diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/script=
s/python/stackcollapse.py
deleted file mode 100755
index b1c4def1410a..000000000000
--- a/tools/perf/scripts/python/stackcollapse.py
+++ /dev/null
@@ -1,127 +0,0 @@
-# stackcollapse.py - format perf samples with one line per distinct call s=
tack
-# SPDX-License-Identifier: GPL-2.0
-#
-# This script's output has two space-separated fields.  The first is a sem=
icolon
-# separated stack including the program name (from the "comm" field) and t=
he
-# function names from the call stack.  The second is a count:
-#
-#  swapper;start_kernel;rest_init;cpu_idle;default_idle;native_safe_halt 2
-#
-# The file is sorted according to the first field.
-#
-# Input may be created and processed using:
-#
-#  perf record -a -g -F 99 sleep 60
-#  perf script report stackcollapse > out.stacks-folded
-#
-# (perf script record stackcollapse works too).
-#
-# Written by Paolo Bonzini <pbonzini@redhat.com>
-# Based on Brendan Gregg's stackcollapse-perf.pl script.
-
-from __future__ import print_function
-
-import os
-import sys
-from collections import defaultdict
-from optparse import OptionParser, make_option
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from EventClass import *
-
-# command line parsing
-
-option_list =3D [
-    # formatting options for the bottom entry of the stack
-    make_option("--include-tid", dest=3D"include_tid",
-                 action=3D"store_true", default=3DFalse,
-                 help=3D"include thread id in stack"),
-    make_option("--include-pid", dest=3D"include_pid",
-                 action=3D"store_true", default=3DFalse,
-                 help=3D"include process id in stack"),
-    make_option("--no-comm", dest=3D"include_comm",
-                 action=3D"store_false", default=3DTrue,
-                 help=3D"do not separate stacks according to comm"),
-    make_option("--tidy-java", dest=3D"tidy_java",
-                 action=3D"store_true", default=3DFalse,
-                 help=3D"beautify Java signatures"),
-    make_option("--kernel", dest=3D"annotate_kernel",
-                 action=3D"store_true", default=3DFalse,
-                 help=3D"annotate kernel functions with _[k]")
-]
-
-parser =3D OptionParser(option_list=3Doption_list)
-(opts, args) =3D parser.parse_args()
-
-if len(args) !=3D 0:
-    parser.error("unexpected command line argument")
-if opts.include_tid and not opts.include_comm:
-    parser.error("requesting tid but not comm is invalid")
-if opts.include_pid and not opts.include_comm:
-    parser.error("requesting pid but not comm is invalid")
-
-# event handlers
-
-lines =3D defaultdict(lambda: 0)
-
-def process_event(param_dict):
-    def tidy_function_name(sym, dso):
-        if sym is None:
-            sym =3D '[unknown]'
-
-        sym =3D sym.replace(';', ':')
-        if opts.tidy_java:
-            # the original stackcollapse-perf.pl script gives the
-            # example of converting this:
-            #    Lorg/mozilla/javascript/MemberBox;.<init>(Ljava/lang/refl=
ect/Method;)V
-            # to this:
-            #    org/mozilla/javascript/MemberBox:.init
-            sym =3D sym.replace('<', '')
-            sym =3D sym.replace('>', '')
-            if sym[0] =3D=3D 'L' and sym.find('/'):
-                sym =3D sym[1:]
-            try:
-                sym =3D sym[:sym.index('(')]
-            except ValueError:
-                pass
-
-        if opts.annotate_kernel and dso =3D=3D '[kernel.kallsyms]':
-            return sym + '_[k]'
-        else:
-            return sym
-
-    stack =3D list()
-    if 'callchain' in param_dict:
-        for entry in param_dict['callchain']:
-            entry.setdefault('sym', dict())
-            entry['sym'].setdefault('name', None)
-            entry.setdefault('dso', None)
-            stack.append(tidy_function_name(entry['sym']['name'],
-                                            entry['dso']))
-    else:
-        param_dict.setdefault('symbol', None)
-        param_dict.setdefault('dso', None)
-        stack.append(tidy_function_name(param_dict['symbol'],
-                                        param_dict['dso']))
-
-    if opts.include_comm:
-        comm =3D param_dict["comm"].replace(' ', '_')
-        sep =3D "-"
-        if opts.include_pid:
-            comm =3D comm + sep + str(param_dict['sample']['pid'])
-            sep =3D "/"
-        if opts.include_tid:
-            comm =3D comm + sep + str(param_dict['sample']['tid'])
-        stack.append(comm)
-
-    stack_string =3D ';'.join(reversed(stack))
-    lines[stack_string] =3D lines[stack_string] + 1
-
-def trace_end():
-    list =3D sorted(lines)
-    for stack in list:
-        print("%s %d" % (stack, lines[stack]))
diff --git a/tools/perf/scripts/python/stat-cpi.py b/tools/perf/scripts/pyt=
hon/stat-cpi.py
deleted file mode 100644
index 01fa933ff3cf..000000000000
--- a/tools/perf/scripts/python/stat-cpi.py
+++ /dev/null
@@ -1,79 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-from __future__ import print_function
-
-data    =3D {}
-times   =3D []
-threads =3D []
-cpus    =3D []
-
-def get_key(time, event, cpu, thread):
-    return "%d-%s-%d-%d" % (time, event, cpu, thread)
-
-def store_key(time, cpu, thread):
-    if (time not in times):
-        times.append(time)
-
-    if (cpu not in cpus):
-        cpus.append(cpu)
-
-    if (thread not in threads):
-        threads.append(thread)
-
-def store(time, event, cpu, thread, val, ena, run):
-    #print("event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" %
-    #      (event, cpu, thread, time, val, ena, run))
-
-    store_key(time, cpu, thread)
-    key =3D get_key(time, event, cpu, thread)
-    data[key] =3D [ val, ena, run]
-
-def get(time, event, cpu, thread):
-    key =3D get_key(time, event, cpu, thread)
-    return data[key][0]
-
-def stat__cycles_k(cpu, thread, time, val, ena, run):
-    store(time, "cycles", cpu, thread, val, ena, run);
-
-def stat__instructions_k(cpu, thread, time, val, ena, run):
-    store(time, "instructions", cpu, thread, val, ena, run);
-
-def stat__cycles_u(cpu, thread, time, val, ena, run):
-    store(time, "cycles", cpu, thread, val, ena, run);
-
-def stat__instructions_u(cpu, thread, time, val, ena, run):
-    store(time, "instructions", cpu, thread, val, ena, run);
-
-def stat__cycles(cpu, thread, time, val, ena, run):
-    store(time, "cycles", cpu, thread, val, ena, run);
-
-def stat__instructions(cpu, thread, time, val, ena, run):
-    store(time, "instructions", cpu, thread, val, ena, run);
-
-def stat__interval(time):
-    for cpu in cpus:
-        for thread in threads:
-            cyc =3D get(time, "cycles", cpu, thread)
-            ins =3D get(time, "instructions", cpu, thread)
-            cpi =3D 0
-
-            if ins !=3D 0:
-                cpi =3D cyc/float(ins)
-
-            print("%15f: cpu %d, thread %d -> cpi %f (%d/%d)" % (time/(flo=
at(1000000000)), cpu, thread, cpi, cyc, ins))
-
-def trace_end():
-    pass
-# XXX trace_end callback could be used as an alternative place
-#     to compute same values as in the script above:
-#
-#    for time in times:
-#        for cpu in cpus:
-#            for thread in threads:
-#                cyc =3D get(time, "cycles", cpu, thread)
-#                ins =3D get(time, "instructions", cpu, thread)
-#
-#                if ins !=3D 0:
-#                    cpi =3D cyc/float(ins)
-#
-#                print("time %.9f, cpu %d, thread %d -> cpi %f" % (time/(f=
loat(1000000000)), cpu, thread, cpi))
diff --git a/tools/perf/scripts/python/syscall-counts-by-pid.py b/tools/per=
f/scripts/python/syscall-counts-by-pid.py
deleted file mode 100644
index f254e40c6f0f..000000000000
--- a/tools/perf/scripts/python/syscall-counts-by-pid.py
+++ /dev/null
@@ -1,75 +0,0 @@
-# system call counts, by pid
-# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
-# Licensed under the terms of the GNU GPL License version 2
-#
-# Displays system-wide system call totals, broken down by syscall.
-# If a [comm] arg is specified, only syscalls called by [comm] are display=
ed.
-
-from __future__ import print_function
-
-import os, sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from Util import syscall_name
-
-usage =3D "perf script -s syscall-counts-by-pid.py [comm]\n";
-
-for_comm =3D None
-for_pid =3D None
-
-if len(sys.argv) > 2:
-	sys.exit(usage)
-
-if len(sys.argv) > 1:
-	try:
-		for_pid =3D int(sys.argv[1])
-	except:
-		for_comm =3D sys.argv[1]
-
-syscalls =3D autodict()
-
-def trace_begin():
-	print("Press control+C to stop and show the summary")
-
-def trace_end():
-	print_syscall_totals()
-
-def raw_syscalls__sys_enter(event_name, context, common_cpu,
-		common_secs, common_nsecs, common_pid, common_comm,
-		common_callchain, id, args):
-	if (for_comm and common_comm !=3D for_comm) or \
-		(for_pid and common_pid !=3D for_pid ):
-		return
-	try:
-		syscalls[common_comm][common_pid][id] +=3D 1
-	except TypeError:
-		syscalls[common_comm][common_pid][id] =3D 1
-
-def syscalls__sys_enter(event_name, context, common_cpu,
-		common_secs, common_nsecs, common_pid, common_comm,
-		id, args):
-	raw_syscalls__sys_enter(**locals())
-
-def print_syscall_totals():
-	if for_comm is not None:
-		print("\nsyscall events for %s:\n" % (for_comm))
-	else:
-		print("\nsyscall events by comm/pid:\n")
-
-	print("%-40s  %10s" % ("comm [pid]/syscalls", "count"))
-	print("%-40s  %10s" % ("----------------------------------------",
-				"----------"))
-
-	comm_keys =3D syscalls.keys()
-	for comm in comm_keys:
-		pid_keys =3D syscalls[comm].keys()
-		for pid in pid_keys:
-			print("\n%s [%d]" % (comm, pid))
-			id_keys =3D syscalls[comm][pid].keys()
-			for id, val in sorted(syscalls[comm][pid].items(),
-				key =3D lambda kv: (kv[1], kv[0]), reverse =3D True):
-				print("  %-38s  %10d" % (syscall_name(id), val))
diff --git a/tools/perf/scripts/python/syscall-counts.py b/tools/perf/scrip=
ts/python/syscall-counts.py
deleted file mode 100644
index 8adb95ff1664..000000000000
--- a/tools/perf/scripts/python/syscall-counts.py
+++ /dev/null
@@ -1,65 +0,0 @@
-# system call counts
-# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
-# Licensed under the terms of the GNU GPL License version 2
-#
-# Displays system-wide system call totals, broken down by syscall.
-# If a [comm] arg is specified, only syscalls called by [comm] are display=
ed.
-
-from __future__ import print_function
-
-import os
-import sys
-
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
-
-from perf_trace_context import *
-from Core import *
-from Util import syscall_name
-
-usage =3D "perf script -s syscall-counts.py [comm]\n";
-
-for_comm =3D None
-
-if len(sys.argv) > 2:
-	sys.exit(usage)
-
-if len(sys.argv) > 1:
-	for_comm =3D sys.argv[1]
-
-syscalls =3D autodict()
-
-def trace_begin():
-	print("Press control+C to stop and show the summary")
-
-def trace_end():
-	print_syscall_totals()
-
-def raw_syscalls__sys_enter(event_name, context, common_cpu,
-		common_secs, common_nsecs, common_pid, common_comm,
-		common_callchain, id, args):
-	if for_comm is not None:
-		if common_comm !=3D for_comm:
-			return
-	try:
-		syscalls[id] +=3D 1
-	except TypeError:
-		syscalls[id] =3D 1
-
-def syscalls__sys_enter(event_name, context, common_cpu,
-		common_secs, common_nsecs, common_pid, common_comm, id, args):
-	raw_syscalls__sys_enter(**locals())
-
-def print_syscall_totals():
-	if for_comm is not None:
-		print("\nsyscall events for %s:\n" % (for_comm))
-	else:
-		print("\nsyscall events:\n")
-
-	print("%-40s  %10s" % ("event", "count"))
-	print("%-40s  %10s" % ("----------------------------------------",
-				"-----------"))
-
-	for id, val in sorted(syscalls.items(),
-			key =3D lambda kv: (kv[1], kv[0]), reverse =3D True):
-		print("%-40s  %10d" % (syscall_name(id), val))
diff --git a/tools/perf/scripts/python/task-analyzer.py b/tools/perf/script=
s/python/task-analyzer.py
deleted file mode 100755
index 3f1df9894246..000000000000
--- a/tools/perf/scripts/python/task-analyzer.py
+++ /dev/null
@@ -1,934 +0,0 @@
-# task-analyzer.py - comprehensive perf tasks analysis
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2022, Hagen Paul Pfeifer <hagen@jauu.net>
-# Licensed under the terms of the GNU GPL License version 2
-#
-# Usage:
-#
-#     perf record -e sched:sched_switch -a -- sleep 10
-#     perf script report task-analyzer
-#
-
-from __future__ import print_function
-import sys
-import os
-import string
-import argparse
-import decimal
-
-
-sys.path.append(
-    os.environ["PERF_EXEC_PATH"] + "/scripts/python/Perf-Trace-Util/lib/Pe=
rf/Trace"
-)
-from perf_trace_context import *
-from Core import *
-
-# Definition of possible ASCII color codes
-_COLORS =3D {
-    "grey": "\033[90m",
-    "red": "\033[91m",
-    "green": "\033[92m",
-    "yellow": "\033[93m",
-    "blue": "\033[94m",
-    "violet": "\033[95m",
-    "reset": "\033[0m",
-}
-
-# Columns will have a static size to align everything properly
-# Support of 116 days of active update with nano precision
-LEN_SWITCHED_IN =3D len("9999999.999999999")  # 17
-LEN_SWITCHED_OUT =3D len("9999999.999999999")  # 17
-LEN_CPU =3D len("000")
-LEN_PID =3D len("maxvalue")  # 8
-LEN_TID =3D len("maxvalue")  # 8
-LEN_COMM =3D len("max-comms-length")  # 16
-LEN_RUNTIME =3D len("999999.999")  # 10
-# Support of 3.45 hours of timespans
-LEN_OUT_IN =3D len("99999999999.999")  # 15
-LEN_OUT_OUT =3D len("99999999999.999")  # 15
-LEN_IN_IN =3D len("99999999999.999")  # 15
-LEN_IN_OUT =3D len("99999999999.999")  # 15
-
-
-# py2/py3 compatibility layer, see PEP469
-try:
-    dict.iteritems
-except AttributeError:
-    # py3
-    def itervalues(d):
-        return iter(d.values())
-
-    def iteritems(d):
-        return iter(d.items())
-
-else:
-    # py2
-    def itervalues(d):
-        return d.itervalues()
-
-    def iteritems(d):
-        return d.iteritems()
-
-
-def _check_color():
-    global _COLORS
-    """user enforced no-color or if stdout is no tty we disable colors"""
-    if sys.stdout.isatty() and args.stdio_color !=3D "never":
-        return
-    _COLORS =3D {
-        "grey": "",
-        "red": "",
-        "green": "",
-        "yellow": "",
-        "blue": "",
-        "violet": "",
-        "reset": "",
-    }
-
-
-def _parse_args():
-    global args
-    parser =3D argparse.ArgumentParser(description=3D"Analyze tasks behavi=
or")
-    parser.add_argument(
-        "--time-limit",
-        default=3D[],
-        help=3D
-            "print tasks only in time[s] window e.g"
-        " --time-limit 123.111:789.222(print all between 123.111 and 789.2=
22)"
-        " --time-limit 123: (print all from 123)"
-        " --time-limit :456 (print all until incl. 456)",
-    )
-    parser.add_argument(
-        "--summary", action=3D"store_true", help=3D"print addtional runtim=
e information"
-    )
-    parser.add_argument(
-        "--summary-only", action=3D"store_true", help=3D"print only summar=
y without traces"
-    )
-    parser.add_argument(
-        "--summary-extended",
-        action=3D"store_true",
-        help=3D"print the summary with additional information of max inter=
 task times"
-            " relative to the prev task",
-    )
-    parser.add_argument(
-        "--ns", action=3D"store_true", help=3D"show timestamps in nanoseco=
nds"
-    )
-    parser.add_argument(
-        "--ms", action=3D"store_true", help=3D"show timestamps in millisec=
onds"
-    )
-    parser.add_argument(
-        "--extended-times",
-        action=3D"store_true",
-        help=3D"Show the elapsed times between schedule in/schedule out"
-            " of this task and the schedule in/schedule out of previous oc=
currence"
-            " of the same task",
-    )
-    parser.add_argument(
-        "--filter-tasks",
-        default=3D[],
-        help=3D"filter out unneeded tasks by tid, pid or processname."
-        " E.g --filter-task 1337,/sbin/init ",
-    )
-    parser.add_argument(
-        "--limit-to-tasks",
-        default=3D[],
-        help=3D"limit output to selected task by tid, pid, processname."
-        " E.g --limit-to-tasks 1337,/sbin/init",
-    )
-    parser.add_argument(
-        "--highlight-tasks",
-        default=3D"",
-        help=3D"colorize special tasks by their pid/tid/comm."
-        " E.g. --highlight-tasks 1:red,mutt:yellow"
-        " Colors available: red,grey,yellow,blue,violet,green",
-    )
-    parser.add_argument(
-        "--rename-comms-by-tids",
-        default=3D"",
-        help=3D"rename task names by using tid (<tid>:<newname>,<tid>:<new=
name>)"
-            " This option is handy for inexpressive processnames like pyth=
on interpreted"
-            " process. E.g --rename 1337:my-python-app",
-    )
-    parser.add_argument(
-        "--stdio-color",
-        default=3D"auto",
-        choices=3D["always", "never", "auto"],
-        help=3D"always, never or auto, allowing configuring color output"
-            " via the command line",
-    )
-    parser.add_argument(
-        "--csv",
-        default=3D"",
-        help=3D"Write trace to file selected by user. Options, like --ns o=
r --extended"
-            "-times are used.",
-    )
-    parser.add_argument(
-        "--csv-summary",
-        default=3D"",
-        help=3D"Write summary to file selected by user. Options, like --ns=
 or"
-            " --summary-extended are used.",
-    )
-    args =3D parser.parse_args()
-    args.tid_renames =3D dict()
-
-    _argument_filter_sanity_check()
-    _argument_prepare_check()
-
-
-def time_uniter(unit):
-    picker =3D {
-        "s": 1,
-        "ms": 1e3,
-        "us": 1e6,
-        "ns": 1e9,
-    }
-    return picker[unit]
-
-
-def _init_db():
-    global db
-    db =3D dict()
-    db["running"] =3D dict()
-    db["cpu"] =3D dict()
-    db["tid"] =3D dict()
-    db["global"] =3D []
-    if args.summary or args.summary_extended or args.summary_only:
-        db["task_info"] =3D dict()
-        db["runtime_info"] =3D dict()
-        # min values for summary depending on the header
-        db["task_info"]["pid"] =3D len("PID")
-        db["task_info"]["tid"] =3D len("TID")
-        db["task_info"]["comm"] =3D len("Comm")
-        db["runtime_info"]["runs"] =3D len("Runs")
-        db["runtime_info"]["acc"] =3D len("Accumulated")
-        db["runtime_info"]["max"] =3D len("Max")
-        db["runtime_info"]["max_at"] =3D len("Max At")
-        db["runtime_info"]["min"] =3D len("Min")
-        db["runtime_info"]["mean"] =3D len("Mean")
-        db["runtime_info"]["median"] =3D len("Median")
-        if args.summary_extended:
-            db["inter_times"] =3D dict()
-            db["inter_times"]["out_in"] =3D len("Out-In")
-            db["inter_times"]["inter_at"] =3D len("At")
-            db["inter_times"]["out_out"] =3D len("Out-Out")
-            db["inter_times"]["in_in"] =3D len("In-In")
-            db["inter_times"]["in_out"] =3D len("In-Out")
-
-
-def _median(numbers):
-    """phython3 hat statistics module - we have nothing"""
-    n =3D len(numbers)
-    index =3D n // 2
-    if n % 2:
-        return sorted(numbers)[index]
-    return sum(sorted(numbers)[index - 1 : index + 1]) / 2
-
-
-def _mean(numbers):
-    return sum(numbers) / len(numbers)
-
-
-class Timespans(object):
-    """
-    The elapsed time between two occurrences of the same task is being tra=
cked with the
-    help of this class. There are 4 of those Timespans Out-Out, In-Out, Ou=
t-In and
-    In-In.
-    The first half of the name signals the first time point of the
-    first task. The second half of the name represents the second
-    timepoint of the second task.
-    """
-
-    def __init__(self):
-        self._last_start =3D None
-        self._last_finish =3D None
-        self.out_out =3D -1
-        self.in_out =3D -1
-        self.out_in =3D -1
-        self.in_in =3D -1
-        if args.summary_extended:
-            self._time_in =3D -1
-            self.max_out_in =3D -1
-            self.max_at =3D -1
-            self.max_in_out =3D -1
-            self.max_in_in =3D -1
-            self.max_out_out =3D -1
-
-    def feed(self, task):
-        """
-        Called for every recorded trace event to find process pair and cal=
culate the
-        task timespans. Chronological ordering, feed does not do reorderin=
g
-        """
-        if not self._last_finish:
-            self._last_start =3D task.time_in(time_unit)
-            self._last_finish =3D task.time_out(time_unit)
-            return
-        self._time_in =3D task.time_in()
-        time_in =3D task.time_in(time_unit)
-        time_out =3D task.time_out(time_unit)
-        self.in_in =3D time_in - self._last_start
-        self.out_in =3D time_in - self._last_finish
-        self.in_out =3D time_out - self._last_start
-        self.out_out =3D time_out - self._last_finish
-        if args.summary_extended:
-            self._update_max_entries()
-        self._last_finish =3D task.time_out(time_unit)
-        self._last_start =3D task.time_in(time_unit)
-
-    def _update_max_entries(self):
-        if self.in_in > self.max_in_in:
-            self.max_in_in =3D self.in_in
-        if self.out_out > self.max_out_out:
-            self.max_out_out =3D self.out_out
-        if self.in_out > self.max_in_out:
-            self.max_in_out =3D self.in_out
-        if self.out_in > self.max_out_in:
-            self.max_out_in =3D self.out_in
-            self.max_at =3D self._time_in
-
-
-
-class Summary(object):
-    """
-    Primary instance for calculating the summary output. Processes the who=
le trace to
-    find and memorize relevant data such as mean, max et cetera. This inst=
ance handles
-    dynamic alignment aspects for summary output.
-    """
-
-    def __init__(self):
-        self._body =3D []
-
-    class AlignmentHelper:
-        """
-        Used to calculated the alignment for the output of the summary.
-        """
-        def __init__(self, pid, tid, comm, runs, acc, mean,
-                    median, min, max, max_at):
-            self.pid =3D pid
-            self.tid =3D tid
-            self.comm =3D comm
-            self.runs =3D runs
-            self.acc =3D acc
-            self.mean =3D mean
-            self.median =3D median
-            self.min =3D min
-            self.max =3D max
-            self.max_at =3D max_at
-            if args.summary_extended:
-                self.out_in =3D None
-                self.inter_at =3D None
-                self.out_out =3D None
-                self.in_in =3D None
-                self.in_out =3D None
-
-    def _print_header(self):
-        '''
-        Output is trimmed in _format_stats thus additional adjustment in t=
he header
-        is needed, depending on the choice of timeunit. The adjustment cor=
responds
-        to the amount of column titles being adjusted in _column_titles.
-        '''
-        decimal_precision =3D 6 if not args.ns else 9
-        fmt =3D " {{:^{}}}".format(sum(db["task_info"].values()))
-        fmt +=3D " {{:^{}}}".format(
-            sum(db["runtime_info"].values()) - 2 * decimal_precision
-            )
-        _header =3D ("Task Information", "Runtime Information")
-
-        if args.summary_extended:
-            fmt +=3D " {{:^{}}}".format(
-                sum(db["inter_times"].values()) - 4 * decimal_precision
-                )
-            _header +=3D ("Max Inter Task Times",)
-        fd_sum.write(fmt.format(*_header) +  "\n")
-
-    def _column_titles(self):
-        """
-        Cells are being processed and displayed in different way so an ali=
gnment adjust
-        is implemented depeding on the choice of the timeunit. The positio=
ns of the max
-        values are being displayed in grey. Thus in their format two addit=
ional {},
-        are placed for color set and reset.
-        """
-        separator, fix_csv_align =3D _prepare_fmt_sep()
-        decimal_precision, time_precision =3D _prepare_fmt_precision()
-        fmt =3D "{{:>{}}}".format(db["task_info"]["pid"] * fix_csv_align)
-        fmt +=3D "{}{{:>{}}}".format(separator, db["task_info"]["tid"] * f=
ix_csv_align)
-        fmt +=3D "{}{{:>{}}}".format(separator, db["task_info"]["comm"] * =
fix_csv_align)
-        fmt +=3D "{}{{:>{}}}".format(separator, db["runtime_info"]["runs"]=
 * fix_csv_align)
-        fmt +=3D "{}{{:>{}}}".format(separator, db["runtime_info"]["acc"] =
* fix_csv_align)
-        fmt +=3D "{}{{:>{}}}".format(separator, db["runtime_info"]["mean"]=
 * fix_csv_align)
-        fmt +=3D "{}{{:>{}}}".format(
-            separator, db["runtime_info"]["median"] * fix_csv_align
-        )
-        fmt +=3D "{}{{:>{}}}".format(
-            separator, (db["runtime_info"]["min"] - decimal_precision) * f=
ix_csv_align
-        )
-        fmt +=3D "{}{{:>{}}}".format(
-            separator, (db["runtime_info"]["max"] - decimal_precision) * f=
ix_csv_align
-        )
-        fmt +=3D "{}{{}}{{:>{}}}{{}}".format(
-            separator, (db["runtime_info"]["max_at"] - time_precision) * f=
ix_csv_align
-        )
-
-        column_titles =3D ("PID", "TID", "Comm")
-        column_titles +=3D ("Runs", "Accumulated", "Mean", "Median", "Min"=
, "Max")
-        column_titles +=3D (_COLORS["grey"], "Max At", _COLORS["reset"])
-
-        if args.summary_extended:
-            fmt +=3D "{}{{:>{}}}".format(
-                separator,
-                (db["inter_times"]["out_in"] - decimal_precision) * fix_cs=
v_align
-            )
-            fmt +=3D "{}{{}}{{:>{}}}{{}}".format(
-                separator,
-                (db["inter_times"]["inter_at"] - time_precision) * fix_csv=
_align
-            )
-            fmt +=3D "{}{{:>{}}}".format(
-                separator,
-                (db["inter_times"]["out_out"] - decimal_precision) * fix_c=
sv_align
-            )
-            fmt +=3D "{}{{:>{}}}".format(
-                separator,
-                (db["inter_times"]["in_in"] - decimal_precision) * fix_csv=
_align
-            )
-            fmt +=3D "{}{{:>{}}}".format(
-                separator,
-                (db["inter_times"]["in_out"] - decimal_precision) * fix_cs=
v_align
-            )
-
-            column_titles +=3D ("Out-In", _COLORS["grey"], "Max At", _COLO=
RS["reset"],
-                        "Out-Out", "In-In", "In-Out")
-
-        fd_sum.write(fmt.format(*column_titles) + "\n")
-
-
-    def _task_stats(self):
-        """calculates the stats of every task and constructs the printable=
 summary"""
-        for tid in sorted(db["tid"]):
-            color_one_sample =3D _COLORS["grey"]
-            color_reset =3D _COLORS["reset"]
-            no_executed =3D 0
-            runtimes =3D []
-            time_in =3D []
-            timespans =3D Timespans()
-            for task in db["tid"][tid]:
-                pid =3D task.pid
-                comm =3D task.comm
-                no_executed +=3D 1
-                runtimes.append(task.runtime(time_unit))
-                time_in.append(task.time_in())
-                timespans.feed(task)
-            if len(runtimes) > 1:
-                color_one_sample =3D ""
-                color_reset =3D ""
-            time_max =3D max(runtimes)
-            time_min =3D min(runtimes)
-            max_at =3D time_in[runtimes.index(max(runtimes))]
-
-            # The size of the decimal after sum,mean and median varies, th=
us we cut
-            # the decimal number, by rounding it. It has no impact on the =
output,
-            # because we have a precision of the decimal points at the out=
put.
-            time_sum =3D round(sum(runtimes), 3)
-            time_mean =3D round(_mean(runtimes), 3)
-            time_median =3D round(_median(runtimes), 3)
-
-            align_helper =3D self.AlignmentHelper(pid, tid, comm, no_execu=
ted, time_sum,
-                                    time_mean, time_median, time_min, time=
_max, max_at)
-            self._body.append([pid, tid, comm, no_executed, time_sum, colo=
r_one_sample,
-                                time_mean, time_median, time_min, time_max=
,
-                                _COLORS["grey"], max_at, _COLORS["reset"],=
 color_reset])
-            if args.summary_extended:
-                self._body[-1].extend([timespans.max_out_in,
-                                _COLORS["grey"], timespans.max_at,
-                                _COLORS["reset"], timespans.max_out_out,
-                                timespans.max_in_in,
-                                timespans.max_in_out])
-                align_helper.out_in =3D timespans.max_out_in
-                align_helper.inter_at =3D timespans.max_at
-                align_helper.out_out =3D timespans.max_out_out
-                align_helper.in_in =3D timespans.max_in_in
-                align_helper.in_out =3D timespans.max_in_out
-            self._calc_alignments_summary(align_helper)
-
-    def _format_stats(self):
-        separator, fix_csv_align =3D _prepare_fmt_sep()
-        decimal_precision, time_precision =3D _prepare_fmt_precision()
-        len_pid =3D db["task_info"]["pid"] * fix_csv_align
-        len_tid =3D db["task_info"]["tid"] * fix_csv_align
-        len_comm =3D db["task_info"]["comm"] * fix_csv_align
-        len_runs =3D db["runtime_info"]["runs"] * fix_csv_align
-        len_acc =3D db["runtime_info"]["acc"] * fix_csv_align
-        len_mean =3D db["runtime_info"]["mean"] * fix_csv_align
-        len_median =3D db["runtime_info"]["median"] * fix_csv_align
-        len_min =3D (db["runtime_info"]["min"] - decimal_precision) * fix_=
csv_align
-        len_max =3D (db["runtime_info"]["max"] - decimal_precision) * fix_=
csv_align
-        len_max_at =3D (db["runtime_info"]["max_at"] - time_precision) * f=
ix_csv_align
-        if args.summary_extended:
-            len_out_in =3D (
-                db["inter_times"]["out_in"] - decimal_precision
-            ) * fix_csv_align
-            len_inter_at =3D (
-                db["inter_times"]["inter_at"] - time_precision
-            ) * fix_csv_align
-            len_out_out =3D (
-                db["inter_times"]["out_out"] - decimal_precision
-            ) * fix_csv_align
-            len_in_in =3D (db["inter_times"]["in_in"] - decimal_precision)=
 * fix_csv_align
-            len_in_out =3D (
-                db["inter_times"]["in_out"] - decimal_precision
-            ) * fix_csv_align
-
-        fmt =3D "{{:{}d}}".format(len_pid)
-        fmt +=3D "{}{{:{}d}}".format(separator, len_tid)
-        fmt +=3D "{}{{:>{}}}".format(separator, len_comm)
-        fmt +=3D "{}{{:{}d}}".format(separator, len_runs)
-        fmt +=3D "{}{{:{}.{}f}}".format(separator, len_acc, time_precision=
)
-        fmt +=3D "{}{{}}{{:{}.{}f}}".format(separator, len_mean, time_prec=
ision)
-        fmt +=3D "{}{{:{}.{}f}}".format(separator, len_median, time_precis=
ion)
-        fmt +=3D "{}{{:{}.{}f}}".format(separator, len_min, time_precision=
)
-        fmt +=3D "{}{{:{}.{}f}}".format(separator, len_max, time_precision=
)
-        fmt +=3D "{}{{}}{{:{}.{}f}}{{}}{{}}".format(
-            separator, len_max_at, decimal_precision
-        )
-        if args.summary_extended:
-            fmt +=3D "{}{{:{}.{}f}}".format(separator, len_out_in, time_pr=
ecision)
-            fmt +=3D "{}{{}}{{:{}.{}f}}{{}}".format(
-                separator, len_inter_at, decimal_precision
-            )
-            fmt +=3D "{}{{:{}.{}f}}".format(separator, len_out_out, time_p=
recision)
-            fmt +=3D "{}{{:{}.{}f}}".format(separator, len_in_in, time_pre=
cision)
-            fmt +=3D "{}{{:{}.{}f}}".format(separator, len_in_out, time_pr=
ecision)
-        return fmt
-
-
-    def _calc_alignments_summary(self, align_helper):
-        # Length is being cut in 3 groups so that further addition is easi=
er to handle.
-        # The length of every argument from the alignment helper is being =
checked if it
-        # is longer than the longest until now. In that case the length is=
 being saved.
-        for key in db["task_info"]:
-            if len(str(getattr(align_helper, key))) > db["task_info"][key]=
:
-                db["task_info"][key] =3D len(str(getattr(align_helper, key=
)))
-        for key in db["runtime_info"]:
-            if len(str(getattr(align_helper, key))) > db["runtime_info"][k=
ey]:
-                db["runtime_info"][key] =3D len(str(getattr(align_helper, =
key)))
-        if args.summary_extended:
-            for key in db["inter_times"]:
-                if len(str(getattr(align_helper, key))) > db["inter_times"=
][key]:
-                    db["inter_times"][key] =3D len(str(getattr(align_helpe=
r, key)))
-
-
-    def print(self):
-        self._task_stats()
-        fmt =3D self._format_stats()
-
-        if not args.csv_summary:
-            print("\nSummary")
-            self._print_header()
-        self._column_titles()
-        for i in range(len(self._body)):
-            fd_sum.write(fmt.format(*tuple(self._body[i])) + "\n")
-
-
-
-class Task(object):
-    """ The class is used to handle the information of a given task."""
-
-    def __init__(self, id, tid, cpu, comm):
-        self.id =3D id
-        self.tid =3D tid
-        self.cpu =3D cpu
-        self.comm =3D comm
-        self.pid =3D None
-        self._time_in =3D None
-        self._time_out =3D None
-
-    def schedule_in_at(self, time):
-        """set the time where the task was scheduled in"""
-        self._time_in =3D time
-
-    def schedule_out_at(self, time):
-        """set the time where the task was scheduled out"""
-        self._time_out =3D time
-
-    def time_out(self, unit=3D"s"):
-        """return time where a given task was scheduled out"""
-        factor =3D time_uniter(unit)
-        return self._time_out * decimal.Decimal(factor)
-
-    def time_in(self, unit=3D"s"):
-        """return time where a given task was scheduled in"""
-        factor =3D time_uniter(unit)
-        return self._time_in * decimal.Decimal(factor)
-
-    def runtime(self, unit=3D"us"):
-        factor =3D time_uniter(unit)
-        return (self._time_out - self._time_in) * decimal.Decimal(factor)
-
-    def update_pid(self, pid):
-        self.pid =3D pid
-
-
-def _task_id(pid, cpu):
-    """returns a "unique-enough" identifier, please do not change"""
-    return "{}-{}".format(pid, cpu)
-
-
-def _filter_non_printable(unfiltered):
-    """comm names may contain loony chars like '\x00000'"""
-    filtered =3D ""
-    for char in unfiltered:
-        if char not in string.printable:
-            continue
-        filtered +=3D char
-    return filtered
-
-
-def _fmt_header():
-    separator, fix_csv_align =3D _prepare_fmt_sep()
-    fmt =3D "{{:>{}}}".format(LEN_SWITCHED_IN*fix_csv_align)
-    fmt +=3D "{}{{:>{}}}".format(separator, LEN_SWITCHED_OUT*fix_csv_align=
)
-    fmt +=3D "{}{{:>{}}}".format(separator, LEN_CPU*fix_csv_align)
-    fmt +=3D "{}{{:>{}}}".format(separator, LEN_PID*fix_csv_align)
-    fmt +=3D "{}{{:>{}}}".format(separator, LEN_TID*fix_csv_align)
-    fmt +=3D "{}{{:>{}}}".format(separator, LEN_COMM*fix_csv_align)
-    fmt +=3D "{}{{:>{}}}".format(separator, LEN_RUNTIME*fix_csv_align)
-    fmt +=3D "{}{{:>{}}}".format(separator, LEN_OUT_IN*fix_csv_align)
-    if args.extended_times:
-        fmt +=3D "{}{{:>{}}}".format(separator, LEN_OUT_OUT*fix_csv_align)
-        fmt +=3D "{}{{:>{}}}".format(separator, LEN_IN_IN*fix_csv_align)
-        fmt +=3D "{}{{:>{}}}".format(separator, LEN_IN_OUT*fix_csv_align)
-    return fmt
-
-
-def _fmt_body():
-    separator, fix_csv_align =3D _prepare_fmt_sep()
-    decimal_precision, time_precision =3D _prepare_fmt_precision()
-    fmt =3D "{{}}{{:{}.{}f}}".format(LEN_SWITCHED_IN*fix_csv_align, decima=
l_precision)
-    fmt +=3D "{}{{:{}.{}f}}".format(
-        separator, LEN_SWITCHED_OUT*fix_csv_align, decimal_precision
-    )
-    fmt +=3D "{}{{:{}d}}".format(separator, LEN_CPU*fix_csv_align)
-    fmt +=3D "{}{{:{}d}}".format(separator, LEN_PID*fix_csv_align)
-    fmt +=3D "{}{{}}{{:{}d}}{{}}".format(separator, LEN_TID*fix_csv_align)
-    fmt +=3D "{}{{}}{{:>{}}}".format(separator, LEN_COMM*fix_csv_align)
-    fmt +=3D "{}{{:{}.{}f}}".format(separator, LEN_RUNTIME*fix_csv_align, =
time_precision)
-    if args.extended_times:
-        fmt +=3D "{}{{:{}.{}f}}".format(separator, LEN_OUT_IN*fix_csv_alig=
n, time_precision)
-        fmt +=3D "{}{{:{}.{}f}}".format(separator, LEN_OUT_OUT*fix_csv_ali=
gn, time_precision)
-        fmt +=3D "{}{{:{}.{}f}}".format(separator, LEN_IN_IN*fix_csv_align=
, time_precision)
-        fmt +=3D "{}{{:{}.{}f}}{{}}".format(
-            separator, LEN_IN_OUT*fix_csv_align, time_precision
-        )
-    else:
-        fmt +=3D "{}{{:{}.{}f}}{{}}".format(
-            separator, LEN_OUT_IN*fix_csv_align, time_precision
-        )
-    return fmt
-
-
-def _print_header():
-    fmt =3D _fmt_header()
-    header =3D ("Switched-In", "Switched-Out", "CPU", "PID", "TID", "Comm"=
, "Runtime",
-            "Time Out-In")
-    if args.extended_times:
-        header +=3D ("Time Out-Out", "Time In-In", "Time In-Out")
-    fd_task.write(fmt.format(*header) + "\n")
-
-
-
-def _print_task_finish(task):
-    """calculating every entry of a row and printing it immediately"""
-    c_row_set =3D ""
-    c_row_reset =3D ""
-    out_in =3D -1
-    out_out =3D -1
-    in_in =3D -1
-    in_out =3D -1
-    fmt =3D _fmt_body()
-    # depending on user provided highlight option we change the color
-    # for particular tasks
-    if str(task.tid) in args.highlight_tasks_map:
-        c_row_set =3D _COLORS[args.highlight_tasks_map[str(task.tid)]]
-        c_row_reset =3D _COLORS["reset"]
-    if task.comm in args.highlight_tasks_map:
-        c_row_set =3D _COLORS[args.highlight_tasks_map[task.comm]]
-        c_row_reset =3D _COLORS["reset"]
-    # grey-out entries if PID =3D=3D TID, they
-    # are identical, no threaded model so the
-    # thread id (tid) do not matter
-    c_tid_set =3D ""
-    c_tid_reset =3D ""
-    if task.pid =3D=3D task.tid:
-        c_tid_set =3D _COLORS["grey"]
-        c_tid_reset =3D _COLORS["reset"]
-    if task.tid in db["tid"]:
-        # get last task of tid
-        last_tid_task =3D db["tid"][task.tid][-1]
-        # feed the timespan calculate, last in tid db
-        # and second the current one
-        timespan_gap_tid =3D Timespans()
-        timespan_gap_tid.feed(last_tid_task)
-        timespan_gap_tid.feed(task)
-        out_in =3D timespan_gap_tid.out_in
-        out_out =3D timespan_gap_tid.out_out
-        in_in =3D timespan_gap_tid.in_in
-        in_out =3D timespan_gap_tid.in_out
-
-
-    if args.extended_times:
-        line_out =3D fmt.format(c_row_set, task.time_in(), task.time_out()=
, task.cpu,
-                        task.pid, c_tid_set, task.tid, c_tid_reset, c_row_=
set, task.comm,
-                        task.runtime(time_unit), out_in, out_out, in_in, i=
n_out,
-                        c_row_reset) + "\n"
-    else:
-        line_out =3D fmt.format(c_row_set, task.time_in(), task.time_out()=
, task.cpu,
-                        task.pid, c_tid_set, task.tid, c_tid_reset, c_row_=
set, task.comm,
-                        task.runtime(time_unit), out_in, c_row_reset) + "\=
n"
-    try:
-        fd_task.write(line_out)
-    except(IOError):
-        # don't mangle the output if user SIGINT this script
-        sys.exit()
-
-def _record_cleanup(_list):
-    """
-    no need to store more then one element if --summarize
-    is not enabled
-    """
-    if not args.summary and len(_list) > 1:
-        _list =3D _list[len(_list) - 1 :]
-
-
-def _record_by_tid(task):
-    tid =3D task.tid
-    if tid not in db["tid"]:
-        db["tid"][tid] =3D []
-    db["tid"][tid].append(task)
-    _record_cleanup(db["tid"][tid])
-
-
-def _record_by_cpu(task):
-    cpu =3D task.cpu
-    if cpu not in db["cpu"]:
-        db["cpu"][cpu] =3D []
-    db["cpu"][cpu].append(task)
-    _record_cleanup(db["cpu"][cpu])
-
-
-def _record_global(task):
-    """record all executed task, ordered by finish chronological"""
-    db["global"].append(task)
-    _record_cleanup(db["global"])
-
-
-def _handle_task_finish(tid, cpu, time, perf_sample_dict):
-    if tid =3D=3D 0:
-        return
-    _id =3D _task_id(tid, cpu)
-    if _id not in db["running"]:
-        # may happen, if we missed the switch to
-        # event. Seen in combination with --exclude-perf
-        # where the start is filtered out, but not the
-        # switched in. Probably a bug in exclude-perf
-        # option.
-        return
-    task =3D db["running"][_id]
-    task.schedule_out_at(time)
-
-    # record tid, during schedule in the tid
-    # is not available, update now
-    pid =3D int(perf_sample_dict["sample"]["pid"])
-
-    task.update_pid(pid)
-    del db["running"][_id]
-
-    # print only tasks which are not being filtered and no print of trace
-    # for summary only, but record every task.
-    if not _limit_filtered(tid, pid, task.comm) and not args.summary_only:
-        _print_task_finish(task)
-    _record_by_tid(task)
-    _record_by_cpu(task)
-    _record_global(task)
-
-
-def _handle_task_start(tid, cpu, comm, time):
-    if tid =3D=3D 0:
-        return
-    if tid in args.tid_renames:
-        comm =3D args.tid_renames[tid]
-    _id =3D _task_id(tid, cpu)
-    if _id in db["running"]:
-        # handle corner cases where already running tasks
-        # are switched-to again - saw this via --exclude-perf
-        # recorded traces. We simple ignore this "second start"
-        # event.
-        return
-    assert _id not in db["running"]
-    task =3D Task(_id, tid, cpu, comm)
-    task.schedule_in_at(time)
-    db["running"][_id] =3D task
-
-
-def _time_to_internal(time_ns):
-    """
-    To prevent float rounding errors we use Decimal internally
-    """
-    return decimal.Decimal(time_ns) / decimal.Decimal(1e9)
-
-
-def _limit_filtered(tid, pid, comm):
-    if args.filter_tasks:
-        if str(tid) in args.filter_tasks or comm in args.filter_tasks:
-            return True
-        else:
-            return False
-    if args.limit_to_tasks:
-        if str(tid) in args.limit_to_tasks or comm in args.limit_to_tasks:
-            return False
-        else:
-            return True
-
-
-def _argument_filter_sanity_check():
-    if args.limit_to_tasks and args.filter_tasks:
-        sys.exit("Error: Filter and Limit at the same time active.")
-    if args.extended_times and args.summary_only:
-        sys.exit("Error: Summary only and extended times active.")
-    if args.time_limit and ":" not in args.time_limit:
-        sys.exit(
-            "Error: No bound set for time limit. Please set bound by ':' e=
.g :123."
-        )
-    if args.time_limit and (args.summary or args.summary_only or args.summ=
ary_extended):
-        sys.exit("Error: Cannot set time limit and print summary")
-    if args.csv_summary:
-        args.summary =3D True
-        if args.csv =3D=3D args.csv_summary:
-            sys.exit("Error: Chosen files for csv and csv summary are the =
same")
-    if args.csv and (args.summary_extended or args.summary) and not args.c=
sv_summary:
-        sys.exit("Error: No file chosen to write summary to. Choose with -=
-csv-summary "
-        "<file>")
-    if args.csv and args.summary_only:
-        sys.exit("Error: --csv chosen and --summary-only. Standard task wo=
uld not be"
-            "written to csv file.")
-
-def _argument_prepare_check():
-    global time_unit, fd_task, fd_sum
-    if args.filter_tasks:
-        args.filter_tasks =3D args.filter_tasks.split(",")
-    if args.limit_to_tasks:
-        args.limit_to_tasks =3D args.limit_to_tasks.split(",")
-    if args.time_limit:
-        args.time_limit =3D args.time_limit.split(":")
-    for rename_tuple in args.rename_comms_by_tids.split(","):
-        tid_name =3D rename_tuple.split(":")
-        if len(tid_name) !=3D 2:
-            continue
-        args.tid_renames[int(tid_name[0])] =3D tid_name[1]
-    args.highlight_tasks_map =3D dict()
-    for highlight_tasks_tuple in args.highlight_tasks.split(","):
-        tasks_color_map =3D highlight_tasks_tuple.split(":")
-        # default highlight color to red if no color set by user
-        if len(tasks_color_map) =3D=3D 1:
-            tasks_color_map.append("red")
-        if args.highlight_tasks and tasks_color_map[1].lower() not in _COL=
ORS:
-            sys.exit(
-                "Error: Color not defined, please choose from grey,red,gre=
en,yellow,blue,"
-                "violet"
-            )
-        if len(tasks_color_map) !=3D 2:
-            continue
-        args.highlight_tasks_map[tasks_color_map[0]] =3D tasks_color_map[1=
]
-    time_unit =3D "us"
-    if args.ns:
-        time_unit =3D "ns"
-    elif args.ms:
-        time_unit =3D "ms"
-
-
-    fd_task =3D sys.stdout
-    if args.csv:
-        args.stdio_color =3D "never"
-        fd_task =3D open(args.csv, "w")
-        print("generating csv at",args.csv,)
-
-    fd_sum =3D sys.stdout
-    if args.csv_summary:
-        args.stdio_color =3D "never"
-        fd_sum =3D open(args.csv_summary, "w")
-        print("generating csv summary at",args.csv_summary)
-        if not args.csv:
-            args.summary_only =3D True
-
-
-def _is_within_timelimit(time):
-    """
-    Check if a time limit was given by parameter, if so ignore the rest. I=
f not,
-    process the recorded trace in its entirety.
-    """
-    if not args.time_limit:
-        return True
-    lower_time_limit =3D args.time_limit[0]
-    upper_time_limit =3D args.time_limit[1]
-    # check for upper limit
-    if upper_time_limit =3D=3D "":
-        if time >=3D decimal.Decimal(lower_time_limit):
-            return True
-    # check for lower limit
-    if lower_time_limit =3D=3D "":
-        if time <=3D decimal.Decimal(upper_time_limit):
-            return True
-        # quit if time exceeds upper limit. Good for big datasets
-        else:
-            quit()
-    if lower_time_limit !=3D "" and upper_time_limit !=3D "":
-        if (time >=3D decimal.Decimal(lower_time_limit) and
-            time <=3D decimal.Decimal(upper_time_limit)):
-            return True
-        # quit if time exceeds upper limit. Good for big datasets
-        elif time > decimal.Decimal(upper_time_limit):
-            quit()
-
-def _prepare_fmt_precision():
-    decimal_precision =3D 6
-    time_precision =3D 3
-    if args.ns:
-     decimal_precision =3D 9
-     time_precision =3D 0
-    return decimal_precision, time_precision
-
-def _prepare_fmt_sep():
-    separator =3D " "
-    fix_csv_align =3D 1
-    if args.csv or args.csv_summary:
-        separator =3D ";"
-        fix_csv_align =3D 0
-    return separator, fix_csv_align
-
-def trace_unhandled(event_name, context, event_fields_dict, perf_sample_di=
ct):
-    pass
-
-
-def trace_begin():
-    _parse_args()
-    _check_color()
-    _init_db()
-    if not args.summary_only:
-        _print_header()
-
-def trace_end():
-    if args.summary or args.summary_extended or args.summary_only:
-        Summary().print()
-
-def sched__sched_switch(event_name, context, common_cpu, common_secs, comm=
on_nsecs,
-                        common_pid, common_comm, common_callchain, prev_co=
mm,
-                        prev_pid, prev_prio, prev_state, next_comm, next_p=
id,
-                        next_prio, perf_sample_dict):
-    # ignore common_secs & common_nsecs cause we need
-    # high res timestamp anyway, using the raw value is
-    # faster
-    time =3D _time_to_internal(perf_sample_dict["sample"]["time"])
-    if not _is_within_timelimit(time):
-        # user specific --time-limit a:b set
-        return
-
-    next_comm =3D _filter_non_printable(next_comm)
-    _handle_task_finish(prev_pid, common_cpu, time, perf_sample_dict)
-    _handle_task_start(next_pid, common_cpu, next_comm, time)
diff --git a/tools/perf/tests/shell/script_python.sh b/tools/perf/tests/she=
ll/script_python.sh
deleted file mode 100755
index 6bc66074a31f..000000000000
--- a/tools/perf/tests/shell/script_python.sh
+++ /dev/null
@@ -1,113 +0,0 @@
-#!/bin/bash
-# perf script python tests
-# SPDX-License-Identifier: GPL-2.0
-
-set -e
-
-# set PERF_EXEC_PATH to find scripts in the source directory
-perfdir=3D$(dirname "$0")/../..
-if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
-  export PERF_EXEC_PATH=3D$perfdir
-fi
-
-
-perfdata=3D$(mktemp /tmp/__perf_test_script_python.perf.data.XXXXX)
-generated_script=3D$(mktemp /tmp/__perf_test_script.XXXXX.py)
-
-cleanup() {
-  rm -f "${perfdata}"
-  rm -f "${generated_script}"
-  trap - EXIT TERM INT
-}
-
-trap_cleanup() {
-  echo "Unexpected signal in ${FUNCNAME[1]}"
-  cleanup
-  exit 1
-}
-trap trap_cleanup TERM INT
-trap cleanup EXIT
-
-check_python_support() {
-	if perf check feature -q libpython; then
-		return 0
-	fi
-	echo "perf script python test [Skipped: no libpython support]"
-	return 2
-}
-
-test_script() {
-	local event_name=3D$1
-	local expected_output=3D$2
-	local record_opts=3D$3
-
-	echo "Testing event: $event_name"
-
-	# Try to record. If this fails, it might be permissions or lack of
-	# support. Return 2 to indicate "skip this event" rather than "fail
-	# test".
-	if ! perf record -o "${perfdata}" -e "$event_name" $record_opts -- perf t=
est -w thloop > /dev/null 2>&1; then
-		echo "perf script python test [Skipped: failed to record $event_name]"
-		return 2
-	fi
-
-	echo "Generating python script..."
-	if ! perf script -i "${perfdata}" -g "${generated_script}"; then
-		echo "perf script python test [Failed: script generation for $event_name=
]"
-		return 1
-	fi
-
-	if [ ! -f "${generated_script}" ]; then
-		echo "perf script python test [Failed: script not generated for $event_n=
ame]"
-		return 1
-	fi
-
-	# Perf script -g python doesn't generate process_event for generic
-	# events so append it manually to test that the callback works.
-	if ! grep -q "def process_event" "${generated_script}"; then
-		cat <<EOF >> "${generated_script}"
-
-def process_event(param_dict):
-	print("param_dict: %s" % param_dict)
-EOF
-	fi
-
-	echo "Executing python script..."
-	output=3D$(perf script -i "${perfdata}" -s "${generated_script}" 2>&1)
-
-	if echo "$output" | grep -q "$expected_output"; then
-		echo "perf script python test [Success: $event_name triggered $expected_=
output]"
-		return 0
-	else
-		echo "perf script python test [Failed: $event_name did not trigger $expe=
cted_output]"
-		echo "Output was:"
-		echo "$output" | head -n 20
-		return 1
-	fi
-}
-
-check_python_support || exit 2
-
-# Try tracepoint first
-test_script "sched:sched_switch" "sched__sched_switch" "-c 1" && res=3D0 |=
| res=3D$?
-
-if [ $res -eq 0 ]; then
-	exit 0
-elif [ $res -eq 1 ]; then
-	exit 1
-fi
-
-# If tracepoint skipped (res=3D2), try task-clock
-# For generic events like task-clock, the generated script uses process_ev=
ent()
-# which prints the param_dict.
-test_script "task-clock" "param_dict" "-c 100" && res=3D0 || res=3D$?
-
-if [ $res -eq 0 ]; then
-	exit 0
-elif [ $res -eq 1 ]; then
-	exit 1
-fi
-
-# If both skipped
-echo "perf script python test [Skipped: Could not record tracepoint or tas=
k-clock]"
-exit 2
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scri=
pting-engines/Build
index ce14ef44b200..54920e7e1d5d 100644
--- a/tools/perf/util/scripting-engines/Build
+++ b/tools/perf/util/scripting-engines/Build
@@ -1,7 +1 @@
-
-perf-util-$(CONFIG_LIBPYTHON) +=3D trace-event-python.o
-
-
-
-# -Wno-declaration-after-statement: The python headers have mixed code wit=
h declarations (decls after asserts, for instance)
-CFLAGS_trace-event-python.o +=3D $(PYTHON_EMBED_CCOPTS) -Wno-redundant-dec=
ls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecated=
-declarations -Wno-switch-enum -Wno-declaration-after-statement
+# No embedded scripting engines
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools=
/perf/util/scripting-engines/trace-event-python.c
deleted file mode 100644
index 5a30caaec73e..000000000000
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ /dev/null
@@ -1,2209 +0,0 @@
-/*
- * trace-event-python.  Feed trace events to an embedded Python interprete=
r.
- *
- * Copyright (C) 2010 Tom Zanussi <tzanussi@gmail.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
- *
- */
-
-#include <Python.h>
-
-#include <inttypes.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <stdbool.h>
-#include <errno.h>
-#include <linux/bitmap.h>
-#include <linux/compiler.h>
-#include <linux/time64.h>
-#ifdef HAVE_LIBTRACEEVENT
-#include <event-parse.h>
-#endif
-
-#include "../build-id.h"
-#include "../counts.h"
-#include "../debug.h"
-#include "../dso.h"
-#include "../callchain.h"
-#include "../env.h"
-#include "../evsel.h"
-#include "../event.h"
-#include "../thread.h"
-#include "../comm.h"
-#include "../machine.h"
-#include "../mem-info.h"
-#include "../db-export.h"
-#include "../thread-stack.h"
-#include "../trace-event.h"
-#include "../call-path.h"
-#include "dwarf-regs.h"
-#include "map.h"
-#include "symbol.h"
-#include "thread_map.h"
-#include "print_binary.h"
-#include "stat.h"
-#include "mem-events.h"
-#include "util/perf_regs.h"
-
-#define _PyUnicode_FromString(arg) \
-  PyUnicode_FromString(arg)
-#define _PyUnicode_FromStringAndSize(arg1, arg2) \
-  PyUnicode_FromStringAndSize((arg1), (arg2))
-#define _PyBytes_FromStringAndSize(arg1, arg2) \
-  PyBytes_FromStringAndSize((arg1), (arg2))
-#define _PyLong_FromLong(arg) \
-  PyLong_FromLong(arg)
-#define _PyLong_AsLong(arg) \
-  PyLong_AsLong(arg)
-#define _PyCapsule_New(arg1, arg2, arg3) \
-  PyCapsule_New((arg1), (arg2), (arg3))
-
-PyMODINIT_FUNC PyInit_perf_trace_context(void);
-
-#ifdef HAVE_LIBTRACEEVENT
-#define TRACE_EVENT_TYPE_MAX				\
-	((1 << (sizeof(unsigned short) * 8)) - 1)
-
-#define N_COMMON_FIELDS	7
-
-static char *cur_field_name;
-static int zero_flag_atom;
-#endif
-
-#define MAX_FIELDS	64
-
-extern struct scripting_context *scripting_context;
-
-static PyObject *main_module, *main_dict;
-
-struct tables {
-	struct db_export	dbe;
-	PyObject		*evsel_handler;
-	PyObject		*machine_handler;
-	PyObject		*thread_handler;
-	PyObject		*comm_handler;
-	PyObject		*comm_thread_handler;
-	PyObject		*dso_handler;
-	PyObject		*symbol_handler;
-	PyObject		*branch_type_handler;
-	PyObject		*sample_handler;
-	PyObject		*call_path_handler;
-	PyObject		*call_return_handler;
-	PyObject		*synth_handler;
-	PyObject		*context_switch_handler;
-	bool			db_export_mode;
-};
-
-static struct tables tables_global;
-
-static void handler_call_die(const char *handler_name) __noreturn;
-static void handler_call_die(const char *handler_name)
-{
-	PyErr_Print();
-	Py_FatalError("problem in Python trace event handler");
-	// Py_FatalError does not return
-	// but we have to make the compiler happy
-	abort();
-}
-
-/*
- * Insert val into the dictionary and decrement the reference counter.
- * This is necessary for dictionaries since PyDict_SetItemString() does no=
t
- * steal a reference, as opposed to PyTuple_SetItem().
- */
-static void pydict_set_item_string_decref(PyObject *dict, const char *key,=
 PyObject *val)
-{
-	PyDict_SetItemString(dict, key, val);
-	Py_DECREF(val);
-}
-
-static PyObject *get_handler(const char *handler_name)
-{
-	PyObject *handler;
-
-	handler =3D PyDict_GetItemString(main_dict, handler_name);
-	if (handler && !PyCallable_Check(handler))
-		return NULL;
-	return handler;
-}
-
-static void call_object(PyObject *handler, PyObject *args, const char *die=
_msg)
-{
-	PyObject *retval;
-
-	retval =3D PyObject_CallObject(handler, args);
-	if (retval =3D=3D NULL)
-		handler_call_die(die_msg);
-	Py_DECREF(retval);
-}
-
-static void try_call_object(const char *handler_name, PyObject *args)
-{
-	PyObject *handler;
-
-	handler =3D get_handler(handler_name);
-	if (handler)
-		call_object(handler, args, handler_name);
-}
-
-#ifdef HAVE_LIBTRACEEVENT
-static int get_argument_count(PyObject *handler)
-{
-	int arg_count =3D 0;
-
-	PyObject *code_obj =3D code_obj =3D PyObject_GetAttrString(handler, "__co=
de__");
-	PyErr_Clear();
-	if (code_obj) {
-		PyObject *arg_count_obj =3D PyObject_GetAttrString(code_obj,
-			"co_argcount");
-		if (arg_count_obj) {
-			arg_count =3D (int) _PyLong_AsLong(arg_count_obj);
-			Py_DECREF(arg_count_obj);
-		}
-		Py_DECREF(code_obj);
-	}
-	return arg_count;
-}
-
-static void define_value(enum tep_print_arg_type field_type,
-			 const char *ev_name,
-			 const char *field_name,
-			 const char *field_value,
-			 const char *field_str)
-{
-	const char *handler_name =3D "define_flag_value";
-	PyObject *t;
-	unsigned long long value;
-	unsigned n =3D 0;
-
-	if (field_type =3D=3D TEP_PRINT_SYMBOL)
-		handler_name =3D "define_symbolic_value";
-
-	t =3D PyTuple_New(4);
-	if (!t)
-		Py_FatalError("couldn't create Python tuple");
-
-	value =3D eval_flag(field_value);
-
-	PyTuple_SetItem(t, n++, _PyUnicode_FromString(ev_name));
-	PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_name));
-	PyTuple_SetItem(t, n++, _PyLong_FromLong(value));
-	PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_str));
-
-	try_call_object(handler_name, t);
-
-	Py_DECREF(t);
-}
-
-static void define_values(enum tep_print_arg_type field_type,
-			  struct tep_print_flag_sym *field,
-			  const char *ev_name,
-			  const char *field_name)
-{
-	define_value(field_type, ev_name, field_name, field->value,
-		     field->str);
-
-	if (field->next)
-		define_values(field_type, field->next, ev_name, field_name);
-}
-
-static void define_field(enum tep_print_arg_type field_type,
-			 const char *ev_name,
-			 const char *field_name,
-			 const char *delim)
-{
-	const char *handler_name =3D "define_flag_field";
-	PyObject *t;
-	unsigned n =3D 0;
-
-	if (field_type =3D=3D TEP_PRINT_SYMBOL)
-		handler_name =3D "define_symbolic_field";
-
-	if (field_type =3D=3D TEP_PRINT_FLAGS)
-		t =3D PyTuple_New(3);
-	else
-		t =3D PyTuple_New(2);
-	if (!t)
-		Py_FatalError("couldn't create Python tuple");
-
-	PyTuple_SetItem(t, n++, _PyUnicode_FromString(ev_name));
-	PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_name));
-	if (field_type =3D=3D TEP_PRINT_FLAGS)
-		PyTuple_SetItem(t, n++, _PyUnicode_FromString(delim));
-
-	try_call_object(handler_name, t);
-
-	Py_DECREF(t);
-}
-
-static void define_event_symbols(struct tep_event *event,
-				 const char *ev_name,
-				 struct tep_print_arg *args)
-{
-	if (args =3D=3D NULL)
-		return;
-
-	switch (args->type) {
-	case TEP_PRINT_NULL:
-		break;
-	case TEP_PRINT_ATOM:
-		define_value(TEP_PRINT_FLAGS, ev_name, cur_field_name, "0",
-			     args->atom.atom);
-		zero_flag_atom =3D 0;
-		break;
-	case TEP_PRINT_FIELD:
-		free(cur_field_name);
-		cur_field_name =3D strdup(args->field.name);
-		break;
-	case TEP_PRINT_FLAGS:
-		define_event_symbols(event, ev_name, args->flags.field);
-		define_field(TEP_PRINT_FLAGS, ev_name, cur_field_name,
-			     args->flags.delim);
-		define_values(TEP_PRINT_FLAGS, args->flags.flags, ev_name,
-			      cur_field_name);
-		break;
-	case TEP_PRINT_SYMBOL:
-		define_event_symbols(event, ev_name, args->symbol.field);
-		define_field(TEP_PRINT_SYMBOL, ev_name, cur_field_name, NULL);
-		define_values(TEP_PRINT_SYMBOL, args->symbol.symbols, ev_name,
-			      cur_field_name);
-		break;
-	case TEP_PRINT_HEX:
-	case TEP_PRINT_HEX_STR:
-		define_event_symbols(event, ev_name, args->hex.field);
-		define_event_symbols(event, ev_name, args->hex.size);
-		break;
-	case TEP_PRINT_INT_ARRAY:
-		define_event_symbols(event, ev_name, args->int_array.field);
-		define_event_symbols(event, ev_name, args->int_array.count);
-		define_event_symbols(event, ev_name, args->int_array.el_size);
-		break;
-	case TEP_PRINT_STRING:
-		break;
-	case TEP_PRINT_TYPE:
-		define_event_symbols(event, ev_name, args->typecast.item);
-		break;
-	case TEP_PRINT_OP:
-		if (strcmp(args->op.op, ":") =3D=3D 0)
-			zero_flag_atom =3D 1;
-		define_event_symbols(event, ev_name, args->op.left);
-		define_event_symbols(event, ev_name, args->op.right);
-		break;
-	default:
-		/* gcc warns for these? */
-	case TEP_PRINT_BSTRING:
-	case TEP_PRINT_DYNAMIC_ARRAY:
-	case TEP_PRINT_DYNAMIC_ARRAY_LEN:
-	case TEP_PRINT_FUNC:
-	case TEP_PRINT_BITMASK:
-		/* we should warn... */
-		return;
-	}
-
-	if (args->next)
-		define_event_symbols(event, ev_name, args->next);
-}
-
-static PyObject *get_field_numeric_entry(struct tep_event *event,
-		struct tep_format_field *field, void *data)
-{
-	bool is_array =3D field->flags & TEP_FIELD_IS_ARRAY;
-	PyObject *obj =3D NULL, *list =3D NULL;
-	unsigned long long val;
-	unsigned int item_size, n_items, i;
-
-	if (is_array) {
-		list =3D PyList_New(field->arraylen);
-		if (!list)
-			Py_FatalError("couldn't create Python list");
-		item_size =3D field->size / field->arraylen;
-		n_items =3D field->arraylen;
-	} else {
-		item_size =3D field->size;
-		n_items =3D 1;
-	}
-
-	for (i =3D 0; i < n_items; i++) {
-
-		val =3D read_size(event, data + field->offset + i * item_size,
-				item_size);
-		if (field->flags & TEP_FIELD_IS_SIGNED) {
-			if ((long long)val >=3D LONG_MIN &&
-					(long long)val <=3D LONG_MAX)
-				obj =3D _PyLong_FromLong(val);
-			else
-				obj =3D PyLong_FromLongLong(val);
-		} else {
-			if (val <=3D LONG_MAX)
-				obj =3D _PyLong_FromLong(val);
-			else
-				obj =3D PyLong_FromUnsignedLongLong(val);
-		}
-		if (is_array)
-			PyList_SET_ITEM(list, i, obj);
-	}
-	if (is_array)
-		obj =3D list;
-	return obj;
-}
-#endif
-
-static const char *get_dsoname(struct map *map)
-{
-	const char *dsoname =3D "[unknown]";
-	struct dso *dso =3D map ? map__dso(map) : NULL;
-
-	if (dso) {
-		if (symbol_conf.show_kernel_path && dso__long_name(dso))
-			dsoname =3D dso__long_name(dso);
-		else
-			dsoname =3D dso__name(dso);
-	}
-
-	return dsoname;
-}
-
-static unsigned long get_offset(struct symbol *sym, struct addr_location *=
al)
-{
-	unsigned long offset;
-
-	if (al->addr < sym->end)
-		offset =3D al->addr - sym->start;
-	else
-		offset =3D al->addr - map__start(al->map) - sym->start;
-
-	return offset;
-}
-
-static PyObject *python_process_callchain(struct perf_sample *sample,
-					 struct evsel *evsel,
-					 struct addr_location *al)
-{
-	PyObject *pylist;
-	struct callchain_cursor *cursor;
-
-	pylist =3D PyList_New(0);
-	if (!pylist)
-		Py_FatalError("couldn't create Python list");
-
-	if (!symbol_conf.use_callchain || !sample->callchain)
-		goto exit;
-
-	cursor =3D get_tls_callchain_cursor();
-	if (thread__resolve_callchain(al->thread, cursor, evsel,
-				      sample, NULL, NULL,
-				      scripting_max_stack) !=3D 0) {
-		pr_err("Failed to resolve callchain. Skipping\n");
-		goto exit;
-	}
-	callchain_cursor_commit(cursor);
-
-
-	while (1) {
-		PyObject *pyelem;
-		struct callchain_cursor_node *node;
-		node =3D callchain_cursor_current(cursor);
-		if (!node)
-			break;
-
-		pyelem =3D PyDict_New();
-		if (!pyelem)
-			Py_FatalError("couldn't create Python dictionary");
-
-
-		pydict_set_item_string_decref(pyelem, "ip",
-				PyLong_FromUnsignedLongLong(node->ip));
-
-		if (node->ms.sym) {
-			PyObject *pysym  =3D PyDict_New();
-			if (!pysym)
-				Py_FatalError("couldn't create Python dictionary");
-			pydict_set_item_string_decref(pysym, "start",
-					PyLong_FromUnsignedLongLong(node->ms.sym->start));
-			pydict_set_item_string_decref(pysym, "end",
-					PyLong_FromUnsignedLongLong(node->ms.sym->end));
-			pydict_set_item_string_decref(pysym, "binding",
-					_PyLong_FromLong(node->ms.sym->binding));
-			pydict_set_item_string_decref(pysym, "name",
-					_PyUnicode_FromStringAndSize(node->ms.sym->name,
-							node->ms.sym->namelen));
-			pydict_set_item_string_decref(pyelem, "sym", pysym);
-
-			if (node->ms.map) {
-				struct map *map =3D node->ms.map;
-				struct addr_location node_al;
-				unsigned long offset;
-
-				addr_location__init(&node_al);
-				node_al.addr =3D map__map_ip(map, node->ip);
-				node_al.map  =3D map__get(map);
-				offset =3D get_offset(node->ms.sym, &node_al);
-				addr_location__exit(&node_al);
-
-				pydict_set_item_string_decref(
-					pyelem, "sym_off",
-					PyLong_FromUnsignedLongLong(offset));
-			}
-			if (node->srcline && strcmp(":0", node->srcline)) {
-				pydict_set_item_string_decref(
-					pyelem, "sym_srcline",
-					_PyUnicode_FromString(node->srcline));
-			}
-		}
-
-		if (node->ms.map) {
-			const char *dsoname =3D get_dsoname(node->ms.map);
-
-			pydict_set_item_string_decref(pyelem, "dso",
-					_PyUnicode_FromString(dsoname));
-		}
-
-		callchain_cursor_advance(cursor);
-		PyList_Append(pylist, pyelem);
-		Py_DECREF(pyelem);
-	}
-
-exit:
-	return pylist;
-}
-
-static PyObject *python_process_brstack(struct perf_sample *sample,
-					struct thread *thread)
-{
-	struct branch_stack *br =3D sample->branch_stack;
-	struct branch_entry *entries =3D perf_sample__branch_entries(sample);
-	PyObject *pylist;
-	u64 i;
-
-	pylist =3D PyList_New(0);
-	if (!pylist)
-		Py_FatalError("couldn't create Python list");
-
-	if (!(br && br->nr))
-		goto exit;
-
-	for (i =3D 0; i < br->nr; i++) {
-		PyObject *pyelem;
-		struct addr_location al;
-		const char *dsoname;
-
-		pyelem =3D PyDict_New();
-		if (!pyelem)
-			Py_FatalError("couldn't create Python dictionary");
-
-		pydict_set_item_string_decref(pyelem, "from",
-		    PyLong_FromUnsignedLongLong(entries[i].from));
-		pydict_set_item_string_decref(pyelem, "to",
-		    PyLong_FromUnsignedLongLong(entries[i].to));
-		pydict_set_item_string_decref(pyelem, "mispred",
-		    PyBool_FromLong(entries[i].flags.mispred));
-		pydict_set_item_string_decref(pyelem, "predicted",
-		    PyBool_FromLong(entries[i].flags.predicted));
-		pydict_set_item_string_decref(pyelem, "in_tx",
-		    PyBool_FromLong(entries[i].flags.in_tx));
-		pydict_set_item_string_decref(pyelem, "abort",
-		    PyBool_FromLong(entries[i].flags.abort));
-		pydict_set_item_string_decref(pyelem, "cycles",
-		    PyLong_FromUnsignedLongLong(entries[i].flags.cycles));
-
-		addr_location__init(&al);
-		thread__find_map_fb(thread, sample->cpumode,
-				    entries[i].from, &al);
-		dsoname =3D get_dsoname(al.map);
-		pydict_set_item_string_decref(pyelem, "from_dsoname",
-					      _PyUnicode_FromString(dsoname));
-
-		thread__find_map_fb(thread, sample->cpumode,
-				    entries[i].to, &al);
-		dsoname =3D get_dsoname(al.map);
-		pydict_set_item_string_decref(pyelem, "to_dsoname",
-					      _PyUnicode_FromString(dsoname));
-
-		addr_location__exit(&al);
-		PyList_Append(pylist, pyelem);
-		Py_DECREF(pyelem);
-	}
-
-exit:
-	return pylist;
-}
-
-static int get_symoff(struct symbol *sym, struct addr_location *al,
-		      bool print_off, char *bf, int size)
-{
-	unsigned long offset;
-
-	if (!sym || !sym->name[0])
-		return scnprintf(bf, size, "%s", "[unknown]");
-
-	if (!print_off)
-		return scnprintf(bf, size, "%s", sym->name);
-
-	offset =3D get_offset(sym, al);
-
-	return scnprintf(bf, size, "%s+0x%x", sym->name, offset);
-}
-
-static int get_br_mspred(struct branch_flags *flags, char *bf, int size)
-{
-	if (!flags->mispred  && !flags->predicted)
-		return scnprintf(bf, size, "%s", "-");
-
-	if (flags->mispred)
-		return scnprintf(bf, size, "%s", "M");
-
-	return scnprintf(bf, size, "%s", "P");
-}
-
-static PyObject *python_process_brstacksym(struct perf_sample *sample,
-					   struct thread *thread)
-{
-	struct branch_stack *br =3D sample->branch_stack;
-	struct branch_entry *entries =3D perf_sample__branch_entries(sample);
-	PyObject *pylist;
-	u64 i;
-	char bf[512];
-
-	pylist =3D PyList_New(0);
-	if (!pylist)
-		Py_FatalError("couldn't create Python list");
-
-	if (!(br && br->nr))
-		goto exit;
-
-	for (i =3D 0; i < br->nr; i++) {
-		PyObject *pyelem;
-		struct addr_location al;
-
-		addr_location__init(&al);
-		pyelem =3D PyDict_New();
-		if (!pyelem)
-			Py_FatalError("couldn't create Python dictionary");
-
-		thread__find_symbol_fb(thread, sample->cpumode,
-				       entries[i].from, &al);
-		get_symoff(al.sym, &al, true, bf, sizeof(bf));
-		pydict_set_item_string_decref(pyelem, "from",
-					      _PyUnicode_FromString(bf));
-
-		thread__find_symbol_fb(thread, sample->cpumode,
-				       entries[i].to, &al);
-		get_symoff(al.sym, &al, true, bf, sizeof(bf));
-		pydict_set_item_string_decref(pyelem, "to",
-					      _PyUnicode_FromString(bf));
-
-		get_br_mspred(&entries[i].flags, bf, sizeof(bf));
-		pydict_set_item_string_decref(pyelem, "pred",
-					      _PyUnicode_FromString(bf));
-
-		if (entries[i].flags.in_tx) {
-			pydict_set_item_string_decref(pyelem, "in_tx",
-					      _PyUnicode_FromString("X"));
-		} else {
-			pydict_set_item_string_decref(pyelem, "in_tx",
-					      _PyUnicode_FromString("-"));
-		}
-
-		if (entries[i].flags.abort) {
-			pydict_set_item_string_decref(pyelem, "abort",
-					      _PyUnicode_FromString("A"));
-		} else {
-			pydict_set_item_string_decref(pyelem, "abort",
-					      _PyUnicode_FromString("-"));
-		}
-
-		PyList_Append(pylist, pyelem);
-		Py_DECREF(pyelem);
-		addr_location__exit(&al);
-	}
-
-exit:
-	return pylist;
-}
-
-static PyObject *get_sample_value_as_tuple(struct sample_read_value *value=
,
-					   u64 read_format)
-{
-	PyObject *t;
-
-	t =3D PyTuple_New(3);
-	if (!t)
-		Py_FatalError("couldn't create Python tuple");
-	PyTuple_SetItem(t, 0, PyLong_FromUnsignedLongLong(value->id));
-	PyTuple_SetItem(t, 1, PyLong_FromUnsignedLongLong(value->value));
-	if (read_format & PERF_FORMAT_LOST)
-		PyTuple_SetItem(t, 2, PyLong_FromUnsignedLongLong(value->lost));
-
-	return t;
-}
-
-static void set_sample_read_in_dict(PyObject *dict_sample,
-					 struct perf_sample *sample,
-					 struct evsel *evsel)
-{
-	u64 read_format =3D evsel->core.attr.read_format;
-	PyObject *values;
-	unsigned int i;
-
-	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
-		pydict_set_item_string_decref(dict_sample, "time_enabled",
-			PyLong_FromUnsignedLongLong(sample->read.time_enabled));
-	}
-
-	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
-		pydict_set_item_string_decref(dict_sample, "time_running",
-			PyLong_FromUnsignedLongLong(sample->read.time_running));
-	}
-
-	if (read_format & PERF_FORMAT_GROUP)
-		values =3D PyList_New(sample->read.group.nr);
-	else
-		values =3D PyList_New(1);
-
-	if (!values)
-		Py_FatalError("couldn't create Python list");
-
-	if (read_format & PERF_FORMAT_GROUP) {
-		struct sample_read_value *v =3D sample->read.group.values;
-
-		i =3D 0;
-		sample_read_group__for_each(v, sample->read.group.nr, read_format) {
-			PyObject *t =3D get_sample_value_as_tuple(v, read_format);
-			PyList_SET_ITEM(values, i, t);
-			i++;
-		}
-	} else {
-		PyObject *t =3D get_sample_value_as_tuple(&sample->read.one,
-							read_format);
-		PyList_SET_ITEM(values, 0, t);
-	}
-	pydict_set_item_string_decref(dict_sample, "values", values);
-}
-
-static void set_sample_datasrc_in_dict(PyObject *dict,
-				      struct perf_sample *sample)
-{
-	struct mem_info *mi =3D mem_info__new();
-	char decode[100];
-
-	if (!mi)
-		Py_FatalError("couldn't create mem-info");
-
-	pydict_set_item_string_decref(dict, "datasrc",
-			PyLong_FromUnsignedLongLong(sample->data_src));
-
-	mem_info__data_src(mi)->val =3D sample->data_src;
-	perf_script__meminfo_scnprintf(decode, 100, mi);
-	mem_info__put(mi);
-
-	pydict_set_item_string_decref(dict, "datasrc_decode",
-			_PyUnicode_FromString(decode));
-}
-
-static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_mac=
hine, uint32_t e_flags,
-		     char *bf, int size)
-{
-	unsigned int i =3D 0, r;
-	int printed =3D 0;
-
-	bf[0] =3D 0;
-
-	if (size <=3D 0)
-		return;
-
-	if (!regs || !regs->regs)
-		return;
-
-	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
-		u64 val =3D regs->regs[i++];
-
-		printed +=3D scnprintf(bf + printed, size - printed,
-				     "%5s:0x%" PRIx64 " ",
-				     perf_reg_name(r, e_machine, e_flags), val);
-	}
-}
-
-#define MAX_REG_SIZE 128
-
-static int set_regs_in_dict(PyObject *dict,
-			     struct perf_sample *sample,
-			     struct evsel *evsel,
-			     uint16_t e_machine,
-			     uint32_t e_flags)
-{
-	struct perf_event_attr *attr =3D &evsel->core.attr;
-
-	int size =3D (__sw_hweight64(attr->sample_regs_intr) * MAX_REG_SIZE) + 1;
-	char *bf =3D NULL;
-
-	if (sample->intr_regs) {
-		bf =3D malloc(size);
-		if (!bf)
-			return -1;
-
-		regs_map(sample->intr_regs, attr->sample_regs_intr, e_machine, e_flags, =
bf, size);
-
-		pydict_set_item_string_decref(dict, "iregs",
-					_PyUnicode_FromString(bf));
-	}
-
-	if (sample->user_regs) {
-		if (!bf) {
-			bf =3D malloc(size);
-			if (!bf)
-				return -1;
-		}
-		regs_map(sample->user_regs, attr->sample_regs_user, e_machine, e_flags, =
bf, size);
-
-		pydict_set_item_string_decref(dict, "uregs",
-					_PyUnicode_FromString(bf));
-	}
-	free(bf);
-
-	return 0;
-}
-
-static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
-			    const char *dso_field, const char *dso_bid_field,
-			    const char *dso_map_start, const char *dso_map_end,
-			    const char *sym_field, const char *symoff_field,
-			    const char *map_pgoff)
-{
-	if (al->map) {
-		char sbuild_id[SBUILD_ID_SIZE];
-		struct dso *dso =3D map__dso(al->map);
-
-		pydict_set_item_string_decref(dict, dso_field,
-					      _PyUnicode_FromString(dso__name(dso)));
-		build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
-		pydict_set_item_string_decref(dict, dso_bid_field,
-			_PyUnicode_FromString(sbuild_id));
-		pydict_set_item_string_decref(dict, dso_map_start,
-			PyLong_FromUnsignedLong(map__start(al->map)));
-		pydict_set_item_string_decref(dict, dso_map_end,
-			PyLong_FromUnsignedLong(map__end(al->map)));
-		pydict_set_item_string_decref(dict, map_pgoff,
-			PyLong_FromUnsignedLongLong(map__pgoff(al->map)));
-	}
-	if (al->sym) {
-		pydict_set_item_string_decref(dict, sym_field,
-			_PyUnicode_FromString(al->sym->name));
-		pydict_set_item_string_decref(dict, symoff_field,
-			PyLong_FromUnsignedLong(get_offset(al->sym, al)));
-	}
-}
-
-static void set_sample_flags(PyObject *dict, u32 flags)
-{
-	const char *ch =3D PERF_IP_FLAG_CHARS;
-	char *p, str[33];
-
-	for (p =3D str; *ch; ch++, flags >>=3D 1) {
-		if (flags & 1)
-			*p++ =3D *ch;
-	}
-	*p =3D 0;
-	pydict_set_item_string_decref(dict, "flags", _PyUnicode_FromString(str));
-}
-
-static void python_process_sample_flags(struct perf_sample *sample, PyObje=
ct *dict_sample)
-{
-	char flags_disp[SAMPLE_FLAGS_BUF_SIZE];
-
-	set_sample_flags(dict_sample, sample->flags);
-	perf_sample__sprintf_flags(sample->flags, flags_disp, sizeof(flags_disp))=
;
-	pydict_set_item_string_decref(dict_sample, "flags_disp",
-		_PyUnicode_FromString(flags_disp));
-}
-
-static PyObject *get_perf_sample_dict(struct perf_sample *sample,
-					 struct evsel *evsel,
-					 struct addr_location *al,
-					 struct addr_location *addr_al,
-					 PyObject *callchain)
-{
-	PyObject *dict, *dict_sample, *brstack, *brstacksym;
-	uint16_t e_machine =3D EM_HOST;
-	uint32_t e_flags =3D EF_HOST;
-
-	dict =3D PyDict_New();
-	if (!dict)
-		Py_FatalError("couldn't create Python dictionary");
-
-	dict_sample =3D PyDict_New();
-	if (!dict_sample)
-		Py_FatalError("couldn't create Python dictionary");
-
-	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(evse=
l__name(evsel)));
-	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((c=
onst char *)&evsel->core.attr, sizeof(evsel->core.attr)));
-
-	pydict_set_item_string_decref(dict_sample, "id",
-			PyLong_FromUnsignedLongLong(sample->id));
-	pydict_set_item_string_decref(dict_sample, "stream_id",
-			PyLong_FromUnsignedLongLong(sample->stream_id));
-	pydict_set_item_string_decref(dict_sample, "pid",
-			_PyLong_FromLong(sample->pid));
-	pydict_set_item_string_decref(dict_sample, "tid",
-			_PyLong_FromLong(sample->tid));
-	pydict_set_item_string_decref(dict_sample, "cpu",
-			_PyLong_FromLong(sample->cpu));
-	pydict_set_item_string_decref(dict_sample, "ip",
-			PyLong_FromUnsignedLongLong(sample->ip));
-	pydict_set_item_string_decref(dict_sample, "time",
-			PyLong_FromUnsignedLongLong(sample->time));
-	pydict_set_item_string_decref(dict_sample, "period",
-			PyLong_FromUnsignedLongLong(sample->period));
-	pydict_set_item_string_decref(dict_sample, "phys_addr",
-			PyLong_FromUnsignedLongLong(sample->phys_addr));
-	pydict_set_item_string_decref(dict_sample, "addr",
-			PyLong_FromUnsignedLongLong(sample->addr));
-	set_sample_read_in_dict(dict_sample, sample, evsel);
-	pydict_set_item_string_decref(dict_sample, "weight",
-			PyLong_FromUnsignedLongLong(sample->weight));
-	pydict_set_item_string_decref(dict_sample, "ins_lat",
-			PyLong_FromUnsignedLong(sample->ins_lat));
-	pydict_set_item_string_decref(dict_sample, "transaction",
-			PyLong_FromUnsignedLongLong(sample->transaction));
-	set_sample_datasrc_in_dict(dict_sample, sample);
-	pydict_set_item_string_decref(dict, "sample", dict_sample);
-
-	pydict_set_item_string_decref(dict, "raw_buf", _PyBytes_FromStringAndSize=
(
-			(const char *)sample->raw_data, sample->raw_size));
-	pydict_set_item_string_decref(dict, "comm",
-			_PyUnicode_FromString(thread__comm_str(al->thread)));
-	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end=
",
-			"symbol", "symoff", "map_pgoff");
-
-	pydict_set_item_string_decref(dict, "callchain", callchain);
-
-	brstack =3D python_process_brstack(sample, al->thread);
-	pydict_set_item_string_decref(dict, "brstack", brstack);
-
-	brstacksym =3D python_process_brstacksym(sample, al->thread);
-	pydict_set_item_string_decref(dict, "brstacksym", brstacksym);
-
-	if (sample->machine_pid) {
-		pydict_set_item_string_decref(dict_sample, "machine_pid",
-				_PyLong_FromLong(sample->machine_pid));
-		pydict_set_item_string_decref(dict_sample, "vcpu",
-				_PyLong_FromLong(sample->vcpu));
-	}
-
-	pydict_set_item_string_decref(dict_sample, "cpumode",
-			_PyLong_FromLong((unsigned long)sample->cpumode));
-
-	if (addr_al) {
-		pydict_set_item_string_decref(dict_sample, "addr_correlates_sym",
-			PyBool_FromLong(1));
-		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
-				"addr_dso_map_start", "addr_dso_map_end",
-				"addr_symbol", "addr_symoff", "addr_map_pgoff");
-	}
-
-	if (sample->flags)
-		python_process_sample_flags(sample, dict_sample);
-
-	/* Instructions per cycle (IPC) */
-	if (sample->insn_cnt && sample->cyc_cnt) {
-		pydict_set_item_string_decref(dict_sample, "insn_cnt",
-			PyLong_FromUnsignedLongLong(sample->insn_cnt));
-		pydict_set_item_string_decref(dict_sample, "cyc_cnt",
-			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
-	}
-
-	if (al->thread)
-		e_machine =3D thread__e_machine(al->thread, /*machine=3D*/NULL, &e_flags=
);
-
-	if (set_regs_in_dict(dict, sample, evsel, e_machine, e_flags))
-		Py_FatalError("Failed to setting regs in dict");
-
-	return dict;
-}
-
-#ifdef HAVE_LIBTRACEEVENT
-static void python_process_tracepoint(struct perf_sample *sample,
-				      struct evsel *evsel,
-				      struct addr_location *al,
-				      struct addr_location *addr_al)
-{
-	struct tep_event *event;
-	PyObject *handler, *context, *t, *obj =3D NULL, *callchain;
-	PyObject *dict =3D NULL, *all_entries_dict =3D NULL;
-	static char handler_name[256];
-	struct tep_format_field *field;
-	unsigned long s, ns;
-	unsigned n =3D 0;
-	int pid;
-	int cpu =3D sample->cpu;
-	void *data =3D sample->raw_data;
-	unsigned long long nsecs =3D sample->time;
-	const char *comm =3D thread__comm_str(al->thread);
-	const char *default_handler_name =3D "trace_unhandled";
-	DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
-
-	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
-
-	event =3D evsel__tp_format(evsel);
-	if (!event) {
-		snprintf(handler_name, sizeof(handler_name),
-			 "ug! no event found for type %" PRIu64, (u64)evsel->core.attr.config);
-		Py_FatalError(handler_name);
-	}
-
-	pid =3D raw_field_value(event, "common_pid", data);
-
-	sprintf(handler_name, "%s__%s", event->system, event->name);
-
-	if (!__test_and_set_bit(event->id, events_defined))
-		define_event_symbols(event, handler_name, event->print_fmt.args);
-
-	handler =3D get_handler(handler_name);
-	if (!handler) {
-		handler =3D get_handler(default_handler_name);
-		if (!handler)
-			return;
-		dict =3D PyDict_New();
-		if (!dict)
-			Py_FatalError("couldn't create Python dict");
-	}
-
-	t =3D PyTuple_New(MAX_FIELDS);
-	if (!t)
-		Py_FatalError("couldn't create Python tuple");
-
-
-	s =3D nsecs / NSEC_PER_SEC;
-	ns =3D nsecs - s * NSEC_PER_SEC;
-
-	context =3D _PyCapsule_New(scripting_context, NULL, NULL);
-
-	PyTuple_SetItem(t, n++, _PyUnicode_FromString(handler_name));
-	PyTuple_SetItem(t, n++, context);
-
-	/* ip unwinding */
-	callchain =3D python_process_callchain(sample, evsel, al);
-	/* Need an additional reference for the perf_sample dict */
-	Py_INCREF(callchain);
-
-	if (!dict) {
-		PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu));
-		PyTuple_SetItem(t, n++, _PyLong_FromLong(s));
-		PyTuple_SetItem(t, n++, _PyLong_FromLong(ns));
-		PyTuple_SetItem(t, n++, _PyLong_FromLong(pid));
-		PyTuple_SetItem(t, n++, _PyUnicode_FromString(comm));
-		PyTuple_SetItem(t, n++, callchain);
-	} else {
-		pydict_set_item_string_decref(dict, "common_cpu", _PyLong_FromLong(cpu))=
;
-		pydict_set_item_string_decref(dict, "common_s", _PyLong_FromLong(s));
-		pydict_set_item_string_decref(dict, "common_ns", _PyLong_FromLong(ns));
-		pydict_set_item_string_decref(dict, "common_pid", _PyLong_FromLong(pid))=
;
-		pydict_set_item_string_decref(dict, "common_comm", _PyUnicode_FromString=
(comm));
-		pydict_set_item_string_decref(dict, "common_callchain", callchain);
-	}
-	for (field =3D event->format.fields; field; field =3D field->next) {
-		unsigned int offset, len;
-		unsigned long long val;
-
-		if (field->flags & TEP_FIELD_IS_ARRAY) {
-			offset =3D field->offset;
-			len    =3D field->size;
-			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
-				val     =3D tep_read_number(scripting_context->pevent,
-							  data + offset, len);
-				offset  =3D val;
-				len     =3D offset >> 16;
-				offset &=3D 0xffff;
-				if (tep_field_is_relative(field->flags))
-					offset +=3D field->offset + field->size;
-			}
-			if (field->flags & TEP_FIELD_IS_STRING &&
-			    is_printable_array(data + offset, len)) {
-				obj =3D _PyUnicode_FromString((char *) data + offset);
-			} else {
-				obj =3D PyByteArray_FromStringAndSize((const char *) data + offset, le=
n);
-				field->flags &=3D ~TEP_FIELD_IS_STRING;
-			}
-		} else { /* FIELD_IS_NUMERIC */
-			obj =3D get_field_numeric_entry(event, field, data);
-		}
-		if (!dict)
-			PyTuple_SetItem(t, n++, obj);
-		else
-			pydict_set_item_string_decref(dict, field->name, obj);
-
-	}
-
-	if (dict)
-		PyTuple_SetItem(t, n++, dict);
-
-	if (get_argument_count(handler) =3D=3D (int) n + 1) {
-		all_entries_dict =3D get_perf_sample_dict(sample, evsel, al, addr_al,
-			callchain);
-		PyTuple_SetItem(t, n++,	all_entries_dict);
-	} else {
-		Py_DECREF(callchain);
-	}
-
-	if (_PyTuple_Resize(&t, n) =3D=3D -1)
-		Py_FatalError("error resizing Python tuple");
-
-	if (!dict)
-		call_object(handler, t, handler_name);
-	else
-		call_object(handler, t, default_handler_name);
-
-	Py_DECREF(t);
-}
-#else
-static void python_process_tracepoint(struct perf_sample *sample __maybe_u=
nused,
-				      struct evsel *evsel __maybe_unused,
-				      struct addr_location *al __maybe_unused,
-				      struct addr_location *addr_al __maybe_unused)
-{
-	fprintf(stderr, "Tracepoint events are not supported because "
-			"perf is not linked with libtraceevent.\n");
-}
-#endif
-
-static PyObject *tuple_new(unsigned int sz)
-{
-	PyObject *t;
-
-	t =3D PyTuple_New(sz);
-	if (!t)
-		Py_FatalError("couldn't create Python tuple");
-	return t;
-}
-
-static int tuple_set_s64(PyObject *t, unsigned int pos, s64 val)
-{
-#if BITS_PER_LONG =3D=3D 64
-	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
-#endif
-#if BITS_PER_LONG =3D=3D 32
-	return PyTuple_SetItem(t, pos, PyLong_FromLongLong(val));
-#endif
-}
-
-/*
- * Databases support only signed 64-bit numbers, so even though we are
- * exporting a u64, it must be as s64.
- */
-#define tuple_set_d64 tuple_set_s64
-
-static int tuple_set_u64(PyObject *t, unsigned int pos, u64 val)
-{
-#if BITS_PER_LONG =3D=3D 64
-	return PyTuple_SetItem(t, pos, PyLong_FromUnsignedLong(val));
-#endif
-#if BITS_PER_LONG =3D=3D 32
-	return PyTuple_SetItem(t, pos, PyLong_FromUnsignedLongLong(val));
-#endif
-}
-
-static int tuple_set_u32(PyObject *t, unsigned int pos, u32 val)
-{
-	return PyTuple_SetItem(t, pos, PyLong_FromUnsignedLong(val));
-}
-
-static int tuple_set_s32(PyObject *t, unsigned int pos, s32 val)
-{
-	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
-}
-
-static int tuple_set_bool(PyObject *t, unsigned int pos, bool val)
-{
-	return PyTuple_SetItem(t, pos, PyBool_FromLong(val));
-}
-
-static int tuple_set_string(PyObject *t, unsigned int pos, const char *s)
-{
-	return PyTuple_SetItem(t, pos, _PyUnicode_FromString(s));
-}
-
-static int tuple_set_bytes(PyObject *t, unsigned int pos, void *bytes,
-			   unsigned int sz)
-{
-	return PyTuple_SetItem(t, pos, _PyBytes_FromStringAndSize(bytes, sz));
-}
-
-static int python_export_evsel(struct db_export *dbe, struct evsel *evsel)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-
-	t =3D tuple_new(2);
-
-	tuple_set_d64(t, 0, evsel->db_id);
-	tuple_set_string(t, 1, evsel__name(evsel));
-
-	call_object(tables->evsel_handler, t, "evsel_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_export_machine(struct db_export *dbe,
-				 struct machine *machine)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-
-	t =3D tuple_new(3);
-
-	tuple_set_d64(t, 0, machine->db_id);
-	tuple_set_s32(t, 1, machine->pid);
-	tuple_set_string(t, 2, machine->root_dir ? machine->root_dir : "");
-
-	call_object(tables->machine_handler, t, "machine_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_export_thread(struct db_export *dbe, struct thread *thre=
ad,
-				u64 main_thread_db_id, struct machine *machine)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-
-	t =3D tuple_new(5);
-
-	tuple_set_d64(t, 0, thread__db_id(thread));
-	tuple_set_d64(t, 1, machine->db_id);
-	tuple_set_d64(t, 2, main_thread_db_id);
-	tuple_set_s32(t, 3, thread__pid(thread));
-	tuple_set_s32(t, 4, thread__tid(thread));
-
-	call_object(tables->thread_handler, t, "thread_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_export_comm(struct db_export *dbe, struct comm *comm,
-			      struct thread *thread)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-
-	t =3D tuple_new(5);
-
-	tuple_set_d64(t, 0, comm->db_id);
-	tuple_set_string(t, 1, comm__str(comm));
-	tuple_set_d64(t, 2, thread__db_id(thread));
-	tuple_set_d64(t, 3, comm->start);
-	tuple_set_s32(t, 4, comm->exec);
-
-	call_object(tables->comm_handler, t, "comm_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_export_comm_thread(struct db_export *dbe, u64 db_id,
-				     struct comm *comm, struct thread *thread)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-
-	t =3D tuple_new(3);
-
-	tuple_set_d64(t, 0, db_id);
-	tuple_set_d64(t, 1, comm->db_id);
-	tuple_set_d64(t, 2, thread__db_id(thread));
-
-	call_object(tables->comm_thread_handler, t, "comm_thread_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_export_dso(struct db_export *dbe, struct dso *dso,
-			     struct machine *machine)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	char sbuild_id[SBUILD_ID_SIZE];
-	PyObject *t;
-
-	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
-
-	t =3D tuple_new(5);
-
-	tuple_set_d64(t, 0, dso__db_id(dso));
-	tuple_set_d64(t, 1, machine->db_id);
-	tuple_set_string(t, 2, dso__short_name(dso));
-	tuple_set_string(t, 3, dso__long_name(dso));
-	tuple_set_string(t, 4, sbuild_id);
-
-	call_object(tables->dso_handler, t, "dso_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_export_symbol(struct db_export *dbe, struct symbol *sym,
-				struct dso *dso)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	u64 *sym_db_id =3D symbol__priv(sym);
-	PyObject *t;
-
-	t =3D tuple_new(6);
-
-	tuple_set_d64(t, 0, *sym_db_id);
-	tuple_set_d64(t, 1, dso__db_id(dso));
-	tuple_set_d64(t, 2, sym->start);
-	tuple_set_d64(t, 3, sym->end);
-	tuple_set_s32(t, 4, sym->binding);
-	tuple_set_string(t, 5, sym->name);
-
-	call_object(tables->symbol_handler, t, "symbol_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_export_branch_type(struct db_export *dbe, u32 branch_typ=
e,
-				     const char *name)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-
-	t =3D tuple_new(2);
-
-	tuple_set_s32(t, 0, branch_type);
-	tuple_set_string(t, 1, name);
-
-	call_object(tables->branch_type_handler, t, "branch_type_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static void python_export_sample_table(struct db_export *dbe,
-				       struct export_sample *es)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-
-	t =3D tuple_new(28);
-
-	tuple_set_d64(t, 0, es->db_id);
-	tuple_set_d64(t, 1, es->evsel->db_id);
-	tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->db_id);
-	tuple_set_d64(t, 3, thread__db_id(es->al->thread));
-	tuple_set_d64(t, 4, es->comm_db_id);
-	tuple_set_d64(t, 5, es->dso_db_id);
-	tuple_set_d64(t, 6, es->sym_db_id);
-	tuple_set_d64(t, 7, es->offset);
-	tuple_set_d64(t, 8, es->sample->ip);
-	tuple_set_d64(t, 9, es->sample->time);
-	tuple_set_s32(t, 10, es->sample->cpu);
-	tuple_set_d64(t, 11, es->addr_dso_db_id);
-	tuple_set_d64(t, 12, es->addr_sym_db_id);
-	tuple_set_d64(t, 13, es->addr_offset);
-	tuple_set_d64(t, 14, es->sample->addr);
-	tuple_set_d64(t, 15, es->sample->period);
-	tuple_set_d64(t, 16, es->sample->weight);
-	tuple_set_d64(t, 17, es->sample->transaction);
-	tuple_set_d64(t, 18, es->sample->data_src);
-	tuple_set_s32(t, 19, es->sample->flags & PERF_BRANCH_MASK);
-	tuple_set_s32(t, 20, !!(es->sample->flags & PERF_IP_FLAG_IN_TX));
-	tuple_set_d64(t, 21, es->call_path_id);
-	tuple_set_d64(t, 22, es->sample->insn_cnt);
-	tuple_set_d64(t, 23, es->sample->cyc_cnt);
-	tuple_set_s32(t, 24, es->sample->flags);
-	tuple_set_d64(t, 25, es->sample->id);
-	tuple_set_d64(t, 26, es->sample->stream_id);
-	tuple_set_u32(t, 27, es->sample->ins_lat);
-
-	call_object(tables->sample_handler, t, "sample_table");
-
-	Py_DECREF(t);
-}
-
-static void python_export_synth(struct db_export *dbe, struct export_sampl=
e *es)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-
-	t =3D tuple_new(3);
-
-	tuple_set_d64(t, 0, es->db_id);
-	tuple_set_d64(t, 1, es->evsel->core.attr.config);
-	tuple_set_bytes(t, 2, es->sample->raw_data, es->sample->raw_size);
-
-	call_object(tables->synth_handler, t, "synth_data");
-
-	Py_DECREF(t);
-}
-
-static int python_export_sample(struct db_export *dbe,
-				struct export_sample *es)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-
-	python_export_sample_table(dbe, es);
-
-	if (es->evsel->core.attr.type =3D=3D PERF_TYPE_SYNTH && tables->synth_han=
dler)
-		python_export_synth(dbe, es);
-
-	return 0;
-}
-
-static int python_export_call_path(struct db_export *dbe, struct call_path=
 *cp)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-	u64 parent_db_id, sym_db_id;
-
-	parent_db_id =3D cp->parent ? cp->parent->db_id : 0;
-	sym_db_id =3D cp->sym ? *(u64 *)symbol__priv(cp->sym) : 0;
-
-	t =3D tuple_new(4);
-
-	tuple_set_d64(t, 0, cp->db_id);
-	tuple_set_d64(t, 1, parent_db_id);
-	tuple_set_d64(t, 2, sym_db_id);
-	tuple_set_d64(t, 3, cp->ip);
-
-	call_object(tables->call_path_handler, t, "call_path_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_export_call_return(struct db_export *dbe,
-				     struct call_return *cr)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	u64 comm_db_id =3D cr->comm ? cr->comm->db_id : 0;
-	PyObject *t;
-
-	t =3D tuple_new(14);
-
-	tuple_set_d64(t, 0, cr->db_id);
-	tuple_set_d64(t, 1, thread__db_id(cr->thread));
-	tuple_set_d64(t, 2, comm_db_id);
-	tuple_set_d64(t, 3, cr->cp->db_id);
-	tuple_set_d64(t, 4, cr->call_time);
-	tuple_set_d64(t, 5, cr->return_time);
-	tuple_set_d64(t, 6, cr->branch_count);
-	tuple_set_d64(t, 7, cr->call_ref);
-	tuple_set_d64(t, 8, cr->return_ref);
-	tuple_set_d64(t, 9, cr->cp->parent->db_id);
-	tuple_set_s32(t, 10, cr->flags);
-	tuple_set_d64(t, 11, cr->parent_db_id);
-	tuple_set_d64(t, 12, cr->insn_count);
-	tuple_set_d64(t, 13, cr->cyc_count);
-
-	call_object(tables->call_return_handler, t, "call_return_table");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_export_context_switch(struct db_export *dbe, u64 db_id,
-					struct machine *machine,
-					struct perf_sample *sample,
-					u64 th_out_id, u64 comm_out_id,
-					u64 th_in_id, u64 comm_in_id, int flags)
-{
-	struct tables *tables =3D container_of(dbe, struct tables, dbe);
-	PyObject *t;
-
-	t =3D tuple_new(9);
-
-	tuple_set_d64(t, 0, db_id);
-	tuple_set_d64(t, 1, machine->db_id);
-	tuple_set_d64(t, 2, sample->time);
-	tuple_set_s32(t, 3, sample->cpu);
-	tuple_set_d64(t, 4, th_out_id);
-	tuple_set_d64(t, 5, comm_out_id);
-	tuple_set_d64(t, 6, th_in_id);
-	tuple_set_d64(t, 7, comm_in_id);
-	tuple_set_s32(t, 8, flags);
-
-	call_object(tables->context_switch_handler, t, "context_switch");
-
-	Py_DECREF(t);
-
-	return 0;
-}
-
-static int python_process_call_return(struct call_return *cr, u64 *parent_=
db_id,
-				      void *data)
-{
-	struct db_export *dbe =3D data;
-
-	return db_export__call_return(dbe, cr, parent_db_id);
-}
-
-static void python_process_general_event(struct perf_sample *sample,
-					 struct evsel *evsel,
-					 struct addr_location *al,
-					 struct addr_location *addr_al)
-{
-	PyObject *handler, *t, *dict, *callchain;
-	static char handler_name[64];
-	unsigned n =3D 0;
-
-	snprintf(handler_name, sizeof(handler_name), "%s", "process_event");
-
-	handler =3D get_handler(handler_name);
-	if (!handler)
-		return;
-
-	/*
-	 * Use the MAX_FIELDS to make the function expandable, though
-	 * currently there is only one item for the tuple.
-	 */
-	t =3D PyTuple_New(MAX_FIELDS);
-	if (!t)
-		Py_FatalError("couldn't create Python tuple");
-
-	/* ip unwinding */
-	callchain =3D python_process_callchain(sample, evsel, al);
-	dict =3D get_perf_sample_dict(sample, evsel, al, addr_al, callchain);
-
-	PyTuple_SetItem(t, n++, dict);
-	if (_PyTuple_Resize(&t, n) =3D=3D -1)
-		Py_FatalError("error resizing Python tuple");
-
-	call_object(handler, t, handler_name);
-
-	Py_DECREF(t);
-}
-
-static void python_process_event(union perf_event *event,
-				 struct perf_sample *sample,
-				 struct evsel *evsel,
-				 struct addr_location *al,
-				 struct addr_location *addr_al)
-{
-	struct tables *tables =3D &tables_global;
-
-	scripting_context__update(scripting_context, event, sample, evsel, al, ad=
dr_al);
-
-	switch (evsel->core.attr.type) {
-	case PERF_TYPE_TRACEPOINT:
-		python_process_tracepoint(sample, evsel, al, addr_al);
-		break;
-	/* Reserve for future process_hw/sw/raw APIs */
-	default:
-		if (tables->db_export_mode)
-			db_export__sample(&tables->dbe, event, sample, evsel, al, addr_al);
-		else
-			python_process_general_event(sample, evsel, al, addr_al);
-	}
-}
-
-static void python_process_throttle(union perf_event *event,
-				    struct perf_sample *sample,
-				    struct machine *machine)
-{
-	const char *handler_name;
-	PyObject *handler, *t;
-
-	if (event->header.type =3D=3D PERF_RECORD_THROTTLE)
-		handler_name =3D "throttle";
-	else
-		handler_name =3D "unthrottle";
-	handler =3D get_handler(handler_name);
-	if (!handler)
-		return;
-
-	t =3D tuple_new(6);
-	if (!t)
-		return;
-
-	tuple_set_u64(t, 0, event->throttle.time);
-	tuple_set_u64(t, 1, event->throttle.id);
-	tuple_set_u64(t, 2, event->throttle.stream_id);
-	tuple_set_s32(t, 3, sample->cpu);
-	tuple_set_s32(t, 4, sample->pid);
-	tuple_set_s32(t, 5, sample->tid);
-
-	call_object(handler, t, handler_name);
-
-	Py_DECREF(t);
-}
-
-static void python_do_process_switch(union perf_event *event,
-				     struct perf_sample *sample,
-				     struct machine *machine)
-{
-	const char *handler_name =3D "context_switch";
-	bool out =3D event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
-	bool out_preempt =3D out && (event->header.misc & PERF_RECORD_MISC_SWITCH=
_OUT_PREEMPT);
-	pid_t np_pid =3D -1, np_tid =3D -1;
-	PyObject *handler, *t;
-
-	handler =3D get_handler(handler_name);
-	if (!handler)
-		return;
-
-	if (event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE) {
-		np_pid =3D event->context_switch.next_prev_pid;
-		np_tid =3D event->context_switch.next_prev_tid;
-	}
-
-	t =3D tuple_new(11);
-	if (!t)
-		return;
-
-	tuple_set_u64(t, 0, sample->time);
-	tuple_set_s32(t, 1, sample->cpu);
-	tuple_set_s32(t, 2, sample->pid);
-	tuple_set_s32(t, 3, sample->tid);
-	tuple_set_s32(t, 4, np_pid);
-	tuple_set_s32(t, 5, np_tid);
-	tuple_set_s32(t, 6, machine->pid);
-	tuple_set_bool(t, 7, out);
-	tuple_set_bool(t, 8, out_preempt);
-	tuple_set_s32(t, 9, sample->machine_pid);
-	tuple_set_s32(t, 10, sample->vcpu);
-
-	call_object(handler, t, handler_name);
-
-	Py_DECREF(t);
-}
-
-static void python_process_switch(union perf_event *event,
-				  struct perf_sample *sample,
-				  struct machine *machine)
-{
-	struct tables *tables =3D &tables_global;
-
-	if (tables->db_export_mode)
-		db_export__switch(&tables->dbe, event, sample, machine);
-	else
-		python_do_process_switch(event, sample, machine);
-}
-
-static void python_process_auxtrace_error(struct perf_session *session __m=
aybe_unused,
-					  union perf_event *event)
-{
-	struct perf_record_auxtrace_error *e =3D &event->auxtrace_error;
-	u8 cpumode =3D e->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
-	const char *handler_name =3D "auxtrace_error";
-	unsigned long long tm =3D e->time;
-	const char *msg =3D e->msg;
-	PyObject *handler, *t;
-
-	handler =3D get_handler(handler_name);
-	if (!handler)
-		return;
-
-	if (!e->fmt) {
-		tm =3D 0;
-		msg =3D (const char *)&e->time;
-	}
-
-	t =3D tuple_new(11);
-
-	tuple_set_u32(t, 0, e->type);
-	tuple_set_u32(t, 1, e->code);
-	tuple_set_s32(t, 2, e->cpu);
-	tuple_set_s32(t, 3, e->pid);
-	tuple_set_s32(t, 4, e->tid);
-	tuple_set_u64(t, 5, e->ip);
-	tuple_set_u64(t, 6, tm);
-	tuple_set_string(t, 7, msg);
-	tuple_set_u32(t, 8, cpumode);
-	tuple_set_s32(t, 9, e->machine_pid);
-	tuple_set_s32(t, 10, e->vcpu);
-
-	call_object(handler, t, handler_name);
-
-	Py_DECREF(t);
-}
-
-static void get_handler_name(char *str, size_t size,
-			     struct evsel *evsel)
-{
-	char *p =3D str;
-
-	scnprintf(str, size, "stat__%s", evsel__name(evsel));
-
-	while ((p =3D strchr(p, ':'))) {
-		*p =3D '_';
-		p++;
-	}
-}
-
-static void
-process_stat(struct evsel *counter, struct perf_cpu cpu, int thread, u64 t=
stamp,
-	     struct perf_counts_values *count)
-{
-	PyObject *handler, *t;
-	static char handler_name[256];
-	int n =3D 0;
-
-	t =3D PyTuple_New(MAX_FIELDS);
-	if (!t)
-		Py_FatalError("couldn't create Python tuple");
-
-	get_handler_name(handler_name, sizeof(handler_name),
-			 counter);
-
-	handler =3D get_handler(handler_name);
-	if (!handler) {
-		pr_debug("can't find python handler %s\n", handler_name);
-		return;
-	}
-
-	PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu.cpu));
-	PyTuple_SetItem(t, n++, _PyLong_FromLong(thread));
-
-	tuple_set_u64(t, n++, tstamp);
-	tuple_set_u64(t, n++, count->val);
-	tuple_set_u64(t, n++, count->ena);
-	tuple_set_u64(t, n++, count->run);
-
-	if (_PyTuple_Resize(&t, n) =3D=3D -1)
-		Py_FatalError("error resizing Python tuple");
-
-	call_object(handler, t, handler_name);
-
-	Py_DECREF(t);
-}
-
-static void python_process_stat(struct perf_stat_config *config,
-				struct evsel *counter, u64 tstamp)
-{
-	struct perf_thread_map *threads =3D counter->core.threads;
-	struct perf_cpu_map *cpus =3D counter->core.cpus;
-
-	for (int thread =3D 0; thread < perf_thread_map__nr(threads); thread++) {
-		unsigned int idx;
-		struct perf_cpu cpu;
-
-		perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-			process_stat(counter, cpu,
-				     perf_thread_map__pid(threads, thread), tstamp,
-				     perf_counts(counter->counts, idx, thread));
-		}
-	}
-}
-
-static void python_process_stat_interval(u64 tstamp)
-{
-	PyObject *handler, *t;
-	static const char handler_name[] =3D "stat__interval";
-	int n =3D 0;
-
-	t =3D PyTuple_New(MAX_FIELDS);
-	if (!t)
-		Py_FatalError("couldn't create Python tuple");
-
-	handler =3D get_handler(handler_name);
-	if (!handler) {
-		pr_debug("can't find python handler %s\n", handler_name);
-		return;
-	}
-
-	tuple_set_u64(t, n++, tstamp);
-
-	if (_PyTuple_Resize(&t, n) =3D=3D -1)
-		Py_FatalError("error resizing Python tuple");
-
-	call_object(handler, t, handler_name);
-
-	Py_DECREF(t);
-}
-
-static int perf_script_context_init(void)
-{
-	PyObject *perf_script_context;
-	PyObject *perf_trace_context;
-	PyObject *dict;
-	int ret;
-
-	perf_trace_context =3D PyImport_AddModule("perf_trace_context");
-	if (!perf_trace_context)
-		return -1;
-	dict =3D PyModule_GetDict(perf_trace_context);
-	if (!dict)
-		return -1;
-
-	perf_script_context =3D _PyCapsule_New(scripting_context, NULL, NULL);
-	if (!perf_script_context)
-		return -1;
-
-	ret =3D PyDict_SetItemString(dict, "perf_script_context", perf_script_con=
text);
-	if (!ret)
-		ret =3D PyDict_SetItemString(main_dict, "perf_script_context", perf_scri=
pt_context);
-	Py_DECREF(perf_script_context);
-	return ret;
-}
-
-static int run_start_sub(void)
-{
-	main_module =3D PyImport_AddModule("__main__");
-	if (main_module =3D=3D NULL)
-		return -1;
-	Py_INCREF(main_module);
-
-	main_dict =3D PyModule_GetDict(main_module);
-	if (main_dict =3D=3D NULL)
-		goto error;
-	Py_INCREF(main_dict);
-
-	if (perf_script_context_init())
-		goto error;
-
-	try_call_object("trace_begin", NULL);
-
-	return 0;
-
-error:
-	Py_XDECREF(main_dict);
-	Py_XDECREF(main_module);
-	return -1;
-}
-
-#define SET_TABLE_HANDLER_(name, handler_name, table_name) do {		\
-	tables->handler_name =3D get_handler(#table_name);		\
-	if (tables->handler_name)					\
-		tables->dbe.export_ ## name =3D python_export_ ## name;	\
-} while (0)
-
-#define SET_TABLE_HANDLER(name) \
-	SET_TABLE_HANDLER_(name, name ## _handler, name ## _table)
-
-static void set_table_handlers(struct tables *tables)
-{
-	const char *perf_db_export_mode =3D "perf_db_export_mode";
-	const char *perf_db_export_calls =3D "perf_db_export_calls";
-	const char *perf_db_export_callchains =3D "perf_db_export_callchains";
-	PyObject *db_export_mode, *db_export_calls, *db_export_callchains;
-	bool export_calls =3D false;
-	bool export_callchains =3D false;
-	int ret;
-
-	memset(tables, 0, sizeof(struct tables));
-	if (db_export__init(&tables->dbe))
-		Py_FatalError("failed to initialize export");
-
-	db_export_mode =3D PyDict_GetItemString(main_dict, perf_db_export_mode);
-	if (!db_export_mode)
-		return;
-
-	ret =3D PyObject_IsTrue(db_export_mode);
-	if (ret =3D=3D -1)
-		handler_call_die(perf_db_export_mode);
-	if (!ret)
-		return;
-
-	/* handle export calls */
-	tables->dbe.crp =3D NULL;
-	db_export_calls =3D PyDict_GetItemString(main_dict, perf_db_export_calls)=
;
-	if (db_export_calls) {
-		ret =3D PyObject_IsTrue(db_export_calls);
-		if (ret =3D=3D -1)
-			handler_call_die(perf_db_export_calls);
-		export_calls =3D !!ret;
-	}
-
-	if (export_calls) {
-		tables->dbe.crp =3D
-			call_return_processor__new(python_process_call_return,
-						   &tables->dbe);
-		if (!tables->dbe.crp)
-			Py_FatalError("failed to create calls processor");
-	}
-
-	/* handle export callchains */
-	tables->dbe.cpr =3D NULL;
-	db_export_callchains =3D PyDict_GetItemString(main_dict,
-						    perf_db_export_callchains);
-	if (db_export_callchains) {
-		ret =3D PyObject_IsTrue(db_export_callchains);
-		if (ret =3D=3D -1)
-			handler_call_die(perf_db_export_callchains);
-		export_callchains =3D !!ret;
-	}
-
-	if (export_callchains) {
-		/*
-		 * Attempt to use the call path root from the call return
-		 * processor, if the call return processor is in use. Otherwise,
-		 * we allocate a new call path root. This prevents exporting
-		 * duplicate call path ids when both are in use simultaneously.
-		 */
-		if (tables->dbe.crp)
-			tables->dbe.cpr =3D tables->dbe.crp->cpr;
-		else
-			tables->dbe.cpr =3D call_path_root__new();
-
-		if (!tables->dbe.cpr)
-			Py_FatalError("failed to create call path root");
-	}
-
-	tables->db_export_mode =3D true;
-	/*
-	 * Reserve per symbol space for symbol->db_id via symbol__priv()
-	 */
-	symbol_conf.priv_size =3D sizeof(u64);
-
-	SET_TABLE_HANDLER(evsel);
-	SET_TABLE_HANDLER(machine);
-	SET_TABLE_HANDLER(thread);
-	SET_TABLE_HANDLER(comm);
-	SET_TABLE_HANDLER(comm_thread);
-	SET_TABLE_HANDLER(dso);
-	SET_TABLE_HANDLER(symbol);
-	SET_TABLE_HANDLER(branch_type);
-	SET_TABLE_HANDLER(sample);
-	SET_TABLE_HANDLER(call_path);
-	SET_TABLE_HANDLER(call_return);
-	SET_TABLE_HANDLER(context_switch);
-
-	/*
-	 * Synthesized events are samples but with architecture-specific data
-	 * stored in sample->raw_data. They are exported via
-	 * python_export_sample() and consequently do not need a separate export
-	 * callback.
-	 */
-	tables->synth_handler =3D get_handler("synth_data");
-}
-
-static void _free_command_line(wchar_t **command_line, int num)
-{
-	int i;
-	for (i =3D 0; i < num; i++)
-		PyMem_RawFree(command_line[i]);
-	free(command_line);
-}
-
-
-/*
- * Start trace script
- */
-static int python_start_script(const char *script, int argc, const char **=
argv,
-			       struct perf_session *session)
-{
-	struct tables *tables =3D &tables_global;
-	wchar_t **command_line;
-	char buf[PATH_MAX];
-	int i, err =3D 0;
-	FILE *fp;
-
-	scripting_context->session =3D session;
-	command_line =3D malloc((argc + 1) * sizeof(wchar_t *));
-	if (!command_line)
-		return -1;
-
-	command_line[0] =3D Py_DecodeLocale(script, NULL);
-	for (i =3D 1; i < argc + 1; i++)
-		command_line[i] =3D Py_DecodeLocale(argv[i - 1], NULL);
-	PyImport_AppendInittab("perf_trace_context", PyInit_perf_trace_context);
-	Py_Initialize();
-
-	PySys_SetArgv(argc + 1, command_line);
-
-	fp =3D fopen(script, "r");
-	if (!fp) {
-		sprintf(buf, "Can't open python script \"%s\"", script);
-		perror(buf);
-		err =3D -1;
-		goto error;
-	}
-
-	err =3D PyRun_SimpleFile(fp, script);
-	if (err) {
-		fprintf(stderr, "Error running python script %s\n", script);
-		goto error;
-	}
-
-	err =3D run_start_sub();
-	if (err) {
-		fprintf(stderr, "Error starting python script %s\n", script);
-		goto error;
-	}
-
-	set_table_handlers(tables);
-
-	if (tables->db_export_mode) {
-		err =3D db_export__branch_types(&tables->dbe);
-		if (err)
-			goto error;
-	}
-
-	_free_command_line(command_line, argc + 1);
-
-	return err;
-error:
-	Py_Finalize();
-	_free_command_line(command_line, argc + 1);
-
-	return err;
-}
-
-static int python_flush_script(void)
-{
-	return 0;
-}
-
-/*
- * Stop trace script
- */
-static int python_stop_script(void)
-{
-	struct tables *tables =3D &tables_global;
-
-	try_call_object("trace_end", NULL);
-
-	db_export__exit(&tables->dbe);
-
-	Py_XDECREF(main_dict);
-	Py_XDECREF(main_module);
-	Py_Finalize();
-
-	return 0;
-}
-
-#ifdef HAVE_LIBTRACEEVENT
-static int python_generate_script(struct tep_handle *pevent, const char *o=
utfile)
-{
-	int i, not_first, count, nr_events;
-	struct tep_event **all_events;
-	struct tep_event *event =3D NULL;
-	struct tep_format_field *f;
-	char fname[PATH_MAX];
-	FILE *ofp;
-
-	sprintf(fname, "%s.py", outfile);
-	ofp =3D fopen(fname, "w");
-	if (ofp =3D=3D NULL) {
-		fprintf(stderr, "couldn't open %s\n", fname);
-		return -1;
-	}
-	fprintf(ofp, "# perf script event handlers, "
-		"generated by perf script -g python\n");
-
-	fprintf(ofp, "# Licensed under the terms of the GNU GPL"
-		" License version 2\n\n");
-
-	fprintf(ofp, "# The common_* event handler fields are the most useful "
-		"fields common to\n");
-
-	fprintf(ofp, "# all events.  They don't necessarily correspond to "
-		"the 'common_*' fields\n");
-
-	fprintf(ofp, "# in the format files.  Those fields not available as "
-		"handler params can\n");
-
-	fprintf(ofp, "# be retrieved using Python functions of the form "
-		"common_*(context).\n");
-
-	fprintf(ofp, "# See the perf-script-python Documentation for the list "
-		"of available functions.\n\n");
-
-	fprintf(ofp, "from __future__ import print_function\n\n");
-	fprintf(ofp, "import os\n");
-	fprintf(ofp, "import sys\n\n");
-
-	fprintf(ofp, "sys.path.append(os.environ['PERF_EXEC_PATH'] + \\\n");
-	fprintf(ofp, "\t'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')\n");
-	fprintf(ofp, "\nfrom perf_trace_context import *\n");
-	fprintf(ofp, "from Core import *\n\n\n");
-
-	fprintf(ofp, "def trace_begin():\n");
-	fprintf(ofp, "\tprint(\"in trace_begin\")\n\n");
-
-	fprintf(ofp, "def trace_end():\n");
-	fprintf(ofp, "\tprint(\"in trace_end\")\n\n");
-
-	nr_events =3D tep_get_events_count(pevent);
-	all_events =3D tep_list_events(pevent, TEP_EVENT_SORT_ID);
-
-	for (i =3D 0; all_events && i < nr_events; i++) {
-		event =3D all_events[i];
-		fprintf(ofp, "def %s__%s(", event->system, event->name);
-		fprintf(ofp, "event_name, ");
-		fprintf(ofp, "context, ");
-		fprintf(ofp, "common_cpu,\n");
-		fprintf(ofp, "\tcommon_secs, ");
-		fprintf(ofp, "common_nsecs, ");
-		fprintf(ofp, "common_pid, ");
-		fprintf(ofp, "common_comm,\n\t");
-		fprintf(ofp, "common_callchain, ");
-
-		not_first =3D 0;
-		count =3D 0;
-
-		for (f =3D event->format.fields; f; f =3D f->next) {
-			if (not_first++)
-				fprintf(ofp, ", ");
-			if (++count % 5 =3D=3D 0)
-				fprintf(ofp, "\n\t");
-
-			fprintf(ofp, "%s", f->name);
-		}
-		if (not_first++)
-			fprintf(ofp, ", ");
-		if (++count % 5 =3D=3D 0)
-			fprintf(ofp, "\n\t\t");
-		fprintf(ofp, "perf_sample_dict");
-
-		fprintf(ofp, "):\n");
-
-		fprintf(ofp, "\t\tprint_header(event_name, common_cpu, "
-			"common_secs, common_nsecs,\n\t\t\t"
-			"common_pid, common_comm)\n\n");
-
-		fprintf(ofp, "\t\tprint(\"");
-
-		not_first =3D 0;
-		count =3D 0;
-
-		for (f =3D event->format.fields; f; f =3D f->next) {
-			if (not_first++)
-				fprintf(ofp, ", ");
-			if (count && count % 3 =3D=3D 0) {
-				fprintf(ofp, "\" \\\n\t\t\"");
-			}
-			count++;
-
-			fprintf(ofp, "%s=3D", f->name);
-			if (f->flags & TEP_FIELD_IS_STRING ||
-			    f->flags & TEP_FIELD_IS_FLAG ||
-			    f->flags & TEP_FIELD_IS_ARRAY ||
-			    f->flags & TEP_FIELD_IS_SYMBOLIC)
-				fprintf(ofp, "%%s");
-			else if (f->flags & TEP_FIELD_IS_SIGNED)
-				fprintf(ofp, "%%d");
-			else
-				fprintf(ofp, "%%u");
-		}
-
-		fprintf(ofp, "\" %% \\\n\t\t(");
-
-		not_first =3D 0;
-		count =3D 0;
-
-		for (f =3D event->format.fields; f; f =3D f->next) {
-			if (not_first++)
-				fprintf(ofp, ", ");
-
-			if (++count % 5 =3D=3D 0)
-				fprintf(ofp, "\n\t\t");
-
-			if (f->flags & TEP_FIELD_IS_FLAG) {
-				if ((count - 1) % 5 !=3D 0) {
-					fprintf(ofp, "\n\t\t");
-					count =3D 4;
-				}
-				fprintf(ofp, "flag_str(\"");
-				fprintf(ofp, "%s__%s\", ", event->system,
-					event->name);
-				fprintf(ofp, "\"%s\", %s)", f->name,
-					f->name);
-			} else if (f->flags & TEP_FIELD_IS_SYMBOLIC) {
-				if ((count - 1) % 5 !=3D 0) {
-					fprintf(ofp, "\n\t\t");
-					count =3D 4;
-				}
-				fprintf(ofp, "symbol_str(\"");
-				fprintf(ofp, "%s__%s\", ", event->system,
-					event->name);
-				fprintf(ofp, "\"%s\", %s)", f->name,
-					f->name);
-			} else
-				fprintf(ofp, "%s", f->name);
-		}
-
-		fprintf(ofp, "))\n\n");
-
-		fprintf(ofp, "\t\tprint('Sample: {'+"
-			"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')\n\n");
-
-		fprintf(ofp, "\t\tfor node in common_callchain:");
-		fprintf(ofp, "\n\t\t\tif 'sym' in node:");
-		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x] %%s%%s%%s%%s\" %% (");
-		fprintf(ofp, "\n\t\t\t\t\tnode['ip'], node['sym']['name'],");
-		fprintf(ofp, "\n\t\t\t\t\t\"+0x{:x}\".format(node['sym_off']) if 'sym_of=
f' in node else \"\",");
-		fprintf(ofp, "\n\t\t\t\t\t\" ({})\".format(node['dso'])  if 'dso' in nod=
e else \"\",");
-		fprintf(ofp, "\n\t\t\t\t\t\" \" + node['sym_srcline'] if 'sym_srcline' i=
n node else \"\"))");
-		fprintf(ofp, "\n\t\t\telse:");
-		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x]\" %% (node['ip']))\n\n");
-		fprintf(ofp, "\t\tprint()\n\n");
-
-	}
-
-	fprintf(ofp, "def trace_unhandled(event_name, context, "
-		"event_fields_dict, perf_sample_dict):\n");
-
-	fprintf(ofp, "\t\tprint(get_dict_as_string(event_fields_dict))\n");
-	fprintf(ofp, "\t\tprint('Sample: {'+"
-		"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')\n\n");
-
-	fprintf(ofp, "def print_header("
-		"event_name, cpu, secs, nsecs, pid, comm):\n"
-		"\tprint(\"%%-20s %%5u %%05u.%%09u %%8u %%-20s \" %% \\\n\t"
-		"(event_name, cpu, secs, nsecs, pid, comm), end=3D\"\")\n\n");
-
-	fprintf(ofp, "def get_dict_as_string(a_dict, delimiter=3D' '):\n"
-		"\treturn delimiter.join"
-		"(['%%s=3D%%s'%%(k,str(v))for k,v in sorted(a_dict.items())])\n");
-
-	fclose(ofp);
-
-	fprintf(stderr, "generated Python script: %s\n", fname);
-
-	return 0;
-}
-#else
-static int python_generate_script(struct tep_handle *pevent __maybe_unused=
,
-				  const char *outfile __maybe_unused)
-{
-	fprintf(stderr, "Generating Python perf-script is not supported."
-		"  Install libtraceevent and rebuild perf to enable it.\n"
-		"For example:\n  # apt install libtraceevent-dev (ubuntu)"
-		"\n  # yum install libtraceevent-devel (Fedora)"
-		"\n  etc.\n");
-	return -1;
-}
-#endif
-
-struct scripting_ops python_scripting_ops =3D {
-	.name			=3D "Python",
-	.dirname		=3D "python",
-	.start_script		=3D python_start_script,
-	.flush_script		=3D python_flush_script,
-	.stop_script		=3D python_stop_script,
-	.process_event		=3D python_process_event,
-	.process_switch		=3D python_process_switch,
-	.process_auxtrace_error	=3D python_process_auxtrace_error,
-	.process_stat		=3D python_process_stat,
-	.process_stat_interval	=3D python_process_stat_interval,
-	.process_throttle	=3D python_process_throttle,
-	.generate_script	=3D python_generate_script,
-};
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trac=
e-event-scripting.c
index a82472419611..0a0a50d9e1e1 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -138,9 +138,7 @@ static void process_event_unsupported(union perf_event =
*event __maybe_unused,
 				      struct addr_location *al __maybe_unused,
 				      struct addr_location *addr_al __maybe_unused)
 {
-}
-
-static void print_python_unsupported_msg(void)
+} static void print_python_unsupported_msg(void)
 {
 	fprintf(stderr, "Python scripting not supported."
 		"  Install libpython and rebuild perf to enable it.\n"
@@ -192,20 +190,10 @@ static void register_python_scripting(struct scriptin=
g_ops *scripting_ops)
 	}
 }
=20
-#ifndef HAVE_LIBPYTHON_SUPPORT
 void setup_python_scripting(void)
 {
 	register_python_scripting(&python_scripting_unsupported_ops);
 }
-#else
-extern struct scripting_ops python_scripting_ops;
-
-void setup_python_scripting(void)
-{
-	register_python_scripting(&python_scripting_ops);
-}
-#endif
-
=20
=20
 static const struct {
--=20
2.54.0.545.g6539524ca2-goog

