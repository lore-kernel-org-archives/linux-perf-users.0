Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36394078E4
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505384; cv=pass; b=dx3hhfisqNbXkER6wsCMPkR6JaUbzubfA3ekCtnYPtQksuw+in4CpzsZtQuaUjU4WgiiAeCgElMRiLJDHSJssDXwswt3NJ3+afbtVhkyNqM02yBuU8jQCW+qDg6g+odt1EZLLVt2Cnl+tFEHcbUsjxpaqyZZHLqoJz4gh8rf97w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505384; c=relaxed/simple;
	bh=9EdZsGvujjYIOTMuVHcupJXRk6h68fFRzhsC3Ifbu8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpUJeQl9p19yVhFQkQEWaUiqbLnnTLoAo3k+R1RekmpYNmyEAE/C8FLJ/1K9pKgVEitx5zvcJhlogtR2ELyrsyIqodDwEfK5CHFSvwHiU/ouDNJ2yaamauIF4cjlBADBzaK22ilduzn+9xnra9NtZj1UWNjII4+eeDYtqfyqAQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9N6NwEm; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9N6NwEm"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so135638a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789505375; cv=none;
        d=google.com; s=arc-20260327;
        b=oRgnuzFtnBcPZw7CULynSRPYT7gU+elvxNDiSQ8gnZRayk1aA9YS2yp9d6QO7Y7eKi
         1p7B9oYZbdyR9H9CeymSKwtUn4tV7prmC7EpSzWg1XxgXAPlp/Kto3McdII9FCMv3eg2
         Fs/vTMeGpLKvd1+qVVFX9Os9QM+9lfXl6BOqJvLypwEqkNp71sbsqnxVvT63VzNqijnB
         osUbLC7eSQbBTRkgE0ejcLG2Z6YMHruaQrbHFjOpf7e1I99Q82IIeQREZ1CiRVgTz8C+
         TIU5JT7mga6mH7jO4Mj2HMcHmQuf/BmOqSCm3Cfmoyhn6FFTVwPMF7ce8/vOW62MsWJX
         Ra7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sahGWJ8mHho7FuY7s/PNI6v8DL9Wdyd6nKrCQOAAOlQ=;
        fh=uTYx8GATIxxuXyVfutXaOVJRZbJQKB32dMFQBvkTBNs=;
        b=JIrDfW4NQ1fWdZKtj2SL9Q7aYHYNDkjHuNVJxkH6LYfUCCNhVA+rY7IS7s1wWRyWyY
         JB/G4/P9yJJmyxpNFgkn552iibqPTlDVsk7xBqsWWjB6XSeq0+8crhoDUkxhxle5TzeW
         IJEy3jvMUqcQ+umubZ9xOYytPskOEQe0wiQYWFXWH16TxNGv+23D8iNQIb315b6Rl/CV
         O6i5SZM1ynpH+UAuv+XeX+4LepNGH6ItekqfwFNhP33YQ9eUBB/wB6VUCEQyP08wZbAv
         sWmmi5VXBb2bCFp+dowm2JWh9kwRpWiK/5V66obhJtLqBYkrAoCbxG3dH91xrACz6TYq
         pv3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789505375; x=1790110175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sahGWJ8mHho7FuY7s/PNI6v8DL9Wdyd6nKrCQOAAOlQ=;
        b=c9N6NwEmD/94m/99FgD7tnAMERgQpAHg2M0K1tfyyQq0yR5iX+5KP5iRdGzodB+Cko
         fF0eVaZ6IiYrL1L1i0CE3OitFpVozx2urgeha8sbpBghCghjZM4CXVNNm23kP1qU8Ny8
         ad7dKrMC5RoxokrWdDshLVnap1Af4nknXDY1uFmJAn/QMI9pCWHw+FepV6gMRZO+MbQm
         fqDgoDrf10AM91qXBaWkSUS9uxo/Hf2JHHCO6MXXTGsVOMguwcTRQ+84DXx7CTumVY6m
         o3Fv01kMNvnrcZK0UpmQASX5SLjOTFoVE2lZEiAclQ41gQ17fDWQjGDRDVObnoGWLiBL
         Fe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789505375; x=1790110175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sahGWJ8mHho7FuY7s/PNI6v8DL9Wdyd6nKrCQOAAOlQ=;
        b=LH1GBkjL5RN/cJnJGVn5nGsz8cuXuKS5cdWvj/OkgGCtz6DpawBsmEdph9QRQWOeBH
         GJZT7bbh6eGbYmN7XYF6tmxdS46xQTdBRJ9IZxMJrYwcU5kj46mQcIHxtW0cAS6A3Sft
         WcdqjsLL7kbqI+vpL298tVGcM1Ou0SE36Uc3NM3jWuhcHxpy1j0hKZ7UvOJSDm2qhP8G
         dSXE0/RhUIaIE4NmztzGTRkZr3bJJYE9cqpq4n0X0HBzorEsscoh6bT9Hc5qZUvT9xEb
         z2ijcwStBloDr97j7gCFZKH5lziuArN5H8r84dFQt85BWxbDrUl1Q8QXIoRnfG6ZWc2h
         Ie9A==
X-Gm-Message-State: AFuF++n4dNp8dGr/zuAT83+bQvLsW6/O24jGjHYdX1j+c3UQ6GJPXhB6
	Twu1od1qoRHEqkC1gc0GR3Ppw4JZTLdTtBc3ifsTYdrRwXwV/KuSkv0u1vvUAtmPYJaRwW2yDIE
	1OohmMtoYXM0r+phGJLwJhQpvsQhX2o2tfrYDWVN4
X-Gm-Gg: AYBFou0geGsQ1MPlhwq/HKkaFMY6Rpblhe6Sm6o80vA5WhyENnJjgK0MO1Is/kQefmw
	vbIHG4BJcKQw/WtIs9XlxxIrqlIuGCFvh2Yx/PAFqLXRYtubnlK1UfRWvFVOoadm7/DGLB2dj62
	Ld+Ln1DKDgPMv+bP/yMi5N/5JjocXS/tr4Y/c1hu51c+WHC1u4OUSYfWXy4PmqH+FHiuXZId0fU
	Pg3tOAjmw/QcYXy/EZ2kZYJZffAbiLWQ5FCTj3WvEQqPuf88hqGGX4dRbUUT3HMyXR7JhS7rBMD
	QQp43KMuF0oJhevJ3DT/AtD2/Mrao/ZQdhf9keLdZUJGcuHkWK4W6w==
X-Received: by 2002:a17:90b:1dcf:b0:39e:132d:df19 with SMTP id
 98e67ed59e1d1-39e1e37a7c0mr224021a91.10.1789505375061; Tue, 15 Sep 2026
 13:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709183956.1545402-1-ctshao@google.com> <CAJpZYjVB2+gSAOQRyXhapkeJLHLRuYWV9FVDTWC5Q2r3HDmyKg@mail.gmail.com>
 <CAP-5=fWYgweCU59usaUoBjV5crj1zAD3sWOQgNBJhDfJmJCdqg@mail.gmail.com>
In-Reply-To: <CAP-5=fWYgweCU59usaUoBjV5crj1zAD3sWOQgNBJhDfJmJCdqg@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 15 Sep 2026 13:48:58 -0700
X-Gm-Features: AcwNN1VpPDXLGqPZoqx4hTkxvamAlRNbPISw5gUK3huIUy48cc0qaQlKQaYuy5U
Message-ID: <CAJpZYjV2g7f=UUSek6vS1Kej_XYm5Gn4qP8kAxCarNQTDeUssA@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Add dynamic IIO PCIe bandwidth metrics for Intel
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Taylor, Perry" <perry.taylor@intel.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:35=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jul 9, 2026 at 2:34=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> =
wrote:
> >
> > + Perry for reviewing the metric.
> >
> >
> > On Thu, Jul 9, 2026 at 11:39=E2=80=AFAM Chun-Tse Shao <ctshao@google.co=
m> wrote:
> > >
> > > Generate per-IIO-device PCIe read and write bandwidth metrics
> > > (iio_bandwidth_read_per_device_0, etc.) grouped under
> > > iio_bandwidth_per_device for Sapphire Rapids and newer architectures
> > > in intel_metrics.py.
> > >
> > > By using has_event() checks across up to 24 possible IIO stack indice=
s,
> > > runtime perf automatically monitors only the IIO root complexes prese=
nt
> > > on the system without failing on missing instances.
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > Assisted-by: Gemini:gemini-3.1-pro-preview
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian

Thank you Ian for reviewing the patch! I had an offline discussion
with Intel and we found:
1.  iio_bandwidth_read/write is only missing on EMR and Intel fixed
that through event updates:
lore.kernel.org/20260714204044.1952031-13-ctshao@google.com
2. -A option does not work well with uncore events and I have a wip
fix for that: lore.kernel.org/20260811230518.3360-2-ctshao@google.com

The patch is no longer necessary.

-CT

>
> > > ---
> > >  tools/perf/pmu-events/intel_metrics.py | 52 ++++++++++++++++++++++++=
++
> > >  1 file changed, 52 insertions(+)
> > >
> > > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-=
events/intel_metrics.py
> > > index bc2b920d3a0d..4f8a123a375d 100755
> > > --- a/tools/perf/pmu-events/intel_metrics.py
> > > +++ b/tools/perf/pmu-events/intel_metrics.py
> > > @@ -1132,6 +1132,57 @@ def UncoreUpiBw() -> Optional[MetricGroup]:
> > >      ], description=3D"UPI Bandwidth")
> > >
> > >
> > > +def UncoreIioBw() -> Optional[MetricGroup]:
> > > +    if _args.model not in [
> > > +        "sapphirerapids",
> > > +        "emeraldrapids",
> > > +        "graniterapids",
> > > +        "sierraforest",
> > > +        "clearwaterforest",
> > > +    ]:
> > > +      return None
> > > +
> > > +    # On multi-socket x86 servers, there can be multiple IIO stacks =
per socket.
> > > +    # We generate metrics up to index 23 with has_event check so run=
time perf
> > > +    # only measures the IIO instances present on the system.
> > > +    max_iios =3D 24
> > > +    metrics =3D []
> > > +    scale =3D 4 / 1_000_000
> > > +    for i in range(max_iios):
> > > +      rd_event =3D Event(
> > > +          f"uncore_iio_{i}/UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PART=
S/"
> > > +      )
> > > +      wr_event =3D Event(
> > > +          f"uncore_iio_{i}/UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PAR=
TS/"
> > > +      )
> > > +      rd_bw =3D Select(d_ratio(rd_event, interval_sec), has_event(rd=
_event), 0)
> > > +      wr_bw =3D Select(d_ratio(wr_event, interval_sec), has_event(wr=
_event), 0)
> > > +      metrics.append(
> > > +          MetricGroup(
> > > +              f"iio_bandwidth_per_device_iio{i}",
> > > +              [
> > > +                  Metric(
> > > +                      f"iio_bandwidth_read_per_device_{i}",
> > > +                      f"IIO {i} read bandwidth",
> > > +                      rd_bw,
> > > +                      f"{scale}MB/s",
> > > +                  ),
> > > +                  Metric(
> > > +                      f"iio_bandwidth_write_per_device_{i}",
> > > +                      f"IIO {i} write bandwidth",
> > > +                      wr_bw,
> > > +                      f"{scale}MB/s",
> > > +                  ),
> > > +              ],
> > > +          )
> > > +      )
> > > +    return MetricGroup(
> > > +        "iio_bandwidth_per_device",
> > > +        metrics,
> > > +        description=3D"IIO Read/Write Bandwidth per root complex",
> > > +    )
> > > +
> > > +
> > >  def main() -> None:
> > >      global _args
> > >
> > > @@ -1179,6 +1230,7 @@ def main() -> None:
> > >          UncoreMemBw(),
> > >          UncoreMemSat(),
> > >          UncoreUpiBw(),
> > > +        UncoreIioBw(),
> > >      ])
> > >
> > >      if _args.metricgroups:
> > > --
> > > 2.55.0.795.g602f6c329a-goog
> > >
