Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F372C87A
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Mar 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729979; cv=none; b=YAH640wXP69j74OFgOzoScKxO6WCu2JKP/dAnY/CQp1G1FXG8rNfIBenftSzWoNEPsxTBJIxGR2Qw3S47408ny449jzDDuSbGdcWoFZK241QdyWfkQfPQENSPkGXn8DtlLfPZ2Bqd+Ta4Od+pRt9mkg83GOU/7gxP/tWU4QC+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729979; c=relaxed/simple;
	bh=pIAzU8hNDvE6TaKP1zgBrfdmJ1P2utDpxGME/TcmF3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzjqoTmanELPVH84fldMptNiK55u8TMTNuMamn156+bUDm3aqjfqhlPqHtD904SyVGZ01endf9LPSAK31aMaWnBqITnQpof9np9Sz4gjyIBsXr0yT1Y+D0kGY13rdUhri4rNDnFhrWXtyB8pUKiflLUhYHVAWiaqme1YLE9G+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQM5LfXm; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQM5LfXm"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3686ad91b9bso106745ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Mar 2024 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711729977; x=1712334777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ecQH2BDkwB2r76ESrdegsHFKAwWkyciZKIsXaeRx8k=;
        b=GQM5LfXmLofyx3Sv41qIxzN/PmJU/67OpDK8a/rsrSGc1vnJRBROR2gv1iZMUPOYmD
         RQqe6QzejY/DcA4KLK4u0MHltr/8bu4A6nuwAYKEr2eiNn3d7zQxEPtBQaAYtI6By/ep
         Gi7zDHtJNJcYhQWIoWNpJM+d7cnEbdg/UbByTtb4DmBU/tqUVcgxZ8rdE+OpndT0zfar
         lsEk0IX4raSLU3/Y+0aWNGK84hcEns0odvm8rULXo2CQWNQmpLd9VM/mJHHY8rKJtj0Q
         zbYaMDmaLS0cF9nuhHG3hzPPx9HB78vQ3TUDZGwfFwBi4lJao2CdAPpt9JyyOklFEAoS
         Zsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729977; x=1712334777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ecQH2BDkwB2r76ESrdegsHFKAwWkyciZKIsXaeRx8k=;
        b=sgzr6AGJEehdtK95vWdPp/45EMxz0wkIKQWs2nMN3fU7oxl80tWLFhKQyjPDFsGTAS
         +CwExPc8PKnL4DHjAEjkT8Z+3na5WP2dZ3nDNNkf5E/xCpLAVy8zHCIa4Vi0diGkppcA
         RhqiidArELerp4F+Cr7V+YW7TNA2SQD6qzUdIkLZENCbh+HawZ8E2PspQkx/Pbo5cvDx
         JQsIuMfW88Zy0Pi8NxgItBPp8ektOkftVGG6WZZR8YbadEjEeJeiRD2fl21udhajo4+p
         ulNy09e4ogMfMxAKy+6RRWrRgzhDbO3rSbBsliic+0GeNSNDY0Z93JGp4oXUOZf0cNx+
         ZBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7kJU57IhChVLcBmcbGv0cHyJytKO8t6YxrpcynB8aN86e2z9B51fHEP/ISJqkiX7wmvVLOJuyKXUh1c4vjbcHjAjlhk7T0GRE1U6lI4mCrg==
X-Gm-Message-State: AOJu0Yw1N9KGVWOyz+gOAx9ae8pKT9eq1JEwVJ/cl3j7Wlj5Ng2WfrTQ
	vavegXI7VX2y0viXaP+602+luNaSz2ivs8N5Qki2SUfMlBrlathjUpNkMhUFVamC8642+Noq5Pk
	oAzu5H/QFKISYXxVyQ9vl/gKlFc1Ip5jjTICc
X-Google-Smtp-Source: AGHT+IEMHiUjwvlOfWtxBmrX9nXWTfw/wir17/OHXAXmPNT4z2N00j9M26g1INAw/fd0ZAiYa+1NVjN/9Sx2i7tABEU=
X-Received: by 2002:a05:6e02:ee1:b0:366:5a92:ef01 with SMTP id
 j1-20020a056e020ee100b003665a92ef01mr227309ilk.8.1711729976944; Fri, 29 Mar
 2024 09:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328232009.466018-1-namhyung@kernel.org>
In-Reply-To: <20240328232009.466018-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 29 Mar 2024 09:32:45 -0700
Message-ID: <CAP-5=fX296_EROp6D+zX4OOABOkwkHrE-2v7F0K=Jo5zSZ_-zw@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf annotate: Use libcapstone as a disasssembler
To: Namhyung Kim <namhyung@kernel.org>, Changbin Du <changbin.du@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> As we've added libcapstone support, it's natural to use it for perf annot=
ate
> as well.  This change added the capstone support on x86 first.  Other arc=
hs
> can be added later (by someone who can verify it doesn't break things).
>
> For now it tries to use capstone (if available) before objdump.  But it
> doesn't support source file and line number info.  So users should use th=
e
> objdump (by passing --objdump=3DPATH option) if they need them.  For exam=
ple,
> this command line will keep the existing behavior (i.e. using objdump).
>
>   # not to use capstone for disassembly
>   $ perf annotate --objdump=3Dobjdump
>
> The capstone uses LLVM objdump style output which is slightly different t=
han
> the GNU objdump.  But it should not have differences besides that.  I've
> verified the result of data type profiling and it produced the same outpu=
t
> but gave me ~3x speedups.
>
> Thanks,
> Namhyung

I wanted to see what -fsanitize=3Daddress would think of libcaptstone
and no issues,  so:

Tested-by: Ian Rogers <irogers@google.com>

Some thoughts:
 - it may be worth adding to the commit message in "perf annotate:
Split out util/disasm.c" that there's no functional change,
 - we lack perf annotate testing,
 - it seems capstone should be opt-out rather than opt-in as a library
dependency (given the performance delta and the objdump interactions
are at best messy),
 - if libcapstone could solve our addr2line issues too this would be great =
:-).

Thanks,
Ian

> Cc: Changbin Du <changbin.du@huawei.com>
>
>
> Namhyung Kim (4):
>   perf annotate: Use ins__is_xxx() if possible
>   perf annotate: Add and use ins__is_nop()
>   perf annotate: Split out util/disasm.c
>   perf annotate: Use libcapstone to disassemble
>
>  tools/perf/util/Build      |    1 +
>  tools/perf/util/annotate.c | 1711 ++---------------------------------
>  tools/perf/util/annotate.h |   59 +-
>  tools/perf/util/disasm.c   | 1739 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/disasm.h   |  112 +++
>  5 files changed, 1914 insertions(+), 1708 deletions(-)
>  create mode 100644 tools/perf/util/disasm.c
>  create mode 100644 tools/perf/util/disasm.h
>
> --
> 2.44.0.478.gd926399ef9-goog
>
