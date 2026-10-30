Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793329875;
	b=f0MEhevNfAKhJjVDxGNXy+tNW3kIpdZOt6eGLWysziGC2qipdA4Ba15kmTNu61Tl93TS
	 tQ9GCq1+mGkLosyxK8sBn/l54Xpj6DYvz6sDhcOFgVppZXeRmAy8winC9YAgylihKCVKI
	 2Mw2HWNYfEFBWlrhU/PwVJ3ClYszAtePN7oFqpmyaPF/xXo+fpjvBwKMcJJ8QEbOsMRSo
	 JXn1lHbc6cX4yBCxh/vF3VLXT6ZKGaIvclNgmT3c8CONJ4lkxLWJ39EQ+1eYDGntuSiOo
	 Hv3Hqdf9IkPsd+Ww0lUY8SjK8aOEW/JkVbHBARgFG0eyuB+kiJ+jd5El9VxKaxA9fjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hoVHC65GR8n9FjINMXnaahKi7WXhnhvguTlzPVQW3pA=;
	b=TFY/AfRxPZxb6HLnEKm2aDCs8haab1o8B0j+LOnu/x0rJVJHOJIkzxzfn4UtEF2/pVIE
	 Aug390hJq8HGcp+daLYn6PDNCTYzcKLuCX6PrCa6NxVJg1DgvvF9jrvMxImch7oF8yNxi
	 9Wrsm+lCvyYwuT4jvBaYbJw4xcxp2BUggtP7k3EY52/FcUkGXTe1EkFqzsLHzJFtcThB2
	 hTisHMVmuFC0tykTsCr41EMVhVdIDqksBEEXyE/VnIoenxCQFx/sHmqWiClh3golTCb7C
	 xDsotvZQQ7fgSz2/XE84VMAJ5N+TVJIH8nrx/GCua14FBFUiFUZFLSC8iyT6KTqVc4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kh2HrdRU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF68606A322
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 03:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF68606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kh2HrdRU
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5383c97c8cfso105451cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 20:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793329873; cv=none;
        d=google.com; s=arc-20260327;
        b=fRuZz231JFsu0ytPNWUbocLhTj+TqP8ctergX5hf8Dom3y5vOHioGWxMRlbP/mQozC
         1JALrIvGIhoYejR5LwrSBIsONaquKlaCd8CwqihrEOr0cmvkpMMVW/InIMNMbCPXnvMW
         P8U7Xz6Oa5VjbqpXvyuGiDOhfIDljh6LHqzqegqy20NFNdlwtugg6C0aoL/iPNlhEo/S
         0NHHvq06fzkXN1EzZTI8lx1tyN2woJnnANUiUnINwH9o+prOgwBjqLI4KIzr9Xyif9uo
         iHzxClELDN7rFvq9+Sc3uXIx1ZB1e8+2wWsdnDe/BCQbGJRqz3EaO7newT1eIbWSCxqE
         QFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hoVHC65GR8n9FjINMXnaahKi7WXhnhvguTlzPVQW3pA=;
        fh=K8/HSWsnxUDcTPyaickxKNask2r7Orpf8q6Fsi3+Qiw=;
        b=Ken2tbhkP99uD/VMQErD9kRkZTn0z612IEExMzSzQ/6DBujfu8E3kvUvRvXDaJf361
         wimUxC82WC0643bieDiwysc5K/GggwbhPXC8kdCCfdggJPIoihlBT2eXRR3sZMOtYpKM
         3qhr03EoOhuW3ZYIt0Cp+ZWLFtKLjYZPpl7dbCqj4mJCfP/XY6qNjxNg+D2k1STPQOzc
         3/o3kGo460zmlAgdAJQ74rrX1b19AQf+GmOrVEVmk7SlRm0/PY6UGR+sD2t/r08nT8D/
         RoMnwOrp5SyfndBEX6BnO9iedxyJy0VWEdNgKGQ4gZGKKYoR0te0+azCUuTq/kIYNkJ1
         gi8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793329873; x=1793934673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hoVHC65GR8n9FjINMXnaahKi7WXhnhvguTlzPVQW3pA=;
        b=kh2HrdRUmrMNIG/6fwizpyRV2s3ZGcRq8l+qhBw8D3lvG8emEl6JjqraKmxtxX2X2O
         ZVgvajWvOtpUnbYl7ZWbzrX3gx+Nz56XLrBfUp/MmTdYPJ3VGsBg83OgypsE+VVnTee0
         B1zec4y+h6QhIc4Iu4oy6WYjms9OJRLgyK3xNdLlO7bckZRnUc/bDAtF8JBpXU0XMUOn
         1I8oAMJqjNaCzflStpKVCF0Bp9tH4SII9WfY81WZQT/FvfENzypAo+IMJO27Nyr6kjlf
         vYvY0iyeiRpFjkQcCmE8mKfeZW5WkPkXWbwrjjVJ2hhNOQ+832Moo79dOhNjQ7s/j5df
         umBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793329873; x=1793934673;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoVHC65GR8n9FjINMXnaahKi7WXhnhvguTlzPVQW3pA=;
        b=m1+fgN5XSJGlJ4fxDZIh3t5AaUzZS7B6SCLkjr2UxmyiC6Mv5p2pbGVSBkVOcHvOJM
         C099yVrjvShMLKHpND9O7EY0w4ky1QAdozlySGG0DsFw2OEtFAPbv2qRRrv2SA6egcZC
         ZSc9kzLFNlGrsWsKck5Qg3BScWU/Xyje7TB+tFZVXKytYny0BGhXCiUoPaAYRa9QL/gI
         s7fzPtDLnuxlByd8iIFW6ueByZCW5L24SYCmQCc57952KUDS5kToWwmqg6g4QiJwxK0W
         Ek9Gt9TvvJwaW8f51Syn/Wr9bDOKVbdZJ/u9bXaazJC0/W68b60ClXdJXiUHL2XFvwVa
         oJcA==
X-Forwarded-Encrypted: i=1; AKwUvBzgXi9TmuQibC89CszRdyqYBMvo/Qc0op2MeqqjGAth9PJ5TBKWoTYc2cPuNkx+7ncNOt0RLY+hbVnzRsG0+hgi@vger.kernel.org
X-Gm-Message-State: AFq9FYKr3/7P0riSTlp0Mst5GNCo8OlVAANhBsuA8++xhzziUi4ms0qm
	aWytIcp9816kFXwLKVjFNxtV1WBqjd4kR+uR0cRytKYQaws0d6qe419EuQD8fAcbsCpWLjtmk9U
	CuZhrYDvftRDED6EDsly1WvsAwOD89Et/pcBUvyfE
X-Gm-Gg: AYBFou12DQ9DsLZr/UwOFQYhidqdDKKznGGzF3joX0d2nCcl6KmQsAY/013IO2qA9HC
	OO2ON2FNUhx/dL/dSeyBhNB/u6WLZp/z0hjMWWT9/iDw4VMT7QAtJmfPfWYtpYZSKLY/VDjVlQo
	8HBDH9ipQ2Sr8zXmWoyEA9twZqVLO2vWfqmEBnOkSnopJfhE6aq1D0S7hPpFA1eN69GEXc0ydqb
	k4XmOpmMRIQF4guIJQzIT2OTDolGYXwriVgVhhkJ0fTiCGYtU9wRqyUaOn9Jo53SQsXBQ7bG33F
	tpji+R9Hsqthke+5KS9Fr1CkQqAFBWYzqAPTn3wGiJ0QauhPuuV5BZGT8W31ykF4zIFv8qz1Yc/
	86H4Ku/aaivNXrbIik9nLdgiRwsLSyE65hY1g9g==
X-Received: by 2002:a05:622a:1b0e:b0:536:6d88:600a with SMTP id
 d75a77b69052e-5414de1cf2dmr34323151cf.9.1793329872551; Thu, 29 Oct 2026
 20:11:12 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029162958.3224280-1-irogers@google.com> <20261029162958.3224280-4-irogers@google.com>
 <d1267d81-0ed8-4b3f-a535-88ddba51af88@kernel.org>
In-Reply-To: <d1267d81-0ed8-4b3f-a535-88ddba51af88@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Oct 2026 20:11:01 -0700
X-Gm-Features: AclHuK9rCNoYtTV6H1GziiI59-c1QFU3f9f-3J74Fr_QKbxS-WGNb4D7UrtMMqU
Message-ID: <CAP-5=fWaLj-ToYvAowp-_dk5tL-_Ju+i=U90GRK_obFNqn5axg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] bpftool: Prefer zlib-rs over zlib when available
To: Quentin Monnet <qmo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:15=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2026-10-29 09:29 UTC-0700 ~ Ian Rogers <irogers@google.com>
> > Add zlib-rs and zlib to FEATURE_TESTS and FEATURE_DISPLAY in
> > tools/bpf/bpftool/Makefile and use feature_rust_lib to configure
> > ZLIB_CFLAGS and ZLIB_LIBS when zlib-rs is detected, falling back to -lz=
.
>
>
> Hi Ian, bpftool doesn't make an intensive use of zlib (mostly, it's a
> requirement from other dependencies; we may also use it to unzip the
> kernel config on the host if necessary for probing BPF features on the
> system, but only on some distributions). So I'm struggling to understand
> the motivation for your proposal, what do we gain by switching to
> zlib-rs when available? I understand this implementation is in Rust, but
> I'm not sure the added complexity and feature probing in the build
> system is worth it.

Hi Quentin,

At my workplace, we are transitioning from zlib to zlib-rs for both
security and performance reasons. I'd like to keep upstream tools
aligned but they don't have to be, it just seems nice. I agree zlib is
of a lower priority to users than, say, zstd. For attackers, like with
brotli, it is probably an area of interest. Knowing the implementation
is memory safe is at least something in favor of zlib-rs. I sent this
series out as an RFC because I obviously have no way to mandate what
upstream should or shouldn't be doing. There are things that can make
life a little nicer and easier, and this patch series, for me, is one
of them.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/bpf/bpftool/.gitignore |  1 +
> >  tools/bpf/bpftool/Makefile   | 56 ++++++++++++++++++++++++++++++++----
> >  2 files changed, 51 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignor=
e
> > index a736f64dc5dc..ea2222373634 100644
> > --- a/tools/bpf/bpftool/.gitignore
> > +++ b/tools/bpf/bpftool/.gitignore
> > @@ -6,5 +6,6 @@ bpftool*.8
> >  FEATURE-DUMP.bpftool
> >  feature
> >  libbpf
> > +libz_rs
> >  /*.skel.h
> >  /vmlinux.h
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index b0f7168e7943..a193cf89a034 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >  include ../../scripts/Makefile.include
> > +include ../../scripts/Makefile.arch
>
>
> Looking at the GitHub mirror repository for bpftool, I'd avoid including
> this additional Makefile if I could.

Ack. I also acknowledge that the CI failed because the patches were
against perf-tools-next.

Thanks,
Ian

> Thanks,
> Quentin
