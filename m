Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CEC3A453F
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513314; cv=pass; b=hdnFX4R9GdJlBLw6J/384BvBpp5PCcrJ7LRwm4TppwOcchYbpZq7DZPUf2CMLAsgMWWld0OKe0qh46Z/h0yiaCBN112sAfSyhvDbg9pWO3RpKXrXvoGD0vytvkh3a29sjcFvItT2040oRsdcy0t4ykxP9ruC4p3c8EctZE+1TYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513314; c=relaxed/simple;
	bh=BXduN/BYnHvSIca+chTMm8KKfn8pMqAMnzQR1MaogWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jw6qTtxUOx2ItmFy8KSqj2FCRL+0zq65jgpMCv/LslLKry/HlXHEfr7KVMzKyl813KbRHT1o0ehFWPAuRPaQrywIjG8tqYFB/4+XbdBOgewJNfRqgyIZNmWFxk1zADcsCl4PPmxqoMzmABjP3uEMyCU7d+nSKghV7koJyN070qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fropvtvt; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fropvtvt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba180a022dso265ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 08:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778513313; cv=none;
        d=google.com; s=arc-20240605;
        b=Ug0W0owYMNv352kWdJh1NBA59uTPQKfoAkPNAqhklmqRF89+aprIcsdiGqnhQzA+K/
         WB9imCU3WQfjWZciC/tkZNMmFe28vkShCfC3Dw6fAC5KSySEwbZ0mGJs04zTxNHNOuaN
         7RPXIhZUtzKHhhb0MXnNkaHUBjonZAvWZDYKvtHzJ3ferWxY+74H+nLQFQSiq5eGiiGG
         L1cJvVW3AJZai9tFayEWxQtpjfxZktzqxz1xfV0vN5eGvaHtc+3UgFaOoRL42jIpE+/x
         TDrUZ6aVnUIaFZKKJYHCS58dBJvLiL2h/U+4RWFYESno8vdkhf0Yk23wq0WgD1SQLgef
         CCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p8REcFcYNRw5/dDIm8v37mlEB1OcP3CL0ecT+JMfoR0=;
        fh=tbJVvj8VT5boZhbN+0fjIoJU9GYiQ1Za63Cy310TPsw=;
        b=deA+BCtfKIPcYi20wWODeQ6ocDgaTUwxh4XjzGzO9lrvsXwJy4P3lOHzpRSzcbmI/t
         W5qN8aIt0x/T/8MUz5XXoi/u7dHx1W4hhtk95ClC3RQTbBILp2ZU8vqhArB18lYbK19z
         C2D86kEWNjyxLdMFt7c6+uxkyDp5aC6QqKXkJYQTpeuLLLzfwUkVz7jX5iiatGmbtqi/
         KnbyfsNZUemB88wb6k19tT+4uiySjtEtH9C9oRqQr1kf2xtD3KmoL9CLmDydrsNSpq8i
         5Ww0kvKy9WFppZqgIzK/EL07+yTXAckEJMXg/6nVeKHrdR1/V8Zq1ofwjvyOD6bhr9Ia
         Yimg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778513313; x=1779118113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8REcFcYNRw5/dDIm8v37mlEB1OcP3CL0ecT+JMfoR0=;
        b=fropvtvtvh9+HoSgbfo3ds5HH8koOmBCGsWXKaQon888NB6cGUCEU9DmkgkM7ofogj
         wVz8HyZi/G1MsNgJKMJprf4cTVq8GS+8TWVCrEKwf/N5uGGAvy23ashy5er2cSE+fOOQ
         /0gsqx3dhNi252s8zAPNOJGoNXOP+kJ/s3Ovlirfcxwu433dsoeOdZPf7r0ci5Ze6GF0
         hrHhAZ+LCV9HC4yVJm77mhXmzX5DKtfLiGa5KU1jpPPgpznXHcMLcL7DbCr+hIFlEw18
         Hk0UcscEAkWX0XOAxSgnWZwS8O/q9/xPdGb/L/e1FQGspa6YyyyR+SYNswM1AbVFtaFG
         8NRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513313; x=1779118113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8REcFcYNRw5/dDIm8v37mlEB1OcP3CL0ecT+JMfoR0=;
        b=jjrS6p204miBoVT+1KVSA1NJEPOKhaESqwsZpU8dDOkpRb1ITRGuV9u6qCO0iF/SH2
         xqKAsc9p625DFGiKqM0MryjTqE6hZXeuN7nWmEh/CRbDMFegXGG/Y13dshWXOnR+JPJ1
         XZrTLIm3v5P5Usk+Th61213JHEFlQtUjcGKU8jVJZujrYfYGgoAIuv9ilh/axC4gl3Tv
         62Hi4FxfCgk/ypSPoU82k4tdFJoyOdL1irs82fvLX+vO6NUlqPelX+geb6lFMhoEpg/d
         DPzHgx81SE6Mt0q2e3dbHvpcjt96SD8OO//R2jwEnrXHddVcekkyGszvc1KYzou704hu
         Q4Kg==
X-Forwarded-Encrypted: i=1; AFNElJ+igA27hknabWuCHiA9eSlE6MHqqzUPh/0YNUUAC6WNmSlQXVIS+axuKjf/Vwj2t++G5bfPLeSLqoc4qpRPTaKs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz968J0+Kqgk8rojyw0DO4igDFRA2wtbZKv3LV8SaO1RV6mC0QP
	vt4bs+83fdBRXtKG4+1VE67OeJkDFA86h6Uj+KZMHwbIvLNoAuHtpgk7ert1FU/EjEMAc6kqUTs
	HLAsd6YzoAwvgxVfNjKka67TVdiyF2cDCa5sNcbfs
X-Gm-Gg: Acq92OESJdLJLjJDyVV65EQJx2L3UgwJAqegXO4FbU+mUXpHfvoMXbfkuEDWRDpjujW
	wjksbWiAMrfyb/Hms98IVq4VftTXLcLVixD/YL/17ODhtz9vx7q15C/sdZ0A5HNYQINfqYzpk9i
	8uiQizd93xGDEBQMXjZMckRIE1o12ikWxKGbBG38TZZnfTF7FDP67X0ui00/0t6ZEmUEiH2FQso
	SlVNvWRN3JKWzqJGUKYutuGLJmI1WWcj0RIRrEZuHt+zIfLbBCnnxo0qiYo2PtV7y+TEBytMkB2
	p4q+3q5NMiGPICloiVWK+eDC3KkR/w3QCvEnTR/qiHvBoGGP
X-Received: by 2002:a17:902:f651:b0:2b7:b03d:9dce with SMTP id
 d9443c01a7336-2bc747e01d5mr5578935ad.18.1778513312304; Mon, 11 May 2026
 08:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agHHR56pFGeDJOxE@x1>
In-Reply-To: <agHHR56pFGeDJOxE@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 May 2026 08:28:20 -0700
X-Gm-Features: AVHnY4LVXsjTmJws9xHjTo8zOrDngttSrU1-r40chJ3upAS6nph1rQ2EZpyU7YE
Message-ID: <CAP-5=fWnEevjKwhQth5bZDsq0pBqV1=1M1OYOqR2YPNw0OL4LQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests data_validation: Fixup test header
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 5:10=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> We made a mistake by having the SPDX comment in the second line, where
> 'perf test' shell support expects the test title, fix it.
>
> Now we can specify a substring and have that test selected:
>
>   root@number:~# perf test truncat
>    84: Test that perf report handles truncated perf.data gracefully (no c=
rash, no segfault =E2=80=94 clean error exit).: Ok
>   root@number:~# perf test -vv truncat
>    84: Test that perf report handles truncated perf.data gracefully (no c=
rash, no segfault =E2=80=94 clean error exit).:
>   --- start ---
>   test child forked, pid 62890
>   ---- end(0) ----
>    84: Test that perf report handles truncated perf.data gracefully (no c=
rash, no segfault =E2=80=94 clean error exit).: Ok
>   root@number:~#
>
> Fixes: 24be50a54cb38cb4 ("perf test: Add truncated perf.data robustness t=
est")
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

I plan to send a patch to improve how the test name is read from a
script. It is either that or continuing to spend time teaching my LLM
not to make checkpatch.pl happy and thereby break this. It seems
better that we just teach the code to skip lines containing SPDX.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/data_validation.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests=
/shell/data_validation.sh
> index 649f71b6cdb93202..f8fcc4c0448b0c51 100755
> --- a/tools/perf/tests/shell/data_validation.sh
> +++ b/tools/perf/tests/shell/data_validation.sh
> @@ -1,7 +1,6 @@
>  #!/bin/bash
> +# Test that perf report handles truncated perf.data gracefully (no crash=
, no segfault =E2=80=94 clean error exit).
>  # SPDX-License-Identifier: GPL-2.0
> -# Test that perf report handles truncated perf.data gracefully
> -# (no crash, no segfault =E2=80=94 clean error exit).
>  #
>  # Exercises the bounds checking and minimum-size validation added
>  # by the perf-data-validation hardening series.
> --
> 2.54.0
>
