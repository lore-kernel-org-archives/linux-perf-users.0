Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FA6AB8
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374282; cv=none; b=bhFa9O08Zl87II0Try939PNzhtcN33eR1IOTu1hnkf0f6n2A/hDcXlAauOCzUlGkLSvEStviNQzrkb98UgnGeEF7rMVSg3Ftub6ax5z/n54NAeD862WG18EBbyPQKWjTsg7Xrfgfa/OY7h7XoaaFQcDcEeuNKXcIEqO81Nr8Oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374282; c=relaxed/simple;
	bh=GdTS9q4l86YOjy86lNWrIhAc/Qp33mLdEkp5QLUQMtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdkMzLdhzFya4NJ9tIUuqG4fkStLbWpH02CXrhrneNigLX7W/Ypa2txct5q8yytfsmqQC+Tftroguw6E0TBVUmChnziYCrMs6RWGX9IvR78+YCTv+kuxa3FI3v1I2eCnQes0+W6Kjx3IcqWbtG3RCwwa+mawuhV+L4PhWceAtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c8dccd0fa9so109887a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 20:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719374280; x=1719979080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdTS9q4l86YOjy86lNWrIhAc/Qp33mLdEkp5QLUQMtM=;
        b=F8rQeJnVPnfhSEcWMtkW6A80m0IehmuU9k0JAFfK2UvyXTM1tDUGrDH1Ekqsr8xpLj
         JHHy7Fpoep1hlwAOQsIfhyJA23sE/s2naNkPCj0HueQJc6YishH810fXxaGMh5Ai1rpz
         hn+inJk0JC+f7aiZrV66JLXGOMEvnHPH940s2g1+vIQjAa1AyUE4QFnOA0tFSyldvcH5
         UmZAsafb9xSE0tob918PHCi6TCTnYr/Zmlnk0o5U/I6t/t/Xku4LZftZwTRh+0C/t01A
         3zFCI+S5c/i6t0e80YOvug8r2iXlEBVVTyz4tGT+UWRFWMTGuhwztAKGT+KZkT65fzn8
         68/g==
X-Gm-Message-State: AOJu0YwMKpULAufdUZLS7W0GPM4Tu612hV0CppI+LqMU3PBMukQn4qyU
	sUY0+sFqle8VpwOydVSpliRg+Hv2wDewZPP7F1iJdvwU1eulcbN83Nw3+n/UjXtEx77ywHlsNVJ
	CSM5CBbsDP3WtvlNwnidyK/lcCzFbCg==
X-Google-Smtp-Source: AGHT+IFfJVtUPPIH1fKwb5B6pud77Sa63aTc4Wsmc+4+dF/olMNDhlqgGrivzszMLnbVkI/jXfBAj+cE0rryb3OgjY4=
X-Received: by 2002:a17:90b:1b0a:b0:2c2:c2fe:77c5 with SMTP id
 98e67ed59e1d1-2c861485791mr8963102a91.40.1719374279896; Tue, 25 Jun 2024
 20:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com> <20240601125946.1741414-11-ChaitanyaS.Prakash@arm.com>
In-Reply-To: <20240601125946.1741414-11-ChaitanyaS.Prakash@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 25 Jun 2024 20:57:48 -0700
Message-ID: <CAM9d7cizC_TpqDfW3MB=RNtzbDp1XtWXMo39+XYyk_ttQaoQ6A@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] perf test: Check output of the probe ... --funcs command
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com, 
	james.clark@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 6:00=E2=80=AFAM Chaitanya S Prakash
<ChaitanyaS.Prakash@arm.com> wrote:
>
> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>
> Test "perf probe of function from different CU" only checks if the perf
> command has failed and doesn't test the --funcs output. In the issue
> reported in the previous commit, the garbage output of the --funcs
> command was being ignored by the test when it could have been caught.
>
> The script first makes use of --funcs option with the perf probe command
> to check if the function "foo" exists in the testfile before adding a
> probe to it in the next command. The output of probe...--funcs command
> is redirected to stdout, therefore, add '| grep "foo"' to validate the
> result.

Applied to perf-tools-next, thanks!

Best Regards,
Namhyung
