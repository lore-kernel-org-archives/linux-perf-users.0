Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA850EC06
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379944; cv=none; b=HtIxCXs4hONdr7jOblUXV7ZfgVJLkU69NaCpaTEVJ84bMch7x+O98DSoJgt2kHuLaJUyGRyVBCKXK10I6OtLajUaVxNOyl/rhRO4rBnhxEWIHK18zOKz/Dv4kg60CWEny/dPMBVr/KiK2dc0O04wt2NfQLHRq/g+WusMiEt4ulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379944; c=relaxed/simple;
	bh=/WISYHW1a081Isovz+WBgA8t70PMCgsjXV12HMB9tIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LwZd18ZDhKj79ruIylykur73ZU743exaUTUJgl0K1R0hU+msQb5DaFdWPnaQ44B0m2yZomPJAOquzvJg0pvgQUpwvWSJhoFfX1MgaeT03cHb9KEgkAOMxku5PLrXfAY1AnQGQxp51siX8R2r616+tTXTpw7Wti5TNLCa9juO2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP7iYmry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP7iYmry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B8B1F000FF;
	Fri, 25 Sep 2026 23:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379937;
	bh=RiXcbXTqu9RgHy25TmxQgsSckaim3dZan8p3XYlRoFY=;
	h=Date:From:To:Cc:Subject;
	b=DP7iYmryRl2FvrhfzyI967vVXLaHw7gHQN4j6PAiocIadzEG4Vzi/cZ5RPrFXCHJQ
	 +lLv5r0TPeUIHA5j4rVDQIWz5sO55Sk0p0njhx9hqi4XBiuN1Ct+ILvw4S+v0w7DbT
	 /tYRaq0m6uaJQdmkE9lXjjZkLIzQuMy8lb/3/Hqjscn1r4dNac7vGlXwVF4Z5gvzqW
	 K0vfNRBcBjDsdnPY9+hezqw4Qv8I938X7u2cMmxLhk5YmVL8hc+0BquW63Jt045YcK
	 a41IWxp0l9yy1vzXgHvnM4nB340B+nHE6EJOFYBjYOZu12jlbBd3df6Nnm0b2u8XDl
	 ANo3s5/34lfXg==
Date: Sat, 26 Sep 2026 01:45:34 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/1] perf tools: Bump the minimum Python version to 3.9
Message-ID: <arcHnvhd56I8SrZH@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

perf's build only refused interpreters older than 3.6, the check added
when jevents.py started using f-strings, and jevents.py carried a
removesuffix() shim to stay usable on them.

The kernel itself requires Python 3.9.x since 5e25b972a22be224 ("docs:
changes: update Python minimal version"), so tools in the tree are
expected to work with it, and staying compatible with older
interpreters stopped paying off:

 - the PEP 585 generics, list[...], used by the type annotations in
   jevents.py and util/setup.py are only subscriptable from Python 3.9
   and, being evaluated at import or definition time, they break the
   build on RHEL 8's python3.6.8 with:

   TypeError: 'type' object is not subscriptable

 - ProcessPoolExecutor(initializer=, initargs=) requires Python 3.7, so
   generating pmu-events.c fails there as well.

Rather than spreading version guards and typing.List() workarounds for
interpreters that cannot be supported anyway, make 3.9 the floor: ask
for it once in Makefile.config and use the result in both places that
run python while building, jevents generation and the python binding,
as the binding is still built when NO_JEVENTS=1 skips the generation
check, and drop the removesuffix() shim, since str.removesuffix() was
added in 3.9.

RHEL 8 is in feature freeze, so those wanting a new perf and its python
features have to vendor a newer interpreter, just as
Documentation/process/changes.rst already asks for the kernel itself.

Tested with Python 3.9.22: perf builds, generating pmu-events.c and the
python binding, with byte for byte identical output to the build made
with the shim, while Python 3.8.20 and 3.6.15 are rejected with the
"older than 3.9" error, by the jevents check in a regular build and by
the binding check when NO_JEVENTS=1 makes them sail past it, where they
used to die on the TypeError from util/setup.py. With NO_JEVENTS=1 and
NO_LIBPYTHON=1 no interpreter runs while building, so neither check
applies. vermin reports no perf build file as requiring more than 3.9,
the only offender being the runtime script
scripts/python/mem-phys-addr.py, which the build doesn't run.

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

---

What changed from v1:

- The 3.9 check now also covers the python binding, addressing
  sashiko-bot's [Low] finding on v1
  (<20260925230813.6F6F61F000FF@smtp.kernel.org>): Makefile.config
  probes the interpreter once, PYTHON_39_GOOD, and both jevents
  generation and the binding check it, so NO_JEVENTS=1 no longer lets
  an old python reach util/setup.py and die with the TypeError.
- With NO_JEVENTS=1 and NO_LIBPYTHON=1 no interpreter runs while
  building, so neither check applies.
  Command to see this delta: git diff perf-tools-next-before-122-python-binding-gate..HEAD

---
 tools/perf/Makefile.config       | 24 ++++++++++++++++++++----
 tools/perf/pmu-events/jevents.py | 16 +++-------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b288ae0191acf7ef..c4ae1cf04e00276d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -834,6 +834,16 @@ define disable-python_code
   NO_LIBPYTHON := 1
 endef
 
+# Minimum Python version for the interpreters perf runs while building,
+# the same one the kernel requires, see
+# Documentation/process/changes.rst: jevents generation (pmu-events/
+# jevents.py) and the python binding (util/setup.py) both use PEP 585
+# generics, list[...] and friends, that are subscriptable only from
+# Python 3.9.
+ifdef PYTHON
+  PYTHON_39_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if sys.version_info >= (3, 9) else "0")' 2> /dev/null)
+endif
+
 PYTHON_EXTENSION_SUFFIX := '.so'
 ifdef NO_LIBPYTHON
   $(call disable-python,Python support disabled by user)
@@ -851,6 +861,14 @@ else
       ifneq ($(feature-libpython), 1)
         $(call disable-python,No 'Python.h' was found: disables Python support - please install python-devel/python-dev)
       else
+         # The binding is built even when jevents generation is turned off
+         # with NO_JEVENTS=1, which skips the check in that block below, so
+         # check the version here as well: otherwise util/setup.py dies on
+         # older interpreters with "TypeError: 'type' object is not
+         # subscriptable" instead of a Makefile error.
+         ifneq ($(PYTHON_39_GOOD), 1)
+           $(error ERROR: Python interpreter needed for the python binding too old (older than 3.9). Install a newer python or build with NO_LIBPYTHON=1.)
+         endif
          LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
          EXTLIBS += $(PYTHON_EMBED_LIBADD)
          PYTHON_SETUPTOOLS_INSTALLED := $(shell $(PYTHON) -c 'import setuptools;' 2> /dev/null && echo "yes" || echo "no")
@@ -885,10 +903,8 @@ ifneq ($(NO_JEVENTS),1)
   ifndef PYTHON
     $(error ERROR: No python interpreter needed for jevents generation. Install python or build with NO_JEVENTS=1.)
   else
-    # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
-    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 6) else "0")' 2> /dev/null)
-    ifneq ($(JEVENTS_PYTHON_GOOD), 1)
-      $(error ERROR: Python interpreter needed for jevents generation too old (older than 3.6). Install a newer python or build with NO_JEVENTS=1.)
+    ifneq ($(PYTHON_39_GOOD), 1)
+      $(error ERROR: Python interpreter needed for jevents generation too old (older than 3.9). Install a newer python or build with NO_JEVENTS=1.)
     endif
   endif
 endif
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 074daae5308b110b..296bf68d10810952 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -65,15 +65,6 @@ _json_metric_attributes = [
 _json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg',
                          'default_show_events']
 
-def removesuffix(s: str, suffix: str) -> str:
-  """Remove the suffix from a string
-
-  The removesuffix function is added to str in Python 3.9. We aim for 3.6
-  compatibility and so provide our own function here.
-  """
-  return s[0:-len(suffix)] if s.endswith(suffix) else s
-
-
 def file_name_to_table_name(prefix: str, parents: Sequence[str],
                             dirname: str) -> str:
   """Generate a C table name from directory names."""
@@ -214,9 +205,8 @@ class JsonEvent:
       """Fix formatting issue for the desc string."""
       if s is None:
         return None
-      return removesuffix(removesuffix(removesuffix(s, '.  '),
-                                       '. '), '.').replace('\n', '\\n').replace(
-                                           '\"', '\\"').replace('\r', '\\r')
+      return s.removesuffix('.  ').removesuffix('. ').removesuffix('.').replace(
+          '\n', '\\n').replace('\"', '\\"').replace('\r', '\\r')
 
     def convert_aggr_mode(aggr_mode: Optional[str]) -> Optional[str]:
       """Returns the aggr_mode_class enum value associated with the JSON string."""
@@ -641,7 +631,7 @@ static const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
 def get_topic(topic: str) -> str:
   if topic.endswith('metrics.json'):
     return 'metrics'
-  return removesuffix(topic, '.json').replace('-', ' ')
+  return topic.removesuffix('.json').replace('-', ' ')
 
 def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if item.is_dir():
-- 
2.53.0

