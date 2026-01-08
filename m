Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289663346B9
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907981; cv=pass; b=hyi+hnqa504sqgALuYPCWl9NDhKEJQXoQr5icwbVwXiqsTjyLitKGKdjPB35pa62506IAHRCdD6STWloKI1/WC3DMSLdPpFgIJSrypZc5JJOUZ3hMKA6kstAbAP7mkzfUBePSGgyAy5GTrN+/LOQJggjKx/5pXO3Pqy/lAIJs84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907981; c=relaxed/simple;
	bh=h7T9WIGW4cP4dhj2JwRYmxkFXPoI0ySk4+E7EPCzcII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iP+Y2SRhmJJ3UtPFHj62jFKmR/p+b7cP2sOM1I+ttOFkoa1ddS4GqfKvFzfrxjkM1lYxQiakNYgeqJcPHr39KB2hXBVOwR+S8ZjZxedHuE9+Yz8/YqeAp6v9wlrCwCRUusBHfk1l0nJ/N50cUBwH0VKKiD0iMbhguonWs1kuPwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIaJEm0V; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIaJEm0V"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d06cfa93so7745ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 13:33:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767907979; cv=none;
        d=google.com; s=arc-20240605;
        b=BkZzcc9ad/DKmrdQYzoLOr1mXUz0gahbdnvjrQnR27IeZ/1PtBTkRONoAhiHBrwETJ
         R+/1s0+woYvQChZ8fJAegJe4i8h35J0C/83Ug0PkZ02yLWriUYZLJpsA9rqS56v7/RVI
         JDSWCzTUjpSrDoCCyAvBozpN9putPsLGsUg6uSmkSFqfTeF9VJ3GrcpMDI9n0iQ63uBh
         P8NzT5GYEt/4uLGMo5SJbiZGkhF8FUV4Nh1GoP6we/Xs/wOR46KDeUkZ1VVX/+n+YUE3
         WRLP2jEtMFUjLhogryRhEori6Ov5KOj6pMTx7mmQsPzCfJvBP8pCYrLYlMHE09M/C4p5
         MnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9jii3QhKwF6ZszXh6UcF2y7D5ibtMfEq4bxBfO5NQDc=;
        fh=r0ipn3lejWJ4acphynDjGkJAqHjMTzK0eEUoyuoFEjI=;
        b=OExqahFUGQokvlHm92raSfhvqoSffIpioZYFcPbvi0ymWjzpPNnLIzha2cmLVAVgXJ
         Kw5Z5VMcwUFY1y1Q1mVfFFq6nClKF0wylsiyDT+JMkMjcOShAlVIyHj5CMkr04BTHycL
         D7s/WZ3RDJT3E6GW6kge0jKfF4l6CXWMAsQ35ersRa4MmSiT/URZHWjgZY/UMflAp1tB
         WeSPdhmhd4LTv6KV86T55/TzQYYg0kZSZwzC4MAS5AigbelBH6KG1r/oXOUuEYpRR/nn
         qJMgfzf7mMF9x1CknV244OJJOIcOVwpz+ZeoyXGAaQfVYzBxA++NTFeSiA8KpHnuc1Vo
         GkwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767907979; x=1768512779; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jii3QhKwF6ZszXh6UcF2y7D5ibtMfEq4bxBfO5NQDc=;
        b=SIaJEm0VIPEAU/piPw7PtG1+RtrgZ7Tnj967XGQa54hUZGn8O5YAE2Kx4guMID5BW8
         7Gxgni/9aQhB1kHL/U8sP9mWijMBz4dMkDisaDod3jSerIRFcp86Vtaq6K2Dfzy1opI3
         AZXPovJ7dS1rz46+/kzA5i7IgaKPcWr3Mz3x8eBuPUIOOTyK0GoO5Xd0nHu/ssU/mzeA
         PYD2KudkKWNXxuutTAz+xvYhgtfkquTzsSuk+AXvhTYpZjobbzj0qJFL0IfqmMQCv9iZ
         xrZektgJE9Hx8pBwdKKDyoqM1+xfDUP3yc1B0mzn/CtOmED0OpLy2egVPgFzUTyTix3o
         XMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767907979; x=1768512779;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jii3QhKwF6ZszXh6UcF2y7D5ibtMfEq4bxBfO5NQDc=;
        b=YslJpoVN3YCMmWv41zb1wlk/SB57+tF7kc3Jio169IaI5/5z403vL/2iZYQ8p/fKTb
         LtJcchhGjTDuVNY3guOqpbuMnITMSwf9hcOJ6fOR7krDS438//L5vFUwnugEOh3x88bw
         /H5Z3jpxRQ5j5wouLQsQCbYmg6iQzpatFP4M9MDkPFqZ3dhHIB3Zqjnx+fu3juk84cTV
         VDqKcDwLPCuE7oLuoesGfW35v42ZChuKI0wpta6ZI2Ryme21mjm1KhVEXV6PoIuwTNUX
         l91Fp8eEKmgJg8hxDrJHSZDYYzszrmiHXYllbxMJWDNQrPBElh1CLWqc+A963ENGzOF/
         QZpw==
X-Forwarded-Encrypted: i=1; AJvYcCVgOB6tsCL0r+KQUXQPz6zeUsAmwdUCwfWPYdrXGTOM/m5kAFUUGCVVICdE8CQmyovJMTkPUc5ll8BgBjAuIQz3@vger.kernel.org
X-Gm-Message-State: AOJu0YxVfUwOYs1tg/hfZlkclv9AckXaw3u0tZuy8j8V7cSmTPRnZQ3s
	RWqt/E0xVK/DpWfB8EltXAj5CGK7HmKjvJgKIL22iNL21SsRCoLnTecZk+/RIiQvpL8k92vHwIM
	9c4S2rslYFI9v3j6hxylDwM78eEDodUR6IlBIz4j+
X-Gm-Gg: AY/fxX5Twyy8xmVoSOoW8nKjUzcw16jiRLltnIfCrfO3AT4SUIAI5ZeC0IzZKVFF99A
	Uq9x/3Noh2sNmsJRT+qe1lN622jeVzEERGXHVjVxwshWjgsuVl0P9nmyOuBTIbsKjTuAPqxFtpK
	orxs3rphQ4xaZCP6Yl9ektsX8eEBBtqFIaYkiFljV+iK4vFj5jid2MW+5SdCHfC8GpKliGp91lf
	rXRcGqNN2kBW2akwRSXYgDy0EwEUdnTSxkZd+drZC6wqCRLmax3Axw+KUmaAOhsJKvYlbIH3sSV
	eB1C6Z4EYlS+GY5mvQqCXfUPeWwtyc0s4SZD
X-Received: by 2002:a17:903:2ac3:b0:299:c368:6b1f with SMTP id
 d9443c01a7336-2a409ac2549mr882185ad.18.1767907979220; Thu, 08 Jan 2026
 13:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007163835.3152881-1-irogers@google.com>
In-Reply-To: <20251007163835.3152881-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 13:32:47 -0800
X-Gm-Features: AQt7F2p4jlLBo8WB0IBnDmjDWl4i1PUdEKalJuFo7-mqHyIq6-NhlJpnSTbe7tQ
Message-ID: <CAP-5=fW7YViusbdr9uZ_wSg5cwAPcdnysGbfuytKyYw6cbQa4g@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] Capstone/llvm dlopen support
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:38=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> Linking against libcapstone and libLLVM can be a significant increase
> in dependencies and file size if building statically. The dependencies
> are also quite cumbersome if bringing perf into a distribution. For
> something like `perf record` the disassembler and addr2line
> functionality of libcapstone and libLLVM won't be used. These patches
> support dynamically loading these libraries using dlopen and then
> calling the appropriate functions found using dlsym. Using dlopen
> allows libcapstone and libLLVM to be installed separately to perf and
> when that's done the performance will improve as separate commands for
> objdump and addr2line won't be invoked.
>
> The patch series adds perf_ variants of the capstone/llvm functions
> that will either directly call the function or (NO_CAPSTONE=3D1 and
> NO_LIBLLVM=3D1 cases) use dlopen/dlsym to discover and then call the
> function. To support the function signatures when
> HAVE_LIBCAPSTONE_SUPPORT and HAVE_LIBLLVM_SUPPORT aren't defined
> prototypes generated using pahole are given. This avoids requiring
> libcapstone or libLLVM for the sake of the header files. It also
> avoids having a build where neither dlopen or dynamic linking against
> libcapstone or libLLVM is supported. There are other possibilities in
> how to organize this, but the chosen approach was done so for the
> simplicity and cleanliness of the code.
>
> The addr2line LLVM functionality is written in C++. To avoid linking
> against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
> the C++ code with the libLLVM dependency will be built into a
> libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
> would extend their C API to avoid this.
>
> v8: Rebase down to 3 patches. Update commit and cover messages.
> v7: Refactor now the first 5 patches, that largely moved code around,
>     have landed. Move the dlopen code to the end of the series so that
>     the first 8 patches can be picked improving capstone/LLVM support
>     without adding the dlopen code. Rename the cover letter and
>     disassembler cleanup patches.
> v6: Refactor the libbfd along with capstone and LLVM, previous patch
>     series had tried to avoid this by just removing the deprecated
>     BUILD_NONDISTRO code. Remove the libtracefs removal into its own
>     patch.
> v5: Rebase and comment typo fix.
> v4: Rebase and addition of a patch removing an unused struct variable.
> v3: Add srcline addr2line fallback trying LLVM first then forking a
>     process. This came up in conversation with Steinar Gunderson
>     <sesse@google.com>.
>     Tweak the cover letter message to try to address Andi Kleen's
>     <ak@linux.intel.com> feedback that the series doesn't really
>     achieve anything.
> v2: Add mangling of the function names in libperf-llvm.so to avoid
>     potential infinite recursion. Add BPF JIT disassembly support to
>     LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
>     series from:
>     https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.=
com/
>     Some other minor additional clean up.
>
> Ian Rogers (3):
>   perf capstone: Support for dlopen-ing libcapstone.so
>   perf llvm: Support for dlopen-ing libLLVM.so
>   perf llvm: Mangle libperf-llvm.so function names

Ping.

Thanks,
Ian

>  tools/perf/Makefile.config         |  13 ++
>  tools/perf/Makefile.perf           |  24 ++-
>  tools/perf/tests/make              |   2 +
>  tools/perf/util/Build              |   2 +-
>  tools/perf/util/capstone.c         | 285 +++++++++++++++++++++++++----
>  tools/perf/util/llvm-c-helpers.cpp | 120 +++++++++++-
>  tools/perf/util/llvm-c-helpers.h   |  24 ++-
>  tools/perf/util/llvm.c             | 273 ++++++++++++++++++++++++---
>  8 files changed, 660 insertions(+), 83 deletions(-)
>
> --
> 2.51.0.618.g983fd99d29-goog
>
