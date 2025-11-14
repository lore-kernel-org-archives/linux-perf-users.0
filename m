Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B98299AB5
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146173; cv=none; b=k5JUH3DXYHkV45mJ5jwOSy7IU42YD+i0yj4m6266yTAovbSWJfFaNmE4fyLm0h6j26tmRnCfAvRxKR2dgY0AcGAYN3sHzwxxSuLRH6tVY2JRipSJXOjPB+ITki8IwntwlqMmKUknhpex2d0GPwZCZyb/Pg9GX3iilSZiiJg5+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146173; c=relaxed/simple;
	bh=rz7j/UJDrxKMl9ZSMZkRQVVJppyfO9y7PO+WsuJt37w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTwLgmxZ7FRyzsczwBIW25ak1FIdEx4QHXLmTL9zmrZ1T86VTv5yROJMGZOUxvPmOyRmntC00F+Lgcho9As6WljPsvTUCeGOtlsj9gqCV2jXjeOUm7ZvltbD8VfKLIHy70EoWd+cPVVzlzF+VXZbFcsmpuvB2xsYXWuQzFebUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmtuPXN9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmtuPXN9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29852dafa7dso18895ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 10:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763146168; x=1763750968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TufH33LR1+FbRs5TTnZXWGBvkJzQgtKHJFV9C+DmjZs=;
        b=SmtuPXN9lT50bmplyfK+KKmC4YIptJhG9JQ4YT9SvprMWMdlCLlM2FKSCjFGrivQTy
         BRWeGcbMPAF2DEg8XyAQ/bctDrRCm7r1OoluNYVFbOv5oHCbxDLXoJD2R1fw02a9Lezk
         7miOM6qpOwA6xPqQG4E65l1nD8uQBvo9e53QqnixeFSik1fkQ/kH02SbR4a0PswptrPd
         9KYLRD9tQSO3jGCYFGKK/+QuaOWzD/GexNeSQevUxKHJzls9BH1NFq7zGR6Omw+hLkAH
         uvOm6igutCmYIC0yydHztE+cCF7zapjwqSgO7at1RadJgeO/iyreSn40ta8cWFeC22dO
         SGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146168; x=1763750968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TufH33LR1+FbRs5TTnZXWGBvkJzQgtKHJFV9C+DmjZs=;
        b=L5qNylCVefeZrgVaj2ZXhMq3oqwdC4UTwd/lgqOqwJggg1qj2dvEZLkrCOswuR0g/1
         96UgrlPP22Fgr7uId1XnOEJ7KHyfU6qWC31/K0F/unx8ba7fhf7cn9vBh43JPxKrCDgd
         c6/wQoC0XZbzPyqKVE7AczypgLXs8tv4b51J4PfXKBqyGTEMJFfkCqTOJI52YrvmCLq4
         x+uSd2pQm/HpYbHleH2uwFuF/d5tAtnnxSL/OfAicmlY2OcPGEP5ZYLtsmEhyeASdISZ
         wbTwVyw2vZEYv+CBOrwx3bjLmqYXguJvN+UGeiAq4Xto/GfiVGbLPuzNehskkxYAt3U4
         +Jow==
X-Forwarded-Encrypted: i=1; AJvYcCWrLXVpkvzoSCfCz+YxYzBsmw4VO8Sg9k7ZF5Uavr6N+VEgSHB2PY+4zzKbrITgvt3wBq2VO9wzZEliQFi0cv1D@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vkwbFK4kY5GP7G85PJ0nPdN8jNj8JubaczHByTl/hdmXb+7K
	1gBLuTbwgP0sxwDj9kOI0PN94xxpkTt4zrDb7MF0Z6j39RlKBJe2Wc/MwDa/OFMtTcPWVjWkkiw
	Zv6eVyLFglpRGpAKOH6+3IIKsW+6z8EhY5LY731kV
X-Gm-Gg: ASbGnctvl2k84z3KPW2QVxOomr6oBgqDSkgutH4MpTBmO1ZjjmVSpb+h2zME63R9Tcp
	C69CPFHlD0Zp1MpEfzYSCVd4UQryq8GIEeKaYs0zS+S5/bFM7vX2OldvvEk5bxhd53gYlU7mkjG
	Z5h+vykghYZyX/d9YeLEZl3RWu4BzJ9QdfDi/989RRqA1wZGpX/gsRMHAC7ME3RJXnoEv4CLhTK
	8HHoWOIZqusGjLC6usQVWcqDhl+bmD9aS77BL9J4PdTmN8XAwG85SCKP0ssY073eWKYE6DNSHjS
	qfRMoZqT4WIAtG9NVQuu10TqNza1tllBYl4=
X-Google-Smtp-Source: AGHT+IGgLMzFBg4dvat4vkWEc7+bSgPYzKPBYdw5lt+7F4/qZIFGnBSHgtP2NlwkFQJ5dDAQrZRX0fSaUJ3hA4n2Fk4=
X-Received: by 2002:a17:903:41c3:b0:295:1351:f63e with SMTP id
 d9443c01a7336-299c6b2473dmr179205ad.10.1763146167172; Fri, 14 Nov 2025
 10:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114070018.160330-1-namhyung@kernel.org> <20251114070018.160330-4-namhyung@kernel.org>
 <CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com>
 <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com> <20251114133009.7dd97625@gandalf.local.home>
In-Reply-To: <20251114133009.7dd97625@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 10:49:15 -0800
X-Gm-Features: AWmQ_blrNkkumPpA1qnlt2x-BsuC-2KXfWdvtWTL6qKsCtowllFahNliI9kmH3k
Message-ID: <CAP-5=fUF78K6TVnqa7gZoriTzymm1yjSY=jVuocZBn4t5aXS-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf record: Enable defer_callchain for user callchains
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:29=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Fri, 14 Nov 2025 10:09:26 -0800
> Ian Rogers <irogers@google.com> wrote:
>
> > Just to be clear. I don't think the behavior of using frame pointers
> > should change. Deferral has downsides, for example:
> >
> >   $ perf record -g -a sleep 1
>
> The biggest advantage of the deferred callstack is that there's much less
> duplication of data in the ring buffer. Especially when you have deep
> stacks and long system calls.

I've never had anybody raise this as a concern with fp stack traces,
especially given the stack snapshot approach being far more space
consuming - but okay.

> Now, if we have frame pointers enabled, we could possibly add a feature t=
o
> the deferred unwinder where it could try to do the deferred immediately a=
nd
> if it faults it then waits until going back to user space. This means tha=
t
> the frame pointer version should work (unless the user space stack was
> swapped out).
>
> >
> > Without deferral kernel stack traces will contain both kernel and user
> > traces. With deferral the user stack trace is only generated when the
> > system call returns and so there is a chance for kernel stack traces
> > to be missing their user part. An obvious behavioral change. I think
> > for what you are doing here we can have an option something like:
> >
> >   $ perf record --call-graph fp-deferred -a sleep 1
>
> I would be OK with this but I would prefer a much shorter name. Adding 20
> characters to the command line will likely keep people from using it.

Fwiw, with buildid-mmap we just (v6.18) flipped the default when the
kernel has the feature to use it. The kernel feature was added in
v5.12.
https://lore.kernel.org/r/20250724163302.596743-9-irogers@google.com
I don't oppose a shorter name, callchain option, .. Unfortunately with
`perf record` -d is taken for saying record data mmaps, -D is taken
for a start-up delay option, and -G is a cgroup option. Perhaps '-f'
for "frame" and have it mirror '-g' except that deferred is default
true rather than false.

Thanks,
Ian

> -- Steve
