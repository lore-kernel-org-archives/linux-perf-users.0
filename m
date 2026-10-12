Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2D423EAA
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841282; cv=pass; b=K+IfG9mNT5VmzGT0ibYvF1jMEOM6lzPTF8mYSKforC3/4JM9Qa0mz9ms7oG+8VqMrbfa8+R67syuW9h8Xugvm9vyYWPd0Vbj8A/XmVVPSiEe0jotMs2QNNJuKYa1g0KPiPT3eGlT0bQPdu/oJbLqBY6lljET4ToMkrSGuDYzQhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841282; c=relaxed/simple;
	bh=MvL2NksiIGW4AGmjA3H0Npu7mPSzD9lxMrBE1kC8jt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDmMxD2bNH1YaIQcXQZRLUPI4ftwrLUY01iLgewl9tM4DXYXThGfTaz3CuEHH/PzIkqHfdxRmodqQbn+s3cNVMjTB9M1e2l6DJMcWf3oJNCSHS8RncV0ZXb5y5HKPrBkqAnqcys0vlhOlwFIwiCebre3UYw0ZikkfOwjc2CjL+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7kcIlYP; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7kcIlYP"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2e6df2742cso342328866b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 14:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791841279; cv=none;
        d=google.com; s=arc-20260327;
        b=jhgcAu9fvfR+bxyfV2Sra6cCze0VMtj/Tu26Tn+nwIWlNAvYC+DikmWMvp72hNHpbC
         OOVCmYZzwx40V/6luI3q+ruwPblIvG01qgUJH1lslsSHTOUiTfPE0GdOmhG7EujLuSti
         xT0/KdQ++GI7CsOUN8tWqwPGWz1x38PuUcina7RueVwHxGGUVLTk9TZI+kFdQp3QFYz0
         mmUoMeW9XaLoLtBQ9wuHyC8igZ27ApoOjJCTl2CGQPydP32euUsAGrZSoPyuRe+xzdSK
         wU/UXktgZmEK3pjt54a5BGCGVCKCpewIDQpMiglJRrbtCaV2SdYBp1aoMJN4OOuztp9T
         y4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MvL2NksiIGW4AGmjA3H0Npu7mPSzD9lxMrBE1kC8jt0=;
        fh=J8Vk+H1n+oxSQ+0RHoY1RrlrhBLT+Rt7RyhSqfxKuwU=;
        b=mxkw/RxRweLQyPnCAPoY78riYrY81ZrA4zNeYcmSpFOe8X846b2WpUH7Go9tf7DgRy
         R2O/E0r579eZERHOGxC2ViL/9PKJxWJmRXXSmoiRdyvVPAO9SWYOdbnFFNr7dvCDMKk5
         WAGafDdz2rxV3cGCV8c5xJOqqdAxPTM8sxnTTZTgDLmoE5EMjtjAmNdMiYdITH34+bn2
         e7EMHKZKbyxY9k9k6uIPxK1zp1zpzPI3zWO7L3Ryz3ZnmFcHJZDAWBKw0pLM6lj1yzXM
         6M0E8dprsZ8pM2aGQL3n2YQt+jqeG9xSJ/qpux7uVxnla45eISuS9W8mKsahNnw9HBWy
         2p6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791841279; x=1792446079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MvL2NksiIGW4AGmjA3H0Npu7mPSzD9lxMrBE1kC8jt0=;
        b=e7kcIlYPpC5PastaV1VA9rFjb7oH2EHlfU40Dsu0wcgeYMvKEervMi3okRv0GQKGV6
         eoPWdEZ0w2ng1d2G/zZ5p089vHOIj5vw6Gk4I6S9j8aPH685HgCQy/M73gfAtbwYXrYZ
         +OsqZCXW58CRlEP09bo85N9kWoPI0CwH+e4jYthZIw8apZw6wYyJerEYghZRJTRHPBDi
         XY36OMwPeZ+I3zp2LJyvWJvDZZcnrFXXTulaiiVTjNmioH5YTcY/RhzVWe2cd5Uv/HJF
         IBZmG+a9AZlLReiMaWgX/z0iuheVyLI0kkz3zutipOGX8NKr6PqHPqGAU6SR7L+1EkVI
         hsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841279; x=1792446079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MvL2NksiIGW4AGmjA3H0Npu7mPSzD9lxMrBE1kC8jt0=;
        b=v8YShehuiJhPn5Tw4JLQlEB5Wj3O97PwF0vnX3v8mgEysUGomszQtEw0T6D2sEsO4H
         YjXPQPIV7dhOR1irqVm465vDUbvBBx0XYP7ZreKpUbtSPIRjIzTA1jKiWgg4yyVOYNoc
         gXaP/6SZIu085TLPRpfE9xB5Zl9pmG00Piturc7A4Fv3oUNbWDdcPVftfLP4Gi1LrhYC
         5IjyCy8H9PBrK9uaUUDiXoIJ0AcouJZwibi5yML1HREIsbdMTS6zul74sLAXHpBxqrYp
         bzZi1k+2AArzc0eWcXl2KUtFoLhcljyluS+cI9GLdN0bFYOFBo5rVCC3fBWRTvlCgKkS
         pjEA==
X-Forwarded-Encrypted: i=1; AKwUvBw45V7TbGgfS2XYVnkZAeq1MHGQb7+phWDREXPPTmdvIa5Z6eZtCXcbh9eNbsrPEOYf6/p30g2o74/KGh/RZTj7@vger.kernel.org
X-Gm-Message-State: AFq9FYIc8OoQZIdf1DDC5/MQUUiiTU4bO0Tgvj+IoNkJynpz1UylLH2+
	o215s0wVN3iTkJEwSxoA8q4PYcuGiUhRFGO6gVp/C/9cCgLkd4My9ID0suJxpHzzxt1FJuWJVwu
	KMD62+L5Q7nw3tYf5tK9Y/YaFp/RlCpI=
X-Gm-Gg: AYBFou0a9/33dDazowHrbXVLdXjkpwA/g3yFstUmUg6hnT5oWwauh+uKXs4E6tfImFE
	A/VRmZYQBbzsi81l2uPIOOosamtLo53c5a4aUMPWrLwuEOS3ms+3TszfzXZG6fuS6HzC6p/mZ+I
	TcmzfTmdYtq8IID9gm+5sPBx49hseOLkQ16kd9ndgatIXnUKF7Lm1McwRWTnwJKOlsT38/NfOHh
	3Bp4JhcEDtzcXrOUypA1Ze8lquKlmvhw6WvHvVbwIWUqvyRun6XRN/LXlBls7nRcnYm8bd9H7sj
	WCWKPtVHXsDQBFs7EM77bCFbhykEtjIm8MmI509tvzjx73/xZly/b+lB2qLO321RyFi4tM4D5QA
	zpDwHp8cBmHyGwOLGuDgEBl20t18ycbJCSa7l8sPwbQ==
X-Received: by 2002:a17:907:2d94:b0:c2e:8eb7:53e8 with SMTP id
 a640c23a62f3a-c31aa03cd11mr1071057366b.30.1791841279326; Mon, 12 Oct 2026
 14:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com> <CA+=Fv5SDnzQQDzyhaQ37kWJMjTOHP0NHuAS6kJHwT8_Zqyjd-w@mail.gmail.com>
In-Reply-To: <CA+=Fv5SDnzQQDzyhaQ37kWJMjTOHP0NHuAS6kJHwT8_Zqyjd-w@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 23:41:07 +0200
X-Gm-Features: AclHuK_Gule_sWbyfyKRqdrOVxlX8Cnrce1CxMxjqq_Jy90LticJHn-in30fJ0w
Message-ID: <CA+=Fv5RGr2NQs=gnErAWXfSZgMcWB1q-_-BNQ5X5DyzqkV-bmQ@mail.gmail.com>
Subject: Re: [PATCH] perf regs: Add alpha support
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again,

On Mon, Oct 12, 2026 at 7:37=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com>=
 wrote:
> > base-commit: bc01105ed65d15787b2eb93ac26e8624a2139e35
> > change-id: 20261001-alpha-perf-tools-regs-c206a84dec7f
> >
> > Best regards,
> > --
> > Matt Turner <mattst88@gmail.com>
> >
>
> Thanks for doing this!
>
> Register selection, recording, decoding and user stack dumps tested
> on my ES40. End-to-end DWARF unwinding remains unverified because the
> installed elfutils 0.195 lacks Alpha unwinding support.
>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>

I just pulled your elfutils patches and ran some more tests.
With your elfutils patches, DWARF unwinding now works on my ES40.
Both existing and fresh perf recordings recovered the expected
leaf -> middle -> outer -> main call chain.

As documented, samples whose CFA depends on r15 stopped at the
sampled frame, since r15 is unavailable. Tested-by tag already given
to this series.

Thanks,
Magnus
