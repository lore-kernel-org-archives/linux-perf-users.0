Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4E63D
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Mar 2024 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711220892; cv=none; b=DR1YP2q007MDXLXTiv7bc1msP6QZ5uG3FaIWH2NnJKsDPwuiuBsrSJwQuyKA/1jAmJVLN5RnC2K4RFLayxj+/BVG/0mLYvNY7ecuq3Y9ryk7aSspVv03ag1k2mYT5q5qaoIX+e21IIQuXQlNhtRqOCDtzZhMLddFcpN5475mJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711220892; c=relaxed/simple;
	bh=7Iro+9xDOqNg9CTZQBUlnao7XkvqozuGgTVgYnkNB/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4xKc3uIKoyQNvY5GtgcIxY5v6G1WvdhPE+46AL5i3+k6N6hap8jKTeSNqyMl63BYrZ5AXyrFFJX6Nwaox1gTxepM4SyeIdqG5Vyw5BWp/AS/5cOimUxyWnOglj1Zln+3c+zjvoLgziAYNQgAfL/eKcrhfzqYhHMPJcGIxakYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=im5lK+KH; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="im5lK+KH"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-366abfd7b09so132145ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Mar 2024 12:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711220889; x=1711825689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRJv7CURqWbrAFFKuvlaXyG2Lcdz0F6vWumzCI2C+dQ=;
        b=im5lK+KHbQkOu2JZ6acpS24yOCs+RcVUcgV4fOTW5buZRe6LIBBZOM7eEjX1xUiUmb
         LIev3xd5GVSOPjGl+PkvKhvektM0+mI1nKJ8jlI8QgOIV0cyGZs9zLiNOLo7X3A8L8AE
         LZ4BLKKgxAEP/wafgV2yaJhSqnX7HrSaeaAjVR5XK9lZujNf2uTTEWmdABRsuLFQSk3o
         y5KjWwWNqJrMGANMD4k+e8kQduLG0a7eR1tf/PgGCBFDrdwsuY933RLQY76CG6KKS2Yb
         y7q9lYzXJo8Yos5IwmLk3+RcpS9yL/ZLzz0v6js0W+1sc4XNv9oKhDYE8fbxnhxl5xgv
         po+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711220889; x=1711825689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRJv7CURqWbrAFFKuvlaXyG2Lcdz0F6vWumzCI2C+dQ=;
        b=EmB6NVCbMcsZz2VKW+f+dNLWj30vGaRNhG+iDPifNvznj5lhB/y+ofunSLdbv3qqiy
         QcrjrVgrT66PUZVWEYonhHhRN32ded4TpxMxDH36reXvuD2Ci+nc9Pj42b/c/20HmMbE
         JBxCGUCzEkQhisNM29fjjzxHN6f2ftckiIi1Lxuiki+FvRx0zTnHceKWUBUVhu4RpP7T
         Go37tovpEYE4+M4CPgWlpDoXf1W4O4bUCt/APa7GPFmYTBBuZkmxjr6fu6/LRFIAI1vr
         I1Z9h3NOcDeoHRYIT1wnTBtHveXIMl5bsVwmBO4mszK8otuJ5+Y8E+EUX3aJAgvl/bMM
         7tbw==
X-Forwarded-Encrypted: i=1; AJvYcCVMygfSxAQH34W+kdW5T3Zhfg7YmPPrtZWhyNGLydwkW4IJbVLDEHgBv6g+p1ghnMHbKaULBsRIi5T7rTLRGkjn7AAWJfpCilzqEUs56+gZrw==
X-Gm-Message-State: AOJu0YzPe/iGilXjy2e4nGtulgZwzfFWp+/0x8SWbjmHCIORt3I/pRGU
	FB0g0moz1Q4XXKCo/l4Rz347MOPjRZPxDwOO61kD4un8c+zt20SfD4qVdAWTdYjC3ueUuvTLLWq
	ejnsYdyKcaNiU/8DEOskKbpcmA8KnlWAPwpBO
X-Google-Smtp-Source: AGHT+IF5yAHfPJf5Nt+uwyVZ9kReMNd2EFfMpFYhXgWwSp95GTASf3aKWdk5kRFHu2rn19V8nBIHm/h5z67Z9NdhxDA=
X-Received: by 2002:a05:6e02:20cc:b0:365:239a:e745 with SMTP id
 12-20020a056e0220cc00b00365239ae745mr739834ilq.27.1711220889515; Sat, 23 Mar
 2024 12:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314063000.2139877-1-yangjihong@bytedance.com>
In-Reply-To: <20240314063000.2139877-1-yangjihong@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 12:07:58 -0700
Message-ID: <CAP-5=fV--O=QB8To+cbR=C06JzPqBFLFYTc1oh9gJZwBQ3BE=w@mail.gmail.com>
Subject: Re: [PATCH] perf build: Add LIBTRACEEVENT_DIR build option
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 11:30=E2=80=AFPM Yang Jihong <yangjihong@bytedance.=
com> wrote:
>
> Currently, when libtraceevent is not linked,
> perf does not support tracepoint:
>
>   # ./perf record -e sched:sched_switch -a sleep 10
>   event syntax error: 'sched:sched_switch'
>                        \___ unsupported tracepoint
>
>   libtraceevent is necessary for tracepoint support
>   Run 'perf list' for a list of valid events
>
>    Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
>
>       -e, --event <event>   event selector. use 'perf list' to list avail=
able events
>
> For cross-compilation scenario, library may not be installed in the defau=
lt
> system path. Based on the above requirements, add LIBTRACEEVENT_DIR build
> option to support specifying path of libtraceevent.
>
> Example:
>
>   1. Cross compile libtraceevent
>   # cd /opt/libtraceevent
>   # CROSS_COMPILE=3Daarch64-linux-gnu- make
>
>   2. Cross compile perf
>   # cd tool/perf
>   # make VF=3D1 ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- NO_LIBELF=
=3D1 LDFLAGS=3D--static LIBTRACEEVENT_DIR=3D/opt/libtraceevent
>   <SNIP>
>   Auto-detecting system features:
>   <SNIP>
>   ...                       LIBTRACEEVENT_DIR: /opt/libtraceevent
>
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>

This all looks good to me, thanks!

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/Makefile.config | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 1fe8df97fe88..7783479de691 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -182,6 +182,16 @@ endif
>  FEATURE_CHECK_CFLAGS-libzstd :=3D $(LIBZSTD_CFLAGS)
>  FEATURE_CHECK_LDFLAGS-libzstd :=3D $(LIBZSTD_LDFLAGS)
>
> +# for linking with debug library, run like:
> +# make DEBUG=3D1 LIBTRACEEVENT_DIR=3D/opt/libtraceevent/
> +TRACEEVENTLIBS :=3D -ltraceevent
> +ifdef LIBTRACEEVENT_DIR
> +  LIBTRACEEVENT_CFLAGS  :=3D -I$(LIBTRACEEVENT_DIR)/include
> +  LIBTRACEEVENT_LDFLAGS :=3D -L$(LIBTRACEEVENT_DIR)/lib
> +endif
> +FEATURE_CHECK_CFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_CFLAGS)
> +FEATURE_CHECK_LDFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_LDFLAGS) $(TRAC=
EEVENTLIBS)
> +
>  FEATURE_CHECK_CFLAGS-bpf =3D -I. -I$(srctree)/tools/include -I$(srctree)=
/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
>  # include ARCH specific config
>  -include $(src-perf)/arch/$(SRCARCH)/Makefile
> @@ -1165,9 +1175,10 @@ endif
>  ifneq ($(NO_LIBTRACEEVENT),1)
>    $(call feature_check,libtraceevent)
>    ifeq ($(feature-libtraceevent), 1)
> -    CFLAGS +=3D -DHAVE_LIBTRACEEVENT
> -    EXTLIBS +=3D -ltraceevent
> -    LIBTRACEEVENT_VERSION :=3D $(shell $(PKG_CONFIG) --modversion libtra=
ceevent)
> +    CFLAGS +=3D -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
> +    LDFLAGS +=3D $(LIBTRACEEVENT_LDFLAGS)
> +    EXTLIBS +=3D ${TRACEEVENTLIBS}
> +    LIBTRACEEVENT_VERSION :=3D $(shell PKG_CONFIG_PATH=3D$(LIBTRACEEVENT=
_DIR) $(PKG_CONFIG) --modversion libtraceevent)
>      LIBTRACEEVENT_VERSION_1 :=3D $(word 1, $(subst ., ,$(LIBTRACEEVENT_V=
ERSION)))
>      LIBTRACEEVENT_VERSION_2 :=3D $(word 2, $(subst ., ,$(LIBTRACEEVENT_V=
ERSION)))
>      LIBTRACEEVENT_VERSION_3 :=3D $(word 3, $(subst ., ,$(LIBTRACEEVENT_V=
ERSION)))
> @@ -1175,7 +1186,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>      CFLAGS +=3D -DLIBTRACEEVENT_VERSION=3D$(LIBTRACEEVENT_VERSION_CPP)
>      $(call detected,CONFIG_LIBTRACEEVENT)
>    else
> -    $(error ERROR: libtraceevent is missing. Please install libtraceeven=
t-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=3D1)
> +    $(error ERROR: libtraceevent is missing. Please install libtraceeven=
t-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIB=
TRACEEVENT=3D1)
>    endif
>
>    $(call feature_check,libtracefs)
> @@ -1301,6 +1312,7 @@ ifeq ($(VF),1)
>    $(call print_var,LIBUNWIND_DIR)
>    $(call print_var,LIBDW_DIR)
>    $(call print_var,JDIR)
> +  $(call print_var,LIBTRACEEVENT_DIR)
>
>    ifeq ($(dwarf-post-unwind),1)
>      $(call feature_print_text,"DWARF post unwind library", $(dwarf-post-=
unwind-text)) $(info $(MSG))
> --
> 2.25.1
>
