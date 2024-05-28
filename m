Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE1178389
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926607; cv=none; b=nHkoL0rnVem/0Zp0fE/SRcHEJ1bPTvBo/+SFZ7NIZxRtfyElYJgSyX2RQhYoerIOs/+xwVcO6LkuiErC4xbIU16kgSS+IZD6pIywpgwWT2n72NEHObD/twv7nCDpkSOK7gq61e+frBZN46lYaLbrKnnyUAzDMnvR8ZMd7cG2Lv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926607; c=relaxed/simple;
	bh=s9G0X2bLnZX2HF1sepAYNajMW296p4Wn4BHLPj+pKwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYWbt1HRZ377lgYHTnoOo1YUF6wS3w4vdH+3cNDVjMHGQBRElznIo3cs3xrEtDtpJOE6PQ/msxeE8Op8NUYWeprERtAGtVNEpOGZp2h69zvRY+IxOHoZzTQ5KdddCKlUwyN+1ioIr2TpKRlb8H0Jj596tVJnnv8QP9uKIBIz6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiSaEb4t; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiSaEb4t"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43e14f0bd75so12251cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716926604; x=1717531404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtVVbl9WsyTR4oADIzXjjbNJialS1FI7rnlVmASQ+MY=;
        b=WiSaEb4tfSCgTPpOm8d0OFWtBm/YjbaEETjMHkgMTaKyKKpM52TMy/DQi6swJQTpH5
         YbZPR718fH+edOmXuDMsXK4D13WDlzJzsbybOZzaQFqj8Ky0E3PNnJaH2w2wR7nJlsrt
         UF8QLWihKxmOVWZuj0ykQoF27xDSDolbYbTZAxMZ/JdRfac1dmPN/AWlWl6nCLNOan5u
         XxZYojO5pz1RBPVU9kpjnO9LzKCs+HmESDYDBsQRQcs6XfDD5xrOEKusV9EEb0dvTsjd
         SqP9fdpQoI+RRnqn7mMxnEFVE+AOb6F7R1aTqQWr/cGny5xlTcUo3n+8AmLMNq1S4Yb4
         DicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716926604; x=1717531404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtVVbl9WsyTR4oADIzXjjbNJialS1FI7rnlVmASQ+MY=;
        b=LDL7jc+ehEZ1VQpGwNbRGTdpOSpWwLdCgEWTx0shnnW4g898AX3yQ7Beq686Ns/RNb
         g/XlErn7j3CYTGSfyeJHOoPWjJUhKQ/74AuuPMd7RMdxhwYy/uPiLWRZJOLoECa+LMAZ
         IbWz+TkNeULa/50DLeeGRdEnp0UMYbHefCSyGykvzLnGovSFx5RluT8jKqaNmibXz4DD
         UtXHhn7g5QWsOCTgcDzC6+QhYmJpYeNPsKsk0w2SHQAJZNqgy4L0l1DFlChgEuMdytom
         DOsJ6BgEE9MslHVaf0y01DRz1IhAqJoeJscvM6iBvzCwK/9/auBkFfL/36Io5Vrv9Tgp
         Dj4w==
X-Forwarded-Encrypted: i=1; AJvYcCUPM6uJDU2E9KDwp1eLZLc4pAT5u/aCNG/aiYDsJwM8MxzpFzq3Xf6PVTjtKcal3W9X5v9/YVnhsYSbYhbZEIAItBnsW/xmBy2k3feqiemOCg==
X-Gm-Message-State: AOJu0YzfGS2a/ug/aQOnNT+5ZujIdDAJ1VB3/Sr49RRsZG7/hGBxS09x
	9KGOzMq+X7dbkE5XydLyyANu4X6i9riNLdRD2B7u2Tv/GMuXteIPtC+gzzt+6NEzAw0P9Ui7fje
	NDqeVVuTaWcaDhQa3ofs6Vf9SH8nt4qZo2wY7
X-Google-Smtp-Source: AGHT+IFrx4P+qJ0MdheUBLT+6DpdE+LTBQRRpkk4ZKWOQQ2aixPRlPCXBnll3hfB7PJJzURbz7reixdLlY9Zsxkc2U0=
X-Received: by 2002:a05:622a:5c95:b0:43e:3d52:3e0b with SMTP id
 d75a77b69052e-43fe0f3ee9bmr359531cf.16.1716926604452; Tue, 28 May 2024
 13:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
 <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com>
 <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com>
 <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com> <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com>
In-Reply-To: <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 May 2024 13:03:11 -0700
Message-ID: <CAP-5=fUwcgsB-AruAmGhw6WVNViMaiJ_iHWuZ8=ksrN7Y3V9QQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 12:45=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 28 May 2024 at 11:59, Ian Rogers <irogers@google.com> wrote:
> >
> > But nobody else ever reported the issue, even ARM who maintain the PMU
> > driver whose event name conflicts. This hasn't been a problem for
> > anybody else.
>
> I'm not blaming you for having had a bug.
>
> I'm blaming you for NOT DEALING WITH THE BUG APPROPRIATELY.
>
> Taking some time to fix the bug is fine.
>
> But that's not what you've been doing.

On LKML:

Issue reported:
2024-05-25  1:31 ` Linus Torvalds [this message]..
Fix posted:
2024-05-25 15:32 ` Ian Rogers [this message]

The only thing I've tried to clear up is the ambiguity of when an
event doesn't have a PMU what does it mean? Perf's metrics don't
specify PMUs and have uncore events. We can't restrict non-PMU
specifying events to just core events without rewriting them even if
it best matches your mental model, perf has never worked this way.

> Since then, pretty much ALL you have done is argue about irrelevant
> thingas that weren't about the regression in question.
>
> The fact that you still don't agree, having broken documented
> behavior, and still argue against just having it fixed, I can't do
> anything about.
>
> > So I think the revert is a real regression for a larger user base.
>
> I didn't have much choice, did I? You refuse to even acknowledge the
> bug I hit. I'd have been happy if you had just fixed the bug. You
> didn't.  You just argued.
>
> > There is a testing issue here, not least I don't possess an Apple ARM
> > machine.
>
> This is not an Apple ARM machine. I have one of those too, but this
> isn't it. It's an Ampere Computing system, based on an ARM Neoverse N1
> (and the ARM PMU's both for the core and for the interconnect).
>
> But that is pretty much irrelevant by now.
>
> The issue is that you don't fix bugs you leave behind, forcing the revert=
.

But you've traded a fix for one set of users with a fix for another. I
suspect the number of ARM neoverse N1 users of the PMU are small, not
least as these devices tend to be in the cloud where PMU support is
deliberately limited. As test expectations were for the patch applied,
I think things are further regressed. I'm glad you're happy.

Thanks,
Ian

> I'm happy to test any patches. But I'm done arguing. The "cycles"
> thing needs to work. This is not a "pretty please".
>
> This is a "if you can't understand that and acknowledge that without
> arguing, just work on something else, ok?"
>
>                   Linus
>
