Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614814A2A40
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760529; cv=pass; b=Br1g59Ut6PvJMSzpWvL825Be/12qyTO6zZ3bTMtuP42SAFb/jh0+7/xrrfM6Nim7FIQranELFNnuaFr2wm3lff3GVc9AMDbdj1vTCeA652SkCb2RmQ1Be8mDI8AI8uA51ew8cu9H/eYT0Q6LlWpuJPfaN1GiQXj8D4rul2865Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760529; c=relaxed/simple;
	bh=FciYpfzLKANxNupwU3w7Epq7qWdhQfQ2fn9tImiDYOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kL0ymGMWszMVaT76XIGOasMvm6d5nXEWDjk4SKJfrQb7j8FME0BLADi0VAHhCF9LfbhZExlVrk/RwqF1gTkj/Zsog4uTNfLLKuGUSJhdj3HLs6aXNfzA7QczDs8RC/vluS2Jp/LC6D/NqT6EstHTTbkpUdpA8QLYHp0GBc9BrI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUGoa5HU; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUGoa5HU"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53113d72966so55361cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 12:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789760521; cv=none;
        d=google.com; s=arc-20260327;
        b=Ifv7upLSqvM7IDyFHvoPu+o6ixRBfFCPhyhjUecXmMluMIPh1zqNkc1E8DQFgtZC9M
         Vj/wQ+RZBGzr9v2NMLfd2/BawMaqzjluDZUp0I5qWfrGNXLiVKu79Pwm7CiI+IrNRnhi
         mLIdQjcAf3XSYjepy00ulv+jvK5J9GGx9ceHAbcJZma6x1nu10mjj0JqRmTciBsoLTTa
         ujAaQcc4s9NjpxklsYhAV721nwg722e56hvnRA/OV/ahJzVHHmewIxRxPKRqe5DdaTgD
         W87aH9EEqDAsKYLNoNiqxQUSkmOSQC5PHzKRwc3C+tQXeW3KhYlnP16Jz1hxBOR9dlpa
         Eqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TCH7p85Cm7cElO31LspfZMTcJ2Lo8qhjOuojMqh9w6s=;
        fh=Xorr3jZ4VahGchAe7FKKJI2gXJbMSGgyVd3UNUqo/1A=;
        b=EI6zGcFAXJpjKxfvT8Lt9TfCWeVgSW4lfrjAMwQcNItbTSSLhHDp+TEA+W8sQEC98V
         c+SeujeqmLvRDSmqbKNiL3e96Dz+X6CgpCPOqFZSPjlub4gLppMUgrlU42mZtk/V53yM
         +twLimtpHFfeB8KzMJyzWg1/WqWOp4k4scm/Fqj2zgBqK9bV3EHG8dQFkZsOSRVHuN86
         CdOAPwCQ+Q8GcycVk0jzKXKV7JAvXpPxB5Q/YQ9MFoQJz4BuzS9jPAjUFLKksvGVdtWK
         ZTGGwtjaIsnjAFzS/gutIBoqEEmrBkfY30AjVEoIBA498xLZx+bn1xz3Aml23vcbkyjO
         L3IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789760521; x=1790365321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TCH7p85Cm7cElO31LspfZMTcJ2Lo8qhjOuojMqh9w6s=;
        b=jUGoa5HU/vNuc8F/pwa+jvfY7AybeMM5t7s7Cz0jArL9EYmw8nCxDKpwEeuccvaNwz
         /SWjCtI8aB/zdRdYlVX/4jiRK0LpmDIUbnQmbayzwHpUfHae3xEwPebCcvrGpZCnqWbJ
         7vBV6YLHcTJGxUFWYBXGUo5gEOX0LoyLT9lGYqRGWMQgT8ULaz7Gso3azB0+vIcUCHtQ
         f8ro7vFYNoic3XuqODB/3KQS5OI5YgSX8sIrcyVNj0BgEuhLlUCwpnsLnphJfgpcDMps
         aYhHMqEbH4TwJ2eN3Wvil+kpFPhgtXGBv45ev7lIVG9ze7zVSKivnUMBBJx/k2tqYnI/
         CmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789760521; x=1790365321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCH7p85Cm7cElO31LspfZMTcJ2Lo8qhjOuojMqh9w6s=;
        b=ez28M0XwNjJa1HfXXYaM6+3fSIwjl0q6jpqmOJLbDyl6uq0GXRLHnvbIJhYP72pvgP
         JVxkvXlP5H8FNSDPV75rOnxNHnCwx3M+n90hhIV0HGZkX4R0ZyVl22Xr5jH4UxT2B1gm
         2sNChzrfWwtgWOlBcVS3IdtXVXGQMp8mibeHFEHGcI7aiFfVCwNR7HijrFtW31nQZyBK
         bWHU5QdbXSGD9S9/v3hLYOYUeQkOleImlzGT/L4gMS9b6UsuDPaEAz3g0Y7URg43gxZs
         oC6oeUBu1ySMPNyv18wRlIkhi618VvOlg0cnwmALcXtez0q5xZlG7lxrcxofacGVDaXP
         Glcg==
X-Gm-Message-State: AFuF++kSTL/7y37AqR5V4MF2d1IGzOS7ubyC9JzV1DcR3HWrebnKudDk
	+MPoUxqF89WZPaS7fcC6W7ZBciMpH0BnJTtUbgDKaaD1OnwFOx283KEe4pxd48V/KvH/Fikv2Z4
	4RWl/JksunW73W2Ymy6ZuqU15E2KPDcS7ur9TMTMQ
X-Gm-Gg: AYBFou3l63CHRtaxRPUpLRFDKYJKcDMsgt29YJU3sTfYpUuaJct6KvSsSyb02eLdXfJ
	yaaoQIxcsBbGS6Op0IU9aontxUad5nn3r0MrFePSLbGEL+Y03rvU/lGnRt62g/VqJ3UZkkIJjhX
	VlmlI5K4NN4qJWqiJC1oi7xt7EXuv5rjEiN+sSOK0LdoePFnC+1lXO1S0Iy9uqH/ZWZDulBv+97
	H1ZLUNBoIwemWFOfZy/0HwM++c7SC+UPmKDno7K1llK3v/IxuRCVlvsswW3dY6ehmP1uJpgD8eW
	Yy4GP41WISVAq5kp2GmxRq1HQIwSjEV16olnqMdTPXCdvtH4CuhYcrKb+2qPQ80pQoWm+4K7gzX
	GcGIbj9N0K+k=
X-Received: by 2002:a05:622a:4c16:b0:532:9cd6:2184 with SMTP id
 d75a77b69052e-532af5ca677mr3511171cf.6.1789760520919; Fri, 18 Sep 2026
 12:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aq2MQLKmyrxkFd0Y@eldamar.lan> <aq2O42fwBRdHELBC@eldamar.lan>
In-Reply-To: <aq2O42fwBRdHELBC@eldamar.lan>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Sep 2026 12:41:49 -0700
X-Gm-Features: AcwNN1Xo9CcFDvMIoZjCpwlNo4XAEGxqbdgx0v6feQC5GXfhUVaYP97hIbvrbVY
Message-ID: <CAP-5=fXL7comAJeMbcWKkT=Ju7NyEUFnWfTvY60SxsSeazWDLQ@mail.gmail.com>
Subject: Re: Please backport subset of 2f5d370dec3f ("perf test: Change all
 remaining #!/bin/sh to #!/bin/bash") for stat_bpf_counters.sh script to
 v6.12.y and older
To: Salvatore Bonaccorso <carnil@debian.org>, stable <stable@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 12:20=E2=80=AFPM Salvatore Bonaccorso <carnil@debia=
n.org> wrote:
>
> Hi,
>
> On Fri, Sep 18, 2026 at 09:08:48PM +0200, Salvatore Bonaccorso wrote:
> > Hi
> >
> > Recently for v5.15.221, v6.1.188, v6.6.157, v6.12.110, v6.18.52 and
> > v7.2.6, the commit b02027776ac5 ("perf tests: Fix flakiness in BPF
> > counters test on hybrid systems") was backported, but it introduced
> > bash specific syntax.  For versions after 2f5d370dec3f ("perf test:
> > Change all remaining #!/bin/sh to #!/bin/bash") aka before v6.17-rc1
> > this is not a problem.
> >
> > The proposed patch is a stable series backports specific one, as one
> > cannot simply backport 2f5d370dec3f ("perf test: Change all remaining
> > #!/bin/sh to #!/bin/bash") without picking as well some other context
> > related changes to make it possible. So I was proposing to only change
> > shebang to #!/bin/bash in stable series were it is a problem, as in
> > the stat_bpf_counters.sh script.
>
> "Obviously" there was a typo in the commit message and a missing
> explanation, thus v2 of the proposed change as follows.
>
> Regards,
> Salvatore
>
> From 804ae26dab32c846467d7b7887d8f7dcd3348fa5 Mon Sep 17 00:00:00 2001
> From: Salvatore Bonaccorso <carnil@debian.org>
> Date: Fri, 18 Sep 2026 20:48:59 +0200
> Subject: [PATCH] perf tests: Change shebang for stat_bpf_counters.sh to
>  #!/bin/bash
>
> When commit b02027776ac5 ("perf tests: Fix flakiness in BPF counters
> test on hybrid systems") was backported to several stable series
> (v5.15.221, v6.1.188, v6.6.157, v6.12.110, v6.18.52, v7.2.6) it
> introduced specific bash syntax. For versions after 2f5d370dec3f ("perf
> test: Change all remaining #!/bin/sh to #!/bin/bash") in v6.17-rc1 this
> is not a problem as the shebang was already changed to #!/bin/bash. For
> the older stable series this introduced invalid syntax if #!/bin/sh is
> not bash:
>
>         $ sh -n tools/perf/tests/shell/stat_bpf_counters.sh
>         tools/perf/tests/shell/stat_bpf_counters.sh: 12: Syntax error: "(=
" unexpected
>
>         $ checkbashism tools/perf/tests/shell/stat_bpf_counters.sh
>         possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh l=
ine 52 (bash arrays, ${name[0|*|@]}):
>                 base_instructions=3D$(perf stat --no-big-num -e instructi=
ons:u -- "${workload[@]}" 2>&1 | \
>                                         awk -v i=3D0 -v c=3D0 '/instructi=
ons/ { \
>                                                 if ($1 !=3D "<not") { i++=
; c +=3D $1 } \
>                                         } END { if (i > 0) printf "%.0f",=
 c; else print "<not" }')
>         possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh l=
ine 57 (bash arrays, ${name[0|*|@]}):
>                 bpf_instructions=3D$(perf stat --no-big-num --bpf-counter=
s -e instructions:u \
>                                         -- "${workload[@]}"  2>&1 | \
>                                         awk -v i=3D0 -v c=3D0 '/instructi=
ons/ { \
>                                                 if ($1 !=3D "<not") { i++=
; c +=3D $1 } \
>                                         } END { if (i > 0) printf "%.0f",=
 c; else print "<not" }')
>         possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh l=
ine 68 (bash arrays, ${name[0|*|@]}):
>                 stat_output=3D$(perf stat --no-big-num \
>                         -e instructions/name=3Dbase_instructions/u,instru=
ctions/name=3Dbpf_instructions/bu \
>                         -- "${workload[@]}" 2>&1)
>
> Change shebang for the stat_bpf_counters.sh script to #!/bin/bash.
>
> No upstream commit exists for this change as for versions post 6.17-rc1
> the scripts were converted to #!/bin/bash already.
>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>

Reviewed-by: Ian Rogers <irogers@google.com>

This should have been caught by the perf tool build as that build runs
shellcheck on all tests when shellcheck is available. Maybe there
should be an action to run perf builds as part of the stable backports
when the tools/perf directory is touched.

Thanks,
Ian

> ---
> v2:
>   - Fixed a typo in commit message: hanged -> changed
>   - Explicit state to what shebang was changed for stat_bpf_counters.sh
>     script.
>
>  tools/perf/tests/shell/stat_bpf_counters.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tes=
ts/shell/stat_bpf_counters.sh
> index 76d4a7f15a43..c4f71bfc0fc6 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # perf stat --bpf-counters test
>  # SPDX-License-Identifier: GPL-2.0
>
> --
> 2.55.0
>
