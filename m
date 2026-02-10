Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54141344DB3
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717782; cv=none; b=JjuOxk9qcxRyrHwBw6dfFI8F6e4aA7q/31rsnxr5rkra87qLqrujFg+ftKko0D1JRVw0OKCs07yo62NGTFAKmRNt3JBedmCFjhQTH0Tx3oBoo4Y7BCjYCZmKGoAbG6lvkPdgmQ1whr70pWPRoW2ji6JRgqUKCQppZ3TCmVZdtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717782; c=relaxed/simple;
	bh=2qc0hJxZty7uTpTB8SnrHB3rW2cEYv7Y+PsoWLxKs4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTjvlSLFb8xJfJ4J5AZMddYGGF594LzDr68OkuPlFeQOk2t8N6/1R/RxQzDUvRM5uNVKCDSjZwrjJkqzR3Jlcv0ot8OISweVje3y9GyDQ09WlQo3NbTCt/5azqfYoixKENdh65c+v1XhnrM/z5qc+FGgsintLv4GtwsKjQqed1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbtcP3+e; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbtcP3+e"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b885e8c6727so639246766b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 02:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770717780; x=1771322580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQndqCMcfHGtx+SDu4KAAwuYCIBgtei/20MfByHdGuk=;
        b=XbtcP3+ehye132pGG4bNJsV2/ye9OIJDkHS4PSTQG+uLZ1NMJYWGVLEL5+58Y2gYJQ
         vPNKDXJ0CB+EnJEOr30JJ+OpeF7TDqtE/pi/4PyPk1nLhowg2O5bx1pMZOdC8uRnWLB+
         KhqeZs2Y52AhWGL/vz2yHwb+V9+CVPuVuUDIOMRDiT2ccnZ9/wGkttyroZhlAf7NrWbQ
         +SNt2i29D+6Ovs7A8Qu9luQCGobBb973lviF5OEjfGKZvrqEDsk/PEHdYLqjZSUvnmnB
         aYDRvX8sf59ylKBSBEfS0cyCdScBYf3nueXgu6Yr4/WQmsKfI0+oknRKb6hxCPCf3OAQ
         54kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770717780; x=1771322580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQndqCMcfHGtx+SDu4KAAwuYCIBgtei/20MfByHdGuk=;
        b=g1+DaXNsQdCYP4PPbwuSeGG5kXuUjMNXfZg/7YHcHrajXdWbnWVhRqW7N1roa3bRa2
         qPRvOQBIEGMAW4O0NCkH1+2jOSfWaD5WWdPD4X4/xfCPN6p1SAriIFKqDqTUB4fqE+OF
         E9BxWF7OVeFjGm4cR2m7YWVhXCXFmTqpPGr9ALczYh8WoWyjsnuXUOXi5/ls2B1A2ixg
         ngGltWd6obFCXc7dWv6LHAJ0RA4fE+4pHpltgkFguLMohndWwT4FYXCgPSqHQgXUu8Pb
         WwtzkUhvKaCx+keg9nfx8fHBTOhHF/sgPt9h9MumkWjsNs0wivsV2pQ7jBs0LdR2bBYq
         VZNg==
X-Forwarded-Encrypted: i=1; AJvYcCUPI1gJOjRMLCACUdURkDsugsa7C5IxdHGWRVZf3stduGxPfSncS58WYok2l04DTbK3XbCfCjb/CLB6lnbXqTVV@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzx0e8b9KoJcforHJTMpaPuioBCOz2LUS07cPkoQRyBjOkzLp
	1d5EFXhvvjo8FyJ6XICQOcvRtX1LkLhn8MYd9RA8APMECwBJV3/vwVMc
X-Gm-Gg: AZuq6aLVTI1aDCxCmRFhfpR9+0/bSz5BpzfhL+3CvEh9cFZ/XE5t5TUpkAXZ75HSafn
	42X9S+V6CSN4SfeVnBB6aEByHV5lA/tLuvfqwxHLU4LbT+mWMOJKuK9i2CKpU6sLRWvPoXdqT0B
	v0OxNViiciSW9alY7ae9k4BIZ+XxofiAXS586n/aF+rrkZGAqooru2owQIa15R7WyG2pmTmlq2l
	Koi5EeGniRrcFX03UTFPNMmvEfqHOBACae0Wo1LLbU20rO0M0n1ypDKByFzgzTB7SAsDV9P6zrb
	ch/cqB38MV7vGFR54wM+AwhVa4OqWIlVwx5LK4t47W6Id1rVwyETnbJNXbzyUp2PVLiTAJ760Dt
	8h5hKBN2uRPd2ubZQI8FuoQCj9olfcbKgnUL51z7loQvwWP89ZAG+T2b3Eoo0mhWpoUcL+wTqbh
	50cgRxb08dDcwD4cX3uFBHXoGN4LBRQn5eYzb/QCiNNYzMjfayAgLxd6JmURP5em8ssHjbllTfJ
	v91Fib0urR/95AJ73AsP22OcT0EOduRhuLy
X-Received: by 2002:a17:907:268b:b0:b88:440b:65c4 with SMTP id a640c23a62f3a-b8f50c53b0fmr105122166b.25.1770717779428;
        Tue, 10 Feb 2026 02:02:59 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda74a646sm492821566b.13.2026.02.10.02.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:02:58 -0800 (PST)
Date: Tue, 10 Feb 2026 11:02:56 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Fix rust feature detection
Message-ID: <sc2w3tcjcle4zhz72b2jdnyfnhzl6atiecium2dwcmrlvn6syb@n573cdtyldne>
References: <aYoZD1onJLsnlrV3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoZD1onJLsnlrV3@x1>

> On Mon, Feb 09, 2026 at 02:27:43PM -0300, Arnaldo Carvalho de Melo wrote:
> Features in FEATURE_TESTS_BASIC will be set as being available if
> test-all.c builds, so since the rust test isn't included in test-all.c,
> we can't have 'rust' in there, remove it from FEATURE_TESTS_BASIC and
> use feature-check so that it tries to build test-rust.bin, doing the
> actual feature detection.

My bad, thanks for fixing it.

> And after installing it:
> 
>   ...                                    rust: [ on  ]
> 
>   $ cat /tmp/build/perf-tools-next/feature/test-rust.make.output
>   $ file /tmp/build/perf-tools-next/feature/test-rust.bin
> /tmp/build/perf-tools-next/feature/test-rust.bin: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=9c416edf673ee3705b97bae893a99a6fcf1ee258, for GNU/Linux 3.2.0, with debug_info, not stripped
>   $
>   $ perf -vv | grep RUST
>                   rust: [ on  ]  # HAVE_RUST_SUPPORT

I've noticed few more problem, maybe worth fixing it here as well:

* test-rust.bin is missing from the list of FILES, and thus is not removed by
the clean target. This could lead to a false feature detection, since the
binary stays there.

* Target to build test-rust.bin does not emit a dependencies file.

I've tested the following diff after first having rust installed, then removing
it and building again.

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 9ae69d85716..28d4ff0841a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -73,7 +73,8 @@ FILES=                                          \
          test-clang-bpf-co-re.bin              \
          test-file-handle.bin                  \
          test-libpfm4.bin                      \
-         test-libopenssl.bin
+         test-libopenssl.bin                   \
+         test-rust.bin

 FILES := $(addprefix $(OUTPUT),$(FILES))

@@ -112,7 +113,7 @@ __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1

-__BUILDRS = $(RUSTC) $(RUSTC_FLAGS) -o $@ $(patsubst %.bin,%.rs,$(@F))
+__BUILDRS = $(RUSTC) $(RUSTC_FLAGS) --emit=dep-info=$(patsubst %.bin,%.d,$(@F)),link -o $@ $(patsubst %.bin,%.rs,$(@F))
   BUILDRS = $(__BUILDRS) > $(@:.bin=.make.output) 2>&1

Reviewed-by: Dmitrii Dolgov <9erthalion6@gmail.com>
