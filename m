Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE24D90A2
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198366; cv=none; b=CwcMbeh8RZdOXeRk8iGnlaPu/xT8ddIU2UUu5cu7MlEiiRLBAEx0YgPqdqkLALEILUXjIe2MzVmhfhjWy1rPOSCPWwRRnp7jqYoI7Eo352bSNkRIDiorcfJHUAUIB8Kc329nFtQSU7PFjwovbT6EgiwrkBtQ1BzaYoTOJ4H0R9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198366; c=relaxed/simple;
	bh=wJdSw09ngN84pgWepRqlT4b54NGlI4xS3ga3tKKKCnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJjGLRyV65j3yP3rjTrmNnvqqO+kb51bjmrmL97xu0N4bK3Ll2EL6OW1WEM0ooqPwmcVpbiglGqWWDsAb9JOxd/n8MhlqocX31qIEnkppI0etK5CiiwxHfHbro+cssXKt6FqMwgYjCPKgKVZXVzUO8lWYMm12y6ezLWvNh1mBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c20YlM7O; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c20YlM7O"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fc90b1so117300eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198353; x=1781803153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=da8D26nvKDiun0kbGNajfFhwBh4lwET5WZxzRxGduwE=;
        b=c20YlM7O9zuIJDZ1RJQyyRt/U7uDDE9VM4Hxhzf25IqXqRo54YAS6ye7QlSZk+Mvwg
         2WQKByVNvqdxu4kRtnAeT3pJp7Vgjby7d4QwlGEtqgw5G+ZdFb9GnsuOAxYbqtUQPVfW
         R8yjYTsf1/HBFZr75rkErDW+hfaxKGRDU6jjppUo0JO2BZzN8YXrepMEm2d9Fl9Ocndw
         T7cEPmipTf6iZPgmlFUV6nhpctxlTe/fHTpUHL4kcA2cUKXcIBhjkZBVTxdFjr0YNIGH
         piNU8RsZmxWuLTXqmF0niuqHU/g3DpFTzoTtKKAGhjYStUU07r6WIVJr5SIGgqOzDpNG
         IJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198353; x=1781803153;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=da8D26nvKDiun0kbGNajfFhwBh4lwET5WZxzRxGduwE=;
        b=dxaG206WfdC1MIthVECdZW5/QhbqAQEL3y+h+WCcbUg3rfficYMiKe4jj7SbFddBv9
         D070umkGNK7IGPjX+/LQqev4CXGfZ9UgD2Q+zKg7yprrLOK+MqLeIdkE1bcUhTSPw5DR
         G3ZDsBlSpTOmHb1++DVik/4MRmw+kUZcy1oBH0U61B4YLmOO67VzHFwLOB+Yw4+kQUgx
         3iYiQZ0Dp27InGe7ypDYcPZEisi3axn2DWhbB3w5ATYTPvctxg5Prj5pYl8eN4NhU9Mp
         zZVUy2CVdVfA1co/MUgFBAn07p3WSqysmh687j2yFfBv0TMvyOZPUAuy28UtHRQFZjT2
         Fj6A==
X-Forwarded-Encrypted: i=1; AFNElJ+0CbDLMnHIFFLJ7Jer5jVkfZE5RYThLyWT+kA5ecFn3FLsluokZfPwI6pothZevrd4ibLAtBCE/gNqImCsYnHb@vger.kernel.org
X-Gm-Message-State: AOJu0YyusdtNFJutnWuZOGq+uP4FoVGARlbdKG/Tmt99LN6jXLN0ryzc
	cHhDgemwCTvuqvnymIDpZUzALLm4OZpRmuxQQNQaDOFKO481yBBamrwHgTiD7tTnSVZtXdB5WGh
	W+8DfbbBw5A==
X-Received: from dyad18.prod.google.com ([2002:a05:693c:8352:b0:304:59b1:e122])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:aca3:b0:2ea:4228:ab11
 with SMTP id 5a478bee46e88-308046226f1mr2506313eec.3.1781198352197; Thu, 11
 Jun 2026 10:19:12 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:17:55 -0700
In-Reply-To: <20260611171756.4008769-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605191500.2477026-1-irogers@google.com> <20260611171756.4008769-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611171756.4008769-19-irogers@google.com>
Subject: [PATCH v12 18/19] perf python: Add perf.pyi stubs file
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
 tools/perf/Makefile.perf   |   5 +-
 tools/perf/python/perf.pyi | 646 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/setup.py   |   5 +
 3 files changed, 655 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/python/perf.pyi

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 476b8dcaef58..6944c9a8e8ac 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -522,7 +522,10 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/p=
ython.c util/setup.py $(PE
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
index 000000000000..b8e3ced7d7f8
--- /dev/null
+++ b/tools/perf/python/perf.pyi
@@ -0,0 +1,646 @@
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
+def syscall_name(sc_id: int, *, elf_machine: Optional[int] =3D None) -> st=
r:
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
+    val: int
+    ena: int
+    run: int
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
+    brstack: Optional['branch_stack']
+    callchain: Optional['callchain']
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
+
+class comm_event(_sample_members):
+    """Represents a COMM record."""
+    type: int
+    pid: int
+    tid: int
+    comm: str
+
+class task_event(_sample_members):
+    """Represents an EXIT or FORK record."""
+    type: int
+    pid: int
+    ppid: int
+    tid: int
+    ptid: int
+    time: int
+
+class throttle_event(_sample_members):
+    """Represents a THROTTLE or UNTHROTTLE record."""
+    type: int
+    time: int
+    id: int
+    stream_id: int
+
+class read_event(_sample_members):
+    """Represents a READ record."""
+    type: int
+    pid: int
+    tid: int
+
+class switch_event(_sample_members):
+    """Represents a SWITCH or SWITCH_CPU_WIDE record."""
+    type: int
+    next_prev_pid: int
+    next_prev_tid: int
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
+    """Iterator over branch entries in the branch stack."""
+    def __iter__(self) -> Iterator[branch_entry]: ...
+    def __next__(self) -> branch_entry: ...
+
+class callchain_node:
+    """Represents a frame in the callchain."""
+    ip: int
+    sym: Optional[Any]
+    map: Optional[Any]
+
+class callchain:
+    """Iterator over callchain frames."""
+    def __iter__(self) -> Iterator[callchain_node]: ...
+    def __next__(self) -> callchain_node: ...
+
+class stat_event:
+    """Represents a stat event from perf."""
+    type: int
+    id: int
+    cpu: int
+    thread: int
+    val: int
+    ena: int
+    run: int
+
+class stat_round_event:
+    """Represents a stat round event from perf."""
+    type: int
+    time: int
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
+    def read_on_cpu(self, cpu: int) -> Optional[sample_event]:
+        """Read a sample event from a specific CPU.
+
+        Args:
+            cpu: The CPU number.
+
+        Returns:
+            A sample_event if available, or None.
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

