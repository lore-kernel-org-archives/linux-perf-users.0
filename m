Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864633A9FF
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183278; cv=none; b=hnH+bQ8rzlwEpJRr4OhgoJH+mHIx29oDHlQJlFJDfnFD9Q2Na5zm6eErl4qvMPaeJTGszsx1xjRDN7GosVFCKVDdIETybr7ErZRsguvBgBZeibnw2b5LnR23cm79GE+WWmZLJAl0sTAEyKfPj3rkGXaGH8rLtweEHXSN1LV5c3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183278; c=relaxed/simple;
	bh=CzA7asvDyyyWAzbTflp87NF2A3i1IiQHLWrqCndBJEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rlI0JGg97CbkyLnzrm/9l0F4mcmLuAyEiUA/GvSZTHuINtbFLf/u9kO8BK6FA056eGCCjfHc6nwi50KICTgNF5+RA+qrV0wW+zd/ft17nJbVgfbHSLwhHkyaD/j15rdfaDBH9I2LsGllWUQhfGxiSGro9estgErEMGE6ZzWWIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6gI4plo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6gI4plo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02C91F000FF;
	Sat, 12 Sep 2026 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183274;
	bh=li/Htgl4YR5ZRIvRv0gLyAxm0xGfRbyPLDhJohTid5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L6gI4ploSW8j2AHnz6ScAHH7K7D9ZHcVvAH2qgNlVVfd7DCOyzSsbRQa4sH5I6Nhb
	 188Lu7belKRAUg+KBaC7TPDWBOeKlLgRJit60xhSwHuzDcHE3S/tJ+mbOLx6mi0RAf
	 1df4jFHShiJ8oR8nnoSQ6Vu51gekc8Y091I/4Fco0KMxXYWYVt8ZrEjiggAZo3kNzX
	 1MCGaCxuGYTWus6va3EszoGCD4p9/YNi594Iy9c0vQowepts0TUkY3mmNZXPwG4fPL
	 BDOHB6gHUJ3zxrvut6tuvnHHBxuGH5Gj5e+nMa9Q9j55yn6Tx4+C8jI7oF7hHVfObE
	 zrR93p5pJ2UUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf synthetic-events: Check schedstat domain
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912031112.1814574-3-sh_def@163.com>
References: <20260912031112.1814574-3-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:21:14 +0000
Message-Id: <20260912032114.A02C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free and double-free vulnerability in perf_event__synthe=
size_schedstat() when encountering unrecognized lines.
--

commit 6cad01b2d5eb6ff97735af9d1d5fd8e900c1d5a0
Author: Hui Su <sh_def@163.com>

perf synthetic-events: Check schedstat domain allocation failure

__synthesize_schedstat_domain() uses event after zalloc() without
checking for allocation failure, unlike __synthesize_schedstat_cpu().
perf_event__synthesize_schedstat() already treats a NULL event as an
error and cleans up, so return NULL when the allocation fails.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 0c150193cca83..24559691b88ee 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2776,6 +2776,8 @@ static union perf_event *__synthesize_schedstat_dom=
ain(struct io *io, __u16 vers
>  	size =3D sizeof(*ds);
>  	size =3D PERF_ALIGN(size, sizeof(u64));
>  	event =3D zalloc(size);
> +	if (!event)
> +		return NULL;
> =20
>  	ds =3D &event->schedstat_domain;
>  	ds->header.type =3D PERF_RECORD_SCHEDSTAT_DOMAIN;

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
in the caller perf_event__synthesize_schedstat().

If the loop in perf_event__synthesize_schedstat() encounters a line starting
with a character other than 'c' or 'd' (such as an unhandled trailing
newline or a new record type from a newer kernel):

tools/perf/util/synthetic-events.c:perf_event__synthesize_schedstat() {
...
        for (ch =3D io__get_char(&io); !io.eof; ch =3D io__get_char(&io)) {
                struct perf_cpu this_cpu;

                if (ch =3D=3D 'c') {
                        event =3D __synthesize_schedstat_cpu(&io, version,
                                                           &cpu, timestamp);
                } else if (ch =3D=3D 'd') {
                        event =3D __synthesize_schedstat_domain(&io, versio=
n,
                                                              cpu, timestam=
p);
                }
                if (!event)
                        goto out_free_line;
...
}

Does this check incorrectly assume the event pointer is NULL if an unrecogn=
ized
line is parsed?

Because the event pointer is freed at the end of the previous iteration but=
 not
reset to NULL, it retains a dangling pointer. The check if (!event) will pa=
ss,
leading the code to actively pass the stale pointer to the process() callba=
ck:

tools/perf/util/synthetic-events.c:perf_event__synthesize_schedstat() {
...
                if (process(tool, event, NULL, NULL) < 0) {
                        free(event);
                        goto out_free_line;
                }

                free(event);
        }
...
}

Could this trigger a use-after-free and a subsequent double-free?

Would it be safer to initialize the event pointer to NULL at the start of
each loop iteration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912031112.1814=
574-3-sh_def@163.com?part=3D1
