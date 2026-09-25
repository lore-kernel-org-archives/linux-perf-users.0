Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA63563FB
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369842; cv=pass; b=LlpLMxN5J+FvHReINvtkoTygCSWRjfQF/ZLRySOZL/QwfUxfW1hGXQTL1xyErHQXyWJXV6slyN9KteaW4pZJaXwWK95rlHJMtLJAxFgSPY7LdckKRf8Kt7PqyBUcvcY34FypHEgO3zKT8+HuBrcPmDGHrHz1zsmGdSQ3FzPZnjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369842; c=relaxed/simple;
	bh=xWkSu0s4lTKuTMVP5dwVIkzdV3WUVEfVBdycszuaQ1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et29rEwsQU5J03NT25cdgvUG/zXcu7GDXed1t8y9HJ1LDEHfdXiF/JoN56KlWvRQkhHppyVYZgW91GZ9l38W0U60QXHqfcRp6KkEG6R7nf6MkuBHPiTnSHHMi6XiKeLhA1Yb+FZhayMm1fl+SPHpkvZjPOMKAtrTcm9bnIBC2vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMPiWw35; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMPiWw35"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53113d72966so36361cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 13:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790369840; cv=none;
        d=google.com; s=arc-20260327;
        b=euE5SXBORsb+NSlow2iD/O3AUab2IQOCULLXAwrOYjBaj4cDcLW1WrQpa6jT65vLen
         Iqxyi7OBRQaEgeggDydRPAQ3Jh9YpoXw1b3E4Xu4lM/3zHNsYAhckWZsvuAO8RIjCLqJ
         H5zuANtlE3h/l4gbZKW0CM5bkEo+2SJm5ZBbWNvLG7dMxp2Fumr73xp5K56KT2B4sCGw
         8g53b4DvsveVeLfNq3N+KB4PNctzHEMMpH3o3WL4qbfoYHGntzg3HQhbkyITt/iq/yfb
         9yIOoC1hym4by9dvT86PZ8QRLRbc22jGglD/qIE5xaMgjnKVTaL3LmMcCcfh5XkVrdwU
         nUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=toHJ3whlAU3XYjTFSLSvyRIHafluaezq0RKrVbeYGbE=;
        fh=/2u8Hl6GFTCWQYUmJBLwLTLD/ru+HX7kJ1pdXLrPGNQ=;
        b=a1ugqd1Cnj8alXSp1gi13Mt1/P4vLcG6BJ23WlmcjsgPnwkvlIqqARyUeWx5P2UgIh
         DFalxYKReYJ+kKT+0NdxfYtDaMbBcvpOJoFu2HBN0xVUYEqmrHJ2BLbC0NgUQ/5OPWzh
         Gn4zC/vKjemrFdE8uCyvR6KWw3PIsdgMZEfxwrByTuMRxygCVVa9rI0ld2P4fh9lhUmF
         oCUbyb3AxeaxzOKnXAJitXUL8lJAI1o9Ry5OJMn09dG7Pnqqe0Hh/nNLI3KQHzy3Zko8
         EZ7L7EIDUYRtWTxf+FkhGki4miQM0xaDrFnPdGothLXi2m/aQ9A+PA6oWR+E8Mhf0NH+
         tD8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790369840; x=1790974640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=toHJ3whlAU3XYjTFSLSvyRIHafluaezq0RKrVbeYGbE=;
        b=IMPiWw35a2/ux8U2wJSw+f5nQ2y0xiZpbnnJk6dbVyMCxLyo0XDptr2ZvLqd2joWJE
         3jn7kLgv9/1opCQaIVbS3WEO3yDFNc8m1NRIRvcOhUNXygViQaCMi2e39L8j/Pbdxt2D
         5oDLjPTY1ozZD1rEWsDSsI9CBXJ2fhwSqWsxxckIicLwdROOqQAugi/ArkqxWWcEn1Nb
         4TY0aK7a9A6uOnacrx4gvEmuRwRli6gc99d1BEj9PuVr9+KoZf7C2pOq2IPHsFibtqZH
         7Tgsw6pyX5UhxiCDQ6PXt5RamlNSlCziA+cT3DDN8CPNH22YiDTw8qGrx6x6BkZoHq5N
         u4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369840; x=1790974640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=toHJ3whlAU3XYjTFSLSvyRIHafluaezq0RKrVbeYGbE=;
        b=Sbw8L/M8okT6QCdqwcRsdtvNZBoNXaxBBBxuTs3VDEf5HQ7Fe2hfjrFYPqeISU8PAz
         4QZ6fBE6lfJubWuSNHK7efIrS/IPaR3nSb2kewCVm6zD1g1kMAzk3+ZviGNr1kJrwOsY
         4zaV+yWqMJzgtN6hucoDjlU0qX5wldJ21scWd4OgqC4/mxnwnWQjFMCvm/fz5Aacqybu
         5+DQ0wWol6Tx0LMjP5tzLgEYHIIqpxG568yX6JzkgO1ftuOUR/z7Q/aozjNbPU3PR1kE
         aDln31Ky2SBpQ5qupvLjzw06D4m2ltGe/KB8OSVrnhrhfF84OLCnGFwlVmSmi0esF2hg
         BPhA==
X-Forwarded-Encrypted: i=1; AKwUvBx31E0Hup3CeDUtEvxGyUJ6Cd5aqJOujGx3SWsqyWpZOi3FAe/0pxSaB5NYQiHt+beT27CWF8BBH6vwqRr1qcT+@vger.kernel.org
X-Gm-Message-State: AFuF++kbG4eU1HW22iqw5cAX4IxSBpef7JVepXCBrY/nrbjQBG/0F/1W
	bFRbO2nIr2nFwRX3spmkw3MLaS+01LMXLu1O/uNylUJ3UWSkLJbslT1hMYy1JI59/rSp5Q9qKTg
	E03b78rqnuOnR6bndHIOyn5RnB+YttIZlnTHwyVE6JtYOqTsEGs/9ypl8tW8=
X-Gm-Gg: AYBFou3JZGydF/SG4B4ynVMBsnt26w4VMr4hZIg9w41sl7DGjW7bos8HMl71WlPOdOV
	6Yt7NwyG6i/jrLVr2oXUTPKGlwJTB0TciM/cRYG5MuZpL6YR8Mp8/ePo//veRvLpn4tWNBbLBFu
	H5T4r2uKvrYHJXUiWrtOYcBch3REXnM0Lnp41xg3yTVvOvqutbg2MU/1zP+gauPLZqmU6373FfO
	fUX0wV1J1emw/XIKNhmQxxR82yx8JgjIP+EfG3vEc2FJYnHT0vZdewCvK330w6lEJufqBKiv3s5
	x1KcfiB0+Q+LeWW6P/nZcqYfvPSWSCPXn1dzExrNrsI8i+H8OlvocshzYbPC/VPSEWB83O0nSzx
	Lq8RsdJJUAQ==
X-Received: by 2002:a05:622a:22a8:b0:532:8a04:af52 with SMTP id
 d75a77b69052e-533226c36aamr1036761cf.9.1790369839326; Fri, 25 Sep 2026
 13:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arbd4TJm4s9MVjN-@x2>
In-Reply-To: <arbd4TJm4s9MVjN-@x2>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 13:57:06 -0700
X-Gm-Features: AclHuK_7rshC0M8489T3uIJa6GcahDAoghjNX7d4xqdgYDp8dDIjAm5TT0MHVmA
Message-ID: <CAP-5=fVXxUEYSfWb=AExGQoZ7w7FqGhD8Ga1+hjwF3gTZfsbpA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf: Fix Python 3.6 build breakage in jevents.py and util/setup.py
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:47=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> perf's build still accepts Python 3.6: Makefile.config only rejects
> interpreters older than 3.6 and jevents.py keeps its own removesuffix()
> shim for it, but two recently added constructs are evaluated when the
> module or the function is defined and only work on newer interpreters.

Could we remove the shim and bump the minimum Python version to 3.9 to
be in line with the rest of the kernel build?
https://github.com/torvalds/linux/blob/master/Documentation/process/changes=
.rst

Thanks,
Ian

> PEP 585's list[...] became subscriptable in Python 3.9, so the module
> level annotations in jevents.py make Kbuild die at import time:
>
>   TypeError: 'type' object is not subscriptable
>   make[3]: *** [pmu-events/Build:176: .../test-empty-pmu-events.c] Error =
1
>
> as seen on almalinux:8 with its python3.6.8, and the list[str]
> parameters of util/setup.py's functions fail the same way when the
> python binding is built.
>
> ProcessPoolExecutor(initializer=3D, initargs=3D) was added in Python 3.7,
> so generating pmu-events.c dies when the pool is created.
>
> Use the typing generics that exist on every supported interpreter and
> only pass initializer/initargs when the interpreter has them: on 3.6
> the default fork start method already leaves the worker processes with
> the parent's _arch_std_events, which is what _init_worker() sets up
> for spawn semantics.
>
> Tested with Python 3.6.15: make -C tools/perf completes, generating
> pmu-events.c and the python binding.
>
> Fixes: cda907c2c3f99 ("perf jevents: Add python type annotations")
> Fixes: 1fa8d81be1eb ("perf python: Clean up and restructure setup.py")
> Fixes: eaab2eb09dc2 ("perf pmu-events: Parallelize JSON and metric pre-co=
mputation in jevents.py")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/pmu-events/jevents.py | 24 +++++++++++++++---------
>  tools/perf/util/setup.py         |  5 +++--
>  2 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 074daae5308b110b..bdc89ec197680c1b 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -8,19 +8,19 @@ import json
>  import metric
>  import os
>  import sys
> -from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
> +from typing import (Any, Callable, Dict, List, Optional, Sequence, Set, =
Tuple)
>  import collections
>
>  # Global command line arguments.
>  _args =3D None
>  # List of regular event tables.
> -_event_tables: list[str] =3D []
> +_event_tables: List[str] =3D []
>  # List of event tables generated from "/sys" directories.
> -_sys_event_tables: list[str] =3D []
> +_sys_event_tables: List[str] =3D []
>  # List of regular metric tables.
> -_metric_tables: list[str] =3D []
> +_metric_tables: List[str] =3D []
>  # List of metric tables generated from "/sys" directories.
> -_sys_metric_tables: list[str] =3D []
> +_sys_metric_tables: List[str] =3D []
>  # Mapping between sys event table names and sys metric table names.
>  _sys_event_table_to_metric_table_mapping =3D {}
>  # Map from an event name to an architecture standard
> @@ -28,11 +28,11 @@ _sys_event_table_to_metric_table_mapping =3D {}
>  # f'{_args.starting_dir}/{_args.arch}' directory.
>  _arch_std_events: Dict[str, "JsonEvent"] =3D {}
>  # Events to write out when the table is closed
> -_pending_events: list["JsonEvent"] =3D []
> +_pending_events: List["JsonEvent"] =3D []
>  # Name of events table to be written out
>  _pending_events_tblname: Optional[str] =3D None
>  # Metrics to write out when the table is closed
> -_pending_metrics: list["JsonEvent"] =3D []
> +_pending_metrics: List["JsonEvent"] =3D []
>  # Name of metrics table to be written out
>  _pending_metrics_tblname: Optional[str] =3D None
>  # Global BigCString shared by all structures.
> @@ -1556,9 +1556,15 @@ struct pmu_table_entry {
>      preprocess_arch_std_files(arch_path)
>      ftw(arch_path, [], collect_json)
>
> +  # ProcessPoolExecutor's initializer/initargs need Python 3.7, on 3.6 t=
he
> +  # fork start method already leaves the workers with the parent's
> +  # _arch_std_events, i.e. what _init_worker would set up.
> +  executor_kwargs: Dict[str, Any] =3D {}
> +  if sys.version_info >=3D (3, 7):
> +    executor_kwargs =3D dict(initializer=3D_init_worker,
> +                           initargs=3D(_arch_std_events,))
>    with concurrent.futures.ProcessPoolExecutor(max_workers=3D_parallel_wo=
rker_count(len(tasks)),
> -                                              initializer=3D_init_worker=
,
> -                                              initargs=3D(_arch_std_even=
ts,)) as executor:
> +                                              **executor_kwargs) as exec=
utor:
>      for path, topic, events in executor.map(_parallel_read_json_events, =
tasks):
>        _json_cache[(path, topic)] =3D events
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 8380980ade4c486f..ad904b374ec6eaba 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -11,13 +11,14 @@ import shlex
>  import shutil
>  import subprocess
>  import sysconfig
> +from typing import List
>
>  from setuptools import setup, Extension
>  from setuptools.command.build_ext import build_ext as _build_ext
>  from setuptools.command.install_lib import install_lib as _install_lib
>
>
> -def clang_has_option(cc: str, cc_args: list[str], src_feature_tests: str=
, option: str) -> bool:
> +def clang_has_option(cc: str, cc_args: List[str], src_feature_tests: str=
, option: str) -> bool:
>      """Check if clang supports a specific option.
>
>      Args:
> @@ -47,7 +48,7 @@ def clang_has_option(cc: str, cc_args: list[str], src_f=
eature_tests: str, option
>      return not any(any(error in line for error in error_substrings) for =
line in cc_output)
>
>
> -def filter_clang_options(cc: str, cc_args: list[str], src_feature_tests:=
 str) -> None:
> +def filter_clang_options(cc: str, cc_args: List[str], src_feature_tests:=
 str) -> None:
>      """Filter out unsupported clang options from sysconfig CFLAGS and OP=
T.
>
>      Args:
> --
> 2.55.0
>
