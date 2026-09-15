Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79342C514
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504532; cv=pass; b=eDCgIoCyHCw2BxZd2prO3DsV63ix2A4Bdr+J/JrTvXMrr9HhzJi1BF9rTFcVES2OMUw8U3rZhzb7skWMx1GiUkRbFgr909LZrM18CpAYLKx4R3BRd8Z78VvrHEUXglkpB6FX7gsXmoZTks7c/izOtRVurKhQi3SOpIwxLuG0uKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504532; c=relaxed/simple;
	bh=5S7mpZP1AY3zyRlpCCbQBhFtYbQmh0B/XXBCpp2Lb20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ubbr5GxUEFqtmqJSTF67m3F9InUDlbuDaytBEm4n5iiZWQAexU2y2jqVXDSU8qNajFrxR29bqSXFzae6LqCQQNkkSXKjuIJMCKz4pGWcXpiAWqXuoGplsnaUfCaHOo0gvoAMAwQDPZXiMzRQQmq9j1IkdEArMNe01jOA3DV77Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zr3p2cAC; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zr3p2cAC"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so9871cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789504530; cv=none;
        d=google.com; s=arc-20260327;
        b=E4s7bzISAxEl0ltSO5cPh0fA/q94O9TP7B+/0hHKA2saVG2CGazD6IUYN8wwFaDQu/
         8Vss2MNPSkqFvUzV7A1sHk1MNMqDL3RonLpXvlzXysnXWs9CQqQJJaKIk6fwHJ9cbJ3n
         CnK98OqCcASNgsukwsReZKBC7u5u3hIVw5K0G3aH646bfW7muEsB42wKLGfzuRyzytDM
         yVDZUvQyF0FbLIet3D7zYacaE0RQCB3TGIl9rYr1bHDfTyDAgQUNpnSZ9rQtDltOOcR5
         R48yYaeHYYs7zrVnY+/2rrMMH//B8ORp8W7FUFD66NDHv4uclchpWRQHCRcwmKY7VfC7
         Q2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2aVaC40lcq/u8k1VkZQcJkdYTt7iyGlSRDBr2moFUHc=;
        fh=TZ6YHXvhuy28y2VxjCIj97dxkVTpTQAHZ8DNn9ofa6s=;
        b=H11lmuzH9s7/nlYw9hLmgYPlb+uCGf8KuwhICvTP9LaMC2N2hyt3HIWeDmAFHKoKtP
         jMFbR9MG8ktLCn4CABSO9SwmH3357KKAi+5/EMbQOiJYQR7JaMSmy1Ld0N5gXkj4csm1
         FUjDlxScAtg53MZI5p+k7lcxUXVsStp1lpW3TCwFWxfdiqzdQtGbaDpvy15TcdTqvFvi
         p6eMCsuULRD/mVkt/a6Qo1U+C5kMdjJPs8oJarHF6TaauFIQoZmeMJNNBtvx/bAShk1y
         Ny4BaF+iBML9lSf7JHIoyZkadbnyWLsU1eJAeRQR9eDneif9gorE3oogc/bU8XlmgCiE
         H4dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789504530; x=1790109330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2aVaC40lcq/u8k1VkZQcJkdYTt7iyGlSRDBr2moFUHc=;
        b=Zr3p2cACVABhMP6P0B0R7ypkrxLGrjhcLCXsNSJRlH6L2/0EVQq24FH/MSsKXAnAUK
         DpJ2iYYnCygY1W33R+ZgJ/XmfpH5averSOqbHqU1CBmbrzBFW2aZHKvrfxe47uun1d/V
         kfiPuoSMktxkVU6qcQcwkEvFWv9NA9rPUI6CYMk60QytB6Gmu0HnOFaC9YyE8+C0lTZ8
         YPhyy90g8jVyhuhCm6mUitOKt1pqQnWJNRQe7BLrxTRfd1L6Gs4j79kEKI4NLsJwahMB
         fzIxp7r/rNs+2XqOeCxjNm7rPLvt8Bd/koEqurxmDu4Tt/SiT10HD5+EoDonszML++xt
         tPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789504530; x=1790109330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aVaC40lcq/u8k1VkZQcJkdYTt7iyGlSRDBr2moFUHc=;
        b=EE+VnW8bfZzyhbSlmsIyvMaj8M8pTi4Mr7z8jeBUzMCTfnRWym12NqfSieo/pglrlH
         k7vdOsPjqVoiE3kX5T3JUg/YUHLkYVefQRIfojFxJN6X7dM2jlMESskvfN6tG/56eds9
         gRr5JPdAM23JUDklPGlXm/Ny5TlE+l7//Ga2tAeSgp45r+RhSrdNTQ4jvJ/0Dg31HCm2
         gKmPLlW/EEPtUH1DAP/crd5EH+3xGHH0mgfPuZsdUw871JPLtrllsHEFprxEuagX1t00
         5T24+pqt+41DNz/HteZgH9llOTQyl4dQwdEOwLrx3WF1ovidbgdg4OsSyX1zRAPHRmZY
         K+ew==
X-Gm-Message-State: AFuF++n6RAYTY8gbZdDfiw9Xr2RMWWGERkJLkROT8l9+jUe3fF+5d24E
	aX6vFfmBHI6HiUJzr8Mz4wJCa1m9FoPdvlBQ0xmwnja/3+kRl+kFlYJ3+Ap8LgY8Xvy3Bz8Q3KO
	Gxxy3TflYG2SQzXsA8CHKicLNsevbwsMX39/8RDuk
X-Gm-Gg: AYBFou18LF89xVNFprH2go6Egi4mX7in9JBFOdhkCTp2Yl0XR0sxHNTc8yZwsDjmZe2
	2E8fw2JcO73i5L3uwZpDe68f0ZLOpETtJImBExvjh3fP92GUwGJ+r5di9yPBB4rqZi8gSSZObw6
	1NkvtYA8c/s1yEmx2CLgKXLEGtfi4QOjSLNzePlCoS/WPBtfiVi5dC+7zJ4uNLyrtAHR7eOYSmu
	o18RCgNvs2MW0Gp1PRdWOXK/04faGbFgfoi/fJo0rbjpWJ8mZDVTrxeh7fmoxr5riwnODuygmWB
	1jz9pL1MBsNHdeN6IJ8WxxXiqZB+EzTjgSexDwJkIITpNZEW8u/V3mGYFC6HYeEi+ikBgz1ILJQ
	jvgv7mjq5+g==
X-Received: by 2002:ac8:598f:0:b0:530:e335:4ef with SMTP id
 d75a77b69052e-532504fd10amr4107081cf.2.1789504529299; Tue, 15 Sep 2026
 13:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709183956.1545402-1-ctshao@google.com> <CAJpZYjVB2+gSAOQRyXhapkeJLHLRuYWV9FVDTWC5Q2r3HDmyKg@mail.gmail.com>
In-Reply-To: <CAJpZYjVB2+gSAOQRyXhapkeJLHLRuYWV9FVDTWC5Q2r3HDmyKg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 13:35:17 -0700
X-Gm-Features: AcwNN1W4gqyMNPoBiIR8TiCEp0MQHdibfJuLwrDHxW2S3LZJMj8Dnk6GlAiScOg
Message-ID: <CAP-5=fWYgweCU59usaUoBjV5crj1zAD3sWOQgNBJhDfJmJCdqg@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Add dynamic IIO PCIe bandwidth metrics for Intel
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Taylor, Perry" <perry.taylor@intel.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 2:34=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> wr=
ote:
>
> + Perry for reviewing the metric.
>
>
> On Thu, Jul 9, 2026 at 11:39=E2=80=AFAM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > Generate per-IIO-device PCIe read and write bandwidth metrics
> > (iio_bandwidth_read_per_device_0, etc.) grouped under
> > iio_bandwidth_per_device for Sapphire Rapids and newer architectures
> > in intel_metrics.py.
> >
> > By using has_event() checks across up to 24 possible IIO stack indices,
> > runtime perf automatically monitors only the IIO root complexes present
> > on the system without failing on missing instances.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Assisted-by: Gemini:gemini-3.1-pro-preview

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 52 ++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index bc2b920d3a0d..4f8a123a375d 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -1132,6 +1132,57 @@ def UncoreUpiBw() -> Optional[MetricGroup]:
> >      ], description=3D"UPI Bandwidth")
> >
> >
> > +def UncoreIioBw() -> Optional[MetricGroup]:
> > +    if _args.model not in [
> > +        "sapphirerapids",
> > +        "emeraldrapids",
> > +        "graniterapids",
> > +        "sierraforest",
> > +        "clearwaterforest",
> > +    ]:
> > +      return None
> > +
> > +    # On multi-socket x86 servers, there can be multiple IIO stacks pe=
r socket.
> > +    # We generate metrics up to index 23 with has_event check so runti=
me perf
> > +    # only measures the IIO instances present on the system.
> > +    max_iios =3D 24
> > +    metrics =3D []
> > +    scale =3D 4 / 1_000_000
> > +    for i in range(max_iios):
> > +      rd_event =3D Event(
> > +          f"uncore_iio_{i}/UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS/=
"
> > +      )
> > +      wr_event =3D Event(
> > +          f"uncore_iio_{i}/UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS=
/"
> > +      )
> > +      rd_bw =3D Select(d_ratio(rd_event, interval_sec), has_event(rd_e=
vent), 0)
> > +      wr_bw =3D Select(d_ratio(wr_event, interval_sec), has_event(wr_e=
vent), 0)
> > +      metrics.append(
> > +          MetricGroup(
> > +              f"iio_bandwidth_per_device_iio{i}",
> > +              [
> > +                  Metric(
> > +                      f"iio_bandwidth_read_per_device_{i}",
> > +                      f"IIO {i} read bandwidth",
> > +                      rd_bw,
> > +                      f"{scale}MB/s",
> > +                  ),
> > +                  Metric(
> > +                      f"iio_bandwidth_write_per_device_{i}",
> > +                      f"IIO {i} write bandwidth",
> > +                      wr_bw,
> > +                      f"{scale}MB/s",
> > +                  ),
> > +              ],
> > +          )
> > +      )
> > +    return MetricGroup(
> > +        "iio_bandwidth_per_device",
> > +        metrics,
> > +        description=3D"IIO Read/Write Bandwidth per root complex",
> > +    )
> > +
> > +
> >  def main() -> None:
> >      global _args
> >
> > @@ -1179,6 +1230,7 @@ def main() -> None:
> >          UncoreMemBw(),
> >          UncoreMemSat(),
> >          UncoreUpiBw(),
> > +        UncoreIioBw(),
> >      ])
> >
> >      if _args.metricgroups:
> > --
> > 2.55.0.795.g602f6c329a-goog
> >
