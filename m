Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795243491;
	b=m5ab5f4eomjtNeyJTig4WAscba8XjhKT+4Q9fn+LqU+IuQ4ma114rwdATZZeMEgTvYu7
	 B5Fp7Jvz9GDxQ1dOY2hyBjapfNdzZA/eDGLGBbd3SP2kSXUxNNjqlvvX6NExJASfW5pEy
	 ImsGqfsE498KFuQd++UuYNkKqbFGWQqDZeFDjzD2Q0Jm1ZCVqNxrHN7JrqZN4wP8kSLLe
	 UNKHB4lWopmNBiKtzo2ez2CZ8A/7kmXQRb8oOmjufifSYIZVQyCQYCv3sZ1ZuraJJLjYp
	 JGBcf46M5i0GGKN9qXPKL/YhmANKYuSWR/46LYzU1zbtKimcAbCnZ8e0s2kdlMYadww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795243491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rJGaXCKWewK0o1WODe/ahcxjTKhVHE+pDRivB69i4vo=;
	b=JbZNu/aRyPHJi6tVASLfYXGCW5Zwyb1rnZnmV8RZWtwBtUQ1tqkevz6UTz7Z1JT+IxXy
	 JUYB2ZxHvwziQX6M1c/fy8B2inIIMktknbV5/DHq9r85xgJx41w/MGpheUbPWrgUe3AEV
	 f5wh1dn0WNWfKMQuIOO0F+i941RDt8jJRmnDTOyiYJ51uk75uC/gZeWdPFcd3fHyRXnQB
	 P6J+83OI51HCj0uYKAD5YDxnzb/JgCLPhzZJ81M55U/GaUqmvv4DsZQpOtL4vQ7oRfbMf
	 BDeBdQsbtkiT69/UQBcG7vif3VSIuUoAASbFJLNcZu5j1HNqBWPJfZhaB2FqsRdXpeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PZkMDnkV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76F606A684
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB76F606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PZkMDnkV
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55be673e029so80171cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:44:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795243488; cv=none;
        d=google.com; s=arc-20260327;
        b=LJls8aUft4BJWlPOQzMnnbmV0rfbsQ/iFzpAIVr0u3MOUyoIdaMSLWZ2u8jp8dnvEX
         FZxDfPMiQuJfeAektKfbAnyYA7gGMNCmf0H76RyCP7EjjcaLONDwFtGR0I9Zr2GwwFSn
         gNjpQDxJKu8zJ8m9MEiz73sFfzthcaKOlOutuxBu1drZTZNoWGy3bI10nl9th+YoFWM3
         0CVOMYr+kmfwVLXF3+DD8oaPj1UcBviISrvmF1KYGlw6CIEYq9Tt3aFv+9hUOiAft1K4
         /TjMTyClmHB5hyMXmnJMVlIRd640tzjIHvguF4qTQOXxOYCo2bQntwGnh+1iJb9x37Ol
         +GvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rJGaXCKWewK0o1WODe/ahcxjTKhVHE+pDRivB69i4vo=;
        fh=wizw7xMR9csjNbqkBaMTHvv1IRAN5DvjkjxGrls8FXc=;
        b=AMApJHlwGsv0rLqZmryzBVNoxgWJBGPSL6YlbqGR3DTQFjvAz/+DWC2rw6CyNQJ8tI
         hhaugV6WCd+BPYUurHWH4MOFsFQddcpnWQcAEEVPJWqJJnxgx2v4LRYjy6AMIW02E2HO
         ZljQPkh+yoMsLxUstdHKjwQLSsNME+12gGAzivLPcYZKrCAzx7s1c1sSxWTPRTBlkPBK
         eY4WQEJ7gs7yt9xCspRdIftzR2HEesdR76qG7VWzp3fLbw6HVkYvsL2RgLa5E6n1rRiG
         FqI9yB/iEbr6jWeCR+KU2+wGy+MeUfMS2VGWpzKzhhFaWTT5j36Vzr4qqOvoeq42eWW1
         //LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795243488; x=1795848288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rJGaXCKWewK0o1WODe/ahcxjTKhVHE+pDRivB69i4vo=;
        b=PZkMDnkVarcdoXoURc6+S4eAc9MUQqoG7OCt8F3EMhWrOQFPuQxNuNs4DH2eXKxc7O
         LE6Q5/ntHK1Z6yBp4O/dGez7oJyO0WvTq2NlwoYT6kjtMuDdZCedU/RNHWWBvzKhmDXq
         OtYPM5ImVNUkkiSL1ndqP4q/4J/hMa5ohNlcadghVe0VVEW1s2tnGs071E2W3GVU/FPF
         Q4eie//Q6cHXcPtbablirHfizCXdy5EK8PEcnlLUvBDoy1qTwLcYMh68n1wFEH2uvmRG
         CFyMMSw8cOL/6WaFXNp+kOnPFQEwDHZz6GKshw0hIEkbV/ZlzKXa5sUd6pp7tw7Bh0IE
         D6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795243488; x=1795848288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJGaXCKWewK0o1WODe/ahcxjTKhVHE+pDRivB69i4vo=;
        b=Ar67UX+YWc7q9n96rKxtxcyM5/mIqMrYrK+pGLSKjrRt07pi0crKvP1W/+6N7HPC3s
         TCfTx+8nNBpv1xk6xID61qxzG65O8dmaaPBYegs+xfB6ydTppi2hL4QtCtNctAj747qb
         a9fVe9qPylWbXLw3o0DNc4ypT5eGFPHK7lSlYYmoO2GfVU30TkY8NpVwWcMkB42wbQxd
         twzGTbpgOupX0S1HQn7tbJAVqGT/0hn2LQpF0MtTCpLLn4aU8M+s2h1Zdh5+SDrl/M8Q
         lS2OPWN02DEYBwdKnkhBMRqk5/6mLPtja5xWaYLVkL9i2PMS0aKrhSHbVDMV94mfjzJ7
         3lQQ==
X-Forwarded-Encrypted: i=1; AL+hErGA88locjjglO3K6PQxseiHO4Ixk+9MJvHKsyFNlxbDQQNQnS58dwiqdbjLBtz2m5fmQgnuf7ZxJi0Wbp6svxm5@vger.kernel.org
X-Gm-Message-State: APuU4Z/AT4iiV8KpSJrpNxp0P8RaFeu8Fi8biC2goijjPCztvtcsjkvm
	gsCjnxXLhhf4EgvSel1KpW/2RLQ0Ay2wbe9UKPqpODfrH3HMKq0oslRgV6fCbaYrm+rxkmheaso
	zTxtc1vGU4p8WNsPc7fyF8XQ5utp7TqqoDa2HSrkx
X-Gm-Gg: AZFdTZcltbwO50uEZAvtZONl9f+6MCEO5RvsFULO5udu7CyF/xKNB3ihe4ixoDZZtg6
	zgmtlpAqk6okvDK/P3nJxZa+HNVatDl5e+M5sF8QoGS66g8WGy7yLJAXKkZCBg0BxBeHYa3tgd0
	fu6cJ/0gAI0PlNqphLKAq6QQ9WgLThHnpYxKJJWFLa9uO3I67E2o9Mxha5gp5Ck0yqP5FXbKryW
	fX27TnmLljx7KVP2lqkTNtQ+VmdZQDw8eA7RfWbxRhrkKpMM479eBlydYaQI9cyqaiWhFBZ3soN
	kaLW2b9Xi26/tgsLJL/Y5r0Ucj/RNRIIHEDIaNwu+3ZuelImtpjEp9v6uW1CVbj2CDxx5MYSDP8
	cPv69Qy5Kt2ExslVGY2223Fc4RKgI2GMiFD0B
X-Received: by 2002:a05:622a:2b44:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d88013e93mr11498761cf.2.1795243487193; Fri, 20 Nov 2026
 22:44:47 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com> <20261113164152.2095566-6-irogers@google.com>
 <av_aLv6EpM9Umko3@google.com>
In-Reply-To: <av_aLv6EpM9Umko3@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Nov 2026 22:44:36 -0800
X-Gm-Features: Aa3M54o_O14Zh_JgQcHXrC4CBU15axyWAwszYpzIdNObSrbntvtFzWqzUehOzsM
Message-ID: <CAP-5=fXj-43JCDZVhY_E=hEQ=x18aN1TwsE4rKXFX7tfZdzCZg@mail.gmail.com>
Subject: Re: [PATCH v13 05/21] perf build: Enable additional Clang
 thread-safety flags
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 13, 2026 at 08:41:36AM -0800, Ian Rogers wrote:
> > Align tools/perf's Clang thread-safety flags with the kernel's
> > scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> > -Wthread-safety-beta, and (when supported by the compiler)
> > -fexperimental-late-parse-attributes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.config | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 3eb8d095cda0..b50702bac53c 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -64,7 +64,13 @@ ifeq ($(CC_NO_CLANG), 0)
> >    endif
> >
> >    # Enabled Wthread-safety analysis for clang builds.
> > -  CFLAGS +=3D -Wthread-safety -DWARN_CONTEXT_ANALYSIS
> > +  CFLAGS +=3D -DWARN_CONTEXT_ANALYSIS -Wthread-safety
> > +  ifeq ($(shell $(CC) -Werror -Wthread-safety-pointer -Wthread-safety-=
beta -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
>
> Is there a better way to do this?  I think there's something like
> cc_has_option but I cannot find it.

Good point - tools/build/Build.include defines `cc-option` (via
`try-run`), which wasn't included in Makefile.config yet. In v15 I'll
include tools/build/Build.include (updating TMPOUT to use $(OUTPUT) when
set) so this becomes:

  CFLAGS +=3D -DWARN_CONTEXT_ANALYSIS -Wthread-safety
  CFLAGS +=3D $(call cc-option,-Wthread-safety-pointer -Wthread-safety-beta=
)
  CFLAGS +=3D $(call cc-option,-fexperimental-late-parse-attributes)

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +    CFLAGS +=3D -Wthread-safety-pointer -Wthread-safety-beta
> > +  endif
> > +  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c =
-x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
> > +    CFLAGS +=3D -fexperimental-late-parse-attributes
> > +  endif
> >  endif
> >
> >  include $(srctree)/tools/scripts/Makefile.arch
> > --
> > 2.56.1.703.gf848ed807c-goog
> >
