Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F73C09FF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673691; cv=none; b=u21DZ2+yuoNIa5gUpYBYH0SBxswZ/jJqEIs9HSCTzbKXVt+9PlX9fwIbIyiFf/IRoE1KBJ+9j+oiCxAXIc2vlAwe2QA2HSBEWVLDRIK88j9PgWSzZAg5Dnub4OAaxMsDxm6j8CmqnR9cm/4kYBpdu6FLMBnuh6X/Z5W/HvlJcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673691; c=relaxed/simple;
	bh=vdlTKw8Tj85CMlqeTCdSYnOsLLfT3m1PUmFpPHZ9mZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F6bNYeiY8xgKstMKVPZBrC9U27/l7KSMbwbng8q5iLZaC5scizU49jtVvQen5vXJ4f2zRgSNIXn04Kh3HlEH6vtZGhOa+BjvfFvdZHwo0VLCQPGPb0kA6n2w1a2VHwKkWdosEprjtsjc9wrMNsoMerHCpGEyukhid2kUDy9eZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4OcYMy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4OcYMy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16911F000E9;
	Fri, 10 Jul 2026 08:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673690;
	bh=St4ZvWyUZSwsXFbkXLWZBX/KFGD0S0zEPzD25+2im20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4OcYMy4xTpavpBE1AjagQItnp1tLA88acYdZ71YPctXkMnVdzBcRsm0mgU1J257e
	 TZzrOmyFwpg2j7slOkTJYWQb0uNnTGWuJ7MwxjFkjPM17yetDnQe5V5RSxGETDhyeq
	 KGvEplGLBTow9CCOzw8CGOc0reXCUay298DFkz/n/JjzQC1dmef/fcbiGQJPK/Rq5E
	 mgKzMQqnSH0QD4njJ0hsTcpzE3RbickNKeUkkKfIbOlw3PVGvzW/yPDAswSQhcvlW0
	 aWG9sUok77Hc9hxsE4/nJQC3YcIk2TKMwmrp1SiGxUCfimY+MiF4LvfFkgk3K2qqWa
	 aqBBe6UzFjDWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/14] perf c2c: extract shared data structures into
 c2c.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710084247.3576706-2-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260710084247.3576706-2-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:54:49 +0000
Message-Id: <20260710085449.F16911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing feature fallback stub for `perf_c2c__browse_cacheline`
- [Medium] Namespace pollution and type safety hazard with generically name=
d global functions
--

--- Patch [1]: [PATCH v2 01/14] perf c2c: extract shared data structures in=
to c2c.h ---
commit 2da5df0fe4f2a39ca1036332be2996007bdfe83a
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: extract shared data structures into c2c.h

Move c2c_hists, compute_stats, c2c_hist_entry, and perf_c2c structure
definitions from builtin-c2c.c into a new shared header c2c.h. This
allows the upcoming function view browser (c2c-function.c) to reuse these
types. Make the global perf_c2c instance 'c2c' non-static and export
perf_c2c__browse_cacheline() so they can be accessed from the new function
view module.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..33271554e354b 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
[ ... ]
> @@ -1928,7 +1816,7 @@ static struct c2c_dimension *dimensions[] =3D {
>  	NULL,
>  };
> =20
> -static void fmt_free(struct perf_hpp_fmt *fmt)
> +void fmt_free(struct perf_hpp_fmt *fmt)
>  {
>  	struct c2c_fmt *c2c_fmt;
> =20
> @@ -1936,7 +1824,7 @@ static void fmt_free(struct perf_hpp_fmt *fmt)
>  	free(c2c_fmt);
>  }

[Severity: Medium]
Since this function unconditionally casts perf_hpp_fmt to c2c_fmt, could
exporting it globally with such a generic name risk another subsystem
mistakenly calling it and causing heap corruption during the free() call?

Would it be safer to prefix it with c2c_?

> =20
> -static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> +bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)

[Severity: Medium]
Similarly, could exporting this generically named function without a
c2c_ prefix risk namespace collisions or type safety issues if misused
by other subsystems?

[ ... ]
> diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
> new file mode 100644
> index 0000000000000..5c3f6ae633ea8
> --- /dev/null
> +++ b/tools/perf/c2c.h
[ ... ]
> +void *c2c_he_zalloc(size_t size);
> +void fmt_free(struct perf_hpp_fmt *fmt);
> +bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
> +
> +#ifdef HAVE_SLANG_SUPPORT
> +int perf_c2c__browse_cacheline(struct hist_entry *he);
> +#endif

[Severity: Medium]
Does this declaration need an #else fallback stub (e.g. returning -ENOTSUPP)
for systems built without SLang support?

If upcoming consumers like c2c-function.c call perf_c2c__browse_cacheline()
unconditionally, missing the dummy inline stub might cause compilation
failures when the feature define is absent.

> +
> +#endif /* _PERF_C2C_H_ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710084247.3576=
706-1-jiebin.sun@intel.com?part=3D1
