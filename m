Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD4FC3F6B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Aug 2022 14:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiHJOY1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Aug 2022 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiHJOYK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Aug 2022 10:24:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F6312AA6
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 07:24:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v5so7900460wmj.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=s02MYhFisswhR/oml/6C35b5IOfg5F1QOhp/QJOQoMA=;
        b=IPggfYhsg7S72d0+crr42oLh2z/EQ2LSKKJdOZMorRJ4If/4qz9Xlow7pIX+YKWZpI
         +Dzvpz8Lclupl/+LT6cEYFVLW1a48uHLYgCcMMM4ysO5rBGmX1dXj//mAu8J62sHv7ze
         7GIaLTyRhF6DknmROuZh7UKX+qf0a3Ox/uQQYrn4oInhIEIWm7hff7Qtsz+AmU+czJr5
         H9HWc9HX+b8UV7tUbGnOS8tVgeTziVL1p6HtlxmEd0cj1+0wXpWUy45SdaSgJV3qNn6+
         7MEh5BCog1kIiBu7EQRS6ZpI2G9b7TxLxScvUzULo9qSuU6Yelf9dTTwCuVScRJKgrUw
         uvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=s02MYhFisswhR/oml/6C35b5IOfg5F1QOhp/QJOQoMA=;
        b=tmN88lGr891JJxQNuayrSGGaAJq4I4sV8VrjqR4lklA5YW+WyJkio3tjD8s9Oj2ARF
         hxEiTskGITPVYjJdPCvGt1ymeN0tnU3S1zKk2ucPdqiJrvWkD/swB4i47NFzJkhWpm0v
         BF6P4lGdp7J0qwC08GwKIE0MoY1wleGdoPuMAlQaJgJRPdV6gKAwmFHDona65eCLX5PC
         M8eZrOVNWDlRGvZwH2hx/z5UJnFAnCVK5NSrzBoVa1GW/OCKSZOqd9qkRBXPEyAObW0d
         VeaKwEXOen39w7NvmkulS+juT8+LmYb5zeRUDUzkuwOysJV/BEt5+mJFBXGoBVT0F86d
         SyoA==
X-Gm-Message-State: ACgBeo0d21WxAPSEZqDNsbVlG6t/L2hlCFKV1H8cXJHWP4+VgLq0jRsE
        IzEuQbnWpYzVoW7RpzS6Yi8Rl6U2tqyXg3JqI6sl/g==
X-Google-Smtp-Source: AA6agR7dsoBEuPHZkASaOuZphZaQ28UgXVC0ir0+cOXaD/SFKR5yFMxzrNFRTi5qQwEi9XiCrxZNqPpNqPy2TsqQwCA=
X-Received: by 2002:a05:600c:4e86:b0:3a3:417a:2fcd with SMTP id
 f6-20020a05600c4e8600b003a3417a2fcdmr2716098wmq.149.1660141446416; Wed, 10
 Aug 2022 07:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com> <20220804221816.1802790-8-irogers@google.com>
 <ad2ad328-89f9-7dea-a6fd-b473da2f1ad0@huawei.com>
In-Reply-To: <ad2ad328-89f9-7dea-a6fd-b473da2f1ad0@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Aug 2022 07:23:53 -0700
Message-ID: <CAP-5=fVWx9ROmHiOYJdBRvQNCdoUxf83dY8nBOsxMe5Xb-ofKQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] perf jevents: Sort json files entries
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 5, 2022 at 3:49 AM John Garry <john.garry@huawei.com> wrote:
>
> On 04/08/2022 23:18, Ian Rogers wrote:
> > Sort the json files entries on conversion to C. The sort order tries to
> > replicated cmp_sevent from pmu.c so that the input there is already
>
> replicate

Ack.

> > sorted except for sysfs events.
> >
> > Add the topic to JsonEvent on reading to simplify. Remove an unnecessary
> > lambda in the json reading.
>
> We sort the attributes of the events alphabetically by attribute name,
> right? Is there any advantage in this? Do we need it for later?


The sort order is given by the tuple:
(not j.desc is None, fix_none(j.topic), fix_none(j.name),
fix_none(j.pmu), fix_none(j.metric_name))
which is putting events with descriptions and topics before those
without, then sorting by name, then pmu and finally metric_name. The
advantage is that when we qsort alias events:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmu.c?h=perf/core#n1759
the events are already in the sorted format, which should make the
code faster - it still has to qsort the sysfs events.

Longer term I'd like to make the searching for an event, or metric, by
name a binary rather than a linear search.

Thanks,
Ian

> thanks,
> John
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++++++---------
> >   1 file changed, 35 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index 12d2daf3570c..30e0e792221a 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -18,6 +18,8 @@ _sys_event_tables = []
> >   _arch_std_events = {}
> >   # Track whether an events table is currently being defined and needs closing.
> >   _close_table = False
> > +# Events to write out when the table is closed
> > +_pending_events = []
> >
> >
> >   def removesuffix(s: str, suffix: str) -> str:
> > @@ -127,6 +129,7 @@ class JsonEvent:
> >         eventcode |= int(jd['ExtSel']) << 8
> >       configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
> >       self.name = jd['EventName'].lower() if 'EventName' in jd else None
> > +    self.topic = ''
> >       self.compat = jd.get('Compat')
> >       self.desc = fixdesc(jd.get('BriefDescription'))
> >       self.long_desc = fixdesc(jd.get('PublicDescription'))
> > @@ -199,7 +202,7 @@ class JsonEvent:
> >           s += f'\t{attr} = {value},\n'
> >       return s + '}'
> >
> > -  def to_c_string(self, topic_local: str) -> str:
> > +  def to_c_string(self) -> str:
> >       """Representation of the event as a C struct initializer."""
> >
> >       def attr_string(attr: str, value: str) -> str:
> > @@ -211,25 +214,27 @@ class JsonEvent:
> >         return attr_string(attr, getattr(self, attr))
> >
> >       s = '{\n'
> > -    s += f'\t.topic = "{topic_local}",\n'
> >       for attr in [
> >           'aggr_mode', 'compat', 'deprecated', 'desc', 'event', 'long_desc',
> >           'metric_constraint', 'metric_expr', 'metric_group', 'metric_name',
> > -        'name', 'perpkg', 'pmu', 'unit'
> > +        'name', 'perpkg', 'pmu', 'topic', 'unit'
> >       ]:
> >         s += str_if_present(self, attr)
> >       s += '},\n'
> >       return s
> >
> >
> > -def read_json_events(path: str) -> Sequence[JsonEvent]:
> > +def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
> >     """Read json events from the specified file."""
> >
> >     try:
> > -    return json.load(open(path), object_hook=lambda d: JsonEvent(d))
> > +    result = json.load(open(path), object_hook=JsonEvent)
> >     except BaseException as err:
> >       print(f"Exception processing {path}")
> >       raise
> > +  for event in result:
> > +    event.topic = topic
> > +  return result
> >
> >
> >   def preprocess_arch_std_files(archpath: str) -> None:
> > @@ -237,7 +242,7 @@ def preprocess_arch_std_files(archpath: str) -> None:
> >     global _arch_std_events
> >     for item in os.scandir(archpath):
> >       if item.is_file() and item.name.endswith('.json'):
> > -      for event in read_json_events(item.path):
> > +      for event in read_json_events(item.path, topic=''):
> >           if event.name:
> >             _arch_std_events[event.name.lower()] = event
> >
> > @@ -251,19 +256,36 @@ def print_events_table_prefix(tblname: str) -> None:
> >     _close_table = True
> >
> >
> > -def print_events_table_entries(item: os.DirEntry, topic: str) -> None:
> > -  """Create contents of an events table."""
> > +def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
> > +  """Add contents of file to _pending_events table."""
> >     if not _close_table:
> >       raise IOError('Table entries missing prefix')
> > -  for event in read_json_events(item.path):
> > -    _args.output_file.write(event.to_c_string(topic))
> > +  for e in read_json_events(item.path, topic):
> > +    _pending_events.append(e)
> >
> >
> >   def print_events_table_suffix() -> None:
> >     """Optionally close events table."""
> > +
> > +  def event_cmp_key(j: JsonEvent):
> > +    def fix_none(s: str):
> > +      if s is None:
> > +        return ''
> > +      return s
> > +
> > +    return (not j.desc is None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
> > +            fix_none(j.metric_name))
> > +
> >     global _close_table
> > -  if _close_table:
> > -    _args.output_file.write("""{
> > +  if not _close_table:
> > +    return
> > +
> > +  global _pending_events
> > +  for event in sorted(_pending_events, key=event_cmp_key):
> > +    _args.output_file.write(event.to_c_string())
> > +    _pending_events = []
> > +
> > +  _args.output_file.write("""{
> >   \t.name = 0,
> >   \t.event = 0,
> >   \t.desc = 0,
> > @@ -306,7 +328,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
> >     if not item.is_file() or not item.name.endswith('.json'):
> >       return
> >
> > -  print_events_table_entries(item, get_topic(item.name))
> > +  add_events_table_entries(item, get_topic(item.name))
> >
> >
> >   def print_mapping_table(archs: Sequence[str]) -> None:
>
