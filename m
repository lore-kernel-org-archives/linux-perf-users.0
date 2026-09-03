Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EEA401A21
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466772; cv=pass; b=bsOpQrUx7iAXZoqBnaPotwr0GITB3q4SNw+YQJkCRAtaIdTvBKcjUAhnrFGO4hbtelPW3C+Z/efNtVbobOlY696vLGD2iKYeyAiAOCVPJxujnZCViHqmZ9lgTv5bz3EFSWP3RfsR2qO/LhguPhNibDNua+9tBFyLo/R5+xdkzNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466772; c=relaxed/simple;
	bh=61uMKuI3tXO8Qfl6r6fbs0W9TlQX4bskjeLyIhYPqIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKHiJnG7yzHkZVxH3VvO1VPotp9wG25s3Yixc0L6OdOXbWrhBZ+36VSYzQ6/Lp+eKaKa7m+XK0l448uNIyj/V3Zn5KZNwG7BKt4MyLmrHjKOshSPsvWDbOYcdubDBBoL3pD0AU/mfHVV8wL9KgVhdzYzvZE31UUsX/UWoR5xOLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mj84xjK9; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mj84xjK9"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52e3de6309cso399051cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Sep 2026 13:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788466760; cv=none;
        d=google.com; s=arc-20260327;
        b=EbZfL7VF90e4CoRHP3x4EJQ32eeLOfCQe7F9pFOrSpHIGFsggnFb27D/d0AsHn3GHO
         nn7+hz/a4BXqTxc6rEqtC9glh8D6E1uKSleMSPUmBuO75JocuH34vwp0DvegUYTmkuVq
         7v+pe9PGnYPGVE+dQpP+mf4h3Kp66tvY7NEYQeZowWXhYtknWOSrYlmNb21PnEmfmn7/
         sCGu951ncwPBwI9hcCOyrOiTJCw/pEDwV9oveOhGJ/9GkRMlhdixDqAp+5UeYUUp4iXM
         nXgW43zvoL5LzXbwv8pSMn1uwCo5JkdbiMNt1i5poNNwVogwYnJFDTIV4bfF/lwI9mlJ
         +gnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LtHhJLDBEdXHkKgeUK5VSuThCr817qPTzSy2D/lDgsM=;
        fh=DkUUAoyAITNay/Y3ROnawvFmALvt/uthBan4aGExBRc=;
        b=FnQ1OyGhp/qzLdDxva6/ycVeUVQzP3S+QrfWB+3hwrOBbumcknwdOOBtQyzR9hDUr3
         fzY/cYi4ZmytWoS4rq1kcrGPnoBtPg6Iz3WAEqrSLAgNETOJ5TcHANUWG+baHaXTOdwd
         TGPWrV80YQiQuJIVeSSdghminlM9WNU5VhR5XQCWV0rT4yiYV1r9I4lXuo89pfmt1+bq
         f/2YcTq9huaDeMLG4+mxtqMhbls9hiffJUXr7TkoS6aVFuuqF6RQKAiYylrrgUjdihpg
         +uZC7qJARySj28vQZL1ifV2zPln2wo+ElUNebL+BopycKG0o1anMzrtZHWg1DkdU5zmq
         MxKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788466760; x=1789071560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LtHhJLDBEdXHkKgeUK5VSuThCr817qPTzSy2D/lDgsM=;
        b=mj84xjK9zlACYEaL8oaVI2GK3Wt+uUKCj0Y5gnoM4Pd0YwHLNjmw9jZf4hdaZHVDmZ
         JmfxQWo9qqxRgUawSaKgJTID4sy+KMctKuGspRXG6mIjcUI0BaSjXNpdsCluXgHsZHFh
         BSmuLcPzi3DF2sUI6RBIsLKjNQlvLbvGNW+gafYMhcfT+j6Wg2V5K0jjnHMydSfJFvdN
         QgQQg2lNW3UvWoq/Nk8n2M/8ztInp0O4a1fkL7zy8KVR0e8qJ+Ycmaen3Nwdm28O35px
         5oLvfqbz2rRx8pEH9UivmM1hg0Ew/sXp+6uvht2moJiPDJVDkMSCMTiEmo/av5QLoaV3
         mn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788466760; x=1789071560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtHhJLDBEdXHkKgeUK5VSuThCr817qPTzSy2D/lDgsM=;
        b=Qh5IAb7ZzdcmoSK/zOYG7pIFMfdRBr+5Un46wyMZtLw6UThicJeRli0XIcwypWxkR3
         lmTmKeePOMzDCYLt4D+tH5r8cVU/5yYKpZ/har0waDYYNR+JlX9feqZfF56XZkaGsGvB
         jO2i2ySBt5O0195ApunTsyQTOkorewGnyQ1VTRAaksBuBq5XJ1rT31J8KTN62xmRJmdE
         F6GcgCRU6FMUJQngJVMv28eIukYCHKXiAbLGjltSTGBQXYLw1DZzWM/RoBwpdTfEzBkG
         FNo4Mv4HaB4FXF2zY20ETRIHoSmS98pD4C65iRpZuOgTctFyBf+HGgjlPveP9DY2UkmX
         FHOQ==
X-Forwarded-Encrypted: i=1; AKwUvByXg1XZtn46xYGW2S5Lg7K6FxbfrKAKyZ0z6deRPHaXMOldFlckDsoMGzA0pHUZIvbLkmiBX6ZDxD2X55t1OEe9@vger.kernel.org
X-Gm-Message-State: AFuF++npTkJdqFVVYZzflwE8Gy35Jdld7rjxTxLXqJoWVQgoH4yRZKnU
	rJh8SjW2Zji7O08lwOPmUmKAgd4O39JzA17rehUXBzYOGYdvZbkpaB78zorpvAc+saWWhkWTeM/
	htcCNL94yD49HH2nl5LKaJssxCN7jxcKY0E3SCCPy
X-Gm-Gg: AYBFou0AxgCwziI+1yNvQaHBkCIPa7pTYubhfs+I1mr7XrnRLvegePueyMNuPVBSnaM
	ZZCWrq7z4aXoByYzns5NpEhymbAoV9HSyeMxPLiZRNdDS+Dv7QKZSb1gg5D4qEiyuAp2HeaK+kO
	pcp4MF89aN9BnJ4j/7ZEGBTjylgNdcARnxmHSLUyMTN+EbDH8r0c4v0j/LvL/wYYzcS7RwJRsgn
	0rwr7GQoSlUGtlAdQZH7/Y5kaasmjkwvAUVyUKTBc3cwy67cK79TLth1UXA7J7QQNf9N+eWMdhI
	evKy0zSHI5btfcl53KZOnJ9tyWwlEwcy/okuD+rKsUH2g5DgdNBK9sT2oAd3IVa/vIdHEfoK0g=
	=
X-Received: by 2002:a05:622a:903:b0:52d:9d62:6163 with SMTP id
 d75a77b69052e-53055c4f251mr1561611cf.9.1788466759468; Thu, 03 Sep 2026
 13:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
In-Reply-To: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Sep 2026 13:19:07 -0700
X-Gm-Features: AcwNN1XK-N7twBaAZhkaw9Vegqsfjdmj6p3WSSQYw1RpFRIiubtAAmV8NKIVXjE
Message-ID: <CAP-5=fW5uHsW0wgffWgc8f5ibDf8ArF8qJW6sWzrorL44CqnNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf evsel: Validate cross-endian samples before
 byte swapping
To: markdamirkan@gmail.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:05=E2=80=AFAM Mark Amirkan via B4 Relay
<devnull+markdamirkan.gmail.com@kernel.org> wrote:
>
> Two paths in __evsel__parse_sample() use values from an
> opposite-endian perf.data record to modify the record before checking tha=
t
> the data fits within event->header.size.
>
> Patch 1 checks the complete branch stack before swapping entry flags.
> Patch 2 checks the RAW payload and the complete 64-bit words touched by
> mem_bswap_64() before swapping the data.
>
> The malformed branch-stack and RAW records reproduce as out-of-bounds
> reads and writes. Each patch adds a Sample parsing regression test that
> checks rejected records do not modify data past the declared event.
>
> Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v2:
> - Add the adjacent PERF_SAMPLE_RAW fix found during v1 review.
> - Keep the branch-stack fix unchanged.
> - Link to v1: https://patch.msgid.link/20260903-sympwn-linux-002-final-v2=
-v1-1-7c6e4166b814@gmail.com
>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Ian Rogers <irogers@google.com>
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: James Clark <james.clark@linaro.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> Mark Amirkan (2):
>       perf evsel: Validate branch stack before byte swapping
>       perf evsel: Validate RAW sample before byte swapping
>
>  tools/perf/tests/sample-parsing.c | 109 ++++++++++++++++++++++++++++++++=
++++++
>  tools/perf/util/evsel.c           |  20 +++----
>  2 files changed, 120 insertions(+), 9 deletions(-)
> ---
> base-commit: aadea57f532882d8bab444646863c7ef8a778ff1
> change-id: 20260903-sympwn-linux-002-final-v2-e30a8df210c1
>
> Best regards,
> --
> Mark Amirkan <markdamirkan@gmail.com>
>
>
