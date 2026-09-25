Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297963D6CC4
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369254; cv=none; b=K2URaYm1mMl2fPhhAlnN9RZu6HMAz/RVfXjqnQBFh67BTfzCFbYjUCIjJn4Feskx7yBmitfUMkW+RbsXxhr5xrU5NuKjqa2qYJDSHaEyNINHfZqphGs71y4zavHPR4mQDULkUcxECiPOE9u95X8/S9NBNJWrgkdGUYdx0yC4hCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369254; c=relaxed/simple;
	bh=r9clqjPUbkKKPZXyWti7JNPr2JgO9NRAe4Ld9B30v9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hv+0YOg55QhU6SrDUmOHvWlnD/WZplBCq8hlypIPyXX51KYkEKmkQDtJ21471wCY+oin4fBOJq3eCe/SdClv7TBQL5eM58tXpqBd3B13gAfz74CO9f5NfjDzNtQzRZE3QGv+jeQ9tywMIiOX7nAHcWjXiwcCqBTZxCSIpfIE8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+bh0vIV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+bh0vIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0963C1F000FF;
	Fri, 25 Sep 2026 20:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790369252;
	bh=yOdqifkiB4/7nTBF3H0r6g16IkBVTsQqN8PEMJSQ06c=;
	h=Date:From:To:Cc:Subject;
	b=a+bh0vIVdRPwIB0FJKa3XwF3LoqJcYvvc6nXvyaeSuDhTVzIpmbpOidYea24tPEMs
	 OnXlMSfLs0UQzAO6weVsxNDKRX8gQvWgSGon78ugnDbjNKZ8bZ4kVx7cH5QpuyUU4l
	 upSw7ZMP3Exye7Wp+uv+huwvpojriZMwFDjLQUOdugrsExNm1uLSUIFwnDdQL5VwB4
	 rjiaUl2zmzvEaFvS6b/kQagP/m4GcqZ8Kk0Vdvh1LKVZD/OEgdNoIGLJHdayis0l8M
	 tcEaUVZBDXPOjqlZLVhQ81qX7yt+iZi1xkcUc21Jec58YbRI4I7qAsrH0iUpztlND3
	 ZKbkBewsBT08w==
Date: Fri, 25 Sep 2026 22:47:29 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf: Fix Python 3.6 build breakage in jevents.py and
 util/setup.py
Message-ID: <arbd4TJm4s9MVjN-@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

perf's build still accepts Python 3.6: Makefile.config only rejects
interpreters older than 3.6 and jevents.py keeps its own removesuffix()
shim for it, but two recently added constructs are evaluated when the
module or the function is defined and only work on newer interpreters.

PEP 585's list[...] became subscriptable in Python 3.9, so the module
level annotations in jevents.py make Kbuild die at import time:

  TypeError: 'type' object is not subscriptable
  make[3]: *** [pmu-events/Build:176: .../test-empty-pmu-events.c] Error 1

as seen on almalinux:8 with its python3.6.8, and the list[str]
parameters of util/setup.py's functions fail the same way when the
python binding is built.

ProcessPoolExecutor(initializer=, initargs=) was added in Python 3.7,
so generating pmu-events.c dies when the pool is created.

Use the typing generics that exist on every supported interpreter and
only pass initializer/initargs when the interpreter has them: on 3.6
the default fork start method already leaves the worker processes with
the parent's _arch_std_events, which is what _init_worker() sets up
for spawn semantics.

Tested with Python 3.6.15: make -C tools/perf completes, generating
pmu-events.c and the python binding.

Fixes: cda907c2c3f99 ("perf jevents: Add python type annotations")
Fixes: 1fa8d81be1eb ("perf python: Clean up and restructure setup.py")
Fixes: eaab2eb09dc2 ("perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.py | 24 +++++++++++++++---------
 tools/perf/util/setup.py         |  5 +++--
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 074daae5308b110b..bdc89ec197680c1b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -8,19 +8,19 @@ import json
 import metric
 import os
 import sys
-from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
+from typing import (Any, Callable, Dict, List, Optional, Sequence, Set, Tuple)
 import collections
 
 # Global command line arguments.
 _args = None
 # List of regular event tables.
-_event_tables: list[str] = []
+_event_tables: List[str] = []
 # List of event tables generated from "/sys" directories.
-_sys_event_tables: list[str] = []
+_sys_event_tables: List[str] = []
 # List of regular metric tables.
-_metric_tables: list[str] = []
+_metric_tables: List[str] = []
 # List of metric tables generated from "/sys" directories.
-_sys_metric_tables: list[str] = []
+_sys_metric_tables: List[str] = []
 # Mapping between sys event table names and sys metric table names.
 _sys_event_table_to_metric_table_mapping = {}
 # Map from an event name to an architecture standard
@@ -28,11 +28,11 @@ _sys_event_table_to_metric_table_mapping = {}
 # f'{_args.starting_dir}/{_args.arch}' directory.
 _arch_std_events: Dict[str, "JsonEvent"] = {}
 # Events to write out when the table is closed
-_pending_events: list["JsonEvent"] = []
+_pending_events: List["JsonEvent"] = []
 # Name of events table to be written out
 _pending_events_tblname: Optional[str] = None
 # Metrics to write out when the table is closed
-_pending_metrics: list["JsonEvent"] = []
+_pending_metrics: List["JsonEvent"] = []
 # Name of metrics table to be written out
 _pending_metrics_tblname: Optional[str] = None
 # Global BigCString shared by all structures.
@@ -1556,9 +1556,15 @@ struct pmu_table_entry {
     preprocess_arch_std_files(arch_path)
     ftw(arch_path, [], collect_json)
 
+  # ProcessPoolExecutor's initializer/initargs need Python 3.7, on 3.6 the
+  # fork start method already leaves the workers with the parent's
+  # _arch_std_events, i.e. what _init_worker would set up.
+  executor_kwargs: Dict[str, Any] = {}
+  if sys.version_info >= (3, 7):
+    executor_kwargs = dict(initializer=_init_worker,
+                           initargs=(_arch_std_events,))
   with concurrent.futures.ProcessPoolExecutor(max_workers=_parallel_worker_count(len(tasks)),
-                                              initializer=_init_worker,
-                                              initargs=(_arch_std_events,)) as executor:
+                                              **executor_kwargs) as executor:
     for path, topic, events in executor.map(_parallel_read_json_events, tasks):
       _json_cache[(path, topic)] = events
 
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 8380980ade4c486f..ad904b374ec6eaba 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -11,13 +11,14 @@ import shlex
 import shutil
 import subprocess
 import sysconfig
+from typing import List
 
 from setuptools import setup, Extension
 from setuptools.command.build_ext import build_ext as _build_ext
 from setuptools.command.install_lib import install_lib as _install_lib
 
 
-def clang_has_option(cc: str, cc_args: list[str], src_feature_tests: str, option: str) -> bool:
+def clang_has_option(cc: str, cc_args: List[str], src_feature_tests: str, option: str) -> bool:
     """Check if clang supports a specific option.
 
     Args:
@@ -47,7 +48,7 @@ def clang_has_option(cc: str, cc_args: list[str], src_feature_tests: str, option
     return not any(any(error in line for error in error_substrings) for line in cc_output)
 
 
-def filter_clang_options(cc: str, cc_args: list[str], src_feature_tests: str) -> None:
+def filter_clang_options(cc: str, cc_args: List[str], src_feature_tests: str) -> None:
     """Filter out unsupported clang options from sysconfig CFLAGS and OPT.
 
     Args:
-- 
2.55.0

