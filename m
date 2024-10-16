Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1654F95
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091209; cv=none; b=t27xPfoCt/s+sexr+r29UDm5eLYSvhfE3XqCgfZ6cYc0WEPkyktlPBi2wC5Pkquy68A3s2i+z7VIYN2YwzmteH6O2pEvyqsWJYUJS4qQhAHIEG+imyv2QSceddWWHRrTFhtMt6rQqPKnNMPUq/f8027GPLJyCPPEv9LjiIas+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091209; c=relaxed/simple;
	bh=sVXCawjoAZ0qULNgQIznPXaXamZ0Ca/yfNHXe+yB8nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGi51ZVFq6jDfyerO7U5zSWTYG1wyvUUAYZwnWupjt0Z7+ijFAH2iSgLzST92fV6gYKq4A1OllGChpsExMDWEFNLK2asTgTb53CTHfj2aiuFLdaCD2ustJtQiXLLXtyQONotCHUqO/SqvWsXXex9l+d+lxjzT7l1lBVbZmRQtmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvKW7JCT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvKW7JCT"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45fb0ebb1d0so308081cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729091207; x=1729696007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6K4x8bphATLlXhelHBdtpzDtj/LNGp0/65nra7sovmg=;
        b=JvKW7JCTDmSzTk/7/Fr72QluZmVHLUelT2MOvaWn8AzPlNIiVFwK7SZw++qkFNdBA3
         HnA3abZ19uWGrHEO40r/eD+5LgLLqbyTLIRkyisFInfrYW1MUlD+Dzktn+5n/Z1tHWIm
         jZyObCdjkJjXcBqsyckNfkhzsCZ66MBqrDDRStkg/K4N/9YcK/vA4AcJt3oOkwuwXX3L
         6fe+SjIYZwizj5nuqAPSYQXdK/7f2lHBMu6nELYN2GGCN8SeYkVbEr4ONU9yZoAcIn91
         I+FBQEalUipxH0gMPjUe+KNmOTs/bBjM0i7gVfg8tl2Niu1q/5yfTQyMPVEeY410Qlmp
         lwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729091207; x=1729696007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6K4x8bphATLlXhelHBdtpzDtj/LNGp0/65nra7sovmg=;
        b=qKRNaxXOCWyZwLtqViEEo/LRyKbbHberDUQH2/jpdgI9N1FpcSeZUA2rNBB3TTJaJU
         UOUKtOBwOQBnKo9yw7fV5cXSLRy5eKTNQITzR8uXQFUkPLwbxD1jk2SvjRYVAPsfaIL4
         98HTg7xgBoFa+mjWF1ELUTeOTFl1BUqoqlCSFiNZdUisVCH0puCeQNrFkQrnEpkHWuQG
         m1K6XKzawqV8gdAFCHwqvr0lo4AJy989BWO/Ke8IAnhmLa+jEKFw4HGJrvbVtj1UWpae
         0AASpwKv1mwz61PFMIOWp2Eb92vD9y5f3TVZTcEfrujzcqqRqbalwCYrLUYjzgo2HZQG
         mpTg==
X-Forwarded-Encrypted: i=1; AJvYcCWp5GgXUFEsO2v4dWSwVQzkZruwrbC5zG53+GOBgKvMijv/ExMsiWJ8x4JGrw8robuhWCMkLhVS044rOGMt1/xI@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+uzsp5xGrLWwnHuL2kAfDvI5cgIsXAK/g4qzBGL0K3jcnOnV
	9XrCLhS9DPgPMk9C8oUdTzUsPi3zBxJ0RtIH6kdlRShGXt2F6tXhEIy9j7A1sjKep/msfOFepXs
	Vn3MiltjaoJsF/MSPWYpms8hlmsg3EzVuy6I+
X-Google-Smtp-Source: AGHT+IHoJmRL6Rr/b848g5lwqp2hwHbpRFYxfZOHmo4MfEhx8DYqRyOLQGFNUtgMz7WYW9kZ8oqR/5cdGwmeVpfYiOg=
X-Received: by 2002:a05:622a:7a88:b0:460:4638:78c0 with SMTP id
 d75a77b69052e-4608db520e4mr4965651cf.14.1729091206890; Wed, 16 Oct 2024
 08:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013173742.71882-1-atrajeev@linux.vnet.ibm.com>
 <Zw1UXbWTS9Gk3lmw@google.com> <8B5B2251-E41E-4584-881E-61A468AFB222@linux.vnet.ibm.com>
In-Reply-To: <8B5B2251-E41E-4584-881E-61A468AFB222@linux.vnet.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 08:06:35 -0700
Message-ID: <CAP-5=fWQsQp3WgJcLvZWsBsiJ2VzxP6j2kOfd5Hrzi0oBUNy2g@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests: Fix compilation error with strncpy in tests/tool_pmu
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:30=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 14 Oct 2024, at 10:56=E2=80=AFPM, Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Hello Athira,
> >
> > On Sun, Oct 13, 2024 at 11:07:42PM +0530, Athira Rajeev wrote:
> >> perf fails to compile on systems with GCC version11
> >> as below:
> >>
> >> In file included from /usr/include/string.h:519,
> >>                 from /home/athir/perf-tools-next/tools/include/linux/b=
itmap.h:5,
> >>                 from /home/athir/perf-tools-next/tools/perf/util/pmu.h=
:5,
> >>                 from /home/athir/perf-tools-next/tools/perf/util/evsel=
.h:14,
> >>                 from /home/athir/perf-tools-next/tools/perf/util/evlis=
t.h:14,
> >>                 from tests/tool_pmu.c:3:
> >> In function =E2=80=98strncpy=E2=80=99,
> >>    inlined from =E2=80=98do_test=E2=80=99 at tests/tool_pmu.c:25:3:
> >> /usr/include/bits/string_fortified.h:95:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 128 equals destination size [-Werror=3Dstr=
ingop-truncation]
> >>   95 |   return __builtin___strncpy_chk (__dest, __src, __len,
> >>      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>   96 |                                   __glibc_objsize (__dest));
> >>      |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
> >>
> >> The compile error is from strncpy refernce in do_test:
> >> strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
> >>
> >> This behaviour is not observed with GCC version 8, but observed
> >> with GCC version 11 . This is message from gcc for detecting
> >> truncation while using strncpu. Use snprintf instead of strncpy
> >> here to be safe.
> >>
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >
> > I found this issue now and thanks for the quick fix.  I will push to
> > perf-tools-next soon.
> >
> > Thanks,
> > Namhyung
> >
>
> Sure
>
> Thanks Namhyung for pulling in the change
>
> Athira

Thanks for the fixes. As this is test code I don't think performance,
style, etc. matter much. The GCC strncpy warnings are annoying imo,
I'm not sure it makes sense for them to be enabled. I see in the
kernel lots of "sizeof(foo)-1" as a workaround. strlcpy looks like a
better alternative but it gets a checkpatch warning as in the kernel
strscpy is preferred. Perhaps we should create a strscpy shim.

Thanks,
Ian

> >> ---
> >> tools/perf/tests/tool_pmu.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> >> index 94d0dd8fd3cb..297cc8c55579 100644
> >> --- a/tools/perf/tests/tool_pmu.c
> >> +++ b/tools/perf/tests/tool_pmu.c
> >> @@ -22,7 +22,7 @@ static int do_test(enum tool_pmu_event ev, bool with=
_pmu)
> >> if (with_pmu)
> >> snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
> >> else
> >> - strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
> >> + snprintf(str, sizeof(str), "%s", tool_pmu__event_to_str(ev));
> >>
> >> parse_events_error__init(&err);
> >> ret =3D parse_events(evlist, str, &err);
> >> --
> >> 2.43.5
>
>
