Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1549B47F
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007746; cv=pass; b=jypiL9wqPlWy17mhZ+Xvrd+UArsV+SmfpmMUxCN6SJfHOh/EVjyp7SujTC5DitRbIuefEk1QCxkKfiCeNEbPZk4vp8xGafQrEsWC6GCDIbpewaLhNRclx/AgpqYIVWogv9m4rflrKHTquqxhZbv0k7VU9kr1Hl3fO61etb2u6Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007746; c=relaxed/simple;
	bh=I8g37qieZ19XHGCL3u3wjTE9kaftquawx7wgmkhVHZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tME9dNoxp4jNQD+SvzlZvvm/EsYlMqSyeROrlgOHBTvaPS0c6072P+P820ebGmTAsrO4DB8aVdYXL9zVCHqkFa735yI4JpfHHEU1YI4rt+1B/SuERaJDc4XTzRspjTfzGhUO5jzstKpSFPwaLhogHHu7KTr3cbb+4PpbAW1P7MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2yFtEbG; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2yFtEbG"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53113d72966so502771cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 09:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790007744; cv=none;
        d=google.com; s=arc-20260327;
        b=iMSuu9Gfp6XxRlrPQXxV0uTVxeBKE4c8akaHKWX292FC7E1dr8VT3cr/gszszlkXAp
         RxjtDIIrPWA5aKejXlY9GUQzcqUT3IuZewJ6DDV8q+A4ij423+kS5/Gec9GkusHKwCHo
         rb1JLCYnwlxYN1k/0Onrl4E/eM4y+OE/J2OCelA7jIWGiHth85c7yTqvQzz13JPKyiSx
         IaHH+hlXgKQ1APdeNwXvdNW8JBf7apH4/Hl07Cd3yEO//4+ZRcjx6bHFK8VorQj6Tapc
         iLN6zJqQMkdWjyzDDICdBy/RFTuAFlTkaAoKME3hnqCMsPNf0srLDLr27ntg36abQ7YJ
         F8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=owC2fjf5Qwa/LkbReUgINQZxkD7C+riZrL1KRkW5XzI=;
        fh=kReVi/n5dXWBjMUp7RM4nYy34hT2qhygCSlzz+vitpA=;
        b=CJd/b6CZJ4gxYHLLaW/0XkS3LRcn6Ra5l++4GRHO0OFIMAMxfn7vTS3ttJzcUU5hT5
         82UxusNOnF5N7qEBF360xsBDIZxJKGWXseFN6I5ojr3b1DXO/cyZ65DVO/ZPABU+ISGW
         aVAhZQuZ1GWLUJybwrUy9D6ugwWF67Cd36tuzAqg+LEgRSt5IYMz0l/dGWScxja2LGmJ
         Mb21DaD8vG42Snj13NlWGRNecpOL5qkjsaYOX3eGdwUOtXRUrZt5bAUqh1YDTIG/v6AJ
         sKqWaqizVO8X9SNIgPYcZGpJpBj3xCAk2HP0xQKiY20kkCUDzWlQYDpyt3p9AzSMOayc
         rOQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790007744; x=1790612544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=owC2fjf5Qwa/LkbReUgINQZxkD7C+riZrL1KRkW5XzI=;
        b=p2yFtEbGvVNsD16rapoTOWIPy7P0ffQGuhtuOcDFPLZXiQqL8T+73ik/eVJ7Xb0fIp
         r3G7BIeNf3MXubwao105Dk0wRsYCGwPmo5MDLrt8RWdWCK5hmlkgOT3U5CK9XKcLi3UM
         9mFPIPud0Zs/WjRo4KlXlbgCN2c/bWuuOt70hhYjMlLSifR7gBLBUKN6/BBXLfD+ZTEk
         yX4NcTNcDlq4X2WsQ4007GnPqpGibyqcaH12sZ2YywI9oWnix5sgca2y5PTdwfDxeNlw
         QtiHvOvGQwdIM3wCw39TG0n3tqGftuVbMzpMdkx0F9WU9CISHDehAudIIYXxfN/bCJWe
         K6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790007744; x=1790612544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owC2fjf5Qwa/LkbReUgINQZxkD7C+riZrL1KRkW5XzI=;
        b=Wsl/rr5ZPtNofEJ9FFcnQBsZ8sYau07q2dp5+Fjmc6V5JYw04mPzGvc7pACrOyLmje
         NCRB/JZv0NqYRKiwTltKE7b5v4S2+ZWCKPkFezdERmv2+pFoIUOAJKSWTIKepSd4KtcO
         d45S0fFnxlm8BoeuwNy8CunaxJwzecYAD4vSt7W/Yv9HjxXAcOivvjbZMRjjy0t2Sf7n
         UiuFKx8n/muN9YT1BN4iFcN06GUo98r74azNorCX9GMj3pShKHyTPozXBphB/qd/R+Tw
         GYehxfMOZsKY0VPigfC1bkf+MCuAFAMtfJWB4ZsLOzdAQuMIgONimVZ2VyK0+kQ2uDLV
         mWeA==
X-Forwarded-Encrypted: i=1; AKwUvBwEEHBOnilzNAH5MNHxpNsk/ju/uYYBABAve8jPqxf7fyGBpE3mMQBjOtz2Q/IRc3mXfFcOTt5cBfy0H6F9mkhD@vger.kernel.org
X-Gm-Message-State: AFuF++ngHaAzobDz0BCkh5UfqTxTw4+FWatu5+xkkE2Wm0mmKgYmD0AH
	cOae48hJT+dGgNIv9QVJTSup03v620Ws0R818e02rlIGPkgyWzjiiSdufsRUboFUqwMGWqay866
	BgYROEXaVp4m4cSE8PcHLSXY5M6gFpNkSi0F+bAQd
X-Gm-Gg: AYBFou1RORnsGSk4PvSE9Qf/41Jnm7Q9AHJuxtnTMgvXgSR+yZrmTtIbZRnewwzvSPL
	tLSJs0YNPZlLDJ2Zn6oooo0DEtHW/+62nkDTh6cPZFnyYrEYR72nigWNfS7Rdg5A7qUdluyA1Lc
	3cu6iND5EWPF3ZlB9rkHow5HBKS3qGjWJIwYEki/fZzXa1Mrl8jsSVLDRM06DEBk6B1Tj4twwrl
	IBEAKznyL/SMNjveiMVDTgTwFIJQu9rAv6UlEqVr3p7iV36be7rvHqFs910mCge1I4U8rw7DQ9E
	4SrwAPKg7+YDkH9iy+cjO9a0oP2rVAXPWbqvD4CaT09bIVTKgqMH1W73fBYZA0mB6p/i/26Vi4u
	Jqop99ECH
X-Received: by 2002:a05:622a:4a8b:b0:531:d8:e437 with SMTP id
 d75a77b69052e-532d8d9b2c5mr4968831cf.7.1790007743302; Mon, 21 Sep 2026
 09:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
 <024fd251-a4ba-443f-8aff-f5b1cdb062a3@linux.intel.com> <CAP-5=fUc_WOHAe4EkLVYuBgvQmxk7_XY4N+v8yJKNJQpCSObHg@mail.gmail.com>
In-Reply-To: <CAP-5=fUc_WOHAe4EkLVYuBgvQmxk7_XY4N+v8yJKNJQpCSObHg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Sep 2026 09:22:11 -0700
X-Gm-Features: AcwNN1W35saVFW-Tr6vgI2VGiSi9ld-QxMQISoA61xD8c6KOSqtdbQ3LIDan_lM
Message-ID: <CAP-5=fWTRPmPTkzd98hCEfh6LUTrRTNHZ2dS4nUDyQBuU8oSzg@mail.gmail.com>
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

On Mon, Sep 21, 2026 at 9:21=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sun, Sep 20, 2026 at 11:42=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.int=
el.com> wrote:
> >
> > Kindly ping ...
> >
> > @Arnaldo, @Namhyung, @Ian, not sure if you have bandwidth to review thi=
s
> > small patchset which fixes the Sashiko found minor issues for the "Perf
> > tools: Support eGPRs/SSP/SIMD registers sampling" patchset?
> >
> > If possible, it's better to be queued in this cycle, then we don't need
> > extra backporting. Thanks.
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Oh, another nit: there's a typo in the commit message subject: s/alsr/aslr/=
g.

Thanks,
Ian

> > On 9/15/2026 5:11 PM, Dapeng Mi wrote:
> > > Currently the SIMD register sampling is supported, but the correspond=
ing
> > > handling is missed in aslr_tool__process_sample(). This can break par=
sing
> > > of the sample record.
> > >
> > > Add the missing SIMD register handling in aslr_tool__process_sample()=
.
> > >
> > > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > ---
> > >
> > > These two patches fix Sashiko reported defects for the patchset:
> > > "Perf tools: Support eGPRs/SSP/SIMD registers sampling"
> > > https://lore.kernel.org/all/20260914014049.2061519-1-dapeng1.mi@linux=
.intel.com/
> > >
> > >  tools/perf/util/aslr.c | 31 +++++++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> > > index 027695d96779..a097084201a0 100644
> > > --- a/tools/perf/util/aslr.c
> > > +++ b/tools/perf/util/aslr.c
> > > @@ -19,6 +19,7 @@
> > >  #include <internal/lib.h>  /* page_size */
> > >  #include <linux/compiler.h>
> > >  #include <linux/zalloc.h>
> > > +#include <linux/overflow.h>
> > >  #include <errno.h>
> > >  #include <inttypes.h>
> > >  #include <unistd.h>
> > > @@ -992,6 +993,34 @@ static int aslr_tool__process_sample(const struc=
t perf_tool *tool,
> > >                               COPY_U64();
> > >               }
> > >       }
> > > +
> > > +#define CHECK_SIMD() \
> > > +     do { \
> > > +             if (abi & PERF_SAMPLE_REGS_ABI_SIMD) { \
> > > +                     u64 nr_vector, vec_qwords; \
> > > +                     u64 nr_pred, pred_qwords; \
> > > +                     u64 header_len, vec_len, pred_len, simd_len; \
> > > +                     if (CHECK_BOUNDS(nr + 4, nr + 4)) { \
> > > +                             ret =3D -EFAULT; \
> > > +                             goto out_put; \
> > > +                     } \
> > > +                     header_len =3D 4; \
> > > +                     nr_vector =3D in_array[i + nr]; \
> > > +                     vec_qwords =3D in_array[i + nr + 1]; \
> > > +                     nr_pred =3D in_array[i + nr + 2]; \
> > > +                     pred_qwords =3D in_array[i + nr + 3]; \
> > > +                     if (check_mul_overflow(nr_vector, vec_qwords, &=
vec_len) || \
> > > +                         check_mul_overflow(nr_pred, pred_qwords, &p=
red_len) || \
> > > +                         check_add_overflow(vec_len, pred_len, &simd=
_len) || \
> > > +                         check_add_overflow(header_len, simd_len, &s=
imd_len) || \
> > > +                         check_add_overflow(nr, simd_len, &nr) || \
> > > +                         nr > max_i - i) { \
> > > +                             ret =3D -EFAULT; \
> > > +                             goto out_put; \
> > > +                     } \
> > > +             } \
> > > +     } while (0)
> > > +
> > >       if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
> > >               u64 abi;
> > >
> > > @@ -1007,6 +1036,7 @@ static int aslr_tool__process_sample(const stru=
ct perf_tool *tool,
> > >                               ret =3D -EFAULT;
> > >                               goto out_put;
> > >                       }
> > > +                     CHECK_SIMD();
> > >                       i +=3D nr;
> > >               }
> > >       }
> > > @@ -1061,6 +1091,7 @@ static int aslr_tool__process_sample(const stru=
ct perf_tool *tool,
> > >                               ret =3D -EFAULT;
> > >                               goto out_put;
> > >                       }
> > > +                     CHECK_SIMD();
>
> nit: at the end of the function you could #undef CHECK_SIMD to make it
> more explicit that the macro only makes sense within the function.
>
> Thanks,
> Ian
>
> > >                       i +=3D nr;
> > >               }
> > >       }
> > >
> > > base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
