Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2B6FBF
	for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 05:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716700948; cv=none; b=UY9zS8JxTcWoECLvPyvJLBmLUVn+v6KZtwsXiYnE/tycA3I5dUfrkYPpXSShlb7+3nlN2HIN05xoDf6+LOvP+K5DJpzeScppHietanu18O5IzdGiN49LUI49vDBvcmAyp59Vep3MMxj1/yUR49+HICuIW124WGXIyb/ejPxrD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716700948; c=relaxed/simple;
	bh=2onGx/xeIrSjTBLOBGWgptieSEtXuzDCtJLlVc4b0wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXIPiPCVqZgGEOkkxiEXCU842J3berkl41rAwfzVz0FF6plZ90HQ4XoZBb6XYfLRhUUNybi9bXAXyh5QY8p3Ogm+vGfoGznlu5KEiuzSCo9ukz7iFyn9kisD0fIKZnkIOGaKgwSThlZIFh851V8oP6TmEkxVnHUhm17ruGbFF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BsoKf/P9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BsoKf/P9"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-523b20e2615so11370713e87.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716700945; x=1717305745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gPJVRsED66SFuo9QB46LJPJvy8CLRk0JilNUt31CkN0=;
        b=BsoKf/P95RQba8zhxdwUMBfUXqPHTbtfzLt5Rw5N5zW7op3RhJ+f2GDuK6PIGgdBY9
         xQWwYTw4+2Ab/X5s2Jo1aMsNqnvWTyZY7al8kTeDVPeab7UjzASFj0fwhWjsG8R0NZIs
         o4x78B5W/HP+QClXjYeo6PaTYOlzXX5yGWEoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716700945; x=1717305745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPJVRsED66SFuo9QB46LJPJvy8CLRk0JilNUt31CkN0=;
        b=J5Mcfv0m5NmV+CqriKlPmKwLhqc9XBcvMOD433ZkQiyr1ECmn4snmFd7KtBPvgPMKO
         /VszFlgTuxCxzFY0bPIqvwEtHbpL2Jn/7vsBAVr0BXIO0Klpl543s5sq+zNPMSXilgKD
         lEeFOP/tkQG8Kfsd6x0CKyp/JH2mdp6AxqgF75GnXvCdYsJiCey/pbAAgiWqOFupTcx+
         54QeAqIh63CRh2tgxM8kzp0udcy6HkjxaGFouySVwf/soksnXnNn4b4ytjkFVbcaKyHC
         AktKhMXzWqNOcb5R3TCnm3VF3i/pMxBvuRjjbUoNpX5wI83BdB+eKm+5/1/Br6uox+TO
         RAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQNrx1XomwGTBmt/6lZrsZqeiF2LkZQSXlWTQc8N87bt5PshlE7PUfSiE5sYRUb38b4n6GFdxBmPW3b1CBFD2Pv/lu9Ivas/cnGO+Q/Bc2EA==
X-Gm-Message-State: AOJu0YxmoYyoxO9meL+sZuow4+5TF+/fvv203ZmIKszTZNc+/7G5I0SY
	JXyUj11kJxA23tb/okSdrcCM3xSYuXIs6m9gCuo1R5ytP7+tkAwscQRxOFx4LdmG/A3jNjQzGzW
	W35HN9g==
X-Google-Smtp-Source: AGHT+IHeBeYCMT/ZsCfGmZ/1arOrsRtZQomvORd/Zr8tiqm4EWPdNF/nz5h9EI05PclheEx2Cyvi1g==
X-Received: by 2002:ac2:4206:0:b0:528:5301:bae4 with SMTP id 2adb3069b0e04-52964ca7358mr3802120e87.35.1716700945014;
        Sat, 25 May 2024 22:22:25 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8adf3sm333076366b.152.2024.05.25.22.22.24
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 22:22:24 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57857e0f464so2312706a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 22:22:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0gBxBAMnf7/34youTJ91qCRjretOWJjTqmfg2sLu1RF/uN3BnnL9YiihkNMONUcY1C/YJZN+OuEQz2Z8AmePRS1Jio18AANSnNLXtg17nww==
X-Received: by 2002:a17:906:3014:b0:a59:9ef3:f6df with SMTP id
 a640c23a62f3a-a62642e9af5mr371152966b.22.1716700944352; Sat, 25 May 2024
 22:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com> <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 22:22:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
Message-ID: <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 16:34, Ian Rogers <irogers@google.com> wrote:
>
> So I think we still need to figure out what:
>
> $ perf <command> -e <event> ...
>
> where <event> doesn't specify a PMU means. I'll try to enumerate the options:

[ snip snip ]

How about make the rule be that if the event doesn't have a specified
PMU, then that just means "legacy rules first".

IOW, if you have a fully qualified event name (maybe define that as
"event name contains a slash), then you use the sysfs lookup.

But a simple event name that doesn't contain a slash shall mean "use
legacy lookup rules".

Maybe in practice that ends up being the same as your option #4 ("if
the PMU isn't specified with <event> then we only search core PMUs")?
I don't know the perf code well enough to be able to say.

But basically, the #1 rule in the kernel is that we do not break user
workflows. I happen to think that that is a really important rule, and
I'm disgusted at how many other open source projects ignore that rule
and think that "in the name of improvement, we will break the world".

And as long as "perf" is maintained in the kernel sources, that kernel
rule will guide perf too. Because the rule is not so much "kernels are
special" as a "Linus wants people to be able to feel confident in
updating".

           Linus
