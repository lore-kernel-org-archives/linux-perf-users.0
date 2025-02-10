Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106025B67D
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210809; cv=none; b=Zk81Nxzn4bLpA8ZfpxlHEsdbacvo6Qp7BY3BFlTeHMLJAnZH4kPPKqPztbhM0L3pAK+CHMRz+KEuor0ALiL0z59ojbTH4Vk4A6uoixTq3rfuzrBUWSpmebQgokDBo4148b/3vRwm3jtcnVK5+/NiJoYfXmif+DM+Nj9iQDZdXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210809; c=relaxed/simple;
	bh=zWHQ/xQzS0SVky8j3UXIWdJ6YcNh5e0HYTnqYtA1fh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfWZxbzsG/hJPz6OJUudEscZ+SP9qvKeF++fNkPll2+cAmDViz28TPqfYnxdn4V4l0qk3U7Q/4ihfhkuhLS7hVr2FhKi+2yBhx+JLEBVy/RPjOUXWmMaHxh9ZP9YprMaAICk19hC71zFcZVd8Rj0XEU/j4lHcb9Nz3r2CJpVaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OfVU4E1o; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OfVU4E1o"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d146357fb2so1535ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 10:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739210806; x=1739815606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLOx8uZKOqbSMHNZbZfwBaDXMWD7wne+WuTTmhB+k4g=;
        b=OfVU4E1oR4hQnex/JieEltu7IvU7gUTapbSfvu2Ebw7ecBxZKEUoBtUn7epx7jIjGP
         CTrZuLu94MtWQsU5r7qorRZ4vBdTIVmTaR22uP7QbvzzVwnGUPRQhiO9rD4ye9KhMS7h
         OhGyvDTWo5lNbGA/nWmq6TF+enmYvsFIx/THdx17ryRRSUHq3EXToI3IBQuiNmk45rTN
         38cJrpkLIKAw2K8dDheAzTgmyc9IBnPyfumNqBeEWB9qqm51PasMFDbAtf7PNrS+G14y
         r2QzqMJ9JpjcDzHjXTCX082sgZi2+fq/znR83yTJQS1c9CUUlgs9rRXy3pE7UO6xHAB8
         +UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739210806; x=1739815606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLOx8uZKOqbSMHNZbZfwBaDXMWD7wne+WuTTmhB+k4g=;
        b=EIvIK16s3SNmMGnFfJx1UcAIV3KAejUul8KLRbeYvOmdT9BVTbOCS/mZs1MLxcdgxn
         ois42rpS04CpU/KhyshzLvljjsOhgWUUDKUrJj//VqxknAam4QZWodNpkI0Cqgol0gEr
         8WbUEAzO23hV08yYWeLEdesNCOxbCizhTDKi8peg+V3HicE3R5wjtIFWSnGRmAiIHLtd
         LYDYL9QITMG9nVzrvsZO63v/zUbV7/PCz+WWcl82Wb7yhF4rBJOngcvJk02+dTuLVZAn
         /Wfys2oojvZBgxUIDHyfpLDDrbfxg/x0JAHBCR2LQQYYu9yOrKQXLryDJzG0q2RKREWU
         +3BA==
X-Forwarded-Encrypted: i=1; AJvYcCWFZASoRKowSG4me6JETHsAetyO4IJvBWGiNFpayNtnr7CMGG0xVdcjW1li5ceURimp2CAKaFOU85OLo6Lr0Npx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5iS2Pk2ko89TXZqbJxEdlIXs+PDiZXUSq0EQPdxyOukCmcjzy
	GOxFRl7b8VpaFlZ67VqyfC7hEhrawmrglFADc87clVP9wnxYtQURXvCjeLlkpCRf3s+EyAB05bf
	kc1ljO2yzg/4Qj93MH2f3EJ6RIy9aOCvyWuE9
X-Gm-Gg: ASbGncu0wZ+10bT4xxDe5CmnfpmxOUSAUC3HGDa3wzRNSppYfYiSBOZ004Fnt9W24Tz
	xA1GxP80jxOJqHumQXIcet+mbz/NDbj2QzcjIoKs7KtMulHCmtM3vtHroywl8Jk0f/WnTqk3yc7
	dJt0ldVaUk/VSqM/aE3WSZ2NFp
X-Google-Smtp-Source: AGHT+IFQyFzL4toKjST54JeKC5iEPw/FRNhzC05ypK58dUkv8jG9yKJ7k/Rc5cXiBrhxLzre2Y5FkHw43ZhurdlnnSM=
X-Received: by 2002:a05:6e02:2198:b0:3cf:fbc9:5c10 with SMTP id
 e9e14a558f8ab-3d14cde2865mr7402415ab.26.1739210806086; Mon, 10 Feb 2025
 10:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com> <Z5K712McgLXkN6aR@google.com>
 <CAP-5=fX2n4nCTcSXY9+jU--X010hS9Q-chBWcwEyDzEV05D=FQ@mail.gmail.com>
In-Reply-To: <CAP-5=fX2n4nCTcSXY9+jU--X010hS9Q-chBWcwEyDzEV05D=FQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 10:06:34 -0800
X-Gm-Features: AWEUYZmqaHEjcEf5hPT16AA9v5ALYmeBI5HqSnlIc7uBGpS_AVyNMa9dTNcQdl0
Message-ID: <CAP-5=fUHLP-vtktodVuvMEbOd+TfQPPndkajT=WNf3Mc4VEZaA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
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
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 3:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
> On Thu, Jan 23, 2025 at 1:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> > I like changes up to this in general.  Let me take a look at the
> > patches.

So it would be nice to make progress with this series given some level
of happiness, I don't see any actions currently on the patch series as
is. If I may be so bold as to recap the issues that have come up:

1) Andi Kleen mentions that dlopen is inferior to linking against
libraries and those libraries aren't a memory overhead if unused.

I agree but pointed-out the data center use case means that saving
size on binaries can be important to some (me). We've also been trying
to reduce perf's dependencies for distributions as perf dragging in
say the whole of libLLVM can be annoying for making minimal
distributions that contain perf. Perhaps somebody (Arnaldo?) more
involved with distributions can confirm or deny the distribution
problem, I'm hoping it is self-evident.

2) Namhyung Kim was uncomfortable with the code defining
types/constants that were in header files as the two may drift over
time

I agree but in the same way as a function name is an ABI for dlysym,
the types/constants are too. Yes a header file may change, but in
doing so the ABI has changed and so it would be an incompatible change
and everything would be broken. We'd need to fix the code for this,
say as we did when libbpf moved to version 1.0, but using a header
file would only weakly guard against this problem. The problem with
including the header files is that then the build either breaks
without the header or we need to support a no linking against a
library and not using dlopen case. I suspect a lot of distributions
wouldn't understand the build subtlety in this, the necessary build
options and things installed, and we'd end up not using things like
libLLVM even when it is known to be a large performance win. I also
hope one day we can move from parsing text out of forked commands, as
it is slower and more brittle, to just directly using libraries.
Making dlopen the fallback (probably with a warning on failure) seems
like the right direction for this except we won't get it if we need to
drag in extra dependency header files for the build to succeed (well
we could have a no library or dlopen option, but then we'd probably
find distributions packaging this and things like perf annotate
getting broken as they don't even know how to dlopen a library).

3) Namhyung Kim (and I) also raises that the libcapstone patch can be
smaller by dropping the print_capstone_detail support on x86

Note, given the similarity between capstone and libLLVM for
disassembly, it is curious that only capstone gives the extra detail.

I agree. Given the capstone disassembly output will be compromised we
should warn for this, probably in Makefile.config to avoid running
afoul of -Werror. It isn't clear that having a warning is a good move
given the handful of structs needed to support print_capstone_detail.
I'd prefer to keep the structs so that we haven't got a warning that
looks like it needs cleaning up.

4) Namhyung Kim raised concerns over #if placement

Namhyung raised that he'd prefer:
```
#if HAVE_LIBCAPSTONE_SUPPORT
// lots of code
#else
// lots of code
#endif
```
rather than the #ifs being inside or around individual functions. I
raised that the large #ifs is a problem in the current code as you
lose context when trying to understand a function. You may look at a
function but not realize it isn't being used because of a #if 10s or
100s of lines above. Namhyung raised that the large #ifs is closer to
kernel style, I disagreed as I think kernel style is only doing this
when it stubs out a bunch of API functions, not when more context
would be useful. Hopefully as the person writing the patches the style
choice I've made can be respected.

5) Daniel Xu raised issues with the removal of libbfd for Rust
support, as the code implies libbfd C++ demangling is a pre-requisite
of legacy rust symbol demangling

A separate patch was posted adding Rust v0 symbol demangling with no
libbfd dependency:
https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/
The legacy support should work with the non-libbfd demanglers as
that's what we have today. We should really clean up Rust demangling
and have tests. This is blocked on the Rust community responding to:
https://github.com/rust-lang/rust/issues/60705

Thanks,
Ian
