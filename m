Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C4426689
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542256; cv=none; b=f4IB4t/ks/GHRvFVGGoBZgeMAxHnM/P2uew5tcqTG6FlO425UZH+eysWtEItuGQ/7kGFINcayV44jfzWCQZywCPUYT1fe8ymh1RqmwE1gQtogcEF6hGxVxTdgMeHLG4cPs2947hKEolVAjWtYfASsY+noQADnVkyP0VaOEcMaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542256; c=relaxed/simple;
	bh=/3BRl3M8W0BbD/ZBv4WxPJLa0vUr671s05PZ4bV30Y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NT2QgHZn/q4+5To8jRtnHcmyVT9NzCpjhKaIt7z7srYoTLluV3ZIvsdd/JP+yeJqgzg/wfebRincnJhWx/AfAbfJjxMiAiy2VYa7zE2DBm4cG8A7ZuCWqTOYEK4p0dSpERe2XpN3mKeFa4tiMG6LZy1/M2fmGPIV00vbs94J/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ef4Zkoyx; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ef4Zkoyx"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3080bb0267dso28948eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542253; x=1782147053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1LB+iJyXOMTQtPS5aUwDh4eekTqiImJhgFM4LFw8C0=;
        b=Ef4ZkoyxWWGAyGQlhIFWTLpBBAvPytQrassDAWccKVV+8KbZ14i/PyeTX2HcVN1UJQ
         K6huqG7ms31JQVImZzl18QOjYtAM+jZXrpDOhrG2bhlkbzYejx3MNH6v0a5bPLM1DoAe
         6HubfXxS/lKTyaw4JzK9E3xUsTdlyP5A6U9KvQXeyj3OrNcBzbXh1m1itRkNSOLhnpS5
         8R+lxvmYtci0LMzHTSPS7R/ZI2jIecMiT3DnpzQJGWT9z+UOX2jMCDkZf3g+XNA7Oh8w
         OEMC6GxHmlfQ1V/mESxwqMChVRY6O5Fpjz71l9yR5dZt8mmOW4pDE02s+Aukv68mJtmz
         E5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542253; x=1782147053;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z1LB+iJyXOMTQtPS5aUwDh4eekTqiImJhgFM4LFw8C0=;
        b=pDGuz9hW1MVdS92dhZUdHpPpPmZSRL9RMI1jjzHDaW0/BSvC3fzJukkk/a6r6kO3z4
         Ll9GafFfurzPgFnptDfVLApuiWvB66Cd2OgrhE49smyClI+vAGTVdefqIJGU0uVjH9Xv
         8Ig6AsGjibwhnd3XKaW0+vONhg+I9TObzgH6bJyG6bz0xNFAimnw+GqhzoesbqwcKXgT
         8EnT4azNFJZbkQhntq2PB/AJ4x2tsPprFYeXttBPyIFvvxr14iQrpkMtFU+62jahBbJS
         1kfGvDx4uztLUYDsCi+85xJ6wIlI9j0GblqKGngHEsLDXGmJyAFXpGfUEfb01RMcrWPH
         1Keg==
X-Forwarded-Encrypted: i=1; AFNElJ9fegUIlFLZ1syZfjrU5qC5YgdFhPvcioqkkW0ntY9daMP2saMBmJ6ogskop9NWRGFXKDyj8OMykakVtJHRY1Jl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4syqEbIqyiQTJgML33MPF8ywyD0T0FnbHBvMnF4iV2hFXJbjL
	U/n0hKzSK+NK2buifSdV9OgIiDbsCQlVxx888l5zbRvBhSOrvjzoa+1TTZ5u9xq2ccIvOec9VLX
	9H02WjsKc2g==
X-Received: from dyev5.prod.google.com ([2002:a05:7300:4305:b0:2da:2af9:bfe2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4350:b0:2be:7fc2:fc38
 with SMTP id 5a478bee46e88-3093551a511mr6146912eec.5.1781542252288; Mon, 15
 Jun 2026 09:50:52 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:50:09 -0700
In-Reply-To: <20260615165010.2724690-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615165010.2724690-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615165010.2724690-20-irogers@google.com>
Subject: [PATCH v19 19/20] perf python: Add perf.pyi stubs file
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add Python type stubs for the perf module to improve IDE support and
static analysis.  Includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v12:
 - Audited all `perf.pyi` event stubs: added full `sample_members` attribut=
es (`pid`, `tid`, `time`, `id`, `stream_id`, `period`, `cpu`) to all payloa=
d events via inheritance. Fixed `sample_event` unique fields (`ip`, `addr`,=
 `phys_addr`, `weight`, `data_src`, `insn_cnt`, `cyc_cnt`). Renamed `mmap_e=
vent.addr` to `start`. Removed `read_event.value`.

v2:

1. Added Missing Module Functions: Added parse_metrics and
   pmus. Renamed metrics to parse_metrics to match python.c .

2. Added Constructors: Added __init__ methods for data , evsel , and
   evlist with their appropriate arguments.

3. Removed sample_comm : Removed it from sample_event since it is not
   exported in python.c .

4. Keyword Handling in branch_entry : I used from_ip and to_ip in the
   stubs to match the rename I did in python.c (in turn 145) to avoid
   the Python from keyword conflict.

5. Added Missing Event Classes: Added mmap_event , lost_event ,
   comm_event , task_event , throttle_event , read_event , and
   switch_event .

6. Added Missing evlist Methods: Added get_pollfd and add .

7. Updated Return Types: Changed process_events to return int .

v6:
- Updated `perf.pyi` to use `find_thread` and `elf_machine`.

v8:
- Added mmap2_event class and new evsel attributes to perf.pyi.
- Added pid, tid, ppid, cpu attributes to class thread in perf.pyi.
---
 tools/perf/Makefile.perf   |   7 +-
 tools/perf/python/perf.pyi | 672 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/python.c   |  16 +-
 tools/perf/util/setup.py   |   5 +
 4 files changed, 696 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/python/perf.pyi

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 476b8dcaef58..3f0544d37a7f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -517,12 +517,15 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_=
BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
=20
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.p=
y $(PERFLIBS_PY)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.p=
y python/perf.pyi $(PERFLIBS_PY)
 	$(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared" \
         CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS) $(LIBS_PY)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  $(python_setup_quiet) build_ext; \
-	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
+	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
+	if [ "$(abspath python/perf.pyi)" !=3D "$(abspath $(OUTPUT)python/perf.py=
i)" ]; then \
+		cp python/perf.pyi $(OUTPUT)python/; \
+	fi
=20
 python_perf_target:
 	@echo "Target is: $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)"
diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
new file mode 100644
index 000000000000..976ff965263b
--- /dev/null
+++ b/tools/perf/python/perf.pyi
@@ -0,0 +1,672 @@
+"""Type stubs for the perf Python module."""
+from typing import Callable, Dict, List, Optional, Any, Iterator
+
+def config_get(name: str) -> Optional[str]:
+    """Get a configuration value from perf config.
+
+    Args:
+        name: The configuration variable name (e.g., 'colors.top').
+
+    Returns:
+        The configuration value as a string, or None if not set.
+    """
+    ...
+
+def metrics() -> List[Dict[str, str]]:
+    """Get a list of available metrics.
+
+    Returns:
+        A list of dictionaries, each describing a metric.
+    """
+    ...
+
+def syscall_name(id: int, *, elf_machine: Optional[int] =3D None) -> str:
+    """Convert a syscall number to its name.
+
+    Args:
+        sc_id: The syscall number.
+        elf_machine: Optional ELF machine type.
+
+    Returns:
+        The name of the syscall.
+    """
+    ...
+
+def syscall_id(name: str, *, elf_machine: Optional[int] =3D None) -> int:
+    """Convert a syscall name to its number.
+
+    Args:
+        name: The syscall name.
+        elf_machine: Optional ELF machine type.
+
+    Returns:
+        The number of the syscall.
+    """
+    ...
+
+def parse_events(
+    event_string: str,
+    cpus: Optional[cpu_map] =3D None,
+    threads: Optional[Any] =3D None
+) -> 'evlist':
+    """Parse an event string and return an evlist.
+
+    Args:
+        event_string: The event string (e.g., 'cycles,instructions').
+        cpus: Optional CPU map to bind events to.
+        threads: Optional thread map to bind events to.
+
+    Returns:
+        An evlist containing the parsed events.
+    """
+    ...
+
+def parse_metrics(
+    metrics_string: str,
+    pmu: Optional[str] =3D None,
+    cpus: Optional[cpu_map] =3D None,
+    threads: Optional[Any] =3D None
+) -> 'evlist':
+    """Parse a string of metrics or metric groups and return an evlist."""
+    ...
+
+def tracepoint(sys: str, name: str) -> int:
+    """Returns the tracepoint ID for a given system and name."""
+    ...
+
+def pmus() -> Iterator[Any]:
+    """Returns a sequence of pmus."""
+    ...
+
+class data:
+    """Represents a perf data file."""
+    def __init__(self, path: str =3D ..., fd: int =3D ...) -> None: ...
+
+class thread:
+    """Represents a thread in the system."""
+    def comm(self) -> str:
+        """Get the command name of the thread."""
+        ...
+    pid: int
+    tid: int
+    ppid: int
+    cpu: int
+
+class counts_values:
+    """Raw counter values."""
+    id: int
+    val: int
+    ena: int
+    run: int
+    lost: int
+    values: List[int]
+
+class thread_map:
+    """Map of threads being monitored."""
+    def __init__(self, pid: int =3D -1, tid: int =3D -1) -> None:
+        """Initialize a thread map.
+
+        Args:
+            pid: Process ID to monitor (-1 for all).
+            tid: Thread ID to monitor (-1 for all).
+        """
+        ...
+    def __len__(self) -> int: ...
+    def __getitem__(self, index: int) -> int: ...
+    def __iter__(self) -> Iterator[int]: ...
+
+class evsel:
+    """Event selector, represents a single event being monitored."""
+    def __init__(
+        self,
+        type: int =3D ...,
+        config: int =3D ...,
+        sample_freq: int =3D ...,
+        sample_period: int =3D ...,
+        sample_type: int =3D ...,
+        read_format: int =3D ...,
+        disabled: bool =3D ...,
+        inherit: bool =3D ...,
+        pinned: bool =3D ...,
+        exclusive: bool =3D ...,
+        exclude_user: bool =3D ...,
+        exclude_kernel: bool =3D ...,
+        exclude_hv: bool =3D ...,
+        exclude_idle: bool =3D ...,
+        mmap: bool =3D ...,
+        context_switch: bool =3D ...,
+        comm: bool =3D ...,
+        freq: bool =3D ...,
+        inherit_stat: bool =3D ...,
+        enable_on_exec: bool =3D ...,
+        task: bool =3D ...,
+        watermark: int =3D ...,
+        precise_ip: int =3D ...,
+        mmap_data: bool =3D ...,
+        sample_id_all: bool =3D ...,
+        wakeup_events: int =3D ...,
+        bp_type: int =3D ...,
+        bp_addr: int =3D ...,
+        bp_len: int =3D ...,
+        idx: int =3D ...,
+    ) -> None: ...
+    def __str__(self) -> str:
+        """Return string representation of the event."""
+        ...
+    def open(self) -> None:
+        """Open the event selector file descriptor table."""
+        ...
+    def read(self, cpu: int, thread: int) -> counts_values:
+        """Read counter values for a specific CPU and thread."""
+        ...
+    ids: List[int]
+    def cpus(self) -> cpu_map:
+        """Get CPU map for this event."""
+        ...
+    def threads(self) -> thread_map:
+        """Get thread map for this event."""
+        ...
+    tracking: bool
+    config: int
+    read_format: int
+    sample_period: int
+    sample_type: int
+    size: int
+    type: int
+    wakeup_events: int
+
+
+class _sample_members:
+    sample_pid: int
+    sample_tid: int
+    sample_time: int
+    sample_id: int
+    sample_stream_id: int
+    sample_period: int
+    sample_cpu: int
+
+class sample_event(_sample_members):
+    """Represents a sample event from perf."""
+    evsel: evsel
+    sample_ip: int
+    sample_addr: int
+    sample_phys_addr: int
+    sample_weight: int
+    sample_data_src: int
+    sample_insn_count: int
+    sample_cyc_count: int
+    type: int
+    raw_buf: bytes
+    dso: str
+    dso_long_name: str
+    dso_bid: Optional[bytes]
+    map_start: int
+    map_end: int
+    map_pgoff: int
+    symbol: str
+    sym_start: int
+    sym_end: int
+    brstack: Optional['branch_stack']
+    callchain: Optional['callchain']
+    def srccode(self) -> str: ...
+    def insn(self) -> str: ...
+    def __getattr__(self, name: str) -> Any: ...
+
+class mmap_event(_sample_members):
+    """Represents a mmap event from perf."""
+    type: int
+    misc: int
+    pid: int
+    tid: int
+    start: int
+    len: int
+    pgoff: int
+    filename: str
+    evsel: Optional['evsel']
+
+class mmap2_event(_sample_members):
+    """Represents a mmap2 event from perf."""
+    type: int
+    misc: int
+    pid: int
+    tid: int
+    start: int
+    len: int
+    pgoff: int
+    prot: int
+    flags: int
+    filename: str
+    maj: Optional[int]
+    min: Optional[int]
+    ino: Optional[int]
+    ino_generation: Optional[int]
+    build_id: Optional[bytes]
+    evsel: Optional['evsel']
+
+class lost_event(_sample_members):
+    """Represents a lost events record."""
+    type: int
+    id: int
+    lost: int
+    evsel: Optional['evsel']
+
+class comm_event(_sample_members):
+    """Represents a COMM record."""
+    type: int
+    pid: int
+    tid: int
+    comm: str
+    evsel: Optional['evsel']
+
+class task_event(_sample_members):
+    """Represents an EXIT or FORK record."""
+    type: int
+    pid: int
+    ppid: int
+    tid: int
+    ptid: int
+    time: int
+    evsel: Optional['evsel']
+
+class throttle_event(_sample_members):
+    """Represents a THROTTLE or UNTHROTTLE record."""
+    type: int
+    time: int
+    id: int
+    stream_id: int
+    evsel: Optional['evsel']
+
+class read_event(_sample_members):
+    """Represents a READ record."""
+    type: int
+    pid: int
+    tid: int
+    evsel: Optional['evsel']
+
+class switch_event(_sample_members):
+    """Represents a SWITCH or SWITCH_CPU_WIDE record."""
+    type: int
+    next_prev_pid: int
+    next_prev_tid: int
+    evsel: Optional['evsel']
+
+class branch_entry:
+    """Represents a branch entry in the branch stack.
+
+    Attributes:
+        from_ip: Source address of the branch (corresponds to 'from' keywo=
rd in C).
+        to_ip: Destination address of the branch.
+        mispred: True if the branch was mispredicted.
+        predicted: True if the branch was predicted.
+        in_tx: True if the branch was in a transaction.
+        abort: True if the branch was an abort.
+        cycles: Number of cycles since the last branch.
+        type: Type of branch.
+    """
+    from_ip: int
+    to_ip: int
+    mispred: bool
+    predicted: bool
+    in_tx: bool
+    abort: bool
+    cycles: int
+    type: int
+
+class branch_stack:
+    """Sequence of branch entries in the branch stack."""
+    def __len__(self) -> int: ...
+    def __getitem__(self, index: int) -> branch_entry: ...
+
+class callchain_node:
+    """Represents a frame in the callchain."""
+    ip: int
+    symbol: Optional[str]
+    dso: Optional[str]
+
+class callchain:
+    """Sequence of callchain frames."""
+    def __len__(self) -> int: ...
+    def __getitem__(self, index: int) -> callchain_node: ...
+
+class stat_event(_sample_members):
+    """Represents a stat event from perf."""
+    type: int
+    id: int
+    cpu: int
+    thread: int
+    val: int
+    ena: int
+    run: int
+    evsel: Optional['evsel']
+
+class stat_round_event(_sample_members):
+    """Represents a stat round event from perf."""
+    type: int
+    time: int
+    stat_round_type: int
+    evsel: Optional['evsel']
+
+class cpu_map:
+    """Map of CPUs being monitored."""
+    def __init__(self, cpustr: Optional[str] =3D None) -> None: ...
+    def __len__(self) -> int: ...
+    def __getitem__(self, index: int) -> int: ...
+    def __iter__(self) -> Iterator[int]: ...
+
+
+class evlist:
+    def __init__(self, cpus: cpu_map, threads: thread_map) -> None: ...
+    def open(self) -> None:
+        """Open the events in the list."""
+        ...
+    def close(self) -> None:
+        """Close the events in the list."""
+        ...
+    def mmap(self) -> None:
+        """Memory map the event buffers."""
+        ...
+    def poll(self, timeout: int) -> int:
+        """Poll for events.
+
+        Args:
+            timeout: Timeout in milliseconds.
+
+        Returns:
+            Number of events ready.
+        """
+        ...
+    def read_on_cpu(self, cpu: int) -> Optional[Any]:
+        """Read a sample event from a specific CPU.
+
+        Args:
+            cpu: The CPU number.
+
+        Returns:
+            A sample_event or other event type if available, or None.
+        """
+        ...
+    def all_cpus(self) -> cpu_map:
+        """Get a cpu_map of all CPUs in the system."""
+        ...
+    def metrics(self) -> List[str]:
+        """Get a list of metric names within the evlist."""
+        ...
+    def compute_metric(self, metric: str, cpu: int, thread: int) -> float:
+        """Compute metric for given name, cpu and thread.
+
+        Args:
+            metric: The metric name.
+            cpu: The CPU number.
+            thread: The thread ID.
+
+        Returns:
+            The computed metric value.
+        """
+        ...
+    def config(self) -> None:
+        """Configure the events in the list."""
+        ...
+    def disable(self) -> None:
+        """Disable all events in the list."""
+        ...
+    def enable(self) -> None:
+        """Enable all events in the list."""
+        ...
+    def get_pollfd(self) -> List[int]:
+        """Get a list of file descriptors for polling."""
+        ...
+    def add(self, evsel: evsel) -> int:
+        """Add an event to the list."""
+        ...
+    def __iter__(self) -> Iterator[evsel]:
+        """Iterate over the events (evsel) in the list."""
+        ...
+
+
+class session:
+    def __init__(
+        self,
+        data: data,
+        sample: Optional[Callable[[sample_event], None]] =3D None,
+        stat: Optional[Callable[[Any, Optional[str]], None]] =3D None
+    ) -> None:
+        """Initialize a perf session.
+
+        Args:
+            data: The perf data file to read.
+            sample: Callback for sample events.
+            stat: Callback for stat events.
+        """
+        ...
+    def process_events(self) -> None:
+        """Process all events in the session."""
+        ...
+    def find_thread(self, pid: int) -> thread:
+        """Returns the thread associated with a pid."""
+        ...
+
+# Event Types
+TYPE_HARDWARE: int
+"""Hardware event."""
+
+TYPE_SOFTWARE: int
+"""Software event."""
+
+TYPE_TRACEPOINT: int
+"""Tracepoint event."""
+
+TYPE_HW_CACHE: int
+"""Hardware cache event."""
+
+TYPE_RAW: int
+"""Raw hardware event."""
+
+TYPE_BREAKPOINT: int
+"""Breakpoint event."""
+
+
+# Hardware Counters
+COUNT_HW_CPU_CYCLES: int
+"""Total cycles. Be wary of what happens during CPU frequency scaling."""
+
+COUNT_HW_INSTRUCTIONS: int
+"""Retired instructions. Be careful, these can be affected by various issu=
es,
+most notably hardware interrupt counts."""
+
+COUNT_HW_CACHE_REFERENCES: int
+"""Cache accesses. Usually this indicates Last Level Cache accesses but th=
is
+may vary depending on your CPU."""
+
+COUNT_HW_CACHE_MISSES: int
+"""Cache misses. Usually this indicates Last Level Cache misses."""
+
+COUNT_HW_BRANCH_INSTRUCTIONS: int
+"""Retired branch instructions."""
+
+COUNT_HW_BRANCH_MISSES: int
+"""Mispredicted branch instructions."""
+
+COUNT_HW_BUS_CYCLES: int
+"""Bus cycles, which can be different from total cycles."""
+
+COUNT_HW_STALLED_CYCLES_FRONTEND: int
+"""Stalled cycles during issue [This event is an alias of idle-cycles-fron=
tend]."""
+
+COUNT_HW_STALLED_CYCLES_BACKEND: int
+"""Stalled cycles during retirement [This event is an alias of idle-cycles=
-backend]."""
+
+COUNT_HW_REF_CPU_CYCLES: int
+"""Total cycles; not affected by CPU frequency scaling."""
+
+
+# Cache Counters
+COUNT_HW_CACHE_L1D: int
+"""Level 1 data cache."""
+
+COUNT_HW_CACHE_L1I: int
+"""Level 1 instruction cache."""
+
+COUNT_HW_CACHE_LL: int
+"""Last Level Cache."""
+
+COUNT_HW_CACHE_DTLB: int
+"""Data TLB."""
+
+COUNT_HW_CACHE_ITLB: int
+"""Instruction TLB."""
+
+COUNT_HW_CACHE_BPU: int
+"""Branch Processing Unit."""
+
+COUNT_HW_CACHE_OP_READ: int
+"""Read accesses."""
+
+COUNT_HW_CACHE_OP_WRITE: int
+"""Write accesses."""
+
+COUNT_HW_CACHE_OP_PREFETCH: int
+"""Prefetch accesses."""
+
+COUNT_HW_CACHE_RESULT_ACCESS: int
+"""Accesses."""
+
+COUNT_HW_CACHE_RESULT_MISS: int
+"""Misses."""
+
+
+# Software Counters
+COUNT_SW_CPU_CLOCK: int
+"""CPU clock event."""
+
+COUNT_SW_TASK_CLOCK: int
+"""Task clock event."""
+
+COUNT_SW_PAGE_FAULTS: int
+"""Page faults."""
+
+COUNT_SW_CONTEXT_SWITCHES: int
+"""Context switches."""
+
+COUNT_SW_CPU_MIGRATIONS: int
+"""CPU migrations."""
+
+COUNT_SW_PAGE_FAULTS_MIN: int
+"""Minor page faults."""
+
+COUNT_SW_PAGE_FAULTS_MAJ: int
+"""Major page faults."""
+
+COUNT_SW_ALIGNMENT_FAULTS: int
+"""Alignment faults."""
+
+COUNT_SW_EMULATION_FAULTS: int
+"""Emulation faults."""
+
+COUNT_SW_DUMMY: int
+"""Dummy event."""
+
+
+# Sample Fields
+SAMPLE_IP: int
+"""Instruction pointer."""
+
+SAMPLE_TID: int
+"""Process and thread ID."""
+
+SAMPLE_TIME: int
+"""Timestamp."""
+
+SAMPLE_ADDR: int
+"""Sampled address."""
+
+SAMPLE_READ: int
+"""Read barcode."""
+
+SAMPLE_CALLCHAIN: int
+"""Call chain."""
+
+SAMPLE_ID: int
+"""Unique ID."""
+
+SAMPLE_CPU: int
+"""CPU number."""
+
+SAMPLE_PERIOD: int
+"""Sample period."""
+
+SAMPLE_STREAM_ID: int
+"""Stream ID."""
+
+SAMPLE_RAW: int
+"""Raw sample."""
+
+
+# Format Fields
+FORMAT_TOTAL_TIME_ENABLED: int
+"""Total time enabled."""
+
+FORMAT_TOTAL_TIME_RUNNING: int
+"""Total time running."""
+
+FORMAT_ID: int
+"""Event ID."""
+
+FORMAT_GROUP: int
+"""Event group."""
+
+
+# Record Types
+RECORD_MMAP: int
+"""MMAP record. Contains header, pid, tid, addr, len, pgoff, filename, and=
 sample_id."""
+
+RECORD_LOST: int
+"""Lost events record. Contains header, id, lost count, and sample_id."""
+
+RECORD_COMM: int
+"""COMM record. Contains header, pid, tid, comm, and sample_id."""
+
+RECORD_EXIT: int
+"""EXIT record. Contains header, pid, ppid, tid, ptid, time, and sample_id=
."""
+
+RECORD_THROTTLE: int
+"""THROTTLE record. Contains header, time, id, stream_id, and sample_id.""=
"
+
+RECORD_UNTHROTTLE: int
+"""UNTHROTTLE record. Contains header, time, id, stream_id, and sample_id.=
"""
+
+RECORD_FORK: int
+"""FORK record. Contains header, pid, ppid, tid, ptid, time, and sample_id=
."""
+
+RECORD_READ: int
+"""READ record. Contains header, and read values."""
+
+RECORD_SAMPLE: int
+"""SAMPLE record. Contains header, and sample data requested by sample_typ=
e."""
+
+RECORD_MMAP2: int
+"""MMAP2 record. Contains header, pid, tid, addr, len, pgoff, maj, min, in=
o,
+ino_generation, prot, flags, filename, and sample_id."""
+
+RECORD_AUX: int
+"""AUX record. Contains header, aux_offset, aux_size, flags, and sample_id=
."""
+
+RECORD_ITRACE_START: int
+"""ITRACE_START record. Contains header, pid, tid, and sample_id."""
+
+RECORD_LOST_SAMPLES: int
+"""LOST_SAMPLES record. Contains header, lost count, and sample_id."""
+
+RECORD_SWITCH: int
+"""SWITCH record. Contains header, and sample_id."""
+
+RECORD_SWITCH_CPU_WIDE: int
+"""SWITCH_CPU_WIDE record. Contains header, and sample_id."""
+
+RECORD_STAT: int
+"""STAT record."""
+
+RECORD_STAT_ROUND: int
+"""STAT_ROUND record."""
+
+RECORD_MISC_SWITCH_OUT: int
+"""MISC_SWITCH_OUT record."""
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a6593c388a48..4ec5a91d45c0 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -431,6 +431,7 @@ static const char pyrf_lost_event__doc[] =3D PyDoc_STR(=
"perf lost event object.");
=20
 static PyMemberDef pyrf_lost_event__members[] =3D {
 	sample_members
+	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_record_lost, id, T_ULONGLONG, "event id"),
 	member_def(perf_record_lost, lost, T_ULONGLONG, "number of lost events"),
 	{ .name =3D NULL, },
@@ -539,6 +540,7 @@ static const char pyrf_read_event__doc[] =3D PyDoc_STR(=
"perf read event object.");
=20
 static PyMemberDef pyrf_read_event__members[] =3D {
 	sample_members
+	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_record_read, pid, T_UINT, "event pid"),
 	member_def(perf_record_read, tid, T_UINT, "event tid"),
 	{ .name =3D NULL, },
@@ -3224,6 +3226,7 @@ static const struct perf_constant perf__constants[] =
=3D {
 	PERF_CONST(TYPE_BREAKPOINT),
=20
 	PERF_CONST(COUNT_HW_CPU_CYCLES),
+	PERF_CONST(COUNT_HW_REF_CPU_CYCLES),
 	PERF_CONST(COUNT_HW_INSTRUCTIONS),
 	PERF_CONST(COUNT_HW_CACHE_REFERENCES),
 	PERF_CONST(COUNT_HW_CACHE_MISSES),
@@ -4102,10 +4105,19 @@ PyMODINIT_FUNC PyInit_perf(void)
 	page_size =3D sysconf(_SC_PAGE_SIZE);
=20
 	Py_INCREF(&pyrf_evlist__type);
-	PyModule_AddObject(module, "evlist", (PyObject*)&pyrf_evlist__type);
+	PyModule_AddObject(module, "evlist", (PyObject *)&pyrf_evlist__type);
=20
 	Py_INCREF(&pyrf_evsel__type);
-	PyModule_AddObject(module, "evsel", (PyObject*)&pyrf_evsel__type);
+	PyModule_AddObject(module, "evsel", (PyObject *)&pyrf_evsel__type);
+
+	Py_INCREF(&pyrf_thread__type);
+	PyModule_AddObject(module, "thread", (PyObject *)&pyrf_thread__type);
+
+	Py_INCREF(&pyrf_callchain__type);
+	PyModule_AddObject(module, "callchain", (PyObject *)&pyrf_callchain__type=
);
+
+	Py_INCREF(&pyrf_callchain_node__type);
+	PyModule_AddObject(module, "callchain_node", (PyObject *)&pyrf_callchain_=
node__type);
=20
 	Py_INCREF(&pyrf_mmap_event__type);
 	PyModule_AddObject(module, "mmap_event", (PyObject *)&pyrf_mmap_event__ty=
pe);
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index a0ce76624a23..cb14554454a2 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -2,6 +2,7 @@ from os import getenv, path
 from subprocess import Popen, PIPE
 from re import sub
 import shlex
+import shutil
=20
 cc =3D getenv("CC")
 assert cc, "Environment variable CC not set"
@@ -73,6 +74,10 @@ class install_lib(_install_lib):
         _install_lib.finalize_options(self)
         self.build_dir =3D build_lib
=20
+    def run(self):
+        _install_lib.run(self)
+        shutil.copy2(f'{src_perf}/python/perf.pyi', self.install_dir)
+
=20
 # switch off several checks (need to be at the end of cflags list)
 extra_cflags =3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unus=
ed-parameter', '-Wno-redundant-decls' ]
--=20
2.54.0.1136.gdb2ca164c4-goog

