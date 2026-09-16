Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE8415B60
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581606; cv=pass; b=CVSAh5E6WKey8lf6R3vfsCHSJLri6MZEwD/VG7r1w6otLw8R9K4ysYh7M/3DBHuMfCj+3M9T1xoBv2/wHwxp8xIWLeryyu4Vi0GUWIg4HTyW/BbBIIimpwKwIegrmAp6AeYRznqp+xXlxKIFFXQb3HOcE9/N8LbgfqmYY/1fqwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581606; c=relaxed/simple;
	bh=phHc/Hq7GhwLfrvuXhUlkMEFZpHArhpTjZxf2I/CxsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0nijXx7EJ6VGqfWf/Xp9907r4z8+/3Q0jdYmMHGX/yOXBc7GXJ3XaRT93e9NwVplA+tcItdNq7tbhmpMpkwP6zrNH2aqNba6dJrBCwyc5Ur7bnhRPftoE/luLvE+jjFiHT//Olf9EMXRaHaBAEiYsVO2nRl/K97jGME3LhWo7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7r/jjaG; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7r/jjaG"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so362801cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 10:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789581589; cv=none;
        d=google.com; s=arc-20260327;
        b=HFUrA0jbEXU7vNdhz+QRpoj4kunbuAbZVoiu68QPH+fzNhFsq7dLogZABcH+sj1SEv
         gFX8etA1eA/hzBrRsB6YhoJffHU9v+76D0v4SYNwUNe4a9qvOvMWlnnVg3QsAzXS1ME9
         pnfBGnZnJAEXgVCTtgLXrJl/swKvyyLApkIm0BFC+i1pWdsIJ/udWwUIPDbKN4H7SiY/
         c+88fGHwtfpOfDF9j29C9tKK1WDiviY91ex3DnOE3lbUjtOg7o7zBX9IPnnOC7qO82FF
         LWW/qiczTM2hhLoigE4a5uJWXTExvVjxwHbNZRVrNwaFa5JLDQ3IvUrXR2vhyDb3uEfd
         fokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eUm2nBDUGJ3be1Pu+106O/aK1tA7hL04j1FWoINl4o4=;
        fh=nIhdFNKZuQXhTyQqfNF3x2ACtH4OjYXL+/znTQX0CQY=;
        b=AsCKuujSV4NvKJqYxCzPeymAm8fmh17ajZ21eqXVOWQ2YHC2yaBxxCpnwaOnEH6c7q
         lp8Oaio+fzE4JluVR98tLWQkmu7Q2MNQymZpSp65fZeEdxt/+fM+GqqbmY+XSb2PwhQ9
         C+LMJ/vBYx3iY00ZODp9U+TQVyaZqPguqgZdQvaodJAXFo5Nf7JAhoT+JXJcf/Tp/9BW
         TqlpuMdtFIXFXkWZ837Vd2Ot8Uyum9P38GhBkj6cOHO6Jyq39re0FiRAgYL/KgwSZGvB
         FiwTEcyh6vlc4m55lmLGWgZR+BeKke1V6U7+BjAF7+npEISJ1dv6wspWlUbFJ7wEMt8+
         YsjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789581589; x=1790186389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eUm2nBDUGJ3be1Pu+106O/aK1tA7hL04j1FWoINl4o4=;
        b=J7r/jjaGHGB09yFa11RnjRA8CjKJ62qfZ2ckToipxXz1UFIPj6wSO/SnVujV3T9DMU
         EiRuvgqS4iu4Md1N3RzjCM8HdbKS0WHmIlm0P35/AISsoEtlw9isvMJTnY+dqX4TJ4YT
         NXFTI8OsPatxvY46212ra0JyMeYYwYDXLlNoql5vVmVZpg13e0y87yQ4c/v7cJE5THR+
         mBzVc3DMRkqLY2VV5uNzmfdf3c4THIT2u9ayaKUiF3BX714mrhoaTh5cuE46maMeTFfv
         RcGo8/YwTgAgguhUjBcIuzL81JA6AnO2qmwE++a1FXxVyr0D7YPPsFFLOY9kc27qKLLM
         WoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789581589; x=1790186389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eUm2nBDUGJ3be1Pu+106O/aK1tA7hL04j1FWoINl4o4=;
        b=BQftIeHbv8FyVPLjgkpncZ3InVeg6CHT7rvmKORgU2e0TCJNms/U0jerTMZRJvjYw8
         eALOaItUMONnvGmlkm6phBXPh0zS1jcSR/hiwmQcCxBA6UrtFIuXfPV7VawiO8IJ/crP
         ZspC6l8c43vNVJrfQcDClX1ncDgCPBsZzjyuNhTdNPYWzgaXfQLoOZZHedohhOTWGMrV
         8uaCDKtVojkN0RUxoBazl1X+8TeoaxSCwuj+Svmk34SUTFnixULG2qJLR/csU1dfJXgx
         PHmCPuHwluAcc0WgKopBqxv4hZ0KDkkD96orybd6q7RqBXhE9E8WVBW3AgPJVFkOvUvK
         0SyQ==
X-Forwarded-Encrypted: i=1; AKwUvByEKz1W8XhG5HIt4+Knp0cTBRm9eW3bX5UfB1Qhhpyq4hYHQ0EB2GCJVmcs+4X+SYCPJTfYA30NHdOKZdUSw6b1@vger.kernel.org
X-Gm-Message-State: AFuF++kViiUdnn/vM1fDWR5YryxcBIUewtkKqcV/wQsqNgG9Vu9vT47z
	scuCum/3I1Cpn5pEc2so82bFSpfzK1cuwieR5kAaZOiqBjnFbh1fs4Ax6VIOhXDD1jayzh0EBk8
	MFckUtSh8Wegdb+7zu2ibJjkAOjSwXXlIXjR/Rn9E
X-Gm-Gg: AYBFou266UTetLv3XDCXPq016zMj+VdRgWwktdgIYm09Ium2EFrxgbD9cDuDMIzZbbf
	1dk+VXL/Y7Zi7uLbUu3UAM8xgRFc5+imvvFjcILE/amXGDr96P/RniV9CN+oOgriPDy/JoDgFya
	mA559tarY+9nFpDCAnvAGW/zZZfGz35FWYMeVzZNbAdI8B8jrrAiink7fclu43UU5rrP9Lx/S7l
	zWxtxjrTGuoN98KlwVvX5M4YpAiiodxPRW/zU4S3x6+UtG5Z02uARVIY6Gd5VjRnoBB9Y3aqrxX
	KsgKVqM4UjUazWyXhiQV/4bxpJmajODiTDH9ExkL2yYGD9dQvNni041E5N3QnurYDbSSRK5kvUS
	yNuZ5EYTXExPtsBPKKZM=
X-Received: by 2002:a05:622a:4207:b0:531:282:6560 with SMTP id
 d75a77b69052e-5328df7e748mr857551cf.15.1789581583877; Wed, 16 Sep 2026
 10:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916114740.48230-1-acme@kernel.org> <20260916114740.48230-3-acme@kernel.org>
In-Reply-To: <20260916114740.48230-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Sep 2026 10:59:31 -0700
X-Gm-Features: AcwNN1VHRxZ8T6jFxHxe0fBWiJ7kIxDmT2H5H6nRSUv1vr_fFx2TOWa2x3wW00s
Message-ID: <CAP-5=fWr46YKripkCvFHO23k+0SUHfGgYBTDc_qp=ev_Fucc1Q@mail.gmail.com>
Subject: Re: [PATCH 02/12] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 4:48=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> perf already uses debuginfod to fetch source files when annotating
> (via probe-finder.c) and 'perf probe' has open_from_debuginfod(),
> which queries debuginfo keyed by build ID when a module's debuginfo
> isn't found locally, largely the same thing this adds; eventually
> that one could be moved over to the new helper.  For the analysis
> tools there was no way to obtain the debuginfo for a DSO in a
> profile when it isn't available locally under the name the DSO was
> opened with, for instance the vmlinux for the kernel a profile was
> recorded on when processing it on another machine, or after the
> kernel and its debuginfo package got upgraded in between.
>
> Add debuginfo__find_build_id(), that uses the debuginfod client to
> locate a debuginfo file keyed by the build ID, checking its local
> cache first and then querying the servers in DEBUGINFOD_URLS, and
> debuginfo__new_build_id(), that opens the DWARF in the file it finds.

When do we have a build ID but not a DSO? The current intent is that
dso__debuginfo hide these complexities. We currently don't purge DSOs
and the first call to dso__debuginfo should trigger loading with the
DSO owning the debuginfo. With this change we now have a duplication
of DSO's data, keyed by build ID and mapping directly to the
debuginfo. I can't see a performance or efficiency gain and we could
potentially implement some kind of LRU mechanism for DSOs, which would
benefit memory usage for things like perf top.

> The debuginfod client fails when DEBUGINFOD_URLS isn't set even when
> what it wants is in its local cache, and the distro setup scripts that
> populate it from /etc/debuginfod don't reach cron jobs, systemd services
> and other environments that don't source the profile scripts, so also
> set it from the .urls files in /etc/debuginfod when not set.

I found the explanation above hard to follow. Are we setting an
environment variable because debuginfod isn't respecting its /etc
setup?

> That has
> to happen before any thread that can call getenv() is started, as
> setenv() is not thread safe, and there are getenv()s outside the fetch
> lock: libdebuginfod reads DEBUGINFOD_URLS in every debuginfod_begin(),
> which perf also does in build-id.c, probe-event.c and probe-finder.c,
> so do it from symbol__init(), on the single-threaded setup, and not
> lazily from the fetch path.
>
> Querying servers, possibly third party ones, sends off-box the build
> IDs of the binaries being analysed and a fetch can take a while, so
> this is opt-out: on by default, off with --no-debuginfod, with
> core.debuginfod=3Dfalse, per tool with report.debuginfod and
> top.debuginfod, and, since users that set buildid.dir to /dev/null
> (e.g. Linus) or otherwise turn the local build-id cache off clearly
> don't want fetched files stored on the box, off too in that case.
>
> The opt-outs also cover libdwfl's own debuginfod client, that reads
> DEBUGINFOD_URLS in every query: when debuginfod is off, be it with
> --no-debuginfod, core.debuginfod=3Dfalse or by disabling the build-id
> cache, the variable is set to the empty string, that the client treats
> as an opt-out and fails the query without even looking at its cache,
> instead of being exported from /etc/debuginfod.  Tools that manage
> DEBUGINFOD_URLS themselves, such as 'perf record --debuginfod', keep
> doing so.

Libdwfl is part of elfutils and so is debuginfod. Is it possible to
share clients?

> The fetches are serialized, as the lookup state they use is process
> global, so two concurrent fetches would race for it, and serializing
> also means that a request for a build ID that is being fetched doesn't
> start a second download of the same file: it waits for the fetch to
> finish and is answered from the entry the fetch published, keyed by the
> build ID, with the path of the file that came back, checked before
> being handed out in case the debuginfod client cache is cleaned from
> under us.
>
> Make dso__debuginfo() use debuginfo__new_build_id() as a fallback,
> keyed by the build ID recorded in the perf.data file, so that
> consumers such as the data type profiler can resolve the types of
> DSOs whose debuginfo can be fetched this way.  Do the fetch outside
> dso__lock, a fetch from a remote debuginfod server can take a while
> and would otherwise block anything else using this dso, and remember
> the build IDs that were a miss, so that consumers revisiting a set of
> DSOs repeatedly, such as the data type profiler on every hist entry
> DSO switch, don't pay server round trips per attempt.
>
> debuginfo__new_build_id() needs libdw to open the DWARF, so it lives
> in debuginfo.o, built only with CONFIG_LIBDW, while the libdebuginfod
> feature check is independent of NO_LIBDW; keep the new build ID
> prototypes under HAVE_LIBDW_SUPPORT too, with stubs otherwise, so
> that make NO_LIBDW=3D1 on a system that has the debuginfod client
> keeps linking.
>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Documentation/perf-annotate.txt |   8 +
>  tools/perf/Documentation/perf-config.txt   |  19 ++
>  tools/perf/Documentation/perf-report.txt   |  12 +
>  tools/perf/Documentation/perf-top.txt      |  11 +
>  tools/perf/builtin-annotate.c              |   3 +
>  tools/perf/builtin-report.c                |   7 +
>  tools/perf/builtin-top.c                   |   7 +
>  tools/perf/util/config.c                   |   3 +
>  tools/perf/util/debuginfo.c                | 327 +++++++++++++++++++++
>  tools/perf/util/debuginfo.h                |  36 +++
>  tools/perf/util/dso.c                      |  19 ++
>  tools/perf/util/symbol.c                   |  12 +
>  tools/perf/util/symbol_conf.h              |   1 +
>  tools/perf/util/util.c                     | 103 +++++++
>  tools/perf/util/util.h                     |   8 +
>  15 files changed, 576 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Docu=
mentation/perf-annotate.txt
> index 1a90b09a12d5abb1..12edc3337b86f099 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -58,6 +58,14 @@ OPTIONS
>  --ignore-vmlinux::
>         Ignore vmlinux files.
>
> +--debuginfod::
> +--no-debuginfod::
> +       Fetch debuginfo keyed by build ID from the debuginfod servers
> +       configured in DEBUGINFOD_URLS, checking the local debuginfod
> +       client cache first, when it is not available locally, on for
> +       these commands by default.  See the --debuginfod option of
> +       'perf report' for how to turn it off.
> +
>  --itrace::
>         Options for decoding instruction tracing data. The options are:
>
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Docume=
ntation/perf-config.txt
> index 9b223f8928299945..688306abe847a0df 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -216,6 +216,14 @@ core.*::
>         addr2line-timeout::
>                 Sets a timeout (in milliseconds) for parsing 'addr2line'
>                 output.  The default timeout is 5s.
> +       debuginfod::
> +               When set to 'false', disable fetching debuginfo keyed by
> +               build ID from the debuginfod servers configured in
> +               DEBUGINFOD_URLS.  It is on by default, can be overridden =
per
> +               tool with the 'report.debuginfod' and 'top.debuginfod'
> +               options and per invocation with --no-debuginfod; it is of=
f
> +               too when the local build-id cache is disabled, e.g.
> +               'buildid.dir' set to /dev/null.
>
>  tui.*, gtk.*::
>         Subcommands that can be configured here are 'top', 'report' and '=
annotate'.
> @@ -562,6 +570,14 @@ report.*::
>                 This option can change default stat behavior with empty r=
esults.
>                 If it's set true, 'perf report --stat' will not show 0 st=
ats.
>
> +       report.debuginfod::
> +               Fetch debuginfo keyed by build ID from the debuginfod
> +               servers configured in DEBUGINFOD_URLS, checking the local
> +               debuginfod client cache first, when it is not available
> +               locally.  On by default, set to 'false' to disable it for
> +               'perf report', globally with 'core.debuginfod=3Dfalse' or=
 per
> +               invocation with --no-debuginfod.
> +
>  top.*::
>         top.children::
>                 Same as 'report.children'. So if it is enabled, the outpu=
t of 'top'
> @@ -569,6 +585,9 @@ top.*::
>                 column by default.
>                 The default is 'true'.
>
> +       top.debuginfod::
> +               Same as 'report.debuginfod', for 'perf top'.
> +

It seems unfortunate to duplicate this option. I wonder if it should
be a "core" option. There's likely similar clean up necessary for
addr2line.

>         top.call-graph::
>                 This is identical to 'call-graph.record-mode', except it =
is
>                 applicable only for 'top' subcommand. This option ONLY se=
tup
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Docume=
ntation/perf-report.txt
> index 1a4706329c6cef1d..2e11c0a97a016853 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -366,6 +366,18 @@ OPTIONS
>  --ignore-vmlinux::
>         Ignore vmlinux files.
>
> +--debuginfod::
> +--no-debuginfod::
> +       Fetch debuginfo keyed by build ID from the debuginfod servers
> +       configured in DEBUGINFOD_URLS, checking the local debuginfod
> +       client cache first, when it is not available locally, on for
> +       these commands by default.  It can be turned off per invocation
> +       with --no-debuginfod, per tool with the "report.debuginfod"
> +       config option or globally with "core.debuginfod" set to false.
> +       It is disabled as well when the local build-id cache is turned
> +       off, e.g. "buildid.dir" set to /dev/null, as that asks for
> +       fetched files not to be kept on the box.
> +
>  --kallsyms=3D<file>::
>          kallsyms pathname
>
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documenta=
tion/perf-top.txt
> index 2da2a16bbf260685..345dd9ee9b6bab88 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -83,6 +83,17 @@ Default is to monitor all CPUS.
>  --ignore-vmlinux::
>         Ignore vmlinux files.
>
> +--debuginfod::
> +--no-debuginfod::
> +       Fetch debuginfo keyed by build ID from the debuginfod servers
> +       configured in DEBUGINFOD_URLS, checking the local debuginfod
> +       client cache first, when it is not available locally, on for
> +       these commands by default.  Turn it off per invocation with
> +       --no-debuginfod, with the "top.debuginfod" config option or
> +       globally with "core.debuginfod" set to false.  Disabled as well
> +       when the build-id cache is off, e.g. "buildid.dir" set to
> +       /dev/null.
> +
>  --kallsyms=3D<file>::
>         kallsyms pathname
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index 850fc72fa75fe7df..d6a201c1866d363f 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -733,6 +733,9 @@ int cmd_annotate(int argc, const char **argv)
>         OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio int=
erface"),
>         OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
>                      "don't load vmlinux even if found"),
> +       OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
> +                   "fetch debuginfo keyed by build ID from the debuginfo=
d "
> +                   "servers, on by default, use --no-debuginfod to turn =
off"),
>         OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>                    "file", "vmlinux pathname"),
>         OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 279e61c2366cb294..442c0822e614197f 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -134,6 +134,10 @@ static int report__config(const char *var, const cha=
r *value, void *cb)
>                 symbol_conf.event_group =3D perf_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "report.debuginfod")) {
> +               symbol_conf.debuginfod =3D perf_config_bool(var, value);
> +               return 0;
> +       }
>         if (!strcmp(var, "report.percent-limit")) {
>                 double pcnt =3D strtof(value, NULL);
>
> @@ -1346,6 +1350,9 @@ int cmd_report(int argc, const char **argv)
>                    "file", "vmlinux pathname"),
>         OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
>                      "don't load vmlinux even if found"),
> +       OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
> +                   "fetch debuginfo keyed by build ID from the debuginfo=
d "
> +                   "servers, on by default, use --no-debuginfod to turn =
off"),
>         OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>                    "file", "kallsyms pathname"),
>         OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do=
 it"),
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index c2562d49be46a9a1..2be6859fd4aee141 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1436,6 +1436,10 @@ static int perf_top_config(const char *var, const =
char *value, void *cb __maybe_
>                 symbol_conf.cumulate_callchain =3D perf_config_bool(var, =
value);
>                 return 0;
>         }
> +       if (!strcmp(var, "top.debuginfod")) {
> +               symbol_conf.debuginfod =3D perf_config_bool(var, value);
> +               return 0;
> +       }
>
>         return 0;
>  }
> @@ -1508,6 +1512,9 @@ int cmd_top(int argc, const char **argv)
>                    "file", "vmlinux pathname"),
>         OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
>                     "don't load vmlinux even if found"),
> +       OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
> +                   "fetch debuginfo keyed by build ID from the debuginfo=
d "
> +                   "servers, on by default, use --no-debuginfod to turn =
off"),
>         OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>                    "file", "kallsyms pathname"),
>         OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index b2972c35c1eca68c..31c6618d3b3daf22 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -470,6 +470,9 @@ static int perf_default_core_config(const char *var, =
const char *value)
>         if (!strcmp(var, "core.addr2line-disable-warn"))
>                 symbol_conf.addr2line_disable_warn =3D perf_config_bool(v=
ar, value);
>
> +       if (!strcmp(var, "core.debuginfod"))
> +               symbol_conf.debuginfod =3D perf_config_bool(var, value);
> +
>         /* Add other config variables here. */
>         return 0;
>  }
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 84a78b30ceac1066..be5882d9c2204797 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -7,16 +7,22 @@
>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <limits.h>
> +#include <pthread.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <linux/list.h>
>  #include <linux/zalloc.h>
> +#include <api/fs/fs.h>
>
>  #include "build-id.h"
>  #include "dso.h"
>  #include "debug.h"
>  #include "debuginfo.h"
> +#include "mutex.h"
>  #include "symbol.h"
>
>  #ifdef HAVE_DEBUGINFOD_SUPPORT
> @@ -139,6 +145,327 @@ struct debuginfo *debuginfo__new(const char *path)
>         return __debuginfo__new(buf);
>  }
>
> +#ifdef HAVE_DEBUGINFOD_SUPPORT
> +/*
> + * Users can disable the local build-id/.debug cache by setting
> + * buildid.dir to /dev/null, meaning they don't want fetched
> + * binaries/debuginfo stored on the box; the debuginfod client keeps
> + * its own cache in ~/.cache/debuginfod_client, so honour that intent
> + * and don't fetch at all in that case.
> + */
> +static bool debuginfod__cache_disabled(void)
> +{
> +       return !strcmp(buildid_dir, "/dev/null");
> +}
> +
> +/*
> + * Build IDs that shouldn't be searched for again in this session: the
> + * ones already searched for on the debuginfod servers without success,
> + * so that callers that see the same DSO over and over, such as the data
> + * type profiler switching between DSOs on every hist entry, don't pay a
> + * server round trip again for each miss.  The cache of successes is the
> + * debuginfod client's own, in the local filesystem.
> + *
> + * Guarded by debuginfod__fetch_lock: it is only read by the lookups
> + * below, that run with that lock held, and written by fetches, that run
> + * with it held too.
> + */
> +struct debuginfod_miss {
> +       struct list_head        node;
> +       struct build_id         bid;
> +};
> +
> +static LIST_HEAD(debuginfod__misses);
> +
> +/*
> + * Was the search for this build ID already made and settled, i.e. the
> + * servers had nothing for it?
> + */
> +static bool debuginfod__missed(const struct build_id *bid)
> +{
> +       struct debuginfod_miss *miss;
> +
> +       list_for_each_entry(miss, &debuginfod__misses, node) {
> +               if (miss->bid.size =3D=3D bid->size &&
> +                   !memcmp(miss->bid.data, bid->data, bid->size))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static void debuginfod__miss_add(const struct build_id *bid)
> +{
> +       struct debuginfod_miss *miss =3D zalloc(sizeof(*miss));
> +
> +       if (miss =3D=3D NULL)
> +               return;
> +
> +       miss->bid =3D *bid;
> +
> +       list_add(&miss->node, &debuginfod__misses);
> +}
> +
> +/*
> + * One fetch at a time.
> + *
> + * The lookup state below is process global, so two concurrent fetches,
> + * which dso__debuginfo() makes possible by taking the fetch out of
> + * dso__lock, would race for it: the second one could answer from a list
> + * the first one is concurrently updating, and put the same build ID on
> + * the misses list twice.
> + *
> + * Serializing also means a second request for a build ID that is being
> + * fetched waits here for the fetch to finish, instead of starting a sec=
ond
> + * download of the same file, and is then answered from the entry the fe=
tch
> + * published, or from the misses list, with no client at all.  Should th=
e
> + * fetches ever run in parallel, that wait has to come back explicitly, =
with
> + * this lock split in two: one only for the lookup state, that the waite=
rs
> + * sleep on, and one held around each fetch, with the thread that finds =
a
> + * fetch in progress waiting on the former for the entry to be published=
.
> + *
> + * What that costs is that a fetch for one build ID blocks a fetch for
> + * another one, and it is what parallel downloads would fix.  Worth doin=
g
> + * only if the wait turns out to be long, because it mostly is not: the
> + * lookups below answer the second and later requests for a build ID fro=
m
> + * memory, so after the first pass over the build IDs of a workload, whi=
ch
> + * is the only time anything is fetched at all, the serialization has
> + * nothing left to serialize.  Start there if a profile with many DSOs t=
o
> + * fetch shows up in a profile of perf itself.
> + */
> +static struct mutex debuginfod__fetch_lock;
> +
> +static void debuginfod__fetch_lock_setup(void)
> +{
> +       mutex_init(&debuginfod__fetch_lock);
> +}
> +
> +static void debuginfod__fetch_lock_init(void)
> +{
> +       static pthread_once_t once =3D PTHREAD_ONCE_INIT;
> +
> +       pthread_once(&once, debuginfod__fetch_lock_setup);
> +}
> +
> +/*
> + * The build IDs already fetched in this session, and the path of the fi=
le
> + * that came back for each, so that the repeated requests for the same b=
uild
> + * ID, dso__debuginfo() is called per symbol annotated, are answered wit=
h a
> + * strdup() instead of another client: the file is in the debuginfod cli=
ent
> + * cache already and its path checked before being handed out, in case t=
hat
> + * cache is cleaned from under us.
> + *
> + * Guarded by debuginfod__fetch_lock.  Only a fetch that brought a file =
back
> + * gets an entry: one that didn't is recorded in debuginfod__misses as a=
 miss,
> + * and that is what keeps the rest of the session from asking for it aga=
in.
> + * Like debuginfod__misses this grows with the number of build IDs in th=
e
> + * workload, one small entry each, and is not trimmed.
> + */
> +struct debuginfo_lookup {
> +       struct list_head         node;
> +       struct build_id          bid;
> +       char                    *path;
> +};
> +
> +static LIST_HEAD(debuginfo_lookups);
> +
> +static bool build_id__equal(const struct build_id *a, const struct build=
_id *b)
> +{
> +       return a->size =3D=3D b->size && memcmp(a->data, b->data, a->size=
) =3D=3D 0;
> +}

This is probably worth moving to the build-id.[ch] file. I see similar
logic in places like __dso_id__cmp,  dso__missing_buildid_cache in
builitin-buildid-cache.c and sort__dcacheline_cmp. dso__build_id_equal
has some special backward compatibility checks.

[snip]

Thanks,
Ian
