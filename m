Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F484D1798
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007687; cv=pass; b=hN7D3J9iq5ocbXW9YA1vSIG1qORA5SA5NNDYFdUZB+czaZ1ZqZr7qnBNn061I8QMmJMwh6x+aGD5mDIMq2nOgsmmR32oKvNv1duYsV/jDnsFLDbPokewWmXXk08EqlSmJCpQA3bgpGor/XqPrIi8J2tsCe/jd28JGVen4Gp1EG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007687; c=relaxed/simple;
	bh=lwo+qtgHhggI0M4y9uJX2oJZaaSUrOh3zbbAT36q7nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6M0d7KOsASKjUMpf9HKtQMVTxxNTOItDLtqEvmhBMbhwbZnIIETu035VDZUa/RLluEJkS8Y1Y4uleAEKQ+L0amcGSeI7yg032/yZFVdEQLDucudfdOfUAQaD4P/UxhftssO/0hGzanql9Bmsce1suBjSTP+vdS5axLPedf7mIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxFJ0P8T; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxFJ0P8T"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-530f6bcc301so397781cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 09:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790007684; cv=none;
        d=google.com; s=arc-20260327;
        b=TcwXHlGUtxFIbO65eOZI2OfRU5kAIY2hXRsFMcvxIligAkMIMBUFJWuTFUstfkO+ik
         O7jDcatccMTA8NfPD7+gb56M531CZ1y2JfMgXbcR2f2q+Q3d3KyhtL9+A4Cki0zlXCvM
         RUKOUcQ3WL+DiQkf+WZ/8BUloA2G6hWpP82ubpdhFOfqGZrHw463BVJMjkMorOgNhxiN
         d12ohXKm5IrXD+TgqBZ8AGpFa+uMo6nGGUUqEZ7nz3BFKvcyv4SI5tWv0iIGPS/sOhXc
         U3uq3M8NQW7wYwXLdD3HocHim1xHN7ojsV8YKqRFf538dmeJredhtz9kgqv9OBtYC18S
         QQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xk7Q0swZ4Ds1t7boohhglrST5MnHaW9AqFXnNH+nuUM=;
        fh=ubtuAYW382fTvc3MPlvY9fWFvC3eq+lMXYtzVKqGVRM=;
        b=PopDZxF4sld523qVzigFJvdpt5TECj+oKCM+/0sUXyJJrSQBL5ApoTVxXydkVOfkRx
         bfrdGGvJWvZ/uqkM3kTGAru0oD0+th/Udt4rS3C6m5z8hAdWoi9ZvlJJttyX7eQWhR5F
         h/IPlM4ZtbLh3MCwtSUgyf3jjg/3PAM/ZP2LFMJqXOn3A/odkASTE1FZ/x3a19EYZWyg
         iUon75nfh+MOmB4GzN8kYwRq1WZtnTAZgnW8VINTDFjHeblDFM4XkwxAAl+VS8chgrqt
         Yt/s1BJ4oBUFZ2IcZ4bfgKcKQU7Yjq1rrgoE1co65p5WmbFGcPOCK6MxeNQP6/xkLmEr
         uLLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790007684; x=1790612484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xk7Q0swZ4Ds1t7boohhglrST5MnHaW9AqFXnNH+nuUM=;
        b=bxFJ0P8TIFDaG7pewSOJtdnLL1AA88dO9zvOnGObKsrjRwMqsLGmM+1806ycsWkYjd
         E05kdJ+TQn703L2obGDVfDuhX03YZX1H4DmL8s4uDHh9WcHQ65ivj6nHMxQ+Li1wnQ3o
         qeXtKaDgAx7iz2Mwer1lJUShImgHQ4m3hwgsBSnZB//EkQYMC5jNmUoDUJGnp3EYQNSQ
         S3KsCpdeSuR3wUf/9BX7sfYS1S0R3gTefh7w+PeYrGqfEtp+27dwX8SkkGn7Eyxnr//K
         5jQFnib/k4NjWRtIQvZaGylv42wFZPxy80K3K2v/WsndCJF3Xn3Fx6of3R9w+hsgjo9J
         AJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790007684; x=1790612484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xk7Q0swZ4Ds1t7boohhglrST5MnHaW9AqFXnNH+nuUM=;
        b=uTpLwguGb0pKXTzZltKtJgEiDEmtid3GgRPgWWbS0ev1RxlZGaCTNpCz+z2vNwapRb
         A2GjeYY31EmrLyZvC3HxLmztZrLzvs3NYt9HxxqjPYxlq4rn/QyRMJ2ZPsmqfnTJa1D0
         I6PaNp28yxCPDVTKGhaQ+IBERsHsDKDIRu+2auCkT2aEcMwVQT7eeVd98FmXO+/+P239
         CozIS7hoU4FmOfGjFXd59x5effuKMwC6n8/Lyzkb2hOveUvY2x6SDNercHBVKUnq/5Dr
         5mr7iquGRWQMVfgqpBT6tKI2/+89ZXXUfMN/aCWkCVucx7moi/Gw14sbMN4hA84yOD87
         +rmw==
X-Forwarded-Encrypted: i=1; AKwUvBwgewqa5TtdyaSCLDWosoielJQEZbPbOC0DWOFPKXozFtRsxq3OqJO6SG6MbeDyPDDF1qgJDZ54HiEDljluwZv+@vger.kernel.org
X-Gm-Message-State: AFuF++lUW3dVdRvUU9N4Y6tbDqWxhqLXeOUGugUvNEBW4lQgPlj1xg/L
	FJsgNFmQt8I80QkRLFWOKrsCil0HNlsH7CU8xnyjIA4O1WqJvJfqgLqtSoBLADEWQuOxnsmoBZO
	P7T4cy7gSW674HtRhcnbgrTBUzjFMFEU9prv+KAbR
X-Gm-Gg: AYBFou1WDWWbypNYfCDyflr+KLSwRp9UWdqbiStk4e+/A5WOtlOKM/X/Vvg+sOkwmw4
	WNFE6ifd0DsXIZb1mW4h1meq1YKSu3LHABomEYENEUwKjC9w64zGWnSI2cPPu0npwWBIJw7jYDA
	8FPYLpkIh4kNg7/fQhAcltaa+SlBrdCC0azPEguVeKjSVkLJ6r+9npYllVQu0HM8q9qhk6VFBX7
	JVqNlqc3V8KDaLM2uHjHFJIJOewKTirad6ZNTz7j3K3RzN1iq5dEaYi+WZV4hC4oULNouI7XdMN
	S4GcKTO33MUKb0BGxkfopuHRD2TsO15qy0o37y3tJkNbg9wBXh9SUnrEcluiU2ieYDFbqJLZmAm
	CB0ySivTV
X-Received: by 2002:ac8:5c90:0:b0:532:9d15:2e5a with SMTP id
 d75a77b69052e-532d8d31243mr5133341cf.1.1790007684100; Mon, 21 Sep 2026
 09:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915091112.333308-1-dapeng1.mi@linux.intel.com> <024fd251-a4ba-443f-8aff-f5b1cdb062a3@linux.intel.com>
In-Reply-To: <024fd251-a4ba-443f-8aff-f5b1cdb062a3@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Sep 2026 09:21:11 -0700
X-Gm-Features: AcwNN1WlRuT2junyV5TVza_msH6V6SCAykTC56KHUponUO2k358vwY1g1Z7ZAmY
Message-ID: <CAP-5=fUc_WOHAe4EkLVYuBgvQmxk7_XY4N+v8yJKNJQpCSObHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf alsr: Add missing SIMD handling in aslr_tool__process_sample()
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 11:42=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
> Kindly ping ...
>
> @Arnaldo, @Namhyung, @Ian, not sure if you have bandwidth to review this
> small patchset which fixes the Sashiko found minor issues for the "Perf
> tools: Support eGPRs/SSP/SIMD registers sampling" patchset?
>
> If possible, it's better to be queued in this cycle, then we don't need
> extra backporting. Thanks.

Reviewed-by: Ian Rogers <irogers@google.com>

> On 9/15/2026 5:11 PM, Dapeng Mi wrote:
> > Currently the SIMD register sampling is supported, but the correspondin=
g
> > handling is missed in aslr_tool__process_sample(). This can break parsi=
ng
> > of the sample record.
> >
> > Add the missing SIMD register handling in aslr_tool__process_sample().
> >
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > ---
> >
> > These two patches fix Sashiko reported defects for the patchset:
> > "Perf tools: Support eGPRs/SSP/SIMD registers sampling"
> > https://lore.kernel.org/all/20260914014049.2061519-1-dapeng1.mi@linux.i=
ntel.com/
> >
> >  tools/perf/util/aslr.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> > index 027695d96779..a097084201a0 100644
> > --- a/tools/perf/util/aslr.c
> > +++ b/tools/perf/util/aslr.c
> > @@ -19,6 +19,7 @@
> >  #include <internal/lib.h>  /* page_size */
> >  #include <linux/compiler.h>
> >  #include <linux/zalloc.h>
> > +#include <linux/overflow.h>
> >  #include <errno.h>
> >  #include <inttypes.h>
> >  #include <unistd.h>
> > @@ -992,6 +993,34 @@ static int aslr_tool__process_sample(const struct =
perf_tool *tool,
> >                               COPY_U64();
> >               }
> >       }
> > +
> > +#define CHECK_SIMD() \
> > +     do { \
> > +             if (abi & PERF_SAMPLE_REGS_ABI_SIMD) { \
> > +                     u64 nr_vector, vec_qwords; \
> > +                     u64 nr_pred, pred_qwords; \
> > +                     u64 header_len, vec_len, pred_len, simd_len; \
> > +                     if (CHECK_BOUNDS(nr + 4, nr + 4)) { \
> > +                             ret =3D -EFAULT; \
> > +                             goto out_put; \
> > +                     } \
> > +                     header_len =3D 4; \
> > +                     nr_vector =3D in_array[i + nr]; \
> > +                     vec_qwords =3D in_array[i + nr + 1]; \
> > +                     nr_pred =3D in_array[i + nr + 2]; \
> > +                     pred_qwords =3D in_array[i + nr + 3]; \
> > +                     if (check_mul_overflow(nr_vector, vec_qwords, &ve=
c_len) || \
> > +                         check_mul_overflow(nr_pred, pred_qwords, &pre=
d_len) || \
> > +                         check_add_overflow(vec_len, pred_len, &simd_l=
en) || \
> > +                         check_add_overflow(header_len, simd_len, &sim=
d_len) || \
> > +                         check_add_overflow(nr, simd_len, &nr) || \
> > +                         nr > max_i - i) { \
> > +                             ret =3D -EFAULT; \
> > +                             goto out_put; \
> > +                     } \
> > +             } \
> > +     } while (0)
> > +
> >       if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
> >               u64 abi;
> >
> > @@ -1007,6 +1036,7 @@ static int aslr_tool__process_sample(const struct=
 perf_tool *tool,
> >                               ret =3D -EFAULT;
> >                               goto out_put;
> >                       }
> > +                     CHECK_SIMD();
> >                       i +=3D nr;
> >               }
> >       }
> > @@ -1061,6 +1091,7 @@ static int aslr_tool__process_sample(const struct=
 perf_tool *tool,
> >                               ret =3D -EFAULT;
> >                               goto out_put;
> >                       }
> > +                     CHECK_SIMD();

nit: at the end of the function you could #undef CHECK_SIMD to make it
more explicit that the macro only makes sense within the function.

Thanks,
Ian

> >                       i +=3D nr;
> >               }
> >       }
> >
> > base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
