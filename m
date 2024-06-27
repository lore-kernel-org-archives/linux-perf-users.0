Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5719A299
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509195; cv=none; b=N1ZUaARe/ULMbJNIDzSrY/Lpk7Fwjmxw+m0w5/ge55dzKlHQ+BRXNqDKUfSJrtSD+ZEZ2kFgTWqV1EL+kXGefxUIpWgAwU1StTa5J7QUsHaGQdrpf1F+iCGIabf+x0rE2h9NlvcsCtWLLmZxCV1XBCxk7Os/bFNgECSV+CowXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509195; c=relaxed/simple;
	bh=+JSD7zPCyP+seLtEHsOyOFtvu0SipabmuDyxuqRoZXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=qI6ME+U6/ewLm+1A5NxyAESTs9/9od8eiN145ipeHklmZmh1Wg4M0J/Hxvx3b9gOA9Yk6cTdkY0AnqEbl7je2QB25A969xWEyMTz21s/o9NWtMSSfrZeatoPmYKozrhjbc0iGik6cewmxdleNAeSbpR4HVqyKczscbdkRf31RyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ml9rmd4w; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ml9rmd4w"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-37624917c2dso7665ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719509193; x=1720113993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG0d9P09i9DuBsLa5XC/aW7vKh1cVtfIv4ydt8vzMS8=;
        b=Ml9rmd4wfgoQcqIPl5Jr1+mSuTSCIdMVInt1qHTdEH0cxC8QEG0dKuTcX3YUiJPmVG
         4AnWkIy7rSA0kPM2qmW7zt225E9gY+HlqDCLVZ2VxTF2mn+W/zqCbz6Ib4x2i90+OWqd
         PNKmEz31ulMo9b707mD48f/hI1LMrXtsuGyCpLJzPdF/g9II81fZkoYB3PtrQn2ZwCIj
         DOO9FT8/19skUCMhJu0r04U5XXPzzAdp2NdJfh5anPhXh8ZzJzCuhZqHp3L6Xps2Jc0G
         ySuwk/xZwhwzexgcl8oF2qaJnqlJVayF9RPeB/5PF6Kdb5K7fMnJnva6Ztd9LiHdvhWU
         O4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509193; x=1720113993;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG0d9P09i9DuBsLa5XC/aW7vKh1cVtfIv4ydt8vzMS8=;
        b=AeWq9NiPzy6ime2HQV6vuv/tFlrLiynzXToqCJ20P+KFdPZD8nuZRymkrFz1mRNHkE
         AzDscztBXAmJtgVhKEexaz1JD/QIc1yNR1QUbt/QhJGDn/1iO/3ac8giQACCZltGZMee
         sWHlircyVY+jZm8lSevp9UgkcXuHkE/Dmc1buMtyaY5BCrExkOTzLZKSd8MRUzjz5joz
         fLql2wvkvIxStYq+pCIMQlj7DwMMPELZW+BvOO3qI6Z5PoBTvWEZsgK61EqolOmsC+iB
         czMSqcrEHQGcMud3zre726yeL+3QlqMsSC8bCthFGIFqUHgBgoUyG7Mk0GMCu5OBoPWa
         OQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOIFGFIRNRA2+moo9TBaLLgsaRXF99mviSB+O8izCqN1gp4j83x6jy2vUvpYTBYUecvzqofRgyNjor/xRsCs4p+E8Z6iAFv0/QppAwRJB4IQ==
X-Gm-Message-State: AOJu0YwxNLcSmvjrnFI8J46S32NiCAdXQ33XTh56FI9DSxi0ob7BLfPO
	1v1cSYzDjFQvtcx/K09GTDmZDdxY7vfMpzowzKDGayfSC88XCvxUQJrHuTJAapJZ5wNAvfdWhmQ
	iMFuDD+k+cUS5uyYvM0eBkFFK1uGPB2x9eGoKwLjOhprrOH6xnA==
X-Received: by 2002:a05:6e02:12e9:b0:375:bb49:930d with SMTP id
 e9e14a558f8ab-379897f6cd4mt5415525ab.23.1719509192944; Thu, 27 Jun 2024
 10:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627150606.2224888-1-amadio@gentoo.org> <20240627150606.2224888-2-amadio@gentoo.org>
In-Reply-To: <20240627150606.2224888-2-amadio@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Jun 2024 10:26:21 -0700
Message-ID: <CAP-5=fVvc612rGoE3xXYqRornKZgTLgnyQH8jfJ2D9x0pDDcPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf build: warn if libtracefs is not found
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:07=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org=
> wrote:
>
> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> ---
>  tools/perf/Makefile.config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 987b48f242d3..e99afc7eb4b5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1204,6 +1204,8 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>      LIBTRACEFS_VERSION_3 :=3D $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION=
)))
>      LIBTRACEFS_VERSION_CPP :=3D $(shell expr $(LIBTRACEFS_VERSION_1) \* =
255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
>      CFLAGS +=3D -DLIBTRACEFS_VERSION=3D$(LIBTRACEFS_VERSION_CPP)
> +  else
> +    $(warning libtracefs is missing. Please install libtracefs-dev/libtr=
acefs-devel)

This all makes sense and looks good to me. I believe perf isn't
directly depending on libtracefs and gets the dependency from
libtraceevent. Older libtraceevents didn't have libtracefs so just
warning in this case makes sense to me. I just wanted to speak my
thoughts out loud in case I was missing something.

Thanks,
Ian

>    endif
>  endif
>
> --
> 2.45.2
>
