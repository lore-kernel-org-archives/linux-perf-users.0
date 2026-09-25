Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0B3B5314
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371769; cv=pass; b=FN/Hkuvylsi19Y/dxbg7RinEaN68w72B6rsX13kWNQAnj64fJavTZ7MyYBQ6wJ0m8YqUeRfI6I2C4oeoMiWUcln49K+s3sp5sIMaX4hhBzRlmrOe4cy4gkzdhWW8sfEZOJTuKtNgFgN4je0PR/uZxY+dvsJxgVup/UK9co//mkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371769; c=relaxed/simple;
	bh=WtwHQlgq/kdCcVDBQxBNXirc88LHGp5kWVdfBkFlWoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra4zPZNL+89ajdZZov+5t5asj7wD6EjL7s11PyigWpRXQRccTzxbby/rlNOPxIVU/6KVM65j/LXcchE6xFbFLCJnvE4F628I0knbAoGJ0OH6vzch65qRaU371OEXTY1pbGVpXVh0Hib7YRKTacEJJ1lQg7BowVZ6SjeQxORPEp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLKUPQL8; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLKUPQL8"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-533202fe429so83761cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 14:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790371764; cv=none;
        d=google.com; s=arc-20260327;
        b=fb0tY6TdYMCiz0rfrzVxYCFRGUYmcbdAVLNfZ2J87kficU5cm2UabV7kRvvylunlwH
         zPMtlWRCsarjSikfpQvXO1E+cXsIyg9uezrfBCs+PuOD3whPQcL067tXWRg1qGamfSiX
         dh10htgQhKQEpq43PVcm/5G4QUAGXHZ4n1w2A1EpPIqf2/GWo+e0iXUG++Krg8sS4t7H
         lXGnU4gQh/vWSv7tBx6GkJt5Ou+xs2xb+FXpqcZJuk1Vw+m5hzeLaBN8ka2B3qB7YCi6
         NNR5GAyr33GOAJ0lL5Q/MT/xYHc8JxTmcg92sLygi7w70DOE3SnNvVrPfspDdNycbuHr
         K2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/TOMLXZaa5+2CxWUPPYsAeXSIbOU+tUkgqyMTYQTfYA=;
        fh=tOvn3SzcwelC7sUWcSes5OoNP+M9/Mxe/huPcESoHcE=;
        b=GzDV2TFwzuuLTztERNnQq6/NORAazPIWAh8kdZaykpnxhlVu524SzH0QAA9YlK/xBJ
         e9XpyOnjz89GE4cvZrfb4bmchIw6W1qCrauz+rV63MLAj4rjM5TlCAu/UWfs7RRS9qJU
         Po0ElDeCcfYUZvInJc91MnjwKYKBdL0jVBdLdE4IRjaDNjA1bQEVe63n2eas9/5DIfIT
         EmrsAIcbe/YsSnxAbYCb4HkgoO7W91OksY95J1Fbr1f+54jYFhAELDmlmIyjpHvvkpjl
         FtDD3N4JvLd8/twXRiw3yTo9Qi3OvF06m6SxkSGO7p11YjnDuHQt/ji7okpW0Zb9dXZE
         Un7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790371764; x=1790976564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/TOMLXZaa5+2CxWUPPYsAeXSIbOU+tUkgqyMTYQTfYA=;
        b=FLKUPQL8/D30AneI0IQYytYzQuem9eSVDNu+cUwReej95M+2E0gQ3aqX85Zqm2zRnA
         XVVGHQ+WzJvLyiWTZBChYlIRHj/uuoMpAT7rabv6TKCCBohLmGBrFlEKKMsm0oMmZthj
         yIQ33mWAhcUv/3Bgv5NKbB41nrlCntlLBtMm7fvAgzJAGHzAhMmm/3lGS+qlvrmXttaz
         q/cXNQ7r8aNTy960VwKQJlMpp0l7r5L9vNMSXXUsA+gat2ZTL4ZfemTdSIUA0HWHNDF/
         92yJDdqlaVdn7kM9jTYVX8gl44ch6nhHCQe3V6K5TLgTR8MMm3wJNxFgwVpR6c6omver
         JXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790371764; x=1790976564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/TOMLXZaa5+2CxWUPPYsAeXSIbOU+tUkgqyMTYQTfYA=;
        b=Ux4uWF07fZrteYv6x+o3C0G69ew8JDWBMGBXw3CQI+YlrOLG2XigG8ornmUEVuBQIW
         zKu0DWuEs7vD+tz6pw8pzZKncHTjDKwPsjbsyAjy1MkcLoLSU+Sc0ygCblIpZnUVSRvH
         w6macW862k5JEZVEHKlI+avha7LMm5/pT0WHamdvxWWgcEBGOyOP5W+8iCSk3D0DvEDz
         QeDBmYLSRwx1A+8NU1+d4ZkDC4i71cbDXgE2etwGEg1Jklcg3KbICZ0Ux88Xjg0QFKNm
         rpJ3FlUruWjk8ppGAIFnEEkGbPMDuGcUCQa5EBFWLmrg4+3EuK7nH9b36X3ARoDYKMDu
         fwPQ==
X-Forwarded-Encrypted: i=1; AKwUvByrwOzwGmeXpqATGZShb0lNqw8vrrY3+HCoOFlXu+sNeEhLIBX1v6yDN3/SN1Fm0eMufU2m8n2OOlsU9rEuy7Qw@vger.kernel.org
X-Gm-Message-State: AFuF++ngvPzKOznkmN/LSnm3nA4Rj+wdxQugobvIL6eLxs2HZE5Y+yYZ
	DYuZsdM0lAW62nv0JoIo6B8ySJsRLPW3ujRyC6NI+XX0Wyy0IMXFF+fUH3EBCYVmBEpq5+3jeUG
	kZKTdpmeIh6ZqYaHOGT+CGBDof1lfpKbzGg1+pRqN
X-Gm-Gg: AYBFou3rx6GlMPf60sekQIBjYteoy54OW3PhKaJhwCNB136xYFWSrmxEpbtp/AXlar9
	kp4L/AM26Ud71vQOHlZHFoSf8jdRt5Q1Sq75BjOHlCMDyD1aDGN1qsmSnZojZtj9zNE5hXllaqP
	g28cObW28Ip/Ggto1KOowZMkvcs2dqq9vfGrN0uyvo69Ctbog+qQg1g4Js3j8EbtovuueZ4tbgY
	NQxUqYFcgqtwmqYhcfWMtOufsCyeRkzLIcgQ3nlc1dKBGfn1Rf+Pn64c/zvhyi9g8hyfggD9h8u
	9+2w1at/s83Gr07hCfXt2T9RCrzqpSUEMd+6JHWlsBgngO16pRuJSF2axVKjuJZ8Aopp3GyCeAy
	Ft0y0XIfiKQ==
X-Received: by 2002:a05:622a:8c9:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-5332007659dmr3289261cf.2.1790371763667; Fri, 25 Sep 2026
 14:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arbd4TJm4s9MVjN-@x2> <CAP-5=fVXxUEYSfWb=AExGQoZ7w7FqGhD8Ga1+hjwF3gTZfsbpA@mail.gmail.com>
 <arbkQymeBZ0ja6sc@x2>
In-Reply-To: <arbkQymeBZ0ja6sc@x2>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 14:29:12 -0700
X-Gm-Features: AclHuK9M3tQ8vaLLvrYIzEIkMp5MHX-ZDKM9k4af-RzP7HYH1GQYvuIyMhskflc
Message-ID: <CAP-5=fW3yv2u4MS1TrbLe4iBL_MyfJx3m4KvP5visKsmT_qwvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf: Fix Python 3.6 build breakage in jevents.py and util/setup.py
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 2:14=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Sep 25, 2026 at 01:57:06PM -0700, Ian Rogers wrote:
> > On Fri, Sep 25, 2026 at 1:47=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > perf's build still accepts Python 3.6: Makefile.config only rejects
> > > interpreters older than 3.6 and jevents.py keeps its own removesuffix=
()
> > > shim for it, but two recently added constructs are evaluated when the
> > > module or the function is defined and only work on newer interpreters=
.
> >
> > Could we remove the shim and bump the minimum Python version to 3.9 to
> > be in line with the rest of the kernel build?
> > https://github.com/torvalds/linux/blob/master/Documentation/process/cha=
nges.rst
>
> Since RHEL8 based systems will still be in use for a long time and new
> perf versions can be useful in solving problems in such systems, maybe
> we should keep the support on 3.6 as is now :-\
>
> This patch is not that big and fixes the only cases where python 3.6 was
> breaking, so maybe this is not unreasonable to do.

Could we update the review prompts for this then? Currently the
prompts load from changes.rst:
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/build.=
md
and so Python 3.9. We can then comment that we're doing this for RHEL8 supp=
ort.

RHEL8 appears to be in maintenance mode:
https://endoflife.date/rhel
which means "New functionality and new hardware enablement are not
planned for availability in the Maintenance Support Phase."
https://access.redhat.com/support/policy/updates/errata#Maintenance_Support=
_Phase
So is RHEL8 support only necessary for people building the code
themselves? In that case, they could also update their Python?

Thanks,
Ian

> - Arnaldo
>
> > Thanks,
> > Ian
> >
> > > PEP 585's list[...] became subscriptable in Python 3.9, so the module
> > > level annotations in jevents.py make Kbuild die at import time:
> > >
> > >   TypeError: 'type' object is not subscriptable
> > >   make[3]: *** [pmu-events/Build:176: .../test-empty-pmu-events.c] Er=
ror 1
> > >
> > > as seen on almalinux:8 with its python3.6.8, and the list[str]
> > > parameters of util/setup.py's functions fail the same way when the
> > > python binding is built.
> > >
> > > ProcessPoolExecutor(initializer=3D, initargs=3D) was added in Python =
3.7,
> > > so generating pmu-events.c dies when the pool is created.
> > >
> > > Use the typing generics that exist on every supported interpreter and
> > > only pass initializer/initargs when the interpreter has them: on 3.6
> > > the default fork start method already leaves the worker processes wit=
h
> > > the parent's _arch_std_events, which is what _init_worker() sets up
> > > for spawn semantics.
> > >
> > > Tested with Python 3.6.15: make -C tools/perf completes, generating
> > > pmu-events.c and the python binding.
> > >
> > > Fixes: cda907c2c3f99 ("perf jevents: Add python type annotations")
> > > Fixes: 1fa8d81be1eb ("perf python: Clean up and restructure setup.py"=
)
> > > Fixes: eaab2eb09dc2 ("perf pmu-events: Parallelize JSON and metric pr=
e-computation in jevents.py")
> > > Assisted-by: LLM
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/pmu-events/jevents.py | 24 +++++++++++++++---------
> > >  tools/perf/util/setup.py         |  5 +++--
> > >  2 files changed, 18 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events=
/jevents.py
> > > index 074daae5308b110b..bdc89ec197680c1b 100755
> > > --- a/tools/perf/pmu-events/jevents.py
> > > +++ b/tools/perf/pmu-events/jevents.py
> > > @@ -8,19 +8,19 @@ import json
> > >  import metric
> > >  import os
> > >  import sys
> > > -from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
> > > +from typing import (Any, Callable, Dict, List, Optional, Sequence, S=
et, Tuple)
> > >  import collections
> > >
> > >  # Global command line arguments.
> > >  _args =3D None
> > >  # List of regular event tables.
> > > -_event_tables: list[str] =3D []
> > > +_event_tables: List[str] =3D []
> > >  # List of event tables generated from "/sys" directories.
> > > -_sys_event_tables: list[str] =3D []
> > > +_sys_event_tables: List[str] =3D []
> > >  # List of regular metric tables.
> > > -_metric_tables: list[str] =3D []
> > > +_metric_tables: List[str] =3D []
> > >  # List of metric tables generated from "/sys" directories.
> > > -_sys_metric_tables: list[str] =3D []
> > > +_sys_metric_tables: List[str] =3D []
> > >  # Mapping between sys event table names and sys metric table names.
> > >  _sys_event_table_to_metric_table_mapping =3D {}
> > >  # Map from an event name to an architecture standard
> > > @@ -28,11 +28,11 @@ _sys_event_table_to_metric_table_mapping =3D {}
> > >  # f'{_args.starting_dir}/{_args.arch}' directory.
> > >  _arch_std_events: Dict[str, "JsonEvent"] =3D {}
> > >  # Events to write out when the table is closed
> > > -_pending_events: list["JsonEvent"] =3D []
> > > +_pending_events: List["JsonEvent"] =3D []
> > >  # Name of events table to be written out
> > >  _pending_events_tblname: Optional[str] =3D None
> > >  # Metrics to write out when the table is closed
> > > -_pending_metrics: list["JsonEvent"] =3D []
> > > +_pending_metrics: List["JsonEvent"] =3D []
> > >  # Name of metrics table to be written out
> > >  _pending_metrics_tblname: Optional[str] =3D None
> > >  # Global BigCString shared by all structures.
> > > @@ -1556,9 +1556,15 @@ struct pmu_table_entry {
> > >      preprocess_arch_std_files(arch_path)
> > >      ftw(arch_path, [], collect_json)
> > >
> > > +  # ProcessPoolExecutor's initializer/initargs need Python 3.7, on 3=
.6 the
> > > +  # fork start method already leaves the workers with the parent's
> > > +  # _arch_std_events, i.e. what _init_worker would set up.
> > > +  executor_kwargs: Dict[str, Any] =3D {}
> > > +  if sys.version_info >=3D (3, 7):
> > > +    executor_kwargs =3D dict(initializer=3D_init_worker,
> > > +                           initargs=3D(_arch_std_events,))
> > >    with concurrent.futures.ProcessPoolExecutor(max_workers=3D_paralle=
l_worker_count(len(tasks)),
> > > -                                              initializer=3D_init_wo=
rker,
> > > -                                              initargs=3D(_arch_std_=
events,)) as executor:
> > > +                                              **executor_kwargs) as =
executor:
> > >      for path, topic, events in executor.map(_parallel_read_json_even=
ts, tasks):
> > >        _json_cache[(path, topic)] =3D events
> > >
> > > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > > index 8380980ade4c486f..ad904b374ec6eaba 100644
> > > --- a/tools/perf/util/setup.py
> > > +++ b/tools/perf/util/setup.py
> > > @@ -11,13 +11,14 @@ import shlex
> > >  import shutil
> > >  import subprocess
> > >  import sysconfig
> > > +from typing import List
> > >
> > >  from setuptools import setup, Extension
> > >  from setuptools.command.build_ext import build_ext as _build_ext
> > >  from setuptools.command.install_lib import install_lib as _install_l=
ib
> > >
> > >
> > > -def clang_has_option(cc: str, cc_args: list[str], src_feature_tests:=
 str, option: str) -> bool:
> > > +def clang_has_option(cc: str, cc_args: List[str], src_feature_tests:=
 str, option: str) -> bool:
> > >      """Check if clang supports a specific option.
> > >
> > >      Args:
> > > @@ -47,7 +48,7 @@ def clang_has_option(cc: str, cc_args: list[str], s=
rc_feature_tests: str, option
> > >      return not any(any(error in line for error in error_substrings) =
for line in cc_output)
> > >
> > >
> > > -def filter_clang_options(cc: str, cc_args: list[str], src_feature_te=
sts: str) -> None:
> > > +def filter_clang_options(cc: str, cc_args: List[str], src_feature_te=
sts: str) -> None:
> > >      """Filter out unsupported clang options from sysconfig CFLAGS an=
d OPT.
> > >
> > >      Args:
> > > --
> > > 2.55.0
> > >
