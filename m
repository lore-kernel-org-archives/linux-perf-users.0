Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1C2BE7CC
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719162; cv=none; b=GLstIAB6xIhxlod+swqlFxMlYppsFkMt9l7Ro/kpij8jlaJibcmachDY/bkGFYqWROSYcNMDM/SUa5TlsBFxFQaBZFdc2tWaJmWDmZ9BPOY8eQDEPQw8CjN07e4jmKA4gjO5oxAiczQHwbemvD63ZRy5ufM9TsoDPRPaKEiI5yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719162; c=relaxed/simple;
	bh=NfOtUuMo2bwMPO8gai/HvBpCuZ8kXKbcNDvD7FcJZOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP+N4ZiYVu4EB6mAeQuoLVMRl0idLekFeb92BKImy+nT0VMIWf8+KwwE70DRZCgfQPcvVrT33K9PP26XfqLRxUnlZ7KTyA7ZTKMyTZg2WbGQf37ndr+NphkWEx7FSr15P6f9ikWcY1TwbhBTpWAgvcA+h6SilvK98Y4SVICBkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-59a8c1eb90cso965875137.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 09:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719159; x=1761323959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0Tvx9lsrJzDtuSp7NrJfF7JnTCr7NK1zbx5mSNtjN8=;
        b=m9ovgAB99qGL6Nno2NNzK95AOt4bzAzqhr/R1T8y53WG6jo13vXhzi9FY/DpO65nN8
         6sB5Nf/scJkv9w3gaUc6lU35l6WOWzZvs33ZtfG2YGGk8pVCHgyNJcaon8gRDBjWkgwq
         Jt4RrQxRXAJy1Ks+1jItJdDSCef8EGTTgTgubOWOiLhnxNqCPxeFIWa+4CzQH04An7VB
         aewRBK205/6BXIabrjhb1XOjTWWsfdmyN3wJ2ypbTG1gnsQiYK2ISJm1zqfzPeKL00TM
         pU9e+8/Gb3KUuG6hQvQc4wlKIX8LxowRzpsHnHdPQj6klFX1agkSK8mRgk1CWziYIVSH
         iiaw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4L8ijvOxGHAJu5JRmITa6f1728Im+InM2V/sDmYoh8uyXoNS9C/xOE3XoqhqT/r2YUXftPQ/U4FCfjvC1iBu@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEvYKzNoBHlzCSJ+8JiijvmEvD++ZnuQbV9AT6kR4+onpJz9a
	rfRhP4+THSp4ZqS4kfj8l4X2z6fixXPcTZWRcMLmIEKpn3y0tgERVKtwQRF+KfAG
X-Gm-Gg: ASbGncub5boaI/RHpu/QnzyqQY4sNxsaiscHBTdi22dxzow8A1Bu/XyqZ2ToBo2tUz2
	nuVumPPbyn2RJKGBxwSvDsmU0cWKSXjsO06tylT4FMAorcZ8PxoTJqeSZGyI5WhK+Tvb8gwsLlz
	9revmDToFmPN5p7RKHXm/caaibjHhLqEU23xSw/yNevnlW4sm1NSi1vxSbP+I7GCaVBRePZ4Q3G
	KwM/FKN5cZ+eeaM+kjj5pCXUcgEgZaJ86Fbt8wcPLFLrs6VrUxHVVY/pRvrp5U44xGjWE9b3/BD
	MiG18hjzof2ffsscVMMQyGMMgVkmKA5+V4ct1jYrmskEMF8uYWvZ5m2m7v2PlQHqNO+aXpyvaQh
	F5eQ4dwFlA7A1MB9Kc88sWt/S46zfFBA+cOnO6+eNZkNJkQZlOb+XRw/spd2octvR25nMWrfqAp
	tiRmMEZA994rGoO5/OS4tQlylsGhP34zV4YB1d4A==
X-Google-Smtp-Source: AGHT+IF0UesxR31yH2rtw0349hvy6IGlUTu7SQf7hU43XVB9XMbb/d9FxzzWCYX67AIkehwMhON8fA==
X-Received: by 2002:a05:6102:5086:b0:5d6:156f:fedb with SMTP id ada2fe7eead31-5d7dd6d9cb2mr1936841137.36.1760719159266;
        Fri, 17 Oct 2025 09:39:19 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-932c3d855b6sm88994241.2.2025.10.17.09.39.16
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:39:17 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-930d9fdeb96so626220241.3
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 09:39:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIR52ePzOjy6wiNLHAme5e2AM1mg5N8VCcancihToHSXqn2sWi6Ykqo2vjEcf0t1/Ck+SRwUeBSrKJZbY8e2BM@vger.kernel.org
X-Received: by 2002:a05:6102:26d6:b0:52a:c340:11db with SMTP id
 ada2fe7eead31-5d7dd6a51f8mr1798386137.27.1760719156495; Fri, 17 Oct 2025
 09:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760617634.git.geert+renesas@glider.be> <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>
 <20251017122904.GC281971@e132581.arm.com>
In-Reply-To: <20251017122904.GC281971@e132581.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 18:39:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>
X-Gm-Features: AS18NWA0zz6hIIpzSiBNMZXGZq9sP-ysnqlRTvuWYFFdCu80QapeqEG6wNBFpYc
Message-ID: <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf build: Add Debian/Ubuntu python-is-python3
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Leo,

On Fri, 17 Oct 2025 at 14:29, Leo Yan <leo.yan@arm.com> wrote:
> On Thu, Oct 16, 2025 at 02:44:12PM +0200, Geert Uytterhoeven wrote:
> > The build looks for "python" and "python-config", while modern
> > distributions provide only "python3" and "python3-config" by default.
> > Suggest installing "python-is-python3" and "python-dev-is-python3", as
> > available on Debian 11 (bullseye) and Ubuntu 20.04 LTS (focal) and
> > later.
>
> Seems to me, this change is not necessary. The Makefile [1] searches
> python[2|3]/python[2|3]-cofig if un-versioned executables are not found.
>
> I confirmed that I can build successfully without installation
> python-dev-is-python3 package.

    $ sudo apt remove python-dev-is-python3 python-is-python3
    $ make tools/perf

Indeed, it still works. I am quite sure I had to install both, and
even verified that uninstalling them again broke the build again before
creating my patch.

/me dives deeper.

Aha, I found it.  After uninstalling python3-dev, I got into the same
state as yesterday:

    $ make tools/perf
    [...]
    Makefile.config:875: No python interpreter was found: disables
Python support - please install python-devel/python-dev
    Makefile.config:918: *** ERROR: No python interpreter needed for
jevents generation. Install python or build with NO_JEVENTS=1..  Stop.

So these error messages sound like python is missing. And "python"
is indeed missing, but "python3" is available.
Hence I installed python-is-python3, but that turned out not to be
sufficient.
Hence I also installed python-dev-is-python3, and that fixed the issue,
as python-dev-is-python3 depends on python3-dev, so the latter was
installed, too.

After removing python-is-python3 and python-dev-is-python3, everything
keeps on working.  But if you never installed python3-dev manually,
and run "sudo apt autoremove", python3-dev is uninstalled, reintroducing
the issue.

So just recomming to install python-dev-is-python3 in the error
message should be sufficient?

What do you think?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
