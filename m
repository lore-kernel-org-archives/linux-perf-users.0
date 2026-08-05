Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83B3D47A9
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956998; cv=pass; b=Fqr/187LRJ/Dtb4MoI/FCjmERgVnd/VXU6zaPq1bF0gTyvaVNLZehNdP8/NJVye2aI54k3qJKxscLF9DxNBZnD4PzMqS9uHWgLBj3mIFi3hr6VmJKcomWCwj35BMmsG1yTiXbGVIrc8xv+GZKB4Pn7QmwDAVWPRqielKnxIjqGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956998; c=relaxed/simple;
	bh=QaNZ3TmDrYsiDfJMYIgG6rk8r1nUb92NIih27YuCBHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRISVk0CX5pE9m3Lvts+rk4e7m3lHapPnK5QOE7Zs7ciUGarrau+IQm3vpCCYc2sd3doZQAvOR2Do0RAkqXAIXhRlD2gE+ky80pmo5Lbs3kNPMh6i4MsPeAs7MQCYsp5+wVw/fderGKWkpjajOEECm1NWb5KmC8vibVIDn7osN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYWUrkLI; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYWUrkLI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c10e86e52so44801cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 12:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956996; cv=none;
        d=google.com; s=arc-20260327;
        b=HdAvvunGUlF1vTL/URV29LBBJVkFcU0ypmLenuGS08CNkPayJNEYZazqWv3ykCnHbu
         yjCOMJRMxmANl4rdAtY/vWZZJC11GxliopGfw6XRNr++5W3MJHJ4n9lJR6nEVjpxsCD5
         KR/ctjZnwI+wHiefkglRNyXcJInyvNkj3aTwOtwudkZ+diNoqb8foT3nJQOQj279lSz0
         W0juAbCvjYpktz73uIHaWBwttGhHL/lfQd3zFOXPoCZYTVgDm3CFUFDtrp19aga3Balm
         kzqy1Yxoo//YCstUVAabFwpby25VbE50MHm8zjdHhZMTCxbdsPKZfkWcFptrM58mtvlM
         91IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98SegR+opIid+fq9df3a2wTbXms034xkglf2ODo1pK4=;
        fh=e49oAlyiXEDGdGKXBcOpMmIMTX6F6tRiAbmfNn2cnro=;
        b=rWvNdA3eijLHALAA72IJSlta00opnpRcypwx1gIAKNC1SKLeRON/Q0lcTGiCDDP2d1
         yD7burWzmtbQb3Sr9wVQzXgOho3Kjavbi8RCDew8dKDL9wjoY1BFnJ6z/ydZ+hK6CRW8
         S07EU+OouiRkgzQixBLl2lBtVG8aC3hq/+w7na5q5s25dbFX5wWKsuZVVeqyg3/o1Fjv
         HBKf/ZSZuJsjm8q8KIiPoQ1KqqowTU3qvOfDcPzNU8q7LbiPWkN2jqi+cBixvW4uUnO7
         cnOVIlkwym+gMMDgFdOB2zD03dBNiX839wublELyOQFT+kU2TMRXW5cdyrI7MqqgDS4p
         lC2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785956996; x=1786561796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98SegR+opIid+fq9df3a2wTbXms034xkglf2ODo1pK4=;
        b=lYWUrkLIxGf7JVKx0Shz42sd6iJKFfUEgvWXcExIkJxs+sRzrt/uS/IxgOMTNBfGpL
         BYANdNFWjMnB8X07jxy8vB8eu8azXxnjHxzzcrs3FBpr8RuEdu8IhdjUxCOvtNpWydV+
         CVEcqsGUqRWg5pY3zUpobtz9vgy1WZ+sMwAgxLX9cCK4P08kHX2GhiL6fs7ttEHcpklC
         /Iv28h3CNeqDExEnObTlg/6pfzTwUbAjuHy6T06jP05Fv1EeyVqdeaQ40H4LTZEN2j2g
         4hdW5Y06OCi/imRMsY8/T/emYFA9Gt3AfHG1l3H7zbtNXg6uOarc5z5PuN6zBayQEKHX
         y9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956996; x=1786561796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98SegR+opIid+fq9df3a2wTbXms034xkglf2ODo1pK4=;
        b=qqhRWa2OR3JtPPgOH0A5IJyayjOnPxd8vGCyWlzz8RwwCRaOtMWxqDKex2curYBEAz
         gpP2dJqzVFmocFTkRTgPJ7naMwzTKCYhQ1FDvWfJu/l1+aT57TVZTlCzNlmP94bBmMW5
         URO6nwbLD7UfiZxrbgDOLwSZ0MVdY6Ty5MJMqvDl1/i2gFEhDmOMkoB1FtkSUqIBwdRW
         I6i3Ymq80zLAvHbllkTI3zM0TjbPEUAGgU6ZsvYwQ2s+3t5HbFbp1ALjiRYyPBylgfOC
         AwPs7G8kAe3Oh1o8D5qOjRlGRHg+22yJiSZPRXIPDKwyJigYhLNJh8b2Lg4gn9c1HEL6
         kqYg==
X-Forwarded-Encrypted: i=1; AHgh+Rok1O1XLavJwtIMXRfKVT+R63Cyzxw3/CPVVMzPyCVYuSh78BVb8AOlFWaBoO0X28wFVFESwT8uLd1ZAP8HpKbm@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+JoP9E7V/yVoRlf1H92M0hahUTUQ4hPgx/Uwm3ZCSkQe5R2m
	mPmHiN8LpBUOT4yTosnQxoONBQZQjCakysv8v1w4bllwT7U01QnFh/Fj65CF39CT6vmW4yqhF1u
	rVMfBE7vdOTHZvBzJR4slF5a00tV6mG5yefTYnwCc
X-Gm-Gg: AR+sD13ul4Mm/QrauPJAKCrepbTobIoNpIG90AckMaSOb2jmB2apMm6LL/AfAV0Whbb
	bChdOAsa8cNQNi2u89qKKMj5EAINCXdvm5CtwZAivP5YE8mYy4m9/NkCAV4jdG3aI8gfAcxKk8j
	euZ2u4gIol1lPyoQ9I/u4v0Y/FlV/Y7vTUqq7B5iRQqXSREQFbo1SQ/4fgBRCq6yoSYiZsdu4I9
	ZrxWMH1jpSpC2vpwjepKcHCYpj6os2FY2G9JUUA3nlEyi9u21M3x/199xj4I2urZ9+amCcJONal
	3BMXIaCbfbJfNf1lFKRzKcR7bDYZdMrmCbLOOJnQywXJmTPjbtLFSrGu
X-Received: by 2002:a05:622a:400e:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52cfc13ee84mr3183451cf.13.1785956995597; Wed, 05 Aug 2026
 12:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-8-acme@kernel.org>
In-Reply-To: <20260805133013.235016-8-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 12:09:43 -0700
X-Gm-Features: AUfX_mwoM4NvD0tj1nTYkv2OZPNKLgnM5opxz3y-ZgSKf2TkxGfZD-u00Ad73A0
Message-ID: <CAP-5=fXUpKnWQburVtz9pCvoyUP4_tJFccDhp3JnW4QZ8TiP_A@mail.gmail.com>
Subject: Re: [PATCH 07/12] perf jitdump: Free event in jit_repipe_code_move()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> jit_repipe_code_move() allocates a perf_event with calloc but never
> frees it =E2=80=94 the 'out' label exits with only perf_sample__exit().
>
> The sibling function jit_repipe_code_load() correctly calls
> free(event) at its out label.  Add the same free(event) to
> jit_repipe_code_move().
>
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/jitdump.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index c3f11d1c1d76d6c7..4f52b143cd0da296 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -683,6 +683,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)
>                 build_id__mark_dso_hit(tool, event, &sample, jd->machine)=
;
>  out:
>         perf_sample__exit(&sample);
> +       free(event);
>         return ret;
>  }
>
> --
> 2.55.0
>
