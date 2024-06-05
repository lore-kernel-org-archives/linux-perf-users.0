Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CAE190490;
	Wed,  5 Jun 2024 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571714; cv=none; b=ubf8pgyrvVbtJQ+OfQdSdJekIeEQs0QwRLR7qiR6mebQLSrGDty3/utU2psA9NpueT3LqC+xH5S9NdBz0kGSswpUrd2JzTqSlH5Cf84KEidWQZWN8wLwzkIl+OMNG+x6/amGLuVQ5b2y4KUBKAq0Gz0HbJU7bC9IZTJ57fEZIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571714; c=relaxed/simple;
	bh=UwC2NvmMXo1nvJ7sYDl1XaOJLxwWFoTpX03WqyuJ8Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0pWz7wzwb1J+v6b9gr5/E5CMhIrOdQRyusY94EDQYVU5OwS8AQWqZKFGZEgC6pH8bInSOrcOBiNOfV0wjp6qAQmjGdXTN9kD7intcOuMssxTnFal2gZ3HwzHxcLosPEup94IRuf4eSKiD1CnBJgwTfPPAFjur45ZmMx+KR+fSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJs0sVJ0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJs0sVJ0"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaafda3b90so38589301fa.0;
        Wed, 05 Jun 2024 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717571711; x=1718176511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzWuhHATgvXynxY1bc2YJTiUpWzS/lVHAC/1FvnI+g0=;
        b=iJs0sVJ022lgN0fF8S0+2yHHKnQsxMrfji4fg618Je7W8amLnw7KmsYoHFY6OUNWbm
         43PwwfuXmmtDzxyqSH2Q0+YwCpMf3AfqjLGyk/z3yumr56styI4x925Mjn0RsYzID4C0
         BbITJYkRmvTkzKiNkfJ+/VhE5VtrHpjGd6kgjeQZzAXw65fyEptW5XMDubxXeiDUU1ui
         5ZqtxigZhHDiyWoFeYY0yHIxR/oCfJ0KGL3yx8VAq8ljxbUg37TJHIcF7U/cUai1JLLc
         GGd4GqebTKK7PRmu922+3+chQfD1PTSVSFbjSGmrHxmJLLjcFIecmRZFxpLohW4vK/Fz
         2fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571711; x=1718176511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzWuhHATgvXynxY1bc2YJTiUpWzS/lVHAC/1FvnI+g0=;
        b=slIIYXucTOa3FWKaJIX1lnPPRwAyFDrq1KIqHkgakrhHCDODYEmZeW/OcCmXHJyc6n
         Q5Lf2ydRKkpVAqHwB5WY2YcosQSP2ZT/56RqgmwBKWPg5EfDz4VWUPN0IfMeQtI37HRP
         ssLhq9t44CggXAW0GCorbsyIEOXBskTZZ8/vyuvYja1d1W7Mp597vp/yuTBMC6q8I605
         OigG7Lgims08WNYnArOrasuKW5bJ/zlU6jyHnoxKxTZfx/8sNW2n2tTd7VPBHSAFVVaJ
         qf+d1Uy0559ztnegA8t7gJ7FVNen1QnqqX6+tLjFoF9JrXBQYp0MfOmdXsP1BLEHt+hW
         STZw==
X-Forwarded-Encrypted: i=1; AJvYcCV2HyzAJUhDU8z/qHjIyzjD2ztjwkZC7EElIhhfzIG19o0Il8LSqXmwPMxRQpWGCK4qRYydsW/UX5j8NaHtkMjhUO8c8S6AgTKMa9Gwpg0ir5Z3LEr+TF33nzMX6pgNZGxgc6eazX6LpiAZ45qu8Q==
X-Gm-Message-State: AOJu0YywAHWM+1eqb3EQMj647ESCtldnY+097Ix6nDfpS2hRnYbU66Zf
	NBtdR4971MNDHTWobcuArBkpgR4KoVfAlS5BenWOz+e3dbuefhfp
X-Google-Smtp-Source: AGHT+IGlBRC9qXybD9x/nDoFbJGpEgecRh/IyGjdJoiPKBMtj7h2rl0lqKvW4kl0WnhQN6cVNZg3BQ==
X-Received: by 2002:ac2:4d9a:0:b0:52b:81de:1126 with SMTP id 2adb3069b0e04-52bab4f5e5bmr1031680e87.49.1717571710383;
        Wed, 05 Jun 2024 00:15:10 -0700 (PDT)
Received: from gmail.com (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5b1f9855sm6085125a12.70.2024.06.05.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:15:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 5 Jun 2024 09:15:08 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
Message-ID: <ZmAQfJ9C5fFQdjQM@gmail.com>
References: <ZjssGrj+abyC6mYP@gmail.com>
 <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com>
 <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
 <ZkJK3x3zQ9a4wp8E@gmail.com>
 <CAP-5=fUh+GoqERAF-qf8zx4kwq2uzwR2Ugop5XOkPexYGAqF3A@mail.gmail.com>
 <CAP-5=fWXDPfNqLz6DHYe9+dev_e6X5TcTe_xzOOz27yDkT7o7A@mail.gmail.com>
 <CAM9d7ch5HTr+k+_GpbMrX0HUo5BZ11byh1xq0Two7B7RQACuNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch5HTr+k+_GpbMrX0HUo5BZ11byh1xq0Two7B7RQACuNw@mail.gmail.com>


* Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Ian and Ingo,
> 
> The failure happens when you don't have vmlinux.h or vmlinux with BTF.
> 
> ifeq ($(VMLINUX_H),)
>   ifeq ($(VMLINUX_BTF),)
>     $(error Missing bpftool input for generating vmlinux.h)
>   endif
> endif
> 
> VMLINUX_BTF can be empty if you didn't build a kernel or
> it doesn't have a BTF section and the current kernel also
> has no BTF.  This is totally ok.
> 
> But VMLINUX_H should be set to the minimal version in
> the source tree (unless you overwrite it manually) when you
> don't pass GEN_VMLINUX_H=1 (which requires VMLINUX_BTF
> should not be empty).  The problem is that it's defined in
> Makefile.config which is not included for `make clean`.
> 
> Can you please verify if the below patch fixes it?
> 
> Thanks,
> Namhyung
> 
> ---8<---
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5c35c0d89306..e6d56b555369 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -214,6 +214,7 @@ NON_CONFIG_TARGETS := clean python-clean TAGS tags
> cscope help
> 
>  ifdef MAKECMDGOALS
>  ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
> +  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
>    config := 0
>  endif
>  endif

Yeah, this appears to be doing the trick here - judging by a couple of 
tries of interrupted builds:

   Tested-by: Ingo Molnar <mingo@kernel.org>

There's a new issue btw: see the 'invalid escape sequence' warnings below. 
This is on a pretty stock Unbuntu 24.04 desktop.

Thanks,

	Ingo

<unknown>:1: SyntaxWarning: invalid escape sequence '\S'
  ASCIIDOC perf-config.xml
<unknown>:1: SyntaxWarning: invalid escape sequence '\S'
<unknown>:1: SyntaxWarning: invalid escape sequence '\S'
<unknown>:1: SyntaxWarning: invalid escape sequence '\S'
<unknown>:1: SyntaxWarning: invalid escape sequence '\S'
  ASCIIDOC perf-daemon.xml
<unknown>:1: SyntaxWarning: invalid escape sequence '\S'
<unknown>:1: SyntaxWarning: invalid escape sequence '\S'
  ASCIIDOC perf-data.xml
  ASCIIDOC perf-diff.xml

