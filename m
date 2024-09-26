Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422415D5B9
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380064; cv=none; b=Vupz6nCcii4cpzcadwfaHcJVQgzK6TJyPlhEr9IlQnYqmYjqLSahcQ/J6+uG0+FF6TDvEmVzSwlYQvQ6U/9XuusawsbBCWaqA27Q0KDgRZu5O5DSKQCHAHdccqCKOMmUW6lNmvydztqr8Dk3AKUMHdkIaQr3Oqm7G7vYCkSZ7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380064; c=relaxed/simple;
	bh=OpdobiaGJFsmzqwmWBmY8ufHrVW3++B4wWy6CDvPzaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGtBHuIl3pIYhUjSvT76GDZBMoFXTgosuMka0L60Ikon7sFiElrjDRvqvQqPxMG2iqaVfrswJOOc5xvL4NFMX4UuhWCu5CFlz6T61QfArHLchHbilnQVUraYFCqxh6JpE0Bgjel7WbNLppoCbgLq7TdjZ5QKuX6OpwEKqgozNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yh/IrXzu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yh/IrXzu"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4581cec6079so66081cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727380060; x=1727984860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l2ZmMYvrEcnOZf47Vq9a28fJ0BtZT2mBNCMtDWME2s=;
        b=Yh/IrXzuHcyJO9pbzCPuQEA5L1Fwf9vKoWM+fOvF2UE8q/0gCIK3stEzdCbV2KK7kc
         bhq69wcAP3eVQUpVaF4KJUomGMydvv9zbMOmAEyqa2aXoJbNlYW5fCdvvHedxf2lHa+8
         fGTjM5xMbfCuBSZN8Hhbix29aCGc4DzHqVaeeIxKzm7CZ6cp1QkfceZZjImOwjFv8H8g
         uD9Eo3B9x9b+mYPTE1ak1CVeaMYfs36M9iEwbSbYH1QdypjuXCrnVVmTthx4ohWyxeq7
         dnd+4uVJZkgCAcJZN71+2VhEJd+NCjYRBbykRN5KbuhS3ZU8oKv6ATataPGeLFUoG+aV
         ULmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727380060; x=1727984860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l2ZmMYvrEcnOZf47Vq9a28fJ0BtZT2mBNCMtDWME2s=;
        b=fsxZWluf+qkHm0iJLwG+CjL3R8cYobnEMmbUHiEAP6T2VNsPM/ir3KMBqGkYis57KB
         VdrfOoOhnr1ekjm/folba37IxN6i0cxPHJMRvRvOpYHwv/qbbmz4C64Xnwk68znT8hwi
         4xjxcAtST+ibTpmPYnMOzRqQ9ax+h3xMjEU+sDtH+MbhL2fxWM0UjPjMWTTm52Zl/W3H
         z7eRjUmnnkPMfYfpp5b3Nn9Hzr4xPgpKgbfebqm5wcrhu7qnzk9cT1+MGJtNuy79Athq
         9F0pOoLTsUjyiyqREioFN8bvWMgM3MUp+e7E9gRmVwzY4mfFnAUP8vSfyeE29Yl7huxk
         8X5g==
X-Forwarded-Encrypted: i=1; AJvYcCXlYxiYReBjTcqa9x6kSuT8d0igpLfecVjK/mFiOrjlj046Dsp4byLI0Bt82Qbbu2S0dHNENBluibWxahhKjffz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4EMjJsfy7AfWw+rAY4drhyHExb4JoyvQWVnf5a3xh8rHiTLS
	q8+fbxE41zrIJAbmnmgmAKoXLwO98Xe96FZNAPItP6SO8b/IZ9wTllf8bGSKXB3Q7rxY6EmMe1M
	u7onGqZgbLx1rK0cO4hX55iO1IEtNnF5BW0jz
X-Google-Smtp-Source: AGHT+IELdLdzrIUeQYOm8qqxy378MyWwf4r+N0EorvnRAGn6DI4pHLTLiIdWSk3uPqWIwIiVcpPhXMLr9+7aIqfcmo8=
X-Received: by 2002:a05:622a:a313:b0:453:5961:b880 with SMTP id
 d75a77b69052e-45ca018d829mr575351cf.10.1727380060084; Thu, 26 Sep 2024
 12:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com> <ZuNwJ07GyMVIT0Qi@google.com>
 <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
In-Reply-To: <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 12:47:26 -0700
Message-ID: <CAP-5=fX3jXPiFhY+Neo8imz7V=86WDtjM42Gcq5phe6LoCLMkA@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Tool and hwmon PMUs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Junhao He <hejunhao3@huawei.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 7:34=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Sep 12, 2024 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Thu, Sep 12, 2024 at 12:03:27PM -0700, Ian Rogers wrote:
> > > Rather than have fake and tool PMUs being special flags in an evsel,
> > > create special PMUs. This allows, for example, duration_time to also
> > > be tool/duration_time/. Once adding events to the tools PMU is just
> > > adding to an array, add events for nearly all the expr literals like
> > > num_cpus_online. Rather than create custom logic for finding and
> > > describing the tool events use json and add a notion of common json
> > > for the tool events.
> > >
> > > Following the convention of the tool PMU, create a hwmon PMU that
> > > exposes hwmon data for reading. For example, the following shows
> > > reading the CPU temperature and 2 fan speeds alongside the uncore
> > > frequency:
> > > ```
> > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_onlin=
e/ -M UNCORE_FREQ -I 1000
> > >      1.001153138              52.00 'C   temp_cpu
> > >      1.001153138              2,588 rpm  fan1
> > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > >      1.001153138                  8      tool/num_cpus_online/
> > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET            =
     #     1.08 UNCORE_FREQ
> > >      1.001153138      1,012,773,595      duration_time
> > > ...
> > > ```
> > >
> > > Additional data on the hwmon events is in perf list:
> > > ```
> > > $ perf list
> > > ...
> > > hwmon:
> > > ...
> > >   temp_core_0 OR temp2
> > >        [Temperature in unit coretemp named Core 0. crit=3D100'C,max=
=3D100'C crit_alarm=3D0'C. Unit:
> > >         hwmon_coretemp]
> > > ...
> > > ```
> > >
> > > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > >
> > > Ian Rogers (13):
> > >   perf pmu: Simplify an asprintf error message
> > >   perf pmu: Allow hardcoded terms to be applied to attributes
> > >   perf parse-events: Expose/rename config_term_name
> > >   perf tool_pmu: Factor tool events into their own PMU
> > >   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
> > >   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
> > >   perf tool_pmu: Move expr literals to tool_pmu
> > >   perf jevents: Add tool event json under a common architecture
> > >   perf tool_pmu: Switch to standard pmu functions and json descriptio=
ns
> > >   perf tests: Add tool PMU test
> > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
> > >   perf test: Add hwmon "PMU" test
> > >   perf docs: Document tool and hwmon events
> >
> > For patch 1-10,
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>

I thought the plan was for 1 to 10 to be in v6.12 and the remaining 3
to be in perf-tools-next/v6.13. I'm not seeing any of the series in
perf-tools so should everything be going in perf-tools-next?

Thanks,
Ian
