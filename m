Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C11C5D57
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668250; cv=none; b=os/XSkHvOTB/MPMPqQ1u2OSJGMeBRN02CuBQhqFKVEdCv4hDOPysKaeTQ5DytBZ1ayHi0zplo6ySmeFLaUwb1rZXUfRdane1gYbHAeVCGJ6KU6MDtxqddJOluTL4vZbSckLSZ6GBTkDFRGKlV4OBjQkt6euwc5DbNKpO617Fdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668250; c=relaxed/simple;
	bh=L752r3W235xYDox9BIyWE3Rp16Pk46klYTAG96XXzG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+FOd6XOEIIydrblkBWQheImRACUHtYG39JYf6nXQcmG5kVSFE/JiDmwXQ5NCdJu52u1JmX0JhwZTu5LpCjE0BM+6jNhmQGQUaaOzhSikmqjZZznAq2eUKdzCc/kieAOoNRBx6/kBS6fenB+LsBd+b5s/4P3b5eO9fvsYv0QyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p98tQp0O; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p98tQp0O"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so40295ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737668248; x=1738273048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoxnm9hTWfZu/cKYiCMCQS81Mb/wxsDunq4c/uCgQzg=;
        b=p98tQp0OMchs7XOtZWLm7C0Hhbqf+S9/2ZfWUSUq48yyFvUUx6vc4grKSgv21PaYS0
         OBheA412BxuhhMR3IDoo3FckA16bUqNm5NpwFwqXaCQDlQVnghuP9CnP8Oq0QjHWCNGF
         5/z6J+qzYoU109UTBCgO08hOsloXJ2sq0D69oAxxskKWVR7e72jrsK1efwfmf9GyxcL+
         TOYVKj9DgFhFCX0/Hv7Iifmjd1Ipnxm+TVgiJcAh9cFrgO3iu+rCB/+bM+3fUlaXoMSK
         LlS/FUU7AmYjsbI0Ld2J3BaIdaQEqhyebvmVC7XEP2qFz4yvtPb7yLf2jdTtXKHRkUzL
         hj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737668248; x=1738273048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoxnm9hTWfZu/cKYiCMCQS81Mb/wxsDunq4c/uCgQzg=;
        b=uOle0wkc3oY1SqCmKFBnWcxYh2eUVZv9GkguD2YQOgbkP05Xe7NUebNN8VacMMDmSo
         GNCHwQ4R0LHpEYf2Id/AtaXq22fe25Z412Oag5t5LIVI7Od+xmZCVK11HC4AiMYxU77H
         7jIHzdg3C2VoJcFQEmwH1P7ryW9W4R6MVuOosVgPGocy6mO/kzVlB6kuJbPsVVsU0ob1
         jAj5ORDzAXVIMFWYcTvZ9sWuvHw0td0fVPbk4hEj4rMoJ9nOatkKwU3/VR9hyu5R0Bye
         kgAHfftikxYlU9rbPQl26+3kgPw3tG0kFKqnYqxlUzva8Vdpafmj63gGbHqXCQ00NHTz
         vr8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCLe9Y0nYKi5h/7Zolo/j6oXbkKpyTOe/T+xH0xeFWLvPJmDzKRH1Lot9tlBjrFJgPbA1h3eMlAE11Y5qRevN3@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQqq7vm3bnrY9+gp8VuAy+HERxSAtfRrKVNv1sKZSOwZgdPFV
	0CQ+asENbn8GtixQe4G7QkahVycrlUD/FXWll1guwjQlyNpGsDhj3p72gFgGesa99WZaYuH7eVk
	MarR/kIP+gRMWK+9cacKy6tBu2ZOGhMsGuUlh
X-Gm-Gg: ASbGncucyBw8O2EvOBjkXZDgiXwAILYnj4YN/dTzia6obdGlEoVwN1Gttg+3+XBBN9b
	sIunHjookMM5VwPwJ0I7Xd3TY/3UNyqi3F6OeB0CGXSFiEv6CZabSsQaL80OayhD28NXyfSW52u
	FAlhTsJfgqvfmSPA==
X-Google-Smtp-Source: AGHT+IFe7SswEBLl2QnLCKZzlHXG+YarrT6rMAK1wtA2NW1AV2vUVPldz0BgyNNQs/pQU2LinX6XSFXiFaCh8HCJUlw=
X-Received: by 2002:a05:6e02:20c6:b0:3a7:e301:a1f2 with SMTP id
 e9e14a558f8ab-3cfbdea9d88mr4093055ab.15.1737668247865; Thu, 23 Jan 2025
 13:37:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120173208.344231-1-irogers@google.com> <20250120173208.344231-5-irogers@google.com>
 <Z5FwusFZ_bYlu6aK@google.com> <CAP-5=fX4vtKzMtrEbZhqH0dmKpXY3Ke+pVJ-ZbnHnAVuto7Z8g@mail.gmail.com>
 <CAP-5=fXx=q-LHcb9BtjE1AFZGmV55NBWy3HvfWQaABo-YO=4gA@mail.gmail.com>
In-Reply-To: <CAP-5=fXx=q-LHcb9BtjE1AFZGmV55NBWy3HvfWQaABo-YO=4gA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Jan 2025 13:37:16 -0800
X-Gm-Features: AWEUYZkx3MIYrAmzo2aXD_jxkXsQ8Hq8_p05FIEhwZQ0cii9aIVMyCMgz9iHWj8
Message-ID: <CAP-5=fUhNuybCU-2_5EgcCwgwXnxvyFMvyhzKe=ZP1bssQwXHw@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf capstone: Support for dlopen-ing libcapstone.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > On Wed, Jan 22, 2025 at 2:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > > I think reverse engineering the types is fragile.  Can we simply chan=
ge
> > > to dlopen if libcapstone is available?

To understand the scope of the problem, here is the LLVM code:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/util/llvm.c#L22
3 typedefs and 5 #defines on 13 lines of code.

The capstone code is larger primarily due to needing to define cs_x86
(and its dependencies) which are used for extra detail in printing:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/util/capstone.c#L23-L132
We could opt out of providing the extra detail if capstone.h isn't
present. I believe this can remove lines 49 to 123. This would mean
there would be 37 lines of reverse engineered types - 2 structs and 5
enums.

My feeling is that this isn't significant and better than returning
errors for capstone/llvm, having #ifdefs/__maybe_unused for the cases
we lack the types throughout the code and relying on people building
noticing a warning to realize they need to install a dependency - the
alternative of failing the build if the capstone/LLVM header files
aren't present, and unless some NO_... build option isn't passed,
likely won't fly with perf developers.

Thanks,
Ian
