Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E63224
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740258; cv=none; b=rX6OglNScGQPkuFJrJjbmGYLNzHu5SoTz+/IOzuEdsnsHkNTcU3Dk3dxmt9aYrvOd/t2rWaISXr3tWDrtoUzg8JUsgDQpUixNie6nT+2yBA/nafDz20HLYewWpSfvvWhvabOIJZO97s1A6m2OeRsPDKb3GW25JuS5JGrK2/qCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740258; c=relaxed/simple;
	bh=+ETipK4Yn4e4X+IMrqY1Tb4nsunXRn8bqircTpzzLX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uezNabhWlSbUjQ2NbHs7ywO2MvToMDEB/9tbEEYskeK0MBdfQysBJmuFhmh551OBf6BnIssx+lcVc0+RWHRxKvtYMsvLjLPtRJQRtn2xttKNzNnK/dt4cjluVkkhvEl7UHpyd2EhJUDGztVB3ads0tl7wQAf5tNcLQPUYmHflMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=t1f7hL/z; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="t1f7hL/z"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aab925654d9so433962966b.2
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 09:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1737740255; x=1738345055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOpeoVPFhrjIWOnt5MtGjoBcb1UkXl4bKR69lU6FYT0=;
        b=t1f7hL/zSs+f23ULf1jP7Gw94IQekZ4lU3ZMOowIpPxG7bmsFvGyCRQ1IWUf3uLiur
         bxqjLsjtvKRrC/O3/0j1hwmfWl784KPMBUkSKFG2+qluJ3xIphcDfHIi7g/HaQxQ46zg
         PTXbHitYRDkKEHR5uSdRxzZ402yjnlGLXWmDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740255; x=1738345055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOpeoVPFhrjIWOnt5MtGjoBcb1UkXl4bKR69lU6FYT0=;
        b=hABy9DlaHlonBdmxpZ973XxXsmSw+82rybblRp3xIH92w+4/kKRhVlV2Dg+ck6xxXg
         jkSofL9VnNwr3MpZ5GOVB8pk6YIyFhyBIYP9DAyvKl2ao/mKIXwEhcqiYUWc3KGS/cXG
         ca7/G/xTxJKq10aJbUakwImqB5q3Hdb6SBsQ5rJA2/P45IR7hgc9ah+yp9zxD3TDYiJY
         UF6eQdC6tKf99OlndNa9B4ZewAl69QmHfrBnRE3WS07JWqfKO5eNnCr3FEWFdSMfIe6Z
         R+dk/+QCzjONh75CjJI/me5B1NGgEW332fglJfyTK+yM9SHA2fjD+gnKJ+tDp7CBqcb6
         DoBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfUzVIxNCUEIg05szMYeyQsMYB0lFAoZ9CwRn1eOZMKZTYlHZ9Rtpf5wc32vXZy2SOT8GxtgMHLoBeYLOMrsWg@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnT1HSkFQeO+ARdHFnKFYXjh4GGsOZ7gJ2cUbw4ZBYAFvL4ap
	x5gZhBTQIT+SrqS0+9a1+xQaW2PKEI8okRzFuiTCpT3N5FyqchTWRhSzQjKLxkxWhMPRKHEUxC4
	w6zGUoJd4u1gSnaEpouKGu5YLLwhTxSlykv4b+A==
X-Gm-Gg: ASbGncunGdXFNzOaRREiqrToda4pW+V86eFMQXP5mboCRADJRK9pbw7y1EomnbfsYLJ
	FSncWdXDqwcHeF/Z7hCB3Hswf4KFPY3Dkq/yRMdlCozrq1Ggjf82anKygt2Xp4A==
X-Google-Smtp-Source: AGHT+IEdUiSyA2/rFGKMXBBw1OFDtgQdjoWRowNbEu3hMN1ERkPs5FDTOPMVI2+Qa+EoeDrAJdKZexKj3y5HMYhGt5E=
X-Received: by 2002:a17:907:940b:b0:aac:619:7ed8 with SMTP id
 a640c23a62f3a-ab38b1e651bmr2670705466b.7.1737740254746; Fri, 24 Jan 2025
 09:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-void-fprintf_tp_fields-v1-1-b0c23fff4c54@engflow.com>
 <CAH0uvoi6=JmtX2xit9y7+NR5O+1S5zbxWpmLpbzC9+9nrkudHQ@mail.gmail.com>
 <CAH0uvohQvqRYo8JBX_Z1yVobqcxRgQG4G1Y8o8XMv18CnrqBbA@mail.gmail.com>
 <Z5FCGGBxBHD95zjT@google.com> <CAEmfU+tj6kUbRNe7YbCorRStyAKs=7ndj73BvPUpkwA-gcBZCg@mail.gmail.com>
 <Z5LVYtjPZduzcoE-@google.com>
In-Reply-To: <Z5LVYtjPZduzcoE-@google.com>
From: Benjamin Peterson <benjamin@engflow.com>
Date: Fri, 24 Jan 2025 09:37:23 -0800
X-Gm-Features: AWEUYZmv_hR7K1hslpCXWOcQGeGrCFyy-XxeFBKEmix791P9e7T73M-fGcR0VmU
Message-ID: <CAEmfU+sWQ8YcfU4He6j2T_DGN7nafJgtO7ntQ=2KdDphttrsbQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Remove return value of trace__fprintf_tp_fields
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 3:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 22, 2025 at 11:19:05AM -0800, Benjamin Peterson wrote:
> > On Wed, Jan 22, 2025 at 11:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > Hello,
> > >
> > > On Tue, Jan 21, 2025 at 07:01:53PM -0800, Howard Chu wrote:
> > > > Hello fellow maintainers,
> > > >
> > > > Just a slight ping.
> > >
> > > Thanks for the reminder.
> >
> > Thanks for taking a look.
> >
> > >
> > > >
> > > > Thanks,
> > > > Howard
> > > >
> > > > On Fri, Dec 13, 2024 at 10:06=E2=80=AFAM Howard Chu <howardchu95@gm=
ail.com> wrote:
> > > > >
> > > > > Hello Benjamin,
> > > > >
> > > > > On Thu, Dec 12, 2024 at 7:56=E2=80=AFPM Benjamin Peterson <benjam=
in@engflow.com> wrote:
> > > > > >
> > > > > > The return value of this function was meaningless and therefore=
 ignored by
> > > > > > the caller. Remove it.
> > >
> > > In fact, I don't see the reason to merge this, as it's the convention=
 to
> > > return the number of characters it prints.  Yes, it's not used but no=
t
> > > much reason to remove it.
> >
> > The main reason to remove the return value is that it has no useful
> > interpretation and is therefore confusing. To wit, the function
> > returns two times the number of bytes it prints.
>
> Oh, ok.  Then please just fix it to return the correct number.

Alright, I've submitted v2 that simply propagates the return value of fprin=
tf.
