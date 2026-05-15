Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B676376BEC;
	Fri, 15 May 2026 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874107; cv=none; b=M60CFGkcl2y1g8Xt9JCt+3ZZ5dPm6ovyGg0LWCuStwuLdSg44XxbCg2WFA8gWS+fCi4ZnMRw4fptYu5KNeUyPqufDN70gq/yBbhnWunw1SylmDsO5/9LiI5ellU1ti6M6gMGmxo/0yrJYA7wqd7rW0EIFHqbrLO9ArS0Nnv4+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874107; c=relaxed/simple;
	bh=1yXhHqfMG9ohZvPpaTmXOpNtz2MyNmvkQA5IXlkA9fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em2WnvVSBwGgzmYVKOvwILfugBNNqM5ra5fiBx17KjQr9RSsVlskk8TxGugUKWdOw4q1eYaWtuH7BFRlaaBiqy84ndHym+VQe0AlelcvdFOoojKuNei8EHSm+l4pyOzTTMF3t7Xbi1OnWLXld8gwfKAESY3zZcE1FYGBpDLq8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oByE9J/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oByE9J/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54CCC2BCB0;
	Fri, 15 May 2026 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874106;
	bh=1yXhHqfMG9ohZvPpaTmXOpNtz2MyNmvkQA5IXlkA9fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oByE9J/L5tCLwamlatLjUIYlyuszL75CP+AGdM0d50Q05TDHdxuVRYqYoVuwC2e24
	 Gas3bFp051gEhMsymJg/pQYUtqA8SWMgfyU3htTr+ONr4hEvSZTDe8wtIB2Tf83AkV
	 wX6xK462qPgkQBWKxuRibN4up+A00SfcoPrbZ9JSwwbLXIgAqmwItNjMX6PJ7B5KWs
	 8or80lh96NI0gS3VnQv3EjSrBknbc4ma5sPxRa20J30F4ea4QAhyyoLzNisLxa+aGy
	 7m0RCWFHLcZUZfzYnZfJKNtU5oQhMd6mnLBeFi9T4Cgkgd5gdFK/1NggS6Wkukon7y
	 +NdZZpkvPlcbw==
Date: Fri, 15 May 2026 12:41:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com,
	adrian.hunter@intel.com, alex@ghiti.fr,
	alexandre.chartre@oracle.com, andrii@kernel.org,
	ankur.a.arora@oracle.com, aou@eecs.berkeley.edu,
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com,
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com,
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org,
	leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev,
	memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com,
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org,
	pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me,
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com,
	tglozar@redhat.com, thomas.falcon@intel.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v4 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
Message-ID: <agd2-MgXgs---InR@google.com>
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
 <20260515173852.1378571-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515173852.1378571-12-irogers@google.com>

On Fri, May 15, 2026 at 10:38:48AM -0700, Ian Rogers wrote:
> Currently, jevents.py parses hundreds of JSON event and metric files
> sequentially across all CPU architectures during Kbuild startup, taking
> ~3.3 seconds of pure single-core execution time.

I'm curious about this.  Does it really need to parse all architectures?
Oh... is it for perf stat record/report?

Thanks,
Namhyung

> 
> Refactor jevents.py to pre-populate its internal JSON AST cache in parallel
> across all available CPU cores using ProcessPoolExecutor. Define the worker
> process initializer _init_worker at the top-level module scope to guarantee
> flawless pickling and standard event mapping inheritance under spawn
> multiprocessing semantics (avoiding AttributeError crashes when spawn is
> used instead of fork). This accelerates jevents.py execution by over 11x
> (from 3.3s down to ~290ms), fully reclaiming multi-core concurrency during
> the build generation phase.
> 
> Tested-by: James Clark <james.clark@linaro.org>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 36 ++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 6adf4b30e1ba..ebacb056524f 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -457,8 +457,8 @@ class JsonEvent:
>      return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
>  
>  
> -@lru_cache(maxsize=None)
> -def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
> +_json_cache = {}
> +def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
>    """Read json events from the specified file."""
>    try:
>      events = json.load(open(path), object_hook=JsonEvent)
> @@ -474,12 +474,16 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
>    if updates:
>      for event in events:
>        if event.metric_name in updates:
> -        # print(f'Updated {event.metric_name} from\n"{event.metric_expr}"\n'
> -        #       f'to\n"{updates[event.metric_name]}"')
>          event.metric_expr = updates[event.metric_name]
>  
>    return events
>  
> +def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
> +  key = (path, topic)
> +  if key not in _json_cache:
> +    _json_cache[key] = _read_json_events_impl(path, topic)
> +  return _json_cache[key]
> +
>  def preprocess_arch_std_files(archpath: str) -> None:
>    """Read in all architecture standard events."""
>    global _arch_std_events
> @@ -1381,6 +1385,14 @@ const char *describe_metricgroup(const char *group)
>  }
>  """)
>  
> +def _parallel_read_json_events(task: Tuple[str, str]) -> Tuple[str, str, Sequence[JsonEvent]]:
> +  path, topic = task
> +  return path, topic, _read_json_events_impl(path, topic)
> +
> +def _init_worker(std_events: dict) -> None:
> +  global _arch_std_events
> +  _arch_std_events = std_events
> +
>  def main() -> None:
>    global _args
>  
> @@ -1459,9 +1471,25 @@ struct pmu_table_entry {
>      raise IOError(f'Missing architecture directory \'{_args.arch}\'')
>  
>    archs.sort()
> +  import concurrent.futures
> +  tasks = []
> +  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
> +    if len(parents) == 0:
> +      return
> +    if item.is_file() and item.name.endswith('.json') and not item.name.endswith('metricgroups.json'):
> +      tasks.append((item.path, get_topic(item.name)))
> +
>    for arch in archs:
>      arch_path = f'{_args.starting_dir}/{arch}'
>      preprocess_arch_std_files(arch_path)
> +    ftw(arch_path, [], collect_json)
> +
> +  with concurrent.futures.ProcessPoolExecutor(initializer=_init_worker, initargs=(_arch_std_events,)) as executor:
> +    for path, topic, events in executor.map(_parallel_read_json_events, tasks):
> +      _json_cache[(path, topic)] = events
> +
> +  for arch in archs:
> +    arch_path = f'{_args.starting_dir}/{arch}'
>      ftw(arch_path, [], preprocess_one_file)
>  
>    _bcs.compute()
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
