Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EACB2701A5
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448396; cv=none; b=QDAhqKC5IqpTsCNbdJzmWCOlSYQy6BUGUrwKbMuN0HddzwJRLTp3fbB+Zfg5b4ZQ1pBSBx/BYlXySqxFBWFe9L+7qMAzLt6QqLbDdN9Jr5QWTDDepQkjaecsDUAu9oT91VjxwMA4VjHO6yREqzINC7eNsABoPT8xZcBYjsa7HSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448396; c=relaxed/simple;
	bh=IMXl/A3yFuGvvJmg1HepUP07i7S5rKed7ldc4avjuHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SilQuVRm4y5mfiJGI7fTgP1f8FwZBoZRRbcV4j3rvEHpzJMcCHLXvTAHwq2Wut1g4VCdxwpeRHVkO8sAO49D8eNX12+cNOhoHt3uyumm7Q1CziV03cO4WjXUaDlX1V1qL1bOVKCaC7TPyl7eLEyHYnjDC8q+e0ubsdOhLny5gxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEZmjZXU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEZmjZXU"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abec8b750ebso70417766b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745448392; x=1746053192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2Qmb+wkwvs0jE1HR4ELuVOB/X5QTEJJo/QFMT2gUfc=;
        b=fEZmjZXUV8fjxDLBg6Mp5L+U5ZL5QJbyjBkgRDv3+P2IanKgPI0fFVy8JEFi7roZHy
         hE6CuLytFefqR+B17zKOZDcb1Ta4HunpHkVPGzpkOBdR9jSB4nV6hvpXy0T8/kSExPm0
         4OHVUabV7rh98wq7dKjb7/cCSu+3HgLZTL7Pv6oj64JEGN73aG0GN+mogowNh8dAf4Ur
         HRlp3GU/DoB/XECA+FGQ2DNuP2PfcGLo2nc82YPISWuWG1pirCk49NXFZx/xjp5NBu+z
         jeJBKcQfgjeyO698YxH9WSj94W+KtBlfEpN43HGSWfuvzLkZaEfqDwM1eoC5jDlyxitt
         1bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745448392; x=1746053192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2Qmb+wkwvs0jE1HR4ELuVOB/X5QTEJJo/QFMT2gUfc=;
        b=wsc+YbCCHaXn8v/U7IIzCyWVu2QdN2goZWM4vJpX1u7ISeWxdnBR0RpTG2NUX65TNg
         xg7HE/L45eUI4MCmK9Uqp2HHXR7LcSLeq4Sd6x6O2GRkThTHKy8uZD+UBt25lzNniMIQ
         x1DORlzpFYp7XG78GYUgAXUJEEwrWBDCbns7Glut7eJyTmCsBRAn19uNxxCFge3qMVmh
         uL/D0V0Ijx24gGmgz9S1YUORV4evxukUNwkySdvxClUNG6p8C2cUe72k9UeAvTOE2M7t
         xxg8OR/WN59dGnyOKSILX/S0C1u5p2IClv4ztrq5LZPukGTl7cpYIjR+f1VYaCwthy3W
         8l/w==
X-Forwarded-Encrypted: i=1; AJvYcCXWAAozWXcHcJ3zygyQX2aCWVkj62lwmXk9mOOEuDRri2+AXxSw/bcSgvev+SUO8hOBhkAM03EioDTdVDl4hKjZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oFhxcmbcBsoQl9bt5yxlezigP1wb3yLtjM+H8gKfsPg6Vd/n
	XZmQiZHjKC0ggAguSHWvflWAC6IeodHCGkDhtCOFseJaLsX5sOPQCcD8I1IyjnDn9Qm2WF48cCq
	3jlimF1RNaPV2INblTe2S3CeUDSh4Y/Oa/ayC
X-Gm-Gg: ASbGncvZHIgFNeXBxqnefN+Ww51NiUfdiqh8G4ULMpxNx4XII2mfOFoWpLToiA8IGUK
	vlO59RvATkq4vNcAtP3anPGJfbhMRDcoXYo5Up+1LtuwiHyU5eS1d9Dg+M8aQNaCRCGL7C53nrF
	DLhDpy6QKNEBVPPkGuKpKKDALRMsztmU6jpOIQg+mmPcnOdo1+9b+v1gtSeQ==
X-Google-Smtp-Source: AGHT+IEIUQX3u2UbHVW2Q3GZfyp1v107uY/UMh5B+ccLdxuZ554TWiJJ5a7OOifECgFbKGAyDKN4fsCYMXYb+co5kiU=
X-Received: by 2002:a17:906:fe08:b0:abf:7453:1f1a with SMTP id
 a640c23a62f3a-ace572a2deemr57881066b.36.1745448392443; Wed, 23 Apr 2025
 15:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414173921.2905822-1-ctshao@google.com> <CAP-5=fUJip8odShuUVCnwQg9MrMLVdCWjGdSFfUxWubfQYBy1g@mail.gmail.com>
In-Reply-To: <CAP-5=fUJip8odShuUVCnwQg9MrMLVdCWjGdSFfUxWubfQYBy1g@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 23 Apr 2025 15:46:21 -0700
X-Gm-Features: ATxdqUEGsYrpqaCxnMFHoDZpNPVkMcK9ff04teDDvJ08RgpruLSH8VAl7VnJK7c
Message-ID: <CAJpZYjV1Z_A08A1GSTLZwo7BCaJNGGD+Q06w2A1Uc9p1ihT=Tg@mail.gmail.com>
Subject: Re: [PATCH v4] perf report: Skip unsupported new event types
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, dvyukov@google.com, 
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

Thanks,
CT


On Mon, Apr 14, 2025 at 10:43=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Apr 14, 2025 at 10:39=E2=80=AFAM Chun-Tse Shao <ctshao@google.com=
> wrote:
> >
> > `perf report` currently halts with an error when encountering
> > unsupported new event types (`event.type >=3D PERF_RECORD_HEADER_MAX`).
> > This patch modifies the behavior to skip these samples and continue
> > processing the remaining events. Additionally, stops reporting if the
> > new event size is not 8-byte aligned.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/util/session.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 60fb9997ea0d..ba32f8461a4b 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1639,8 +1639,17 @@ static s64 perf_session__process_event(struct pe=
rf_session *session,
> >         if (session->header.needs_swap)
> >                 event_swap(event, evlist__sample_id_all(evlist));
> >
> > -       if (event->header.type >=3D PERF_RECORD_HEADER_MAX)
> > -               return -EINVAL;
> > +       if (event->header.type >=3D PERF_RECORD_HEADER_MAX) {
> > +               /* perf should not support unaligned event, stop here. =
*/
> > +               if (event->header.size % sizeof(u64))
> > +                       return -EINVAL;
> > +
> > +               /* This perf is outdated and does not support the lates=
t event type. */
> > +               ui__warning("Unsupported type %u, please considering up=
date perf.\n",
> > +                           event->header.type);
> > +               /* Skip unsupported event by returning its size. */
> > +               return event->header.size;
> > +       }
> >
> >         events_stats__inc(&evlist->stats, event->header.type);
> >
> > --
> > 2.49.0.604.gff1f9ca942-goog
> >
