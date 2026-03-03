Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DFA314D1E
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577325; cv=pass; b=mPfbz4XY4ronVngI1aTVjrAxlTDc23iejWSohHZo5ai97cIDVim3HDvW8BpHPgF5GNjET2Onqa6QrtDH4bC9PsMSLc3mQqUnjZAcQzkzjEwYYLJTq3z2w+sN2N53psvS3dZ56jaOWeWPi7ANoUZvPXrywoi3zP9cX7Mn+KHEetw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577325; c=relaxed/simple;
	bh=b3aDJi8f27z/0jU8fIz/hP20uA9BX+5Zrfu22n+/kS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgobetY0Buh1XZiRqcLDn6uN0KGJ9WcwDGOzquAr+EPqLEbe0RdUDSixWdMx361EpgQ9l5XRd1UZglLKyGPoXAcztRZVr7r1CYd4QBjO8U/ZYzVSOdSnEmwUHLjgrS0ggJugMBDnaF5P9Q6UVjkxnxss33uUG9kPUkAEtnQtEno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXFNWBmp; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXFNWBmp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae4b40999bso116525ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 14:35:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772577322; cv=none;
        d=google.com; s=arc-20240605;
        b=MeM4jOXcTX+lga0EGdGa3xUl5Dw+MNn9qqKmVbbWzYDoPVvpR8Auuti4o5/hzCMOYd
         vXO4/sYwxu/BXsfYYrohc/dKFPsZ5azoPw6zpEUVTDpi15Hyj3RghJ0Ch1MJl2wnc3cA
         GEU+Oki+FJBr+7g1BTjBHaWJ7wA2cm862xh/TKYjGlwmYOb1atuQsS4Kl2GP2r4ExZJg
         PN3VkNBdYT4F0OKs9XHITMUZtMBytx423mY5YcSPwXfm/akgSZIOYIA1edyluMMnqF/G
         PGyyxhLGpgsge4Disf1loK8hqvLA0ZuBnUKtrvf80mZnG1kg7yKCYvZarECnMiP4SiCF
         bJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XhNPxd/kf193bDd1RtmL72X8SSxkMwFOWq9tsP+bXtU=;
        fh=Ws6VF6Js87TvrD1/M6kcaz5NsK+7BO0n8ieG2i+4lxs=;
        b=JW1GQ9JIEXS71pdS3EFbxOCorkMVlX1Lrgy0ITgsh0nI8lTEUdADx3CwiDV5/miRjU
         i48TfrKbUunJhRcKFYcZ+F21PRY/Hf2fzA25Ag+D5L+Vr/L/i2YiFVh1abNA75js1mTz
         Fad11megoc0uYszzCjJFPwS/X7YIgt+FYdWruBnNlddDEo1J/wBSAw0ygGSIJNijDXuK
         q4kWD4c2oj6z9tmH9+iwcGCOktsZgKS12UzW4yZC6pYfc5KPYYdlgmdfT2WGpwVHflJu
         BJ5JAtImGM8p6tvaBJGvSDzVlEHnfXvsgxCiIZi7bnJH5xDDlYJOlsnp+ug2dmXbjJS9
         sfCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772577322; x=1773182122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhNPxd/kf193bDd1RtmL72X8SSxkMwFOWq9tsP+bXtU=;
        b=DXFNWBmpUW83/pwtJ29J9GqH3qeodoDvD89qb6ECQ3c0xhMyBwZZB4yU7W3+cAZ9lw
         S47OMjTN0+nokCORAubyDyKCUxpMXYfDwC1eFe0/+hmS21lX7TseDs5E7cZrBaA6BwKt
         gvzcx0n+YPdBsWYIwGoVAKfX/oTnDvA+heCbcq+MByFmmCSFPU4Ac4j5942S+xC4zmhU
         1O23lruGnEHLXBl5a0lEi1ffyyuWYPb0vutIInAONIUFvWokhZOXH2Olnw0HPs9itlxj
         wup/3wibWhR6LddXf1zxC2xFyJn945pf2Hflv3sv7CQLN/SWr/4UpOwUlJ/51GZJnlT6
         uZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577322; x=1773182122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhNPxd/kf193bDd1RtmL72X8SSxkMwFOWq9tsP+bXtU=;
        b=SvcHQOAcSZNYadHqa4aCC0LhWXR50zwC1pIh77a9M0AGSDRZkYy3CX/bZGGEBv6B7S
         oa7Yz//3RSAFNuyaaRQeiYXn6Tm4CyPyNJlmptS6tChWWATrYM4ovex5XLUryeNw1aKb
         J190PwORZ4egh4dwK6i2PNBidElBi1bqMIjaSJPA/A9iGtLVDPDB5Q4SVPg7mGnm27Ba
         lWYmHgBdMIIA572Eox3o8psoMLx2VVHqN6PeRAytLwbna8cOkEVvINLXn5MqBcVaUmzh
         07AEeA3F3yAvNHyJICEtWB4UV4YitL0NJdZPXdQycKffitSKzTXAHJY9u82zdPaCW+0A
         oK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRbDt2ET0uWr5CKigqDzTbBXnY/Bf2B1fojPdGkcziZsV+c7m0fKm6dLAYj3B4P8OcPQxKrz+1T5Yl5rzffUBb@vger.kernel.org
X-Gm-Message-State: AOJu0YxpiicyMd2f98IPxVpsL+us4fM9rN907SwiCQsdFM7pjOEo900a
	wYiP7H7AJxVWfSiLZqA91F8nRuBW8AMqpbCRWEv/J090bYYTureIhxQZ64FXrQhUm8M5X0F6Y1h
	yehGLIsrGEO1pw/rlFeDliGDLwKlWtFfD4ulEM4Xt
X-Gm-Gg: ATEYQzzY0/9x8mfKVhaSVaBDdE3f3e74VuE7xs7bWsST/W6jrYusPAElbZC/Umuj9/u
	VD8jZDPSDlcWag6mgMdT1Lv4EnFrnowjaMpAffhDOLTEmfE5FewINInd45P0I5aVeTbGr+urdHI
	L4DMkoftq/wwkzDbGvv6bg9jg3ZGUFGaVT5SCQ2r18rFWLCrnMT36xqcAZzIXDmY1nK2oI6AD05
	vPKeagAKkd6Ks2rHZVYFkwbIwRvA2HiLccQhiJDjMutP5XW1i+Ri+9EfoGCu/gKp7+MwiKlIB75
	YhESDBfOFGNBm8G9XY4C4XjSGp9WEjevbPR9Bw==
X-Received: by 2002:a17:903:3903:b0:2aa:d604:62f3 with SMTP id
 d9443c01a7336-2ae397254c0mr8854995ad.10.1772577322008; Tue, 03 Mar 2026
 14:35:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303211503.165337-1-mmayer@broadcom.com>
In-Reply-To: <20260303211503.165337-1-mmayer@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Mar 2026 14:35:10 -0800
X-Gm-Features: AaiRm50bNGOsugzM61MfhFz5a30u8msi-_5LdoLHVdEiEkGxYB0Gl-uiMplAMOc
Message-ID: <CAP-5=fV5yQGGL3q9KB-3-bc+T0ZyW6robVLhskb7aSQ7HV=a5Q@mail.gmail.com>
Subject: Re: [PATCH] perf build: prevent "argument list too long" error
To: Markus Mayer <mmayer@broadcom.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Perf Mailing List <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 1:16=E2=80=AFPM Markus Mayer <mmayer@broadcom.com> w=
rote:
>
> Due to a recent change, building perf may result in a build error when
> it is trying to "prune orphans". The file list passed to "rm" may exceed
> what the shell can handle. The build will then abort with an error like
> this:
>
>   TEST    [...]/arm64/build/linux-custom/tools/perf/pmu-events/metric_tes=
t.log
> make[5]: /bin/sh: Argument list too long
> make[5]: *** [pmu-events/Build:217: prune_orphans] Error 127
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [Makefile.perf:773: [...]/tools/perf/pmu-events/pmu-events-i=
n.o] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [Makefile.perf:289: sub-make] Error 2
>
> Processing the arguments via "xargs", instead of passing the list of
> files directly to "rm" via the shell, prevents this issue.
>
> Fixes: 36a1b0061a5 (perf build: Reduce pmu-events related copying and mkd=
irs)
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

As with:
https://lore.kernel.org/lkml/20250728093153.2330009-1-changqing.li@windrive=
r.com/
I'm not able to reproduce the problem but the change makes sense.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/Build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 63c65788d442..dc5f94862a3b 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -214,7 +214,8 @@ ifneq ($(strip $(ORPHAN_FILES)),)
>  quiet_cmd_rm  =3D RM      $^
>
>  prune_orphans: $(ORPHAN_FILES)
> -       $(Q)$(call echo-cmd,rm)rm -f $^
> +       # The list of files can be long. Use xargs to prevent issues.
> +       $(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
>
>  JEVENTS_DEPS +=3D prune_orphans
>  endif
> --
> 2.52.0
>
