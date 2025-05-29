Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187B3C8EB;
	Thu, 29 May 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502467; cv=none; b=JSl1rR82WSu2QyXVRsQmFeukbnzv1YhrX+ULRZqK6iPjpzTT23a9EHmzYUKfiE3VpMMfUjQRik5+rK4zSR3cZ7dm+hIi0TZ6yEtlW192Wt/swXJQB2FgeWzP5qyqs7fdT5lqX3td20C0hwTGM8tP6YouuVyU+ou2XUZX1k45hHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502467; c=relaxed/simple;
	bh=6cIekbriWiWKfaXCYAeZSta271blHf9u+hSq5kD2qLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLN3UIYj2X/wEXiD9JECw3WAUZQouXi5yPiQL+nZod9h4CaAnZ5LdUQ/di/zNqrAy7g0RCHHyv/yxuUbsnwS0cH9I7yEWve3Dl3A/qDj5ggqdOmYlDxOL8JLte7+BLA5Gs+vCCKBU2RmBVWZsuppbTpvc2F7ejKvoNZg0JjuBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlMYABlf; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlMYABlf"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e731a56e111so512898276.1;
        Thu, 29 May 2025 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748502464; x=1749107264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlzqSwcojgI0VbGKS+qdPoR/KI0f7D4BNFlWU3U/FlM=;
        b=SlMYABlfpapnzZbjZey7RE36bUXAZabI0IjJLr+em511CH/92x5uASEw15iYhIqDxK
         EGoC2keudxkKPWgyvA5D2YMuu9TqS93lDqlG5Nhau3J88srLsM3+5D0iYcwA19Uvi9pY
         8fucVTPRwtnewjHDRQb1e1pK/54QLqN1QgknnPY7RPsiQcAkdSRsTMjQYGJN94G78DxW
         ckfJQGDJW3nehYVD8iUsKbQ9yO4WvO0i/InE4xvNLeZtCE16uy13y+WTJ/jtY7oFjF8E
         lmEcqxQ5VKZ2wtqrQjLIPLwp3pjmuCffpsPFheYB6kh1oT7sjyjUyi/eBFhKhp/RtriC
         4U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748502464; x=1749107264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlzqSwcojgI0VbGKS+qdPoR/KI0f7D4BNFlWU3U/FlM=;
        b=eVk/BoplTAqaAXac7JOQ0RMOLH/vNghaTiot5XnDrovhGl4D+9bCe1YH+ou3+l6yxm
         YQG68MR9tGyX3OZvpn93elCowfujIE/iQmk/g8+OaOPSD/CYtomu8KHbgs2vFl4ttecR
         m6BBjFSF9fRDjbmgit7PdqKpsA39XEz23lRDEKjLDELx1O2q6yvPE9XgcN1QEo5Tib/l
         IikpwE4XHcP5FsEyq4NZoIYUjRiYNSJh+UBszviLMZmQ045GXBYAbdR42GQrhf7mgPua
         /0gcg+4IPXdMlUjZNGSicdpYnde9i9uI0yOH6nPO3Au0V5taQMfxFgS9qmUg5kQUfJ7d
         dGow==
X-Forwarded-Encrypted: i=1; AJvYcCVIiso0oMa6Lr9KFn2ApcwqiXE/0uQie9OT3oSFHjVZmKJSJsD2nkQnXMFHmP50BONPR8kTGdmG8aSgP/k/0P/Neg==@vger.kernel.org, AJvYcCXr40+sxf3HPl0FFmuJGWqjDgXomzEs/3IabxHy8W8WTOk2DxKpXTirzOuJ82GJvV2/RMsXCQ849znoJiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbZeY/WY1v4e2kNYZ8ToUQ+88h+bN4n04+RN5OxR/ZUvDlOI5
	fWnqOun9RlRDv4b6hqtwWv+IMTjTmbP3uXwEI+hmTxC9l3gR6EqZZhIxcCzlOGUJHB2LKC1j2mv
	kvpKJDIWuejMM+q8lJvZ8thgRHnfpjPQ=
X-Gm-Gg: ASbGncutmV1/IKr7niZQBGJ6c+eFLCECJcsR5YF47QqbwQPiWEAxtg9GuKNOl/Gxomc
	Yum07ZBwW7GERO4QL2h653NvabWYti9eHPWBcZmfIpr8I4ZVmOYWBBEQ+J7Bmswc1uhfoNi8507
	tcGVJKRmCdHYsdK8mmReZTJOGFGTheFac=
X-Google-Smtp-Source: AGHT+IF2PD3oFwH+ZQPkCKJgOxl/2YbUzJRnx7lBd7GlzLkTmHFvlM+948C0FNI4foXBprodmm3x9TjEwqB8K0rdeU0=
X-Received: by 2002:a05:6902:705:b0:e7d:9fa6:5fbd with SMTP id
 3f1490d57ef6-e7d9fa661d8mr21744381276.30.1748502463961; Thu, 29 May 2025
 00:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518190957.58932-1-howardchu95@gmail.com> <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
In-Reply-To: <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 29 May 2025 00:07:33 -0700
X-Gm-Features: AX0GCFs2lparwpsWTkYFeYSMnbmbNHDg-hi5m0VylnxpQl3BZQy3B72nVEkdAZU
Message-ID: <CAH0uvojyKi6tN2RfEsG25fn8G5G3iz+pWqjprm9qYaD_sA+i_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] perf test trace: Reduce test failures and make
 error messages verbose
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Sun, May 18, 2025 at 3:18=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sun, May 18, 2025 at 12:10=E2=80=AFPM Howard Chu <howardchu95@gmail.co=
m> wrote:
> >
> > Currently, BTF tests fail constantly, this series fixes two major reaso=
ns
> > why they fail, and makes the error messages acquired when using '-vv'
> > more verbose, so when they fail, one can easily diagnose the problem.
> >
> > Before:
> >     $ sudo /tmp/perf test enum -vv
> >     107: perf trace enum augmentation tests:
> >     107: perf trace enum augmentation tests                            =
  : Running
> >     --- start ---
> >     test child forked, pid 783533
> >     Checking if vmlinux exists
> >     Tracing syscall landlock_add_rule
> >     Tracing non-syscall tracepoint syscall
> >     ---- end(-1) ----
> >     107: perf trace enum augmentation tests                            =
  : FAILED!
> >
> > After:
> >     $ sudo /tmp/perf test enum -vv
> >     107: perf trace enum augmentation tests:
> >     107: perf trace enum augmentation tests                            =
  : Running
> >     --- start ---
> >     test child forked, pid 851658
> >     Checking if vmlinux exists
> >     Tracing syscall landlock_add_rule
> >     Tracing non-syscall tracepoint timer:hrtimer_setup,timer:hrtimer_st=
art
> >     [tracepoint failure] Failed to trace tracepoint timer:hrtimer_setup=
,timer:hrtimer_start, output:
> >     event syntax error: 'timer:hrtimer_setup,timer:hrtimer_start'
> >                          \___ unknown tracepoint
> >
> >     Error:  File /sys/kernel/tracing//events/timer/hrtimer_setup not fo=
und.
> >     Hint:   Perhaps this kernel misses some CONFIG_ setting to enable t=
his feature?.
> >
> >     Run 'perf list' for a list of valid events
> >
> >      Usage: perf trace [<options>] [<command>]
> >         or: perf trace [<options>] -- <command> [<options>]
> >         or: perf trace record [<options>] [<command>]
> >         or: perf trace record [<options>] -- <command> [<options>]
> >
> >         -e, --event <event>   event/syscall selector. use 'perf list' t=
o list available events---- end(-1) ----
> >     107: perf trace enum augmentation tests                            =
  : FAILED!
> >
> > Changes in v2:
> > - Add an extra newline after error messages
> > - Rename the title of patch 3 to 'Stop tracing hrtimer_setup...'
> > - Take the debug diff for explanation out of patch 5 to make it apply
> >   normally
> > - Add base-commit in this cover letter
>
> Thanks Howard! I did some testing but see failures that may be
> pre-existing issues:

Again, thank you for spending time testing this series! It has been
some time... But hopefully this: [1] along with the BTF test v3: [2]
can resolve the issues.

[1]: https://lore.kernel.org/linux-perf-users/20250529065537.529937-1-howar=
dchu95@gmail.com/T/#u
[2]: https://lore.kernel.org/linux-perf-users/20250528191148.89118-1-howard=
chu95@gmail.com/T/#t

Thanks,
Howard
