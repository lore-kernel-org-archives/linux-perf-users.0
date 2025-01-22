Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DD1BEF7A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737573559; cv=none; b=YcNVnorXM4F9P+eisuXhIRa/XleHs0JDmDQjptVC5voRh25Q59Po2zf8k2KPR/8eJJjk4/NyMEzZNUxD9chDv+cthzlTBQd1od1Nd/NTfbJmrTfwN0CrhmnlXAzIruv3yKH1uLHrCMYJ8+OZJVVxPR+nZhCY7y2QrleMrx3M82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737573559; c=relaxed/simple;
	bh=x0eTSZi7z2hjUND4ZddEt7IF9f0Am2IlZc3XsMsz3s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZO/JKnj1woHXpRbaVXVGlo9GOqkKUL5gh0SKLjqe2kkj1I6F531aZKT8y7gi3tkom11irhD+RU8bb/L9+Xiisu3R/j4bAvi9liyrtvXVbZXYMZOARsjyLelra3UR0Z1FoDZgetJOoEdBe7/R63OJYt+ybwB3PK3r7b59epoVRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=VTwTDKl5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="VTwTDKl5"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa68b513abcso32484066b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 11:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1737573556; x=1738178356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok6ig2JkzmoNT6uEAUbsPTwAKatgOz88CLQrqYCVK30=;
        b=VTwTDKl5OzKEPKuqz3e1mhUiCEm+zR+2kTnAsnVB4Nyzlg0KApVGhwyWM08MJMEWC1
         z6qB2VqMiz1+7FnkFyinmQ0/b+V27qp7yW8npU9mPphCTMsrk7DQZA3N7vERIgLHRQ20
         sW4bqKG4q2Awq2u43i5gYSkb70b3iiKxQWOrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737573556; x=1738178356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok6ig2JkzmoNT6uEAUbsPTwAKatgOz88CLQrqYCVK30=;
        b=tmE96UlVtL5wVTnGFi9MafcBNRqcEUX5Me4B4oDPdswv/e0Ha6oBZkpjc5L8ZyhUjr
         IAz3OJvf2R4p1a3+O0dHJYhoEDm0zhHqgIQLdQMnDBoLXvsFUp4IauNvznHD6xb8etTA
         q+d5eZFxC1AO+0Kisb5AIK9i2cOIHye1MyPW+ECPeIDLs7QgMVIMn262IiUuyUISorOH
         b5wyO90m5dp1ZfsF8HYhn3loFhD0Zd4Mgo8VQp/RVWHY31SGWi2SjohE/4mBUDrq9rr6
         wRal19yb5PdI4z20zlPg7XTmgLSOwbjlAOs30ZXzq9ZWiGR4K1okKAndRoB6AXSneoxT
         XN5A==
X-Forwarded-Encrypted: i=1; AJvYcCVdU3C1prR8kTWQ6w2sRiyS/IFCIw2Sx3I60dNnxnl8LjorjRXYpJULqWUnk5/X8oTwKuFOsYydaE/tzxzIpfil@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZ7P1CNVpN631HnXhlaLDcB2B4uoL6P6BoM4369xcdcDl7rEV
	rq16GcVh9jpRGNRsAD+WW1P7+15fWSsTH0cIIKnmTG0DMzSeQoq0NiRJVlBmuoeJ/o7zfXw6rX7
	WsDijUVad3dbK8Hbv+3CWR3NUDIfH0lkb5n7VOg==
X-Gm-Gg: ASbGnctK9kWffMZmVBqxkbBAMCqAL/ZN8v28d26b23Wv4hl9iucZwPpR34IJqIUfZBX
	CRnPqrmJef4xd3aOwmlAcJlgMB64ca1NIei/ylhy51qGLjHOoH1c=
X-Google-Smtp-Source: AGHT+IGG6XSfGeJ6XUXIQzhkPWqZ4gLn8LJIaKwhTqhYv+y4r7P7cwvlzQ5balaokCLhcr7GCaTcFwQr4QMl0BCozUI=
X-Received: by 2002:a17:907:785:b0:aa6:5e35:d72d with SMTP id
 a640c23a62f3a-ab38b11346bmr2184878266b.24.1737573556264; Wed, 22 Jan 2025
 11:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-void-fprintf_tp_fields-v1-1-b0c23fff4c54@engflow.com>
 <CAH0uvoi6=JmtX2xit9y7+NR5O+1S5zbxWpmLpbzC9+9nrkudHQ@mail.gmail.com>
 <CAH0uvohQvqRYo8JBX_Z1yVobqcxRgQG4G1Y8o8XMv18CnrqBbA@mail.gmail.com> <Z5FCGGBxBHD95zjT@google.com>
In-Reply-To: <Z5FCGGBxBHD95zjT@google.com>
From: Benjamin Peterson <benjamin@engflow.com>
Date: Wed, 22 Jan 2025 11:19:05 -0800
X-Gm-Features: AbW1kvZ3NCatN6KDlZNgXZl9qzIZ1j-KWFbjzE1MjwUlCefLljSVVI50G7L8kQw
Message-ID: <CAEmfU+tj6kUbRNe7YbCorRStyAKs=7ndj73BvPUpkwA-gcBZCg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Remove return value of trace__fprintf_tp_fields
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 11:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Tue, Jan 21, 2025 at 07:01:53PM -0800, Howard Chu wrote:
> > Hello fellow maintainers,
> >
> > Just a slight ping.
>
> Thanks for the reminder.

Thanks for taking a look.

>
> >
> > Thanks,
> > Howard
> >
> > On Fri, Dec 13, 2024 at 10:06=E2=80=AFAM Howard Chu <howardchu95@gmail.=
com> wrote:
> > >
> > > Hello Benjamin,
> > >
> > > On Thu, Dec 12, 2024 at 7:56=E2=80=AFPM Benjamin Peterson <benjamin@e=
ngflow.com> wrote:
> > > >
> > > > The return value of this function was meaningless and therefore ign=
ored by
> > > > the caller. Remove it.
>
> In fact, I don't see the reason to merge this, as it's the convention to
> return the number of characters it prints.  Yes, it's not used but not
> much reason to remove it.

The main reason to remove the return value is that it has no useful
interpretation and is therefore confusing. To wit, the function
returns two times the number of bytes it prints.
