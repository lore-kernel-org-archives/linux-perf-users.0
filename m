Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AC192B9F;
	Fri,  9 Aug 2024 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210608; cv=none; b=Lbc6WquMkYx9iSAt5fkmJRzEyu/Eh6KuYnH3+bs5LRTDxlGSgy+vEYOsBcrFVpU12VAUf+UJ8Kd19m8gOeiZge64hE+EH1JJ9obzlQskHSPkLx3/hFo3hSopK3ZkNGskzAYirXwFJZJCDA31eGgRskT59oQcPmYlKW2ZmDvK158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210608; c=relaxed/simple;
	bh=qbki987gaYsmofTdGaOrSNO/2m7rpUZOrujXQCXht1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R56B5Sqj5UTTRJW9T55IpGJaZ//voXLd6dT0KzlR1+BVZDXSpr6qmg4ct9ECnEvkQ4PVGYhPEhY7wf7owyzifY8GuoU+c60b2uS827Sh7AJ8QAl3MtWY7nZ+KKxRbXXat4znlk3y4drDmJ7AUoL4JDuk3MSd1nwryQPyZl1uYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0P2qDVO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0P2qDVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996E0C32782;
	Fri,  9 Aug 2024 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723210608;
	bh=qbki987gaYsmofTdGaOrSNO/2m7rpUZOrujXQCXht1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0P2qDVONXxvOeB7wDiYJ+x5raP/IoD8prvxqS5xCi1b77IL5lpzGbtSVQMntbMgw
	 g0L9IyHWLojoOpssXX/AG0jmlZKOq46rDBgZYFCoq11v43yVN5dkTra3+Kq5ZeM1Hn
	 MOo6/gGFxEC/CVqFLcXBOeLJE7LhqC3zXqpsvg0Ua+tk4T17JWq/MVsyMUqD9FS4Q4
	 7FY+56yJyMqHf18y6Pj6UdnejnVLkw03Rdt+K7FKWRshPbxY1MTUqjq7G5XZTa2s3t
	 GCHUQdKbABG52APNgm4S9trksTnKxYkxQ1bcJgOh94PtTT7mYSsxhniFiLLvy53/dz
	 tVznqBS7/pnBQ==
Date: Fri, 9 Aug 2024 10:36:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Zixian Cai <fzczx123@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ben Gainey <ben.gainey@arm.com>, Paran Lee <p4ranlee@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf script python: Add the ins_lat field to event
 handler
Message-ID: <ZrYbbZVE4BQ-oqba@x1>
References: <20240809080137.3590148-1-fzczx123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809080137.3590148-1-fzczx123@gmail.com>

On Fri, Aug 09, 2024 at 08:01:36AM +0000, Zixian Cai wrote:
> For example, when using the Alder Lake PMU memory load event, the
> instruction latency is stored in ins_lat, while the cache latency
> is stored in weight.
> 
> This patch reports the ins_lat field for Python scripting.

So, how did you test this? I tried:

Committer testing:

On a Rocket Lake Refresh Intel machine (14th gen):

  root@number:~# grep -m1 'model name' /proc/cpuinfo
  model name    : Intel(R) Core(TM) i7-14700K
  root@number:~# perf mem record -a sleep 5
  Memory events are enabled on a subset of CPUs: 16-27
  [ perf record: Woken up 85 times to write data ]
  [ perf record: Captured and wrote 41.236 MB perf.data (191390 samples) ]
  root@number:~# perf evlist -v
  cpu_atom/mem-loads,ldlat=30/P: type: 10 (cpu_atom), size: 136, config: 0x5d0 (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
  cpu_atom/mem-stores/P: type: 10 (cpu_atom), size: 136, config: 0x6d0 (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1
  dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|CPU|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
  root@number:~#

Now generate a python script to then dump the dictionary that now needs
to have that 'ins_lat' field:

  root@number:~# perf script --gen python
  generated Python script: perf-script.py
  root@number:~# vim perf-script.py
  root@number:~# perf script -s perf-script.py | head -40
  in trace_begin
  in trace_end
  root@number:~# vim perf-script.py

But now the perf-script.py doesn't have a handler for the events and I
got just:

  root@number:~# perf script -s perf-script.py 
  in trace_begin
  in trace_end
  root@number:~# perf evlist 
  cpu_atom/mem-loads,ldlat=30/P
  cpu_atom/mem-stores/P
  dummy:u
  root@number:~# perf report -D | grep PERF_RECORD_SAMPLE | wc -l
  5857
  root@number:~#

So now I'm investigating if this is some 'perf script' script generation
oddity by trying to run this on an AMD machine, non-hybrid...

But in general try to provide the steps to show that the functionality
that you are adding is actually working, making it easy for other
people to try reproducing your results.

Thanks,

- Arnaldo
 
> Signed-off-by: Zixian Cai <fzczx123@gmail.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> v4) reformat commit message for max line length
> v3) address review comments
> v2) rebase on top of perf-tools-next
> 
>  tools/perf/util/scripting-engines/trace-event-python.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index fb00f3ad6815..6971dd6c231f 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -888,6 +888,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  	set_sample_read_in_dict(dict_sample, sample, evsel);
>  	pydict_set_item_string_decref(dict_sample, "weight",
>  			PyLong_FromUnsignedLongLong(sample->weight));
> +	pydict_set_item_string_decref(dict_sample, "ins_lat",
> +			PyLong_FromUnsignedLong(sample->ins_lat));
>  	pydict_set_item_string_decref(dict_sample, "transaction",
>  			PyLong_FromUnsignedLongLong(sample->transaction));
>  	set_sample_datasrc_in_dict(dict_sample, sample);
> @@ -1317,7 +1319,7 @@ static void python_export_sample_table(struct db_export *dbe,
>  	struct tables *tables = container_of(dbe, struct tables, dbe);
>  	PyObject *t;
> 
> -	t = tuple_new(27);
> +	t = tuple_new(28);
> 
>  	tuple_set_d64(t, 0, es->db_id);
>  	tuple_set_d64(t, 1, es->evsel->db_id);
> @@ -1346,6 +1348,7 @@ static void python_export_sample_table(struct db_export *dbe,
>  	tuple_set_s32(t, 24, es->sample->flags);
>  	tuple_set_d64(t, 25, es->sample->id);
>  	tuple_set_d64(t, 26, es->sample->stream_id);
> +	tuple_set_u32(t, 27, es->sample->ins_lat);
> 
>  	call_object(tables->sample_handler, t, "sample_table");
> 
> --
> 2.25.1
