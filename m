Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125D33F8CA
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745523; cv=pass; b=KoK8TIUF4Azfo+bgFdxpZ/0eX37GKrJ0AbUZeFeXgi9WWjTnKqecxKMCsc1crFThQaRmXSiBpQvTxcXvhDJupwWxLgfFJl85xXVhDe6jh6r2xvEvhT47aHOdmFPsYeTojBOLPpUHuygD22VkhHsxWfFqGlhDvn/YJUTK45ipWxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745523; c=relaxed/simple;
	bh=hp8K6SrwBdoU+e2wO7+eb7bUKjXFK4WIfUnNEL71uAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mw4EECgBxSVgZWIYPT7oGCTbAak9Rilz5Pex2Dh0al/qvM+bf/ISiuBasdi/gh4zX/GklE80XIRGVWTY5lDX9ZTPuDvLUh+30ONm3bCudV6RrRw77jowIuLCgssOxW15zu0046FG8Y4RgiG63CL20omuDOFsxTgf1CM+s2331X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KG4xJnAG; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KG4xJnAG"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-530e8c6fb80so288151cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 08:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789745519; cv=none;
        d=google.com; s=arc-20260327;
        b=YVkprzDvF5hv+V75Sauk7P3IgmC1zO5I0edoSFxYpHLETwqYv2ka25pg0Zi/Frwq+k
         Z9av8+W+SsBcUh/EmyGcBnaEs9nZCttlAodm4Fv6Wmel2wUMApOSZ3/1Hc6MI+Y8pyK6
         xoh8UjpJ/udFoSwdtceDBAacpWHZofaQyGZzNe1KhO/0XUTzUUtUeyGcNvnBQpIJjr5D
         4SgkSE3UGDPjozJJjTgzdFFtj8vMbnPrPMMK5MZu3I49gd05QBkrSSBGrVUWfJsYZ+QJ
         z1i5WWRRYGeV/D781DKQCyawHPPDMQ6OJQj/g4bu7D2hZQY7b6fGocKsX5qAKdshy4ZV
         HsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dewjtoIEBFOvSiAWpjFtBX+g4LwL5kovJX9ITwRujXM=;
        fh=eZEB7U1jwgFfwwVghrlYw68cSeQvfRDvsyDwGH5uuYw=;
        b=qdzcEEyMhUQ6LQxcNkhZUijqrFxghR0QXTo2v8i9DYxkRG5qHHrtjN592NS3tzxGd6
         HG/NKB8dxjAAaWfJ/+U8rLpV7DBto67+RNDiDxMRCjIRxhMxNOkCtWGTWN3Lz2R3VIsZ
         m9HDD56Jxfr522k3Kv5xZysVzxO95weGRYRf3mLFr9vnW6phzas+3e/llpr8IpqrZVS9
         yHWPXMnKk76FYghY+vM6pTzVxi8dwWCgeNDiWIaZoCCK5HAk89iMNEuB6wim4YkuwrFE
         sCh7Uk4O4BdW49bPK56eyFLS0S42EGATLmMzN4MXYIo920o1Hp6TzF3upark4V/bjcAV
         4COQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789745519; x=1790350319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dewjtoIEBFOvSiAWpjFtBX+g4LwL5kovJX9ITwRujXM=;
        b=KG4xJnAGJMrJ8gW8EI4ZeGU3FMSdZx4mMIr3Z7sCD46Fa8bELio3zMBYh++n1k0HPR
         k+YZ4s9okUNM5A9uMpzAU6dVpFs+u4deImFUAUGkL8c8RkH3ppkqFWvwC7A04CDVA9xC
         1lenyarPGhMCQScjWbqk7MR1FdmRX6OMTESFCsEZgSRafhOAShPAtPwfNWNNCCc4Z8Y+
         V6+uwShcLEUf3WCsfQDmlt8Y2gK6OzWd5ZwzMJi3HjSL5w11bDj50a876pYTskGjZp7m
         uNg/stAJA1vUR51e2D2q+Pktv20OY3eJy9dIvzr88RHz5mhCOIb8nJjz7AZHrb7Jr3Nv
         ddNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745519; x=1790350319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dewjtoIEBFOvSiAWpjFtBX+g4LwL5kovJX9ITwRujXM=;
        b=tHFeLiH3egcf6jBbhyN7qYSIJr83KOzyDqSpNNru91DjlkognHayWeeTPetvb9fZBx
         Breb3Af7MxxmxMkdN1RNyKHmNGMyoh8IFIV7JsuBlS0iqVQ/xB/uzGFHYwKvQMfIvReK
         SMYczpSOAk9s2bCgOmrUqoO5G/2MDKsgSbz/iT3nFUcaPkWgjK6yHWAd+N2ymOa9+4yr
         DEmLv+nGTwmrHihanmkzPPHKJdDJDrIFe4nx5QQC1JZqLP+8FjJpcujn5T/gYtAtNZgC
         jrHDU2gpO+wz+sW4rb8LkbNwGHxviHHRgVHO4BGiuZa/r/gA0lNUvejVwF75vjOqlITc
         hvvA==
X-Gm-Message-State: AFuF++k7f3zLgS47oYINm+ge9P+CuVLzemE38G/DhcHVAXKiDjAZMQwz
	rpDvZTuBxjdFJvNF0OarznIC2Ycfpd9X2iAJo0EYaFol3zsDdvUmz2YzRJBx/Cb8warmMIbPf6k
	wiShz+OHO3b9EazJWzs0rOBs/LUrsE8AuyL2r5n/kBOIiGi53re61SgWF
X-Gm-Gg: AYBFou1kQeklgNycyRaC6BH2v9d8SnRXr+gitCh6o0Qj3eB5BMG1PdTt55Ib7LQe/Mh
	ZX5XnCPFUnJ0DT2FPfWp5nEBgql6rrUOhGo/i8RQftfYVKatagfGT4B6zLywarIHLOI6m97TDix
	ej9yNEdGbk/qIU0hpOpx+GwHSq5gSWmdDY5BwlAe9HsKEBqbulrn34p99fmpiUBHEqmMHKd/p3v
	tFjmMzDZelfNRqxaFMeA2XGakqlPJXntJyaEytkxuBuam1SSDwxsZOWFYbo8P6wQqN89oMAwKvF
	cjBSc5ZjhNBDbr6B2EGRxe1yAbVlDepBeg1mcgFgbZ5cGa0rL37psx3/oVFEFkLr
X-Received: by 2002:a05:622a:14d0:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-5329d2e1093mr18247261cf.0.1789745518385; Fri, 18 Sep 2026
 08:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917095921.2802275-1-sandipan.das@amd.com>
In-Reply-To: <20260917095921.2802275-1-sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Sep 2026 08:31:46 -0700
X-Gm-Features: AcwNN1Vf72XtsGyuzBFuyeEaR4yzTJKkeyCI8WH25n0dlkARhAdbTcppBKif0qY
Message-ID: <CAP-5=fXcDT7Vi32odox1_gSbiGakN8KQMjXCZjmh=SyxuaVDZw@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Limit the number of JSON reading workers
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 3:00=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> The ProcessPoolExecutor is created without max_workers, so
> concurrent.futures defaults to one worker per CPU and forks all of them
> when the first task is submitted. Each worker costs the parent a few
> file descriptors. For systems with high core-count processors like the
> AMD EPYC 9996, the pool can easily exhaust RLIMIT_NOFILE as seen below.
>
>   File ".../multiprocessing/popen_fork.py", line 65, in _launch
>     child_r, parent_w =3D os.pipe()
>   OSError: [Errno 24] Too many open files
>
> The error is reported, but jevents.py does not exit. The workers that
> did start stay blocked waiting for work and are never joined, so the
> build eventually hangs. Other targets keep building in the meantime,
> leaving the traceback several lines above the point where the build
> stalls.
>
> Limit the pool instead of sizing it against the descriptor limit, which
> would mean relying on how many descriptors concurrent.futures needs for
> each worker. At least for recent AMD EPYC processors, reading the JSON
> files does not need many workers to be fast and things typically stop
> scaling beyond 32 workers. Hence, a small upper bound keeps the speedup
> and stays well inside any usable limit.
>
> Fixes: eaab2eb09dc2 ("perf pmu-events: Parallelize JSON and metric pre-co=
mputation in jevents.py")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 860027bb71b2..d81fe6757915 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -1450,6 +1450,13 @@ const char *describe_metricgroup(const char *group=
)
>  }
>  """)
>
> +# Upper bound on the number of workers reading JSON files in parallel.
> +_max_parallel_workers =3D 32
> +
> +def _parallel_worker_count(num_tasks: int) -> int:
> +  return max(1, min(getattr(os, 'process_cpu_count', os.cpu_count)() or =
1,
> +                    _max_parallel_workers, num_tasks))
> +
>  def _parallel_read_json_events(task: Tuple[str, str]) -> Tuple[str, str,=
 Sequence[JsonEvent]]:
>    path, topic =3D task
>    return path, topic, _read_json_events_impl(path, topic)
> @@ -1549,7 +1556,9 @@ struct pmu_table_entry {
>      preprocess_arch_std_files(arch_path)
>      ftw(arch_path, [], collect_json)
>
> -  with concurrent.futures.ProcessPoolExecutor(initializer=3D_init_worker=
, initargs=3D(_arch_std_events,)) as executor:
> +  with concurrent.futures.ProcessPoolExecutor(max_workers=3D_parallel_wo=
rker_count(len(tasks)),
> +                                              initializer=3D_init_worker=
,
> +                                              initargs=3D(_arch_std_even=
ts,)) as executor:
>      for path, topic, events in executor.map(_parallel_read_json_events, =
tasks):
>        _json_cache[(path, topic)] =3D events
>
> --
> 2.53.0
>
