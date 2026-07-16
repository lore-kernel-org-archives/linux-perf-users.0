Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22488357CEB
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188277; cv=none; b=WNHq3YQC8oyCt1bF3wbBGyEEyBpYkXX4SV/kPdAGjK4ktwG/BPBbDGQEcYuV78fu+G7cqUlfv7JN6+0EpEQgS1719Bixw2QMVul3M5JGQvfyR8DDGVl+yRiQdQgO5YsBz57qdMpKltCkAfxz3xsr4D7sbOU8uU2ruW/RWvw3Cm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188277; c=relaxed/simple;
	bh=NY/xkbaD+MUssHhKN/3jUzsUBi7nSc4+YeNV4fSwINw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NYs+/B/IW57MXHMwUxQAodyYh6CSoxGZGyTZf3W0SgK2f8r0kiUfe4PKRr3CZ/bX2wDulIoFkUlNW7cT2xMy0nANkTUjrE8BJLL18VtpMD8qUrvJjWSZ1oAkJYWwAoWJc0jG+OygxynugsgRYMQSm8vnriLpRKJiRc2V2Vwcmcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECQGyQR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECQGyQR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974921F000E9;
	Thu, 16 Jul 2026 07:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188275;
	bh=v+5C6dzKGVNJ4/8M7TsW9EhYjkQT+VvZ4e7+wFBeNEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECQGyQR2MdIRV9j5dPIQ7TMTa/XzpabYT51byANDoG6D7vpdpATGmtoopQ8l2Afxg
	 gTYGbURhCdUqcYG+HzunloAVueM8ZJhGtTTZQJhijVWsnNAAVJTIJwP1ZsMAhPXa5/
	 ktEjAE57gCZivpgOSF8+gsjZ5fm2aVWr35cOLzpb42Nj85t2qhQOHba+T1zD1MwIi4
	 IxVbVHzLHTAL434dX5BuPtfsJQYPuoMo4KbyL69I9gTNeR8GFWz4F//0U8gNb3BPM7
	 PMHPsS42BOP8LCixLmJfaH/KO/DBUKNoaYAcOEweYnNxPq317KXPxuEPnTabGm4nqb
	 FUjVc+cTte8Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/10] perf annotate: Be robust to annotating without
 a thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716072351.560311-10-irogers@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:51:15 +0000
Message-Id: <20260716075115.974921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional call to `map__kmaps()` on user-space maps triggers i=
nternal error spam.
- [High] Unbalanced `map__put()` on the selected `map` when zooming out via=
 ESC/LEFT leads to Use-After-Free.
- [Medium] `map_symbol__get_arch` returns negative POSIX error code, breaki=
ng its caller's error formatting.
--

--- Patch [10]: [PATCH v6 10/10] perf annotate: Be robust to annotating wit=
hout a thread ---
commit 6b7b7896027a6d84296eafef08984d82adf8db72
Author: Ian Rogers <irogers@google.com>

perf annotate: Be robust to annotating without a thread

If a thread isn't given to map_symbol__get_arch try harder to determine
the arch for disassembly. Do this by using fallback paths such as
reading the e_machine from a map's dso.

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index e0ef756d95367..aee3d2c4e1867 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
[ ... ]
> @@ -3347,8 +3347,10 @@ static int evsel__hists_browse(struct evsel *evsel=
, int nr_events, const char *h
>  				 */
>  				do_zoom_dso(browser, actions);
>  			} else if (top =3D=3D &browser->hists->thread_filter) {
> -				actions->thread =3D thread;
> -				do_zoom_thread(browser, actions);
> +				memset(&hotkey_act, 0, sizeof(hotkey_act));
> +				hotkey_act.ms.thread =3D thread__get(thread);
> +				do_zoom_thread(browser, &hotkey_act);
> +				map_symbol__exit(&hotkey_act.ms);

[Severity: High]
Does the migration to use map_symbol in popup_action elements introduce a
use-after-free when zooming out?

In evsel__hists_browse(), when handling K_ESC or K_LEFT to zoom out, the
code assigns the map pointer directly:

evsel__hists_browse() {
    ...
    case K_ESC:
    case K_LEFT: {
        ...
        actions->ms.map =3D map;
        top =3D pstack__peek(browser->pstack);
        ...
        continue;
}

This assigns the raw map pointer without claiming a reference via map__get(=
).

When the loop continues, the top of the loop unconditionally executes
free_popup_actions(actions, MAX_OPTIONS) to clean up the array. Since the
struct now embeds a map_symbol, this calls map_symbol__exit() which will
execute map__zput() on the un-refcounted map.

Could this unbalanced put prematurely free the map while it is still
referenced elsewhere?

>  			} else if (top =3D=3D &browser->hists->socket_filter) {
>  				do_zoom_socket(browser, actions);
>  			}
[ ... ]
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 02505222d8c2d..deb92c27f7abf 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
[ ... ]
> @@ -982,24 +982,40 @@ void symbol__calc_percent(struct symbol *sym, struc=
t evsel *evsel)
>  	annotation__calc_percent(notes, evsel, symbol__size(sym));
>  }
> =20
> -int thread__get_arch(struct thread *thread, const struct arch **parch)
> +
> +
> +int map_symbol__get_arch(struct map_symbol *ms, const struct arch **parc=
h)
>  {
>  	const struct arch *arch;
> -	struct machine *machine;
> -	uint32_t e_flags;
> -	uint16_t e_machine;
> +	struct machine *machine =3D NULL;
> +	struct map *map =3D ms->map;
> +	struct dso *dso =3D map ? map__dso(map) : NULL;
> +	uint32_t e_flags =3D 0;
> +	uint16_t e_machine =3D EM_NONE;
> =20
> -	if (!thread) {
> -		*parch =3D NULL;
> -		return -1;
> +	const char *cpuid =3D NULL;
> +
> +	if (ms->thread) {
> +		machine =3D maps__machine(thread__maps(ms->thread));
> +		e_machine =3D thread__e_machine(ms->thread, machine, &e_flags);
> +		if (machine && machine->env)
> +			cpuid =3D machine->env->cpuid;
> +	} else if (dso) {
> +		struct maps *kmaps =3D map ? map__kmaps(map) : NULL;

[Severity: High]
Does this call to map__kmaps() verify if the map is actually a kernel map
first?

If map__kmaps() is invoked on a user-space map, it forcefully prints an
internal error and returns NULL. Since perf annotate might process many
user-space symbols, could this result in continuous console spam that
obscures real output and breaks the TUI layout?

Should this check dso__kernel(dso) before attempting to extract the kernel
maps structure?

> +		struct machine *kmap_machine =3D kmaps ? maps__machine(kmaps) : NULL;
> +
> +		e_machine =3D dso__e_machine(dso, kmap_machine, &e_flags);
> +		if (kmap_machine && kmap_machine->env)
> +			cpuid =3D kmap_machine->env->cpuid;
>  	}
> =20
> -	machine =3D maps__machine(thread__maps(thread));
> -	e_machine =3D thread__e_machine(thread, machine, &e_flags);
> -	arch =3D arch__find(e_machine, e_flags, machine->env ? machine->env->cp=
uid : NULL);
> +	if (e_machine =3D=3D EM_NONE)
> +		e_machine =3D thread__e_machine(NULL, NULL, &e_flags);
> +
> +	arch =3D arch__find(e_machine, e_flags, cpuid);
>  	if (arch =3D=3D NULL) {
>  		pr_err("%s: unsupported arch %d\n", __func__, e_machine);
> -		return errno;
> +		return errno ? errno : -ENOTSUP;

[Severity: Medium]
Is returning a negative POSIX error code (-ENOTSUP) expected by the caller?

The caller symbol__strerror_disassemble() seems to expect POSIX system error
codes to be passed as positive integers to correctly translate them with
str_error_r(). It uses negative integers exclusively for custom
SYMBOL_ANNOTATE_ERRNO__* constants.

If we return -95 here, does the switch statement in the error formatter
default to printing an invalid error code message instead of the real
unsupported architecture error?

>  	}
>  	if (parch)
>  		*parch =3D arch;
[ ... ]
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 5ad537fea4360..b4903f351bac0 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
[ ... ]
> @@ -411,9 +411,22 @@ int symbol__disassemble_capstone(const char *filenam=
e, struct symbol *sym,
>  	    !strcmp(args->options->disassembler_style, "att"))
>  		disassembler_style =3D true;
> =20
> -	e_machine =3D thread__e_machine_endian(args->ms->thread,
> -					     /*machine=3D*/NULL,
> -					     /*e_flags=3D*/NULL, &is_big_endian);
> +	if (args->ms->thread) {
> +		e_machine =3D thread__e_machine_endian(args->ms->thread,
> +						     /*machine=3D*/NULL,
> +						     /*e_flags=3D*/NULL, &is_big_endian);
> +	} else if (dso) {
> +		struct maps *kmaps =3D map ? map__kmaps(map) : NULL;

[Severity: High]
Similarly to map_symbol__get_arch(), does this unconditionally invoke
map__kmaps() on what could be a user-space map, triggering the same console
spam issue?

> +		struct machine *kmap_machine =3D kmaps ? maps__machine(kmaps) : NULL;
> +
> +		e_machine =3D dso__e_machine_endian(dso, kmap_machine, /*e_flags=3D*/N=
ULL,
> +						  &is_big_endian);
> +	}
[ ... ]
> @@ -526,9 +539,22 @@ int symbol__disassemble_capstone_powerpc(const char =
*filename __maybe_unused,
>  	    !strcmp(args->options->disassembler_style, "att"))
>  		disassembler_style =3D true;
> =20
> -	e_machine =3D thread__e_machine_endian(args->ms->thread,
> -					     /*machine=3D*/NULL,
> -					     /*e_flags=3D*/NULL, &is_big_endian);
> +	if (args->ms->thread) {
> +		e_machine =3D thread__e_machine_endian(args->ms->thread,
> +						     /*machine=3D*/NULL,
> +						     /*e_flags=3D*/NULL, &is_big_endian);
> +	} else if (dso) {
> +		struct maps *kmaps =3D map ? map__kmaps(map) : NULL;

[Severity: High]
Is the same dso__kernel(dso) check missing here as well?

> +		struct machine *kmap_machine =3D kmaps ? maps__machine(kmaps) : NULL;
> +
> +		e_machine =3D dso__e_machine_endian(dso, kmap_machine, /*e_flags=3D*/N=
ULL,
> +						  &is_big_endian);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716072351.5603=
11-1-irogers@google.com?part=3D10
