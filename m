Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873164438B
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617354; cv=none; b=p496D9eNdFMRXPnrEJgLyYXqC1Aux7U1mx5FFE+4J7InJS0QddJ8BO/SLQIqfEddI4jYAps5yu+SL3DHfJtZGBBP7TIiGF4Tlu/TX7EWdh5MBJ3bZckarqlpsFEP1yQk/q68KuI/odeg6OEro2jfjeMZntzgbXDtBpqqB4Xz3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617354; c=relaxed/simple;
	bh=z2ipP4my5QnyVNvAfHRwu9o0oRXT4HEUJ/+g6IV1ubU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hf+uC72KSIYN9P31ZLSkqrY7XU1QTRzSqoTQK9E6vtsjLXrFrAiw2b42iMFVRFy0Y8MlC+32vZgNstSO21h1gokSzbBt0ufIabYc8L8wC3TzBvqbXMlkx1lmlMvpYu6nYyrwqVXn47q/PnTUL78xMW+MaMTrUEDE/uN/DLT2hOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FnzOozB0; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnzOozB0"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso12055ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729617351; x=1730222151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaXzMvAYvUxlUCWeHAnHy7Ln3CXIQTuXNPgjIoy8xAk=;
        b=FnzOozB01z9Qpepj9QiuDDEkO3Jhb82YPgMQGWpL1pmJ6f0vf0ZzqO90N9v0vkrVbR
         glyHUEiRfYRZWSEEEV7k1EA4PUEr5DLhtuxNmLghKMaWkiNBwIJ/pBNv6kskteBeLVCF
         21so9r4O7UNZyzYuPCfi9efNO4cUVFVtFD9YUULwMD3ofq7b4dk6Q6UekJGxVQAyr8Xk
         uqeDLgmVKED3+i97lCATOlvcwdPlIpaI/zmXsG8POEuamdsnVXSFC87pgGt2lR8YuFlt
         cXzplSjc9JnUYNT7Ez4+eR5L+xSdAEiVtcD41LS1Zssf8y+wGppuUGguKqwCNG/3pJrj
         gUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617351; x=1730222151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaXzMvAYvUxlUCWeHAnHy7Ln3CXIQTuXNPgjIoy8xAk=;
        b=PFDgXECoesrQX6LjjMCaKmKauVeoJrYlIxJbhu3+T2lKJGHKxew9LyUktH1a9bU9/+
         NMBaj/zUmxCoydKQpN7nRCP+WZNyHxFXz60uYbz7IbWaa5dv8OmAMiYF8dxuUjthjgv/
         zaWmCQZaPC8Z+WiLvH9u83Iun81F8axCYPCE9Pw6kXtTlWXVux/j+M6m77O6j3a5avaL
         9Zc306goEcbjTTLuqJ1oKLJ5F05hqbBw1pidUG/ywCVL+zz7ZprHCO6/H6oJx8shp9/5
         wgC7aZr8zZC7WHiCEckxcCQdrOzlmCH9pcYk3wVIulEArLkjUTCHXXedWL4qizDjn/mY
         dq1g==
X-Forwarded-Encrypted: i=1; AJvYcCUNIeTQn+hBaJ/ZyDDOjm8m/hIU+0hRQc+Vrb/DtrBcM1utzrMHjsxIfyiy4MlRA5MnYZKMMdEGcCbMBtTj88PY@vger.kernel.org
X-Gm-Message-State: AOJu0YzBphyyHwFgr4lzS42YObW4WyMNkxvgZ0RyY0Nb8ZvtURGVVxnK
	NL4rnzAq+ktmUIuumgwSud7PfnsfKEo4Jxt6iGjtHMR9I6n/kWr4iTn/WeqidGIuWF2m9xGpIcq
	iiHzTrFatl9BA/miCG0mZ4Te+8AGHsLX1n5Xq
X-Google-Smtp-Source: AGHT+IEVy5VyzazC8qQI5OZ8jkSTr1uF7DIcZre/POs3/p26eCu/ktnn4YnUyuyzRspoVg/9iqbEOoec2ztXipcoSMk=
X-Received: by 2002:a05:6e02:1381:b0:3a0:9b7c:7885 with SMTP id
 e9e14a558f8ab-3a4cca013f9mr5069435ab.22.1729617351393; Tue, 22 Oct 2024
 10:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com> <20241016042415.7552-14-irogers@google.com>
 <ZxdJyRpCv7dmmin9@google.com>
In-Reply-To: <ZxdJyRpCv7dmmin9@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Oct 2024 10:15:37 -0700
Message-ID: <CAP-5=fU7n6iumZuNaUcS7VjsG9uF3ib-mP_6cvUGExKaY-CNQw@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] perf bench: Remove reference to cmd_inject
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Oct 15, 2024 at 09:24:12PM -0700, Ian Rogers wrote:
> > Avoid `perf bench internals inject-build-id` referencing the
> > cmd_inject sub-command that requires perf-bench to backward reference
> > internals of builtins. Replace the reference to cmd_inject with a call
> > to main. To avoid python.c needing to link with something providing
> > main, drop the libperf-bench library from the python shared object.
>
> Looks like a clever trick!  But I guess by removing libperf-bench from
> the python object, you can remove the reference to cmd_inject, right?

So this change is looking to clean up cmd_inject yes, an alternative
thing to do is to remove libperf-bench.a as a python dependency but
that would use an unused stub. I'm looking to remove all the stubs.
Once you start cleaning up the cmd_inject stub then you get where this
patch is.

Wrt cmd_inject have 4 choices:
1) status quo - have libperf-bench.a be depended on by builtin-bench
but have a cycle where libperf-bench.a depends on builtin-inject. This
can yield build issues I've wrestled with in the past and in general
this shouldn't be done.
2) this patch - have a dependency from libperf-bench.a to main in
perf.c, which is less of an internal dependency on the perf.c/builtin
code but is still an annoying cycle. It's not much better than (1) but
at least it shouldn't require a #include "../builtin.h" which is
obviously bad. That #include isn't in the bench code as it re-declares
the function, again bad. The patch here declares main which isn't
great, but at least the declaration of main should not be subject to
change whereas the builtins could be.
3) move perf inject into util or some other 3rd library. Out of scope
for this change, but also not something I think we want.
4) have `perf bench internals inject-build-id` fork/exec the perf
command. My preference but out of scope here.

So I went with 2 to improve things but without doing some larger
rewrite. The cleanups all relate to removing cyclic dependencies to
cmd_inject hence 1 patch.

Thanks,
Ian
