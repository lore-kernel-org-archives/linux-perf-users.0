Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA22EFD89
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192614; cv=none; b=hgowLlNO21iRjf8V8GPfiBNWEmBo5+h9q5K+0svQlWM6IAE+zo16I2r7MKfggp0G4+MA0ptjbseGbG6987BIcGKntJBpy2YSMAiAAKz1ILVRwndnimSVa09G3OV+khlDmipl08nZ3uKFEguZ58AmBFVWEO40KwfNfZrItHunAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192614; c=relaxed/simple;
	bh=G7hqmBHb1iXZBcJkyo90cSmswhsGrPLntg46L09h6f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F74Q1vku0sAqLjnmhEuK8ihmgJ2Xm74QJLNkxLWii4RR4+vpF2Fk+LOBEgfuFSbmnOft217QKjgLUHw7Zt+GWRIjCKUCWQ5Gl8vE4yzk+/FQWXczL7PBsy7l1r0vJdnXd9eeUafCrnVOTb2iy4R3qwS7CDnC4v4M4dULu9S57VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3qa6Ql/; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3qa6Ql/"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ddc10f09easo31235ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 13:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750192612; x=1750797412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7hqmBHb1iXZBcJkyo90cSmswhsGrPLntg46L09h6f0=;
        b=h3qa6Ql/amLjFJ569DLsFWEi+M3igcsfWN30mECE4oOZFt/vWf/AhHhqrKgKrZn6ZJ
         EKkIO/uqRKpOq//zSlD4ECnM8QWCxn6As0RVGiPi/TPVcPpY5PQJI7xV7ZLQrc7nDRZ4
         295l9mK2fE+Jgk/ZfuFOAN3S+WhuVaA3PlH4I44AwML/h2zzDZjOHb2f8s8W3mYGX+3H
         0rfyQSOrWmbTo1bbaNthw/gotUGUlLSgrA41OEXZkZZd+iGyfv5qeQ+akccHowGR0iSe
         yMA1drsqdmZ1C1CJ1loF7zsrs8u2AaN/oPzp3qHPPAF/eMFB52yDlbpmzXnCh+Kzr0Ka
         cU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750192612; x=1750797412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7hqmBHb1iXZBcJkyo90cSmswhsGrPLntg46L09h6f0=;
        b=UrdhMur0RHiJK+1F4rFShiMe7ZUTvnlxL4EQM2R5OlmHy0McH5k2N72KFRWXt9a1Q5
         iQvbLJsmQe9iO4dfKG+Njfa+Hxu6tHRq9Kjgb53hVnRZ3EIz6hYl5mNF09opZhcNumkW
         Rumi7MeEP1OT36j5bMSJx8RETaCuLpJ3rgjhLTJZtFjbJrkQ4MY8U34K47axW8oqnQzR
         8zvULdjTeUOYYR/28DbOHIzM36dtGZd402kf2D8QvMOcuqfy44nPgS0ljpHGgf1S+Hx8
         oNlJto/+oZYyFxKVnp98ERrc40oiJxCeUyCa43g5lvFaChDVDd3tsAv2QFsP3DtpK7v1
         g7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUSRM549NmHH1fuw+z2RebjaeK2dWArFqSNieZ1wSSmp2aTeVatvk6LlMtfFXRjs/3ObVfzbzk+0KzPCdScXTwT@vger.kernel.org
X-Gm-Message-State: AOJu0YzESqK9yMmLfi9J4rkbuLuIn+vd4lqU2P89LPpj2+9Sd4jwcA0i
	M87vUBeAdirSTGdln560ZY9FIYhjUzJff3/0/8ck3l3z/fa2tBJXjQh+Y7xQhJpNY6sbne+4GRr
	nW/6zhncgqyM9c0Ssl0mKWhSPCgFtZl6SD6XaOXH3e6bDWLmZhXxl/AO4F/A=
X-Gm-Gg: ASbGncvw2TCbju1Iu+nMHiIMxCbZR4hXc7+YFLGczgtLkID4S24f+Q1NhQ6IRYMZVfP
	pUFCI/avjKajTwybtIogy4rjyDNvYA4Vlxz+tOt2MyucpwWDCNdmbxS8gYj8SNlalagS67+kvv7
	mK2YqVAZqslB00UpRv/FfdQP7EM5i5myVWcKdDJ4iDfNTXVlSj4Yp7XUDpsq476h6ELsE2CRE0
X-Google-Smtp-Source: AGHT+IH6E1jG9JLDjBZZmhdc/45MmKqz18EwdEKd4VF9DZBuSWr0GaHH49x8aUlXQq3w7/7+sKVGuJ1iLIXPtLMrJbE=
X-Received: by 2002:a05:6e02:219d:b0:3dc:7edc:5f42 with SMTP id
 e9e14a558f8ab-3de08d956c0mr11656235ab.12.1750192611439; Tue, 17 Jun 2025
 13:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
 <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
 <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com>
 <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu> <CAP-5=fXHgzhp6=xrVi1GK6gO_dtVAAStK__eKKoaAvvge4oNow@mail.gmail.com>
 <CAP-5=fWYfMe8y-xcZkkEnppA11+H0r33Xnn0Mn2d4_y3dortmQ@mail.gmail.com> <20250617181738.GD1613376@noisy.programming.kicks-ass.net>
In-Reply-To: <20250617181738.GD1613376@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Jun 2025 13:36:40 -0700
X-Gm-Features: AX0GCFvDO7wxJeKZsHvlltwan5R8wdpQerx8KgVJiHs7QquUXd56RTifnncwJlw
Message-ID: <CAP-5=fUbEuwHKOAJhvgHbbfg_f=KcED=9a94ra++cPbNLJP5BQ@mail.gmail.com>
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 11:17=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Jun 17, 2025 at 09:37:39AM -0700, Ian Rogers wrote:
>
> > To answer my own question, the sequence number will vary after the
> > counter is read and so the read loop will be retried with a different
> > index value loaded on the next loop. Perhaps this is the right fix for
> > hybrid, if you have a hybrid system a per-thread event with
> > cap_user_rdpmc and the thread is rescheduled (say p-core to e-core),
> > then the sequence number needs changing in the user page mmap. This
> > will trigger a second loop where when the index is loaded it will be 0
> > for disabled.
>
> It does; migrating the counter will change the sequence number. But this
> is not sufficient, because meanwhile you will have executed the RDPMC --
> which comes before double-checking the sequence number.
>
> Issuing the RDPMC on a wrong index will cause fail.
>
> RSEQ is more strict, it will abort and redirect the instruction stream
> on preemption/migration and ensure the RDPMC instruction will not be
> issued.

Thanks Peter, out of curiosity, how does the RDPMC fail? If an event
were rescheduled (even with RSEQ assuming the CPU the thread is
running on doesn't change) could the RDPMC with the incorrect index
also fail?

Thanks,
Ian
