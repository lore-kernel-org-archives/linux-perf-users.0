Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4222A81A
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005004; cv=none; b=IieRsoya2FBZqB8UNROSeuXiQJuW7zHxDnO56QE8ggqu65ZAlOD9NbW+kMS6ukipt7MqnW/DiJmrtt7DblTkz2KaMTcSpNnjAqZXIV7Tjn7XQI0H03+vSQTADqjaPdZgg8nvvjlLZsoh5ADhHpFzmuv+nxk06DR1PZ/9AtxSnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005004; c=relaxed/simple;
	bh=h2NRHjDecopR8l5RP8zzvh9LJ1iSzbV/geHRFqci76I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtmR6mpmk10ctONTh2aLCxvfOi+7+vUXwqlAqjXqqHPgM8cenEVKb8DHNTnHEn7iRQBa4NADiZUZBwJYlwxGe0GvdW0s2HZeRQOcDOvvp+3bKVsCecQuHhxiLFTRKnx+ikcYCUdT+5MdOnW7Pf/TrOFGDMKDjRqr7mrfMbsV2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mMqv0luy; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMqv0luy"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so46625ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740005001; x=1740609801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y/dovmWdG7T+i+r2MZlIGAZJzk/xUKUEy1yv6P218A=;
        b=mMqv0luy66O8ENb8LNhwhXuum3LvjFy5ryhIpXUTzfyBXlblf79DI0drVNLJmCttZu
         ZPAxDBEJ5OGOJUmirrC+gc+iYJ/w/6vgbcULK9Y8/oWDJl8osiJ7dopAq6KF1GILAG3f
         v4fqhdUIAkVQ1yunvXMpJoDqAxdkUJSeZaw3GoHZWqbca/CM6jtsQ8NEyz/WYn95NR8m
         7LYd44yRU3bgVT5rnjfq4a5BKSq5axEguTUFpicDS8U8rVU8aPkF30O+yInJ4YmgL0ik
         saqmGWQ03fVpsbD1DbIzSKb2EM6VoZDOeeo3dQrWnW9F3tu58o6F6Zjkf+Vi9UZ0gLIV
         UtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740005001; x=1740609801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y/dovmWdG7T+i+r2MZlIGAZJzk/xUKUEy1yv6P218A=;
        b=gLuYUIVy9NLjsGogF85DkefAw3wpcOQsl9hA0QZMbuLi+Rf3EzPNO9zQ9RLfa0giQb
         HFmeZz0TLQtKXlEd7K8bTCSfZspwP733kI94q4/zVOEUfAO6iNEcAKWvUhpfEL6kusNy
         Hz/AjOII6xaMuEgm9OcTgVSbw0ycZj8OgjtGNhlyP9+KWGtg66yKEkij4+80+nF29KOL
         TjLQIdLuZ1yojflUf+CUNdHRk15g9tavMCui7ybPKQJsX6iRvO7BVrgs7VflgswYUEI9
         3oKtSue5u2i90QJ6JfdCZgoMhhLMB590X1QuVoiJo2VtGTf8ryyDQdGp3tmD3Qu9v8Bp
         1isQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVp7eWsQ9yE0cLlw8I2nt1QbcovBPjh500eyP+31u72qy0cr8rxC/eQqYGKLDi1WPUDUlH51DlOTXOwhgMvNAc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyye+tdnvwX4X58nmXisjLiwBFe2EHPFa3O54HlvA2kpK5z1mc
	LfYTWc38WsT6gbhzyYZH5w/7gnS7DBIg29aiIAX+2SUy3UzB/hcoZp5xtB3EPjo0wqjRDnQ6dQg
	8ENQHkrX5jBSxqDuLqxui76CPF8OIHR31bD4y
X-Gm-Gg: ASbGncsQENi4AscOEDTGYlVrXAXRbjEexCsyqO0aM/kvA/SaDX8+CDVBEkp21OC3kxg
	hrsYEkvr853rzecFTV6fFOtrFEr9tXlgHC7S099LMuTzJbZlXggie1RMH8f06txGEptoe8BDa4V
	aWXt6N0lm7+HF32wPKC7MGzpX/RA==
X-Google-Smtp-Source: AGHT+IFC0YKr6ge+vQ0BA0jbZopO8H5aIWcwki6w0/svHfg5XzmpQ8wqSVmBQuHa6Wl6ARptthNty7N4A/x29IJdE8Y=
X-Received: by 2002:a05:6e02:1b05:b0:3d0:bd4:e46e with SMTP id
 e9e14a558f8ab-3d2c0b75924mr1079235ab.22.1740005001493; Wed, 19 Feb 2025
 14:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109175401.161340-1-irogers@google.com> <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
 <CAP-5=fWZAk7XqtL+=CanefkuFxhDsJ22+-uHkrxXi4g8123oew@mail.gmail.com>
 <Z7ZD5phOOCbKggrn@google.com> <CAP-5=fXeZM7iWNQq0ar1HmAwWrH4HAHqD3F=ueB=jaw-2UMn_w@mail.gmail.com>
 <Z7Za30xyVUQWI1tV@google.com>
In-Reply-To: <Z7Za30xyVUQWI1tV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 14:43:10 -0800
X-Gm-Features: AWEUYZkoW8uinawVDJYMzpveA0ZEuCIE2CtPCeO_4HSgxaqFzd9JHRM-ml0me0g
Message-ID: <CAP-5=fW=_4j43-mY3B02BavaOdTA469kUjEZaahTUA5S7Ma4sQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Tidy name token matching
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 2:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 19, 2025 at 02:11:43PM -0800, Ian Rogers wrote:
> > On Wed, Feb 19, 2025 at 12:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Wed, Feb 19, 2025 at 11:02:40AM -0800, Ian Rogers wrote:
> > > > On Mon, Feb 10, 2025 at 11:23=E2=80=AFAM Ian Rogers <irogers@google=
.com> wrote:
> > > > >
> > > > > On Thu, Jan 9, 2025 at 9:54=E2=80=AFAM Ian Rogers <irogers@google=
.com> wrote:
> > > > > >
> > > > > > Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scannin=
g PMUs
> > > > > > before parsing") names (generally event names) excluded hyphen =
(minus)
> > > > > > symbols as the formation of legacy names with hyphens was handl=
ed in
> > > > > > the yacc code. That commit allowed hyphens supposedly making
> > > > > > name_minus unnecessary. However, changing name_minus to name ha=
s
> > > > > > issues in the term config tokens as then name ends up having pr=
iority
> > > > > > over numbers and name allows matching numbers since commit
> > > > > > 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with=
 digits
> > > > > > "). It is also permissable for a name to match with a colon (':=
') in
> > > > > > it when its in a config term list. To address this rename name_=
minus
> > > > > > to term_name, make the pattern match name's except for the colo=
n, add
> > > > > > number matching into the config term region with a higher prior=
ity
> > > > > > than name matching. This addresses an inconsistency and allows =
greater
> > > > > > matching for names inside of term lists, for example, they may =
start
> > > > > > with a number.
> > > > > >
> > > > > > Rename name_tag to quoted_name and update comments and helper
> > > > > > functions to avoid str detecting quoted strings which was alrea=
dy done
> > > > > > by the lexer.
> > > > > >
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > Ping. This patch addresses name parsing inconsistencies, in parti=
cular
> > > > > events may start with a number without a PMU, but not with. It al=
so
> > > > > aims to give better names to patterns than name_minus and name_ta=
g
> > > > > (with term_name and quoted_name respectively) that have drifted f=
rom
> > > > > their original meaning and become to me less than intention revea=
ling.
> > > >
> > > > Ping.
> > >
> > > Sorry for the delay.  Can you please give an example for better
> > > understanding if there's a change in the behavior?
> >
> > The example in:
> > https://lore.kernel.org/r/20240510-perf_digit-v4-3-db1553f3233b@codewre=
ck.org
> > is `perf trace -e '9p:*'` which allows the number to start a
> > tracepoint name, but what is true for tracepoint names is also true
> > for event names. I lack the tracepoint but the patch here is making
> > that work if the event/tracepoint is specified with a PMU, so:
> >
> > Before the input is just seen as broken:
> > ```
> > $ perf stat -e 'tracepoint/9p:9p/' true
> > event syntax error: 'tracepoint/9p:9p/'
> >                                \___ Unrecognized input
> > Run 'perf list' for a list of valid events
> >
> > Usage: perf stat [<options>] [<command>]
> >
> >    -e, --event <event>   event selector. use 'perf list' to list
> > available events
> > ```
> >
> > After the input fails because the event wasn't found:
> > ```
> > $ perf stat -e 'tracepoint/9p:9p/' true
> > event syntax error: 'tracepoint/9p:9p/'
> >                     \___ Bad event or PMU
> >
> > Unable to find PMU or event on a PMU of 'tracepoint'
> >
> > event syntax error: 'tracepoint/9p:9p/'
> >                                \___ unknown term '9p:9p' for pmu 'trace=
point'
> >
> > valid terms: config,config1,config2,config3,name,period,percore,metric-=
id
> >
> > event syntax error: 'tracepoint/9p:9p/'
> >                                \___ unknown term '9p:9p' for pmu 'trace=
point'
> >
> > valid terms: config,config1,config2,config3,name,period,percore,metric-=
id
> > Run 'perf list' for a list of valid events
> >
> > Usage: perf stat [<options>] [<command>]
> >
> >    -e, --event <event>   event selector. use 'perf list' to list
> > available events
> > ```
> >
> > But the patch is just about making the name term more consistent and
> > cleaner, the weirdness above wasn't its main point, I want the code to
> > be easy to read and understand.
>
> Ok, so I guess there's no behavior change from the users perspective in
> this patchset.  Do you plan to add support for the tracepoint name in
> the config term (like tracepoint/9p:9p/) later?

I think we treat tracepoints much as we do regular PMU perf events
except in the encoding of the config. There is also a sysfs PMU:
```
$ ls -al /sys/bus/event_source/devices/tracepoint
/
total 0
drwxr-xr-x  3 root root    0 Feb 19 14:35 .
drwxr-xr-x 78 root root    0 Feb 19 08:13 ..
-rw-r--r--  1 root root 4096 Feb 19 14:34 perf_event_mux_interval_ms
drwxr-xr-x  2 root root    0 Feb 19 08:13 power
lrwxrwxrwx  1 root root    0 Feb 19 08:13 subsystem -> ../../bus/event_sour=
ce
-r--r--r--  1 root root 4096 Feb 19 10:53 type
-rw-r--r--  1 root root 4096 Feb 19 08:13 uevent
```
with the type reflecting the perf_event_attr type (3 aka
PERF_TYPE_TRACEPOINT). So I think much like with the hwmon_pmu.c it
makes sense to have a tracepoint_pmu.c and move logic like
parse-events add_tracepoint in there:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n523
in that case tracepoint/9p:9p/ would be a valid tracepoint event name.
For now this code is cleaning up that if you had a 9p on say the cpu
PMU, 9p would wildcard match with it but cpu/9p/ would be a parse
error - as the event name currently doesn't allow a number to start it
when it is part of the term list, what this patch fixes as part of
tidying up the code.

Thanks,
Ian

>
> Thanks,
> Namhyung
>
