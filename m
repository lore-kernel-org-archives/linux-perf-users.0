Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7F185B67
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258359; cv=none; b=D5+BbDKYcWWduzSZ/h2QE6LLK8hZUJoiB3sYnmyZIzNrdirfPbfKCRFNYC5253VMeJGC8OFM+F0zS6enX0cPZUqYV7dpUS6W6OaUkGBgI9ShVUVACDheAoHwRvMhyNwSLMMBTCQatYep+m/33ZNXfQADp21GNZ330Kg7hqDwzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258359; c=relaxed/simple;
	bh=qs/dHe762bV5YYzQJdDETbURb7lhwTiTQk/egCiACC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxLDrBvEF87q9SmQ+5mONQ+ZI1WEe2cuDrOE/SieCUqwip4WC30S+6vy4FYmkEfRlUb2WLT1DMyPBwzcqysSKP/CnPfAXJZVzI52N5Pq/bjA3gw5aCIFaVMR6k+zB1j94vz4qmmRP/SZZZaJUA2y4GS9o+PQP8l2+wBXVYj8YBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blp2gR3s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blp2gR3s"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eeafd4882so40615ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759258357; x=1759863157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmJKMGcqxpp0JsoAWSjrh/NPC+r2Fp6Z3vCsbhcIyQo=;
        b=blp2gR3sFwmS2Tr+BKAVmcPmF5nYJ58qsdHs+B+lL324vB55KDUKPmUucqecICPphq
         Mqd2++r0HBWpVEomTOmClQI4DWCl1O5jKGohXKlAfUDjK3ylt8KAacr7Lg0OHoHSC73/
         u7oodeYKvJu1kBfPNYxSuvbzsHVGrRKvGJu5/7HZFtXxFUEBNuaw7HeQxiZB+aTCZS1h
         z41kwXsgLEm2lWrHG+50dF7XFndlpmsW5HMU7uPrASIsmzapb9igd6JGBrYBmLINbD+g
         yP6UIoJdGi5E/SdEuoLRDiejr93dO0ZtW0LfMN36i2YJUXIV3QOlQcPHdA4+VBtROBTc
         ZjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258357; x=1759863157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmJKMGcqxpp0JsoAWSjrh/NPC+r2Fp6Z3vCsbhcIyQo=;
        b=hufOA1Si2F79655elQ5wXX0aqUxe5yQC1MkulsssjOizniXXMsAm37KJ/OiH/2c0OV
         aOtJLvebekK3+/Omby1ABFq7t+9M/PKPr5vBkEhJqVc6Rt3RlO0RzEmvB2Uo58V0OCAo
         e9IJHpOQA+lhNmgqJYArCNORJlW4d6ItMz0SqknEGLs6+9vcIUMm3N10cOMbp9856OEq
         /V9Lqaxk9x3dvyNWN0J3tca2wO31CfXmfWpKUwiLJKYcgj+9xUUPeKb1b9ZjtMdNGIJA
         xh2bAdr7zjFNnF14vCDUqLUWB9mLchLQS1AVzIa3nkkELXSv5cD3qMcML5TlodYwTOXA
         n63w==
X-Forwarded-Encrypted: i=1; AJvYcCX/8TDL/dooeCW2oMAbXAi/AhaSGXZfQWsKhSOVzdh0vqJy19VO/ZKQZ7ANTXn9r96HJwUX/F4zhuVqrld2grXe@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLuP+LXgBNo+VCzGpyV0Dx3yyoLXmj+UXDVfHOZrG1kQ69rT/
	v8XorzKl1VW0kEvnUlRgA8czCyhAdFdEk4dHK3I710FtPIuWUbOLNpJ14CXTLb5RP2AnPy1W/oK
	EgYqlxQ3JdjewtmD03pgy8fR4P9rWNDX8uS/cTNhB
X-Gm-Gg: ASbGncvAmfAyik3gLELpkB2zXmRmjHtwepdDL6lU8EsztiNEnGy9tHeSp5YcgscsKax
	8GZKGBIU76gYs8sAg+0UORv7ytX+mGD0zmCp2P8XDLgvKEHrFp8q+DT1xcMryGhEA68RHPOfpzd
	Q8JJ7Dmp/NHwRfyEobK9ExHsDhDxgJ0RKRF1/ac93sCvJHm3LR2zEAJB2Zkz2ym6z13Qj+j0Mk3
	POcOuQDm2tHlT686fXcgPHCRgsY50+erbbe2XPdArBgl9mAPnq9omTT8XWqHUh1u6n4bFvH8u/X
	tkQ=
X-Google-Smtp-Source: AGHT+IHJVPbpJv2BGYgLOZmi1yTD1bJ1cFgoF1A8/A0wlvsAJLtJM6ndGtA3WN7UXflYMH9jQ6JFDJjazAvvDadob6I=
X-Received: by 2002:a17:902:f68b:b0:240:6076:20cd with SMTP id
 d9443c01a7336-28e8027af3amr589105ad.15.1759258356402; Tue, 30 Sep 2025
 11:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930160923.13728-1-jbrnak@redhat.com> <20250930160923.13728-5-jbrnak@redhat.com>
In-Reply-To: <20250930160923.13728-5-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 11:52:24 -0700
X-Gm-Features: AS18NWCCjOSF-i2R8t1TPtCIdm_r80T0WNosW1A32X7-IWyjOnPrHz0holICLOE
Message-ID: <CAP-5=fVObnp3WP9jp03QqdEsd4iJNimrWhGTm4YfU+PWOCDESw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] perftool-testsuite: Add empty setup for base_probe
To: Jakub Brnak <jbrnak@redhat.com>
Cc: namhyung@kernel.org, acme@kernel.org, acme@redhat.com, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:09=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
te:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> Add empty setup to set a proper name for base_probe testsuite, can be
> utilized for basic test setup for the future.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/base_probe/setup.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
>
> diff --git a/tools/perf/tests/shell/base_probe/setup.sh b/tools/perf/test=
s/shell/base_probe/setup.sh
> new file mode 100755
> index 000000000000..fbb99325b555
> --- /dev/null
> +++ b/tools/perf/tests/shell/base_probe/setup.sh
> @@ -0,0 +1,13 @@
> +#!/bin/bash
> +# perftool-testsuite :: perf_probe
> +# SPDX-License-Identifier: GPL-2.0
> +
> +#
> +#      setup.sh of perf probe test
> +#      Author: Michael Petlan <mpetlan@redhat.com>
> +#
> +#      Description:
> +#
> +#              Setting testsuite name, for future use
> +#
> +#
> --
> 2.50.1
>
