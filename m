Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B532A3F3
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Feb 2026 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771274510; cv=pass; b=ZbjuMeuMpZqhTsIIcre4TEAD9MjO9xdoKZFdGMBRIAOnr+vr/WIwFNz+TwKaXxFhKKI5RnJAT3K8jPq4H/PDDf7O6tfze7EEHk9TLCt6zsACzS5C4/MnYZNH/noGVibhymUr2ipHpbYjnTTtjrEJX2u98i1U/fdSQe6p0XYvSY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771274510; c=relaxed/simple;
	bh=niFgeZaFWZq+2Xx8sAkgvHJjXq6dUk0A45yCk0UDf1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHFLEbtSYJc4c2oWdIeruB8UAIhHHuum961OQOQUhEJYjs1Q2h6K0SGT3zt6ISv+RfXZ+BmX9yGC42ajYoBjv5nPA7ZZ4A5FPZnOFXNGGsxi5+oRk/J1GW85xzBONBpmTptBOJV2Acd+3brsSrl7BKTFaItsxlavSjgBXbaEeB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCb5Ej81; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCb5Ej81"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b866f98574so275577eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Feb 2026 12:41:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771274507; cv=none;
        d=google.com; s=arc-20240605;
        b=djASyJTvbyptkX3/Mysa4BfJEDr+HPygqQAGbVA6IFwMHT6t/ugzr9UOTjZ21cNhE1
         j+NrrZYUy10AS2SGie3aYrQOsqO9AOuz5fLdC9aWZyFniw93v8fN+XdOqSWSbJGn8CpO
         4Ca4BULAB3Dw1QP1GC6xmxCNUxzOzTdMQAH9Cn1Huk0Cx+FoQB/U8WiztrDyyaqn+unw
         qGf+igwNpCnGNpxem74OfCIMDFva/XqBrqzsmCfo0I/0A+ZiZpWtot3FAGQYk2zeP12l
         rkS/WcmnCjwDDS6Lpv5CDp+KIgqYgug6rImOnZ4wuQHWBZR7DzX+8E3cfyuWYMNJfrIn
         g2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niFgeZaFWZq+2Xx8sAkgvHJjXq6dUk0A45yCk0UDf1w=;
        fh=29H4c6z0XYrvZSYbXQV38YE2c8SDonSIZndL1HDqUcg=;
        b=fdSaVoHAFn7h+naKchmitDUW6b1WYPtmPHJVy6oP4FzhvD73WhV4dBDknb7z3/ev06
         G9OgLIRIEwl33/nTln9kymIJfu1xs44QxLUSfaQ+nMVnf3IcmsW8TvxU7+Dyf91rJGFN
         7ET71MLayK/h9Bg5uKasFv08v8tfeQEu6hYFkKtI3xiV6//lLYRmYoWBjM4WCxoVbm9G
         vM6QaAt42Z5aVTQyRhKxJiEpErCJiqtyZxSgVVfPTzNQLpBkM+aIZj9aY/ti8ZUFR6Mu
         7mgMiCUXhtxurp7aLd4dQCFumdshBZqAVijTkicPznL9eeOekR4Oe5yydTsVx9Qr40DS
         Hy3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771274507; x=1771879307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niFgeZaFWZq+2Xx8sAkgvHJjXq6dUk0A45yCk0UDf1w=;
        b=fCb5Ej81/1Qbw7KLMj3wl7fKmlXod+7c4JLAgATFJ5/9b4ssG0t8D980sWFuMv2Ufm
         03P5Sd+OT9U6+slGX1R1eAVZozTUlo4Qrj60Pc748fHMNIRTWqX3MqZnhbXjnD95UmB1
         bp19Ex5m7SOahwJlFbuQE4rfgNGvVL/Zm6QjVxLc5VaZ3z54oT2fJKBueNut3XMiOKtV
         O3zTwpAcO0Y/iVOHMYBdMm/f9FQNMG8Kyruxex4g+Xq0uXM2RZLGUwJSqC9BBGuFVXiW
         yhzjakc17WU778oxnW24jE8vMWW+0Z+omJFF8Qj6PXsjc6GD623XEoDL/yzVWn9fY0t3
         InHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771274507; x=1771879307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niFgeZaFWZq+2Xx8sAkgvHJjXq6dUk0A45yCk0UDf1w=;
        b=orX8RT2sRTsEaBM7aPo3Fs0KS/hruMR6WQLpRNtkIpXpdBYOACz/LE4SHf/Y5XouxF
         kIDnq59a37PyDFUSIXzNQ0uCAR/ic9ugc6cHETpkQ8rv8VxgztG+DU/OU+gGXYLdwkE3
         T9EXHM+yNsxh3E/f7j9dZdsQf36EN1lc1sNsXVFJt8SE5ReokeT5HQoZjJvO+5FQ33M7
         dpWAE77WuBz0hUwJpm81XegwTyY4+GrGVC+Yfi+S9/vdfIJ7yHjzLFhQmlcc3a5+6TCf
         dVz0xTLQn94f/vLHJ1RbRoUxnFsS1TvxvQQXv7ZWWluIQh0rGJr/rQe3DmOqg+qfPk6H
         mtHQ==
X-Gm-Message-State: AOJu0YzYh6Zey3aKtQXKlfUs77da7Y9vmEVfHW/a4IeXGj2drA3KkvXC
	SW3IPqIjNSw8SKp+Q0KWrEeLQYZVjw8Ad9MO55gz+BlL2g1ViM6ji8UXQ2Ip0vVGquic5YtnZS7
	yKC/d9laTM5kOMKbug0cfNO7aLGK4l+U=
X-Gm-Gg: AZuq6aIPACmJHpD/iI+WpCZR3WNBaNGVN/ijrgaUZZCqU5MCgEaej8ysbnwRw2cSp9j
	iAzluWnilkSix7ddTahXbLvNBDnYHwBbV8NXYMMdm4E3hCZ2q++ymLALtulmqmN/KSP3amMFUZV
	sd1JurGuTbqZGkRH0yb+9j/iqGHXILcCmZh5mhT6K4Y1XG+wkVLEn1457jVuCAr96TjrUw2zcRd
	iGaLsPjy3JNHAuaEoAz+TDWNWk1GkWXvxZX8UicoC9zTg3IdERviLg9fzaT2An0Ij4MyBEIXUSZ
	4J8Gy1v+QTXciL7n/VbqGuAD6vGMOFoNNsEA8u6ig2tv3y20m2KmkbKFkWAT8DuLRrGFsoB/BLw
	OOTAHUBv+loSSyM/u1dreXmzK
X-Received: by 2002:a05:7300:d709:b0:2b7:24a1:865d with SMTP id
 5a478bee46e88-2baba03c364mr2814598eec.3.1771274507004; Mon, 16 Feb 2026
 12:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213191212.33328-1-9erthalion6@gmail.com>
In-Reply-To: <20260213191212.33328-1-9erthalion6@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Feb 2026 21:41:34 +0100
X-Gm-Features: AaiRm52AQh1nLse1tepTu3V9vLsY4p9m5Cmmc1cWP7wLS8GwhehvOv2qge2KTzw
Message-ID: <CANiq72n3FPOBVbR83-Vp6uetu8RnazMuu6MhzG_hA=_j18_BTA@mail.gmail.com>
Subject: Re: [PATCH v1] tools build: Fix rust cross compilation
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 8:12=E2=80=AFPM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
> Currently no target is specified to compile rust code when needed, which
> breaks cross compilation. Detect required target and pass it via
> rust_flags to the compiler.
>
> Note that CROSS_COMPILE might be different from what rust compiler
> expects, since it may omit the target vendor value, e.g.
> "aarch64-linux-gnu" instead of "aarch64-unknown-linux-gnu". Thus
> explicitly map supported CROSS_COMPILE values to corresponding Rust
> versions, as suggested by Miguel Ojeda.
>
> Tested using arm64 cross-compilation example from [1].
>
> [1]: https://perfwiki.github.io/main/arm64-cross-compilation-dockerfile/
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

I think this was meant to v2.

By the way, should this have a Fixes: tag? i.e. since it sounds like
this fixes an issue. Perhaps to 6a32fa5ccd33 ("tools build: Add a
feature test for rust compiler"), or something else? I also usually
recommend showing the error message in the commit message.

(Also, you can use "Link: ... [1]" for the link.)

Cc'ing Kbuild maintainers too.

I hope that helps!

Cheers,
Miguel
