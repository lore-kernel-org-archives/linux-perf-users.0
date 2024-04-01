Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D0482CA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Apr 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990710; cv=none; b=MOP60uq5jRXSQOoox4nKMOQzDu87u28c6q3KAuIlRR0PdWrAdb3JQUB/Exd8wu3Xi1dqzcDqeXEtkCq9+qqCChB/ZnLNcCdqjTSGGqZEhy0zO1Swyz4Eb59ycOcw9/hUjv968zultMZSFYfaVZ2NZV0l2nLi5/GxXxwhXhVxmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990710; c=relaxed/simple;
	bh=XAN85uBzU9p+rsXfD7l6Q54QkoJwqztmx2MlbrDPJ/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TWyMHO9cpiH40GqGiL8f68a+KgqZyXy93rsk8ienwXJtJET0513NiB5/C5p5U/eksX+UZl8ObXBPHMpnP/yMBCaCtTzqVbd/OJwimJJcE2NhDLH6ki5uL7XMn93J2vIedJ5CuVsRDr3AUiNz0g6VoPffNDSsOIMZwmy2tPe4GN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=15fwyAki; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="15fwyAki"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-368c8845dd0so393585ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Apr 2024 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711990707; x=1712595507; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAN85uBzU9p+rsXfD7l6Q54QkoJwqztmx2MlbrDPJ/I=;
        b=15fwyAkioZiDBWHdxKsjwIz2GgkuMoHMGXV8LZU0TGioF+NwpECVQRquJJN2q6igaf
         Xj9lFCUUQaniAcAMBcmLzCxtUe+668BdT61GN/7Taj6mYDuNjLk7PJh2ncifZC0SyOmL
         BqADYUhRC1PUqhhp5FORjxAdhKyUtJ6rxHHzwokw84JTqgJ3uTLHys52J1tmCSClTYc1
         g8iJrMFooXNGj7Sq57Qn5TMbHV0Dna2TL46ixGP/ygWyvBlIkEwZcx7lI1j5jIc2qVJR
         EpIvc06U7Pgqo/y/93IOOKVps7bPQ6c5IeXD/Fk7r8SoHwTGTxeF06tmIUe/AiDrdj6j
         cVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990707; x=1712595507;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAN85uBzU9p+rsXfD7l6Q54QkoJwqztmx2MlbrDPJ/I=;
        b=IrUhnRtleqjtO2g2rGgq6nJs+TWvEMEzMReGd6kSHAbQWq37lcZvk6tn1M4Z4r7Skg
         2ZQ0JJmhqRtLmsLy2hxd1yimKZFxLgTo+u2EMJukcMVyCwSNqWAkIt9yaAtfDC8olGrm
         Lf/9k9jPvRUxk5Y6Q6XMT2Kcvmj2hy00y76OCCAvmP96yGHsQmczmVNWfuCHQOUmUe0c
         tGybrILyFID9mCdUSnMLk9oUyMMYjplXQGtnhzi3Vh/EQ6ZX/w2xS7P7+hxBzleuHcxs
         jTuV5nEtB5gYBLfKkEVXEYJg34ca7xWz09KdiYlsXPtdImiwMwLrx2wJ5GCpNerbn8IF
         W/EA==
X-Gm-Message-State: AOJu0YzriqeDDRjfxE/cnEPpM2L73gkvZ5AUqfIiyzlzcESQBitWNsqK
	6fjQ/NuNq3VfqK37gMRMx+bbgTFxWMUyNRwu/Um7GZVvfnRcWHzk/UKyuoEbzjEmXXOryzNQyaZ
	6TwWflmWgPgtOdbkftOZxGDi3bKdfbiTeF4yDTtTixKa0qiHec5cjMA8=
X-Google-Smtp-Source: AGHT+IHSukaILyuZBu/msa7PF/uczk9sRJxTGJffQS7siRtKcUX8xRYAy1EdbAh/sx/vRv89/rW/2b76Ixg5VcOheKo=
X-Received: by 2002:a92:c267:0:b0:368:9314:6783 with SMTP id
 h7-20020a92c267000000b0036893146783mr925595ild.4.1711990707356; Mon, 01 Apr
 2024 09:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWALQGhqNqh+hsEDZ9p1O3uS=0T4_hqx-fz_VNQF96Zzg@mail.gmail.com>
 <CAP-5=fVK2UV0s3hfo=G+TpsW7cW4WXndo+-OHVuCOYe0WWduhQ@mail.gmail.com> <CAP-5=fVoU5Fq9=Dq8C39sLenr0kn5n1sNPKt4Cym30EUzcTc8Q@mail.gmail.com>
In-Reply-To: <CAP-5=fVoU5Fq9=Dq8C39sLenr0kn5n1sNPKt4Cym30EUzcTc8Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 1 Apr 2024 09:58:16 -0700
Message-ID: <CAP-5=fVXd+L1oTHEi+kM6z+=iuDUm9v+B3JvuGZddzofiyXw2w@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2024
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 9:52=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Mar 19, 2024 at 8:28=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Hi,
> >
> > A reminder/heads-up that the application period has now started and
> > will end on April 2nd [1]. Thanks for all the interest we've had, it
> > has exceeded everything we've had in the past! I'm really hoping all
> > the interest becomes applications and all of those become projects.
> > I'm excited for all the improvements that can come from the work.
>
> A reminder that the application deadline is now less than a week away.

A reminder that the deadline is tomorrow at 1800 UTC:
https://developers.google.com/open-source/gsoc/timeline#april_2_-_1800_utc

Thanks,
Ian

> Thanks,
> Ian
>
> >
> > [1] https://developers.google.com/open-source/gsoc/timeline
> >
> > On Wed, Feb 21, 2024 at 7:07=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Hi,
> > >
> > > I'm happy to say that the Linux Foundation has once again been
> > > successfully chosen as an organization for Google Summer-of-Code
> > > (GSoC) 2024. This means we're looking for contributors to do work and
> > > get paid as part of the Google Summer-of-Code program!
> > >
> > > A full timeline is here:
> > > https://developers.google.com/open-source/gsoc/timeline
> > > We're in the part, "Potential GSoC contributors discuss application
> > > ideas with mentoring organizations".
> > >
> > > Project ideas and more information here:
> > > https://wiki.linuxfoundation.org/gsoc/2024-gsoc-perf
> > >
> > > Please help spread the word, volunteer to help out. etc.
> > >
> > > Thanks,
> > > Ian
