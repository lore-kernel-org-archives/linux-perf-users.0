Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906C27E04C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855286; cv=pass; b=XgFu9qinVnDRF+taGEFmImgH14D6mLOBSgqdMZKfK+MPUo5Ou2KucwhMsQlj1E4mQZqieD3UTV0V81wB/dfUeZPlOQIl1LleitGbnIrFm597X3lqVwgb2e/MjHGsLoGLgz9y4P10OZZbQ6cAxxyrymlK27osqttrbt63HFn4IZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855286; c=relaxed/simple;
	bh=/uGYZMdhA4ZCkX6DVyB4qeMn3LOXxhzjotizcYAFZLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE3oSrVq6HMMTG+/fSX2CS91cFCA7BT2RZxBky0Myfoo2Z3n1hDcMRvsw4gCsTqZnlLP1UX8hbKfb+V0Vvz416EmVM5kEMH3exD7OiPvCP/skTWdUdT9doUh2lyV3mi1EY1RyOUoDSNUOlNN1yRO7NzpTXQxii1jycxaqsFZLF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G90ZwBqQ; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G90ZwBqQ"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1270fc2bdf2so915c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 10:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773855284; cv=none;
        d=google.com; s=arc-20240605;
        b=Z9wh9bxr+zI+WqkGZSK95oVSaLjTdnYcC9lE9SB+gFASc3uP+8j4c9MNosMiOaiPGS
         yW8Tkn46uiqG8u3HBrxg3aKQNl3KspotiTiR4ihqnUhrBgcCGHPWnxOFnKIgqoZcDVZo
         A3r4NVWm4Rp1De5JspxAu+wey+7/mxrPc8et8nn1IMsHothV4dP4CIT91IP7FM/Dl/f8
         Af1EfyVq1qB5kXN+NCnPA4j2QAaVf8N21e7DgHPtiT29zN69oOCqTXrd3Jk7AY35OZ7D
         DqKa+DlKP3O/weeOtPrSgfrl4QbJNpd1bL9nVqBttrlcmblil2Sb7WFiU9BFUQkABx82
         AtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6lY61x6ncYeO5/ECHa6x2gozt9+BQ6WvQ1ND1ZlVjU=;
        fh=6RfGgyNkhwHDLTCIL2nYxDiuK222bqVPRR14r8ylxPI=;
        b=OUKL8AgBd5UuofYRbClyiiX6OhU1NZHrsaAAgg5MgewiPWddeV6OpghPGp8jrhfL36
         dFGafcPRX6vqJIcNhbiXr1Y5wWh3IQlTCbv4aBsFsPEcmU317WrtrEvivaZybpJeM7w0
         fTBzua8TlsY6YrvU7etRmhJ3nnnHlOB4BK8YM6vufzdcbok6ICnoI6M9XD502FoEASOu
         hSK57i6K3PI0ttH+6jKse66vWeWCH2jawdIrLAX6GtzdUhpBgpF2OUS+yzOYn1zqwp91
         3znj8b2/e2tITFoR10xnkqpQKDvPmN/+rjmqhUed7fpoENJGTbI2NXGV+NRKYKYXEC26
         b7DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773855284; x=1774460084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6lY61x6ncYeO5/ECHa6x2gozt9+BQ6WvQ1ND1ZlVjU=;
        b=G90ZwBqQy29Kf8FMCgxrUCTxjaSr+aMA0reld2fBkAEPtkTbN/m36+yZWuSQJGTmyP
         Ngi6fr9QR9v2FKBQiV6GPHQ3WNWhEoJed3fVd2mCdbY99ifaPuH4by/IZYdoN5v6jhWu
         lj2wJt4A0Tkj69Dq6zKRJvi0giqefwBlaUpyHTSQ4I/zU1M3ruMH29wxYKDK4IfHQGuy
         jI7n+c1Nv5g9lIbO77RNbWchzEEwapqi0Euw5JsdR+Lp2rztuDwMxBkhzapB8BL5n89e
         zsyTvV3rea/bug+BpMAFMjZKQNcCXvaS2NNuegxDruLMOXNQR8z4y/yJqNTqrSkPPLHy
         6w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855284; x=1774460084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6lY61x6ncYeO5/ECHa6x2gozt9+BQ6WvQ1ND1ZlVjU=;
        b=oJD7tFdFIvRl4prd6ENXZR38XJNfAn70nXbKgTe+4DoCilgH2yiW6B8y8Njaeh9M5c
         eg9BUPDJI7vnWaVD7ISp49iATSEGJqBud/xyKWxIV/9SkedisDiGo3ZJd2s9Z2wlN1K7
         yNx0kNFFhcZ5kSFaLbSJJFL3uKcPoWIALyONFrZEp5O5B3EJJrs9HHCYiqwGKevXKclQ
         QHcT2/D4E9OgUbZpr2W0yGW1L0OuLa/3fbtNTM3RuhtI3F0rS+0XogmUnXHkzhYiYLVg
         3v5BO817TYGgJLpt14tYSfoDykyG8G34/e0zcCt1lD0UszDUt8M0NeY/uq7NbjV3Ki2s
         Xq4A==
X-Gm-Message-State: AOJu0Ywaio935CT0DFVwj9Dbrm6eSdNd0TLuGLLR3GLuBm83k8WcWQzN
	7e0RoNHwqaggo2+uhsc6aaZpMRRqHXpWS2dUDWavcgWptBNNIkebkNPCgAFr3mTMLO7nRIEF8EZ
	zLhDkrEBJ+FxMym6SKwgSRb566Va+mO7cJktFL7gp
X-Gm-Gg: ATEYQzwBmJYb50uRtzSeurtxJHw3jLF/EBNLicEKd2rmZx96rmacrgInVcyABfX6Omq
	iDSQq5u9wBkYING7aShbj91GA8XC1azhSYbbj1cHYM5G3K+ogeeLc6LykHiBRcOZcoirlC6UcSe
	Ys+/6PTG5CXYKeIop9W7oF38CwR05PKTus3iKbrzfkEAWLuT4caDOZV9Im4rH+GsGL7htshxBxk
	xw79UqPBIKokj+gXdKvnVimejeSiORaId8ND7NquvNXrIKsXU62I+3XEwXCrpQJyrzujuJGwcpQ
	8RgUmyIbBA2a2oL7suI=
X-Received: by 2002:a05:7022:e20:b0:119:e55a:8091 with SMTP id
 a92af1059eb24-12a68d293c3mr16344c88.14.1773855283685; Wed, 18 Mar 2026
 10:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318040422.398996-1-nichen@iscas.ac.cn>
In-Reply-To: <20260318040422.398996-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 10:34:31 -0700
X-Gm-Features: AaiRm504f_U9FnaTAdymD8K4CrOgGHKLgodk5nmr_iiSnmcJtQx-R65l9R47AAQ
Message-ID: <CAP-5=fXZWz7z4_RNPUa7_ETJ48r9oW09a-u_Fog7xy9jwXTB_w@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Remove duplicate include of debug.h
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:06=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Remove duplicate inclusion of debug.h in symbol.c to clean up redundant
> code.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index bd811b2b7890..ce9195717f44 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -26,7 +26,6 @@
>  #include "demangle-rust-v0.h"
>  #include "dso.h"
>  #include "util.h" // lsdir()
> -#include "debug.h"
>  #include "event.h"
>  #include "machine.h"
>  #include "map.h"
> --
> 2.25.1
>
>
