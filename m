Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A01CAB3
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522749; cv=none; b=HkWMr2MZO32REJ1B2nOkwey+ICBFmBe0Mv6FsLJourwEcyCH7weGLIlmxsXWPmUm6KRez/PWuqRJxR0m8v6pR8LMveXt+U68oElQ4LV92+5pIlDKipD/K7dptEw0SAxPzahkwlPv+uOZ6thufpvfJKEJosJnPDOMCBbdDIHk4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522749; c=relaxed/simple;
	bh=3DoVvAkHKzlA55dWX7469yZ7NdqVmb2RDHnFOvW9QuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo1Ab7W30y2I47aDySSpeC83BMOViMA9Y4YH8VDKOvIwUT+6BjGwFKaRVUvDFemhTyYgBJ+6p2cwfuOjzKLU8slxKK3jQ2i69WNlND/27JfNqJfScn91o1+i0IoVaqLSjYA3vG6qZbqIS63eOBcdyjz4sftzYW4JTdSql1M8o6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8nCrXqR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8nCrXqR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24cca557085so1505ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757522747; x=1758127547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awcUZJhrSr7vk/FN6/yazFNso0WDtq5kIuzjKcXy7dM=;
        b=x8nCrXqRuFl2oDmuSyJJC7KYbgbAl1Y4vxGzkStTfJtsCG8+0Dcyd6+E/Ve/dKzQAi
         e78INYFUrTEDkEiUfIk94FLYYFqUJMmIcBEQfhGNI/tfIxmrW5pkLUDHF/VvTMBmWpuc
         dkRMrimMdTe6k9XuS6rliBnawRqOWo9EFDqVSLA4hv41PwSRBg82/2vvGlJPNoG8F3rg
         4po8rKj2l4iLFbD6/duExlDnKRfpW1q7TKKZ4KLI4jmAmikJelYHuRMJj5TUcZBY3YFh
         XZRckaKGqN+ApjZ/vJ0KkYbSSif3r5HDHvZf7EPwSeLv5jwdMfw2NcYUYe8xDJPbsQ00
         NfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522747; x=1758127547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awcUZJhrSr7vk/FN6/yazFNso0WDtq5kIuzjKcXy7dM=;
        b=E5NnNRGKCVDIbaUoHDPaRLHfs5ncfMZH2k2WkV4kHlSHVi5SsMwR4XOtH2GIt/aNjT
         jdGzBPsEP6JGEvRUg56kfTqqxy9GdOUuZd1wldPAk3upgSn5GUk+B622/+0js+rCWyha
         0UEfn0FN8I+sa2qxJAQSBDbf5Z6p7+4On3bk0XOSRa231mqFU/b+Dz8eb85WM1f4Y+Ac
         Q7S6PaCY1pz/fnhj9WRnVuP+3aOQCJWPrcwTlmBUdRseWINCuJsz3HVtWoFk7+pSSUBK
         1yRe10tcuI6Q/u07rEl3jM6OjuEt35MjTnLbMkPDhM9yJM3LqCBBGwFiVwIuNsiwYnsG
         SVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb5Y3WHLBnRM/+iR64SQk9NefINdJ1rfjBbGEk+ZFj5M5dlUt6RdDMUpD+PeQwuUJyttkJVCvZF8RqquH9A/Iq@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIdAUuXI3nCeBId8QRxepqHqItYfkRrebKk4EHlQqFe6Fyutq
	LchQaUacMa/4fMiiUkOXWSrNGywRiK84GHeO+kGLxpbOlyI5IQ3YDkRx4k6SYWtNNCnAqFxU3A4
	dUPX0dmSYmfqGNepG01kZsEs01qUQ/mIqSuagGVEY
X-Gm-Gg: ASbGncvHh/b9LZEsUoO1MfhpKNVlNVIjMquaBII9K8Lm60mu36OTt/T0IQhewC6Rv8y
	+kx9fMLZkIqlrnsWVlPIms3D0DkJl1Ij1UOBB6qDzAdteNuiyVaJaiiHsoV++YNQzT9p+vamdun
	29CU/lMBUvdAiONzwS23ln8qQ2k8SHrFipdGtXzgaIqWdJsKONaF60wH+5i6uvvPwaTFo23TYNQ
	Y5sbbpXpfn0us6zoD41WLjvP0EaW8uKj9maaZVo4S0f
X-Google-Smtp-Source: AGHT+IHYwRpB3J9CuictAomIol7aeL11ghkSN0Km+0mTWaChVAO1NMeXp/i3VR4zUg4scx2cFOoKZZYNX2kyXd2Cqxw=
X-Received: by 2002:a17:902:d50e:b0:248:aa0d:f826 with SMTP id
 d9443c01a7336-25a55af0c4emr5769095ad.6.1757522747028; Wed, 10 Sep 2025
 09:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMACaOmneDrG8_pQ@gentoo.org> <CAP-5=fVA_Cduf9NvFAJezcNcg0JDNGa5q7m_mRBWNAYGEUo8bw@mail.gmail.com>
 <aMAtqNq55TZEuaKn@gentoo.org>
In-Reply-To: <aMAtqNq55TZEuaKn@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Sep 2025 09:45:35 -0700
X-Gm-Features: Ac12FXy0jWTEx2X8QZ0NZCANfJE8Eof_psH73gdEiZeY_JHSOHjsmrlsDgL6vC0
Message-ID: <CAP-5=fX-GG_pUH+1Eak8dsoTdNh=vRU+00scBxbRt7EhXZosiw@mail.gmail.com>
Subject: Re: Problem with perf report --gtk
To: Guilherme Amadio <amadio@gentoo.org>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 6:37=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org>=
 wrote:
>
> On Tue, Sep 09, 2025 at 06:04:42AM -0700, Ian Rogers wrote:
> > On Tue, Sep 9, 2025 at 3:33=E2=80=AFAM Guilherme Amadio <amadio@gentoo.=
org> wrote:
> > >
> > > Hi Arnaldo, Namhyung,
> > >
> > > Since sometime we have a bug in Gentoo's bugzilla about perf report -=
-gtk not
> > > working=C2=B9: https://bugs.gentoo.org/937869
> > >
> > > I know this feature is not used very much, but I thought I'd report i=
n
> > > any case. The problem is easily reproducible as shown below:
> > >
> > >
> > > $ perf record -a -g -- sleep 1
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 1.818 MB perf.data (6648 samples) ]
> > > $ LD_DEBUG=3Dsymbols perf report --gtk 2>&1 | grep '(fatal)'
> > >     288067:     /usr/libexec/perf-core/libperf-gtk.so: error: symbol =
lookup error: undefined symbol: hashmap_find (fatal)
> > > $ perf report --gtk
> > > GTK browser requested but could not find libperf-gtk.so
> > >
> > > I tried this with perf 6.16, but this bug seems to have been there si=
nce
> > > at least 6.12.
> > >
> > > Please let me know if it's better to file problems at https://bugzill=
a.kernel.org/.
> >
> > Thanks for letting us know Guilherme! I suspect I broke things when
> > trying to fix python things. The code linking libperf-gtk.so is:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n809
> > The hashmap symbols are part of the perf-util library:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/Build?h=3Dperf-tools-next#n197
> > So maybe there needs to be a libbpf -lbpf for your case? Alternatively
> > we may need to reorder the libraries here:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n464
> > like:
> > PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPERF_=
UTIL)
> > becomes:
> > PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UTIL) $(LIBPER=
F_UI)
>
> Thank you for the suggestion, but just changing the order of linking or
> linking libbpf doesn't seem to fix the issue. I still see:
>
> $ nm -D libperf-gtk.so | grep hashmap
>                  U hashmap_find
>
> at the end of the build. The function is in util/hashmap.c, so the
> problem might be more involved than just the linking order.

Thanks Guilherme! I was able to reproduce the "nm -D" output. Adding
"-z defs" to the "$(OUTPUT)libperf-gtk.so" also fails for that symbol,
it fails for many more. Even though the symbol is undefined "perf
reprt --gtk" works for me. Attaching gdb I see that the symbol is in
the perf executable itself. I tried the following change:
```
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
-       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_=
LIBS)
+       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^)
$(filter %libperf-util.a,$^) $(GTK_LIBS)
```
or
```
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
-       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_=
LIBS)
+       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter
%libperf-util.a,$^) $(filter %.o,$^) $(GTK_LIBS)
```
but the nm output shows either the same or more undefined symbols, not less=
.

I'm wondering if perhaps the hashmap_find symbol is being stripped
from the perf executable. Maybe it is an LTO or stripping related
thing?

Thanks,
Ian
