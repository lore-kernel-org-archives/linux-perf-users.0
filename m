Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6099433BD5;
	Thu, 16 Jul 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220991; cv=none; b=Ek94X92r7xLMn4RuStPjJFbB3VFeHQowiMW8quAXWKtfxwP8SrUOC/rsoYuqGwof2ofqUld54MFvVsDT55IwIFa33NaxD9DW25ITYQQA+lP0DcwV3GmsBZNARjtnvVvZ1jT1vf2d4asM9q83Q7vzNxx5CVeFln//ojYIEu9Kb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220991; c=relaxed/simple;
	bh=WfGs0j7xC7R10n6sJSU52vTR2nLsHwX/tFgM8QPphGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnR80lqD7NOkHwR22x7QuGSsPD9FC+VC9+dAnfrICmsSiE74jyS89yfZnChYN7fAvf6/30/4fZ8XiIyrzu1ndS/lj3GNo4pjICGfJ+lrtPGGWPbM9I2foaNzW9IioPRZ215nxnoL80hdugXp7IwN6RNIvdpswYcUSFKVmmZujS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQQLjJrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQQLjJrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582261F000E9;
	Thu, 16 Jul 2026 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220987;
	bh=hZAoQWGvzJ1DzB/QjRLCBaTNYKaAFYtq7TUWscEDxhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MQQLjJrw9TJaaeBCe2nfTXwAcm71FhnHsluHNBzsnnMMtSQVl+nnWjTw/q8Z1x6c7
	 SiJ5xqQpI8/ZRgqU8jSf0WZuhcvkufjR45a0U5Xsn2LhcVgDbAkFeHlW70hV2s2Y9T
	 +Z+Xwh2vMZl3ddvu2lNZhdctTb6U6vgiVaEDWsIZmFin1ujmlMYCyvw/SWjaqnQAOc
	 ss1Fp/OFqzZuQaCM96mvCkGLHA6u4CBYbLmgjLDccQon8zsp/3tchwf2rV7z1ZEc1/
	 Sxfo7C4WNthyHx2i4ONoCeCd8Kgb1OBip/xz2+8sj+cFMZjT6yL327ZUaYs+JkZ99n
	 Tmq/YVWve9RYA==
Date: Thu, 16 Jul 2026 09:56:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sandipan Das <sandipan.das@amd.com>,
	Chun-Tse Shao <ctshao@google.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Subject: Re: [PATCH v1 2/3] perf jevents: Add python type annotations
Message-ID: <alkNOWGqi5aD8HlE@google.com>
References: <20260707034019.241762-1-irogers@google.com>
 <20260707034019.241762-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707034019.241762-3-irogers@google.com>

On Mon, Jul 06, 2026 at 08:40:18PM -0700, Ian Rogers wrote:
> Make mypy clean.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 77 +++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 3c6cfeefbd5d..83a239dd69f5 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -14,27 +14,27 @@ import collections
>  # Global command line arguments.
>  _args = None
>  # List of regular event tables.
> -_event_tables = []
> +_event_tables: list[str] = []

I got this from one of my test setup.

    GEN     /build/pmu-events/test-empty-pmu-events.c                             
  Traceback (most recent call last):                                              
    File "pmu-events/jevents.py", line 17, in <module>                            
      _event_tables: list[str] = []                                               
  TypeError: 'type' object is not subscriptable                                   
  make[3]: *** [pmu-events/Build:176: /build/pmu-events/test-empty-pmu-events.c] Error 1
  make[2]: *** [Makefile.perf:550: /build/pmu-events/pmu-events-in.o] Error 2     
  make[2]: *** Waiting for unfinished jobs....                                    
  make[1]: *** [Makefile.perf:288: sub-make] Error 2                              
  make: *** [Makefile:76: all] Error 2

Python version was 3.6.15.

I'll process patch 1 for now.

Thanks,
Namhyung


>  # List of event tables generated from "/sys" directories.
> -_sys_event_tables = []
> +_sys_event_tables: list[str] = []
>  # List of regular metric tables.
> -_metric_tables = []
> +_metric_tables: list[str] = []
>  # List of metric tables generated from "/sys" directories.
> -_sys_metric_tables = []
> +_sys_metric_tables: list[str] = []
>  # Mapping between sys event table names and sys metric table names.
>  _sys_event_table_to_metric_table_mapping = {}
>  # Map from an event name to an architecture standard
>  # JsonEvent. Architecture standard events are in json files in the top
>  # f'{_args.starting_dir}/{_args.arch}' directory.
> -_arch_std_events = {}
> +_arch_std_events: Dict[str, "JsonEvent"] = {}
>  # Events to write out when the table is closed
> -_pending_events = []
> +_pending_events: list["JsonEvent"] = []
>  # Name of events table to be written out
> -_pending_events_tblname = None
> +_pending_events_tblname: Optional[str] = None
>  # Metrics to write out when the table is closed
> -_pending_metrics = []
> +_pending_metrics: list["JsonEvent"] = []
>  # Name of metrics table to be written out
> -_pending_metrics_tblname = None
> +_pending_metrics_tblname: Optional[str] = None
>  # Global BigCString shared by all structures.
>  _bcs = None
>  # Map from the name of a metric group to a description of the group.
> @@ -210,7 +210,7 @@ class JsonEvent:
>        """Convert an int to a string similar to a printf modifier of %#llx."""
>        return str(x) if x >= 0 and x < 10 else hex(x)
>  
> -    def fixdesc(s: str) -> str:
> +    def fixdesc(s: Optional[str]) -> Optional[str]:
>        """Fix formatting issue for the desc string."""
>        if s is None:
>          return None
> @@ -218,7 +218,7 @@ class JsonEvent:
>                                         '. '), '.').replace('\n', '\\n').replace(
>                                             '\"', '\\"').replace('\r', '\\r')
>  
> -    def convert_aggr_mode(aggr_mode: str) -> Optional[str]:
> +    def convert_aggr_mode(aggr_mode: Optional[str]) -> Optional[str]:
>        """Returns the aggr_mode_class enum value associated with the JSON string."""
>        if not aggr_mode:
>          return None
> @@ -228,7 +228,7 @@ class JsonEvent:
>        }
>        return aggr_mode_to_enum[aggr_mode]
>  
> -    def convert_metric_constraint(metric_constraint: str) -> Optional[str]:
> +    def convert_metric_constraint(metric_constraint: Optional[str]) -> Optional[str]:
>        """Returns the metric_event_groups enum value associated with the JSON string."""
>        if not metric_constraint:
>          return None
> @@ -241,7 +241,7 @@ class JsonEvent:
>        }
>        return metric_constraint_to_enum[metric_constraint]
>  
> -    def lookup_msr(num: str) -> Optional[str]:
> +    def lookup_msr(num: Optional[str]) -> Optional[str]:
>        """Converts the msr number, or first in a list to the appropriate event field."""
>        if not num:
>          return None
> @@ -253,7 +253,7 @@ class JsonEvent:
>        }
>        return msrmap[int(num.split(',', 1)[0], 0)]
>  
> -    def real_event(name: str, event: str) -> Optional[str]:
> +    def real_event(name: Optional[str], event: Optional[str]) -> Optional[str]:
>        """Convert well known event names to an event string otherwise use the event argument."""
>        fixed = {
>            'inst_retired.any': 'event=0xc0,period=2000003',
> @@ -269,7 +269,7 @@ class JsonEvent:
>          return fixed[name.lower()]
>        return event
>  
> -    def unit_to_pmu(unit: str) -> Optional[str]:
> +    def unit_to_pmu(unit: Optional[str]) -> Optional[str]:
>        """Convert a JSON Unit to Linux PMU name."""
>        if not unit:
>          return 'default_core'
> @@ -304,21 +304,21 @@ class JsonEvent:
>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>  
>      def is_zero(val: str) -> bool:
> -        try:
> -            if val.startswith('0x'):
> -                return int(val, 16) == 0
> -            else:
> -                return int(val) == 0
> -        except e:
> -            return False
> +      try:
> +        if val.startswith('0x'):
> +          return int(val, 16) == 0
> +        else:
> +          return int(val) == 0
> +      except:
> +        return False
>  
>      def canonicalize_value(val: str) -> str:
> -        try:
> -            if val.startswith('0x'):
> -                return llx(int(val, 16))
> -            return str(int(val))
> -        except e:
> -            return val
> +      try:
> +        if val.startswith('0x'):
> +          return llx(int(val, 16))
> +        return str(int(val))
> +      except:
> +        return val
>  
>      eventcode = 0
>      if 'EventCode' in jd:
> @@ -370,7 +370,8 @@ class JsonEvent:
>      if precise and self.desc and '(Precise Event)' not in self.desc:
>        extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
>                                                                   'event)')
> -    event = None
> +    self.event: Optional[str] = None
> +    event: Optional[str] = None
>      if configcode is not None:
>        event = f'config={llx(configcode)}'
>      elif eventidcode is not None:
> @@ -455,6 +456,7 @@ class JsonEvent:
>          return f'\t/* {s} */\n' if len(s) < 80 else f'\t/* {s[0:80]}... */\n'
>  
>      s = self.build_c_string(metric)
> +    assert _bcs is not None
>      return f'{make_comment(s)}\t{{ { _bcs.offsets[s] } }},\n'
>  
>  
> @@ -524,6 +526,7 @@ def print_pending_events() -> None:
>      return
>  
>    global _pending_events_tblname
> +  assert _pending_events_tblname is not None
>    if _pending_events_tblname.endswith('_sys'):
>      global _sys_event_tables
>      _sys_event_tables.append(_pending_events_tblname)
> @@ -534,7 +537,8 @@ def print_pending_events() -> None:
>    first = True
>    last_pmu = None
>    last_name = None
> -  pmus = set()
> +  pmus: Set[Tuple[str, str]] = set()
> +  assert _args is not None
>    for event in sorted(_pending_events, key=event_cmp_key):
>      if last_pmu and last_pmu == event.pmu:
>        assert event.name != last_name, f"Duplicate event: {last_pmu}/{last_name}/ in {_pending_events_tblname}"
> @@ -576,6 +580,7 @@ def print_pending_metrics() -> None:
>          return ''
>        return s
>  
> +    assert j.metric_expr is not None
>      return (fix_none(j.pmu), fix_none(j.metric_name), j.metric_expr.ToPerfJson(),
>              fix_none(j.desc))
>  
> @@ -584,6 +589,7 @@ def print_pending_metrics() -> None:
>      return
>  
>    global _pending_metrics_tblname
> +  assert _pending_metrics_tblname is not None
>    if _pending_metrics_tblname.endswith('_sys'):
>      global _sys_metric_tables
>      _sys_metric_tables.append(_pending_metrics_tblname)
> @@ -593,7 +599,8 @@ def print_pending_metrics() -> None:
>  
>    first = True
>    last_pmu = None
> -  pmus = set()
> +  pmus: Set[Tuple[str, str]] = set()
> +  assert _args is not None
>    for metric in sorted(_pending_metrics, key=metric_cmp_key):
>      if metric.pmu != last_pmu:
>        if not first:
> @@ -629,7 +636,6 @@ def get_topic(topic: str) -> str:
>    return removesuffix(topic, '.json').replace('-', ' ')
>  
>  def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
> -
>    if item.is_dir():
>      return
>  
> @@ -643,6 +649,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>    if not item.is_file() or not item.name.endswith('.json'):
>      return
>  
> +  assert _bcs is not None
>    if item.name.endswith('metricgroups.json'):
>      metricgroup_descriptions = json.load(open(item.path))
>      for mgroup in metricgroup_descriptions:
> @@ -704,6 +711,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>  
>  def print_mapping_table(archs: Sequence[str]) -> None:
>    """Read the mapfile and generate the struct from cpuid string to event table."""
> +  assert _args is not None
>    _args.output_file.write("""
>  /* Struct used to make the PMU event table implementation opaque to callers. */
>  struct pmu_events_table {
> @@ -821,6 +829,7 @@ static const struct pmu_events_map pmu_events_map[] = {
>  
>  
>  def print_metric_table_functions() -> None:
> +  assert _args is not None
>    _args.output_file.write("""
>  const char *pmu_metrics_table__name(const struct pmu_metrics_table *table)
>  {
> @@ -864,6 +873,7 @@ int pmu_metrics_table__iterate_tables(pmu_metrics_table_iter_t fn, void *data)
>  
>  
>  def print_system_mapping_table() -> None:
> +  assert _args is not None
>    """C struct mapping table array for tables from /sys directories."""
>    _args.output_file.write("""
>  struct pmu_sys_events {
> @@ -1400,6 +1410,7 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
>  """)
>  
>  def print_metricgroups() -> None:
> +  assert _args is not None
>    _args.output_file.write("""
>  static const int metricgroups[][2] = {
>  """)
> @@ -1443,6 +1454,7 @@ def main() -> None:
>    def ftw(path: str, parents: Sequence[str],
>            action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
>      """Replicate the directory/file walking behavior of C's file tree walk."""
> +    assert _args is not None
>      for item in sorted(os.scandir(path), key=lambda e: e.name):
>        if _args.model != 'all' and item.is_dir():
>          # Check if the model matches one in _args.model.
> @@ -1513,6 +1525,7 @@ struct pmu_table_entry {
>      preprocess_arch_std_files(arch_path)
>      ftw(arch_path, [], preprocess_one_file)
>  
> +  assert _bcs is not None
>    _bcs.compute()
>    _args.output_file.write('/* clang-format off */\n')
>    if not _args.output_string_file:
> -- 
> 2.55.0.795.g602f6c329a-goog
> 
