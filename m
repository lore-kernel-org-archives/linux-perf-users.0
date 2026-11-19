Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098012;
	b=XWNaqN4XOeiZ0TZsw85uT2agHPOQd6UDtfGlqmlGZfmNmJwR40yZbSNRNEsDo0tMk0bd
	 4/RWuKaYO7wWxM5Y36KVwbF0BAN/cRUfj9HilqpXIWn4ykZvmxaWDTIpX2W7g7ct3jGW8
	 F8ObRKFyQksaMP/0OuBaznM4vQRPxtq2sNZJSXICfncyId7wjR8DN0S3ix9vkYTxH2bKT
	 2OXXdtEGGNa3sHFe3+E84QQk9NH9tKSeT/2fwlNGLMpJYNpoPUPRNhKlfzY5RmOse+PN+
	 1MHX4Wyq2u136txYxW3aZvChSfoZezmeRaVsVU4kc2E9om/+bqdo+EiOjwHSPvIVnyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nd+IYjFxdGtZZ0LGHQbKoanR4t4Tdc4crRwdJeaQsbk=;
	b=TJOXsfLxJt/aI1c7lqBZfkkuuvSyCcGGBbv0rporLPQsqpc7axVWg815H8yEPX/sY0em
	 CN2sASb0CeBHoPEKm+P/GPzaJMhwmxFeQGJgH1bugy1Momgm1N1xOV4hBMXsVenVo0MY8
	 dQ/RR8ckG0Q5pQPM8voEmnKskVRP+jqnD9VV/zUvQe5m0RWdgaFQ0k30JrmXpO70pzxMk
	 0Ksm4Of2bBZRLnYCIPbMU3ct1AlhE5WzytxaoxP1Zjz7P5uq6c6/ryFE2ezWhl8cby3Tb
	 M7j/WyuvmKbpYTPD6oEhYiN+nmFKSEF1spRI2G2DaTBIgoDaN06Z1U03O257uCBWzKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ITZCqyUu;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42802606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 14:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42802606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ITZCqyUu
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49a92144733so1110487f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795098010; x=1795702810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nd+IYjFxdGtZZ0LGHQbKoanR4t4Tdc4crRwdJeaQsbk=;
        b=ITZCqyUulPmKUEx2ZQYCgCyqk95iFnyAEPl+QP0eDRYBUv+3CHVv26rRmHav30gW2l
         dyQxwUHcec9YH5bxZDwJDaDMkQp+o2uMP276XnWEHKUqY31sOWXNJFsXGpbj2qhDoo9Q
         V+JzpB+D/vEvTbxZXrwPnsUHNtXSk94+qzaU4ELK7ARqOGEQk0pe3p7zCo/oAUBgonV4
         mG3rLBEzUFwucke6XqK6t5sUx90FvfvG9WlB+5T/g/Gtcyy4RwJ+ztuuTXwzqetdobND
         601RM5QfJQvF9ziMlo/JBhx6TcL+w82JkZ8nbG/Xr8Gigm+YK/iZj4ZZqJIheG3d+s8G
         uf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098010; x=1795702810;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nd+IYjFxdGtZZ0LGHQbKoanR4t4Tdc4crRwdJeaQsbk=;
        b=t0BJasrXl8E6V5RFRZ2Hk3jQzDGFb8cnet5RRCm7cTFtAjp8UG92STVed2kbrQHqPP
         LcA9NVEOZaEStS1RFXnBEPFNduA/bI+2pqOcoeqk6BoEwosnRgGw0VOWfCzDe5Pko10T
         x574SDeis2AFtHJhL47+fHjqGKbwmksH430Rnpyb0hMnsAd5D0Z+P/tft2NOHnCNuatT
         5306sKuIF6GU8zfLQUc8IyRwHR5pTeYb0ECjuBs2s+IjoRKQ/KaCTLW8d7ITCeKOyvYf
         slcrDd3KvDBXNI8hfQo4NQO8H5Nmnjf43y2KiVhQnIiJ74K0q+0Lpn+yHc5zUSYcl7+U
         bL1A==
X-Forwarded-Encrypted: i=1; AL+hErF7j7Dk9SqdI+X7zgW6dwUjrX5jOr25ZMvfFRc5D1T+2Fu1kziXvSB0VsR/9h8dQfA7qmuWhi6AXtV3rUAAwGE8@vger.kernel.org
X-Gm-Message-State: APuU4Z91Bo26b7Z/z86iR1w9tyx/67EK7sSQRdZkuT4Fi9uE5eQaBbg2
	7jZ8WTFVXy6wFE1tIaXKDgoIRcrcfDVpprEHX2lzF4LaMzRsMzrzPcotr6qzjO/KnDg=
X-Gm-Gg: AZFdTZe5PPdIpJR+UAGKbxmqw3xhUebq6l4nEXix3/7kiunpLb6fhmQjnXp728d5YWM
	wCnbuD+X6K2AR7YgEn2Hir3zhDo38JwhNsJU+XQYxBuSyrP0GVc7mc69se3EcIGFSdci6Q5DpMB
	3+1BNH/NFQH9zHoJGh71OlVTg85IhegWOSQ6v5fRq6CVGuIE89ZNCmkKMLhoOM6n8TAXrXYC1FX
	epBCdNxk/unEWM8RYnViGJVQmq2YY0PMidOJrmacf2m3HwAYkQxSQf2LHHUtZ50idsr6ZTD1C4t
	L74JAIoff4ZsHfbQ5GRJ4wy42WTTCTd0R5TN3UE2N7B2Z05l7v12mqrYZbHEu5Z4TuW6xBZt4En
	j/Vvc3+QNUL2VjWCsN7KzXbq+BtEYDBcGGTwJ3OdNtKkJ2dapg3wCH4VclIfSdneGVLGkRoO60p
	DTE1NLFC5DpBa5kFCT5qsMhksJ8Vzrfy8MAl5cLuyMWqkewUov4DLTuSbhAkSTH6Oh728Hztr4v
	BSLEGFFU120HqoeSoyr0Sj4CYei/NOOoK81iB/KLVyJud3WxSEmGj9bUgOeiTZ94esFV0sveZLw
	dgB2HUJI6Fgfv4XoCA+1AT34b2gcQryUfA==
X-Received: by 2002:a5d:64c5:0:b0:4aa:842f:5f78 with SMTP id ffacd0b85a97d-4aa842f6223mr2905795f8f.46.1795098010233;
        Thu, 19 Nov 2026 06:20:10 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab56a96207sm54426f8f.59.2026.11.19.06.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 06:20:09 -0800 (PST)
Message-ID: <4dac94a8-8a87-4fd2-abd8-60ef2faafa20@linaro.org>
Date: Thu, 19 Nov 2026 14:20:08 +0000
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
Subject: Re: [PATCH v10 1/1] perf jevents: Check the keys of the JSON tables
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20261112222526.462146-1-takano32@gmail.com>
 <20261113032927.634183-1-takano32@gmail.com>
 <20261113032927.634183-2-takano32@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261113032927.634183-2-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/11/2026 03:29, TAKANO Mitsuhiro wrote:
> jevents.py takes the fields it wants out of each JSON object by name and
> ignores the rest, so a key that is spelled differently is dropped without
> a word and the object is built without whatever that field held.  Two of
> those are in the tree: "PublicDescrition" in 16 entries of an Arm table,
> and "BriefDescript6ion" in one entry each of three AMD tables.
> 

I think the commit message can just be "... validate that the jsons only 
contain known keys so that the build fails when there is a typo in a key 
..."

There's not much more to say than that.

> A table may carry 51 keys; 47 of them jevents.py reads, one more metric.py
> reads, and three are read by nothing although the tables hold them
> (Counter, CountersNumFixed, CountersNumGeneric).  A key outside that list
> is reported with the file that carries it.  There is no cut-off, no
> similarity and nothing that depends on what a run of the generator
> happened to read.
> 
> The check is not a JSON schema because perf's build would then require
> jsonschema, which it does not use today and which is not in every
> builder's python.  It runs as a perf test, not as part of the build.
> 
> --check reads its directory before the parser asks for the three

Can we drop the --check argument and do it unconditionally? See below.

> positional arguments, so it needs no dummy architecture and model, and it
> takes "--check=DIR" as well as "--check DIR".  A directory that is not
> there is reported instead of passed, since nothing found under it would
> otherwise read as a clean tree.
> 
> On the tree today it reports 19 keys in four tables.

There shouldn't be any errors when this patch is applied. If there are 
there needs to be a commit before adding the checker that fixes it.

> 
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
> v10: the two fixes v9 described were missing from the diff v9 carried;
>       they are in this one.  The check itself is unchanged.
> 
>   tools/perf/pmu-events/jevents.py        | 48 +++++++++++++++++++++++++
>   tools/perf/tests/shell/jevents_check.sh | 36 +++++++++++++++++++
>   2 files changed, 84 insertions(+)
>   create mode 100755 tools/perf/tests/shell/jevents_check.sh
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 080e04b51b8c..4bbaba7086c5 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -7,6 +7,7 @@ import json
>   import metric
>   import os
>   import sys
> +from pathlib import Path
>   from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
>   import collections
>   
> @@ -1450,9 +1451,56 @@ def _init_worker(std_events: dict) -> None:
>     global _arch_std_events
>     _arch_std_events = std_events
>   
> +# The keys a json object under arch/ may carry.  jevents.py takes the fields it
> +# wants by name and ignores the rest, so a key that is spelled differently is
> +# dropped without a word; this is the list a table is allowed to contain.
> +_TABLE_KEYS: Set[str] = {

Rename this to _valid_keys and move it to the top of the file where the 
other lists of attributes are.

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
> +
> +def _check_tables(root: str) -> int:
> +  """Report the keys in the tables under root that a table may not carry."""

All you need to check them is this in the JsonEvent constructor:

  class JsonEvent:
    def __init__(self, jd: dict):
      if extra := set(jd) - _valid_keys:
       raise ValueError(f'Unknown keys ...')

> +  if not os.path.isdir(root):
> +    print(f'{root}: not a directory', file=sys.stderr)
> +    return 2
> +  bad = 0
> +  for path in sorted(Path(root).rglob('*.json')):
> +    if path.name.endswith('metricgroups.json'):
> +      # A dictionary keyed by metric group name, not a list of events.
> +      continue
> +    for obj in json.loads(path.read_text(encoding='utf-8')):
> +      if extra := set(obj) - _TABLE_KEYS:
> +        print(f'{path}: {sorted(extra)}')
> +        bad += 1
> +  return 1 if bad else 0
> +
>   def main() -> None:
>     global _args
>   
> +  # --check takes the directory to check and needs nothing else, so it is read
> +  # before the parser below asks for the three positional arguments.  Both
> +  # "--check DIR" and "--check=DIR" are accepted.
> +  for i, arg in enumerate(sys.argv[1:]):
> +    if arg != '--check' and not arg.startswith('--check='):

Avoiding using argparse is pretty horrible, but that goes away if you 
remove the --check argument.

> +      continue
> +    if arg.startswith('--check='):
> +      root = arg.split('=', 1)[1]
> +    else:
> +      root = sys.argv[i + 2] if len(sys.argv) > i + 2 else ''
> +    sys.exit(_check_tables(root))
> +
>     def dir_path(path: str) -> str:
>       """Validate path is a directory for argparse."""
>       if os.path.isdir(path):
> diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/shell/jevents_check.sh
> new file mode 100755
> index 000000000000..b596f8bc509d
> --- /dev/null
> +++ b/tools/perf/tests/shell/jevents_check.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# jevents_check: an unknown key in a table is reported (no_mlock)

This has the potential to cause slight confusion about whether this is 
doing the validation for all json files or checking the checker itself. 
Some of that confusion goes away if you remove the --check argument, but 
the test should probably be called "jevents_bad_key.sh" and the 
description "Check jevents.py reports unknown keys as errors (no_mlock)".

> +#
> +# A key that is spelled differently is dropped without a word, so the keys of
> +# the tables are checked against the list jevents.py reads.
> +
> +jevents=$(dirname "$0")/../../pmu-events/jevents.py
> +python=${PYTHON:-python3}
> +
> +# An installed perf has the test but not the generator, and a python that
> +# cannot run the generator is not a failure of the check.
> +[ -r "${jevents}" ] || exit 2
> +command -v "${python}" > /dev/null || exit 2
> +
> +tmp=$(mktemp -d)
> +trap 'rm -rf "${tmp}"' EXIT
> +tables="${tmp}/arch/x86/model"
> +mkdir -p "${tables}"
> +
> +# Known keys pass.
> +printf '[{"EventName": "a", "EventCode": "0x1"}]\n' > "${tables}/events.json"
> +"${python}" "${jevents}" --check "${tmp}/arch" > /dev/null || exit 1
> +

No need for the happy path to be tested if we always check as part of 
the build.

> +# A key the generator does not read is reported.
> +printf '[{"EventName": "a", "NotAKey": "x"}]\n' > "${tables}/events.json"
> +"${python}" "${jevents}" --check "${tmp}/arch" > /dev/null && exit 1
> +

So this one makes sense.

> +# A directory that is not there is an error, not a clean tree.
> +"${python}" "${jevents}" --check "${tmp}/nodir" > /dev/null 2>&1 && exit 1
> +
> +# The key is an option, so "--check=DIR" works the same as "--check DIR".
> +printf '[{"EventName": "a", "EventCode": "0x1"}]\n' > "${tables}/events.json"
> +"${python}" "${jevents}" "--check=${tmp}/arch" > /dev/null || exit 1
> +

But these two can be dropped too.

> +exit 0

