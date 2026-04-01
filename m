Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490673803C1
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021391; cv=pass; b=RQeLQKGyISW8TdAVcIA1ea/vJVY4UJDq54NX8iQzEU+UJy/HvVX0QU3vL9H0DWHdvo7PKno3OdMZ1CuJ6Zst+lzlGTqF/SNBjZVdNstkaNb6VXsD5hFSJisL53NPsum695YAjMuU3JbykH98ej1WF42+h61cHJtcmj/6pFjgzQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021391; c=relaxed/simple;
	bh=2c5ZUWD8nbarVE+Azi7suaoDEGJxWaCF6WzdJxJb3lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr039Bwdjf/H5uLsMtR05pjKUa0ZNnokG0NMIKqDbyXfOcd3LiB0F7C4zcUhZMOKesiDZSbSYqKL6SWPnh82t4iUgV06DpKRmsDfY3SjMF5z6YrjC8A6u0Au2rCpsI8g5Zd3eUexbu8yiuhT6cxe5ZTPBz537ShwiVxbXANZCNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1QC1syz; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1QC1syz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b243198058so151735ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775021390; cv=none;
        d=google.com; s=arc-20240605;
        b=BM64Aw8FLZZNWPXD94/YkiWAsB41OQg4tqhfa1NNN3+PnZcaesrucm6nIM4ygfBw/N
         NgR1q4a1qAjm4HbxUfBXpqKgob/JCMgt0LZFm0SBNUPp8nKCfEXtrLpSZedjr4efcBUS
         UYxm+7M4Zqbh8Js1zPbKpVNkQMk1NVPiYnzVwTEe6/YeJBAPyC9X9tLhZmr4DuLPlDbE
         x60zBr4iiz82OwCNOkYPrsyN6uUt5NXCzT1v532m1uSVoHYEqIt/8WX4hlsxsIXNyGe2
         MxCC60bm9tQ263+yHwnNCP1pDrftu4GvYK0zz72T4Dsje4iuKbquPESgk5sBqZEp3Zfy
         6qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MHvTXFr80J8lkhJdyH5wvFfx93OrgN/d3nB/zuREgAI=;
        fh=rSDWw6rRGuRRNDZO0yG4XHPCLzjVedj3i6NYjLadxPs=;
        b=TXagNQvXfJxpjkOrpSoRyxWMsckDVToHBa9DpFcmegfr6BTGNbtp4oZkgUfwvjlWOv
         0QFZduZXPOVAs600QV+dB0mlAWEfI8OcnjgOH98uONjufQMhgbhXIu+nzYVwnumEgLYE
         42je10x1jw4iUKnAyQupyIJPmMTHQp1FA2xrRGtYuPQyinrJZn5ieWzEfzBPv87nL35m
         /j8XlOirqHBqFgSntdofhnVcj7/kWMxYwxoeh1+17jFo7uP8VCMtEItddL4GftIo7rO7
         aoDOXpFkAPHhb7nBEGdS2cZrEIiLULGLtmXbhj4Y0qDJBXgcZvz/KcWi4O1ac5ZC4ttW
         +V3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775021390; x=1775626190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHvTXFr80J8lkhJdyH5wvFfx93OrgN/d3nB/zuREgAI=;
        b=n1QC1syzm5g94iXTl5Y6MXl/zhevgl0S24GQi/u6bd0OcYXbPD4ZOU0ysXYAZNGZT3
         193rUYhDeYsGCThDodA9UIK9gPooUdKKjUdhnBtwYKEf7cizy05HQugo10qlxtVEzK8s
         LfZh/cHlwf86vzt0fyNDpcPuxWNqew+Oj7iFW3xSe6Y/q0G9Lh4lzjmsnCkv0VQWNtX6
         b0ymakcBcPTfwRVDvD1DD65RbfWiK+iZJ6V5TgeUh32DLmViYUb4q/LFTc+ljea0X8jr
         EA4wXNGE7Rkli135P2l51wdT85e6qBy7/RoVixc4ItRtneMsZcVup5bWrLiUHx2t+AZY
         1S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021390; x=1775626190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHvTXFr80J8lkhJdyH5wvFfx93OrgN/d3nB/zuREgAI=;
        b=Yzw9PfiyZ6bUGNBX9TPe8WEQPwUxxmOIseWrZFLb9ycaWwuTw0GYoyo+kMlTnKi8Ji
         aW5HG2v0sb+YdtbceKr3qTtvoRIRERk5wHhHvqFKXSDkx0OnRGEt2M0lE3UOvf1bcuzv
         TGrdkI3MenS2XZCKMtVufZNug9FfisRRu/veIpKI9iF++dC2YbSxDbbZkzMonTK7uujE
         hDfU2rzsNtxQA2YZ6jgo5gRBqpN/QXc3Twf1vzQedOwncgBP9lKHv1nfNeSHzkZ3z8a8
         Bk7miRRc5HGXPKHML/JgYo72j86iXbnSQvoRdbudb3RmL1hPdIN4EkIOsfVsbjDIJEV0
         yfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3wnJA+LFF8MNbFThV5WV5JKNHIdzLTahJjgYUhjdU86PfFP105aWh2TDn77Zm/GF4FkP65X0chiyEv1MkDjCN@vger.kernel.org
X-Gm-Message-State: AOJu0YznWwyEcPxIWFmIQLmciQD1Ru+358b93rS51LT6zJKfOUC6muSv
	eJAIFZrBLAOBw7y2A9GxQSHB11Mp3f9csYS0+9p0MHiv1FuTEFRlysiMYpGnBhxAdeLTGn4x9eq
	KC6BotiHckKeJlOk2xuckWwISkoXNMAl+W+1DUTUz
X-Gm-Gg: ATEYQzwBR2/vCgMkTi7p9DKHAizV0tfe4AOgjKgbnEvKm9zD8BL/qL+4v8k/f0c/DsJ
	3CQVvYs2DIl/N5JFqtPWk19CbP/cl2fyc73HGXNwOLqTjAYpl/4lgvAMSuRoPagI4wFUHWjaB18
	77qzMR4RsfKXu4Zx91nkmIdjsLpfZYSH+UxjmKPCkXQFYelwpMu38Zp+rfIULj3Qwe9to3Aqc2A
	gmXBODYOOuFNpypPioJeihnMSnLtvonu9GY5yNKGXPwy/C4ZelSKIJYWuv40dLAC6jgMYSfq5E7
	GBSU65eY
X-Received: by 2002:a17:903:32cb:b0:2b2:4663:abe0 with SMTP id
 d9443c01a7336-2b26b1c1b69mr1406505ad.7.1775021389008; Tue, 31 Mar 2026
 22:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com> <20260228065953.3226283-6-irogers@google.com>
 <aakiZ_NyxlLvVSoy@z2>
In-Reply-To: <aakiZ_NyxlLvVSoy@z2>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 22:29:38 -0700
X-Gm-Features: AQROBzASE01uzf24IBofmWNCIq4M3IUNeeTNjQYhGOhg-P6FiRyXhKRTCzhm7qw
Message-ID: <CAP-5=fXY0_UvgFPaVrVOs9KVGGgSOsVCpQ5OpvjUY-nbXvBUHQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] perf ordered-events: Event processing consistency
 with the regular reader
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 10:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 27, 2026 at 10:59:51PM -0800, Ian Rogers wrote:
> > Some event processing functions like perf_event__process_tracing_data
> > return a zero or positive value on success. Ordered event processing
> > handles any non-zero value as an error, which is inconsistent with
> > reader__process_events and reader__read_event that only treat negative
> > values as errors. Make the ordered events error handling consistent
> > with that of the events reader.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/ordered-events.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered=
-events.c
> > index 8c62611f10aa..a5857f9f5af2 100644
> > --- a/tools/perf/util/ordered-events.c
> > +++ b/tools/perf/util/ordered-events.c
> > @@ -243,7 +243,7 @@ static int do_flush(struct ordered_events *oe, bool=
 show_progress)
> >               if (iter->timestamp > limit)
> >                       break;
> >               ret =3D oe->deliver(oe, iter);
> > -             if (ret)
> > +             if (ret < 0)
>
> Are you sure all oe->deliver callbacks return negative for errors?

These are the same callbacks used for unordered event processing; this
patch aims to make the two consistent.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >                       return ret;
> >
> >               ordered_events__delete(oe, iter);
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
