Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4331D387;
	Thu, 18 Sep 2025 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226326; cv=none; b=B3d1khqweFd95HTNuFcl8pcYM/H20oLC+AJcBSWJsafmmsa7Jz6HKipseWZ3F+vp8lOuopt3eWvjYHBH4G+iqy8se5u+YSGTRygG6nOVEafx9iJPewOmJrIuVEqlg0HIh1scPGhxx4dMHVPvmmtMLBX25JrbES2fAwrXk2VqCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226326; c=relaxed/simple;
	bh=RxCpqhSvLg4lk7i9vbQdgM1MVNM/M/8zr48h4MsKziQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fwen+yftgAojIYlQ58sOVFrFaplgBnZCJ3K+wsTjxz1aexygUlQo1H+YsC1iEwb6v8hwZ0UKHRO5/6PoqLuMqii+dS1lDjCcepdFmO+BoxdjP0CaNG5L8/ZEMm+jN8iqnk/Qjdm0RsdKaNiY8kv5nJJhwDuAig86c1M4yT2AZvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVfz5EMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVfz5EMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E562C4CEE7;
	Thu, 18 Sep 2025 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758226326;
	bh=RxCpqhSvLg4lk7i9vbQdgM1MVNM/M/8zr48h4MsKziQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVfz5EMUsDpb+0LZ8xGvg6w9zy/epN8/yRL5Y46vIjdJN2tk29Mm1E5XIzz690h9b
	 LlP0k6rsqjfIgQlZcDnpsGlekukCsLvorolwuarWFu2pv/jOztLtLw5d3t3JTclW/T
	 /Jtnm+3/h5rNyr8ieI+1c+b0TDDOJbVT7QTqdXvquKjr7B60QPJ482aWMW0vCiuKDi
	 +uzNHZoafbVH6NokoWViz4kU4zHTHaSqhHzB59v2VgnfUHu5zqD6m07SC/eSYdMl/2
	 qoNdP/AACvN58ksSUvVqypAJBkojL7QT6ssHwjrK8vHWfl6k0lEKgF4MJGzY33toqZ
	 sVXniDenv9Hjg==
Date: Thu, 18 Sep 2025 17:12:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] perf check: Add 'system' subcommand
Message-ID: <aMxnk8dQrXC-q5dD@x1>
References: <20250918063944.16331-1-namhyung@kernel.org>
 <CAP-5=fVAsDN50X07zpnxikS_tA2cw92YJwHR2f9RVs0fc8j-Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVAsDN50X07zpnxikS_tA2cw92YJwHR2f9RVs0fc8j-Ng@mail.gmail.com>

On Thu, Sep 18, 2025 at 08:48:10AM -0700, Ian Rogers wrote:
> On Wed, Sep 17, 2025 at 11:39 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > +/**
> > + * Usage: 'perf check system <settings>'
> > + *
> > + * Show system settings that affect perf behavior.
> > + */
> > +static int subcommand_system(int argc, const char **argv)
> > +{
> > +#define PERF_SYSCTL(name) { #name, system_help_##name }
> > +       struct {
> > +               const char *name;
> > +               const char *(*help)(int value);
> > +       } sysctls[] = {
> > +               PERF_SYSCTL(perf_event_paranoid),
> > +               PERF_SYSCTL(perf_event_max_stack),
> > +               PERF_SYSCTL(perf_event_mlock_kb),
> > +               PERF_SYSCTL(nmi_watchdog),
> > +               PERF_SYSCTL(kptr_restrict),
> > +       };
> > +#undef PERF_SYSCTL
> > +
> > +       argc = parse_options(argc, argv, check_system_options,
> > +                            check_system_usage, 0);
> > +
> > +       for (size_t i = 0; i < ARRAY_SIZE(sysctls); i++) {
> > +               int value;
> > +
> > +               if (argc) {
> > +                       bool found = false;
> > +
> > +                       /* only show entries match to command line arguments */
> > +                       for (int k = 0; k < argc; k++) {
> > +                               if (strstr(sysctls[i].name, argv[k])) {
> > +                                       found = true;
> > +                                       break;
> > +                               }
> > +                       }
> > +                       if (!found)
> > +                               continue;
> > +               }
> > +
> > +               value = read_sysctl_kernel_int(sysctls[i].name);
> > +               printf("%-20s = %d", sysctls[i].name, value);
> > +               if (!quiet)
> > +                       printf("\t# %s", sysctls[i].help(value));
> > +               printf("\n");
> > +       }
> > +
> > +       return 0;
> 
> This looks useful! Rather than returning 0 should this return
> something indicating whether perf does or doesn't have the permission?
> In that case, what about root? We have this pattern in our shell
> tests:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/lib/stat_output.sh?h=perf-tools-next
> ```
> function ParanoidAndNotRoot()
> {
> [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
> }
> ```
> I wonder things like this can use these values instead.

Yeah, I thought about that as well, to use these checks in the perf test
shell entries.

- Arnaldo
