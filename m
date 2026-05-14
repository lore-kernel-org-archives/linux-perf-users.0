Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4B336EE9
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776670; cv=pass; b=PWCSbz/MjyXVPn3Tg6VvgGWzxSx5GZC0bwMyQtleu9lKWAyhuyCPDaBymzZZ1TGOaFk1UPb3Yxp6JFSHVkhHrUneaIhHGA3ybQ/g2rQNK2b4XkY2rjO/Gwcml8WFFjJDib92BcJ3hNUW8UqIWK56PW3YfT9ghVx7JNTfQZmZkeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776670; c=relaxed/simple;
	bh=ON9stXw0Lg5Y6tyaAT4szKRGcCGwrprdC4U05lyqO2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tX3UChF+EVORM1ZWkIiX11iu9tvemQ8BpvozpRGe1RzU4tPMnSk0oc55Fv594H+CDCYzx+rSC8Se3Uar6konkgqkjn/JA9zrLrK4Qsl1eXVObvABgrm5XWb2WSJPl7PPLzemv2XssioOj+X3J/z5MzQVxQiTZ6BNRr77fBVn23E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dkt3Rd2G; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dkt3Rd2G"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8d0945b3so50c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778776668; cv=none;
        d=google.com; s=arc-20240605;
        b=XMXCwP5OB7Kd9P6kxK8wBC5DPRcCjKr2PtdvpXsMg4F9v7lCqjPQIqo2ZwCEKS7d3L
         bJ4/XWJsusqmXhaXoMiCh9qiWZniIDn1sXqFIK49sVy5NP1WWkPS3gxNGLD2HUTx841G
         HVkmkrMDUKUynSM7OjWqlperjiZLuvVZ2crIEgXWovV/YNLxrPoI6/TWo6YpQYpSYwxy
         q+3FnFnKt9r2D7qG+Gac+B5SAz8+7zXkO3kS77yeQYgqqXTit9PCixeYixTkf7nNqHR3
         vcjRcKDj3YqguEopKu/yopZWWF0NQZ6ByxlTdxugfOTyRcGw4FaoyPWh2Nb7vM1iEWoY
         vbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ig7yBd9mVAEhaPLHSzdHx9IU65mp4w8wTO1kuXURqI4=;
        fh=w894r0GZn2a9ndd0FALdTx39SRwZEVTFuPFkWkMbtmA=;
        b=JRglLN77VOmhqql+NnUtDFaS2T9g5v2ekwFnoXI7gFW1tVqHK4LhjmTJ9ZSmN/IE+u
         B2nwQRqMf175vPXJTcIzFL4WMtN9TLLr0qgu6aTz81KG30p7t8sWKO/1sG6nFzzcAh8S
         cITT8J2mElZABWPyRc51A9Pgwmy9U7vaFF6OK9iYE8NuxJ8crbIoc1JOicZOsfP7WWGh
         4Z1ko4xx9G5z0OtvLwKNWeUxCQzzXnC5hIIpNxvdaVgZH9LFL6Qlxnw7Ua8l2fFRGdkM
         JgCzaURpN8lf60updqAxphZiy8A90iUH+j6LyHq+AYSqn9FZbhJybQxYUX0SHY3J/Ff6
         h+qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776668; x=1779381468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig7yBd9mVAEhaPLHSzdHx9IU65mp4w8wTO1kuXURqI4=;
        b=Dkt3Rd2GP2mDPo4ohtWE7E6ZNtMOPA2EkptGjz7ad6rFixIRSCl9hsRVNZ/LAfZvvn
         diMVxmkQ2YoKjKoO6VK9OYFcSMVb0+3VVP/6t20AsGs2zndtOltuqgf9OeRDRch1Os0S
         e8F8fJ4RlCZ7qy550Ol/rRGCLSpkikx1cGyh1coT7CJhZIiu5q530kJHTIY25YwmySoC
         N+ykXy4cBb4XXslI9Yku8NX1XTXaOAF5Ievaet0m/5ootLiVq74j4PNSXZjRCOzFD719
         aJmZi5VDtEPeG6AwwxaC3l+t7lDuhcY7lh7jD+2OSDw+rVo8+6rqLFOgO95LpL3shW75
         8eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776668; x=1779381468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ig7yBd9mVAEhaPLHSzdHx9IU65mp4w8wTO1kuXURqI4=;
        b=PuwfqKPW8ImNPJDwW5HXUwAWkLlRi6TD/1xu9nI42mdiTfi4kPCfUUoZED8libp4DP
         8ZtxvwDZ9AjoZAOZyPMo38gn2xTz44sC3yIgMX07SQ81aV9vLCOdzRQ2PHi2NAdi36/Z
         AXbft0S4z5zxWR25ocbzQH7y0bCSQIc5RaWvY7/Cv5eOesx6q03LhzXJF3iRKnc/i50P
         zQdWLnELZ/yE0LFFHVEYaZBd4pSEkiD3z1ZgaQshRuf17MNqbW76ZZ/lwp+i2s32bz+r
         FaMGjoUoJt1Wn5r+6W8DDE9uq8hn0g526BU3NKQRXmkXsDx6kbOy4H6A1kjOyCKLYcck
         YSgw==
X-Forwarded-Encrypted: i=1; AFNElJ/rLGXZ7w2tYjPHW40b2c/Mz5iknxcNCrLRGR4V1dUrrLDxBejZoo84/qAe2EF1XZnNaCO/GDJPFubMi/uD3klJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwedUY+WCRQfhfNnHULCsXQNx53Nn3tx0SQAzciQ0d3aD2kqXMu
	r5DSXBKYN49NLKeSGzwAsQ09ytV3PgfgQgX0fWw37kGSPOixhZssAb6MoDtjMIrj7y0oNHQvmEx
	zfIDJ6r8BhoLv10PGNB7S4NiFwHdcmtvXnXC245k3
X-Gm-Gg: Acq92OEeiPgAjyIh8y4bdOPEZmnuS4tL5y5m+xNB27QWmDcixW5bn+dzDNQ1Nbcd1Ej
	eXykewYpuYrEGfXMUpAymJnY9dok6dZ9D4s62v1BCQZuyEh0SIvmYWgREv++ZnmRWP3MW1guWr6
	IRUosBvL5UKHTTyuB7TaJW4Yiy9ZLshFX3qA5+3Siq395DOFkO+IahbNtXBVDPMQ0PwEAHa3idh
	ZOFb0P50YzH1g59Ge/PYXuA4a1vsvDk4IXBVp8myqaT1Ee0vmGPIXZFBUVzwa9y8c7IGHdN2SCD
	9ofZ+URY1gOp9n/CtpGOUb9B9cXy9fLI2rKCNpVqWCRKdKQ=
X-Received: by 2002:a05:7022:f20c:b0:130:5c2c:d255 with SMTP id
 a92af1059eb24-134d3115d4fmr116423c88.21.1778776667174; Thu, 14 May 2026
 09:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513192347.4007895-1-florian.fainelli@broadcom.com> <agXwulXp_PqixUCg@google.com>
In-Reply-To: <agXwulXp_PqixUCg@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 May 2026 09:37:35 -0700
X-Gm-Features: AVHnY4JjOKsA0PCCOcOqyT3rSrErA3I4VyaZomWax9zQOOV1u8d_ZJtEsgvxIxQ
Message-ID: <CAP-5=fUJvVGEeA7+mk8KjracroD_5xhSi2pp7eQbEv9xGeq19g@mail.gmail.com>
Subject: Re: [PATCH] perf trace beauty fcntl: Fix build with older kernel headers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, linux-kernel@vger.kernel.org, 
	mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 8:56=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, May 13, 2026 at 12:23:46PM -0700, Florian Fainelli wrote:
> > Toolchains with older kernel headers that do not include upstream commi=
t
> > c75b1d9421f80f4143e389d2d50ddfc8a28c8c35 ("fs: add fcntl() interface fo=
r
> > setting/getting write life time hints") will now fail to build perf due
> > to missing definitions for
> > F_GET_RW_HINT/F_SET_RW_HINT/F_GET_FILE_RW_HINT/F_SET_FILE_RW_HINT.
>
> Can you share the error messages?
>
> I think this code should use a copy of the header in
> trace/beauty/include/uapi/linux/fcntl.h which has the definitions.

I don't think the beauty headers are in the include path.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Provide a fallback definition for these when they are not already
> > defined.
> >
> > Fixes: 9c47f6674838 ("perf trace beauty fcntl: Basic 'arg' beautifier")
> > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > ---
> >  tools/perf/trace/beauty/fcntl.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/=
fcntl.c
> > index d075904dccce..e1b99b8f55eb 100644
> > --- a/tools/perf/trace/beauty/fcntl.c
> > +++ b/tools/perf/trace/beauty/fcntl.c
> > @@ -9,6 +9,22 @@
> >  #include <linux/kernel.h>
> >  #include <linux/fcntl.h>
> >
> > +#ifndef F_GET_RW_HINT
> > +#define F_GET_RW_HINT                (F_LINUX_SPECIFIC_BASE + 11)
> > +#endif
> > +
> > +#ifndef F_SET_RW_HINT
> > +#define F_SET_RW_HINT                (F_LINUX_SPECIFIC_BASE + 12)
> > +#endif
> > +
> > +#ifndef F_GET_FILE_RW_HINT
> > +#define F_GET_FILE_RW_HINT   (F_LINUX_SPECIFIC_BASE + 13)
> > +#endif
> > +
> > +#ifndef F_SET_FILE_RW_HINT
> > +#define F_SET_FILE_RW_HINT   (F_LINUX_SPECIFIC_BASE + 14)
> > +#endif
> > +
> >  static size_t fcntl__scnprintf_getfd(unsigned long val, char *bf, size=
_t size, bool show_prefix)
> >  {
> >       return val ? scnprintf(bf, size, "%s", "0") :
> > --
> > 2.34.1
> >
