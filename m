Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C8251790;
	Wed, 26 Mar 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013355; cv=none; b=uTQ5gZpY6DfKiyJQbhvwW16l8ylE4LW9V0Wji6D4By3YykZmEjV8JDjxdFUnyLLgY7ZI7yaoGbY9jdWGlWm9n7cbN5fsBz/6rEfyPkZj7kNGNIE6i7fr9f6GkPi9jONPVNqkQ76lbHdMzlHRJWD9+FSbzHFHNelQpPwfzrc7Vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013355; c=relaxed/simple;
	bh=KZtT5LRAw5rpKbF4crJUt08eImhcbbKcHJdsfaQmyhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUnmcX8kfTVRVorHAjeLKBEnqyurwKbfjA2+juRX0ltApivwCWgAtHxjDnt98JO9bUIRsRGtIkSxLsNon8Y1gbj9Lz+CYiz9kwS5nI4DDZbsEYxnN71BRX2RsqDm4Kx2LQ65+veMHn5tZ/sU8F6l4xx8QIrxLBF+mGmtfRV6wzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbkFmqlz; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbkFmqlz"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e589c258663so197026276.1;
        Wed, 26 Mar 2025 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743013353; x=1743618153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUlliuzKe24ABM+zYuZbagEPiXi19b5EkOBKxUSW2YE=;
        b=KbkFmqlzjAC+VYp5WVVtwjVGzmdf2kDSiFkQmP37OObf00UdBEUPzKT20pzLMe6hFY
         5ELysLHZC5gGg9b4w/hX0HNawRYJL+v3F0XsU3Y1fntMcL1sCmUzkTkRq2Tqiar7+kQ9
         M8eYCQyClbzPCQjWfuUGAg9tXKNQtFmorNBGFqOtK0mnhEbn5sYVrYGbZFs4atWqXLUu
         6w3Ntc4veUNBn53eoexUIh6OZTewAjGt9+JQr1q1JOa9YOE7BAdFCMwaR271OK9o06sn
         uEr6Tz4opBb7wsONGYf37TuDAPY5STLm29UK6xnQ4wUKXWRKHLptr8LBXffGlrSqJYFp
         9+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743013353; x=1743618153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUlliuzKe24ABM+zYuZbagEPiXi19b5EkOBKxUSW2YE=;
        b=k66tn5dboOg15/ge9kHDb+PfOc+o7IodmeErnux2da3Byke9IU5uV8HjWa/8KUje1/
         GYnrTVtBlzjq+pmujXFYBstzllhaEVkbPqf0elzE27qN+LtMGvb7/qFoscXPlRWbLo2F
         tdm0mBsiYelKldZg7pf2tWpm9KA6kZ+vyd4i2gmQogjNTcP8gXLNqUA51FyWX9tlgpIT
         xVGnqvI0kAO4kazFRJUPO6/wmFC8lgX6FlLKpWUNInRTuSpDCJXbGUjUZ5kg8JGvdgqP
         pjn8AGP4cGRM7dsofyK6+qZhxVN2n84F0WGLtvWcDFLip8Uw8RkjtGPPON9Fxuv53zsY
         oJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzA1mINTV6OLbjCDBXUvEIyHFT6FH4zpu1YWhwzBJW1/FhXv1hv0Ve3zs6vGoddXG1j507nRM1mGZBbHk=@vger.kernel.org, AJvYcCXa5NHCc2OvIsZayQ3AQQCeFc867Yi+3r17kTrFeo4oh5UzD9mH1Itf3WqCtsA9/J7ux2HV2sf8Qj+9TRYBPQNI/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRr/Xh3VV9rjA3J7fW6hJMGOt/ekcVsOKDPbR5A5PzG5hByWm
	Vuypve/9XJsHLqiRWqWC2Nwco6PtEiy15aZSdmqL0an+WOd0fngfDQ8FNcITz7zEds4yKQyhQ29
	mnLJKso9lcgWoD/F3umh/x+O9IqjoMy/08Ns=
X-Gm-Gg: ASbGncuzuT4rROzbF7ehUvsV/Bx2WfjtTVEs9MQGUS5nVD5P5VFFg+PNcu3QytuBF17
	U6jYKUs8oA0p2ghos6AWDUBXSo7PlZ72V532tiT+W7JObzadCaharaVnfKO44hdNoBOGTCrv6m+
	wCw+hD42LX+wtTcR3WPt+WScJP
X-Google-Smtp-Source: AGHT+IGPYYMuvK5C7/xVgSnuNXK23FQILjnYloV1i3xR1JNstY300wsAj0214yXKKp+tDUoKdbW+pQWL9R5Tn0L7DAk=
X-Received: by 2002:a05:6902:1183:b0:e65:c4be:6faf with SMTP id
 3f1490d57ef6-e694358e57dmr990053276.21.1743013352979; Wed, 26 Mar 2025
 11:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326160416.1725322-1-howardchu95@gmail.com> <Z-REG5kkE1RahBW2@google.com>
In-Reply-To: <Z-REG5kkE1RahBW2@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Mar 2025 11:22:22 -0700
X-Gm-Features: AQ5f1JohIGRHpnehwKfT5JlO1KShBVjVlK6jtXAp0OENm6OJE-DVbmm1SAJfeAo
Message-ID: <CAH0uvojANF=3y252epqFaxB5FXQ36-UrBnJ63bY6Wwr6BAxCZA@mail.gmail.com>
Subject: Re: [PATCH v1] perf doc: Improve perf trace's doc on --force-btf option
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Wed, Mar 26, 2025 at 11:14=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Wed, Mar 26, 2025 at 09:04:16AM -0700, Howard Chu wrote:
> > As mentioned by Arnaldo in a past discussion (Link:
> > https://lore.kernel.org/linux-perf-users/Z2m0pWiQgZNXhvxK@x1/), the
> > current documentation on --force-btf is vague and inaccurate, this patc=
h
> > aims to provide a clearer explanation of the option.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-trace.txt | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Docum=
entation/perf-trace.txt
> > index 887dc37773d0..cf2445d2ba3d 100644
> > --- a/tools/perf/Documentation/perf-trace.txt
> > +++ b/tools/perf/Documentation/perf-trace.txt
> > @@ -246,10 +246,10 @@ the thread executes on the designated CPUs. Defau=
lt is to monitor all CPUs.
> >       arguments to strings (pid to comm, syscall id to syscall name, et=
c).
> >
> >  --force-btf::
> > -     Use btf_dump to pretty print syscall argument data, instead of us=
ing hand-crafted pretty
> > -     printers. This option is intended for testing BTF integration in =
perf trace. btf_dump-based
> > -     pretty-printing serves as a fallback to hand-crafted pretty print=
ers, as the latter can
> > -     better pretty-print integer flags and struct pointers.
> > +     Use libbpf's btf_dump to pretty print syscall arguments, utilizin=
g only the debug
> > +     information from BTF. This option is intended for testing BTF int=
egration in perf
> > +     trace. Using libbpf is a fallback to perf trace's own prettifiers=
 generated from the
> > +     kernel source, as the latter can better pretty-print integer flag=
s and struct members.
>
> "the latter" means our own prettifier, right?  Then why do we need the
> fallback as it's better and always works?

Honestly, for debugging=E2=80=94if BTF exists, it always works, yes. I don'=
t
know if libbpf is 'better' because our prettifiers are prettier :),
yet there are so few of them.

Thanks,
Howard

>
> Thanks,
> Namhyung
>
> >
> >  PAGEFAULTS
> >  ----------
> > --
> > 2.45.2
> >
