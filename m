Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4625486E;
	Wed,  5 Mar 2025 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203846; cv=none; b=XqA87YcPntP+ZwJ09SpFgjmitkYCbFiT0W9zinS9eqjcXLxYlYtkFVY9/JpZtU7l/i7H6Hf+Gb0t6WJJ6gLTCJISPICOzZfJpHs0yMLwL3jsfjTSHrGjp9y5pcQTE3Iem7UimbA3KrDJUi5Dco8WoeD5AJULToxvdqZTLqCTiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203846; c=relaxed/simple;
	bh=iuMAshD4bk3c1DXvxZqphmHEvfIZrLNQXSbR2588DH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwH8vY72k5Qhs3o3ZlJQJekyi0AGAfWIvod4poYqTOrTnatAy3U3JnQpIriy8TO7ipeXIwLUKgODrielxvSEZvN69AMb75UJ1NMBntKcuAnvqzqeKykJv/CAe9Q23pG3ZtBvqOWLsrYQW/lPfYNuEQEBgD15DtpZ0n3ytR3CSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTjB6yIw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTjB6yIw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22359001f1aso166879315ad.3;
        Wed, 05 Mar 2025 11:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203844; x=1741808644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCjogQfkKhbdMF0UGzixY7XrKAjTABD1okRnqIJZJIw=;
        b=DTjB6yIwEEJBclkmyOlq+leQlGBGXTRN5aQJFyOJZribDnfeLC76QWwZYZRw9meGaR
         jtJbw7vbGAtS3B/FQgNox/o0ilpeKx0N7j8upp95iMTzgqWWnVDbJukA9b/+nb/xFZZy
         ordpV3RIAwN3lF2sKejt4HczQiTQuqWTdDnp21PxriO/FvTV+VjMP2u6eiTmUDseEkXs
         lPTRg2g2Y+VxEcETf3qLAb7nLuvxbt3mONeQSZyTwZ+oZtZuaT+Dj1Tp/wBg+CtVbbNv
         Uao4jsLKNUhSpqaxmN0iUZ3t9YodJaJvjCqfaID6zht42Wi8asGTVe8Tgn1xZw+mMfSr
         hg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203844; x=1741808644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCjogQfkKhbdMF0UGzixY7XrKAjTABD1okRnqIJZJIw=;
        b=GGh90kp5p5G5SkP95KU8tudVAvOESRohnCei6MOh4ns9lD1/zb52avvDA0+ma2VTYN
         yLM5h2ydKutv/i4FVJZ5z840mh4LDlEcAwCyUd8Y0AH8sO+kf38SeRJB9xCYljE/He2n
         9kTzIyjtErRd9s/gZKRLf+QcDFq1Bv1vgLx/iXIhP5cKZoJW3lVCL3sARJOKf3ZDoItP
         GperbXU74CWKuXoPPDsudvutaxIi+J6ulRFfpjy24vzzKuP/DFlyuaFuUbeZLRaDNwnv
         ey5m3NcAwxzxsZjODNJhc0cqGa90x+SMabZLneIo8yzVQVsFjqfOhv7jqb8m6mvwo0I+
         Tduw==
X-Forwarded-Encrypted: i=1; AJvYcCUOcdlfs1NT8z+PgwkNiVISER++H+Fg/TmZo5fOSTC75PYAJPixX3hO/Oaf5DICAFngM2CdjWYg78FNaW/uVdHFlExD@vger.kernel.org, AJvYcCUfrA00+vo2isPbVH9hc5+ojgIQBoc4GgkEPLXMLwOw4cAHo1HnN81oxz/BF1jNsWjau+i86y/uN4XbfTE=@vger.kernel.org, AJvYcCWQAeXu/kb1tinnZ/akYi5R8u7kvO3Br8ECjmNSaluq4IGPrSeZtl/AaEouyQcx/+sjI9mRzlGXcjEbGpSBWoq2Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YztYtfL4D8PFU6owiNbAfzB0FTAC5jl8XW2OjhXlbuJ7WQsJibs
	MOLlbADisfTFRnKWAjqPQJuROTckr+rStuLOhvll4rlskT8DMBHz25vBs0sO861iob36Qs7MAVA
	Bb3nTowcMACWlL7TNHypBy0w4xTs=
X-Gm-Gg: ASbGnctysBlu/SLEZi3pkb754vuWeHBzBrJEJfsPkZA3BgUyE0cykzTeZDNHe53MvSi
	y80MYMgE/2x8GHlsApz2hGzuUxbZCTtU0qBftXD9w+L6mqbgs2GYD7q06+lCwRFI08UYhAfD3uy
	kwLwsllL7voN6gk8LOqaoZnI3W
X-Google-Smtp-Source: AGHT+IFdCDYj/agpQVhv3dAYVCWS6XsBw5aAFSnr2mfwdcK9Y4FN9aCNwjHl/acg8MGpJUB2P/zufNqUs3lMvnM53KY=
X-Received: by 2002:a05:6a00:21cc:b0:736:457b:9858 with SMTP id
 d2e1a72fcca58-73682b7405dmr6071779b3a.10.1741203844549; Wed, 05 Mar 2025
 11:44:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304154846.1937958-1-david@redhat.com> <20250305152055.GB28112@redhat.com>
In-Reply-To: <20250305152055.GB28112@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Mar 2025 11:43:52 -0800
X-Gm-Features: AQ5f1JrrjsXo3LTI9gnU7JfioqsYSvoLENxHqqnaxX48DOE6niZSlJc8m2hl6mM
Message-ID: <CAEf4BzbyFy0eQHLac3zR8GiGDOUqYoTGAWDbFaeou903OGOTpg@mail.gmail.com>
Subject: Re: [PATCH -next v1 0/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Tong Tiangen <tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 7:22=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 03/04, David Hildenbrand wrote:
> >
> > Currently, uprobe_write_opcode() implements COW-breaking manually, whic=
h is
> > really far from ideal.
>
> To say at least ;)
>
> David, thanks for doing this. I'll try to read 3/3 tomorrow, but I don't
> think I can really help. Let me repeat, this code was written many years
> ago, I forgot everything, and today my understanding of mm/ is very poor.
> But I'll try anyway.
>
> > Are there any uprobe tests / benchmarks that are worth running?
>
> All I know about uprobe tests is that bpf people run a lot of tests which
> use uprobes.
>
> Andrii, Jiri, what you advise?
>

We do have a bunch of tests within BPF selftests:

cd tools/testing/selftest/bpf && make -j$(nproc) && sudo ./test_progs -t up=
robe

I also built an uprobe-stress tool to validate uprobe optimizations I
was doing, this one is the most stand-alone thing to use for testing,
please consider checking that. You can find it at [0], and see also
[1] and [2] where  I was helping Peter to build it from sources, so
that might be useful for you as well, if you run into problems with
building. Running something like `sudo ./uprobe-stress -a10 -t5 -m5
-f3` would hammer on this quite a bit.

I'm just about to leave on a short vacation, so won't have time to go
over patches, but I plan to look at them when I'm back next week.

  [0] https://github.com/libbpf/libbpf-bootstrap/tree/uprobe-stress
  [1] https://lore.kernel.org/linux-trace-kernel/CAEf4BzZ+ygwfk8FKn5AS_Ny=
=3DigvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com/
  [2] https://lore.kernel.org/linux-trace-kernel/CAEf4BzZqKCR-EQz6LTi-YvFY4=
RnYb_NnQXtwgZCv6aUo7gjkHg@mail.gmail.com

> Oleg.
>
