Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611E3B95FA
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632849; cv=pass; b=pTIngKvjuf/7t6faX5KjPuEsA1b16oOXHoH9Hp0hYh0eHQxFnv49GYHFrlDcxmmpWj7jvvfqHf/fwDbzEAvT7fz74uigC9q8zuhP+pMu4k3hJ6HOOc+ukXQLYBHJpELlT2EFEjCKi3FIdxsGHLJ/dEYvYDF1EOUJpMDaQXm61b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632849; c=relaxed/simple;
	bh=1zShKhS1VRrFzdzdECNxK7gNa7QYz7pdJG0rj3Wmwmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4XhcIdSlwpdpvR5r3FM7J0xGiU0vuZR9gDY9DFRqd37cg8hh7QITCfFSwoZCFZGN0n6U8SXiSXi8xgvQ72xgvLWRsBmPD2J227+Hh1jGrMYDcMQL85AU6o3AcYJTp5DMnfDUzWVzpFNPwPWYSHcUfNjPYuNFJJg6B4/DmSRK58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ir35GMew; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ir35GMew"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso488422a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 14:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783632847; cv=none;
        d=google.com; s=arc-20260327;
        b=aYGptKx4VX99JFza1Bi/hceO6F75S8J2A8EokALTmUz8qLN1ueD1o09plaKQDcrjti
         0O4VjlszMOCUrdkMQTHBcNIgl09JMBLXp/H8MhxgmzrS5utnHCP4oSvCWPeAli9aWacO
         Il0lNB8eagIB5sm7IIQHcXuZsQ3S0r+zwG29itDBipfkevhMI9rUVkiIXMg36VLO9MnM
         ErFIUJKFDxlXH19/8BtV+t6Lx1Zo5Lgr/hYi8rOHkehRM6gsK29ciV+qflVTQJcjW2sl
         LZkJzDu26F4s22gDy2ezNg0+1d8rpBaSUshcieAlhE+5QeEeCcZ6xbrYx3OOC3txuR32
         9REQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTDRlUAAfGMhwl7695u+h/Wy4kpjjKykbx+XrpLTiiI=;
        fh=vXqaoQ5B/VzLhcAFzRfLX9CY5QwaIFRHiRXnE5D0jvQ=;
        b=LH1VaQVqYLtW3GQGrhHfVl6HZnduK9BaUSpihv7/hNWij3bUrSFdnOBadVl5NiszNZ
         q0ZAjzkJRjb9mAz08HHGFr5QU8G1D5+CrpEakj6LLiTtIbmnr9qZFatyGf/oyCR0m6X5
         4ZxW0SR/THIJUF+9pEVvDqmBp/FuN17jp4TjMfZuOpnlLBGPYf8+AwFr/Mm1GbiXIf0X
         u9R5wMFXuOzitbFFcWNG1b60wr1eXup7zwtCVMI0JshyrpbuK2WIr8ZMT04ZdRuEPbxL
         EDd0K3O6J4YrsPzmClhNshM5JTrDiBKXP1NlKAU+J/v47/AAPRc8pewspZQQ7CLGsgaY
         Rmig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783632847; x=1784237647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cTDRlUAAfGMhwl7695u+h/Wy4kpjjKykbx+XrpLTiiI=;
        b=ir35GMewXIYSZy9junLSFOcz6RtWShc824dq+mj05D094KjiDuT9vYSwtkxynNOAqt
         7JiOvXakXbRTg+0JrvyNk81+/1kGUBQ+AfbyIcG/Wl/JJjC4ns22BBlk7ys3ENQumYgc
         esIs3A1JxG7OqBqrWwfprmCI1JdYF6A4xQFooQQDaSCCYrJB50276tHy1uU4B5Ka7rLD
         LixHWeO7xCwyKLTN9OjwhkGJURAjl7hpZkjiRysI4A/ac95IExZGGHAiF3iVbLoUm396
         Wn1fB1AP37QZy6G0jtkWd3oEOtOCMdqywqAm3TAfbSVahO93hwmXJV3bm/X6U7BplygK
         o/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783632847; x=1784237647;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTDRlUAAfGMhwl7695u+h/Wy4kpjjKykbx+XrpLTiiI=;
        b=mRzuXk+D78Xv+WE7W+4mV0gdePiKklhA3FoqsHkZoCPi2rjCXG3Q9/dphZEqrnXzWD
         8LGYT4mT9DNJOJfQ14MwpeQtL6SkM/Z6uGSP/a64nq+kiZ7vapqMOzUtS9VWqP0hXnkq
         DC52PqSesw2diHH2qnRN6SOAc6qi4nbPMWx9Y3zrnb46lvFiSLcu3j7uLZ0gR+eLG9UB
         brCYVo+GlNgCgyhQ8e2pkBuG+CjzT8P6fD/t7uVu4Z8CjmFtVkz5ZLhaqZdexYHbEsdL
         qVfjYyNmjaIZ/nbTSDbkcAYJ+YyWSQ5wZVYAwihxBzPuiPsu90CJhklx6ifS3BowkeEa
         MaAA==
X-Gm-Message-State: AOJu0YwbhDq3URN2oNxgdZhTqZ8zKEO0dWnNOmxnczZewaDUA4OHmT8y
	2QzTLeEavRw3gxtN83aBiUF84rXLQoj2V2SjOwnlitW+SLc/zKQKUcTLm/YxpUMCh8pHwSGg/rL
	Yvly34/S5eA5N7TQlKVvIEqmzI3reTQKEqfzHmXTyVz+KWGo+T0gVN5YX
X-Gm-Gg: AfdE7clR1RAPLU55CebeFb7de//48PFz1EicYsa2gGIIFgmBTh8bKagDYcdu/F0wHsp
	HJUPAwtzRqJAT9eh4nUR/VWqcSzoOCmfx4E5DmFEyuBlg3voyUefvDfTY4jdcxzejEU/alYN4Je
	ELbY5ZoKZtvlnSAfXcll24l9i/IGJeKz374U1ydeu6EggnBzniq4rQb+rB6Uf57cNuJ3LsWkC8I
	pFYOcN5jPVLc/srhN+A58cvlEbnKhq5xYc9+PY8ou3OhVZpHyIoFRAUEOz/DVI/eBEF2p0=
X-Received: by 2002:a05:6a21:7018:b0:3c0:9c19:6591 with SMTP id
 adf61e73a8af0-3c0bd027a40mr10072989637.75.1783632846667; Thu, 09 Jul 2026
 14:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709183956.1545402-1-ctshao@google.com>
In-Reply-To: <20260709183956.1545402-1-ctshao@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 9 Jul 2026 14:33:54 -0700
X-Gm-Features: AVVi8CdpFVE5FieSZYsv-8qhRQ0apPJ4crUtRmiit0lj6JgcQx1Bzr1CYLp6v9E
Message-ID: <CAJpZYjVB2+gSAOQRyXhapkeJLHLRuYWV9FVDTWC5Q2r3HDmyKg@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Add dynamic IIO PCIe bandwidth metrics for Intel
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Taylor, Perry" <perry.taylor@intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Perry for reviewing the metric.


On Thu, Jul 9, 2026 at 11:39=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Generate per-IIO-device PCIe read and write bandwidth metrics
> (iio_bandwidth_read_per_device_0, etc.) grouped under
> iio_bandwidth_per_device for Sapphire Rapids and newer architectures
> in intel_metrics.py.
>
> By using has_event() checks across up to 24 possible IIO stack indices,
> runtime perf automatically monitors only the IIO root complexes present
> on the system without failing on missing instances.
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> ---
>  tools/perf/pmu-events/intel_metrics.py | 52 ++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-even=
ts/intel_metrics.py
> index bc2b920d3a0d..4f8a123a375d 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -1132,6 +1132,57 @@ def UncoreUpiBw() -> Optional[MetricGroup]:
>      ], description=3D"UPI Bandwidth")
>
>
> +def UncoreIioBw() -> Optional[MetricGroup]:
> +    if _args.model not in [
> +        "sapphirerapids",
> +        "emeraldrapids",
> +        "graniterapids",
> +        "sierraforest",
> +        "clearwaterforest",
> +    ]:
> +      return None
> +
> +    # On multi-socket x86 servers, there can be multiple IIO stacks per =
socket.
> +    # We generate metrics up to index 23 with has_event check so runtime=
 perf
> +    # only measures the IIO instances present on the system.
> +    max_iios =3D 24
> +    metrics =3D []
> +    scale =3D 4 / 1_000_000
> +    for i in range(max_iios):
> +      rd_event =3D Event(
> +          f"uncore_iio_{i}/UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS/"
> +      )
> +      wr_event =3D Event(
> +          f"uncore_iio_{i}/UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS/"
> +      )
> +      rd_bw =3D Select(d_ratio(rd_event, interval_sec), has_event(rd_eve=
nt), 0)
> +      wr_bw =3D Select(d_ratio(wr_event, interval_sec), has_event(wr_eve=
nt), 0)
> +      metrics.append(
> +          MetricGroup(
> +              f"iio_bandwidth_per_device_iio{i}",
> +              [
> +                  Metric(
> +                      f"iio_bandwidth_read_per_device_{i}",
> +                      f"IIO {i} read bandwidth",
> +                      rd_bw,
> +                      f"{scale}MB/s",
> +                  ),
> +                  Metric(
> +                      f"iio_bandwidth_write_per_device_{i}",
> +                      f"IIO {i} write bandwidth",
> +                      wr_bw,
> +                      f"{scale}MB/s",
> +                  ),
> +              ],
> +          )
> +      )
> +    return MetricGroup(
> +        "iio_bandwidth_per_device",
> +        metrics,
> +        description=3D"IIO Read/Write Bandwidth per root complex",
> +    )
> +
> +
>  def main() -> None:
>      global _args
>
> @@ -1179,6 +1230,7 @@ def main() -> None:
>          UncoreMemBw(),
>          UncoreMemSat(),
>          UncoreUpiBw(),
> +        UncoreIioBw(),
>      ])
>
>      if _args.metricgroups:
> --
> 2.55.0.795.g602f6c329a-goog
>
