Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD0489892
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872611; cv=pass; b=KS66US6lvAOaAlq/7bpAVLNuQSFD6onIawRQSgtbybTMNIyYIMf+zFESoKW00Wp+V7t00yfwMFc/lHm0te+EZDJuJGAXea+BsEHtePif37mik8sDAcw0IXmK4tcQsLbN5nDZP1jWqxhxd/ZNxrmEM1wljH3N8ppCKMZDORnC9Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872611; c=relaxed/simple;
	bh=kKsv/L/7XImJi9cQhEQ3QJQ5spSt4fA6qgz8y7mhmv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ainqTj369xzvXIvtPDN2H2X3BAniCtlpp3yfZBhoD+5Sl5pJsa4HgPWzCgamPwwanNKKnrE1IQt/ZWxLWgrJwlS913RA45x5ffwknHfeu49sZnpaqFpeEDRZnwel2kiMonTx3kLS4Xzuu3Imcac2NrRY7gnCCgAmUodQlIVPwLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Snhjsg4l; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Snhjsg4l"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5337c7b9937so409351cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 09:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790872609; cv=none;
        d=google.com; s=arc-20260327;
        b=lwyMmmgeINiSbD5VkBdTEpWEnyvOyTyXMIgvcbmtF7o2ED1DIgdHYNaAbA/5ifJIZY
         JtflcOS0APWgwakyaUv3ObbAVGPvvV659M2iJugAwVJCuUkBVvl+6L7mI6cNxisBLFH3
         z41qWDXgyHLab+6pXWmb5qFSjbzn9T9GRakbXmwWOJ8fgo5nn7GOnW6afF40C9uVVLzV
         znxO8oSlRUGpsQsrEP9/O5ZgfReEZpO/8CpZdIaSWat3pcNhUbsRoqAvO1J3AGWIAaBH
         u6k203jAHiMpkD1yuPBUuZGnjRTLJ9nC0bAAj5Fq1LbKYKKK6JUrSJdfOxEfBScHKTQF
         to2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=leni7uoQNi24uZIsWMCtaU+tRF5UodmR1qKmfZe45iw=;
        fh=cJRXX+hqI6k9yO2H6pvx9dLZb5W+oo4XGLe3gx2LdA0=;
        b=ikcJa+tmQWGTiLklC59FaWTIxu/NKpDrcMGsz4QxdWdqzA8XDQXe9UG2kZmT9TbdVY
         c/0hiMP06anQ4lXU9yk5vUPG1pCwpND/IAAloI5snb5wjISnxEaOG+XZJCxtYITGjXE+
         jYyCud7ROVEdeemYgT7jhBlsjQiq8E5LETEF1uGQTHr28FxkubbvCe3jEVxuH6YRi5hc
         PNP0MLlxSvIJrPuE4Rn8VjoDaWf8F/fKYgy0VC6q1VrlX3AQwX+oBAk3FSH6l0+D+/2d
         y3Gk4rWfRydK5voS9tWLEnxuqcU9WU89blBeFjE0YT/2h8tMhyl8chvQH1nDSEP/FFYN
         Zflg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790872609; x=1791477409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=leni7uoQNi24uZIsWMCtaU+tRF5UodmR1qKmfZe45iw=;
        b=Snhjsg4ltdXg9AoSypx1MDEZSpyc63Xq3WVFt0SA+eGoU6qP6bfMYXzHn6LCj9kFvC
         QLReAX/XP0j0fmlvF7kkW499I34n8QnOC+zmFflRGMV2uEqCk16thYgsVTP1cFmCO/XF
         xmPf/hmZhOm6sEsAAiQMU9wbAddQ49yLYy+veXpeKq/V4KhSrI1hcV06P6J0JCxtLUhn
         4C2PsfadGByFOEGlAAfXxpl2AoEx16t2x5mJ4+p3zF548vrSmK5zWSvOhmYXvyhHKeqS
         bWLwDIXwwhUZIIiVRhGrgb8a6szuisvS8BiNcAPQQGfMKNHi1krs0WDzPJlpVDr8a39p
         o/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872609; x=1791477409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=leni7uoQNi24uZIsWMCtaU+tRF5UodmR1qKmfZe45iw=;
        b=hCCIQmlG+A8pMUFUL0e0s16rXsXrqk0H+KqYjr5IBT4jxq2TSunLV77MEi+pjbKtap
         hC/EbAvn+9fFi9EZhv0ZRq6JFOp6SGayPz6SF7j6dZf4nL2oENvjsqo9g+9rlacFtnyA
         00XUC/mbfF/OmzwgGXiKoxDNllTAWlUheLWx2ZQf56WpWI39Bsz/vRRfFTtPLO/GwS6v
         yEUlgfjgudOIbX0nbuF+kEsk3wuzVzF/+mliTHlzkBh5C7HEKkpeedrn8LHtfSDKoU+Q
         l/4zw350JJK/5za2Of3dGs/mOzvR1a0SQkudkDL/dwGbkAFMK1SU3fBvsGtvXmoaXFGV
         wooA==
X-Forwarded-Encrypted: i=1; AKwUvBy02XI1xToZsDOAG4YIM4Kf8Wy88n8sXb/fI7qzvjAAkiStFc8mJWc81HMHA8iTnX9gVIby71HZIoeieV633RT3@vger.kernel.org
X-Gm-Message-State: AFuF++kJCOFnov0F+pNdrwU0KYjtW7CCZYvJNtNqcOAr5cjRYgK8xeSx
	7T6bEj3N8azf7/YeSHYSOlO7lkJoSeiyg8jaWetxnL5RS9/AVpVY8G1oB6BCVTbe3Dw7HI7asSL
	0c0toKXgrDaXvmkWrJn8tF8ZT3uXK9Vn+TSdeMhA7
X-Gm-Gg: AYBFou0GnDZvVlF2oPyzv8vAua3DBSW/+dJWyHu2SCDJIZC8Hy3wFLI1u+vj3JSQE02
	Y2wcDwrc8a+YITtH54r/mEQUlivPYQ1i+VSqBiZgzydyLtga08heoh5HLXIFSzGtK2f9iMQRP1L
	HORCbSYg0ocsoKqaRNYnMlcbAUXrvHfkwZVpQDD84JxgxqoKeIPym+bZ3YlbhWZ0agF0fsPlJVB
	RinAsNI6+l/cCzME4HOEiyxuw9mmm/iOc7BzpByk/sDwihXeF7neCuSEi73TS9u1IUuyQrrBl5m
	lG2NnUYjdw0wQtfJRXU1RrIQzQQFPUVqctqPNhF9E6GZDkXaG9rD5w==
X-Received: by 2002:ac8:5fce:0:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-533892020d3mr13545121cf.9.1790872607892; Thu, 01 Oct 2026
 09:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-16-irogers@google.com> <ar5_pbVm1WYiq8Bg@x2>
In-Reply-To: <ar5_pbVm1WYiq8Bg@x2>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Oct 2026 09:36:36 -0700
X-Gm-Features: AclHuK_DFBCaFEauM_JRCveg75vwAb47yXfKyEr3-KyQDhRVzy2DjGyn1sndr6I
Message-ID: <CAP-5=fVtMaVM5PEoxKR4CF8BqYzKiaS4M9zpyEHyjQPPqhHDHg@mail.gmail.com>
Subject: Re: [PATCH v6 15/26] perf trace: Filter the target's tasks in BPF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 8:43=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, Sep 28, 2026 at 11:25:54AM -0700, Ian Rogers wrote:
> > +static bool task_traced(void)
> > +{
> > +     u64 pid_tgid =3D bpf_get_current_pid_tgid();
> > +     pid_t pid =3D uses_tgid ? pid_tgid >> 32 : (pid_t)pid_tgid;
> > +     bool *traced;
> > +
> > +     if (!has_pids_to_trace)
> > +             return true;
> > +
>
> I didn't look at the generated code, some optimization may well make the
> bpf_get_current_pif_tgid() to be executed only if has_pids_to_trace is
> !NULL, otherwise it would be better to move that to after the test.
>
> I'm applying it anyway, just caught my attention while applying.

Agreed, that's an inefficiency and the compiler likely won't optimize
it. I'll send a fix.

Thanks,
Ian

> - Arnaldo
>
> > +     traced =3D bpf_map_lookup_elem(&pids_to_trace, &pid);
> > +     return traced && *traced;
> > +}
