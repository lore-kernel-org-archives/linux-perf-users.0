Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362BB24A067
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796128; cv=none; b=CxjToCko1GWNRGROapWMJvMslgp/jXgHH/d4YYkqQ2uqo6/xrBEVNVn/mGrEGkj5P9NoJXiwwkkd0WK5OAJUpkQ83f7Fo1FY0QpraNICpyHKrjAllSKupgiXPAWXKqx9uWs16oNzB61qYJtzP7O6uL7/sWgk9B1aD2x0fVgefJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796128; c=relaxed/simple;
	bh=UlzlZk95h62E2dFmhFMYDsHx4a8MH2Y12M1Yv1IvIMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfpRbHvOIOJzaysljp6k31hkBEIoi7VO8Qr3I3l6QY9aKcWwE4d4gwcO9Bc0BRzgIkN+73+PtTHjzGGF2QPBnSA2K3Cm1QatkLkVgxiYLadrEUQT10MjyZYHXnjeyl1crNGi3L2Lwwr2oyzZMAqvtOxSDZ25eQKrXu1DvGXrgYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bkKv5hjB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkKv5hjB"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so47445ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750796125; x=1751400925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crm7iMPEqdvrsHtyrAYpKfkV0og2LPRa8E+D3nQ+FeA=;
        b=bkKv5hjBCJZ5bpz9vKSyWhVsZEr7j8p12t89JnWnyJw1btlVJXbZU5iYm3q+VqfdrJ
         zXqVVHwyUzIg7jRDI/LWnb9iAVasMPHF2Ugy5x7gPn+eilT/4kHMRccp9dD86RLai5M4
         a54cTgZVn9KGV4333tEb+KdbMlgGv6X0N7O7byxsqeydluSXT4F4+P0GTuT4HirVgvib
         zHXR6RPGXEoiba9ee9/4tkdAsN6nDanCO3JWWMYT47k1dt3V3sVf/Khfrz9bhOVqYQ8Z
         AU7NGS8jX7hLM0K1EgWwZCYiX4F7ZKkgfkq+yZvj8Dc0+iqkcQz5n3nY9ftrpgCsvG5l
         43WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796125; x=1751400925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Crm7iMPEqdvrsHtyrAYpKfkV0og2LPRa8E+D3nQ+FeA=;
        b=Tzod6ANl8l+8rNCB5BnM2046CnIelghX1Fc/rBeMw3m8gdde8x2vaVDM2ki8YFO31r
         EkgWUyBGHZyjnmHhqE9/erHGE7rXnmYmNia/r8dag2g6BiG1Nh9vVmWJXADuSPx5Y7Di
         ZDeRKS6KXyvDWjDTNEVRRnnfXypmTxor2dy9v80HLhDcAm/qGSpfgDQU7Ebqgz+TDVp9
         hluJWF21obo0AHKVunqj6lhud6537R0R+bbSrCrw/lE+P1jEzckFlVxA9qUVdsp4dOu/
         7QtoH4RzB6liabrPMU8PJPuXOjwZf86ZwW+pMBy6+6XQii+Sb0v0my/LjW9h2vN/Kwos
         tOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxFJpJi7i7+ufEP4Zlo6zYIVQF0xCzwmYNvD9uMCXxCIM+VQo9jfazyCQca6A8sZ9CzG6L0taLvoLb7YY1laHx@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUFPWt5DaL6kXKCoM1ROTFQspaydRKDJwuuKavJF9jpWPocZD
	ZBJOOW/IBwDwVC3aRL69Dvqw/cLYF7NdFLi8nfQ4XQ7hOIiqaNXj+awEDw/abvnKwbfWLhaJXcN
	kavLUwTvmf/KhOho1yKvwpqJArVbEkt2baF3Jr60Y
X-Gm-Gg: ASbGnctBBslPKuFZ61BR8nzvs3rG74S/nEHxRdlGyiOKjVawt8N4t8sipK6mJ3PHVKG
	kqkxrW9BdJ8zfUTe1GFT9sUMtDUYto/nUhaocp00M85FVqm3VyxwS1O4Ay45wNydFxi6TcATh0d
	OPOKBKOvsgilzMyXO2duqqH5yjx3LvYHQRTXZimF9WToWjdNvpEkj2OuC4I4CNQGIIrnPHn8MH0
	Q5yIN1RZCc=
X-Google-Smtp-Source: AGHT+IHDrLMtWz9iH/ZyuBTeDgg6761MH7H9fmWbZDDtDfliqIQt+YgtiWD/fV0rK61WS/GJzLSu9sD2gHWfrhH6DJk=
X-Received: by 2002:a92:c806:0:b0:3dd:a7f3:a229 with SMTP id
 e9e14a558f8ab-3df324b428fmr761455ab.4.1750796124780; Tue, 24 Jun 2025
 13:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607061238.161756-1-irogers@google.com> <aFr4VwxaAi5u5U2F@google.com>
In-Reply-To: <aFr4VwxaAi5u5U2F@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Jun 2025 13:15:13 -0700
X-Gm-Features: AX0GCFsvr6O4cl6_ojTsUDe1lP2DrspXA0qQzZt2H0zA7A110StK3fYtKKb0e_o
Message-ID: <CAP-5=fUh5uJhbgdr0iYqB7DD=hZgdbAr+34yss=pCVwnWG08yQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Pipe mode header dumping and minor space saving
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 12:11=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Jun 06, 2025 at 11:12:34PM -0700, Ian Rogers wrote:
> > Pipe mode has no header and emits the data as if it were events. The
> > dumping of features was controlled by the --header/-I options which
> > makes little sense when they are events, normally traced when
> > dump_trace is true. Switch to making pipe feature events also be
> > traced with detail when other events are.
>
> I'm not sure I'm following.  Are you saying the pipe mode doesn't
> support features with --header/-I option?

No, in pipe mode it currently shows just PERF_RECORD_FEATURE or
PERF_RECORD_ATTR for the details of the events containing these
things. The reason being that the dumping is controlled by separate
header flags (--header and -I). In patch 1 the commit message shows
the before:
```
$ perf record -o - -a sleep 1 | perf script -D -i -
...
0x2c8@pipe [0x54]: event: 80
.
. ... raw event: size 84 bytes
.  0000:  50 00 00 00 00 00 54 00 05 00 00 00 00 00 00 00  P.....T.........
.  0010:  40 00 00 00 36 2e 31 35 2e 72 63 37 2e 67 61 64  @...6.15.rc7.gad
.  0020:  32 61 36 39 31 63 39 39 66 62 00 00 00 00 00 00  2a691c99fb......
.  0030:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0050:  00 00 00 00                                      ....

0 0 0x2c8 [0x54]: PERF_RECORD_FEATURE
```

That is we have a feature "event" but there are no details there to
try to be able to understand the feature event. After the change this
becomes:
```
$ perf record -o - -a sleep 1 | perf script -D -i -
...
0x2c8@pipe [0x54]: event: 80
.
. ... raw event: size 84 bytes
.  0000:  50 00 00 00 00 00 54 00 05 00 00 00 00 00 00 00  P.....T.........
.  0010:  40 00 00 00 36 2e 31 35 2e 72 63 37 2e 67 61 64  @...6.15.rc7.gad
.  0020:  32 61 36 39 31 63 39 39 66 62 00 00 00 00 00 00  2a691c99fb......
.  0030:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0050:  00 00 00 00                                      ....

0 0 0x2c8 [0x54]: PERF_RECORD_FEATURE, # perf version : 6.15.rc7.gad2a691c9=
9fb
```

So now in the dump trace output I can see this was a feature for perf
version and what that value is. There are often multiple
PERF_RECORD_FEATURE and PERF_RECORD_ATTR "events" and so the extra
trace output helps in being able to work out what's going on.

Thanks,
Ian


> It seems to work for me.
>
>   $ git show
>   commit be59dba332e1e8edd3e88d991ba0e4795ae2bcb2 (HEAD -> perf-testing)
>   Author: Ian Rogers <irogers@google.com>
>   Date:   Tue Jun 17 15:33:56 2025 -0700
>
>       libperf evsel: Add missed puts and asserts
>
>       A missed evsel__close before evsel__delete was the source of leakin=
g
>       perf events due to a hybrid test. Add asserts in debug builds so th=
at
>       this shouldn't happen in the future. Add puts missing on the cpu ma=
p
>       and thread maps.
>
>       Signed-off-by: Ian Rogers <irogers@google.com>
>       Link: https://lore.kernel.org/r/20250617223356.2752099-4-irogers@go=
ogle.com
>       Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
>   $ ./perf version
>   perf version 6.16.rc3.gbe59dba332e1
>
>   $ ./perf record -o- true | ./perf report -i- --header-only
>   # =3D=3D=3D=3D=3D=3D=3D=3D
>   # captured on    : Tue Jun 24 12:06:38 2025
>   # header version : 1
>   # data offset    : 0
>   # data size      : 0
>   # feat offset    : 0
>   # =3D=3D=3D=3D=3D=3D=3D=3D
>   #
>   # hostname : bangji
>   # os release : 6.12.20-1rodete1-amd64
>   # perf version : 6.16.rc3.gbe59dba332e1
>   # arch : x86_64
>   # nrcpus online : 4
>   # nrcpus avail : 8
>   # cpudesc : 11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GHz
>   # cpuid : GenuineIntel,6,140,1
>   # total memory : 32566540 kB
>   # cmdline : /home/namhyung/project/linux/tools/perf/perf record -o- tru=
e
>   # event : name =3D cycles:P, , id =3D { 369, 370, 371, 372 }, type =3D =
0 (PERF_TYPE_HARDWARE), ...
>   # CPU_TOPOLOGY info available, use -I to display
>   # NUMA_TOPOLOGY info available, use -I to display
>   # pmu mappings: cpu =3D 4, breakpoint =3D 5, cstate_core =3D 22, cstate=
_pkg =3D 23, hwmon_acpitz =3D 4294901760, ...
>   # time of first sample : 0.000000
>   # time of last sample : 0.000000
>   # sample duration :      0.000 ms
>   # MEM_TOPOLOGY info available, use -I to display
>   # cpu pmu capabilities: branches=3D32, max_precise=3D3, pmu_name=3Dicel=
ake
>   # intel_pt pmu capabilities: topa_multiple_entries=3D1, psb_cyc=3D1, si=
ngle_range_output=3D1, ...
>
> >
> > The attr event in pipe mode had no dumping, wire this up and use the
> > existing perf_event_attr fprintf support.
> >
> > The header's bpf_prog_info or bpf_btf may be empty when written. If
> > they are empty just skip writing them to save space.
>
> These look good to me.
>
> Thanks,
> Namhyung
>
> >
> > Ian Rogers (4):
> >   perf header: In pipe mode dump features without --header/-I
> >   perf header: Allow tracing of attr events
> >   perf header: Display message if BPF/BTF info is empty
> >   perf header: Don't write empty BPF/BTF info
> >
> >  tools/perf/util/header.c | 46 ++++++++++++++++++++++++++--------------
> >  tools/perf/util/header.h |  1 +
> >  2 files changed, 31 insertions(+), 16 deletions(-)
> >
> > --
> > 2.50.0.rc0.604.gd4ff7b7c86-goog
> >
