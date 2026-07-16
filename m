Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D2381AE4
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222717; cv=pass; b=rcBId8VfKx4NEwBwZBnzsKP+2iYo1RyTtMQfNTa3d2mT5qpVMrE6cL6T/afmFnq3uYStvEn7DkSHOHfSWjgVMk6UDLcZWQYbVxkqnMbtYkU66BRyZ7ggfe7ccoLdCOFuFcoPAOoqGbMA+2PaL2whyNOo/FdrsghA6MMzz+0MK+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222717; c=relaxed/simple;
	bh=kjEa6FXYInUU0F9F3RnsAOw9PzPsin2inkNvT/F70iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjAUObL0kclSfUs5BNiXa+iBm+H2xaiy4M7FKwOjEYrqevnfoW7kDoSCGbbRwbyXwNlRl0efQB7OUQne2aXbQCdmrZjDDtY/FraeRXQ+tjoUkEEe21PwTCNLVPXX7p3vUzU7Mk7d/oot/8KX7h2hSiz1nZuZZFuOC/3k8x68VIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKQXQ50G; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKQXQ50G"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccdf36f63dso36895ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 10:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784222713; cv=none;
        d=google.com; s=arc-20260327;
        b=jujN7GofHsH9zqXGhfD8maxCCgUQQMjBwC8kcbeqSZL3o/kqBBlpZoh97ci0C2dxAR
         1xT7bJNV89/IPsCU06XrjXf1v1uHhQKuAV5ZgnREYwDo59C/xWOd9SiEW4djsktu8xcB
         BXsvRtbwVAUl7JiOdmO5OZfbSsy32rEI8qLPPWiepGK+eyJtuZ5QYCp3Ww8iR9aDnTge
         5OmUkq8TXPE3+lfz6aQszxbY0my6vB11aTuLA/jVUz775hSKbwmCJZLKdwrMSPB6fOvX
         rO3Hpeaw2mSV5Bcfa8BmJszyEXUK+AQr7ZW7L81PTng+5E3M5dqTmKsSTL2l3OWSsIYG
         QK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P4itiLg7ofslGkBhnrEKZhZVwSyi/GwowDqHtQDu6DE=;
        fh=MFJmABz8DPRs5PcT5e9gcr+Ktm63eXTV04rLM1zGqu0=;
        b=pQW+FFxtWtcE6LqRQBLD8d0XCLgvtLL2F9n6Na53sgcYmM7U2Q9dfFB+lB7mA9aRMf
         +kjPUVVN4zo+BVdtsmo7Qgcw0C4ABGkqwegZfwVK5zXbRFAqeYhmezA+Bh6/+tTViSa9
         eAHv7ZmMLgS56lr7fvKUHPcu09w1sayczB2j+NSZuR+cQAtmnfkDhRWhNhtsLvtR8u2Y
         g8/qlZteT7o2iGf3UnQot+vvc2y7iPo36oLknXxgWPmx77n5pjsbmgbD5s1Gd7HHDm8j
         o39zN6bLjrTbqp8ZwFKAit82nB6hAjyOB4l+7b6d5cEQMBuONQc2XxhBdLv1PKxh36fq
         JO3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784222713; x=1784827513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P4itiLg7ofslGkBhnrEKZhZVwSyi/GwowDqHtQDu6DE=;
        b=WKQXQ50Gt6rl4A8vxlHrB6XorpPhEihIjuczd6LB1N0GvehAzBX6bKWZYcOhgGyqtX
         /TKwpWAfy8BDB5Gwf/bQ5o6OU60A9PC8TKw04GmQYhrDf717w8tmTNYvftNDmrbIQqYt
         /OFQBj0i8HeTQKMCcJ+X9phUcBO04DYAtc0h5TrjW7NXTNu/yzFEluqlsanrzDB8BUF7
         ydBtNzZmvO+2DSv5EJAHSyLl7LxrAMZVsmNa/Y8jle4fFXSUSmYImJzvA68hr3VxwkuW
         +4FqBWi1BU9sih5H6F7cJC1naUdxywxNktDk+JSOD+PbUYKgBZysTlzQiKYJA2ngIRs4
         hD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784222713; x=1784827513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4itiLg7ofslGkBhnrEKZhZVwSyi/GwowDqHtQDu6DE=;
        b=i/TQ2PQbMG5GdWLBfA1iYzfvwa55+UevFLzPx/9R6rmPPBrmIdHIqCqanJ1rzZucrw
         IkapnLobrjd17/lyeWEB4Lwlt6MaoWf8XwekFJWNApmrrsDvWXOSzLNy2LaPAhLE8cmV
         RrSm15HYRKmTOBE6Tg5FmR1/QxFwkjnpcONDVvQf+KLyUJ8I7fHpgeK8cwM+5EdD1481
         9+HvNAwrBY6eP4NtAT9kADfm8B4v8R+0J8NuNIniY6jckLP66qGzPrFjub18dGcXNwIF
         CZeUOzMmwQBNMlCJ0w+e39o7SyMvwBFH3quSRsy73Nl73s5F0fjLikF8BW0zUYgLXGbf
         xX2A==
X-Forwarded-Encrypted: i=1; AHgh+RrrhdHkL/zes08Hx4cgZXqBtYMqSbxIRmTHTb7j58je3U0fBklnk/JcqaDptkhI8OWZosv7C/BKdV4tVKAjtjCt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3Efr8kBDsHmDlusHXJqt3P6Yqzq8b1per7kLt2912Lr0mBFQ
	NjI+PWplUxb2TQ1r+QzmUxWbkPS5asW79xdhEYMkW8v8YTabP5zch3xrr1+9bBMVkOSTJSxKOHz
	Xjpmc/SEP4KvCrD+8vWVw3rEIo1pHfF5LVDhPxEGf
X-Gm-Gg: AfdE7ckys0F7XoaKeb5D/Hq6xxkslQGHh9Y56siJMiKA4u2RkWlJZBuE9Hz6SvJzF3W
	4rTEyFUAFXwQYEOMyQJ0FoAUM1pU02UipzG0/e5Gfy4UO28ujbmUi3P0ZQTNS/QWKYsJjnpIGsp
	jeuggq+t4LilHcf1ntaCtHLO88tDz3XX4YtJ6NkiuGNwITC2UFxm8t+zJcPctUZeWgvdXJNlhFO
	d6V3hlPHJ6FbXC+EbOaGEZRx6WIwaD57g7IH+ubrvdBOkYPri/AiNqSrBfazyN/TSgy4luyB06P
	6iT9NuyE/9s2GY7I
X-Received: by 2002:a17:902:e745:b0:2b7:b03d:9dce with SMTP id
 d9443c01a7336-2cf2f8ccd3cmr135675ad.18.1784222712673; Thu, 16 Jul 2026
 10:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707034019.241762-1-irogers@google.com> <20260707034019.241762-3-irogers@google.com>
 <alkNOWGqi5aD8HlE@google.com>
In-Reply-To: <alkNOWGqi5aD8HlE@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 Jul 2026 10:25:01 -0700
X-Gm-Features: AUfX_mwLdWVSEMk5kR0uq26t_ByL5WukMDEe_irXBMIk2aXAWeuL_M1qENqXEyU
Message-ID: <CAP-5=fW4Lze=nPvD0ycd4uJtTL0H=HjeXidZDya-FOt6jpD71Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf jevents: Add python type annotations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Sandipan Das <sandipan.das@amd.com>, Chun-Tse Shao <ctshao@google.com>, 
	John Garry <john.g.garry@oracle.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 9:56=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Jul 06, 2026 at 08:40:18PM -0700, Ian Rogers wrote:
> > Make mypy clean.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/jevents.py | 77 +++++++++++++++++++-------------
> >  1 file changed, 45 insertions(+), 32 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index 3c6cfeefbd5d..83a239dd69f5 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -14,27 +14,27 @@ import collections
> >  # Global command line arguments.
> >  _args =3D None
> >  # List of regular event tables.
> > -_event_tables =3D []
> > +_event_tables: list[str] =3D []
>
> I got this from one of my test setup.
>
>     GEN     /build/pmu-events/test-empty-pmu-events.c
>   Traceback (most recent call last):
>     File "pmu-events/jevents.py", line 17, in <module>
>       _event_tables: list[str] =3D []
>   TypeError: 'type' object is not subscriptable
>   make[3]: *** [pmu-events/Build:176: /build/pmu-events/test-empty-pmu-ev=
ents.c] Error 1
>   make[2]: *** [Makefile.perf:550: /build/pmu-events/pmu-events-in.o] Err=
or 2
>   make[2]: *** Waiting for unfinished jobs....
>   make[1]: *** [Makefile.perf:288: sub-make] Error 2
>   make: *** [Makefile:76: all] Error 2
>
> Python version was 3.6.15.

I believe the minimum Python version should be 3.9.x:
https://docs.kernel.org/process/changes.html
That version will resolve this issue.

Thanks,
Ian

> I'll process patch 1 for now.
>
> Thanks,
> Namhyung
>
>
> >  # List of event tables generated from "/sys" directories.
> > -_sys_event_tables =3D []
> > +_sys_event_tables: list[str] =3D []
> >  # List of regular metric tables.
> > -_metric_tables =3D []
> > +_metric_tables: list[str] =3D []
> >  # List of metric tables generated from "/sys" directories.
> > -_sys_metric_tables =3D []
> > +_sys_metric_tables: list[str] =3D []
> >  # Mapping between sys event table names and sys metric table names.
> >  _sys_event_table_to_metric_table_mapping =3D {}
> >  # Map from an event name to an architecture standard
> >  # JsonEvent. Architecture standard events are in json files in the top
> >  # f'{_args.starting_dir}/{_args.arch}' directory.
> > -_arch_std_events =3D {}
> > +_arch_std_events: Dict[str, "JsonEvent"] =3D {}
> >  # Events to write out when the table is closed
> > -_pending_events =3D []
> > +_pending_events: list["JsonEvent"] =3D []
> >  # Name of events table to be written out
> > -_pending_events_tblname =3D None
> > +_pending_events_tblname: Optional[str] =3D None
> >  # Metrics to write out when the table is closed
> > -_pending_metrics =3D []
> > +_pending_metrics: list["JsonEvent"] =3D []
> >  # Name of metrics table to be written out
> > -_pending_metrics_tblname =3D None
> > +_pending_metrics_tblname: Optional[str] =3D None
> >  # Global BigCString shared by all structures.
> >  _bcs =3D None
> >  # Map from the name of a metric group to a description of the group.
> > @@ -210,7 +210,7 @@ class JsonEvent:
> >        """Convert an int to a string similar to a printf modifier of %#=
llx."""
> >        return str(x) if x >=3D 0 and x < 10 else hex(x)
> >
> > -    def fixdesc(s: str) -> str:
> > +    def fixdesc(s: Optional[str]) -> Optional[str]:
> >        """Fix formatting issue for the desc string."""
> >        if s is None:
> >          return None
> > @@ -218,7 +218,7 @@ class JsonEvent:
> >                                         '. '), '.').replace('\n', '\\n'=
).replace(
> >                                             '\"', '\\"').replace('\r', =
'\\r')
> >
> > -    def convert_aggr_mode(aggr_mode: str) -> Optional[str]:
> > +    def convert_aggr_mode(aggr_mode: Optional[str]) -> Optional[str]:
> >        """Returns the aggr_mode_class enum value associated with the JS=
ON string."""
> >        if not aggr_mode:
> >          return None
> > @@ -228,7 +228,7 @@ class JsonEvent:
> >        }
> >        return aggr_mode_to_enum[aggr_mode]
> >
> > -    def convert_metric_constraint(metric_constraint: str) -> Optional[=
str]:
> > +    def convert_metric_constraint(metric_constraint: Optional[str]) ->=
 Optional[str]:
> >        """Returns the metric_event_groups enum value associated with th=
e JSON string."""
> >        if not metric_constraint:
> >          return None
> > @@ -241,7 +241,7 @@ class JsonEvent:
> >        }
> >        return metric_constraint_to_enum[metric_constraint]
> >
> > -    def lookup_msr(num: str) -> Optional[str]:
> > +    def lookup_msr(num: Optional[str]) -> Optional[str]:
> >        """Converts the msr number, or first in a list to the appropriat=
e event field."""
> >        if not num:
> >          return None
> > @@ -253,7 +253,7 @@ class JsonEvent:
> >        }
> >        return msrmap[int(num.split(',', 1)[0], 0)]
> >
> > -    def real_event(name: str, event: str) -> Optional[str]:
> > +    def real_event(name: Optional[str], event: Optional[str]) -> Optio=
nal[str]:
> >        """Convert well known event names to an event string otherwise u=
se the event argument."""
> >        fixed =3D {
> >            'inst_retired.any': 'event=3D0xc0,period=3D2000003',
> > @@ -269,7 +269,7 @@ class JsonEvent:
> >          return fixed[name.lower()]
> >        return event
> >
> > -    def unit_to_pmu(unit: str) -> Optional[str]:
> > +    def unit_to_pmu(unit: Optional[str]) -> Optional[str]:
> >        """Convert a JSON Unit to Linux PMU name."""
> >        if not unit:
> >          return 'default_core'
> > @@ -304,21 +304,21 @@ class JsonEvent:
> >        return table[unit] if unit in table else f'uncore_{unit.lower()}=
'
> >
> >      def is_zero(val: str) -> bool:
> > -        try:
> > -            if val.startswith('0x'):
> > -                return int(val, 16) =3D=3D 0
> > -            else:
> > -                return int(val) =3D=3D 0
> > -        except e:
> > -            return False
> > +      try:
> > +        if val.startswith('0x'):
> > +          return int(val, 16) =3D=3D 0
> > +        else:
> > +          return int(val) =3D=3D 0
> > +      except:
> > +        return False
> >
> >      def canonicalize_value(val: str) -> str:
> > -        try:
> > -            if val.startswith('0x'):
> > -                return llx(int(val, 16))
> > -            return str(int(val))
> > -        except e:
> > -            return val
> > +      try:
> > +        if val.startswith('0x'):
> > +          return llx(int(val, 16))
> > +        return str(int(val))
> > +      except:
> > +        return val
> >
> >      eventcode =3D 0
> >      if 'EventCode' in jd:
> > @@ -370,7 +370,8 @@ class JsonEvent:
> >      if precise and self.desc and '(Precise Event)' not in self.desc:
> >        extra_desc +=3D ' (Must be precise)' if precise =3D=3D '2' else =
(' (Precise '
> >                                                                   'even=
t)')
> > -    event =3D None
> > +    self.event: Optional[str] =3D None
> > +    event: Optional[str] =3D None
> >      if configcode is not None:
> >        event =3D f'config=3D{llx(configcode)}'
> >      elif eventidcode is not None:
> > @@ -455,6 +456,7 @@ class JsonEvent:
> >          return f'\t/* {s} */\n' if len(s) < 80 else f'\t/* {s[0:80]}..=
. */\n'
> >
> >      s =3D self.build_c_string(metric)
> > +    assert _bcs is not None
> >      return f'{make_comment(s)}\t{{ { _bcs.offsets[s] } }},\n'
> >
> >
> > @@ -524,6 +526,7 @@ def print_pending_events() -> None:
> >      return
> >
> >    global _pending_events_tblname
> > +  assert _pending_events_tblname is not None
> >    if _pending_events_tblname.endswith('_sys'):
> >      global _sys_event_tables
> >      _sys_event_tables.append(_pending_events_tblname)
> > @@ -534,7 +537,8 @@ def print_pending_events() -> None:
> >    first =3D True
> >    last_pmu =3D None
> >    last_name =3D None
> > -  pmus =3D set()
> > +  pmus: Set[Tuple[str, str]] =3D set()
> > +  assert _args is not None
> >    for event in sorted(_pending_events, key=3Devent_cmp_key):
> >      if last_pmu and last_pmu =3D=3D event.pmu:
> >        assert event.name !=3D last_name, f"Duplicate event: {last_pmu}/=
{last_name}/ in {_pending_events_tblname}"
> > @@ -576,6 +580,7 @@ def print_pending_metrics() -> None:
> >          return ''
> >        return s
> >
> > +    assert j.metric_expr is not None
> >      return (fix_none(j.pmu), fix_none(j.metric_name), j.metric_expr.To=
PerfJson(),
> >              fix_none(j.desc))
> >
> > @@ -584,6 +589,7 @@ def print_pending_metrics() -> None:
> >      return
> >
> >    global _pending_metrics_tblname
> > +  assert _pending_metrics_tblname is not None
> >    if _pending_metrics_tblname.endswith('_sys'):
> >      global _sys_metric_tables
> >      _sys_metric_tables.append(_pending_metrics_tblname)
> > @@ -593,7 +599,8 @@ def print_pending_metrics() -> None:
> >
> >    first =3D True
> >    last_pmu =3D None
> > -  pmus =3D set()
> > +  pmus: Set[Tuple[str, str]] =3D set()
> > +  assert _args is not None
> >    for metric in sorted(_pending_metrics, key=3Dmetric_cmp_key):
> >      if metric.pmu !=3D last_pmu:
> >        if not first:
> > @@ -629,7 +636,6 @@ def get_topic(topic: str) -> str:
> >    return removesuffix(topic, '.json').replace('-', ' ')
> >
> >  def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> =
None:
> > -
> >    if item.is_dir():
> >      return
> >
> > @@ -643,6 +649,7 @@ def preprocess_one_file(parents: Sequence[str], ite=
m: os.DirEntry) -> None:
> >    if not item.is_file() or not item.name.endswith('.json'):
> >      return
> >
> > +  assert _bcs is not None
> >    if item.name.endswith('metricgroups.json'):
> >      metricgroup_descriptions =3D json.load(open(item.path))
> >      for mgroup in metricgroup_descriptions:
> > @@ -704,6 +711,7 @@ def process_one_file(parents: Sequence[str], item: =
os.DirEntry) -> None:
> >
> >  def print_mapping_table(archs: Sequence[str]) -> None:
> >    """Read the mapfile and generate the struct from cpuid string to eve=
nt table."""
> > +  assert _args is not None
> >    _args.output_file.write("""
> >  /* Struct used to make the PMU event table implementation opaque to ca=
llers. */
> >  struct pmu_events_table {
> > @@ -821,6 +829,7 @@ static const struct pmu_events_map pmu_events_map[]=
 =3D {
> >
> >
> >  def print_metric_table_functions() -> None:
> > +  assert _args is not None
> >    _args.output_file.write("""
> >  const char *pmu_metrics_table__name(const struct pmu_metrics_table *ta=
ble)
> >  {
> > @@ -864,6 +873,7 @@ int pmu_metrics_table__iterate_tables(pmu_metrics_t=
able_iter_t fn, void *data)
> >
> >
> >  def print_system_mapping_table() -> None:
> > +  assert _args is not None
> >    """C struct mapping table array for tables from /sys directories."""
> >    _args.output_file.write("""
> >  struct pmu_sys_events {
> > @@ -1400,6 +1410,7 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn=
, void *data)
> >  """)
> >
> >  def print_metricgroups() -> None:
> > +  assert _args is not None
> >    _args.output_file.write("""
> >  static const int metricgroups[][2] =3D {
> >  """)
> > @@ -1443,6 +1454,7 @@ def main() -> None:
> >    def ftw(path: str, parents: Sequence[str],
> >            action: Callable[[Sequence[str], os.DirEntry], None]) -> Non=
e:
> >      """Replicate the directory/file walking behavior of C's file tree =
walk."""
> > +    assert _args is not None
> >      for item in sorted(os.scandir(path), key=3Dlambda e: e.name):
> >        if _args.model !=3D 'all' and item.is_dir():
> >          # Check if the model matches one in _args.model.
> > @@ -1513,6 +1525,7 @@ struct pmu_table_entry {
> >      preprocess_arch_std_files(arch_path)
> >      ftw(arch_path, [], preprocess_one_file)
> >
> > +  assert _bcs is not None
> >    _bcs.compute()
> >    _args.output_file.write('/* clang-format off */\n')
> >    if not _args.output_string_file:
> > --
> > 2.55.0.795.g602f6c329a-goog
> >
