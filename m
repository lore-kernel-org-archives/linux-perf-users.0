Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EC3264FE
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776983311; cv=pass; b=e8ICWm/uc2s4HINhAI5frO/HOKPjuoEKqNlcCFOXJN9d8qd3eyqN57XeE85vk49ClJwun1IlxTcsXMhD+nfccK5zFDVi53ZOTvnTIlsFst1/00eMypjO+7SQkhbHXzQoHdzAnTOTshhNT3fGDmSV/1aL4SaqrgCJv4W6VlGfsrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776983311; c=relaxed/simple;
	bh=K+8za5H22NaSbnAELiR2sAasM26mKvO4ZYwuOzyDQMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOf4hYfXjQSuWoQtjngbyHpkd2y466ZCldEnIJV4O/KI1vAoJHNa29sAWhc5cm8mzU1nzPQoT4rJfyTreyC2OCaG+D4rOhrlfhVTLzb05M2LkG2XNaKhTAMXMy4MZu4hbclBWwTnhBJR4y28cYhV18Jt3kfz76tmVQeZHfAIeB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DgtpN9pG; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgtpN9pG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b46da8c48eso169755ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 15:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776983308; cv=none;
        d=google.com; s=arc-20240605;
        b=YrUMtNLRq+NFUWAi0OgcEdoRFZa/kX/wH4+6Fp0rBztjcQU1fm6rLuij+RwV0lgAUu
         rZ1pn0AKKIJjg963JOLk86s3GPRXmBYeXwgbuaQP/mQt2ZFUubM5LFywt4/qCUuqPNWk
         F8pzVkFESuIMm4JDh0ROf8qjc+L1FTkYnLBfX/XwQRB0xW9FXEjVdekp4HL5CDWIa0n9
         I7iNllD650SSJsZOVKqCkZ0a9N49wfoNWIrlU+4l4gmo808JV50Gdv4v9J1BPVhjcHdW
         PfbIAthgQpDXvcTiZ5cakvTXgu6VkoBrzeWwzHcjN4K/k64qDR+ekszzrOVXXNO6R89e
         7ShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xv6X6zYdg4eIs9isfVTOuubs0w4UAAxTdheGEyAeVHI=;
        fh=RCfkU83BgN6lQAFs7WmlQXKSfFIzzZ1FF4uRoYloBjQ=;
        b=fmxVBYRtyilh5VPjGRdPpM2bKA+wF4mO987JVA1izxLPKp8o6ZhfQmNnn4dFVjyLb4
         Dq8FdQvpQZI20DIy0Z56mPVX7hem3PYR9y+7p8zunacPzagO1f6zv1oWFoyGw1bOPA5+
         3EKOcLi9vt6a4TBflYFDkH3V8z54GG2qq6wnZI83hhsHQAIcZ5CAGXAvQjrKdVwwmJd/
         kaKQ3KyDqsFe5mRWwJP2dlDKrzuGqSK+pcw6H3VybQ+d5ao6/hE6eRoIK2Wf2ur/EHuJ
         WUD4YHuC23xGyUmZA5q97XG2kZXb9tj+qrDNOZAPmjGdIjEa8DA6ntS0zp5z4Qm/tNU4
         aXVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776983308; x=1777588108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv6X6zYdg4eIs9isfVTOuubs0w4UAAxTdheGEyAeVHI=;
        b=DgtpN9pG2mfF+MkdMvod0Rd8Vp5xmqIBuSUBaGp+0klcp3dKx/+/PAqtKX5y48nt6v
         /XdY3mDDLYI1pEJKE/PkJCaOSa1jF/mbK72jFr77r4u+Jmf12qeIhj8A30k0mIsAJ6J5
         ngptKyQaNgSnQHT17t37cIm8hyuIDuiBFe8HOEMQfWaDG5nWGXAyJFFziuWqO7j+K1aG
         L1s06TWPd3bgyq5ga05BwqW/Fp3h7ZJxRNn6X5x7Impdx/TbjvmnnrvW+heDMxJOOQEf
         9Tma6ekRuoh9dQxVVuwiVIHb92wiHngMGaV1S9CXKIR0SKWudjL7+NQpiFr03CtzYEzr
         IyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776983308; x=1777588108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xv6X6zYdg4eIs9isfVTOuubs0w4UAAxTdheGEyAeVHI=;
        b=HS/7Yf+kmTyvdguuSbvDTKoVujAgfnJRaIrJQ2W6x8KxGpJ6jT8gtl1DHUekq2kCyP
         iT8l9h8QAxlUv9Tb0jQ9HqOnovvkxX1+2WPSDAimqGSee7kVJNLfCB09TwXwaZxDDvmV
         mw+8/VqAIw2RkD3cEJP8KlVvo4lSRfCJvq5jZfX9JQw7ZtK9N2Fwjp4v/ztvmYJ2uaYu
         PDdo8s6RdsBaB35pl5WKkofGSBtLlMwIYnSm4kY1V4InrnXZClFDftzFQT2fAsPAyyLS
         h1KLXQnNbLnoVrAr8fFg79Pyv29wfjkIQAzgF4w1OAhAZLpRK53KDL2UmKfT2aITn/rr
         a3ng==
X-Forwarded-Encrypted: i=1; AFNElJ8ZydKxzMGT5aFJo9PdC5VbMc8Qpnxtbu279607Q2ee1eXKCJ3TGc3lO6mBSMh/3ps2TuCmGT3k6JFIYqFJvRFz@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZSkjZLcZXYeCcvkSzKNzmXsOXsWKy3KrnIBlZrKF2zgYEU0V
	TZKd/WztN71ZUxXdKiVTUPqKi0VpSPPvbAvIXpnt9IvdQrqyeFxRQmvJlicr4nz9bA+tNPLawA1
	42bVa2T3TJz0EGxelvUfndCdnaGFTvJ/efFb/heCDqCT1cyoPuyDsKUcH6gc=
X-Gm-Gg: AeBDiestQL3KU0xXFS0A85H0tAWde9TBJJbR+fHDUcBmpAAimQqn3h9j5wOT06Yjo2E
	jsX8MsGhVULbqumlOLXrsgma/UwhlUxFXfwAJ2VUFPgt8sZoXI5XCdbEXHEIe+Vb0f9Dr/zD1Kt
	PFJ+uNCSB78suUWxoCDNNOkqCWXBwC67cauCyjZgxUcVB+D+oJvruNOBmRC5CAYlfXx0ltQvvyZ
	97CJPa+F3hxddX4iO9sfj09gFEtkaseeLlBihASmp4rvF3yOXjkrtaA07/06hZVSRfw+N1Mxoc9
	8+MlAzvxrLzbehyHlROZCZgcRNiYKFrx5Y8CG6JB9/BYO7Uk/grJAIxRBw==
X-Received: by 2002:a17:902:fa84:b0:2b0:4d40:ce18 with SMTP id
 d9443c01a7336-2b603045dddmr12427675ad.14.1776983306908; Thu, 23 Apr 2026
 15:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aejMem8Pt3iCxaka@gentoo.org> <CAP-5=fX6PT2FsvAoy+0AGq3AFEQ9XU_HBhGkZdX0fn0Ltss-JA@mail.gmail.com>
 <aenrHEOZDiBKG4Sy@gentoo.org>
In-Reply-To: <aenrHEOZDiBKG4Sy@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Apr 2026 15:28:15 -0700
X-Gm-Features: AQROBzBcHQa0ORP14SyU9NuhjOemNaFPZBjxCYKOg7Uxj-NyR-TMeC-2DjqkVVo
Message-ID: <CAP-5=fVoC9R05rGGt=Q4XowbJ6Cr8xGVpQEsh-K4WN0myNkOJw@mail.gmail.com>
Subject: Re: perf performance with libdw vs libunwind
To: Guilherme Amadio <amadio@gentoo.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, libunwind-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 2:49=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org=
> wrote:
>
> Hi Ian,
>
> On Wed, Apr 22, 2026 at 09:21:52PM -0700, Ian Rogers wrote:
> > Hi Guilherme,
> >
> > Thanks for the feedback but I'm a little confused. Your .perfconfig is
> > set to use frame-pointer-based unwinding, so neither libunwind nor
> > libdw should be used for unwinding. With framepointer unwinding, a
> > sample contains an array of IPs gathered by walking the linked list of
> > frame pointers on the stack. With --call-graph=3Ddwarf a region of
> > memory is copied into a sample (the stack) along with some initial
> > register values, libdw or libunwind is then used to process this
> > memory using the dwarf information in the ELF binary.
>
> Thanks for your reply and pardon my ignorance, I thought that the librari=
es
> were generically used for stack unwinding, regardless of if it's fp or dw=
arf.
> I should have looked a bit deeper before reporting this, but we are on th=
e
> right track.
>
> > So something that changed in v7.0 is that with the dwarf libdw or
> > libunwind unwinding we always had all inline functions on the stack
> > but not with frame pointers. The IP in the frame pointer array can be
> > of an instruction within an inlined function. In v7.0 we added a patch
> > that includes inline information for both frame pointer and LBR-based
> > stack traces:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/commit/tools/perf/util/machine.c?h=3Dperf-tools-next&id=3D28cb835f764=
5892f4559b92fcfeb25a81646f4cf
>
> This is a nice development, I have been using --call-graph=3Ddwarf to see
> the inlined symbols, so having the ability to see inlined functions with
> fp unwinding, which is much more lightweight in terms of space (i.e. the
> size of the final perf.data files), is great.
>
> > By default we try to add inline information using libdw if that fails
> > we try llvm, then libbfd and finally the command line addr2line tool:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/srcline.c?h=3Dperf-tools-next&id=3D28cb835f76458=
92f4559b92fcfeb25a81646f4cf#n145
> > I suspect the slow down is for doing all this addr2line work on a
> > binary that's been stripped. The good news here is that if you can add
> > a config option to avoid all the fallbacks, "addr2line.style=3Dlibdw".
> > You can also disable inline information by adding "--no-inline" to
> > your `perf report` command line.
>
> The binary and its direct dependent libraries, as well as most other depe=
ndencies
> are not stripped, but it's possible that some dependency in the full chai=
n might be.
>
> When I run perf report using --no-inline I indeed recover the performance=
 I
> had before with perf-6.19.12. However, setting addr2line.style=3Dlibdw di=
d not
> help much. Here is what I observe:
>
> $ perf config
> call-graph.record-mode=3Dfp
> $ perf version
> perf version 7.0
> $ time perf record -g -F max -e cycles:uk -- root.exe -l -q
> info: Using a maximum frequency rate of 63800 Hz
> [ perf record: Woken up 18 times to write data ]
> [ perf record: Captured and wrote 4.720 MB perf.data (16552 samples) ]
> 1.26
> $ time perf report -q --stdio -g none --children --no-inline --percent-li=
mit 75
>     92.65%     0.00%  root.exe  root.exe              [.] main
>     92.64%     0.00%  root.exe  libc.so.6             [.] __libc_start_ca=
ll_main
>     92.64%     0.00%  root.exe  libc.so.6             [.] __libc_start_ma=
in@@GLIBC_2.34
>     92.64%     0.00%  root.exe  root.exe              [.] _start
>     91.63%     0.00%  root.exe  libCore.so.6.38.04    [.] ROOT::GetROOT()
>     89.46%     0.00%  root.exe  libRint.so.6.38.04    [.] TRint::TRint(ch=
ar const*, int*, char**, void*, int, bool, bool)
>     88.31%     0.00%  root.exe  libCore.so.6.38.04    [.] TApplication::T=
Application(char const*, int*, char**, void*, int)
>     88.22%     0.00%  root.exe  libCore.so.6.38.04    [.] ROOT::Internal:=
:GetROOT2()
>     88.20%     0.00%  root.exe  libCore.so.6.38.04    [.] TROOT::InitInte=
rpreter()
>     76.34%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpret=
er
>     76.34%     0.00%  root.exe  libCling.so.6.38.04   [.] TCling::TCling(=
char const*, char const*, char const* const*, void*)
>
> 1.70
> Flamegraph: https://amadio.web.cern.ch/perf/perf-report-noinline.svg

Thanks for all the reporting!
So here the C++ demangler is about 1/3rd of execution time and there's
no dwarf decoding for the inline functions.

> Now without --no-inline, and this first command is without addr2line.styl=
e=3Dlibdw in the config:
>
> $ time perf report -q --stdio -g none --children --percent-limit 75
>     92.65%     0.00%  root.exe  root.exe              [.] main
>     92.64%     0.00%  root.exe  libc.so.6             [.] __libc_start_ca=
ll_main
>     92.64%     0.00%  root.exe  root.exe              [.] _start
>     88.22%     0.00%  root.exe  libCore.so.6.38.04    [.] GetROOT2 (inlin=
ed)
>     76.34%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpret=
er
>
> 241.60
> Flamegraph: https://amadio.web.cern.ch/perf/perf-report-addr2line.svg

Here perf is using libdw trying to do the addr2line and then it is
using the addr2line command to do it. Time is mainly spent gathering
addr2line inline information.

> $ perf config addr2line.style=3Dlibdw
> $ perf config
> call-graph.record-mode=3Dfp
> addr2line.style=3Dlibdw
> $ time perf report -q --stdio -g none --children --percent-limit 75
>     92.65%     0.00%  root.exe  root.exe              [.] main
>     92.64%     0.00%  root.exe  libc.so.6             [.] __libc_start_ca=
ll_main
>     92.64%     0.00%  root.exe  root.exe              [.] _start
>     88.22%     0.00%  root.exe  libCore.so.6.38.04    [.] GetROOT2 (inlin=
ed)
>
> 137.93
> Flamegraph: https://amadio.web.cern.ch/perf/perf-report-libdw.svg

Here time is just spent in libdw.

> The flame graphs above are for the perf-report commands themselves.
>
> So, the performance is fine with --no-inline, and it's better with addr2l=
ine.style=3Dlibdw.
> However, the function names are not the best in the last two reports, so =
this problem remains.
>
> > Your report suggests we should tweak the defaults for showing inline
> > information. Could you try the options I've suggested and see if they
> > remedy the issue for you?
>
> Thank you for the suggestions. Indeed --no-inline seems to bring back the
> previous performance. Please let me know if you would like me to try more
> things and what other information you need for the cases without --no-inl=
ine.

Performance-wise, things are working as expected. I'm confused about
why we see different symbol names, perhaps this points to a libdw bug.
With or without --no-inline libelf gets the symbol name, libdw is only
used to get the source line and inlining information. Perhaps this is
more of a bug with `-g none`, which is an option I've never used. I'm
quite busy at the moment, so it's not easy for me to dig into this.
Perhaps we can create a test and try to get an LLM to investigate it.

Thanks,
Ian

> Best regards,
> -Guilherme
