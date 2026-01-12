Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C103BB40
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259773; cv=pass; b=pJf+xaEPWknajxQDqsCuKk1bYONGiy2sGU2pv1GwYF+xQN86bEzZk66AcggOV/IcQfwjHaL9R/wPFtlGTqhEUIP5mGMKwDsExDy+Yr8fGWqB0vUiq+5eLhc7uzVjUTAFUZ/f9QXe4w9sfoEv7yVY0cK64opo+KntWCF4qIbBQjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259773; c=relaxed/simple;
	bh=mEAVtYq7+eSBK4S0e4JR0ieTSUePPZMbVRfcZHHD7QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5l5DHUHmU4kn1ZZijW8vreWJAKZOmS8LXrjVsqrNEpjjiNlPi0A8x8y4Nua1tEg36n2rxVnEWWpae006dHu7leDJGafKdQeRfKol6igvNx+yYcsTIsBkwl1iRcZ/FTDFgqUi6EnXUbx2wHnOkadQX/q8iCVcuCj7K7/lOsEqhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAfgsX6y; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAfgsX6y"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11f42e9977fso1355c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 15:16:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768259771; cv=none;
        d=google.com; s=arc-20240605;
        b=K0jEzWmGZx88Rxy7ehxFtJNo88GHws14AmIe2EV0dLnKZ63X60tSagNa2gBRe2gNzj
         SpqqykHJNXCHThCBql+AO4jIjGOkfQpCtfnrk9NAhW5eXE5DOq92jiammVQ/HpkAmUvA
         x3U2KWMdUonW98aUCull4ljLsaPSnebrPRyLQmq3nBERk9bd8GBM2Hsy+ssaovHJsM68
         yHpexV42G5lUZAFCsgmc0kCVciG28WGU5WmOvZ4QN+K3KcLcGBRKQl563GhoHEyoxq4R
         x/KheTLA6nlZSS5sFNhUDYx0O4Q1Z3HWN9SwEslWAoe7WjlYgMuvE2w9TscQ4t76mM6I
         e4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LXHXUVxkBmGv17lT6MoRuTKqPhnVYQ4ci/vz5gUo1Go=;
        fh=gjdi7tg6Q8WCjj+6poVTtpM/l9xUqw9pi4VSgdxPEP8=;
        b=P1RAyFjW8bo0LE0dzDnEgzOGcaPpiRi+gJoRwwohUNev8OKqdYD8qpuVszFrH/Vqjm
         FwwVuVTvKPg1aLZzcSN+6QRe0J8ETejydiYIrTIMRMiPVkllCiTMsVtNkYlZQNN9mAGx
         liaBUWeiUmacN2OSY97qdrJ/aYP2E0gW+VVoFKQ957sjNLToeT0ZfOXQcM2mkMdcMCwu
         Vatf9IPdIs5lwHtW2zAHJJd0RDFg3J3wsPYuIVfY8oUYqSLhTmc1FGyp0hQMMbTiosyV
         SOSizsbySVdlBFaNTA9b3+O9/xCJ44QggahzKIrpUQD+Bk3jOoVtAPcg2TnJt8oklTfP
         NZbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768259771; x=1768864571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXHXUVxkBmGv17lT6MoRuTKqPhnVYQ4ci/vz5gUo1Go=;
        b=EAfgsX6yD/XFkH/RgpuBKwB/L1mw4VxTTyZL+LNLbBlBH+Mk3THCRCGeQ5cPZ3Ja61
         KRIr1pCTM27u4CKo5eZmgsk/0nWtE1ur9IuhFDNqqCAyrsAxbPVAbnWnrpqH030q8m6R
         EJuTu8E5GoMmSv3BvuOObYNPwxqpDEP6KC6QXWTKJKAeUFRPrLEZ6Ty1a99iRNpwGJo6
         BpdnlT5gAXCcFdcb+DVDQR315lgTMVpT+d3LrlYL4XkkOzxKFmy3/Mbx7xXH1JSeH1it
         vANKB5HtiPkZG5kaPHSJcto22zUmlsQd6OfnbXCIezT0vrgQUsp9dyGnLg7eECHLMUIP
         Xfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259771; x=1768864571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LXHXUVxkBmGv17lT6MoRuTKqPhnVYQ4ci/vz5gUo1Go=;
        b=WEbZHmKww13nIBuwcGIv4n8xrxJq4kgAvNpPajKzmgYqGdtWZNp2CUunn0WuTAMbfB
         JQ8uP5qa42fNoayDHLSAt0ek594ZYVcP20gdUhXBnPpyi9gHsf7vzdQx/0eeaHJpp6Hk
         SVhoIpu/k+J29JCAzHTCzff+CTz1CK967YOKN8XgDrefQt0AyxAArodDAVxANO5CZWgw
         DOBJbzwPH696m9ABq60YydQLcsxppAqo0AC3Xz4FCrkKFjg/6h04n9KegmlQPO4dYezW
         zlfZ7eSlR0DOEBnweaHM8iUIcRJfypIGRwxAPsoyKYfXF/SC5lvD6OZDRP95Z9WMVune
         FekQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhJfUp2KfUaFG7G/RdKPU7x4Eh6qZddfSiy1R/B2987W40OrNhu0OQ9KywxG5JtvvUCPnbp3qy4MWO/3xjznNR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gty55sRf0S2Z94wL6KtMiRBBnltWeBKZXNVCThMCIVP5frOk
	yk8CGyg4ocxb8UOU65KR3tcRGutvc5AsKAQnttmoshO4PpXnoyxzMOh5eyNCXk71pFRy1v8tISB
	A4t75OH/YKr9TQLSGnghnqZlfA8dRCbK6PcpIVgtY
X-Gm-Gg: AY/fxX7keakbkSsM/xPfTHPlw6u3jWY4WV2bcfsq8LcF54nyNrNSkEoMhNgUoACPm4p
	0/ZBean/T3fTBdf9jQqHVYmbzIJB5gO0cTdVIYavLt5D8vjD2R8H7fOS5JShu+GcDCpWShYUPaM
	oPKGyaj7kh6NvUZVam/Xc6tAS9lxefSuwVWSKoPVOTekVmjHpOWtWzXHFRrAlVri15lteIOM0DG
	s8TIsmqq20rFf9PGs6gC2S/PXv7icbaB2hHThMmXrZhD+kU5kzJtsmZjMCIZTEboAF4MID7IOnf
	3+q+r/bhhKVMo2zSGGNyw4Znn+mBm5I+Dp5h
X-Received: by 2002:a05:7022:6709:b0:119:e56b:c1e1 with SMTP id
 a92af1059eb24-1232bec76b5mr38947c88.12.1768259771191; Mon, 12 Jan 2026
 15:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110011715.1642869-1-namhyung@kernel.org> <20260110011715.1642869-2-namhyung@kernel.org>
In-Reply-To: <20260110011715.1642869-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Jan 2026 15:15:59 -0800
X-Gm-Features: AZwV_Qi7EE0aCaB1PkoSPf9J99rNGNV3ELooQivHTzLfsrHTqt196G0IrR-MIpc
Message-ID: <CAP-5=fUZ_BzjWdKOrjufceEqwXVqr=Mtd4Y7vpU+NcKMBy8grg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf test: Add DWARF callchain conversion test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
>   $ ./perf test -vv "DWARF callchain"
>    87: perf inject to convert DWARF callchains to regular ones:
>   --- start ---
>   test child forked, pid 1560328
>   recording data with DWARF callchain
>   [ perf record: Woken up 4 times to write data ]
>   [ perf record: Captured and wrote 0.908 MB /tmp/perf-test.nM3WoW (105 s=
amples) ]
>   convert DWARF callchain using perf inject
>   compare the both result excluding inlined functions
>   ---- end(0) ----
>    87: perf inject to convert DWARF callchains to regular ones         : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/inject-callchain.sh | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100755 tools/perf/tests/shell/inject-callchain.sh
>
> diff --git a/tools/perf/tests/shell/inject-callchain.sh b/tools/perf/test=
s/shell/inject-callchain.sh
> new file mode 100755
> index 0000000000000000..a1cba8010f954d21
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject-callchain.sh
> @@ -0,0 +1,45 @@
> +#!/bin/bash
> +# perf inject to convert DWARF callchains to regular ones
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if ! perf check feature -q dwarf; then
> +    echo "SKIP: DWARF support is not available"
> +    exit 2
> +fi
> +
> +TESTDATA=3D$(mktemp /tmp/perf-test.XXXXXX)
> +
> +err=3D0
> +
> +cleanup()
> +{
> +    trap - EXIT TERM INT
> +    rm -f ${TESTDATA}*
> +}
> +
> +trap_cleanup()
> +{
> +       cleanup
> +       exit 1
> +}
> +
> +trap trap_cleanup EXIT TERM INT
> +
> +echo "recording data with DWARF callchain"
> +perf record -F 999 --call-graph dwarf -o "${TESTDATA}" -- perf test -w n=
oploop
> +
> +echo "convert DWARF callchain using perf inject"
> +perf inject -i "${TESTDATA}" --convert-callchain -o "${TESTDATA}.new"
> +
> +perf report -i "${TESTDATA}" --no-children -q --percent-limit=3D1 > ${TE=
STDATA}.out
> +perf report -i "${TESTDATA}.new" --no-children -q --percent-limit=3D1 > =
${TESTDATA}.new.out
> +
> +echo "compare the both result excluding inlined functions"
> +if diff -u "${TESTDATA}.out" "${TESTDATA}.new.out" | grep "^- " | grep -=
qv "(inlined)"; then
> +    echo "Found some differences"
> +    diff -u "${TESTDATA}.out" "${TESTDATA}.new.out"
> +    err=3D1
> +fi
> +
> +cleanup
> +exit $err
> --
> 2.52.0.457.g6b5491de43-goog
>
