Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A32836B1
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Jan 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520137; cv=none; b=YHbU2gx3qMCRA3CYLQxhwjs7+YPdhNsup5r48V928ylq0l/L66tEsRbNbr0bAlLCwUJQ4Ii7mmvT0coYt5HcABtf4RuLHSMMdMyFyX/AqTwqxQ+8cupCFlFTtYbqa7X97HhqIL7tBDRpVSBwq8UXk+jZN3T5BGGkwvxttApTlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520137; c=relaxed/simple;
	bh=Sd5u1m4hBvY3ac+Xo0S7P6bC5jfOmx5rGLi7Jyx41H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsbyaSe+PBLbfdG9BHEbx+PQ4bQrOtIgn7m20kDgNHS74g8TIs3mVQHgi18443VlVVh26vpnhix62PZKykOU/8tddi6qrtq4roOW4kDKxEYZyUW8gj3B23XUDDaiQ9nIe27LLawXji5he1vB57LA0yd3twxzGUICc4nIPny2DGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mzt+qbtJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mzt+qbtJ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b876f3f603eso263717166b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jan 2026 15:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768520134; x=1769124934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd5u1m4hBvY3ac+Xo0S7P6bC5jfOmx5rGLi7Jyx41H0=;
        b=Mzt+qbtJ10hAeqYHRFXJUHvk2GtxJzcoPJozj+fg//Ci+xE1EKsS0ZwbNiWBg32nwf
         KocUAGWC5B8evL1gny5lPBAxnq/aNZjWxYn5dYmMAFJzksR9VOtW51ynVxA5duGgWSFH
         CHajMKJSk5Zgl23ZrhQkSIHnDahRkVqf0OxArPMDPZPdTgzVFYkb9a18aeXm9yGiKaxi
         rtMN6h7DZLrizD+mdHvu7hmLyZmSvQCZfWIyj5H6m9QLDxKYmRAOQkZw/WuIZt3z2XDB
         WgCx6AlKc9scIS4pJNr2Nou5hwE0FNnddY5pRnEBLRw0g6XnPghrMME1MyPbefANUcNH
         zneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768520134; x=1769124934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sd5u1m4hBvY3ac+Xo0S7P6bC5jfOmx5rGLi7Jyx41H0=;
        b=l5gMYKlE+jveNsp/xtqgBPf+3P9vBUbNVdCCY0Fu8sOQMH1fNfJ5VopP/dg11A5Jx6
         73ndUuYOuN5uZJk9vKvOZkHmYshAk2DI7qaIT+oa3C3XSHIMXijZnmjvASzo/tXiXn8a
         M1K8tKv9B9xF1p/864SJacnRS80/xhva/h9tQnew/Sm2Z82LCp7TepSjGD65cE1eLiaQ
         ZotK/7Mnl05yhtSi085zPBPkvHVs1l9sJ63+PF4Z3elr5ssMYiC57Usx4SLELeKNbuvB
         AJPfUzR3MSTKy98d+QHUyaj9oetXJRyYFwP8cxOZz1ExmtmHv1bYBLxl7ZuqbUrKL+EP
         4cqw==
X-Forwarded-Encrypted: i=1; AJvYcCWIJgaMf6U65GcZdGwtvjlPbs4AtJZVbzhJPUc+3qkSicC3lGWz+xfvo5T6YHfyZozGKYysYsY8R6jksVUl/XwM@vger.kernel.org
X-Gm-Message-State: AOJu0YxTemb2IVRaZy8z4r6fd+vztiXgr9HBR90BIIvJuGLH+aktb0go
	x7kjAEtIZc7R2wSuKyG5hE7fk8dBgvF5sTQrJAwTmsNwcyhmoeL1s19swJ6/LyrsvK8NUDdDKgJ
	cuwh16lV1KuWGCDfu177Xx1kvPVwKYgFSqiAOSb77
X-Gm-Gg: AY/fxX7NKERDzKtTjlfAFHj5qTLhfasnoFHopBR8BZkfvIQyTmjVzujoURz8WjiRZ0L
	smngOBevR7BTghn6RDSf+CjssPkTglFswfxkoYX8zjZ48IGSKz2tGzvSvSCWSctx/t9EoCUHOGL
	2WTh/ofrdZUjbqmNh/77zt0XRHGUbTi3yODoxfFzjyBrrgB9s4DM90NkxJvRpe3dXaPQ6xNPBbT
	09V5KnXqgDq1lhj2U8IOxrRh4sA+WNKrn39yEwgUuso9C9lAa1X/MRUJevPDoFtIQTKX6MRKFvV
	DhlHqwV1/slTgo1yvm4yRWqPjQ==
X-Received: by 2002:a17:907:7ba0:b0:b87:701d:341a with SMTP id
 a640c23a62f3a-b879691c97dmr60702466b.25.1768520133853; Thu, 15 Jan 2026
 15:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201202437.3750901-1-wusamuel@google.com> <20251201202437.3750901-2-wusamuel@google.com>
 <f28577c1-ca95-43ca-b179-32e2cd46d054@arm.com> <CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
 <20251204114844.54953b01@gandalf.local.home> <CAJZ5v0irO1zmh=un+8vDQ8h2k-sHFTpCPCwr=iVRPcozHMRKHA@mail.gmail.com>
 <20251229165212.5bd8508d@gandalf.local.home> <20251229170021.71cc5425@gandalf.local.home>
In-Reply-To: <20251229170021.71cc5425@gandalf.local.home>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 15 Jan 2026 15:35:22 -0800
X-Gm-Features: AZwV_Qjrxjv68dd8vV8YximCsepNvBfmIJ1YNLb9adYYh_EA_LMsFGVBQLimKwc
Message-ID: <CAG2KctqvAKUYwWex=8vDeMvAaDEUJ0D4gEoAZczapnpeM5p-SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with trace_policy_frequency
To: Steven Rostedt <steven@rostedt.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 2:00=E2=80=AFPM Steven Rostedt <steven@rostedt.org>=
 wrote:
>
> On Mon, 29 Dec 2025 16:52:12 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Thu, 4 Dec 2025 18:24:57 +0100
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > My concern is that the patch effectively removes one trace point
> > > (cpu_frequency) and adds another one with a different format
> > > (policy_frequency), updates one utility in the kernel tree and expect=
s
> > > everyone else to somehow know that they should switch over.
> > >
> > > I know about at least several people who have their own scripts using
> > > this tracepoint though.
> >
> > Hi Rafael,
> >
> > Can you reach out to those that have scripts that use this trace event =
to
> > see if it can be changed?
> >
> > Thanks,
>
> I got a bunch of "Undelivered Mail Returned to Sender". It seems that gma=
il
> thinks my goodmis.org account is now spam :-p
>
> -- Steve
>
Hi Rafael,

Bumping thread since it's unclear if Steven's email has gone through.

Are you able to reach out to those with the scripts using this
tracepoint to see if they can be changed? Hopefully this update can be
proactive, but I'm optimistic even a reactive update would be
straightforward.

-- Sam
