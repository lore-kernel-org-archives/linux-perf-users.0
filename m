Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35538C2C6
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778800; cv=pass; b=Vm2g9nYXm+vhteoQHP8OtZ/1HMioFJ0s+15i5CSi8RHzqQu6xgVrmQViz5Br4x/1q1lA8qmP1H4CPuHixsDRfybQJQmNBtbuMB6B4YO/pyuzNJqRh+/L3JRrM9aY5y8rrC8TSBFcsImMEMEHHPnWx0naIzJr9v6JDVIkPBqXxFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778800; c=relaxed/simple;
	bh=d+OtiQ0H/gBifHk68vqkUXjS10Sh3IVlcLVUeTNFQg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBEgfr+FK5IxZQeym7qDoWcz1rdUPR7r8nOYuL9wEYpOBeEY5DUO3cyKztcfOqWNXogIBIZ9oJ5+om/+Sgovdgjz2ewadrY/eJ+bU+32FVD/23Q55Craif3SkEttYqZA1WkNox1lKtVaKWAjiRB4Rd4JYhQWBT04bPKsez18Q2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcbRxcWC; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcbRxcWC"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-132cccd3d77so118c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 10:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778778797; cv=none;
        d=google.com; s=arc-20240605;
        b=RHlZ8SLC49H6MEebjFwsfwxKMRdJ0dOdLNq95QnNwc0Mphf3C7b5ysYT8OsPxMoPdi
         Ada1ux3CMfGaYtGwSXDeSNKYX+/cFeSrvHweqpCJZesewqv2kMG0pBkkFyEbWdSQY8pz
         8SVLeUtG2be0mfrHNxfjD+dp0/XFZNEeEWQ73dh+8G0PUqZRjmWrTRFOy4ndNJIjOugN
         IwNUaGdEcVECujMtJhzaX2JRf1KXSxTWpW60Im3TUR6MAK3KWqD4Ig3tTNQIdxqzKFtG
         9omMrarXS2bzri7SWPOE5hJvDnLY+672bKOOKld8exK6Io5XKGRiXFHEqh/QBUTFboYa
         Fqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HxY3bIiiTdRYoBV+0s7FH7KcYnL1mpvYv2a4R0jVs0k=;
        fh=B0NHO/sq4s7PjJqgPl29w+2OC5YPFNzyU924WRvYuKA=;
        b=G5Aa0pSIVcRcYyP+RCz4ApXK6BlqTfPNi1k0A5lr4H2fWvfd1S2RA+bNECldr7CM4b
         uCBtBVk1VrcJLqVS47mSa+/GDSeqy79PaoiSL7W/feZDTkSZIu5WzMhtJZXE2MuxJRYJ
         wN8RRA8ILVd93tIwhcvOLX193sSYpUcd340QkMD8BiGiicOU0fAIQCwAxPi81nAosjCm
         cONzA5wKZ6YDCYrTlQmvfHplk+sAF4N5rVtRSgcBZ9380oS8eiMGzMIq/ACo5nJ1fLFU
         j+qJY1txmj2FU1qqCMEduO69J5JormxO9GxsvQww3W507ceQz30knllHqUxVPt5Bfvo7
         7A0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778778797; x=1779383597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxY3bIiiTdRYoBV+0s7FH7KcYnL1mpvYv2a4R0jVs0k=;
        b=HcbRxcWCwxIet+Wk6yOp9N9X4++L258ZAbKKxThwrJ03E7jhbQcUxXzPMs9+NVg8JO
         SByuoVPN/2BMCNyIFx+tl/eEHXbylnUfyOK5IMeKjhtxas3WeCmAyxkbu1dWlMoNQNuh
         MiMeIJVn8MnDs/bPRkQVT2aaQPS1KkZD44RKK6yedCFMIUJQy0uZzH1CXkPpxGDtoXvZ
         fL5RS85OWBPianUad375LvB1no2XdKCjzHfWHna3l0t1qCMmPMgFAYoDmHoxW4JZnN4L
         Z43vgY5T3YpqGCBbM7j7HdGe90W0qNnlvu0gM6VZausXGXk33szcHDNISltLDrF9Sm8B
         QdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778778797; x=1779383597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HxY3bIiiTdRYoBV+0s7FH7KcYnL1mpvYv2a4R0jVs0k=;
        b=LlwKk52dbtyMe8mVbljVZNr5ZgRdQA7vggUBpxeYETf+vn0oqH2hlx0oB8+pjafQCF
         6DLtAHshXvhPsP+V9lmuES7sb/WvIrAFtyGO4Ena15xMA4NVM9/d5eggQjCa7heW/PA3
         xsDboB1DS0mt1OnymegUYxfj2g3YChh9fqBV5M+S9deXRl7Z87/pKRIzrxUfXwqZd/Zf
         rMGEkClnamcblLE12qKK524NudEmLClRb5BW1LsYklFdOIrE3U/C1MEwhHv1yUKs0gn0
         Zc6jp1jn8XLKt2Qv9a9aGloQ1OZg/16kUrNJWzyAewMsX7YqeyYVaDG8uFsqrsU/KzpU
         gwTg==
X-Forwarded-Encrypted: i=1; AFNElJ/pE8d2nDcKxU4YcCuRKwDnvPGg2aPnz9bYO9p6yadMT9vAEO80AbVcqB0h6UsAQYx7HQ0ATPImPIraRmTOZHza@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYN+s4t0opuwQCH8XnBwfpJwqxyXUlElfW3vietCAQMZU5EaJ
	lAA+2yR4pPuhByaERnX1gynVcFM1Dv1Qv+03xs6wiOpEZo/b1oyCayGW5I4K6yHxgK++U3UfpsF
	RPq1gJhRddgLrt+E4KKGueLgECdgrdmJy4dwOWBk2
X-Gm-Gg: Acq92OFigwAfO0lEv/+PYJKObeU0UWAWKVqZJl5p5HtGCo3S8+MYKxrR6G0nrviWwjm
	sdke/9SivfmwgKeLeC4mVJGvwSv6EiTlEkBpsIkQDatwIQjAuK4Kl+QwGe9LKOQW1EfZc+jg0dF
	CsTbE8ATPhYO4znCccESEMUEL+Kd1w/+c9Vq8DvHNko7TeUBks1od6/368sOwgH+yTC5gBpyGn3
	hYCpR5MlnGMkMvtlpw7jN8TBnacTZ3/UCml70PMjbOxNpNowMbANEKe8d9ZgfpPYNUO+JqyAfbY
	SNyfJQwZCwyMYVJiD2dwcL8bgjt3JrkPUrAhBMCxDHmF4Mw=
X-Received: by 2002:a05:7022:f317:b0:12d:b285:c521 with SMTP id
 a92af1059eb24-134d2ff20a6mr38451c88.15.1778778796309; Thu, 14 May 2026
 10:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513192347.4007895-1-florian.fainelli@broadcom.com>
 <agXwulXp_PqixUCg@google.com> <CAP-5=fUJvVGEeA7+mk8KjracroD_5xhSi2pp7eQbEv9xGeq19g@mail.gmail.com>
 <9a1b7351-bf10-4120-b29b-7f6b340ae92e@broadcom.com>
In-Reply-To: <9a1b7351-bf10-4120-b29b-7f6b340ae92e@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 May 2026 10:13:03 -0700
X-Gm-Features: AVHnY4IN0AqAUvtEcCE5IzxOw3Vu7GRdjaDGE_lhAWvTFoc3_D0d6eIBBa3IZ0o
Message-ID: <CAP-5=fWAymPbYdsiRJKTN-ff_dKRzGniQU62uVPEH=2Lkw18mw@mail.gmail.com>
Subject: Re: [PATCH] perf trace beauty fcntl: Fix build with older kernel headers
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, mmayer@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 9:57=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 5/14/2026 9:37 AM, Ian Rogers wrote:
> > On Thu, May 14, 2026 at 8:56=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> >>
> >> Hello,
> >>
> >> On Wed, May 13, 2026 at 12:23:46PM -0700, Florian Fainelli wrote:
> >>> Toolchains with older kernel headers that do not include upstream com=
mit
> >>> c75b1d9421f80f4143e389d2d50ddfc8a28c8c35 ("fs: add fcntl() interface =
for
> >>> setting/getting write life time hints") will now fail to build perf d=
ue
> >>> to missing definitions for
> >>> F_GET_RW_HINT/F_SET_RW_HINT/F_GET_FILE_RW_HINT/F_SET_FILE_RW_HINT.
> >>
> >> Can you share the error messages?
>
> The compile errors look like this:
>
> trace/beauty/fcntl.c: In function 'syscall_arg__scnprintf_fcntl_arg':
> trace/beauty/fcntl.c:96:13: error: 'F_GET_RW_HINT' undeclared (first use
> in this function); did you mean 'F_GETOWN'?
>        cmd =3D=3D F_GET_RW_HINT || cmd =3D=3D F_SET_RW_HINT ||
>               ^~~~~~~~~~~~~
>               F_GETOWN
> trace/beauty/fcntl.c:96:13: note: each undeclared identifier is reported
> only once for each function it appears in
> trace/beauty/fcntl.c:96:37: error: 'F_SET_RW_HINT' undeclared (first use
> in this function); did you mean 'F_SETOWN'?
>        cmd =3D=3D F_GET_RW_HINT || cmd =3D=3D F_SET_RW_HINT ||
>                                       ^~~~~~~~~~~~~
>                                       F_SETOWN
> trace/beauty/fcntl.c:97:13: error: 'F_GET_FILE_RW_HINT' undeclared
> (first use in this function); did you mean 'F_GETOWNER_UIDS'?
>        cmd =3D=3D F_GET_FILE_RW_HINT || cmd =3D=3D F_SET_FILE_RW_HINT)
>               ^~~~~~~~~~~~~~~~~~
>               F_GETOWNER_UIDS
> trace/beauty/fcntl.c:97:42: error: 'F_SET_FILE_RW_HINT' undeclared
> (first use in this function)
>        cmd =3D=3D F_GET_FILE_RW_HINT || cmd =3D=3D F_SET_FILE_RW_HINT)
>                                            ^~~~~~~~~~~~~~~~~~
>
> >>
> >> I think this code should use a copy of the header in
> >> trace/beauty/include/uapi/linux/fcntl.h which has the definitions.
> >
> > I don't think the beauty headers are in the include path.
>
> I suppose if it were however that would provide the missing definition,
> maybe that's a better path forward to front load the inclusion of
> trace/beauty/include/uapi/linux/fcntl.h?

That's a reasonable thought, in that case we should move the header to
the more regular tools/include/uapi/linux for that purpose.

I'd very much like to get rid of tools/include entirely and have its
headers provided by explicit build targets similar to how we have say
libbpf headers:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n957
Currently our include paths are a mess and we prioritize
tools/include/linux over tools/include/uapi/linux, which seems the
opposite of the expectation in user space. If we could install
separate headers, we could be clearer about licensing.
An issue with all of this is that the tools/include headers should
really be hermetic. This isn't true today and may be an issue for
moving linux/fcntl.h. The usual failure with non-hermetic headers is
pulling in linux/types.h or similar, from the system, linux or
uapi/linux and then get some mismatch in expectations with say u64 vs
__u64. For how silly the code base is today see bitsperlong.h that has
23 header files for essentially "sizeof(long) * 8".

Anyway, Arnaldo has been moving to reduce the number of files in
tools/include to avoid touching files there that then trigger a full
kernel rebuild, which frustrates Linus.

Thanks,
Ian

> --
> Florian
>
