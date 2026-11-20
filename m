Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152432;
	b=xPTGsMv7ePXLDKR+a1hekQEqcXj6Eq2SKk8HDlcy59nwpE+PdCoHSq7kbD5ghIJj8Ixd
	 dJR0x9uC2qFgM2c3ONMJdtmnfgofqKlCc3Iq1cSzJHCgtQP/AMhqW/Q7R2ccbZx24GLqX
	 vN2Km96n/HKGLLqIHcEo+FFc9vImHfhTsyM6QV0lKJTXGyyUeDCfHLckU3Nf8tPb8x8dQ
	 h7bCdzWFv2kPPGJdL5Qi1gxGlvhxL6WNvEM1YLGHDbRIK6i2XX5PXLKiPvorqyoOfgqlU
	 cmGhix2+A6nV5cZdmnW2z3kKkmGUY5RCjUu1s3uSIwYVR1NGBM2Ap/laMkgwrJkt/WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152432;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jkv8R6SZr2MqhoNWbmP2V2VXFF04IsosrhtBbN0losg=;
	b=Tb4l8dt1gN/b/n7hoa+ZW4q+LNV+2BzAUD2vfGYsnvHdLkg4CZdppHSFtPq9D4PcdxLh
	 s76ncwfOOTsU/IXin0NCNZSGzcgEpLB9Nf4VEwefFN1xAF+1cLAuecRzdZMVS/shQT7wP
	 ZFEkZIS241Hu2IUIFc8h0ubI+5GwJ1OcH46Fvq/rcBipAgN+lxJemJdkWazcgFibh89Ua
	 wecltAIaD5WztN1PFdQdvheEqeRd84OYv1sO+2d/0qGHsJ3RB6xkSy64OsFPizruP/R9Y
	 L9m0EYCdwBEgLbcTZYz+C8WHax1cVA+TO1SYogP1un8FqQVcVUY2eGRXczDTGs0yMWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjTh85UM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93E606A320;
	Fri, 20 Nov 2026 05:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjTh85UM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D9E1F000C6;
	Fri, 20 Nov 2026 05:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795152432;
	bh=jkv8R6SZr2MqhoNWbmP2V2VXFF04IsosrhtBbN0losg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KjTh85UMy3noxjFClYdyCK5/0HWCovegt922TC1+DuOccs6vVq3L7ggJ0Gz1/U+qE
	 swSHvcv/s+rBlFG3JJ7rhHXgd+WrqnowJ/KC4rdbEXHmGyddbvDRETmWDYOomHFeTH
	 hdOU9Sz0gpbvEcY8fGRd6BlHT6318nA/dlfsxYMzFC9GjV7T263z09kj3POFcBel2s
	 lgbDYjh0LS0Z57+pBtXUVcCmaQ4A2/rBwwa6Xa+sVbNjcLc2IWKPi1XkOzmgxXJX6f
	 fA505Sz4ojjU1QqPpyufjnmCtVUfoqMNgT2edLx+vRonDJT/Fhyq98bFAWdejuuVCv
	 mjvrD+1Ps7tGA==
Date: Thu, 19 Nov 2026 21:27:10 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org,
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	mingo@redhat.com, morbo@google.com, nathan@kernel.org,
	ndesaulniers@google.com, peterz@infradead.org
Subject: Re: [PATCH v13 05/21] perf build: Enable additional Clang
 thread-safety flags
Message-ID: <av_aLv6EpM9Umko3@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-6-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113164152.2095566-6-irogers@google.com>

On Fri, Nov 13, 2026 at 08:41:36AM -0800, Ian Rogers wrote:
> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 3eb8d095cda0..b50702bac53c 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -64,7 +64,13 @@ ifeq ($(CC_NO_CLANG), 0)
>    endif
>  
>    # Enabled Wthread-safety analysis for clang builds.
> -  CFLAGS += -Wthread-safety -DWARN_CONTEXT_ANALYSIS
> +  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety
> +  ifeq ($(shell $(CC) -Werror -Wthread-safety-pointer -Wthread-safety-beta -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)

Is there a better way to do this?  I think there's something like
cc_has_option but I cannot find it.

Thanks,
Namhyung


> +    CFLAGS += -Wthread-safety-pointer -Wthread-safety-beta
> +  endif
> +  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
> +    CFLAGS += -fexperimental-late-parse-attributes
> +  endif
>  endif
>  
>  include $(srctree)/tools/scripts/Makefile.arch
> -- 
> 2.56.1.703.gf848ed807c-goog
> 
