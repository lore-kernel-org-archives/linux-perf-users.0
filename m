Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4928BA9F
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457315; cv=none; b=D5G1bp9E6dWs6dIzfrB+3Q7T3QB9+Voaz8elg988hMw1qD1aqtq8oqDxZPYtF859XoyP8VWsjHi3EI6Ev80wFOugTIRNJm2JPm6Oz+pu/aIbY/+dQAjypDFOMseC/Je0y+p7H5rZoBa/fQajpavNfwrNpJ6ENQH/fv02Xzza4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457315; c=relaxed/simple;
	bh=Jz7Nai9JFiOirN09TRvaGuuwtMD049NqJp7EUjquMVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6nXT6fHrH1r/nYccaIUig2h+XEBypa1SkvZVyueq/tGc7B9zt75xFpmRaUdbxGTy23wd0qdIDRJjrWpiSM6t+SP69B0z28/hDE8yYHIB83JDZtto+3eXZNQ4v9hMoEHBk5SBJSZxcX4b/0FGS4udLAPwjoA5UIhMSn/vi9gvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWRioj7l; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWRioj7l"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3dd89a85414so33125ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748457313; x=1749062113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cVLMwY4AxanVU8F/mVt2OHuXPMKbrtS0JnadrXFkYs=;
        b=YWRioj7lDUZBh61XThc8rxbgIqVywLZ6oNeTGKZXZOEV6A9X4reI8bzBkwwcL6ZeQC
         dtU+60ycwHyWiWOsjvR+An02+17mZo5xYYRLarL7B8IGYd+cr1L6weLcph+WMwyauR7M
         ELkR1NU1xg4Rtt7fddCDVcjRFjpdurarcfNXvdCxQchYCbEbgirskQwIUldoRmKEzgwT
         nP1WL0w67LH+ftBGRYcIMCBS9kMW5SX+Ml7YFZra99DeKCgOCopcrO7EkiNhThFFW6s8
         oKvcrLv7HlepCVzOUtmMuitaIynv948HhfBYMdFFF9MQqZE4jN9fU1fdyyZ43U8JtX/q
         QSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748457313; x=1749062113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cVLMwY4AxanVU8F/mVt2OHuXPMKbrtS0JnadrXFkYs=;
        b=UCnRccm2D+QVOxaqAIWpTHNlO/wDdS5HPHchRsLR69XPlqI52mVqlvkmqokqRAB8HX
         aYbf+fyEDa2yA+pUev9YbJotTTJ3AfdF0UexUU/fTVPJ4TqjftCzrOxXwJ19cuDLYjZN
         uuIHmBZM7D7A2TDPZ4YaCcG5dI/ij4Wj1iQn12npuvUnf26otIbBkvKAGorGchAdT2Fz
         47lfLRnugFpcz4HF/FNhffPrTOLFyxyo2zuGh6rM5Us3BJ9ZcdR2nyIKdC6fcdk6crqG
         e1TzSfZTdiN/kJDNONfmR7czxgt/tmy0X+qcv9xLBHBnVza/BMGtl3APcqsP5NbxhrjC
         uWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUastoSASXXIWvr6dkFlIeZsgCzbkatmFfUnau6wZ/mq7l7ZKr3dT0KuSH9Zdl10Hk0NGJsQ7oN7KCwvcKOAwtZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+LQOs0Vq7o3ExRwBB1ujuPxfecYDphNzaxOuE9bq41f8Ng45
	L7Wupc+OTfwiMMkw3zddEFyU4N24+cIP6bMh243D88euwSxMrdkEtmflk6KQAi0HqdZxgM5ENeb
	pfheJdcCDWMqXazd4q8LyLPnLQ4qEL7Gii7pgBdEi
X-Gm-Gg: ASbGncuKPqoOCdn/3Mn8APWuQWsx1ZfM7FolAfw4JVarcJdW+4HKIdMIeCphX4Tkj0x
	HaniOU+8TaaKpeazpHfZSgW6DJCcPvCL883opEQATpnns5tyF3efeNdcqoZhXGUTlMsl4zCfirE
	IGBgMY+YIAQEx4w4tkq84l3zXI+foNJhIJDREMdGOUK1x3vWWWPGVe0WMf51mw3aMCXsZEcoSv
X-Google-Smtp-Source: AGHT+IGYXX0WDoz2XCkffg330kupFU0jreTbKLaIcJ3R/pK8nBp48fujSFr5wR2xC39RxHnZaH4b1vXmghZ5HEoyCok=
X-Received: by 2002:a05:6e02:1a08:b0:3dc:830e:1ce6 with SMTP id
 e9e14a558f8ab-3dd920f5e16mr384695ab.22.1748457312709; Wed, 28 May 2025
 11:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410202647.1899125-1-irogers@google.com> <Z_mK9BVv16MT7shL@z2>
 <CAP-5=fWykL-01S=35zz-6JASbM_cQkx6PHdKS7pJAX0=JBTuNQ@mail.gmail.com>
 <CAP-5=fWFYS7-FcbyJ5Z5U2rqA7eYwwJ4dMf90TUzwJ0Shh2yxA@mail.gmail.com> <aDdU1npHL2Vczhsa@google.com>
In-Reply-To: <aDdU1npHL2Vczhsa@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 May 2025 11:35:00 -0700
X-Gm-Features: AX0GCFuOWPXoPpHqCzIaOBkJlXVpLQKsGRF_N94G7uJ_0dqi9rbnNFLaxAn8bjI
Message-ID: <CAP-5=fUycjUUWW=hoSSvxfUVPXcqAk5KHnknFuUDOr7+Zf=M2A@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf build: Fix build for clang's -Wunreachable-code
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:24=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, May 27, 2025 at 01:53:37PM -0700, Ian Rogers wrote:
> > On Fri, Apr 11, 2025 at 3:14=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Fri, Apr 11, 2025 at 2:34=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Thu, Apr 10, 2025 at 01:26:47PM -0700, Ian Rogers wrote:
> > > > > Clang's unreachable code warning is able to catch bugs like the f=
amous
> > > > > "goto fail" which gcc's unreachable code warning fails to warn ab=
out
> > > > > (it will complain about misleading indent). The changes here are
> > > > > sufficient to get perf building with clang with -Wunreachable cod=
e,
> > > > > but they don't really fix any bugs. Posting as an RFC to see if a=
nyone
> > > > > things this is worth pursuing.
> > > >
> > > > I'm not sure if it's useful and don't see what kind of bugs it can
> > > > address.  The proposed changes don't look like an improvement.
> > >
> > > The goto fail case was in OpenSSL the code from a bad merge:
> > > ```
> > > if (...)
> > >   goto fail;
> > >   goto fail;
> > > ```
> > > Meaning the fail path was always taken and checking on the non-fail
> > > code never executed. Newer GCCs will warn of this because of the
> > > "misleading indent" but  clang won't. It is easy to imagine similar
> > > mistakes creeping in, so using compiler warnings to avoid the bug
> > > could be useful.
>
> It doesn't look very convincing to me but it might be valuable in some
> rare cases.  But the proposed changes - basically replace exit() to
> __builtin_unreachable() - seem weird.  Why is calling it a problem?  I
> guess it already has some kind of annotation like "noreturn"?

Yep. The exit is incorrect (depending on your notion of correct, I'd
go with clang's notion as they've had to consider this for a while) as
it can never be executed. I've added the __builtin_unreachable() to
document that you can never get to that statement, as otherwise it can
make the code readability harder with the code looking like it will
fall through after calling something like usage_with_options (which is
noreturn). In unoptimized builds __builtin_unreachable() will fail if
executed, so it is a bit more active than just a comment.

Thanks,
Ian

> Thanks,
> Namhyung
>
