Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231671E130F
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346446; cv=none; b=XjQcJ9jKLwo/t0dAHu/Y/jj9H2dvUbjSW6gfeBhIZJMqQdgWVtH1mb6w9vPWDEoVij2WN+fPXf1QTfwVWY4x42O9GXbifVemUuPWbexEEtOSYoVYczzx9IQhOl0fKpHQl1zpBXroKV0aCgexZ95gCBxPLBZir8ugM3ZTbXWsUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346446; c=relaxed/simple;
	bh=aD3jXyKBXU31pvp9Myc8+fQsx0JMT3JspeZvV/Lksic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCL05TGsMAkAGzQFzdSWE36So6Kv2y0m0mVUOS4WI9x+L759FgMS95FhxqknrftD0x1F70s2x+Tuylv5jxJ2+R5xCSI2vur/iQxSQqhANHNovZ4uL89pXTwkOBWERLbL0qrAJ/Jx0filGfNj/WRa4aozaiUNvRF4zF6LVE19YKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3VA+1h1u; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3VA+1h1u"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24cf5bcfb60so310795ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757346444; x=1757951244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aD3jXyKBXU31pvp9Myc8+fQsx0JMT3JspeZvV/Lksic=;
        b=3VA+1h1u48x4GSyq+AB8yklE9D/SS9FjjY0021pziiBvZVbAv5dvXLDtA/5unGV3/e
         Y7bSbe9ByQfGxyIX1AXTa3wrZxEHYplggzswiTJjvoNXhOJIpBDDcTuqNNOkJ6fAK4N5
         ReeRM7c2DcTtm57Ue0ydXdVhbyn4E8idpWeUsPr8cCwerLZrDZnY3ckmBSvpF1v2MaNE
         1VBQ8fgZCuTM0WCVqmcBQe+3uLJJMU+frgLEtcy5Xb6AAzOqC2Grkq8qsoQ2YLlxDzgx
         SnC0oOzF1WHVEbtK32Y3/RqiRuvtEX4rKXnNjFVa/Bx5kg9cyMt1C22u3zJOl0oTfvxO
         pSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346444; x=1757951244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aD3jXyKBXU31pvp9Myc8+fQsx0JMT3JspeZvV/Lksic=;
        b=L0P/VSf15s16JaHka5VxU7V/2+/EIPO5SAQQMk8P5BBqTzalpGD/rd0Y+Li8OMceCG
         /+562WGeSe2BmK9C46PHmnbTcFLu9whJsyR78ZZQ+n0nVH4WyZ+fn79pB55/rNTlRVFI
         ydqbRIlvFI59Ol4LY1qB4Nq97N//YyTfMsMIAqxTtuRleNbhxg4eN7aGNv7MiSZj8quY
         k77LLsVGEo84RN8mgGZV0ULSs3lyg24f09Z+wJlh59zDkR1KcT7rGM46hc8A0mOWyLVM
         UvYQwe4ZJgUGo/AALkijoMMCU79b09vQjRKiA703avkFu8iMM1ybqEHS6plmJDbNm353
         9g8A==
X-Forwarded-Encrypted: i=1; AJvYcCXf5geaiwWR8Ov0Wbun66gg87J8ac/exe3FZBBQVvvGPqByWO7NSp76vQjLNzT94845xjG+0iEB0BUiDIv5UiFx@vger.kernel.org
X-Gm-Message-State: AOJu0YxAKv799DJw+0bXxL1FwL6rex1y9tI1TWXv1FoOPsZH4/+omwcX
	FHfVH5kdPyA2DDACot6kcGqfpyCeQ7muF9G9iowPTB83zu7z2Ma1IXbMiQEGHMUTvHvaa4ZPu45
	uQ1xsNXDym6UeE7kJXpz3mzbeaDqWY7O9x0RdX/cL
X-Gm-Gg: ASbGncugITZnu0Ii1hsmdOMl4EXieY8J1XXFPTD8NOU2tpXmlvnnRRIEnBpEnHCP6mg
	5y0izlumN55XQ3XGPIyQ4VhbrD0CC82ztZ4KuN0QZ7gWIHygOXQPo1czcu53eQ11OXMkCofD0lS
	+MJmDoBCOkOVagPe3CQVbLIaqdsqxb3LqFA4CZ5GnUtN5LqZ7uakVb6+HFOcPIGkZ+vSUmjM5HH
	gGNq/4KEPI5EQ4k+Rx1A2WZOsmwmFeJdaX7bH3dasNjLjvOk3TYb/w=
X-Google-Smtp-Source: AGHT+IFRB2Zi7H8bLl4KDdTB4pTqHhLqyIcs4LqKCoPEIDGJ6guPwolnD8VdcorGTXxQsBy9SD4HG0t62zOwUJZKRhg=
X-Received: by 2002:a17:902:c403:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-2511937bce8mr7909045ad.8.1757346444046; Mon, 08 Sep 2025
 08:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
 <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
 <70bd9eea-905a-4fa9-8265-f84ab9894b12@linaro.org> <2b958dec-7ba9-41a3-b11b-43b5e8418849@codeweavers.com>
 <549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org> <CAP-5=fXKthsZe3J4_UHHGwDafBq7pHzM18Mh=_2QrnSfCT3nOg@mail.gmail.com>
 <3db2d6af-3b21-4ce2-be1f-668270adbbeb@codeweavers.com>
In-Reply-To: <3db2d6af-3b21-4ce2-be1f-668270adbbeb@codeweavers.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Sep 2025 08:47:12 -0700
X-Gm-Features: Ac12FXx_k9AygYv7PTRqriXBaFYgUElhJVmWC1X25XbrTF3SCiUFkzquGcpd8G4
Message-ID: <CAP-5=fX33kGxfHzqVGzusMBiHJM6G75TbLyZazjp37yohwscGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: Brendan McGrath <bmcgrath@codeweavers.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, =?UTF-8?B?UsOpbWkgQmVybm9u?= <rbernon@codeweavers.com>, 
	Sam James <sam@gentoo.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:24=E2=80=AFAM Brendan McGrath <bmcgrath@codeweaver=
s.com> wrote:
> Just wanted to let you know that I've been able to put together a PoC
> that does just this. It allows the pe-file-parsing test to pass using
> LLVM in place of libbfd.
>
> If there's interest, I would be happy to try to shape this in to
> something that can be accepted upstream.

IMO that'd be great! In this series:
https://lore.kernel.org/lkml/20250823003216.733941-1-irogers@google.com/
I wanted to pull apart the disasm vs the srcline vs .. uses of
libraries like llvm, capstone, let's delete libbfd, objdump, etc. The
idea being to have the API defined somewhere like disasm.h and then
based on compile time and runtime options select which implementation
to use. Things have evolved in perf, with a lot of stuff just globbed
into places like symbol without clear separation of APIs. Separating
things by library used allows reuse of things like library handles.

That series has 2 issues I'm aware of:
1) the last 6 patches remove libbfd support (rather than refactor) and
some people may care. I suspect with your fix it could be down to ~1
person caring. I removed rather than refactored as there is a very
real risk that when you do refactor you break, and as this stuff is
next to always disabled then it's easy for regressions to creep in at
which point that ~1 person would probably complain. I'd much rather we
had a good solution that everyone was working toward having work well,
your patches would pull in this direction :-)

2) Namhyung didn't like that I'd reversed the struct definitions for
the the capstone/LLVM APIs using pahole and would prefer that the
definitions came from capstone.h/llvm.h. My reasons for not doing that
are:
2.1) if you have say capstone.h or llvm.h then why not just link
against the library? But doing that avoids the decoupling the patch
series is trying to set up. We'd need more build options, which option
to make the default, etc. which is kind of messy.
2.2) to support that you'd need to bring back a "what if no
capstone.h/llvm.h" option in the code, I'd wanted that to be the
dlopen/dlsym case which must already handle libcapstone.so or
libLLVM.so being missing. Supporting the "no anything" option brings
with it a lot of ifdef-ery I was hoping to avoid and it would again be
one of those seldom used and often broken build options (like symbol
minimal (no libelf) today).
2.3) in my build environment (bazel) depending on headers means
linking against the library and the global initializers mean that even
though no code (in say libLLVM) is directly used you can't strip out
the library again. I'd need to rework my build environment to try to
get the headers without the library and that'd be a larger undertaking
than the reverse engineering of the structs using pahole (as is
already done in the series). So changing the patches would mean
creating a patch series that I'd need to then do more work on to have
work in my build environment, and I'm not sure things are any better
by doing that. pahole was my compromise to just sidestep all of this
without copy-pasting from header files and introducing licensing
issues.

Anyway, what does this mean to fixing PE executables in LLVM? Perhaps
the first 12 patches of:
https://lore.kernel.org/lkml/20250823003216.733941-1-irogers@google.com/
can land and then you put your changes into llvm.c there? We can
always clean up the issues of problem (2) above as later patches -
don't let perfect be the enemy of good. If libbfd must live-on then we
can move it to libbfd.c so that going through the generic source
doesn't mean wading through the libbfd code.

Anyway, I know I'm hijacking your fix to advance my own patch series.
I'm happy with your work landing independent of it, it just seemed we
could do the APIs more cleanly if both series landed together. I don't
object to (I'd also be positive for) just getting PE working without
my series. Isolating your code in the llvm.c in my series may make
things a bit easier for you. Having both series together would allow
the library decoupling, BPF JIT disassembly along with LLVM PE
support.

Namhyung/Arnaldo as the barriers to entry, could you comment?

Thanks,
Ian
