Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4320125F
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 04:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786940015; cv=pass; b=aUBEIoWFFK8i88K5yh71OF11a8V3hRj+COOz8QLuAMt1o6KIi5Jp4ruX8Pmrkotg2i3B80b38vBCrknceRJUVjp1drxsxAaiZMe4+x7MTcunIws5M0fkbKTiMqDQUZdNUzCvQLZBium3+jHxsXsvX30QECO8Ggay7Sd6tzm7bqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786940015; c=relaxed/simple;
	bh=5Blta1wT0z6cp3scoqrFYSVq0hVhmY3Q87T2OMyervA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr7ywLJinsvq2t9Mas7z82zIKtHqFPLpl0iPIjlt+nPDAgVDeHQNRlbKBwDsMtIQgfM/4A6CWZ3r25vNhXBO2bvR7wEVdJHNZst3wgHnO36idKOAof0AajCVuvhbXVgnIPTAXMPHZ4iFKB+sJ3J2ziixlEoGcdY3EyFXN6buJlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KTfDUxee; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTfDUxee"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c01c79467so640231cf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 21:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786940013; cv=none;
        d=google.com; s=arc-20260327;
        b=nzFG2BZlC+KCghV1efMfvJlzWp8NswYIo9tjEi0Ou/UqyvrbM0MxTLTXxwR6ZX/XFl
         f/8mVHilUJznevFWlONijAayXCrjI1tUMKvVMP+T8KQrNYJI1u9rsYLDgGCGWf4ZJu/u
         P7Os2Rf75oS/shNYEtfejvj+Z3pr5HJg6TkbuOoMs6OIQlwR37FNzVxdcnAAak/4vqFo
         DVfvu6+U7MOvbsNjlngUHkzTt2iSlLrjwPBLDiLfX9Ae3yV1Oytrc021Su7AeAHqelLo
         PH85vLNP9BLJKVPCk4tQ+W7crhj89CQvtRTVbiaT9w8lCGWwPD9r076viY3CtNqqYlL8
         pXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m6ws6hhoYl9pEf/rI1rxibuzyydRkmy7kW/80lYzhYw=;
        fh=5uAbr7OHeF8fTVnxbwY5wIAXFIqv5NFFccFyy2VHKxQ=;
        b=JxFSXc2Te2AXhhOVSgIIBEn2IcQ7lvrTH/ZLraBJOfNn/uq3i1DKdEbPR9ALz00Wxm
         NroCUl1WEfXgc6sgND5QYyzB1L+jTVrH1INCKBHUZALo739me3CtAihUBONRqOKLsxOg
         9ppxsYfaghvhLIyhKP7fQQuj0pI78x7G7Cl6B7fD9FfQSIH2kFv4h03q+ud9FJ/Q+iE6
         N6bDgqIWtxjLmooFTA2550JXFcefqy5qYmONRklVNScnNMfjBNkV5h2SLoTJEAridkkP
         Uquysg3ghwqBBd3+XFCT9A4MOGrMJvcYGvCTUR9VPPOQIJ9ChygSOjkvcZwMC1uKtgNJ
         4NEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786940013; x=1787544813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6ws6hhoYl9pEf/rI1rxibuzyydRkmy7kW/80lYzhYw=;
        b=KTfDUxeexBcLCHFpTTYXPSd1OJyA2bJ6IMmj15y58ADXJrd86ewmB8eG59UAwfWB7K
         WYZW2fojwclS/7bpFJ9iVFPyTsAydKKS5eansvK789v56Q6FaAPmAP2jLrQ4zTLlKxOG
         ZmyUti3XOmMacKpMXNLIo7ZTRf5XMO+Ix76xHm7t8y5ienS6Uz+EojVvgMBnve2+a4Tn
         7sOfYcQl8dmmQqgcckmIXWujKxA3+Xe9rOQ81QO0PHeVUTCczbByzYk0zmy0keb9xfnG
         IEALccVDlpMBvEY8GSFpLLXFfy2IarPinI73I9jqgCHaFOSgKLo10sPVMfxzPttl7zLb
         s1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786940013; x=1787544813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6ws6hhoYl9pEf/rI1rxibuzyydRkmy7kW/80lYzhYw=;
        b=Q4Q9E8I8b6SxRPiN5mGZllbzQSwdZ/LuknA63qcDJJ50p5yBMBQbP33o9VbopRx76c
         DXzxkv4Hvso9GdzpxfQlQBIAMJRTlwTqwdqIbBeeHcnz5erD3w2hXh7a06MQWky1Hhf5
         dXX469uvtKrOJ7dN9/3RkHPBoKJ8SztCOk6FIeqcABclIE0D57ylMqvS4vwHtVDxeBDZ
         CDm805ImL33BWIZG8PVVvv+t3hBtViFFcE1kNZRQiJckY9WpWBqAQNgQKLlcfCXatxRD
         zFdacajhul+byxsP2z8h1J89dg13sY4CDFzX2CYV9YG2mLVOBsNJZ0tchFpXLxapLQnQ
         iHzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2IwnZ/Yu2UOmsoStDtXoue4mVbAVeNS4FYy2eTzfbbDz3lcphsEA3lBeaGpcVLOhdxF2aE3eIPjQrxosPiXw2@vger.kernel.org
X-Gm-Message-State: AOJu0YyKa4VYLk8EUzVC4rwNAHYasyixVNRiNuSoYPGDh2eyZivqCUrJ
	umkjG53QATKJQAmfYuvygous/DTZ3vTMAI7k4ssSSjR78ZvFfKyPQ8sN94DTOsuoy5D0LcM2v1v
	+fmmL7+Fwp020JVwtQ934Ntmc5lPOPnQs9SVmJkQQ
X-Gm-Gg: AR+sD121ym42GMv6EDFP6yHFd7Z+ec9VOhJsUdPgJ+LGbMpKONbCImluO7+csT0klk2
	zFkS4PcV6wVsLTZlCpLM6rXzAoI8TvvEyCpl5tT1tXxwPV62g3BRoUsR/pk/ENY6CjRUZp7e2rx
	U+i2fJS085F+65S7qcFy42t5opZn4JGU1OsjB719Yon6fOVnzk9R2dJglm0d087g5p3fm/Qu8l5
	fHuYObx+XHBlkNcX76oPstz88/1thIxuMr+D2Pc6dkIA51XtO5dBXwVdpiq4XNb3L7Nt5qDw6Zf
	KkHLHONQyZL93WERDQ09AulRS13TgNoq/8V2gdE5JG2t3A==
X-Received: by 2002:a05:622a:258b:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-52db1f07d0cmr5546611cf.11.1786940012189; Sun, 16 Aug 2026
 21:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813170155.1156593-1-bwicaksono@nvidia.com>
In-Reply-To: <20260813170155.1156593-1-bwicaksono@nvidia.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 16 Aug 2026 21:13:20 -0700
X-Gm-Features: AcwNN1VNLEZmh2YCuKGehmfZoT5-qHlv3AMCfSLe-X8oH-pX3c8TxAnfrF0rZHw
Message-ID: <CAP-5=fURdj7hsk50k-KyiNQD_23KQtAYcNTvKfC93uGEsM0e7w@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf vendor events arm64: Fix Tegra410 Olympus PMU events
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org, 
	mike.leach@linaro.org, leo.yan@linux.dev, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tmakin@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com, 
	rajjoshi@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com, 
	mochs@nvidia.com, sauravsc@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:02=E2=80=AFAM Besar Wicaksono <bwicaksono@nvidia=
.com> wrote:
>
> Fix two issues in the NVIDIA Tegra410 Olympus PMU event definitions:
>
>   - Correct the swapped MetricGroup assignments for the L1 data and
>     instruction prefetcher metrics.
>   - Correct the name and description of implementation-defined event
>     0x0197.
>
> Patch 1 resends the original patch from Saurav:
>   https://patchwork.kernel.org/project/linux-arm-kernel/patch/20260511210=
832.91408-1-sauravsc@amazon.com/

For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Besar Wicaksono (1):
>   perf vendor events arm64: Fix Tegra410 Olympus event 0x0197
>
> Saurav Sachidanand (1):
>   perf vendor events arm64: fix swapped MetricGroup for Tegra410 L1
>     prefetcher metrics
>
>  .../arch/arm64/nvidia/t410/metrics.json       | 28 +++++++++----------
>  .../arch/arm64/nvidia/t410/misc.json          |  6 ++--
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> --
> 2.43.0
>
