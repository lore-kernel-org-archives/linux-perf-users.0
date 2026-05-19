Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CA3016FB
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214014; cv=pass; b=BVPngrcGBrNS5BE9vj2dFHdSJchR1yBBjtZHw3RfLSSkxPeuC7x4Y/pmoIRgyjXLlQTKYq0YrsN+H5mInCfnnw+yRryu2GhIKweRuVZRxjxO243+cVyQxX/PCr4mVTMNcUcuj/v+pv+RaJOPDoksqgRsT3AG15uT6LaUDfUJ+ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214014; c=relaxed/simple;
	bh=4thNVZ0mHB2sYEYeFvMvXVOlUMWi1njYgCSLRkweRH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lS7bn5pv83bARU/y8iVU07bIrG3okMVQIPiNgBgqBtMA4WSV82ezyo8IkyQU/ftrRQpyMfDib2BJCZu4pAcF29rCCRLkg2TfVLJO+ssyFR3OGMZWxYwUHmzqJdodj6Z/poCigWHfUUGTbbVtJqbvWa33IEC9Ckotg7vNthc0y08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gd9Bvh/I; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gd9Bvh/I"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c19d23b19so5352661c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 11:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779214012; cv=none;
        d=google.com; s=arc-20240605;
        b=gxsWho8AthSB4SxllUkkUPbbovt2QPyxzq7gw6aEmExMidzw9sQru8D6KTyMx+2ypW
         fuU5nl3vwPa6GDhEsY1g7uLSh7muagXSq1k6GX8wjjGnnOLDgXuPPITirfmA2QBRWCoP
         LpQG6cCr4RTm1pPa69xrY7BYLIKAaxa/H453p45T8g0MXn+/TMhSjUtwNh3fEc0fo/iP
         SyfjmPXNVc88iG2GO9PyiGX9jektORgZjqMyUtwGaWfKxk124HLSHmtbflYFEAQUTJ7U
         zzGWfzNxiUBTsFcoVfFPQ2OsOWSh55GENN++VeB55rX+HccZWDTYBLLn+MFK2txdbmSK
         iceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pXEsiVi0J6CWJzQCcHF6I004hQIxqj2VlxwwG4G9tMQ=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=f2Mx+AfXQcuoJzlPCS7LXbfywMflzs3tHIDMyo3OaRyM/rSGM2t9Dq+cCaXR7vnixa
         0AX1TIR35+g3KynpiKmWj1mpq0o7J8ctnemytYNEN+bPI+MnVR1FsmmRhpGMMIbVCgUf
         zUBDZ7d/+gD5fhxIBYa8d9qKq9dT6YfDtfAtm2znXG+WuLtASfVf1z/Au87q/krfBXUI
         b8YxEcEA9lXInb1eXmK+PIY0TbmALppfrBaTDvVa/XFvriajWVD5l5DVPHPgEz01n/mU
         SPWntWCvG/qNe5dfT42eqDsJWz30CIhXLm68rM1sVvPRZR4KnCZsHIOJk6pxtjbGyKPc
         6bkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779214012; x=1779818812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXEsiVi0J6CWJzQCcHF6I004hQIxqj2VlxwwG4G9tMQ=;
        b=Gd9Bvh/IyjLoyD/Av6rgy8Tng73yWYeVV5FIt8eQY6Rmzm07YsnQkm87kLvSppn3vt
         I0OotpjSjnUlzE55H5/1BNanQA28SjOEkQlu1NW44SqGMkfWOZN+RAh5PrqSEArVA/jE
         Olw/617i0x/l3g04WIU2+XiXhvmwQjd4AKwQKGawLi4GzWdLcoNypkjJY/gX26+7NMGy
         Rk/8efbLbDKysP2sp68y4mqK+wDreYHRb/dswOvkN63KKKIMHFoLa9vvN8BR6ZVmRADx
         7caBSlHkzzfk2KpdOoE/0JimLE1e8IgllWj7fhC0OuRDA7k56bmlxOlAmtHw91r3eVZ0
         yANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214012; x=1779818812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pXEsiVi0J6CWJzQCcHF6I004hQIxqj2VlxwwG4G9tMQ=;
        b=FF1i+TJ/YFQhXY9puTEKxHIsErNYBtZR0p2J48ktuwrhYRwDgMUh0F6za9e+TCOtwo
         17P7See5qzkTPqL8s+0ztqEDruiglzKWZtBeJb7pIxZIT6fCMQ8aILmRP2RbF5RthhGh
         3y3wIYlIc4xKhy7opeZJeQSNRcRfAMD2UsxgmeU5dUnw5JpVJmT6Y+melyK+iOfvy9px
         2jeWGKl67a+nVVPHwL1stwbEsL0ne3jQsJq1SWUX3nrZj/w7HVQ75DZ7ZsnmzaE38prQ
         Q9rTcCV+Kw5+0mdDRXZFYZFa3Y6nGKgFuUKQSIDcE63YOzAkc6IJjd1dZS9AoX1100qL
         DYkw==
X-Gm-Message-State: AOJu0YyH9ngUxNN4/FRsIr8ZHma+JX0rZ9zNNpt57iLcS9cQW7UeR/7h
	0kcS/1EQuBM2QGYi1kqYVqASwBjaDy/Ljr+QQooyCoDXvYJYHP+pRPM71D+ycMcVLAkK2KrX72z
	+mKTS6R+mBNVlUk8eHudcRhcejIKjA45S0Igk65pTh7AERDpvKlaXcyKx
X-Gm-Gg: Acq92OE5ctwJlR7YNXv92gzxnPkHKbwy5gWcWmrs3q+0bKX2co03kS4SHmPNIQRC+hy
	LSfwXSOQgGIR0msrNggroNzEjReZjM6ZFOIzByk0FPDktWWTuEMftNqCzvfPsVJWyAntvXAjCPn
	SoRnr8/lT1fXuGb565UNQRi61ew8l5JwMkjhSXl8FOsf18LE5+bGsKY3EC/mTVLWbOTNL4QAdkw
	LajRlWWcFsuO0ne328oNih/xZdCk8bjOU6x+Yy0z+OpJX2VPkanP5+8u8X/5M1QJz5rAaQUDmwS
	rNfu79u4INnrb2+/LXYL2IZZWBbM1639JsKZF9VwcC+228Uw
X-Received: by 2002:a05:701b:271b:b0:135:da70:c2d4 with SMTP id
 a92af1059eb24-135da70c454mr932737c88.25.1779214011829; Tue, 19 May 2026
 11:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518231150.1252420-1-ctshao@google.com> <20260518234452.DEAEFC2BCB7@smtp.kernel.org>
In-Reply-To: <20260518234452.DEAEFC2BCB7@smtp.kernel.org>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 19 May 2026 11:06:40 -0700
X-Gm-Features: AVHnY4IKM7KqTw7rimaea7u0hqsWqLvd1iRJlnijVTEklupSIQWf90acL9kc8ZU
Message-ID: <CAJpZYjXh2DFpnS3+_cKhJ==6n31qBU8Cnks9VXZB_qH5i7S-eQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix uncore metric scaling bug across sockets
 and nodes
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Based on the AI review, instead of changing `source_count` behavior, I
will expose `aggr->nr` in perf python metrics and fix per-aggregation
metrics accordingly.

Thanks,
CT

On Mon, May 18, 2026 at 4:44=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The patch codifies a mathematical scaling error across all agg=
regation modes for uncore metrics by changing `source_count` to `aggr->nr` =
without removing `#num_packages` from the JSON formulas.
> --
>
> commit 1c2296ec7fca6ef588c3a63c6bd68377de82335f
> Author: Chun-Tse Shao <ctshao@google.com>
>
> perf stat: Fix uncore metric scaling bug across sockets and nodes
>
> This commit changes how source_count is determined for uncore metrics.
> Instead of using the static PMU count via evsel__source_count(), it
> dynamically assigns aggr->nr from the metric's leader event to handle
> various aggregation modes.
>
> > Before the fix:
> >   perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
> >   {"socket" : "S0", "counters" : 28, "ns  lpm_miss_lat_rem" : "163.4", =
"ns  lpm_miss_lat_loc" : "27.5"}
> >   {"socket" : "S1", "counters" : 28, "ns  lpm_miss_lat_rem" : "170.5", =
"ns  lpm_miss_lat_loc" : "25.5"}
> >   perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
> >   {"ns  lpm_miss_lat_rem" : "90.4", "ns  lpm_miss_lat_loc" : "12.6"}
> > `lpm_miss_lat` on global aggr is 0.5x the actual value.
>
> Does this misdiagnose the correct baseline? Existing uncore metrics like
> lpm_miss_lat are defined in JSON formulas as dividing by
> (source_count(TICKS) * #num_packages).
>
> Before this patch, evsel__source_count() returned the static PMU count pe=
r
> package (e.g., 28 CHAs). In global aggregation, dividing the global sum o=
f 56
> CHAs by (28 * 2) =3D 56 yields the correct average of ~90.4ns.
>
> The --per-socket mode yielded an incorrectly scaled value because it divi=
ded
> the sum of 28 CHAs by (28 * 2) =3D 56 instead of 28.
>
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shado=
w.c
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
>
> [ ... ]
>
> > @@ -103,7 +103,7 @@ static int prepare_metric(struct perf_stat_config *=
config,
> >                                       val *=3D 1e-9;
> >                               }
> >                               if (!source_count)
> > -                                     source_count =3D evsel__source_co=
unt(metric_events[i]);
> > +                                     source_count =3D aggr->nr;
> >                       }
> >               }
>
> Does changing source_count to aggr->nr break global mode calculations wit=
hout
> updating the JSON metric formulas?
>
> In global mode, aggr->nr dynamically evaluates to 56 instead of 28. Becau=
se the
> JSON formula still multiplies by #num_packages, the metric divides the gl=
obal
> sum of 56 CHAs by (56 * 2) =3D 112. This scales the true average incorrec=
tly,
> causing the global mode to output the doubled latency value of ~174.5ns.
>
> Similarly, in --per-socket mode, aggr->nr evaluates to 28, and the formul=
a
> still divides the sum of 28 CHAs by (28 * 2) =3D 56, retaining the origin=
al
> scaling error in per-socket mode.
>
> Should the #num_packages multiplier be removed from the JSON formulas whe=
n
> making source_count dynamically scale with the aggregation mode?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518231150.12=
52420-1-ctshao@google.com?part=3D1
