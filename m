Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DA346FDA
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111393; cv=pass; b=fm1dpNamrJvIl/8eEb54g+tl3Ay3lU9TXZrKIqrxW+amwNZFvObDH4Ie56vseRARFvWdNdIyXIHus+FTcrKLN1bucqtg95wOM05vsEo36vdg7r11BPpqZN2nGj0e81Or/GcDPSPqUnp0oQJ21GfCDCB+qpHTVtw4cydd9bTH2H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111393; c=relaxed/simple;
	bh=m9RegbNqcRLzI9ybYpxjWVdj5WlWfSwjL6mtaONC7Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+SsH2NCyOStDkPFqpm5ZokcaUW9s41c8hTvuoEWb5AJccKW9cH0jsJpKPxHzOHdcCF/Lt+7PeOwpAIDUToue15ynNMrJ+Qbsy5+rx8zetJotLCxEghL1T1qsbgBIh255+1qiabIpD4SkNLBpOyuH0M9n5y0jcZylz1964uXZ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCba/0ev; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCba/0ev"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2d865383so4985ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 10:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781111391; cv=none;
        d=google.com; s=arc-20240605;
        b=CKJORo4V4yMTgnRmxT158ILBgoX6dLHlmvvBB6XKwZtZPHmaugH92CTSbQIpx4WL7y
         0Er6BCSSSeLFCRsQ1SYNDrxvhYv04xBs2cdMH9U4+FpWgr+49MYUK5KgR/qT/ug3EvRY
         h20lKiL0uSU68+60cjR45yfM0cvRcC4C1hvh7zjFHgujqJ8FQ3hX+jl4XUP7Nj1tEo7O
         8YA5mG8t6vOeCekhgOU9c93r2VYvrcX4gmM/cvMzfet+ayOUIl2tWv7oErcgud6Fiocl
         7cvDuu1RumxProx2NAvAEsYjmlFawEXmYd83n52XRa9bZdE6NAE/f3syHubGtvCdF5d+
         KjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vLzjLyziWygrwQcvyuw1Y4NpKopNA8D6FnsGf3f95Ic=;
        fh=qHJjaYxrzI2qUByWHG0Qa4UQZgixjWn30bjtfrl2VeQ=;
        b=Bc5ANcs36LU8z5QMU/x0esTQASDIrKeW9UTM5GIxHi+05qqQARsWlGBbXlT0GgrrO4
         ZFtC9KMLbdi3qfYjbxzC44puiAE7ZFdcQMsy/VFuNvR+f1GmKSbg11qfBtAclT5CGBOt
         24XVfGfhIKMeHZH6u8hIe8pP0zFShVfr1MIy4FLzEfUoovKL3xHVvv9Un2irR8cvbq8x
         eBiKcGD+RXi/EXw+N7M0PC+pAjdZfS4LSTvz6Ay53hQPXB/knlJzeqIHLj6lTm4AltM4
         nndHQo1S//szENGzhob1o8H8q7NffA2sil58ajGg/xRfvAuWNcwaSu5jw4d5FLX6mTN+
         +83g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781111391; x=1781716191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLzjLyziWygrwQcvyuw1Y4NpKopNA8D6FnsGf3f95Ic=;
        b=QCba/0ev3ZnJ+DZBBFZY3+49atshH0lFKGWgVhPydB8TXNSMwVjs8naH0hJt2Ujjs2
         8MHELP/o3T6ey1BMDXf55JZRYUDPHD/v037PSm2s/xpTpqsqqIsTb32tF1Do99AyarLV
         lls1nWcdWzmNtBKKZanNuC8cJJPzEphETdNAmpSc6TfYGNmDzjXN4U7DxWqee8p/HQY2
         w4qcfCyqUzazhjuJgC1jNMLIfH0kAtMLOxnq5gNu0UKhFOCfHXS2rT10XXW9DI2UxslM
         k3JwP2R34sKD8PzhSidjGgbM7AlVyigzk8CEuRyAdFSOAJIVu1RHvAyFWhJvRAraYK9V
         ueUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111391; x=1781716191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vLzjLyziWygrwQcvyuw1Y4NpKopNA8D6FnsGf3f95Ic=;
        b=Kk2cwm4Ev+dyAWd/2zpbH/5LaP5YuUIVVIqVfJW+QEJMj0Dom8lKXq3qzAAkUC1uPz
         vIWpgMuDKBK5D2nFiD/lMqagnvgdYzfwAxuwN9UpjaWcIk1FyK3S/LUAOzjYzKmpcLzu
         x5/KRvpLT3YYuWRYJF2g6KkNx1GnSAZkoTOGS/BrfKAPX5+mD3EvoIOQtjzDY0MkWqOw
         VhFzgDvUXg33rIlSqoCjxpy0v22vjaFg19pPJ+jSGIDpPkJFRBraZBYyXUTUQElH82xz
         JN2jpV1u+N3xPOGxoDRPB+JiO0gALGt/7tK7bW4xYoloTGvOH3e/sQ1lrVQtWx23aRUi
         qLMg==
X-Forwarded-Encrypted: i=1; AFNElJ84oNNPHq5wYlsbII/7L3aipecAB1mZQHLVFIQwIJs4jxBhjRatChdRIP2/pHunPIw8moxKonDXI5rId/j3NQtu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vaJ4KCQnjs9i9BnhyHuYWd2G6jEO+E/KRcVjUkScsM+litmG
	+DyiPd1uMxZPmTYAmMDiLDA2z7rxQfUhFctT8L5d1OmF6VLSXz7SaRVR2/QLYNI8VccRJnPdGsg
	ikQ/UsR0Fvqn90R3PGfDMA7aZppCGXmm6Pz9mugxO
X-Gm-Gg: Acq92OF+DrzwFiBWbm2zsd7POCNnG6JcdK206WryzeAKRRvWhh5Ckd0zROo/8PgPnQl
	YlN+nUwjXPiJNc+YYM8EeA9Bm6gH4h7RfXipE2HQirXy54X4ZIUrz2CLbVFvRiJKsLBQRGyEoqP
	NREDnZ/6GG+d6sqyZtI/mMUdX+EtepcXBHtm0FWRx/7X6L0/tbCJo/XgUM2tG7L4x4SF7RXhcPI
	sShV3QcreED7NLvxVUfSCbpgbYR+TRkMxoejk3XZv10u41CeTV6N0XNBW8i+g9q4IArD9amfO3v
	cG7LpvoTdTXbftwszgPxzMsyKDrdjriAk2bEMYYoTgtMG5Oh
X-Received: by 2002:a17:903:2c9:b0:2c1:ee6e:be1f with SMTP id
 d9443c01a7336-2c2d9571df9mr395405ad.29.1781111390345; Wed, 10 Jun 2026
 10:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610165207.2077258-1-acme@kernel.org> <20260610165207.2077258-11-acme@kernel.org>
In-Reply-To: <20260610165207.2077258-11-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jun 2026 10:09:38 -0700
X-Gm-Features: AVVi8CfBMwsUrpZ1jIhF6GtlLNubC6ACCIjjThKVuh59pBlV06XHP-b7M-W6_sY
Message-ID: <CAP-5=fVd=pi6bf8BscABmyEDTDFjFzEJ1j7K8mb_hEv8mr7Ecw@mail.gmail.com>
Subject: Re: [PATCH 10/11] perf tools: Use scnprintf() in build_id__snprintf()
 and hwmon read_events()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:53=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> build_id__snprintf() and hwmon_pmu__read_events() accumulate formatted
> output via snprintf(), which returns the would-have-been-written count
> on truncation.  In build_id__snprintf(), this inflates the return
> value beyond the buffer size.  In hwmon_pmu__read_events(), len
> overshoots out_buf_len and the next 'out_buf_len - len' underflows.
>
> Switch both to scnprintf() which returns actual bytes written.
>
> In build_id__snprintf(), also tighten the loop guard from
> 'offs < bf_size' to 'offs + 1 < bf_size': since scnprintf() returns
> at most size-1, offs never reaches bf_size, and the original condition
> would spin doing zero-byte writes once the buffer fills.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Fixes: fccaaf6fbbc59910 ("perf build-id: Change sprintf functions to snpr=
intf")
> Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events =
from hwmon in sysfs")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/build-id.c  |  7 +++++--
>  tools/perf/util/hwmon_pmu.c | 12 ++++++------
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 8c0a9ae932aa5798..eb95ab90f9741d5f 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -93,8 +93,11 @@ int build_id__snprintf(const struct build_id *build_id=
, char *bf, size_t bf_size
>                 return 0;
>         }
>
> -       for (size_t i =3D 0; i < build_id->size && offs < bf_size; ++i)
> -               offs +=3D snprintf(bf + offs, bf_size - offs, "%02x", bui=
ld_id->data[i]);
> +       if (bf_size > 0)
> +               bf[0] =3D '\0';
> +
> +       for (size_t i =3D 0; i < build_id->size && offs + 1 < bf_size; ++=
i)
> +               offs +=3D scnprintf(bf + offs, bf_size - offs, "%02x", bu=
ild_id->data[i]);
>
>         return offs;
>  }
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index fb3ffa8d32ad2a93..dbf6a71af47f9a42 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -442,12 +442,12 @@ static size_t hwmon_pmu__describe_items(struct hwmo=
n_pmu *hwm, char *out_buf, si
>
>                                 buf[read_len] =3D '\0';
>                                 val =3D strtoll(buf, /*endptr=3D*/NULL, 1=
0);
> -                               len +=3D snprintf(out_buf + len, out_buf_=
len - len, "%s%s%s=3D%g%s",
> -                                               len =3D=3D 0 ? " " : ", "=
,
> -                                               hwmon_item_strs[bit],
> -                                               is_alarm ? "_alarm" : "",
> -                                               (double)val / 1000.0,
> -                                               hwmon_units[key.type]);
> +                               len +=3D scnprintf(out_buf + len, out_buf=
_len - len, "%s%s%s=3D%g%s",
> +                                                len =3D=3D 0 ? " " : ", =
",
> +                                                hwmon_item_strs[bit],
> +                                                is_alarm ? "_alarm" : ""=
,
> +                                                (double)val / 1000.0,
> +                                                hwmon_units[key.type]);
>                         }
>                         close(fd);
>                 }
> --
> 2.54.0
>
