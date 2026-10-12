Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF7470EB6
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791844734; cv=pass; b=PQlNEGzt6IqZ8FYxvGAXu1P4g6RgQObvwagifBX4wC+6bwgaU7HARxOPGF7EGq71k05Y8iqXkYW4zv7QieP24B7FI1HOcDL4AXVGkGzOYlRafKb+YKFfWs/DhSc0R2It37DWGjo2+e6sKIB4J7OqsIbgMYWhLLHaAZo3R8zPFf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791844734; c=relaxed/simple;
	bh=2EJZ/MdSdrcAt4BslODEOUqzbJqgXodfdsD9g+6uKJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxfzvdlXH3z3me646UUvMfz9+R2vsdaZfqFR+cIsWD9uhpFsBNFnUbaQ+AHA4yBxxzc9Aa8UMj+VKL+P9AbSy4mz+hx60aA3D8pXTl7l1Xp3I7LBVUW0qzl+4om0MG/PV8vdcs17Y5x6RO/mMON8BxJO4BwpFxfh9tUQIxnswUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMQvW1W5; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMQvW1W5"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso2811293a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 15:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791844732; cv=none;
        d=google.com; s=arc-20260327;
        b=GzJC787OG0G3Mi545VS+jt55C7UVv+EhcwjimPYdmpAeW0DZwH70Lnn2zJWYB9IvBw
         oX0a05ggV0tgs0R2oZSGyCnvKfdiJ7FDcx2hGq11wg/gA2BfXpUfP5+iWMYwRFUw4Z2N
         oX7wVfKOfrSEfLcRjNbhvn6PQ3dU8AsLflBExC/zsOhz7MPMQvuE140zmACtfs4hVD0D
         GhKezuJz3BJW8IRvReObwk2Uw2WWFPRh5OM55/lA1+x5/5RvCJ66CKNj9OXA0lhNXrCB
         Fsy6vulrE3SdXgNjFf5nwKpkiIMDE4BuAeG2nTfi9iGK6ByphX8hRy5He0JCSWwn2UOQ
         UwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EJZ/MdSdrcAt4BslODEOUqzbJqgXodfdsD9g+6uKJw=;
        fh=cX3I8R7A1pDyYCSMRUy1/ZZbNmfAiF8Um+Fhzaf3650=;
        b=Rjrc4q3i87wH3vjpAQTcSplD2dwrMUcwFeU4WXh3j2d1bCsjdSZSEXYcvIJQdqtyZK
         VhppmXs2/guOBJMGmfpCjJC+5+os5WCrhRfZ91+dWFMmSHOk5j1Q9EUlxX3+L26oud6s
         LOPGY5UFHiPfSyH4yn+PpNziUB+B1peXE/8bNIDkqrPe29dc3lKI/igrnYC3bmXYGAN2
         FvROU6mYBUlbcnQe/bpZ6h3EHwW9ShedeEFJlJCoDWkBv+D6/QHw/FqALRbMtXxSkIds
         rqArIRMKAeFuFHhQcGTiu3gaR4FWRw7GdFac5mGQQu3fIK0C4gtPqoY6nw1JI2MXKnvo
         07Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791844731; x=1792449531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2EJZ/MdSdrcAt4BslODEOUqzbJqgXodfdsD9g+6uKJw=;
        b=lMQvW1W5arme6ixZ/aPNWep+Rrs+GcP4aV8lHrQ4iUhbtsMBlwe1NE5okST2S/vvZb
         598dQIj0bETPe5nNCWR22ljw7qCw7crHlwAGSqN5rjpyr65YOSV0gh/bGqeYShSmz4a9
         VmxRHk9fQx83xvs9f2q2Kx82Ek6yjIE38RhWA4tf0mQlMar/pAamtDARUduSICxPg2jO
         pLLAkO7Pckfn0WcZAz5EkupuEUakVHPssbe7maZFeH2vdYDzCok8WfZtul/TUkLOPHA9
         3k00BwKEfPm2IC4i0fXOEVw4FHBzwTbAEoxCl7f8/Qjswf2UDvxe28dIW5I0zgogH75z
         b7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791844731; x=1792449531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EJZ/MdSdrcAt4BslODEOUqzbJqgXodfdsD9g+6uKJw=;
        b=BbArg18oszqpdOX+bExcOENdazduJXnA5def72zTf8PpPg7lfT8o//2UL5eiTOUAxZ
         +lrMQlZcHJC6K8XqgCW0bEPluhZfewKAvyG9ujN/bf0DNI9+23yFrVrbboDA7lVB4XYV
         AD+S7btTSBb/DEhwe7rkvvYYuk2PQzTz14KO4ofSsTNhwLnY/va7rO85GmsCDNmvKBu5
         /H4OOGVwevrEdY+0u63WbA2IXqJvEf1zc8mJhQ3q/UAAwyPlK6ozbJGN2HNaoslFAB6K
         TpYEz0r/+uQLjpmEGrdTQs47wxVqbKF0B2YYW6oQ8hYf4mrmSBqRlRSp/IJOc7HT36Gy
         LzLA==
X-Forwarded-Encrypted: i=1; AKwUvBwuZ1SvyxMkMffczrq/zvE7tzRUwmFV7eGrG/zDrlNYhzKOXJp28DqXW6KfQndf78V3CvswfkSTE4KDOpJD/bK+@vger.kernel.org
X-Gm-Message-State: AFq9FYK5dx/SwevBm9CDNNaOIbimbhbaH6pUXkZU/VLmdG2G72JPLyhP
	rxYKWe/jGDboFiP3DVXtQlaOdL+J2/i3LE+LSFXmM8q3KsSpL1DdrQw11jmPzqJY9ere5yitwJJ
	Twz84NO7UgI6Y4JEABBkC/upGo0ni4iQ=
X-Gm-Gg: AYBFou1gbUMn5SYEURuWBX82hODuxl4NU2zI4ZLKhfXEvBlj68ZteC3s1NZ3jLfwydC
	VFlkgmn5jWtQ/RjQjn+W6QyIDzQumgoWcLgd8bgdLLgTE8KhRLsEP0tsgVkK4F1wTZUh6+GvZ+9
	xNmbimGKxOj+wmKm+JVtTnOy5olOBqj1v6thAvk7zaSa2xwQ+KJk2AqNUFuTQebNEP8VBeJGApz
	5Dm1o8PlzJD8n4DZdQ35WoX/X/MrQ4z7IfB8+EKLo/Hlbt4mJFnopxqMM9IF0kNA2+OKKKomjuM
	pdDF7nXnILV/CGaCJWwGg8Vj35RuFOg3IpRjvWEVJEUC4fxhXeeYbMdAgpZYycWX+8IgdaJlV0Z
	gs87DHlseK09WizAgwosN6kO/8HH9v26j0CIZ3cTDxw==
X-Received: by 2002:a05:6402:13cc:b0:6ac:9a44:d404 with SMTP id
 4fb4d7f45d1cf-6b17c161c2emr8836767a12.0.1791844731550; Mon, 12 Oct 2026
 15:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com>
 <CA+=Fv5SDnzQQDzyhaQ37kWJMjTOHP0NHuAS6kJHwT8_Zqyjd-w@mail.gmail.com>
 <CA+=Fv5RGr2NQs=gnErAWXfSZgMcWB1q-_-BNQ5X5DyzqkV-bmQ@mail.gmail.com> <CAP-5=fXFYbuV9MtJsVX5hUPKDOxcjtNTHM4-qR7Q+ncsPq59UQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXFYbuV9MtJsVX5hUPKDOxcjtNTHM4-qR7Q+ncsPq59UQ@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 13 Oct 2026 00:38:40 +0200
X-Gm-Features: AclHuK9jpDSnMmxaQ8D-fp2gCjn8tu1qfqdLAoGiaBjhGMcvT3oSv-_wxieiSxY
Message-ID: <CA+=Fv5QHzus2HUPJNFeWMCFSrOjvr8xhkPie2CLSbdjgK=+j8g@mail.gmail.com>
Subject: Re: [PATCH] perf regs: Add alpha support
To: Ian Rogers <irogers@google.com>
Cc: Matt Turner <mattst88@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Mon, Oct 12, 2026 at 11:45=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Oct 12, 2026 at 2:41=E2=80=AFPM Magnus Lindholm <linmag7@gmail.co=
m> wrote:
> >
> > Hi again,
> >
> > On Mon, Oct 12, 2026 at 7:37=E2=80=AFPM Magnus Lindholm <linmag7@gmail.=
com> wrote:
> > > > base-commit: bc01105ed65d15787b2eb93ac26e8624a2139e35
> > > > change-id: 20261001-alpha-perf-tools-regs-c206a84dec7f
> > > >
> > > > Best regards,
> > > > --
> > > > Matt Turner <mattst88@gmail.com>
> > > >
> > >
> > > Thanks for doing this!
> > >
> > > Register selection, recording, decoding and user stack dumps tested
> > > on my ES40. End-to-end DWARF unwinding remains unverified because the
> > > installed elfutils 0.195 lacks Alpha unwinding support.
> > >
> > > Tested-by: Magnus Lindholm <linmag7@gmail.com>
> >
> > I just pulled your elfutils patches and ran some more tests.
> > With your elfutils patches, DWARF unwinding now works on my ES40.
> > Both existing and fresh perf recordings recovered the expected
> > leaf -> middle -> outer -> main call chain.
> >
> > As documented, samples whose CFA depends on r15 stopped at the
> > sampled frame, since r15 is unavailable. Tested-by tag already given
> > to this series.
>
> I'm finding this fantastic and exciting to follow! Being greedy, does
> the cross-platform DWARF unwinding work? perf record on an alpha and
> perf report on, say, an x86. It would in no way block this work, but
> I'm keen to check Matt/I wired this up properly :-)
>

Tested recording on the ES40 and reporting on x86-64 with patched
perf and elfutils. I hit an existing offline architecture-detection
issue in my for-next-based perf tree: it selected x86 registers for
the Alpha samples.

After two local corrections, both perf report and perf script
recovered identical seven-frame chains for all 391 optimized samples.
The r15-dependent workload stopped at the leaf, just as on Alpha.

Both issues predate Matt's patch in this tree. The places to look
are machines__init() in tools/perf/util/machine.c, where the host's
machines pointer is left unset, and thread__e_machine_endian() in
tools/perf/util/thread.c, where the session->data check for is_live
appears, to me, inverted?

Locally, setting machines->host.machines =3D machines and changing
is_live =3D !!session->data to is_live =3D !session->data resolved this.
These changes still need broader review, but the Alpha cross-platform
unwinding itself looks good.

Thanks,
Magnus
