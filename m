Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D23A4F4A
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377277; cv=none; b=HdRnNQqXrC3u5eo8Zt4bIcQILK58Lg/RiISHRj5l+Yz/nzwiib8dddjAU9He6a19/Oo9ZEB72e+RVFw24mPENmxz6OooPgZjjRHRkxpptx57FrjFNkP22uLMCgiLpjO5oXqVzicsrf2sF3TGnV4HnA0ZAg66kMyAVUshSaYMbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377277; c=relaxed/simple;
	bh=Qluq3E4Spzq7LZ3sD1WkFg05ED/NUZFx+CR18OclOHs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XFQuU8QAuss4s/RrcJPNSDMZfZt4uzhE2tEQybQxc4iOU8kJVN7+l8Sv1k46ZN0nkmP/6Sydq9Mfn4EPlVmANMmMDDk6WILnEAj6vyvuI0nAZ+JGdF4AVD4JhhKsvYVmCDUNcNEQNIDxbdWFzk1VlLRKSnbTma64qf1J3maiits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5+L58Ub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5+L58Ub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FAF1F000FF;
	Fri, 25 Sep 2026 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377275;
	bh=5cDT2q7CYTZnLXid0xvAsM+pLHPfFrQiNOpJuwfLU6s=;
	h=Date:From:To:Cc:Subject;
	b=a5+L58UbKuj2hjqWxoOabct3RP1uM8wX51o+fkV6z5VrlPJLvFZIGq0JkQ6ZzjDHp
	 Mc//0nwktAn2bfNeeikyYHrD8MvYuAJbwWNHe+EDWv4hP54NhFy8RQK4rCJnolctea
	 Au06njw2UQ1DLrYwqw9l7aPn1yasLbEzcgZsyicDs8V90n2BP4TultWY2urEgE4YNl
	 8ybq4KZyh4jveIA8/3x4hApfg5FrrEpzyXuid7LGmg6pglmq7jS7DORlwlmoxMZOu8
	 EJyEnb9hvsIVU+cgJBuglBWP25v3h5VBwIresvn+I2NOA1u721gsPMciFHPzVOkddq
	 bs4YArxeUwnLQ==
Date: Sat, 26 Sep 2026 01:01:12 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tools: Bump the minimum Python version to 3.9
Message-ID: <arb9OMEQ8HCcw-9O@x2>
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
interpreters that cannot be supported anyway, make 3.9 the floor: check
for it in Makefile.config, where the jevents generation check already
lives, and drop the removesuffix() shim, since str.removesuffix() was
added in 3.9.

RHEL 8 is in feature freeze, so those wanting a new perf and its python
features have to vendor a newer interpreter, just as
Documentation/process/changes.rst already asks for the kernel itself.

Tested with Python 3.9.22: perf builds, generating pmu-events.c and the
python binding, with byte for byte identical output to the build made
with the shim, while Python 3.8.20 and 3.6.15 are rejected with the
"older than 3.9" error. vermin reports no perf build file as requiring
more than 3.9, the only offender being the runtime script
scripts/python/mem-phys-addr.py, which the build doesn't run.

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config       |  8 +++++---
 tools/perf/pmu-events/jevents.py | 16 +++-------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b288ae0191acf7ef..92ac7c620b3ccd49 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -885,10 +885,12 @@ ifneq ($(NO_JEVENTS),1)
   ifndef PYTHON
     $(error ERROR: No python interpreter needed for jevents generation. Install python or build with NO_JEVENTS=1.)
   else
-    # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
-    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 6) else "0")' 2> /dev/null)
+    # Minimum Python version, the same one the kernel requires, see
+    # Documentation/process/changes.rst: jevents.py needs PEP 585 generics,
+    # list[...] and friends, that are subscriptable from Python 3.9.
+    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if sys.version_info >= (3, 9) else "0")' 2> /dev/null)
     ifneq ($(JEVENTS_PYTHON_GOOD), 1)
-      $(error ERROR: Python interpreter needed for jevents generation too old (older than 3.6). Install a newer python or build with NO_JEVENTS=1.)
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
2.55.0

