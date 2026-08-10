Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266943552D
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385276; cv=pass; b=msn4ex3DkC2QxQWrYzX0GKXVQa7R7srsJYbUS8B0baEcbTjdZW4jW7Ut08fotPXRP0KqKei4pJ8HqcV7LKnc2QQozMaqj3CMKMByKHKZkDutLoGIrYwKE3cT8Q0FslOrVqKPDVV6zsOaX2EoIYI0payeOzi2aUCGWHasdZYmuQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385276; c=relaxed/simple;
	bh=iHqM3Q8HCHghtAETU6ilDjQNevj5DZ/8n+SZYpFCRRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd3PTqfLmp/LYehXW78jcQNItPVZbcw2hvMqrpK4z7HqtZnIUAD2OKKT3GkwP9ig3vhnBGz3relWYpsFWlfchRyUqf7D11mR9E4ObtRJ0/XEQX5+8lpqyX7QIiT+3bsN5cT/a1XL+7yn7qZJyUUXeNGgTV85qX3bv26+YOC/lUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmZh1317; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmZh1317"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c10e86e52so21631cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 11:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786385273; cv=none;
        d=google.com; s=arc-20260327;
        b=PBf96u/kgj3M4eMgvhypOG6uC2biXIN4l8g7m5EKbrXiBXJdiswF1bMMb4lhd0Um7U
         PLvQ9rT4MhdaF2BtZrjRheIe0sf0ni7+UKQFMqx/RBYNLCJUUz10DrjTg02ogWr1dT3i
         t4na5BkKzVMjPdKp3dmdo8AS3yZyyc71hY6cj8xNMNBT60LVIdZaA1MPNo7EbdGgL9Jd
         XGdS/EtfTlacz/O0ePYGn3yGLIUFwLHV9ZxaCdjkJBwVtjPrGirhmgRW8ARjD7hTTnSq
         a9R4nj0o9PnaFcIf9ohxZtVNywevpdL3icGMR4Hvs7yaej2XFur60ka+he+ZwqvoIfP4
         K/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8KxD4/O8Zn5wNND+ehyszrHU5PvhiHdhU7NgQDwvKmU=;
        fh=FRhnLm+ruJHMmn+CUII8j1cTABYG8JCzhU9Vcu5IEIQ=;
        b=Zje53+uP3dUmEhgmU8zhlp/3a3YRIE69gczDNVT27OhL70lZ4qGC2mzbjVM75f82b2
         eKcK2tr3dlIbrDMkeRLl5tSdID3eHCmAozgRc4CNrkyi8zf1MjVw+qpu0QPWYgEkX/AM
         ha3T7YA0N6Z2PflGaPOLtvLqrOBvog4ly+dc67uC2YWOkqP/ueTz4BLYBXhwWSVvXLUa
         Mtw3CueJ14Y+Q2o46q7ZbhEKPqt1aIX3X+HnW9GL1amiUtm91o8BPvi0yA/Zqamd0KZx
         gKkOve1+pnHZq6P23f/edQBoXGef5bfoHxOdQV3tZRc7rAU1l18r/Giuk+x7osgPVN9/
         1d/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786385273; x=1786990073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8KxD4/O8Zn5wNND+ehyszrHU5PvhiHdhU7NgQDwvKmU=;
        b=pmZh1317ouHLsBUEzsKfd8m8glqoOzwsF8hD413PcUw80aDwmMiC1MZBVg2ilMEZsw
         aunvwmVSHaNAaoHLbctNThnSsX8296ttSw9rO3ltqdZmx/vryUmS7nyw4EjHk+fY71Ey
         0D8Qql1dYSP+i3A4cw7LJQcObRbTINuvPnUbypy/WDwzQOBzWjnLDWEoNrFR1V+fSTUn
         xjRfSZI1DiUij/JuDXu50YHgSYcMZAQOur9aAOCNkA4sxai0A9DaapWu4LpIlhdQyFAS
         l9knPTsaRtj+dDsNuZpf0jor5IpZSi9POwEVrnSRzmbhthc4LrK1t1inFWW6w+o+ErvZ
         wl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786385273; x=1786990073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KxD4/O8Zn5wNND+ehyszrHU5PvhiHdhU7NgQDwvKmU=;
        b=ACROI8qYRwiy5fiHdHzkoOZMae7/aTkegfcZAlNFNKBc88chHetpQmF2m9ePrsF696
         d8KAG2x4OpzNFlGdeapoZ0ENh10DmlgXDpgVA3ReqESHoYya40RfSf0BK5SBgndFhNdY
         3WGfvVg41hQCD54joL5nfG1CISfAvjGMaEZCb24iP1U8jAgIDWQ4xHk+fNV7t6e809Oq
         64ZJTQHAgG/N36i1NSgtjBbCKI/fLSnlT/0IG4Kfwr+Rw9GaoeomaJawem/oAISzuuLb
         eafawY8z/7FqFuR38R9KpawzNzBKJ3NW9NLtIGIzkQI/WmLo8jsrabeOiMr2TrAk3lMp
         MBCA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0Ekxnw//WzS8iQTnvkZ2hIH0xeNoMmBtBMOXFNR2Nj8KPt1mwl/KBNjB4oS0amrmQiYO2chCf4hU/XEIa0hZR@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrU5bX89vIJUCKEfc9E8Zqr3uLEVlxefsflTV7VPjA2tGCPHs
	do2KzdkFcTPMfxnFEcPIFXOtvvUp3EViGpPS6SGA5kqN2EwIvz9mS9OCy8GmR5i3Vqco+Rfa1+V
	KQ7e6lZOmTZoA2dZYxsCQ215KSCM2+9EitMJg538NcBrRXgh84Hj1+vHiZgw=
X-Gm-Gg: AR+sD12jEa01RdvclDfeF7ROQ+DIkh8Xrt9lsLtJy3JFpsZiCB0AdHC8uknASpzyrYX
	IFBdtQgSk7QRcXWIVM/erDw3FCEvHtfI18l0G2ALBH9WNuTJcgWujgMA2t6AGsAoMmjwn6hYx/P
	kJJrz6jRmqf0QQo+uLeK1hkiOaYDYx/z0dxtM0fvO8X+5xWEs9rGtJE4ZIn7SURhrk7Tt1t8Uie
	zW2I9+8+C97wXgeI2xMzzprOWUg9p1aN5vqXSZeSbIT7IWr2uuzXiKVmcwJD6kkc1n28lqMkXcV
	Zw/6Amz7zvTbMMNSl0iJrg3QCg0E3uW4sRFRrcpX9oud3Q==
X-Received: by 2002:a05:622a:6d06:10b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-52d51275b91mr1203331cf.7.1786385272185; Mon, 10 Aug 2026
 11:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810154437.15946-1-acme@kernel.org> <20260810154437.15946-2-acme@kernel.org>
In-Reply-To: <20260810154437.15946-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Aug 2026 11:07:40 -0700
X-Gm-Features: AUfX_mzLSbuAN248IIKha6KxZIxBjQYeBZiscU9Tsel94nT2TJkl0xnO_OVSeaU
Message-ID: <CAP-5=fWRQuo29kBXzOP9jobO6rcTPqZ5PLt42G+0+0Rh2tm7bw@mail.gmail.com>
Subject: Re: [PATCH 1/7] tools build: Only probe the compiler at parse time
 when it is installed
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 8:44=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Two parse-time probes still invoke $(CC) unconditionally:
>
> - LP64 in tools/scripts/Makefile.arch, probing with
>   $(CC) -E -x c, pulled in twice by tools/perf/Makefile.perf;
> - CC_NO_CLANG in tools/scripts/Makefile.include, probing with
>   $(CC) -dM -E -x c /dev/null.
>
> In the corner case where gcc is not yet installed, the very setup the
> install-build-deps target, added in the next patch of this series, is
> meant for, these probes make even targets that never compile parse-time
> spew errors like:
>
>     /bin/sh: 1: gcc: not found
>     /bin/sh: 1: gcc: not found
>     /bin/sh: 1: gcc: not found
>
> Guard both probes with 'command -v' using the first word of CC so a
> missing compiler is handled silently with the same result as a failing
> probe (CC_NO_CLANG and LP64 unset/0), and with no behavior change when
> the compiler is installed.
>
> Only the first word is consulted because CC may carry arguments such as
> 'ccache gcc', and shell implementations differ in how 'command -v'
> handles multiple words (dash only checks the first, bash any of them),
> so validating the whole CC value would silently disable both probes on
> some make SHELLs.
>
> Assisted-by: opencode:deepseek-v4-flash-free
> Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/scripts/Makefile.arch    | 2 +-
>  tools/scripts/Makefile.include | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
> index eabfe9f411d914b9..e0bca6808ec44ed8 100644
> --- a/tools/scripts/Makefile.arch
> +++ b/tools/scripts/Makefile.arch
> @@ -38,7 +38,7 @@ ifeq ($(ARCH),loongarch64)
>         SRCARCH :=3D loongarch
>  endif
>
> -LP64 :=3D $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
> +LP64 :=3D $(shell if command -v $(firstword ${CC}) >/dev/null 2>&1; then=
 echo __LP64__ | ${CC} ${CFLAGS} -E -x c -; fi | tail -n 1)

nit: It might be worth adding a comment to explain this fairly complex
one-liner.
As there are minimum requirements to build the kernel
(https://www.kernel.org/doc/html/latest/process/changes.html) does it
make sense to be defensive about CC not being installed?
Perhaps install-build-deps.sh can be part of the wider kernel build
with flags to specify if you are building the kernel or a tool, where
depencies are different (e.g. perf doesn't need quota-tools but
libcapstone is useful).

Thanks,
Ian


>  ifeq ($(LP64), 1)
>    IS_64_BIT :=3D 1
>  else
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index 46a3872b87624a7b..fff453aac187536e 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -98,7 +98,7 @@ else
>    $(call allow-override,LLVM_STRIP,llvm-strip)
>  endif
>
> -CC_NO_CLANG :=3D $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang=
__"; echo $$?)
> +CC_NO_CLANG :=3D $(shell if command -v $(firstword $(CC)) >/dev/null 2>&=
1; then $(CC) -dM -E -x c /dev/null; fi | grep -Fq "__clang__"; echo $$?)
>
>  # Some tools require bpftool
>  SYSTEM_BPFTOOL ?=3D bpftool
> --
> 2.55.0
>
