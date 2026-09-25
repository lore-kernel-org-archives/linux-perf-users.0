Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB83CB91E
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370888; cv=none; b=Uo64ttkMnSD46mjyPLmQ0xSyN6e8EnuJvMvrcbuHEz7sTHUUyIgpvHiNgz9fpul8gQbyW250Xoc+iVGdQhPMXoNxvdTmFLarj5AVHOY+Mkk5xHfB8CuUikukBRXs9+PvrbJ5jIVRar+8kfLxsZhv8i9rSSfj/zvOcS5oYVXctIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370888; c=relaxed/simple;
	bh=rtSIIumyjUP9U1vSaMEW8UJ3chSJ74vjPnzpREPbf2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVYWqtZ5wuoCh7o1eV21J7tL1yAlqAdkxAEnbQICxNiY1sxIe2o7fBC7tDgQ86F2tvUo3TfkuNWrp+cvvdVyHSq5iPPCuL+UHx3hf4mP5vCABjEpM3aLDiXxLmVDt5lyPilyAqyVBQCJZqLQRavG7eDUDEByq+kYq6icH1ZeCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdGWXsqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdGWXsqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C373F1F000FF;
	Fri, 25 Sep 2026 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790370886;
	bh=DzcQ2jZ6NwsxFKJ7kmsjXlhBJeGGKbbcoWb/CXT0sds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jdGWXsqTeTNPWp9teMbJ2vQMlKWatPqxIa2bysZx4KkUfRL/yBMPHoagHkg05WuZL
	 +YqkXhoGZcKl7PTmThZHqNRjRoiJZ5xZAn76We5fBLA6JeEnTLN2532kIzF7yg5HiH
	 7Jrd5+PhidziRsVTcw5j9F3OX38m6o+w9bsX/k8puB0eJaZ+lk5pSSmK1soqNRuvaI
	 VA5jF/5NOs4XZHveFJYFFcCpaxS3eCo8AMqf53g1maX+8t7iP/Wc7noogaN3FDKI+X
	 aWQTOFQp2AFKHTsmT2HtiEd2FGG8YEFL0TrB1I1fa/5Q65BDa4hUiPANJ4nUjlWdG6
	 vKdTZTTBprG5g==
Date: Fri, 25 Sep 2026 23:14:43 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf: Fix Python 3.6 build breakage in jevents.py
 and util/setup.py
Message-ID: <arbkQymeBZ0ja6sc@x2>
References: <arbd4TJm4s9MVjN-@x2>
 <CAP-5=fVXxUEYSfWb=AExGQoZ7w7FqGhD8Ga1+hjwF3gTZfsbpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVXxUEYSfWb=AExGQoZ7w7FqGhD8Ga1+hjwF3gTZfsbpA@mail.gmail.com>

On Fri, Sep 25, 2026 at 01:57:06PM -0700, Ian Rogers wrote:
> On Fri, Sep 25, 2026 at 1:47 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > perf's build still accepts Python 3.6: Makefile.config only rejects
> > interpreters older than 3.6 and jevents.py keeps its own removesuffix()
> > shim for it, but two recently added constructs are evaluated when the
> > module or the function is defined and only work on newer interpreters.
> 
> Could we remove the shim and bump the minimum Python version to 3.9 to
> be in line with the rest of the kernel build?
> https://github.com/torvalds/linux/blob/master/Documentation/process/changes.rst

Since RHEL8 based systems will still be in use for a long time and new
perf versions can be useful in solving problems in such systems, maybe
we should keep the support on 3.6 as is now :-\

This patch is not that big and fixes the only cases where python 3.6 was
breaking, so maybe this is not unreasonable to do.

- Arnaldo
 
> Thanks,
> Ian
> 
> > PEP 585's list[...] became subscriptable in Python 3.9, so the module
> > level annotations in jevents.py make Kbuild die at import time:
> >
> >   TypeError: 'type' object is not subscriptable
> >   make[3]: *** [pmu-events/Build:176: .../test-empty-pmu-events.c] Error 1
> >
> > as seen on almalinux:8 with its python3.6.8, and the list[str]
> > parameters of util/setup.py's functions fail the same way when the
> > python binding is built.
> >
> > ProcessPoolExecutor(initializer=, initargs=) was added in Python 3.7,
> > so generating pmu-events.c dies when the pool is created.
> >
> > Use the typing generics that exist on every supported interpreter and
> > only pass initializer/initargs when the interpreter has them: on 3.6
> > the default fork start method already leaves the worker processes with
> > the parent's _arch_std_events, which is what _init_worker() sets up
> > for spawn semantics.
> >
> > Tested with Python 3.6.15: make -C tools/perf completes, generating
> > pmu-events.c and the python binding.
> >
> > Fixes: cda907c2c3f99 ("perf jevents: Add python type annotations")
> > Fixes: 1fa8d81be1eb ("perf python: Clean up and restructure setup.py")
> > Fixes: eaab2eb09dc2 ("perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py")
> > Assisted-by: LLM
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/pmu-events/jevents.py | 24 +++++++++++++++---------
> >  tools/perf/util/setup.py         |  5 +++--
> >  2 files changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index 074daae5308b110b..bdc89ec197680c1b 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -8,19 +8,19 @@ import json
> >  import metric
> >  import os
> >  import sys
> > -from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
> > +from typing import (Any, Callable, Dict, List, Optional, Sequence, Set, Tuple)
> >  import collections
> >
> >  # Global command line arguments.
> >  _args = None
> >  # List of regular event tables.
> > -_event_tables: list[str] = []
> > +_event_tables: List[str] = []
> >  # List of event tables generated from "/sys" directories.
> > -_sys_event_tables: list[str] = []
> > +_sys_event_tables: List[str] = []
> >  # List of regular metric tables.
> > -_metric_tables: list[str] = []
> > +_metric_tables: List[str] = []
> >  # List of metric tables generated from "/sys" directories.
> > -_sys_metric_tables: list[str] = []
> > +_sys_metric_tables: List[str] = []
> >  # Mapping between sys event table names and sys metric table names.
> >  _sys_event_table_to_metric_table_mapping = {}
> >  # Map from an event name to an architecture standard
> > @@ -28,11 +28,11 @@ _sys_event_table_to_metric_table_mapping = {}
> >  # f'{_args.starting_dir}/{_args.arch}' directory.
> >  _arch_std_events: Dict[str, "JsonEvent"] = {}
> >  # Events to write out when the table is closed
> > -_pending_events: list["JsonEvent"] = []
> > +_pending_events: List["JsonEvent"] = []
> >  # Name of events table to be written out
> >  _pending_events_tblname: Optional[str] = None
> >  # Metrics to write out when the table is closed
> > -_pending_metrics: list["JsonEvent"] = []
> > +_pending_metrics: List["JsonEvent"] = []
> >  # Name of metrics table to be written out
> >  _pending_metrics_tblname: Optional[str] = None
> >  # Global BigCString shared by all structures.
> > @@ -1556,9 +1556,15 @@ struct pmu_table_entry {
> >      preprocess_arch_std_files(arch_path)
> >      ftw(arch_path, [], collect_json)
> >
> > +  # ProcessPoolExecutor's initializer/initargs need Python 3.7, on 3.6 the
> > +  # fork start method already leaves the workers with the parent's
> > +  # _arch_std_events, i.e. what _init_worker would set up.
> > +  executor_kwargs: Dict[str, Any] = {}
> > +  if sys.version_info >= (3, 7):
> > +    executor_kwargs = dict(initializer=_init_worker,
> > +                           initargs=(_arch_std_events,))
> >    with concurrent.futures.ProcessPoolExecutor(max_workers=_parallel_worker_count(len(tasks)),
> > -                                              initializer=_init_worker,
> > -                                              initargs=(_arch_std_events,)) as executor:
> > +                                              **executor_kwargs) as executor:
> >      for path, topic, events in executor.map(_parallel_read_json_events, tasks):
> >        _json_cache[(path, topic)] = events
> >
> > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > index 8380980ade4c486f..ad904b374ec6eaba 100644
> > --- a/tools/perf/util/setup.py
> > +++ b/tools/perf/util/setup.py
> > @@ -11,13 +11,14 @@ import shlex
> >  import shutil
> >  import subprocess
> >  import sysconfig
> > +from typing import List
> >
> >  from setuptools import setup, Extension
> >  from setuptools.command.build_ext import build_ext as _build_ext
> >  from setuptools.command.install_lib import install_lib as _install_lib
> >
> >
> > -def clang_has_option(cc: str, cc_args: list[str], src_feature_tests: str, option: str) -> bool:
> > +def clang_has_option(cc: str, cc_args: List[str], src_feature_tests: str, option: str) -> bool:
> >      """Check if clang supports a specific option.
> >
> >      Args:
> > @@ -47,7 +48,7 @@ def clang_has_option(cc: str, cc_args: list[str], src_feature_tests: str, option
> >      return not any(any(error in line for error in error_substrings) for line in cc_output)
> >
> >
> > -def filter_clang_options(cc: str, cc_args: list[str], src_feature_tests: str) -> None:
> > +def filter_clang_options(cc: str, cc_args: List[str], src_feature_tests: str) -> None:
> >      """Filter out unsupported clang options from sysconfig CFLAGS and OPT.
> >
> >      Args:
> > --
> > 2.55.0
> >
