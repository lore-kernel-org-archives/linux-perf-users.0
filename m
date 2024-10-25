Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871C20A5D0
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880803; cv=none; b=eNKFaa/CPEsUNuz3Ey3XVOijPn1x3u09rZS4DvGkBPxxhG8SgEaz5i5Zed20xcaI2WMfMDp4DbRJI1mXJpKuZWLtfJOqOJJ3J3xqq3z121RglqURwxaj3esKMchY/tnLcrPR0BDeTnOpDluxVsmBX4BopVelGiUBtZRuUPyGIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880803; c=relaxed/simple;
	bh=wXO8DVxWInf4/onGpZFKSnWuJtr5zd2yG/DNkZPuQVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsSYwJ8yPRAg+cE/bJNAxQl8kSZ1IwfllbAnUM+XdZOqTLRgagFtViuwCGMu2013tqsKUyKddfMOq23mwy5TjAunrjzwbG1L6XrgMp6WCv4o6NoHGhOUgC+kAYRmZzw8XZr8wHruU4TKnxnAARGca/BHlldCLDN/ndfc9dD6BQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8NwYaMV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8NwYaMV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca4877690so18315ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729880800; x=1730485600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mxch2jceRGkVBlz336RsPUbQGRq3wTZKN+cS0JWNR44=;
        b=t8NwYaMVhsSUUZRfED4B1iRt356+oNqqsOT9H0qELYprzg4Wfy0OHt2KRSc6noSAN2
         8Od+gaRUWHwCGOTl5Y/OvCdL+qEkMWyfmH14YSK8E/WeKaU1OS6GIl0bb6OnmLHcT90Y
         j2R8NBP3xhU3lR5fTzth52gRIJKJHetoddLXgoPLhS5tbyf+LKy9dQ7vb2W8qzjdTYvw
         7DO9knrrh+PtWuuGDLWnRWPk6RHpOfqHkdV7s6rzP23XuH28y+8A5UVdMvf3gszjQDxi
         7jWSvDx0yK3lnmAc/OMNoqu6WaTjhhnyHNONDg63Zmg9D9tsSCgMbDLf6MEgDWEX4Llf
         wcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880800; x=1730485600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mxch2jceRGkVBlz336RsPUbQGRq3wTZKN+cS0JWNR44=;
        b=gjCRzUqiaWLPcmDeEByZVZgV6z8vv5E6jwQpVtbHTnb/hnKlJSn8AXuyttk4P8uqad
         03K1iHdsQvvJA4Ec67vLc4vrsav9TeRpcl+VV5K4TbeFfsfOzctIL4jQN8W2FDq9IEB0
         dlMpv7YBtR8XWKJu4xSESNJXOuAelooBzvzykideZByPFCdAKaYdMTLwr6vcAu6a1lrf
         pjnBxxpcJkUQAxTXjzRKd03tvSBRx0Ur1I7xfgy5PPqtpxU+vGTqGYIYZslePMGG7eiE
         U8hj+bj4bMTpi9mkyW/O+YIqDqncqiCpjioBwqwBGxrZZLDnUK6unia7h+b+GlPFdkr0
         A97w==
X-Forwarded-Encrypted: i=1; AJvYcCWW+r97Xgkz+mPLsEy+ESvtAtiAZkGEz+phQVcnqwdQ7XaQGKfQme6tGMZJ4TOkLXTe2ChnMS89OW60MavRQedx@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDM89wShfzDmhF8xdGBvP+QZ+Zh7EuPEe4ldUOOdReKfo3nt6
	puzYOd+9qp2eg3G1mozj74ypcSJLi/zrl7F87UxouQs+KepWDVsC02qGIyNuXKhkRG/b5XK5RrO
	4TAvU48DI0g+fptzxW73tIiZnYxVsOfwxha6P
X-Google-Smtp-Source: AGHT+IHwYwGjlevJvHONATg57+JHShC7/xzFisfkImzJkZ8YsYL/7bFVdjHlsBJ4foaYT43aPWsFy3/CgPH9Z66yHpk=
X-Received: by 2002:a17:902:e749:b0:206:a87c:2873 with SMTP id
 d9443c01a7336-210c67e67acmr124445ad.5.1729880799649; Fri, 25 Oct 2024
 11:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022180623.463131-1-irogers@google.com> <Zxm5w6wXLxpbERZx@google.com>
 <CAP-5=fXfyd9b7Ns-SL5F+iffc7oy4NFHBsT3oj3CRMbBa1QCfg@mail.gmail.com>
 <Zxp4mbzsFyO5nUh7@google.com> <CAP-5=fWP-T57-Bb60eixhgO3m7f_v3y-tWmV=ypuR52iNSAQvQ@mail.gmail.com>
 <ZxvVuFqef2CLwtCs@google.com>
In-Reply-To: <ZxvVuFqef2CLwtCs@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Oct 2024 11:26:26 -0700
Message-ID: <CAP-5=fVTU8nUfadXgpUd4my9emsY4c_7znMa9_RWD6VZbGYhZA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Hwmon PMUs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:30=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Oct 24, 2024 at 06:33:27PM -0700, Ian Rogers wrote:
> > On Thu, Oct 24, 2024 at 9:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Thu, Oct 24, 2024 at 12:07:46AM -0700, Ian Rogers wrote:
> > > > On Wed, Oct 23, 2024 at 8:06=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > On Tue, Oct 22, 2024 at 11:06:18AM -0700, Ian Rogers wrote:
> > > > > > Following the convention of the tool PMU, create a hwmon PMU th=
at
> > > > > > exposes hwmon data for reading. For example, the following show=
s
> > > > > > reading the CPU temperature and 2 fan speeds alongside the unco=
re
> > > > > > frequency:
> > > > > > ```
> > > > > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus=
_online/ -M UNCORE_FREQ -I 1000
> > > > > >      1.001153138              52.00 'C   temp_cpu
> > > > > >      1.001153138              2,588 rpm  fan1
> > > > > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > > > > >      1.001153138                  8      tool/num_cpus_online/
> > > > > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET      =
           #     1.08 UNCORE_FREQ
> > > > > >      1.001153138      1,012,773,595      duration_time
> > > > > > ...
> > > > > > ```
> > > > > >
> > > > > > Additional data on the hwmon events is in perf list:
> > > > > > ```
> > > > > > $ perf list
> > > > > > ...
> > > > > > hwmon:
> > > > > > ...
> > > > > >   temp_core_0 OR temp2
> > > > > >        [Temperature in unit coretemp named Core 0. crit=3D100'C=
,max=3D100'C crit_alarm=3D0'C. Unit:
> > > > > >         hwmon_coretemp]
> > > > > > ...
> > > > > > ```
> > > > > >
> > > > > > v6: Add string.h #include for issue reported by kernel test rob=
ot.
> > > > > > v5: Fix asan issue in parse_hwmon_filename caught by a TMA metr=
ic.
> > > > > > v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu =
from
> > > > > >     the update to perf_pmu to use it. Try to make source of lit=
eral
> > > > > >     strings clearer via named #defines. Fix a number of GCC war=
nings.
> > > > > > v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
> > > > > > v2: Address Namhyung's review feedback. Rebase dropping 4 patch=
es
> > > > > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > > > > >
> > > > > > Ian Rogers (5):
> > > > > >   tools api io: Ensure line_len_out is always initialized
> > > > > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in =
sysfs
> > > > > >   perf pmu: Add calls enabling the hwmon_pmu
> > > > > >   perf test: Add hwmon "PMU" test
> > > > > >   perf docs: Document tool and hwmon events
> > > > >
> > > > > I think the patch 2 can be easily splitted into core and other pa=
rts
> > > > > like dealing with aliases and units.  I believe it'd be helpful f=
or
> > > > > others (like me) to understand how it works.
> > > > >
> > > > > Please take a look at 'perf/hwmon-pmu' branch in:
> > > > >
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-=
perf.git
> > > >
> > > > Thanks Namhyung but I'm not really seeing this making anything simp=
ler
> > > > and I can see significant new bugs. Your new patch:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf=
.git/commit/?h=3Dperf/hwmon-pmu&id=3D85c78b5bf71fb3e67ae815f7b2d044648fa083=
91
> > > > Has taken about 40% out of patch 2, but done so by splitting functi=
on
> > > > declarations from their definitions, enum declarations from any use=
,
> > >
> > > Yeah, it's just because I was lazy and you can split header files too
> > > (and please do so).
> > >
> > > > etc. It also adds in code like:
> > > >
> > > > snprintf(buf, sizeof(buf), "%s_input", evsel->name);
> > > >
> > > > but this would be a strange thing to do. The evsel->name is rewritt=
en
> > > > by fallback logic, so cycles may become cycles:u if kernel profilin=
g
> > >
> > > I know it doesn't work but just want to highlight how it's supposed t=
o
> > > work.  Eventually what we need is a correct file name.  In fact, I th=
ink
> > > it'd work if we can pass a correct event name probably like:
> > >
> > >   perf stat -e hwmon5/name=3Dfan1/ true
> >
> > But this isn't what the term name and evsel's name are for. They are
> > to allow you to do:
> > ```
> > $ perf stat -e cycles/name=3Dfoobar/ true
> >
> > Performance counter stats for 'true':
> >
> >         1,126,942      foobar
> >
> >       0.001681805 seconds time elapsed
> >
> >       0.001757000 seconds user
> >       0.000000000 seconds sys
> > ```
> > Why would you do this in code, change a fundamental of evsel behavior,
> > then just to delete it in the next patch?
>
> Well, I didn't change the actual behavior and it doesn't work yet.
> The deletion is just one line, and I think it reveals the intention of
> the next patch very well.
>
> >
> > > > is restricted. This is why we have metric-id in the evsel as we can=
not
> > > > rely on the evsel->name not mutating when looking up events for the
> > > > sake of metrics. Using the name as part of a sysfs filename lookup
> > > > doesn't make sense to me as now the evsel fallback logic can break =
a
> > > > hwmon event. In the original patch the code was:
> > >
> > > The fallback logic is used only if the kernel returns an error.  Thus
> > > it'd be fine as long as it correctly finds the sysfs filename.  But i=
t's
> > > not used in the final code and the change is a simple one-liner.
> >
> > But it's not. It's changing what evsel->name means to be an event
> > encoding. How does reverse config to name lookup work in this model?
> > How does the normal use of the name term work?
>
> It's intermediate code that is not activated yet.  So I think it's about
> to say how the code works.  If you really don't like to use evsel->name,
> maybe you can put a dummy name with a comment saying it'll be updated in
> next patch.
>
> >
> > > >
> > > > snprintf(buf, sizeof(buf), "%s%d_input", hwmon_type_strs[key.type],=
 key.num);
> > > >
> > > > where those two values are constants and key.type and key.num both
> > > > values embedded in the config value the evsel fallback logic won't
> > > > change. But bringing in the code that does that basically brings in
> > > > all of the rest of patch 2.
> > >
> > > Right, that's why I did that way.
> > >
> > > >
> > > > So the patch is adding a PMU that looks broken, so rather than
> > > > simplifying things it just creates a broken intermediate state and
> > > > should that be fixed for the benefit of bisects?
> > >
> > > Actually it's not broken since it's not enabled yet. :)
> > >
> > >
> > > > It also complicates understanding as the declarations of functions =
and
> > > > enums have kernel-doc, but now the definitions of enums and functio=
ns
> > > > are split apart. For me, to understand the code I'd want to squash =
the
> > > > patches back together again so I could see a declaration with its
> > > > definition.
> > >
> > > Yep, please move the declarations to the patch 3.
> >
> > So I think moving the enum declarations into one patch is okay. But as
> > the enum values have no bearing on hardware constants, or something
> > outside of the code that uses them it smells strange to me. Ultimately
> > this is going to do little to the lines of code count but damage
> > readability. I'm not sure why we're doing this given the kernel model
> > for adding a driver is to add it as a large chunk. For example, here
> > is adding the intel PT driver:
> > https://lore.kernel.org/all/1422614392-114498-1-git-send-email-alexande=
r.shishkin@linux.intel.com/T/#u
>
> Maybe others can understand a big patch easily, but I'm not.

My understanding is that we make small patches so that the codebase is
more bisectable. When there is something new, like a driver or here a
hwmon PMU, the first patch is large and then we switch to the small
patch model. I have seen patches adding constants ahead of them being
used, but not normally as enums. I've already reduced the size of the
patch by moving everything that isn't hwmon PMU out of the patch and
most of that has already landed. Moving enums out of a header file
okay, shouldn't break the build (a compiler may complain about unused
enums) but then I end up copying comments into commit messages and
doing something alien to what is done in the rest of the kernel. Not
defining a function when you declare it, that is in many cases a
compiler error and for good reason. Adding in changes that are what
are or could be compiler errors goes against making things bisectable.

So breaking up this patch is bad as:
1) it doesn't match existing kernel style,
2) it makes the patch harder to understand (declarations split from
definitions, etc.),
3) with new compiler errors/warnings the code will be less bisectable
as we're deliberately doing things we think wrong for the sake of a
lines-of-code size,
4) we increase the number of patches and commit messages, with commit
messages duplicating comments for things like functions or enums being
added,
5) with your patches we create an intermediate PMU with different
conventions than the rest of the code base and with bugs, impacting
bisectability and the ability to understand the code base.

So I'm arguing against doing this as it is contrary to both our normal
objectives and existing style. I have no real way of knowing when I've
cut something up small enough and if we're not building the code then
how do I build/test the intermediate states, I'm just out on a wild
goose chase.

Thanks,
Ian
