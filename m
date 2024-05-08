Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160C393
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210345; cv=none; b=CKhrBld8hYSCJo5UielDMS3qwL9Q92wS9xOO8D6kPH2xlBy6LKsH+TmyT6r6g1cVZeeOvtvjcjT4EVyHcCgwx/oFL0793N+WzKWdhBTI2+JX/E/Mtm//XVXlh7MsJC1utkc/SzLiAIUNs2x2ZprZUVRtnGbbjd9mu83R1biaV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210345; c=relaxed/simple;
	bh=OiNB3/cDYuUdfUbV1+fECaBooWhKPWeutLbF3YpqoJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsKL1Vr9BkOwKdlhuqwYQKB7EgvcPuQtQQ3MWfUckXwJYaDlhpVmDVTgxhCDjU7HB3dWw1m4GWHdDBLEFC3g8rgvUgcTUpgecgdnyLOUXNXFEg+87wDDyx7z5sP7UK2tqHHHTkjPsSdkYvB2hjGV2iBlgN/GzOXrxytf66AeuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpYyDBSi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpYyDBSi"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43d55133609so62561cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715210343; x=1715815143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDBlHx5ATABpMS7xQNpK1O16Vnpbp53v+71gVmyOflY=;
        b=EpYyDBSiF9pZydmON/AajAD2/ceVwM+PHAjM2a8RerOP95XFp/0hK1nIlQjmBYqlKk
         9lGKdjHzdbUtMKKm7FGRCsKfWY9dJwmAh3Wb+lIcS8VbtZLS0dnZoIzl4GtMfImL1Tvo
         fDtmvs2qjoR4c31IucrPNGH/z3hyzJS4kx3MeTY0oTyIElVaWqSTAfArN+S8yXiyxtAi
         FeupDhHNckKqOOmCrj2C9sv+nvH7ViM9DI5Q2K1+qdhv0yReDKN8cWj1/aEzT1g3UU3t
         pakBn7oArN13pvZhyyKGZgoYuOaWWXEXlJP1Sp+A+Y5wCtgCUeEIV0woRPg4sgRsMszf
         7e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715210343; x=1715815143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDBlHx5ATABpMS7xQNpK1O16Vnpbp53v+71gVmyOflY=;
        b=OZFgDGdkQusLs+/whsWS1Z97tMWMias91AIC+fUgd7lHamiMbXHh5tn83aL8zxjmXx
         6A8RtkU2S4D/4zuscH8NKdmDcaV9SDnTVYx0nnqYcci2SbtskV0Rf5pGF9gVBCBsxEh5
         RpK0Ih8Y26LJoLDQdGLLcG7TqJZvZPLRr3qF9qKz0f/CMFhEPo+XI4VZsYEqCU8Dr79u
         9fH19mjyYYU5i4ih91qoDLF0KiGFTiUlHkSXndanYc5dJfMJyaGJ7PFlZPhpwgQa3jhB
         x+ITlow5W8kOK9pueCW7ZdDUkVK4JBqZlO7QbnHvlehCnHO/cpCB8Ry/zi7TE0gKOOJS
         zOsg==
X-Forwarded-Encrypted: i=1; AJvYcCXnHJU20mNtYFyPgYAQn0/NJrkj5p9rpTAaaF46sM2hHcY2mgAiPPFUKY63NxTIQnWFAtLvroPar7fgym9j2A55G59L0KuAZJANyxkMjX3Jlg==
X-Gm-Message-State: AOJu0YwJwDOmrOuzXeC6+/cc1jCoi960MbGCgmLQarE97fCrG51pqiWT
	ODO6LE/eQRLu39TAI37tYjwigDlDziks6y3EV1MVHG3X9MG+bUWsPuNLfOE75EtR3wcxtnfDaIE
	o3lbo+8KWSV0d+SP6RyG9c0TkL67Xt1HXMlmR
X-Google-Smtp-Source: AGHT+IHN6UkD/4Gv6PjBxfRZ8th4Maz5mHqvhrx6UR/Ga7ncyaOX4VpXz+Tyyem8Rz8SYvlZ4POD+mRRG+vjOv8gHEM=
X-Received: by 2002:a05:622a:98d:b0:43a:b8f3:f079 with SMTP id
 d75a77b69052e-43defba1d13mr1557401cf.20.1715210343018; Wed, 08 May 2024
 16:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506081648.3890067-1-yangjihong@bytedance.com>
In-Reply-To: <20240506081648.3890067-1-yangjihong@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 16:18:51 -0700
Message-ID: <CAP-5=fXYH4JnfQH98vPRttViBfYAWGA-aoGXO7q+R_Wt8AqFSw@mail.gmail.com>
Subject: Re: [PATCH] perf build: Specify libtraceevent dir to rpath for
 asan/msan build
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 1:17=E2=80=AFAM Yang Jihong <yangjihong@bytedance.co=
m> wrote:
>
> perf built by asan/msan will not search for shared libraries in the
> -L directory. For cross-compilation, we assume that sanitizers is
> generally not enabled and add libtraceevent dir to rpath in a simple way.
>
> 1. msan build
>
> Before:
>   $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g -fn=
o-omit-frame-pointer -fsanitize=3Dmemory -fsanitize-memory-track-origins" C=
C=3Dclang CXX=3Dclang++ HOSTCC=3Dclang NO_LIBELF=3D1 BUILD_BPF_SKEL=3D0 NO_=
LIBPFM=3D1 LIBTRACEEVENT_DIR=3D/opt/libtraceevent
>   ...
>   $ /tmp/perf/perf
>   /tmp/perf/perf: error while loading shared libraries: libtraceevent.so.=
1: cannot open shared object file: No such file or directory
>
> After:
>   $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g -fn=
o-omit-frame-pointer -fsanitize=3Dmemory -fsanitize-memory-track-origins" C=
C=3Dclang CXX=3Dclang++ HOSTCC=3Dclang NO_LIBELF=3D1 BUILD_BPF_SKEL=3D0 NO_=
LIBPFM=3D1 LIBTRACEEVENT_DIR=3D/opt/libtraceevent
>   ...
>   $ /tmp/perf/perf --build-options
>   perf version 6.9.0-rc5
>   <SNIP>
>            libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>   <SNIP>
>
>  2. asan build
>
> Before:
>   $ make DEBUG=3D1 EXTRA_CFLAGS=3D'-fno-omit-frame-pointer -fsanitize=3Da=
ddress' LIBTRACEEVENT_DIR=3D/opt/libtraceevent
>   ...
>   $ ./perf
>   ./perf: error while loading shared libraries: libtraceevent.so.1: canno=
t open shared object file: No such file or directory
>
> After:
>    $ make DEBUG=3D1 EXTRA_CFLAGS=3D'-fno-omit-frame-pointer -fsanitize=3D=
address' LIBTRACEEVENT_DIR=3D/opt/libtraceevent
>    ...
>    $ ./perf --build-options
>    perf version 6.9.0-rc5
>    <SNIP>
>             libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>    <SNIP>
>
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/Makefile.config | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..a9a923358604 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -188,6 +188,10 @@ TRACEEVENTLIBS :=3D -ltraceevent
>  ifdef LIBTRACEEVENT_DIR
>    LIBTRACEEVENT_CFLAGS  :=3D -I$(LIBTRACEEVENT_DIR)/include
>    LIBTRACEEVENT_LDFLAGS :=3D -L$(LIBTRACEEVENT_DIR)/lib
> +  # Specify rpath for asan/msan build. Generally, cross-compilation will=
 not enable sanitizers.
> +  ifeq ($(findstring -fsanitize=3D,${EXTRA_CFLAGS}),-fsanitize=3D)
> +    LIBTRACEEVENT_LDFLAGS +=3D -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
> +  endif

Thanks for this! I found I need the following to make it work:
```
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a9a923358604..bcf4ab292462 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -190,7 +190,11 @@ ifdef LIBTRACEEVENT_DIR
  LIBTRACEEVENT_LDFLAGS :=3D -L$(LIBTRACEEVENT_DIR)/lib
  # Specify rpath for asan/msan build. Generally, cross-compilation
will not enable sanitizers.
  ifeq ($(findstring -fsanitize=3D,${EXTRA_CFLAGS}),-fsanitize=3D)
-    LIBTRACEEVENT_LDFLAGS +=3D -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
+    ifeq (${IS_64_BIT}, 1)
+      LIBTRACEEVENT_LDFLAGS +=3D -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib64
+    else
+      LIBTRACEEVENT_LDFLAGS +=3D -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
+    endif
  endif
endif
FEATURE_CHECK_CFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_CFLAGS)
```

My libtraceevent build command is:
$ make EXTRA_CFLAGS=3D"-O0 -g -fsanitize=3Daddress" DESTDIR=3D~/libtrace in=
stall
and I build perf with:
$ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g
-fno-omit-frame-pointer -fsanitize=3Daddress -Wno-error=3Dunused-function"
LIBTRACEEVENT_DIR=3D~/libtrace/usr/local
I'm checking which library is used with ldd.

Thanks,
Ian

>  endif
>  FEATURE_CHECK_CFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_CFLAGS)
>  FEATURE_CHECK_LDFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_LDFLAGS) $(TRAC=
EEVENTLIBS)
> --
> 2.25.1
>
