Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD830E838
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114619; cv=pass; b=fNV6EGEq0SBbZvheie6+dZX41oQMSH0dz5Wogb4Dc54zRHJXBHNDpeiJzi7S2OfJK0szUpe1YAHcMiX8iw4ngbiQ3YDa65Gv2p9qMaLflt6035hOmDCOh2Igw5Xr8M9PonbOLzdvbJD3dLY3ajyV74T4VfkNgqTA8TbY8GFMAg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114619; c=relaxed/simple;
	bh=Afy2UaHCzp8XbNPdfyoHRGs0Ua8F5RHvj4lYcWDPFuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ia2mMqp7gMrWZIuCakAbctGS2OfjVsmywaf/sjHxEz34SWRAsXP8D77sk+buhtiIMo1Fr/+F50jS5I6u+12kE/7MHGXRsp718M/oBGqDLDYcSXPrOIKwdPVEY/KIjhyFrpmiVk4dI88Rm8os+/YjMxk/9sN2sWW5VuekSTqkTmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3zh/tzj; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3zh/tzj"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so21052275e9.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 10:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774114617; cv=none;
        d=google.com; s=arc-20240605;
        b=PAlwTDr3lwGlIu4XHlTAoWq2hdCPDcwg+fB48mqIU+yrl8Ro5+WcGtaHmy5WVVRBrC
         SmyeYB4TB2hszjXwLEV4Epw3wIcmBcjKq51JFw1KKZYH1KCmABasIKjx9YxZwEJOOjmI
         fWvsNVY8/0KAItbVB6HRxPRtcmOUa5cbLCX/F1ENtgUIBTuXZhGXUdy4xY/oLBzjKUl4
         pB9C6XDw2JVXjOlnDOK3feNuc0GjVXDlwJz+3geRIiw3CWuog+G78om4m1OAb09JsAkN
         IRiSflH3m9tWyPAn1voXvWCP6RJIN+dqRCJ2o58MwbPxS03S1P0gSMZ56VpdAvNSP2fj
         5v1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y+9PfnTKizgvLcMJqc0FUiyfAk3mg4TyGnA00SE2rCw=;
        fh=eQYuwCLIUcInP42HARG+kwHCR2cYAjlDfu0sSBwX1kI=;
        b=FDu9t55baQLjzAUOhHcfR8y/0TKhZK6u9l9EonUSSIG72GBKI8QNDDUUm13Pddludw
         7WpLtneCbePdaMZzzJhe8C0XqcrVBig991jYd1+zuWBlSLKhYrbS44je0eXtLySnxSJc
         WDPaOBOX58PST5rtTj30S6ZoApzemTyHdhkqFE5/CbKzBW9FelAlE/08AL8imdavaL6Z
         iOogjUmh2CwPmY2YsttbKt1pwC7I29wZEquppxNRCGj68p48AvnngZ58sd8qjPoHEz2h
         /P0Cgv5PBFOyTTNBsXo5yr2H18VInp45L+gAzk6E9tgUonw6OZvkv/xPIxEhnxMQak/k
         F9mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774114617; x=1774719417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+9PfnTKizgvLcMJqc0FUiyfAk3mg4TyGnA00SE2rCw=;
        b=R3zh/tzjvQZw9wX0pNFCgm2zQ1jQ6oQ8m6AmvB/m2tJ872XVr8N++mihhFaEVExsUP
         HgqwooXwmL214iHsNcwVISemdV/2Zt4N/xYDFZmVF70pf8deNz1HGAWWvLfMyvEPSPf/
         +HtRuRa+h7n6ztscZ0E1/6dssVTMOrnSMfV1QIO7pFjxeabeBUZBdq9NA+tfnOOBYozi
         djmhGML82j6mAuwMJtAx4TumLNVPCOnNSeLKKyA5BcfbYU8+Z9fpZhYDWeEdIyeiUR/O
         JkyU1wob9qvvU2bFdDlj5m4KDCu3vxZY0XcPF/6Pe5XGToVJ4pu5jZPlPNve9A3gcMK9
         +new==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774114617; x=1774719417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+9PfnTKizgvLcMJqc0FUiyfAk3mg4TyGnA00SE2rCw=;
        b=erH5s9KiLFTZAl9aXFx8/s4eCHdtI2OYhxF+wOsbPI6H3BcfARPbc/iKLyQ0afiGCr
         +sjFd1iW1uStW0NdfxXsjXhq+T2ukg+JomBKWiXMsE/GePCZbZSwXaVKlyWsYEE/XAy8
         Spdvdt6mz9Ml3Gin89K3CJMUToEOvPvbVTJQYK7b+N95yxzJCGwTyoSYgr1PPzNixrJv
         f3zTFgo3R6pfHKfEmZ7QqdnNZRN6HfTdSoaa94fMxpGhV/ZoLJC0fTT0OPixe5OXWsQA
         9Chb1JADyQCY3xMGCgN/9zflqdbHygJGTAo21B++DnqlLCHDR83xzZndD6dvWQGY+oTE
         VCiA==
X-Forwarded-Encrypted: i=1; AJvYcCWWUJwzZ7EbiKHWI5jngGI0IbW0RkgqC73dYA7npWtYlhV6if2rjqhZQXNO+NHchuWgnC9OjZLxEIjzfC/ZEs6P@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoPTv9IvbHkHuIJiRyHYvO7rBAGTspEJHmqEfB6aH/H8DOau3
	QqYNpxJAEdNrSNr1AwtwCRGELUlTKphG1ii8OG2xm/kpRMXb1yLcJR4j7AfDcp9w0AHZl3qWL1Q
	Lv8oi7BcdvS66Iq8ZJOSQnobW/K7mcRw=
X-Gm-Gg: ATEYQzy/dzUXHeHKmEdA/sCZQpaL/h19Ehf74hW1ILD135V1GIUrp2r2Rh5V2qGMuTC
	oNQAvdyV/X+gd+9m/IOoAP/X0AFapL9w4uIgVu3qR2w5hhgJzfAitrM75B+837cJOk73RALEGGq
	2OFlNlEXgcbLIm/le/mmJbVICptGNzsKtXzNgrpto5SeZLqzQyqDFzrHIYnJ5CwngZ1M2CFOHdh
	ypuNL2+TCo2tKqPBodicKiPzz9dVDIfJs7K9qvNpu7nYO4VbNjvnZ5u+Xr4YFkWZeMI63HOZHgR
	Da+qTLj+FAJ3luyfhWboaQy4oyomHErmiXZRKUFa9izX/SYibCPIt+5jMEc=
X-Received: by 2002:a05:600c:35c4:b0:485:3f1c:d8a4 with SMTP id
 5b1f17b1804b1-486fedb2551mr116656825e9.9.1774114616507; Sat, 21 Mar 2026
 10:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
In-Reply-To: <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 21 Mar 2026 18:36:20 +0100
X-Gm-Features: AaiRm51T8R4umn3vhNl3zRLi8Rm9QE0qMzoTWcSVi9M_Kw4MtIygviLgrZ2b8JA
Message-ID: <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
>
> On 3/20/26 7:44 PM, Ian Rogers wrote:
> > The hashmap implementation contained strict aliasing violations.
> > Specifically, the hashmap_cast_ptr(p) macro was casting pointers (such
> > as void **) to long *, and these were subsequently dereferenced in
> > functions like hashmap_insert(), hashmap_find(), and hashmap_delete().
> >
> > C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> > through an lvalue of an incompatible type. Dereferencing a long * to
> > write to a void * object is a violation, even if they share the same
> > size, as they are not compatible types. This can lead to undefined
> > behavior, especially with aggressive compiler optimizations.
>
> Potentially this could be a concern. Did you actually find an issue
> with it?
>
> The linux kernel build has
>     KBUILD_CFLAGS += -fno-strict-aliasing
>
> The libbpf does not have this flag. Maybe we should add '-fno-strict-aliasing'
> for libbpf as well? This way, we can avoid any future potential
> 'strict aliasing' issues.
>
> Note that bpf program (tools/testing/selftests/bpf/Makefile)
> also has '-fno-strict-alaising' flag.
>

The change itself looks correct to me, fwiw, but as Yonghong said, we
can add -fno-strict-aliasing to CFLAGS and move on. I also doubt the
compiler can cause issues here, since the usage happens in hashmap.c
which wouldn't be visible in other CUs where the call is made and
pointers are passed in (unless compilers also do aliasing-based opts
during LTO). I guess libbpf maintainers can decide what they prefer.

> [...]
