Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556501DE2B8
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779944; cv=none; b=Q2Bm61pWeiIpQnHKDecLsiIiV2wdOHW9PRr1+RgdmoriIsOcMocz7MUVy061volbWks3Esl/155ttGc+JqGMI+4yZJ1JXKgh4CBxJ85FakO5vArWGaljowMUWIeDuFRymYHYwGC2Hu3yW9h+I7six9sQXToP3/Mk1vWp5EU9mnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779944; c=relaxed/simple;
	bh=FXmF3PiNKKcWPPr+aQeb8jG3PSOC/Qb2ar8qg97uGAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/Vmx0xaHXyxLC9AHsNlCUDohrR8pB6H/DVYaixZcwRxC5JRY8Zb8zBzYo5jSvfmyIqNZQ4dbQVYtZUMu84lTjudVS0B5NsKl60Fqn4NL2RBWOIUNqErDMh/DiElxMENOYqPMIqm0AUOm3egxBk/kj8y15HzwDcUUgwb68/SbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tk8eYh1k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tk8eYh1k"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22185cddbffso65796075ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740779940; x=1741384740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htwmJPr5T2uqdai6eVyfL3xJDIabMmOP4IMOsJVBxhE=;
        b=tk8eYh1kpwPV105V1MxG8v4pbJ1Y9jP9bILd8dBquvHDdDKqfbhXzzsI7l+HuCAxKz
         NxkZSxVTra8SLFY6V2nWlj47Cw+D+Mox9fpkhUEFJNr+Ud8mqXPLtCVwT+ZaFCGF6whG
         jq2V7GbVbGBjY08neVVg9SNhR14xtRm6N7KPFkPvaP5bbN+g41d3Q/EUbA2QFjKwbRlu
         HJqnX84jANpoufAsW/IbQG6aohBdnjlSfEm2DPST7pfpd0DnE5yG6L8dgo/yQAcA2EON
         PrIwJrFg9Gj1azij6SJJ4Fo8jd1LLPSOgMf43XQwozvg8fzjbBalphBTtcVud29c6AIL
         3WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740779940; x=1741384740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htwmJPr5T2uqdai6eVyfL3xJDIabMmOP4IMOsJVBxhE=;
        b=vOJHDsnRyJE5FeYHfcNQUmKY0jR0iKlahVGwfHnIllHhDrOSiZE163jgAgTxcV5W+g
         pe+nGruLxRteJQ3O2/KglP6R/v6Ib05Dxjz1wVQ5gHTIi5ZFwwJnAAvQicqEt37XXoUo
         zu0krOGARWhBJ2GpAHonkan9P+RzMNL1kMJkNzfdwZgGxMIosBOlRPmj6LXogtIMr62R
         EWjlEhsKmCpB70OmH1TJ6Eq9dXrjypilpzQStFlBJIhJ67NGKDam2lSJzMfnZd6j7osH
         J0w/PZpxhttVkOAqyd6jEKLSr3d96tnSHeydCBV6DDMm7H39GpCrRCdT7El8rhhTwGGL
         cqag==
X-Forwarded-Encrypted: i=1; AJvYcCX4h2sYRxsSX+vBFOHwmTMWlQyyepq8mKhfHI5fKciQEyZe392EQRAlCegwwaeOqs1SKx/BZZc11J2ZPQl/kfUm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qwoQ4hsV2DwOlImMIbwDmjn4umJD8jROaIJYDURtA4cfwQl5
	MoH3y3osJxSxvsH1nwlAL78ewJJbJXDKPHdZFiBum6gDO/ZvwCJfnUJ6bqo+/TM=
X-Gm-Gg: ASbGnctXp3ssZo67sCvzfvLSywnn3ptuTlSAmjNIU89qCqS7AsHXBl+Uu9jxagV61ZE
	/ytHKdg9dWfKjWLwedmLFqz9l6y/r69jqcyXsBv52Dv5khg91U7QYPwYghtZ0SaMEUGLtm4/047
	OgpDx3U9xRY8vimklNEn4B8Kf+dzcFVcmcoG9vSo6zUVsjTJAXUVKdaNGSVkJc/qnI7EJm+O3bc
	vcwv58G8oD5Q5GlKvbNZVyWL17jt2YMQo+d4WNqekIBNj0HMdTJAUCpVmNUOm2x3HWq2MaY3BYl
	UkHyCvYJLB0I3Ndj422kFwNlBiVfJwtKol5roGsP
X-Google-Smtp-Source: AGHT+IHrXgYSbWtJbGGvvjbqgGeeMYXQJ4bKQjXqIkNDzpxQy6/BW8JhnsRoif+JrDmxplX8OOVelQ==
X-Received: by 2002:a05:6a00:228c:b0:730:8468:b2e8 with SMTP id d2e1a72fcca58-734ac386d5bmr8631206b3a.6.1740779940231;
        Fri, 28 Feb 2025 13:59:00 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:6935:f301:4e47:2b68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7defbd9asm3409033a12.74.2025.02.28.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 13:58:58 -0800 (PST)
Date: Fri, 28 Feb 2025 13:58:55 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix perf object dir symbolic link
Message-ID: <Z8Ixn3J2hw8TLdRj@ghost>
References: <20250228-b4-fix_perf_symbolic_link-v1-1-3ad734838929@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-b4-fix_perf_symbolic_link-v1-1-3ad734838929@rivosinc.com>

On Fri, Feb 28, 2025 at 01:48:32PM -0800, Charlie Jenkins wrote:
> The -n flag is needed as an argument to ln to avoid recursively setting
> the symbolic link when OUTPUT is the same as $(srctree)/tools/perf.
> 
> Without this flag, the perf binary at $(srctree)/tools/perf/perf will
> become overwritten with a symbolic link to the parent directory.
> 
> Additionally, remove the forward slash after $(OUTPUT) since $(OUTPUT)
> implicitly includes a forward slash.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 890a1961c812 ("perf tools: Create source symlink in perf object dir")

I should have double checked that this patch didn't exist already, I see
there is another thread here:

https://lore.kernel.org/lkml/Z5aiWiqJbkNaVG2Y@google.com/T/

- Charlie

> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 55d6ce9ea52fb2a57b8632cc6d0ddc501e29cbfc..0b6f9de6f222da1181402aa33e41ec3b05f9189e 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -158,7 +158,7 @@ ifneq ($(OUTPUT),)
>  VPATH += $(OUTPUT)
>  export VPATH
>  # create symlink to the original source
> -SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
> +SOURCE := $(shell ln -sfn $(srctree)/tools/perf $(OUTPUT)source)
>  endif
>  
>  # Beautify output
> 
> ---
> base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> change-id: 20250228-b4-fix_perf_symbolic_link-8cc373a195ac
> -- 
> - Charlie
> 
