Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175107FD;
	Fri,  6 Jun 2025 04:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749184471; cv=none; b=BDUki84++z6lmOUbPvYjok4sdk9JhGURhaixJJKL+vPhuXsre/RU6MLQNvSLBI/LolSCx1ofBZSjb7ZnLBMPIwAj0sPRArI+gn62SqEbjU+BU2pgertTgHXl8/cJKJ31Mcdd8TEh1vQFC5pkYJnQvV69sTY5eQLH5Jwpbdf8m5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749184471; c=relaxed/simple;
	bh=vnMAELuzG2kke7g/yxfLyim4FLm/VWvttWQ0dUK8rXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiVPN3JNf5iiN0kQXiwSHibafPW8TW5wyDxicB2zeVUDTZe0H+4vDEynpxKkqch14Xe70HJm02dmccIOhnMANKPEYdAycLWtxts4VFWnePHHLTaZM36ZanUQOCLJFxjKRNX9LBkoKAbRWBuokOAcgKDFSz1StV7INctPnmM+4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADzVPUQw; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADzVPUQw"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2e95f0b6cb7so637759fac.3;
        Thu, 05 Jun 2025 21:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749184469; x=1749789269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mg1a1IQFTFf5ogNp6q+daBBqdh0tsbxhquOjKrxejzo=;
        b=ADzVPUQwFzseONnjO4Rfqm+pSf9LZakhYSwcAc0ffKgaMz2lBYpNMrY59OAHrPF2VI
         NErN4R0/kAypPLf5edS9UVKkll1O1JodatQ/uwzPb8LyPIl8e1PCsmjOE9H4fWLzIDBc
         JojchhUi8GOREYo2QFduZNdbfvWgUFCZLkxk1NKDjPO88RTiY7vcFJc2AaTE9avkOU7L
         JfPLy+CdfaCxBry8CkHjWZ3CVn0logwxX+ocuQ/UxIFJ6UbIjuqWwiPqbbUFKmD1K8+Q
         d/ekcrZh9cAj+KwPiNVl1K5ZMnqbWM9hajE1YjRHwxo6OhL1NqUji8PsGW9NP1dnZBZN
         dlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749184469; x=1749789269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mg1a1IQFTFf5ogNp6q+daBBqdh0tsbxhquOjKrxejzo=;
        b=I505OrBrHJwPRCHYKLEApqLzhcUDb8WMgL5ePQM7589vVcOm3zl+e0jG8gCVBRkL+O
         ilGaih+K9Ga0UnoNI/7n4IzJAMqaexHpSCF5HJX+kJNFQEZg7AGcIffTbIIxQGI17mP0
         rwKfNYjye6rzfnReFfp8VYFBAOOqNvtYH3hBXEXSEwtLkh3Id3Lcf/yWamLasvMmtUiY
         Blq1GSA1jwQXifcnZG7wJLqf1ZeASHeyD9lPPSRadfCU846zghoiFCjzKtM4r6oSlHsO
         TIxz5Jjmbwo3u3O1O6ngNkyxi16Oa8ZU24y4c4KBYJBGTkFNTumuikHChrfljCUODwn8
         Nleg==
X-Forwarded-Encrypted: i=1; AJvYcCVbUCtr/gmf4RpQP6/EFwQuIbC3aGemolFOHNdDMHX5WvlJ1eIif3K4D5FpefcCYkN3GL6zmOQ2A2uJXQLF/+0g8A==@vger.kernel.org, AJvYcCX7EyCenTRTnjtFAeu9+SiMeN2dOF2bUotcmzclq5+UgFctzIvTk3fJh0nps8Wqg9HOsL+JRNCj0dU/RvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kra/7iXdeciDbgScLN+9y0foHwkknlo6maW/ZnbcOnmesvgo
	zB0IJDgSHds5ZSavt/juGN37Z2f921gh2MCYE081frA/6EiPxJ+Yq4MuSFA3YchoThg228vS+yF
	wnkJyU1jFI4XZrw1Z4o4JGNojWH9YNos=
X-Gm-Gg: ASbGnctf49CX887+oYiWLN3ZwuKzttE3bJAcxeSxyAV046+Im2v08lUFF3rGcpS9idd
	BmGsweemm/Vt0m7UKZiv+brbjNWLo5pP6GtwnCAiIrby/znZriCA3P6tJwYx/9uGbVUcqxN0GjR
	SQDdeGMlE6IMqhiRFAClbK+VAA/uzqETVBl2xeoSlSZOG1
X-Google-Smtp-Source: AGHT+IGe+Gpjm/xzoy7jVhdeKpcvtPkvOA47lA3aaDIdOsMO7A1fppCgysW8oALEl3UfWBrN826LKnk4mLCT4zvsXkc=
X-Received: by 2002:a05:6870:2e03:b0:2e9:512:ee1a with SMTP id
 586e51a60fabf-2ea007a7ce8mr1204043fac.4.1749184468851; Thu, 05 Jun 2025
 21:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605180012.16788-1-suchitkarunakaran@gmail.com> <aEJnQIviayEi-Jsv@google.com>
In-Reply-To: <aEJnQIviayEi-Jsv@google.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Fri, 6 Jun 2025 10:04:17 +0530
X-Gm-Features: AX0GCFuRiJTuxgtQoZd8Ei54IeDfiUe37eSzPDMDXBh-MAmv0rzA1AygHtFg26E
Message-ID: <CAO9wTFhyQnE2hgvtQuYxfCTjd7iRHJN5O+v3wka7smDkrUX1GA@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf stat: Fix JSON output formatting in iostat_prefix()
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 09:27, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Thu, Jun 05, 2025 at 11:30:11PM +0530, Suchit Karunakaran wrote:
> > The iostat_prefix() function previously included a TODO noting that its output
> > format was incorrect in JSON mode. This patch corrects that by conditionally
> > formatting the prefix string based on the output mode specified in
> > perf_stat_config.
>
> I've tested this.  It doesn't work well.
>
> Before:
>   # ./perf iostat -j -I 1000 true
>   #          time    port              0.000517525 0000:00 "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
>        0.000517525 0000:80
>        0.000517525 0000:17 , "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
>        0.000517525 0000:85
>        0.000517525 0000:3a , "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
>        0.000517525 0000:ae
>        0.000517525 0000:5d , "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
>        0.000517525 0000:d7
>
>
> After:
>   # ./perf iostat -j -I 1000 true
>   #          time    port         "interval" : 0.000463559, "device" : "0000:00""Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
>   "interval" : 0.000463559, "device" : "0000:80"
>   "interval" : 0.000463559, "device" : "0000:17", "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
>   "interval" : 0.000463559, "device" : "0000:85"
>   "interval" : 0.000463559, "device" : "0000:3a", "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
>   "interval" : 0.000463559, "device" : "0000:ae"
>   "interval" : 0.000463559, "device" : "0000:5d", "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
>   "interval" : 0.000463559, "device" : "0000:d7"
>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > ---
> >  tools/perf/arch/x86/util/iostat.c | 35 ++++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
> > index 7442a2cd87ed..1d9c20dab5c7 100644
> > --- a/tools/perf/arch/x86/util/iostat.c
> > +++ b/tools/perf/arch/x86/util/iostat.c
> > @@ -403,18 +403,29 @@ void iostat_prefix(struct evlist *evlist,
> >       struct iio_root_port *rp = evlist->selected->priv;
> >
> >       if (rp) {
> > -             /*
> > -              * TODO: This is the incorrect format in JSON mode.
> > -              *       See prepare_timestamp()
> > -              */
> > -             if (ts)
> > -                     sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
> > -                             ts->tv_sec, ts->tv_nsec,
> > -                             config->csv_sep, rp->domain, rp->bus,
> > -                             config->csv_sep);
> > -             else
> > -                     sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bus,
> > -                             config->csv_sep);
> > +             if (ts) {
> > +                     if (config->json_output)
> > +                             sprintf(prefix,
> > +                                     "\"interval\" : %lu.%09lu, \"device\" : \"%04x:%02x\"",
> > +                                     (unsigned long)ts->tv_sec, ts->tv_nsec,
> > +                                     rp->domain, rp->bus);
> > +                     else if (config->csv_output)
> > +                             sprintf(prefix, "%lu.%09lu%s%04x:%02x%s",
> > +                                     (unsigned long)ts->tv_sec, ts->tv_nsec,
> > +                                     config->csv_sep,
> > +                                     rp->domain, rp->bus, config->csv_sep);
> > +                     else
> > +                             sprintf(prefix, "%6lu.%09lu %04x:%02x%s",
> > +                                     (unsigned long)ts->tv_sec, ts->tv_nsec,
> > +                                     rp->domain, rp->bus, config->csv_sep);
> > +             } else {
> > +                     if (config->json_output)
> > +                             sprintf(prefix, "\"device\" : \"%04x:%02x\"",
> > +                                     rp->domain, rp->bus);
> > +                     else
> > +                             sprintf(prefix, "%04x:%02x%s", rp->domain,
> > +                                     rp->bus, config->csv_sep);
> > +             }
> >       }
> >  }
> >
> > --
> > 2.49.0
> >

Hi Namhyung,
Thanks for testing it. Could you please tell what could be improved?
