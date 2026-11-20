Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169220;
	b=Y/cJHogDaKddmN5hQ55/a77elPAbbM8gL3Eeg2ZayQ8Wsu0+ZMofxQkhqB7DNxuycjwt
	 tud4dpyTRa8JXZwxsfZvmJ6HmgevWrlxR9WKhtxtcQxAriJk/SrJCXk4ZHD8Je96pyGg4
	 SOzLEQBopHTJJEyYWy4Llmj5smRXYwM6H7hjf+gRYwih8YkJiInjo5P7qIaYH47QAJ1zq
	 sNe3EVKEBGGE7khyj/PXSLMkkvfc6j08OW8/oLxle/JxLiTU5J0H9sb6t+cyk87wdPvhh
	 2AtxtFEap5sKXJhy97MuAw44bP8KsBWoFgxyshdfQroqOZaqQiH0Cku6IwnU89FOZfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+90+pqil6CBAVbA79RRMMCs5y0fU+WuyAvov2TcftGQ=;
	b=OujPnBsD1wL3exf02Vbo+EHkICIik1jkcE00dN8mx+axy1Ct6HmcWDyHrRr0RoKVQKTk
	 BOnVMM84CgGCxAq0DAvXGNPtMNjcC89YrmE0gVKsUBYV0ioWpW6e+bC5ysnuygKurmN1z
	 rt3MOGj6LAVw9DlIV/ZChvE7wo4WjtI1UcinSPM8OMvEEcr9ULc9Wdo/I+2sNtbg+/ixc
	 wPMK2pXSk6Hd0GZ+aekpsl1WyX/wmWV5rGGESe0j9iQdV+cGVlScZti+wVoLUjL1ygyhN
	 ud/iZmqx2pFoVJtbMx+a7mMMc41I0QJV8POaAQ3jaSj/Rb6rPPHwkgB0/ja9nbrl1EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sazvftPD;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C5B606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 10:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C5B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sazvftPD
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso342738f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 02:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795169218; x=1795774018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+90+pqil6CBAVbA79RRMMCs5y0fU+WuyAvov2TcftGQ=;
        b=sazvftPDNBlMwUtfO1fhjPDBQ8zpPXewmHHeJrpQeFRQQfwpEWHRiNb0HRC1G8aCGB
         UgGPkTCl9z0xIMZ6wEjQHlO4uloI1uiNdGhO2LDDQThE75hYs1O3ekXwZfQfZEB+KCQh
         Ni/DlVy5JA4i/f+PhhBGfFI4AVuaolp6/AqAJCwl1NlhMQ/CIXLyh6VFd7RfPhzD0yzq
         4ktOTmXs7K/wmm83j+VhgZAkl4ToKO40ENRlBhziAiITc6ht1M/9e5Zqm6Dz/F+I2oi+
         9lkF4uRFdaK4vPX6iv+uVlV995+Lutv0S3hZ5HqYkDTKudEVx50jkTVNsCMAkndFU6xd
         G3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795169218; x=1795774018;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+90+pqil6CBAVbA79RRMMCs5y0fU+WuyAvov2TcftGQ=;
        b=kIGtMLjCpmkG6lDYhcu4zq7ZBeqatN8KOujYPipTWhUqDCk7auukyMh2IUO4xpxUR8
         XFk8TH7caNKUcxkYuasj0QaoV1BORoBMwaEiVdC0rZ6lnUla2pHHW5TkLDvotb4cV+0e
         UdRwdD8apzei/VAP+edx7hEeGKBhUxVJR8gU9HQZRtrdDyoBDUxQHkpP0sHz/YtQMRjM
         NwGF50K23dE/XwvLpmTa2v/pgxJg//N9F2Qt13/yOWTdeZA0AXokDOKWsNryAulh0TDm
         TpR3FKVSEN/dZGrmd7CRYIoeR2ikDvpMAlePor90LmIwAJ9/3t80e1/zylboMLqtPYET
         ZjzA==
X-Forwarded-Encrypted: i=1; AL+hErHZGsoznsYK4A6XKL9SYOkE23imwxVWyB/vyGgpXT4DAVDdEb1M2dkvokFP2UZvZg/SdnrDOwwo8Q5Jhwpb6gy5@vger.kernel.org
X-Gm-Message-State: APuU4Z/aVxOjEWuB1PzOXW+IUBEBPkXO4HUT1h9dEaLg6rxDKxxtmVLq
	GRw9Mk752NLQXYKwYbS79kxo/gOQok7pEW63TfEX7ok414NxXZrpp+Hnx6yooagmTYY=
X-Gm-Gg: AYBFou1wbiWjIrmu9vs0p2/AhwRBirCqzIRQ9Uutst8DKPvnievidD7TBNytBcLo4JN
	d9HP9ccUUQUuaw8yWPXvllCXdVE9KTxUrH2Ld7FeTbufnO/j+tsh5q8zyQcbfX7iALwh/6ev/XQ
	d9+l/Aomz0zeZvy7ouKkJz9kgavU4cpHACYVOTMV4plIbwPy3JbYDQqVxUU4aUfde9VHPyrDmNn
	WTKggQ+Tk+IsxvPq/Dxu7wdxwsY7qg/cEmEqMnthkgeZCRkLBJEQReu1YL+9/IFINENHNxL5eMN
	ZXIkLZRdH58OgRHGjvoa3TBPGO1DC8yOYNGow8F5CwiErlD309lA87GoRURcA8gyI0sYh535i0J
	KxoJXKUVguwTmiaf2fQN168Iy43qIOgX7d2n7Je32SA2u7k4hN6wAvzeo7F1l2G2i7535B9pU4s
	EBQhnF4kWvbU5PFGNDnwB2fhSW98LGCkpZhkGbAirWWn37yKXdzemBau1F3Dt1SBTXzruoFKa77
	sWx+ZvLB+GX4+eWrm9Qvvfh7JK3KmjaSsrASAbBE90l3X1Ho5C2qennXqfPoX2kaoF1Crr+I0Vl
	Bl8ENLjvmWxql0QSPeZRL4BgYRYGjmrHRg==
X-Received: by 2002:a05:600c:c4a2:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4bb88807d87mr58234305e9.7.1795169217686;
        Fri, 20 Nov 2026 02:06:57 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm20236705e9.4.2026.11.20.02.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 02:06:57 -0800 (PST)
Message-ID: <4c59af55-230f-4fd5-980e-91b953a1709a@linaro.org>
Date: Fri, 20 Nov 2026 10:06:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] perf jevents: Fail the build on a key the tables
 may not carry
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>,
 linux-arm-kernel@lists.infradead.org,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Leo Yan <leo.yan@linux.dev>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20261113032927.634183-1-takano32@gmail.com>
 <20261120060931.711483-1-takano32@gmail.com>
 <20261120060931.711483-3-takano32@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261120060931.711483-3-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/11/2026 06:09, TAKANO Mitsuhiro wrote:
> jevents.py takes the fields it wants out of each JSON object by name and
> ignores the rest, so a key that is spelled differently is dropped without
> a word and the object is built without whatever that field held.
> 
> Compare the keys of each object with _valid_keys, the keys a table may
> carry, and fail on anything else.  The error is one line naming the file
> and the key:
> 
>    jevents.py: <path>: unknown key(s): ['BriefDescript6ion']
> 
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran the generator on every arch directory, with and without a key the
> tables may not carry.
> 
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>   tools/perf/pmu-events/jevents.py          | 70 ++++++++++++++++++-----
>   tools/perf/tests/shell/jevents_bad_key.sh | 43 ++++++++++++++
>   2 files changed, 98 insertions(+), 15 deletions(-)
>   create mode 100755 tools/perf/tests/shell/jevents_bad_key.sh
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 080e04b51b8c..65e51dafd42b 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -63,6 +63,27 @@ _json_metric_attributes = [
>   # Attributes that are bools or enum int values, encoded as '0', '1',...
>   _json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg',
>                            'default_show_events']
> +# Keys a table under arch/ may carry.  jevents.py takes the fields it wants by
> +# name and drops the rest without a word, so a key that is spelled differently
> +# is only visible as a field that went missing; a table carrying anything else
> +# is an error.  The list holds the keys jevents.py reads, plus the ones the
> +# tables carry and it does not read: Counter, CountersNumFixed and
> +# CountersNumGeneric (read by nothing) and Experimental (read by metric.py).
> +_valid_keys: Set[str] = {
> +    'AggregationMode', 'AnyThread', 'ArchStdEvent', 'BriefDescription',
> +    'Compat', 'ConfigCode', 'Counter', 'CounterMask',
> +    'CountersNumFixed', 'CountersNumGeneric', 'Data_LA', 'DefaultMetricgroupName',
> +    'DefaultShowEvents', 'Deprecated', 'EdgeDetect', 'EnAllCores',
> +    'EnAllSlices', 'Errata', 'EventCode', 'EventidCode',
> +    'EventName', 'Experimental', 'ExtSel', 'FCMask',
> +    'Filter', 'Invert', 'LegacyCacheCode', 'LegacyConfigCode',
> +    'MetricConstraint', 'MetricExpr', 'MetricGroup', 'MetricgroupNoGroup',
> +    'MetricName', 'MetricThreshold', 'MSRIndex', 'MSRValue',
> +    'NodeType', 'PEBS', 'PerPkg', 'PortMask',
> +    'PublicDescription', 'RdWrMask', 'RetirementLatencyMax', 'RetirementLatencyMean',
> +    'RetirementLatencyMin', 'SampleAfterValue', 'ScaleUnit', 'SliceId',
> +    'ThreadMask', 'UMask', 'Unit',
> +}
>   
>   def file_name_to_table_name(prefix: str, parents: Sequence[str],
>                               dirname: str) -> str:
> @@ -196,6 +217,9 @@ class JsonEvent:
>     def __init__(self, jd: dict):
>       """Constructor passed the dictionary of parsed json values."""
>   
> +    if extra := set(jd) - _valid_keys:
> +      raise ValueError(f'unknown key(s): {sorted(extra)}')
> +

All you need is this raise, you don't need any of the other try catch 
changes. It already prints the filename, a little bit of stack and then 
the missing key as the last line:

   Exception processing pmu-events/arch/x86/amdzen1/core.json

   ...

   ValueError: Unknown keys ['EvendtName'] ...

It's perfectly legible as an error as it is and not worth the churn and 
extra noise in the code.

>       def llx(x: int) -> str:
>         """Convert an int to a string similar to a printf modifier of %#llx."""
>         return str(x) if x >= 0 and x < 10 else hex(x)
> @@ -459,6 +483,8 @@ def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
>     try:
>       with open(path, encoding='utf-8') as f:
>         events = json.load(f, object_hook=JsonEvent)
> +  except ValueError as exc:
> +    raise ValueError(f'{path}: {exc}') from exc
>     except BaseException:
>       print(f"Exception processing {path}")
>       raise
> @@ -492,6 +518,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
>             _arch_std_events[event.name.lower()] = event
>           if event.metric_name:
>             _arch_std_events[event.metric_name.lower()] = event
> +    except ValueError:
> +        raise
>       except Exception as e:
>           raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\'') from e
>   
> @@ -643,7 +671,10 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>     assert _bcs is not None
>     if item.name.endswith('metricgroups.json'):
>       with open(item.path, encoding='utf-8') as f:
> -      metricgroup_descriptions = json.load(f)
> +      try:
> +        metricgroup_descriptions = json.load(f)
> +      except ValueError as exc:
> +        raise ValueError(f'{item.path}: {exc}') from exc
>       for mgroup in metricgroup_descriptions:
>         assert len(mgroup) > 1, parents
>         description = f"{metricgroup_descriptions[mgroup]}\\000"
> @@ -1473,6 +1504,8 @@ def main() -> None:
>               continue
>         try:
>           action(parents, item)
> +      except ValueError:
> +        raise
>         except Exception as e:
>           raise RuntimeError(f'Action failure for \'{item.name}\' in {parents}') from e
>         if item.is_dir():
> @@ -1536,20 +1569,27 @@ struct pmu_table_entry {
>       if item.is_file() and item.name.endswith('.json') and not item.name.endswith('metricgroups.json'):
>         tasks.append((item.path, get_topic(item.name)))
>   
> -  for arch in archs:
> -    arch_path = f'{_args.starting_dir}/{arch}'
> -    preprocess_arch_std_files(arch_path)
> -    ftw(arch_path, [], collect_json)
> -
> -  with concurrent.futures.ProcessPoolExecutor(max_workers=_parallel_worker_count(len(tasks)),
> -                                              initializer=_init_worker,
> -                                              initargs=(_arch_std_events,)) as executor:
> -    for path, topic, events in executor.map(_parallel_read_json_events, tasks):
> -      _json_cache[(path, topic)] = events
> -
> -  for arch in archs:
> -    arch_path = f'{_args.starting_dir}/{arch}'
> -    ftw(arch_path, [], preprocess_one_file)
> +  try:
> +    for arch in archs:
> +      arch_path = f'{_args.starting_dir}/{arch}'
> +      preprocess_arch_std_files(arch_path)
> +      ftw(arch_path, [], collect_json)
> +
> +    with concurrent.futures.ProcessPoolExecutor(max_workers=_parallel_worker_count(len(tasks)),
> +                                                initializer=_init_worker,
> +                                                initargs=(_arch_std_events,)) as executor:
> +      for path, topic, events in executor.map(_parallel_read_json_events, tasks):
> +        _json_cache[(path, topic)] = events
> +
> +    for arch in archs:
> +      arch_path = f'{_args.starting_dir}/{arch}'
> +      ftw(arch_path, [], preprocess_one_file)
> +  except ValueError as exc:
> +    # A worker's traceback is three levels of ProcessPoolExecutor noise around
> +    # the one line that matters, so say it here and stop.  make deletes the
> +    # target it failed to build (.DELETE_ON_ERROR), so the next run reads the
> +    # JSON again rather than a half-written table.
> +    sys.exit(f'jevents.py: {exc}')
>   
>     assert _bcs is not None
>     _bcs.compute()
> diff --git a/tools/perf/tests/shell/jevents_bad_key.sh b/tools/perf/tests/shell/jevents_bad_key.sh
> new file mode 100755
> index 000000000000..7848e60b8b4a
> --- /dev/null
> +++ b/tools/perf/tests/shell/jevents_bad_key.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Check jevents.py reports unknown keys as errors (no_mlock)
> +#
> +# A key that is spelled differently is dropped without a word, so jevents.py
> +# compares the keys of each object in a table against the keys it reads and
> +# fails on anything else.
> +
> +jevents=$(dirname "$0")/../../pmu-events/jevents.py
> +python=${PYTHON:-python3}
> +
> +# An installed perf has the test but not the generator, and a python that is
> +# not there or too old to run it is a skip, not a failure of the check.
> +[ -r "${jevents}" ] || exit 2
> +[ "$("${python}" -c 'import sys; print(sys.version_info >= (3, 9))' 2>/dev/null)" = True ] \
> +  || exit 2
> +
> +tmp=$(mktemp -d) || exit 2
> +trap 'rm -rf "${tmp}"' EXIT HUP INT TERM
> +tables="${tmp}/arch/x86/model"
> +mkdir -p "${tables}" "${tmp}/arch/common"
> +printf '[]\n' > "${tmp}/arch/common/empty.json"
> +printf 'Family-model,Version,Filename,EventType\nGenuineIntel-6-97,v1.0,model,core\n' \
> +  > "${tmp}/arch/x86/mapfile.csv"
> +printf '[{"EventName": "a", "NotAKey": "x"}]\n' > "${tables}/events.json"
> +
> +if "${python}" -B "${jevents}" x86 all "${tmp}/arch" \
> +    "${tmp}/pmu-events.c" "${tmp}/pmu-events-string.c" 2> "${tmp}/err"; then
> +  echo "jevents.py accepted a key it does not read" >&2
> +  exit 1
> +fi
> +grep -qF -- "NotAKey" "${tmp}/err" || {
> +  echo "jevents.py failed without naming the key" >&2
> +  cat "${tmp}/err" >&2
> +  exit 1
> +}
> +grep -qF -- "${tables}/events.json" "${tmp}/err" || {
> +  echo "jevents.py failed without naming the file" >&2
> +  cat "${tmp}/err" >&2
> +  exit 1
> +}
> +
> +exit 0

