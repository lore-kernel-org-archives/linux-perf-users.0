Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18F25776;
	Tue,  7 Apr 2026 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563728; cv=none; b=vFCClxAcsCFV9Ts39A5zNf2L4KCQYbRM/gClcKoHSeGyTTz8+l2IejmcqbkW8r71y5fNHlInDwSQyHWh2OQSwNK91/XtMceYuH/xsNfV0+vUlmMfNyrsJmRRBwt1epuhN4Og457Xr3R8/63bdJ4cEdGZO2Tl095cR00tVZ5Fw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563728; c=relaxed/simple;
	bh=r4CrN2dfvyMcTjw4pcJs5SrtdmOVDZyqLxzczWtx68g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOSfyG0MDAtPiwfEYx3B03jg94co0d8M37cQRDs7ueVJ4cfUDrrEJeZLBHjp7kYQkpFafjUeTwih2B2Z5VNaEqayE3A70CkK7wlEk7/mL3dkS02x/+jGPtQkMAPV67Lr/Z42jhUJ+9AQzwK4MXuQ/ef+F5E9kUBpaf58M97B68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzB+45Yv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzB+45Yv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9521C116C6;
	Tue,  7 Apr 2026 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775563728;
	bh=r4CrN2dfvyMcTjw4pcJs5SrtdmOVDZyqLxzczWtx68g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzB+45YvGxHOW+VJeu7y0wkP8NEqq90uj0tUIfozATz0JgMMp6oUAFNWd6JtHzXCC
	 fY5NVtkK5GtW43VtI1rtL2SIlMiRXhH/VtNgSZmUHJMqrnPx1z1jWctiJRa0iAn9lA
	 kYQV83PdHE5qLdxk+uU6mJy5tWY98whZlAqKcxPcOXLUtCtfZFSfcMddEYQ9VIPUZu
	 hNPJaeXknZR7Vk58YuPcwfQ1qLsUWyALJ1mLGVC5jEcOYH2R//kqazi/wbnFX86S5w
	 c43c1b5wDNxEmg6jPDOe0ZfT3C2twxsUyNzzUPG8COb7vxAHZOLdISBH5Awrt6gsPj
	 ALIw19IFlR2Lw==
Date: Tue, 7 Apr 2026 09:08:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 4/4] perf symbol: Add missing libgen.h include to get
 basename() prototype
Message-ID: <adTzzKCWES52egGl@x1>
References: <20260402001740.2220481-1-acme@kernel.org>
 <20260402001740.2220481-5-acme@kernel.org>
 <CAP-5=fVv=5H-6DOaAr4BSDE=pKrxWDa9oduYbVTozYc-ZeeuRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVv=5H-6DOaAr4BSDE=pKrxWDa9oduYbVTozYc-ZeeuRg@mail.gmail.com>

On Thu, Apr 02, 2026 at 08:19:24AM -0700, Ian Rogers wrote:
> On Wed, Apr 1, 2026 at 5:20 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > This works in some places because there are tricks to prefer a GNU
> > version instead of the XPG version, but started breaking in some musl
> > libc systems due to some unrelated change that made libgen.h stop being
> > included by chance.
> >
> > Since symbol.h is using basename(), make it include libgen.h.
> 
> Huh, this is being flagged by Sashiko:
> """
> Could this include cause segmentation faults by exposing the POSIX version
> of basename() to the rest of the tools?
> 
> According to the POSIX specification, if the input is an empty string
> or slashes, basename() can return a pointer to a statically allocated,
> read-only string literal (such as "." or "/").
> 
> In tools/perf/util/probe-event.c:convert_exec_to_group(), the code takes
> the return value of basename() and modifies it in-place:
>     ptr = basename(exec);
>     ...
>     for (ptr2 = ptr; *ptr2 != '\0'; ptr2++) {
>             if (!isalnum(*ptr2) && *ptr2 != '_')
>                     *ptr2 = '_';
>     }
> If a user provides an empty target or "/", the POSIX basename() would
> return a read-only string. When the loop attempts to write a null or
> underscore into it, wouldn't it trigger an immediate segmentation fault?
> 
> Is there a way we can safely duplicate the returned string before modifying it,
> or ensure the inputs never resolve to these static strings?
> """
> 
> The story of the two basename versions and the issues appears in the
> man pages. The whole thing makes me think we should avoid basename :-)

What sashiko pointed out is a problem in some other part of perf that is
unrelated to this patch and requires a separate fix, no?

I.e. tools/perf/util/probe-event.c already includes libgen.h since
581037151910126a ("perf probe: Add missing libgen.h header needed for
using basename()") from March, 2024.

In the scope of this patch the potential problem isn't possible as
__symbol__join_symfs() isn't changing the return of basename(), right?

⬢ [acme@toolbx perf-tools-next]$ git grep '\<basename(' tools/perf
tools/perf/builtin-daemon.c:    base = basename(basen);
tools/perf/scripts/python/exported-sql-viewer.py:               if short_name[0:7] == "[kernel" and os.path.basename(long_name) == "kcore":
tools/perf/util/annotate.c:             d_filename = basename(filename);
tools/perf/util/dsos.c:        * basename() may modify path buffer, so we must pass
tools/perf/util/dsos.c:          * basename() may return a pointer to internal
tools/perf/util/dsos.c:         base = strdup(basename(lname));
tools/perf/util/probe-event.c:  ptr1 = basename(exec_copy);
tools/perf/util/symbol.h:               base = basename(path_copy);
⬢ [acme@toolbx perf-tools-next]$

It seems just the probe-event.c case needs fixing.

And we also have this in tools/perf/util/srcline.c:

/* basename version that takes a const input string */
static const char *gnu_basename(const char *path)
{
        const char *base = strrchr(path, '/');

        return base ? base + 1 : path;
}

That probably could be reused to avoid these basename() oddities?

- Arnaldo
