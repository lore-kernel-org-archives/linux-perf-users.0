Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794507230;
	b=q5m6doaC8napUxrB6yDJU4I78ePfTV41F2f626HGnENCKCZPli//HwR6rlhhqVS85XQW
	 ig3C4TFOweKfrDdtQeL+w2cN1XE2wZWrosqfmjmeKDJGkyFVpDwkXTXrtLIDtXBvwIVbZ
	 pTHQUkus8u/vGd8RbAyW+0Q8d3Acs47hRptTLLxggaBiZcP+vmoE1QtnavPsSaE2qUxQf
	 U2x0zNnh+wqIcENqLIyp3NZn1OHsxwn46A0n4OX9EYwwAEFITwJEaM4NlejbQOGuFzbQz
	 suRt/zypXKQG2asbkZhif4NEV1ZXrfvxMeEYOIT1bGljEeiw9tU5plfATOEMcB23rHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rZ6GJC7hEGwULDynH0oTCtdmn91ovRHlyRCH+X3ZTes=;
	b=ea0TVIiLJJHivn+rMdcDC86XeEZjCjoFSdEB0tQ81NUDb7lLDZZpwepmZDihigQH/5Pu
	 vP6YrvOG4iJsuH0NYLsYxDQkhqGoEpJ+SR65kJ4mr0Xfhbk7vole4CgvPe8nzzuCLVqBz
	 doKx/BLmvHR69JAU552hD+ZKQEw1MLZwfLBdcIKlqRxZTGRi2jhC6IUGdKM8LYf1q/1VO
	 RZTNIIOE4bUEdByT5rVrcKT8KyWjUeWwA+N5nX5aFa6YnGXXp+3ckIZxMD1qaich9SNfs
	 fwAppFmpoDDTeSXq23n7I7kIZDgg4l+dFiKn2O3F/Nds7oWXi7rm7/4+8kcC1RodgHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="QAOT/jUa";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B46606A33D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 18:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B46606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QAOT/jUa
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-535f598d126so7371cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 10:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794507229; cv=none;
        d=google.com; s=arc-20260327;
        b=TVft9uwemdmmoepPFb5Wlc3jaXcF94suEd2mI9Kn5jiv0jCw++aoh6kWGDVPI1ZbDf
         LC055sScchQxHkAp5lVlfwJDpPolR8vGhnHABx9RPNqQ9pDnnLHarhiA2V8yvMkboOgk
         Hw826WDQEanDga+fQTfKL1LP5cnGWnwyi5ulGCdr2H4D4MmARzs4mg3GdPbMu/JOW/nJ
         qbdqQyMTJo0y2BAh2od7xUVGKjmdwjuOA4rwSl3fXIbInmf8zZijfqpV7FowIT+BxCyv
         yTdMjWf+jNZ71zgRk4LQQDzEkOfyt1VSHcuQ5fPxRP6RDt0SB3e2MDFLt86vCPjPeLdY
         MDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZ6GJC7hEGwULDynH0oTCtdmn91ovRHlyRCH+X3ZTes=;
        fh=swyzE5s4mE8cjlx7xKZYqcbSuYvVVaGd5gUz5M1BxW0=;
        b=YFMUInGgN0RjdiLc7fKe5FlJ8PzszwDMFkYllI7n+x+SGnmWi9DCSXEIDjJNMJCpy2
         EFGEfxiFxwYeyiJvgm8gvbPRXC0xLvnHOqDWdw3YnuVfq3oOg/w66YKRW+9f3piyi7uR
         6WMLCzE9iUSZBqU4uzZ16PeQdYY9xyNrbcQBrMBz9mTf/Ph3+y51p0hmkZPqm2YKTEjr
         bGYs9HzfWFalrUZar1yx5kTGdEWyOpmznG7NPjIH0JOKtmv18rr6dZkR0GQXtZDAsi3S
         cC8jeQkyJUX2bZ0T6rylpU5hbJ1ff9P7YrysulRc28IyCYbM8y2zWzs1JQNDSvcF+QkK
         1o3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794507229; x=1795112029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rZ6GJC7hEGwULDynH0oTCtdmn91ovRHlyRCH+X3ZTes=;
        b=QAOT/jUa1ge+FjhwHcidPWqHm+YYo2QRnirCuBNYMGRauQmP4nWTzYMNyQy+u3k+zu
         tKbYvx+UacipiubMSX2t0aNrINRm7JGqNgE4HnDn5ONmnfqtBlekoPiY6RyY8TJZdqB2
         iMPSQi99rEXSAFVRN+O5374t02u1cDpUtC9gCdwxOQi1tDaoYnuxIHmFNDKqKWxTLKbS
         yD/UvRB7ECUE0FZhxd0sv0OzKQeI5b7SSgNPE5jKeoEhoVTsDve8pyILpbnScp/cH0k9
         e0x9cHDKovRAfsJLx0KDxuQYUQ4dTbRAqXvjFi+foSzaKIMiYm0P/fJ4606JrVpwnrVb
         ZQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507229; x=1795112029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZ6GJC7hEGwULDynH0oTCtdmn91ovRHlyRCH+X3ZTes=;
        b=rYmpX7pWcX2E9ET2w/DjSCkxhaHr8A7tMwWHpx2pr/r8WR3DfJDYv+EX/QiIB/qR/D
         77k6zBwf5Kl+W4/lb5EapH8SpH+z4KudqIglqkyzlLyLOUY2EDnsjcIRSrYY8FYX11aN
         Eq1I0Ix1bgOkHYSxient5HgONqx4MkRLCVDfp0rm2EBfpYx/qaq8TT3mXEuwxkDf0mUE
         m1bKTnGkVlwPYXcfjGePSv+y0P5M0i+gnDwXzHZ0YvMpRc7El6FRf5JwH94GeZ9cTFGt
         QMtCqTewspvW8lEVcM3ct11tiJ/ecsLvjmBNCwVC0KrVmLo8Y+CnnvY1JcHOmJ8eANxx
         3GHA==
X-Forwarded-Encrypted: i=1; AL+hErHDPUXNx7FLZf3tgur1kvmbMIwO4EaOZbBAA0iuTrLqo+PCRVnc9oyvJDjMpMQppAD2oAjUoY18BUpGsZMXefSR@vger.kernel.org
X-Gm-Message-State: APuU4Z/zjm585MLJI8w36A5E3w3Bg8CUAc3G6BfgY09xbRYB3DtwOphW
	TyW8Yyr/YXHSyiC6y2+wBJ4NxAAHzRqC1FSWTUX6JsGe2vBrZgi+glZ6hhbl+WKG3M0qaBcKPh+
	QU26F+eZ6sbOQLWuzFtyKnFh8VAFSC0SYp9qujn1f
X-Gm-Gg: AYBFou1633NrfyeZVKUDMfgMGw7ZQSH6mHw+98ExqK8FnVN2as+vUC3i3IcsmEiUK6s
	JU3iXlqk5qdGqI2KMnnu69yI1XCjR7DY2sViLQSQ0lnextiCDQay0iPZQsoH8JedFg7NLSYnCP/
	WfLaeWe0KXTlwz+aKkx5DW16JHJWx36fbEamLw2GxJBYINNfz9WN8YbjHhpq0VqTK4p+TZeCDta
	ytDd9OfiY+oJdcBwyJ4RoT0fae2pd5B+O4/tGvhWa+jcK49pc2YAQn7jvq6qUuChBMqipCfk9B1
	hyXO4cZouCSgOQJnx1e8ea2MggeceQZKedeBNMr8Saa+P76f6RTO+KnKLokfwUBBAEjAfP8IZnS
	5/TxIqfNQKQcPNLa2g76PN1vWyAL5AWtvv2U2+3P88a18QzFigtpWC09z+4SCUSdMi8w=
X-Received: by 2002:ac8:5c84:0:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-5598d505571mr21838081cf.9.1794507227881; Thu, 12 Nov 2026
 10:13:47 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104043006.1199857-2-irogers@google.com> <d94520950f855a1d5ac4b51975988b70185ba7da61836aa84b044b69e8104bbc@mail.kernel.org>
In-Reply-To: <d94520950f855a1d5ac4b51975988b70185ba7da61836aa84b044b69e8104bbc@mail.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Nov 2026 10:13:35 -0800
X-Gm-Features: AclHuK_VHOAaoYtWAecnECui2dC3TEgW3VbUrZGpnHMy0F3WB50lMjG2hgO8I_c
Message-ID: <CAP-5=fWekVEnxS_eSGsrCPM2XzoY=Z5fkYYK_dD6MGgxX3N2gg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] tools build: Add explicitly sequenced -lzstd to
 libbfd feature fallback
To: bot+bpf-ci@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	qmo@kernel.org, jpoimboe@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, james.clark@linaro.org, leo.yan@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, martin.lau@kernel.org, 
	mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:03=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > tools build: Add explicitly sequenced -lzstd to libbfd feature fallback
>
> TL;DR: Possible build break at this commit: the libbfd -lzstd fallback is
> removed but no consumer uses the new feature test yet, so perf may fail t=
o
> link and bpftool may lose JIT disassembly.
>
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
>
> [ ... ]
>
> > @@ -249,18 +250,21 @@ $(OUTPUT)test-python-module.bin:
> >       $(BUILD) $(FLAGS_PYTHON_EMBED)
> >
> >  $(OUTPUT)test-libbfd.bin:
> > -     $(BUILD_BFD) || $(BUILD_BFD) -lzstd
> > +     $(BUILD_BFD)
> >
> >  $(OUTPUT)test-libbfd-threadsafe.bin:
> > -     $(BUILD_BFD) || $(BUILD_BFD) -lzstd || $(BUILD_BFD) -liberty || $=
(BUILD_BFD) -liberty -lz
> > +     $(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -l=
z || \
> > +     $(BUILD_BFD) -liberty -lz -lzstd
>
> Can this leave perf and bpftool unable to link libbfd at this commit?

So the concern is that at this commit, not later in the series, a
feature test for a libbfd built with zstd that previously failed to
link in this feature test will now succeed, but the parent Makefile
will not pass the -zstd flag and so break the build. This issue is
fixed later in the series by adding the -lzstd. Will this impact
anything? It will turn one broken build into a different kind of
broken build. I can reengineer the series to maintain bisectability
but this seems like a low priority issue to address.

Thanks,
Ian

> Nothing here reads the new libbfd-liberty-z-zstd result.  Neither
> tools/perf/Makefile.config nor tools/bpf/bpftool/Makefile calls
> feature_check for it or has a branch that uses it.
>
> On a system where "-lbfd -ldl" fails but "-lbfd -ldl -lzstd" links, the
> parent commit gave feature-libbfd=3D1 through the removed fallback.  Here
> feature-libbfd, feature-libbfd-liberty and feature-libbfd-liberty-z are
> all 0, while feature-libbfd-threadsafe is 1 through the new
> "-liberty -lz -lzstd" fallback.
>
> With BUILD_NONDISTRO=3D1, perf's Makefile.config then passes the threadsa=
fe
> check but takes none of the EXTLIBS branches:
>
>   ifeq ($(feature-libbfd), 1)
>     EXTLIBS +=3D -lbfd -lopcodes
>   else ifeq ($(feature-libbfd-liberty), 1)
>     EXTLIBS +=3D -lbfd -lopcodes -liberty
>   else ifeq ($(feature-libbfd-liberty-z), 1)
>     EXTLIBS +=3D -lbfd -lopcodes -liberty -lz
>   endif
>
>   CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
>
> util/libbfd.o is still built, so the perf link can fail with undefined
> references to bfd_openr(), bfd_check_format() and disassembler().  bpftoo=
l
> goes down the same chain, silently drops -lbfd and -DHAVE_LIBBFD_SUPPORT,
> and loses JIT disassembly.
>
> The consumers are added later in the series:
>
>   6eb66acc776f ("perf build: Add explicitly sequenced -lzstd to libbfd
>   feature fallback")
>   155513d3a59d ("bpftool: Add explicitly sequenced -lzstd to libbfd
>   feature fallback")
>
> Would it be better to keep the old -lzstd fallback until those consumers
> land, or to reorder or squash so that each commit remains buildable?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/417749=
22004
