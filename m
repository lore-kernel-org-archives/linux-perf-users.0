Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159A214A7C
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562313; cv=none; b=H7lUawRGJJF/BayihLg2SVSPpz9DqOhmHfHb8vFs0GQX5eQa9HCjupJS3YCUNONfblNFfD1X8hg8eIkEqDSFDft2R4S49KE7/yA4TSR9/ekghVgk/QXipPhYKGpbKF4O9P3zolZCJ+8NaNrymWv8Ve3Ae65K2FfeqBtcizpxuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562313; c=relaxed/simple;
	bh=jNCWiuGwLIrwAxoH6c87tzyM63E/aK+e20wre6ZWSr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsjUeoCJ4JnDp6MyzK7yT3iTKsthDK04bOCE4JcW5g0XvbZllZbCHCc3cLPuEK1jjxLKEVgZ6+d6cKo+gfUQr7ed2F00wcfB5JCN3Wyj5BC6EK+DacWmhVH6qa6q1KARzThVmkzFMVoBcn46krZnjlo66g0RFUL6n8/h0P0gW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1kdu9jf2; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1kdu9jf2"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so214635ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 08:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737562310; x=1738167110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNCWiuGwLIrwAxoH6c87tzyM63E/aK+e20wre6ZWSr0=;
        b=1kdu9jf2pORUhScbCpAhMeZoqRUJcDU6bPaIq3U8rAiPIwnbDiXS1z7BJHtx70mhsv
         sq+T1nnr3MgOnqKNKxfgqq0hqs7IkJWQzqayAZ4tqSx12sztHA+HPHa5LVvjwBLOPMFy
         oIu0u80QL+SKWERYBaZfEyd+wIFwmWhnM177220YOgBicZ9gqrss6ltxbjFoGqMRcju9
         mjyMdkE6Rh51IeSMgF0qXEl9vzgJhR7gs0qiMeOnYe+Gl003i7Eq3jez9SFTBh8nDP5x
         n54eXt5406048/93Vvzh5n9BT+gkB2xrwnvNfc0kopH1A1FjIMEMf+7j9zKYOW9OJNw4
         doBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737562310; x=1738167110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNCWiuGwLIrwAxoH6c87tzyM63E/aK+e20wre6ZWSr0=;
        b=agTRqd4cxBBjda8LZQM8sNMXAMB9gVWf3v3Paq84NorjuEHGK29rGMhvMc5aYRKLsW
         TnQn9XkFSnHqzOzA2BXdv8O45kjb2T01ItJaV7gNPPvWn4edBB/FmQuHo8o7CjJM6jEf
         ZFUz8U83YI/df7ae1NykT5RW6TVxFDhOsaUHGKG1vX+Qa1Yni/FPAkhRS0+rl5ZnoHxK
         VaCt0Pkxur8z0JoMpYMLegLFWOxiK6KLj5dwy1kNTs6ECUVcPwWNyuvDDQFJvluDSVnu
         mY0izVegVpXemn++DT0/PxElofKztsFJa7A94x1wujxJ4znGqjvX3iqB1cljOftshYcj
         X5zA==
X-Forwarded-Encrypted: i=1; AJvYcCWqa7xgfziiQTYtcjou+THoo55R3anbBd1v01hy0eH+q9v+jrWFpOL59iCkoQeXkcRO3zrA/c/Yw6kC37pAGjCk@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvnvmZWmj7ezZCs2i73AMwOMYuVDGANDZ450Ps3F/ac2ZO2nl
	XG/jZ7jkPPuHOVK+TIFUL4CSGwv7G6GhpP6w8eUqolsIiRsnzhYys9iEpoc8/+QcKNI+6bDXSdo
	sId3YIlWqe4ycIEby5mgYPzDiSY5JR4sLwiRk
X-Gm-Gg: ASbGncvLB1L4KAy+YY5XquAPK1ui3AD1jz+0hT6cwIETQFzfIN5UapPDztsdJq8QYPX
	s5YemKQ1OIpxJ6wUNwMtnkU7GCIlhxKndp74XBraMBA8T0L7FtJK15vaR4iOK4iVorQLniOuoSV
	yOBXk=
X-Google-Smtp-Source: AGHT+IEiFLgAYdHIXS9mFH9WxNkvJOsHn2tSvvkkY8zJ54ZbyBmpqfFOVwUtOm1Q1WCVFVs1ws31sUh2kq3VR1xaSo0=
X-Received: by 2002:a05:6e02:348f:b0:3ce:7852:1e9 with SMTP id
 e9e14a558f8ab-3cfb3fa3d80mr3094505ab.17.1737562310187; Wed, 22 Jan 2025
 08:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com> <Z5EM24qWVQF2VdI8@tassilo>
In-Reply-To: <Z5EM24qWVQF2VdI8@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Jan 2025 08:11:38 -0800
X-Gm-Features: AbW1kvafVY7CkArTm06Ofo62Z-sE61GIelJQE_qFuHGUl5T-U-N_90G7y7SWyBY
Message-ID: <CAP-5=fW6ZWf6jF3Xnike81S9s_5tZ9w4DS8=8Ff1Ve87O32_Sg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 7:21=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Tue, Jan 21, 2025 at 10:23:15PM -0800, Ian Rogers wrote:
> > Linking against libcapstone and libLLVM can be a significant increase
> > in dependencies and size of memory footprint. For something like `perf
> > record` the disassembler and addr2line functionality won't be
> > used. Support dynamically loading these libraries using dlopen and
> > then calling the appropriate functions found using dlsym.
>
> It's unclear to me what this actually fixes. If the code is not used
> it should not be faulted in and the dynamic linker is lazy too, so
> if it's not used, it won't even be linked.
>
> I don't see any numbers, but it won't surprise me if it improved
> actual run time or memory usage significantly.

In certain scenarios, like data centers, it can be useful to
statically link all your dependencies to avoid dll hell. The X86
disassembler alone in libllvm is of a size comparable to the perf tool
- I think this speaks to us doing a reasonably good job of size
optimization of the events/metrics in the perf tool. We want these
dependencies for the performance over forking objdump and addr2line,
but we don't want it baked in - unless the person doing the build
wants this and this is still the default if the libraries are detected
by Makefile.config. Using dlopen also means distributions can have a
perf tool that doesn't drag in libLLVM.so and a universe of
dependencies, but when it is installed get the performance advantages.
In data centres having fast disassembly/addr2line is less of a
priority over the binary size cost replicated over 10,000s of machines
because those machines don't tend to be running the annotate/report
commands.

Fwiw, Namhyung's uftrace is doing something similar for python:
https://github.com/namhyung/uftrace/blob/master/utils/script-python.c#L139
and I wish the perf tool were also doing this. I think it is much
nicer to have the tool fail at runtime because of a missing dependency
which you can then install should you want it, rather than doing an
equivalent within the code base with #ifdefs and needing users to
recompile. This patch series significantly reduces the #ifdefs in
places like the core disasm code.

Thanks,
Ian
