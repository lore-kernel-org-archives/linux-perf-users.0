Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91F2D97BC
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368269; cv=none; b=Kkb5s+UjARFWQ3Z531lFI8s7iwPiaLCohG2zIwprsQTxK2RPTV6uN1tnEysVilMiVLLD4WBJzeIcbDQel8GhYKl9aCAP2mmhFB0A2EMXN+EuhkWnPiDoQTkRgBPOraH+0IiR6v9fOS5l5sUxFJfKO0Wu8hovOGgNQbJ7PuKMnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368269; c=relaxed/simple;
	bh=VN1/pnuUZie25pZLbsZz/JJS+mATsTYyYjRzSW9ONYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn0oIKYO4x3qToa6H5dzWMbLEWromfpfi5F6OXbL0f1TA5B5EPe8HIhoNsJ0H5ztCeqXbmQ3X2F6XGX9JNrE6eX0/sjMH93vynvYSY3fChH32qQFWxkR3s9PSqkMHWjXNe2zvOiMmEw2rarmOvIopvaSC7Fe08snaJxRuKOBpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g86+W2cc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g86+W2cc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24cca557085so446665ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757368267; x=1757973067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptukJrDpMQC6yvQq7fy8/E7wgh/xTIuczpHu3sAzFmo=;
        b=g86+W2cckNyji8bEgT3/RZuVkV8MQ6hIsRpnFgIfI04LvZRf5cVy8MzHyX1oBv59/R
         ZymLgNTMkEBtFsWtxsl4bMlLq7n+Em/GOeGfCAX8UXCtu+eFeInZK4OzYJ7Y0RLWM3lb
         2PZy98CFW6da0kBcZpPcqxpXu1Wu36v20MsTSRqyaF7fOLuvcYrvDUeguhrJ0b0OaGy/
         6HRI2OJ0Kv8elLXpjedhL6svpoi0rXpnUZOu3QtW83DYUozkdfSkmAEMNng5ZvHy2IsN
         jG7QQA1LQMbmfNV+IVtq3VrDopRZSKYRpP+tadDMFlRa+tf33AfmNQcq1vMKjk1W3DVq
         hUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757368267; x=1757973067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptukJrDpMQC6yvQq7fy8/E7wgh/xTIuczpHu3sAzFmo=;
        b=CF+jJ7CRaC7QMtEmHhmMOaEHm2dKHiLeDGAtdrAGI8kvbzvpSydjojb+SX4pn0pbX7
         V76hkduwlpggwQLkcfOTiCXAgoc99R6K5gvrP5daabNLS7jGJlKeerA9qjuilNh89DUn
         a0v3SKmPBbUl7Oqshz4uYj2ohZycZvkpCrm10Wy7qW/RG5L01v5wXy7K1RyqiLqM4kLH
         2QYX0IRQFUCZDRFL3y7KAQyKXSHimJi1eLBGnHzWO6NApENsDbEyov8rhZCy7boGrFSi
         i7EqLdknAjQ26I8w4M2y0nuITeisZ1l/Us5ZIZ46iK8clDPp9mcHT+7KX/KuGvawj7/E
         xGrA==
X-Forwarded-Encrypted: i=1; AJvYcCXSEUMbN1B4/oe8WukRym/7QDOgwECMnw3Z1QLwDB+DIiaooYT5jv/E2pQvwl9oOKUqBtSZKSZUsLDb9dXGpZb0@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQAc7hjNhuPqRxjrSDwqn2lSMuyeOg43Xellg7cQyzASRE2rK
	NJpyCv+/PNEXuDET3sWpAOAjVA27HoqeH83ktvEQumJqh1a4zuNy7XChZf6iOgREAM6zaoE3YzC
	/+FhIei19OJaYrrzjuZr6TT3iusTuxXA1t+ci+jVk
X-Gm-Gg: ASbGncvj5C4Hkkj1ke1CFPtUP5hmJlHj5x38H+mzLVTAMA9wu+wHCcAx9ZaPmOVkQls
	OJMByRZiZFG7e4blui0j1qm4krcrImSxTWW2TTVyOtvxdcaw7w/o0FWK5e9LJRZKLLxE4U1Rc+G
	+4y5red8mkrx1yLjn7Bv7RxRP4/rtQuI9nris5Jt25QheBEVYb6xcr3XzD3c33IBnNnBWmIGbfP
	qhbE7uiJSD5icoQex0uTGAxIYtCZZFJIBY6LA==
X-Google-Smtp-Source: AGHT+IFXtljAmlRPmXSQo47bOh2JUAzRYbs2TGR7KxJxt04lr5eJ05ZEY/fT/oNdcobAsGgCJW2PUMmxfR77o9q35vQ=
X-Received: by 2002:a17:903:1a70:b0:248:aa0d:f826 with SMTP id
 d9443c01a7336-25114d02755mr11529835ad.6.1757368266771; Mon, 08 Sep 2025
 14:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aL9Ch_XaYTxMzFXK@x1>
In-Reply-To: <aL9Ch_XaYTxMzFXK@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Sep 2025 14:50:55 -0700
X-Gm-Features: Ac12FXxKKtVNXodXKUdoEQiJlG44mQVtYUYRrCCWg2KWWOvbz0x8DwTRDij0uCc
Message-ID: <CAP-5=fUYfZyvOpH2rTzMfoz0_uqmHRucwP=tgNB6=pigrowR1g@mail.gmail.com>
Subject: Re: [PATCH next 1/1] perf symbols: Handle 'N' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:54=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> I started seeing this in recent Fedora 42 kernels:
>
>   # uname -a
>   Linux number 6.16.3-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Aug 23 1=
7:02:17 UTC 2025 x86_64 GNU/Linux
>   #
>   # perf test vmlinux
>     1: vmlinux symtab matches kallsyms                  : FAILED!
>   #
>
> Rust is enabled and these were the symbols causing the above failure,
> i.e. found in vmlinux but not in /proc/kallsyms:
>
>   $ grep -w N /proc/kallsyms
>   0000000000000000 N __pfx__RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter8adapters=
3map12map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtBa_3ops12c=
ontrol_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterat=
or4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   0000000000000000 N _RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter8adapters3map12=
map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtBa_3ops12control=
_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4fin=
d5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   $
>
> So accept those 'N' symbols as well.
>
> About them, from 'man nm':
>
>            "N" The symbol is a debugging symbol.
>
>            "n" The symbol is in a non-data, non-code, non-debug read-only=
 section.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3fed54de54016227..3d04382687d17d22 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -107,9 +107,14 @@ static enum dso_binary_type binary_type_symtab[] =3D=
 {
>  static bool symbol_type__filter(char __symbol_type)
>  {
>         // Since 'U' =3D=3D undefined and 'u' =3D=3D unique global symbol=
, we can't use toupper there
> +       // 'N' is for debugging symbols, 'n' is a non-data, non-code, non=
-debug read-only section.
> +       // According to 'man nm'.
> +       // 'N' first seen in:
> +       // ffffffff9b35d130 N __pfx__RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter=
8adapters3map12map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtB=
a_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterat=
or8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
> +       // a seemingly Rust mangled name
>         char symbol_type =3D toupper(__symbol_type);
>         return symbol_type =3D=3D 'T' || symbol_type =3D=3D 'W' || symbol=
_type =3D=3D 'D' || symbol_type =3D=3D 'B' ||
> -              __symbol_type =3D=3D 'u' || __symbol_type =3D=3D 'l';
> +              __symbol_type =3D=3D 'u' || __symbol_type =3D=3D 'l' || __=
symbol_type =3D=3D 'N';
>  }
>
>  static int prefix_underscores_count(const char *str)
> --
> 2.51.0
>
