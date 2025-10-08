Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74128224B15
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930780; cv=none; b=kiJdsjo3YlfUyOH1OdM3xhQwDHGpR1XRef9ADkbDdDe61CbtN0nma/3gGi7yS6YVVnkEEEhfcqbQGVVnyaGQV4tStljB3wqKAfBuG4LsuNeO0LxajWzC4wecPDtLA0UMB+W9QSpKxxS6VXt9sR9rVZywW27QKXc9xTR3PWF0iJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930780; c=relaxed/simple;
	bh=/Qs0oIyWheEc3zWX81NSETq42rB7JfdxsDIJJfgGAdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/QaD0sKfEdlEk864aBcHN6MFUUJbCyW0Lg0iTeYmwDls6vMr+DAWHRMLuvi6c+AI9cb5ulcG6Xztt/C3EGv3MMMij/DBkWEMXFBsqYyEmEGchg1q6Tvwo/EBBHCl8SYrXYFofPJKNEIAcKpqvvMIMDQO/XUOHf8PLOdu2Wg2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x2GUn6CR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2GUn6CR"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e2e363118so67851735e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759930777; x=1760535577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vn6BpMsAh9r4IbRE1UUdGGWd28vzfH5FktGYeaYOaFg=;
        b=x2GUn6CR+AcRZQ1l78p5I+0mC23jUut6jEZaogw1gyVEjkdNWQNV7fwStFBb6YSrkm
         KiJjeBg4Ds+bz2/9LSP0T6DVuj9MQ/ZdyEBWFq57wm0aQxsEAB0XYzinTW9v2YOrvBHa
         gm1vupU7wUKQtX53Sm3Qc4k69FGg2PDdr6F7wdGUcBSBHYZGnbKaxJBjLnyVx4qvjTR0
         L+lTXtBlb7sHT4T67Fp4H+cRcGNvR2LuxZRoTX3jQ8rJdsri/4GLnVFWVZNuBJfoiXNP
         riUFid+dCQELDo2ym2cFe8ThqnTUlPzuHNIZyS2W4oS3oqY18+3h+IfxOm2Gti2kDwEp
         Tt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930777; x=1760535577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn6BpMsAh9r4IbRE1UUdGGWd28vzfH5FktGYeaYOaFg=;
        b=Seo6jlStnNAQhe+75RcoLQuD2Q/6RUfa72eGDUjYe82Uh8gn+89cVvKYhULhe2eFLp
         05oT9/iGEFa8VdwndlKW5YyMDpTO2W6/EGLa6//WO8P6IXA2A0DS7r2Ce3Cdu5AbtgIz
         a3ESLqgk3crut52+MDDkOSFg2OaMXdNDi2L89RhkWIigTTXxpKjw1FJA40B2oS3C/G7l
         Z963GGGbOAHVayJtj3KAe8aRkwP93d2LWqvTdgHR6zxsT4nnLongPBcpLvSUK7LqhwI6
         ZiwNF+cTPDy6BkJlM040Ppk7XmfA7A6QMQLcqXGqSs+HP5BHY19j+SArsjpRF1qL6LOL
         F2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdcfPI6ZBYNElflxNz4HkIb/TlL0nqX67G3i6tK+e6dsqZ3io9bHlmyl0Wy4FltJwuORJiwOmDACn544//zsl5@vger.kernel.org
X-Gm-Message-State: AOJu0YxzScdIgtzHqs2WFZl5I5fwMFHANIxROGVMsrguHXaBoYuYAGTS
	2oXQT4tErMcoYzTWavBQcbi6cRQK3DHysZ/SQMxmgvfs2e8knu08iPAeKHmfXulBwHs=
X-Gm-Gg: ASbGncuq7nq9jzdPAS8WFVtFJKUU4Wm6WapHU++aTX33g55oFT+Tg0Ex1xoFmT2dj+e
	jfTgGo4rkIBNS/2DoS82qDCltBI8y2sYH65D41WdaWkYYekjx7dIWcOCYzv4ucYClbkPq93Y4Ye
	x59F+/OZ+A9KUlg4GrrJHNUQGSGVX+1lQOPZuXbLELGXPGrxapouQlSZSKemaVZBpk98qcWJyVj
	GJW+CA19rgSXyeGmjzcV9pMJfZBZO0ZUtesNDZ0hTsOk9n1I0GsIrs8OGO5Ro/UgiSp7xGmjuDo
	/d04/VEoMXWXREb/Uws5UBAr/HyvRjGb5TdB7zxDc9RvlwZ7W6Ibn5xTfmDZMzJsgJ9Wo9ZVFaG
	IvMnNRUQYvdKAzCZvzQKdakPWQIOW90JEnj32wrrJYHmFB+nGzmH9nBCA
X-Google-Smtp-Source: AGHT+IEGhf1M0IfGRsKkHgegIRsELI5GO3Yw29dOQ7cZNfxg5VRZxd2tA7cNQ01uOfaqYYNWwFlArQ==
X-Received: by 2002:a05:600c:8586:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-46fab89b7abmr12921045e9.34.1759930776614;
        Wed, 08 Oct 2025 06:39:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fa9d4c89esm38044165e9.13.2025.10.08.06.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:39:36 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:39:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
Message-ID: <aOZplPKCRwvlOgUA@stanley.mountain>
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
 <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org>
 <aOVxlEXDMKJyIhME@x1>
 <a7698f4f-6541-4d3c-afea-d30baa4776f5@linaro.org>
 <887ff02c-c221-4b98-be98-efe62e043727@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <887ff02c-c221-4b98-be98-efe62e043727@linaro.org>

On Wed, Oct 08, 2025 at 11:21:34AM +0100, James Clark wrote:
> 
> 
> On 08/10/2025 9:32 am, James Clark wrote:
> > 
> > 
> > On 07/10/2025 9:01 pm, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Oct 07, 2025 at 10:10:12AM +0100, James Clark wrote:
> > > > On 06/10/2025 4:21 pm, Ian Rogers wrote:
> > > > > On Mon, Oct 6, 2025 at 6:11 AM James Clark
> > > > > <james.clark@linaro.org> wrote:
> > > > > > +       data = zalloc(sizeof(*data));
> > > > > > +       if (!data)
> > > > > > +               return true;
> > > 
> > > > > > +       data->addr = addr;
> > > > > > +       strlcpy(data->path, path, sizeof(data->path));
> > > > > nit: perhaps strdup rather than having 4kb per tested_section.
> > > 
> > > > Oh yeah that would have been better, not sure why I didn't do it
> > > > that way.
> > > > Although the max sections I saw was around 50, and it's usually
> > > > a lot less
> > > > so it's probably not worth the churn to change it now that
> > > > Arnaldo's applied
> > > > it?
> > > 
> > > I see you submitted a patch for using strdup() and then there is a need
> > > for checking the strdup(), etc.
> > > 
> > > Since at this point this is an improvement on a test and all is sitting
> > > in linux-next and the window is closing for v6.18, lets leave this for
> > > the next window, ok?
> > > 
> > 
> > Makes sense.
> > 
> > > These would be good things for some tool to catch, before it gets sent,
> > > but that is another rabbit hole :-)
> > > 
> > > Thanks,
> > > 
> > > - Arnaldo
> > 
> > Does Smatch work on Perf? I imagine it would catch this if it does. Or
> > just plain old cppcheck. I'll take a look.
> > 
> > James
> > 
> 
> Smatch doesn't know about strdup and seems to be more focused on kernel so
> probably isn't a good fit.
> 

No one is going to write a check which tells people when to use a fixed
array vs when to allocate memory dynamically.  Those sorts of decisions
are too complicated.

> Cppcheck struggles with a lot of the kernely style that's used in Perf,
> especially the headers. We'd either have to silence a lot of the warnings,
> or start with almost no warnings enabled.
> 
> It doesn't have a warning for usage of a malloc return value without NULL
> checking, so in this case it wouldn't be useful.

In the kernel we care a lot about missing NULL checks but in userspace
it doesn't really matter in the same way...  It's easy enough to write
a check for this in Smatch.

> 
> I'm not 100% convinced that the effort of integrating one of these into the
> build system would be worth it. I know that once they're in, there would be
> constant maintenance of silencing false positives etc. And a lot of the
> warnings are more style or opinions about undefined behavior according to
> the standard, but aren't real based on what the compiler actually does.
> 

The thing about false positives is that people should just ignore all the
warnings except the new ones.  In the kernel, this works well because we
fix all the real bugs right away.  And if we haven't eventually someone
will look at the code again and after 10 years or so it all either gets
fixed or it doesn't matter.

> As an example, cppcheck on code-reading.c with --enable=all gives 17
> portability, 11 style, 3 warning and 1 error outputs. Out of all of these
> only two of the warnings are significant, from commit 0f9ad973b095 ("perf
> tests code-reading: Handle change in objdump output from binutils >= 2.41 on
> riscv"):
> 
>   token = strsep(&version, ".");
>   version_tmp = atoi(token);
>   if (token)
>       version_num += version_tmp * 100;
> 
>   token = strsep(&version, ".");
>   version_tmp = atoi(token);
>   if (token)
>       version_num += version_tmp;
> 			
> "token" has already been passed to atoi() so can't be NULL in the if
> statement. I think the atoi() needs to come after the null check.
>

Yep.  Smatch does cross function analysis so it would have caught that.
(I haven't tested).

regards,
dan carpenter

