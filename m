Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A10F9C0
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2025 06:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764916208; cv=none; b=m5fuqXmg4osYwQn+I33aSYCDk4ikcpY0jOqkG2P/PTtTPYI/IdiKZvksWWcaTHAn6eDCOfattSqk4ZAhFt4f8ObmsiTTQEoTzLCx5GfQoGgjuws2G39KaSW6L/oXIQ9jijfV8SahKfJbdvv6dWv4IhwbVPdxAWLNHX1spbHQicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764916208; c=relaxed/simple;
	bh=7kCHTFSgNFkM+HqHco4WGE3HSiUaDzBvUT8m4H2A/xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6XHfifzAbRoGHDqtCMENBNjChyUo+SXZM8lkkic6Nsd2cCGXpHnQPjL9tAsTYWaFUC6BkoeymxSJzX8UKlOa6LuoFV0mgCHfVA0et+lSH4fn2OHo8HO0oF+2Xi8MCb2H1F45XnUtFLG8sQP471r4W1/I/32udfEwZeL3xexIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOMRDo/1; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOMRDo/1"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-37a2dced861so24246741fa.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 22:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764916205; x=1765521005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/N6cIVpJoY6gbZ5Y5Z8pBbxkt661DUursq7AFn6Eu80=;
        b=LOMRDo/15UsnBDGAA1nG63RJ04rm5NtmdibP0NxpK/795gX0CGxzl+AbutIzvXkB6F
         AoPqE/8EfTxAo3m/ZY+8mpy2FpWBcQU/sOEedNb0/GddUT1Y1C0zsaclPNNqB0eDxV0J
         wUE8Jx+ZBsftnKUHZl3QiGEA+ovBys6/htUOlDrS0z68kFnZ8fPuMd60O2BZ8JEohxyO
         NEnILhBnuDOkSEyTCEE1cfMRjmuBo8YJaFfw5RdrmiQrLDx1diLUEB2n33DP3xGpElKd
         Rh8JWC+S62LM34zGHOkM3Iu+tda0H2+pNbesyP1fSF3EWG0++Zcj5jfnfrNd3xn1Zlsh
         li0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764916205; x=1765521005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/N6cIVpJoY6gbZ5Y5Z8pBbxkt661DUursq7AFn6Eu80=;
        b=sWyNL5ZQF8jw8B1U3OhJr80LyhjZ10qhhbhoCjq8mY3B8a42WLnmTQFJs649Ck4pTt
         ztp6WFP9lYv3gVtVCH004VcU04tC7yGVpR4xYqmwvWGSdZgIsDm9aiGIyd+uKXz1hUPK
         Y5ePF3HxIdgAMmajarxs1GJeAxapqlzdb8Jg/rFw6Cw1m/M9LCyOh9Hgh5kWZza8gSjN
         pRcjnxCZ4YYZcexR4EnCaji5cWvEyhryK0sN68Pp1hw5/LarCOvMMgQmWFFFaZNVAFxH
         q26usCSOLP33roE9dLdufqh1y/zRJSF/Yzv5Kol3w0gV0EGaZUOXQAqpX2lgE5YMdrhe
         MVog==
X-Forwarded-Encrypted: i=1; AJvYcCXIU7rF/UAwDwgwPe9ChHyItDDt2vN88oMp5rXrqDBVP45zveOyaZ/ws4vYkn6xkkAgveZjBqHQtovethDr2cnj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6/mBvb6ij7/wEMgBrh5rlhxtN0MRYXWK2kiKyGIcTl5YlRn66
	QavAvMjRWVlDK63KoVAvpjtmWS+9O7gHg1WAMcrt0jSqCIxh4PHBoWITDgWV4XvKGdrZCOPtJPX
	LMgfqEcqhLCcposSQ5oZVxpGl3zeJO2s=
X-Gm-Gg: ASbGncuEqUeA0i9BhUj4XezQhuv1up4HPCBnwqHGEJXTFu62sFqpVc1wDVXJlNSea2Y
	aQA8pkgV32eAuOPpiCg40SUH6MFdB0AbBU18JbS7lmPYnulRXSbqZ6rEvIT3Y5FQKm07xIpOwbz
	M5hJsRceTNpPvb28cbJwpYOssHakYli1mKow9JWgYeeCIqeQZNuXh7sN2ThAy6UdoKgWGLgZVv4
	3S5FXhlnmuAnH0E6xtxLNSnydxr5zg0HgrQhvRuwE5/NYPNLvm4yF7NdMOmRmpxyx90BoAyqKPO
	ESp3/4Y=
X-Google-Smtp-Source: AGHT+IHKlq3cyngumYG+o82Sgbw2ZnRZLnOkvjLfM27RMnKOt+2gtPKjRRs5YrFMR3t4dcWjHHYWyQ1DqOnh/H8UZ28=
X-Received: by 2002:a05:651c:1476:b0:376:3792:1a9b with SMTP id
 38308e7fff4ca-37e6ccec2b3mr15525721fa.21.1764916204893; Thu, 04 Dec 2025
 22:30:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124072310.3592-1-hupu.gm@gmail.com> <20251125163920.GG724103@e132581.arm.com>
In-Reply-To: <20251125163920.GG724103@e132581.arm.com>
From: hupu <hupu.gm@gmail.com>
Date: Fri, 5 Dec 2025 14:29:53 +0800
X-Gm-Features: AWmQ_bnHS4AewP47Drz--eeeyWiC-BzkJvvqxRXiq9wP2uiVUQHkMq_wZu3z4c0
Message-ID: <CADHxFxT3TfdfLUYUqDqnx2ZBzn9uiSoDpo+R-u_t2U9OCoHRew@mail.gmail.com>
Subject: Re: [RFC] perf build: Use self-contained headers from kernel source
 when compiling
To: Leo Yan <leo.yan@arm.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo,
Thank you for your reply.

On Wed, Nov 26, 2025 at 12:39=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
[...]
>
> This doesn't work if use the commands:
>
>   make -j `nproc` Image O=3D$OUT
>   make headers_install O=3D$OUT
>   make O=3D$OUT -C tools/perf VF=3D1 CORESIGHT=3D1 DEBUG=3D1
>

Oh, yes, I followed the steps you provided and was able to reproduce
the issue exactly as described. Thank you very much for pointing it
out.

> Maybe it is good to search possible paths:
>
>   $(abspath ../../usr/include)    =3D> Build in local folder
>   $(abspath $(OUTPUT)usr/include) =3D> Build in a specified folder
>
> > +BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) \
> > +             -I$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)
>

I agree with your suggestion, but I think the following search path
order might be more suitable.

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..0f1113b8552c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1202,7 +1202,13 @@ endif

 CLANG_OPTIONS =3D -Wall
 CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARC=
H))
-BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCL=
UDES)
+
+KHDR_INCLUDES :=3D -I$(abspath $(OUTPUT)../../usr/include) \
+-I$(abspath $(OUTPUT)../../arch/$(SRCARCH)/include/generated/uapi) \
+-I$(abspath $(OUTPUT)../../arch/$(SRCARCH)/include/uapi)
+
+BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) \
+ $(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)
 TOOLS_UAPI_INCLUDE :=3D -I$(srctree)/tools/include/uapi

 ifneq ($(WERROR),0)


It=E2=80=99s worth noting that if the 'O=3DXXX' parameter is not specified
during the build, the OUTPUT variable will be empty. In this case, the
header files will be searched under the kernel source tree, which
corresponds to the 'local folder' scenario you mentioned above.


I have tested the patch in both scenarios below, and it works
correctly in each case:

Case 1: Build with 'O=3D$BUILD_DIR' specified

  make ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE Image O=3D$BUILD_DIR -j$=
JOBS
  make headers_install O=3D$BUILD_DIR
  make perf ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE O=3D$BUILD_DIR -j$J=
OBS


Case 2: Build without O=3D$BUILD_DIR specified

  make ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE Image -j$JOBS
  make headers_install
  make perf ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE -j$JOBS


> Why the issue only happens for eBPF skel build but not for perf binary
> build?  As I said in another reply, I'd consolidate options for both
> cases.
>

Regarding your question =E2=80=94 =E2=80=9CWhy does the issue only occur fo=
r eBPF skel
build, but not for perf binary build?=E2=80=9D =E2=80=94 here is my persona=
l opinion:
As I mentioned in my previous reply (link below), eBPF skel and perf
binary are built using different toolchains =E2=80=94 clang for the former,
and gcc or a cross-compilation toolchain for the latter. Without
deliberate unification, they will naturally use different compiler
options during the build process.

https://lore.kernel.org/all/CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1=
nwSw@mail.gmail.com/#t

Thanks,
hupu
