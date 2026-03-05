Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC233BBD7
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749896; cv=pass; b=d8Q9Y/1rMRGRZ4Bky+tZx6HiF8gzjs27kIhsUF6kZJUQSSG6zQrHyuoKws8LGdPnHLb676marl/MZdYcXB8cclg5ZSQiAVMsLDJXD9kUOoitU4sViljd+DaGDr213CvkuChg4DQt5X7gbvOYZVVdLrWfcBEf4okbkNKrOjDfmfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749896; c=relaxed/simple;
	bh=xDceSgUKVd81YgsUMCSgKnm4us2TFS81rmz1p/nSLWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5k2fCAhhmQt2xTqTlzTz2w2U7o6RLSU74RXixWreJA0IC4m+9G50hQ7RlfzdM63826uN2PlHdyGaeIlvscFutM59nXCuRbreXfZXZW8UQPr9AUcD+62FZJJGl9C28SHCQuviGqVyj/IRfY0GXPFcrx0lgkvqSCEj81SrXHA1XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jmqUcm4w; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmqUcm4w"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1270f10a774so1340c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 14:31:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772749894; cv=none;
        d=google.com; s=arc-20240605;
        b=fjjg98QGgtDraK7kgRsDTCCU3CgN7QUdviHejWeUs6FdPDvwPqrGLyNeqZfW5Tm0oH
         +5NEpwTURj5sur6qsnHMYwXdm+kSQyYVlBAqBfevIdVR0Ictv2F1dWuixXYNmhiIp+bf
         0rkO2+1oigSWuN9HAG10ps3TOLJDFoaDOFhGXAgXVWuT6vbrnsJkBjqquEBcdXUMrkZk
         /KiWZ/zVIOZ3SaOIzhW31faZnFh2nDEVIVm2UxJurphdw0yIE18Qcam+7KoAC373nIEe
         LvzlYMHXxzlQfmFYwKJQ9mWnAXKncN++jsugCWvdJBEq18d7tz+HLkd6kRoxUPdTj4Pn
         Fanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2IetXRgswr5aabdzWvBTKO5qNNFL0cOhYNFPcxX/d9g=;
        fh=jincxDMUI0agIl8Pj9+Svqx8xfwhT5LXN0bekGjbBA8=;
        b=EOAOVJHS4x7dZOalvoBN62/oGf8+WRbSVcCkXZzvK4/DkTuYAAX4zUCaEwiZCxQk4u
         nuIje79CgnOw5vLm5QwliXoBm6qZIW2nBokLjDAlYWY9no3lSErP87mVVJn+Ym81iHBX
         Sp5ZiQocbJc8u4va+owiwKzU8kenAibfBAKTUvVyg0jsGtGhqQdaNzoFCdOZfr9AY/Tt
         iD6+VnhP+HwnuPaaFDLPMkR8/UQM1LTmN6TxsuFJM3HVdjTOCpp6B9OmGa4jdJG5I71i
         lXB8m23CV5VCT2qsjG6t60Gs/vm+DvrltCadKrLqcyR9gDTPvZeqIzpuF0OKk1P1BLW3
         hH8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772749894; x=1773354694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IetXRgswr5aabdzWvBTKO5qNNFL0cOhYNFPcxX/d9g=;
        b=jmqUcm4wFOwfo9CAZ+OSXeDqD46crqDqpjjKER0zzgfEiyjiPsuXD5AZahP+AXu9vk
         ftAtlhFhlwQG/+5t3v63QZ/wC8A8XO/jGsbQVf6EQTOcrRcZCHFNR3N5VeEfybe2IjPY
         CeJBUjfauSXMPI6Bm9J3B/Izz54RXakkaG4XoBTgtCrtbQc6Ly/L4BcPXNluPMubrIFo
         vONwQ9CvJ1xtIpZ77kBS3d4LP6XFOF9aHOaDzMZ1+wxfAcjrmrG0DzNHE95JO1jLwmaU
         166LSRc1q+MkBTPH0tm+b44EPJ0BFoog8hyqt3trbmF/p1FM7h9O0qQ/Zyk9LJpzEMr8
         6MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749894; x=1773354694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IetXRgswr5aabdzWvBTKO5qNNFL0cOhYNFPcxX/d9g=;
        b=fiHDR+h6ej+N/no6OlMA7Aj/7U/tEJLCPRbzPovpjxXOs+I99FsItd2VHbtLRdDoE2
         Q4uC6szFzVZHZ+yPvJQObmEwFA+HWzNequnzFfGreJWQzUcKg8rrLyUgoiAVHXoxft+C
         ywYsyJJSxcNNiziMjw80t4nAm5407Bc2stZj23xq33iNe/tXHhQNPR5FHe6EVN8MOQtS
         gYDzmIzGlMg3oGf/YoMeQ5xD/Ltt6TsXC9pwkQBxJj+BlhlDhrS1lI2I+FG0ZE/d0mqZ
         mfX70rU1YS/cuvfD2ixdZORbu1xk0+rc5HXcWXK3DSXxYzDOeGcV7GgvsfhxEoT4Jqwk
         vMsg==
X-Forwarded-Encrypted: i=1; AJvYcCXWgi1s8eM150fCSRnln/l4o9bGo2iSwd/9Pc7IepvkuRCufJLxX5ORT6XOf3UEgHPPeS2fbk9Pz9PpZKYWubfk@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFr2ZGO3Fmx8PVIT09fgdpBtkIrDo/Abgw6v7LUvWPIMNfb5E
	+hud0vrxrSUqwfqK2IETQwEeCjSQ9222S9PM/pPd31gkoPkhZebHtDoF0T0AOd5eH1u0Nh49udJ
	NU+2v483vdeyUAfDTJbyWjolWWty1Jd1sEzYjwC11
X-Gm-Gg: ATEYQzx4ofHQTNxfEd23MNDHyiQ6aBqV0BehGmARjA2lLaw6+ouSbvCLDDOeBUhyOzj
	59mw4cidcjWYezNx274+/KtNK7QksAgvgjugbq1T8fUSBWSxSp6mb76EmKCn5dTiDRhN0FXwiWN
	VFoyO5VtYXvg1sW7PghTX/M8PNcXzwFBszpws9ec8OMv6K4hPsw1wSzzL98+2OiJUFHPDeueCYS
	alw8L7JDQsZvHArTr6bBPASN9pgVb5OT6cC8qkB2zpkVU9eLZG+7P30clcci+SF4vbKrYFx6N4n
	AaH0pDFZ/tMlE7racu9kiEFMB+ZLLdik1wKJ
X-Received: by 2002:a05:7022:3d0c:b0:120:5719:624b with SMTP id
 a92af1059eb24-128c1cae4acmr47839c88.18.1772749893793; Thu, 05 Mar 2026
 14:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305022308.593869-1-nichen@iscas.ac.cn>
In-Reply-To: <20260305022308.593869-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Mar 2026 14:31:22 -0800
X-Gm-Features: AaiRm51D-g032A5OJCJi7CPBZkifSv_E4hFEWZg87iktDSJ9HgesQJ02vTk0D7Q
Message-ID: <CAP-5=fXYSywTz5M_jtpoBB=19y39k2Y4V33qN7u+kzPx_d2HdQ@mail.gmail.com>
Subject: Re: [PATCH] perf ftrace: Fix NULL vs IS_ERR() check in prepare_func_profile()
To: Chen Ni <nichen@iscas.ac.cn>
Cc: namhyung@kernel.org, acme@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, jolsa@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:25=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> The hashmap__new() function never returns NULL, it returns error
> pointers. Fix the error checking to match.
>
> Fixes: 0f223813edd0 ("perf ftrace: Add 'profile' command")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  tools/perf/builtin-ftrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6b6eec65f93f..9e7e81a08606 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -18,6 +18,7 @@
>  #include <poll.h>
>  #include <ctype.h>
>  #include <linux/capability.h>
> +#include <linux/err.h>
>  #include <linux/string.h>
>  #include <sys/stat.h>
>
> @@ -1209,7 +1210,7 @@ static int prepare_func_profile(struct perf_ftrace =
*ftrace)
>         ftrace->graph_verbose =3D 0;
>
>         ftrace->profile_hash =3D hashmap__new(profile_hash, profile_equal=
, NULL);
> -       if (ftrace->profile_hash =3D=3D NULL)
> +       if (IS_ERR(ftrace->profile_hash))
>                 return -ENOMEM;

It's probably a good idea to make sure ftrace->profile_hash is NULL
here. It is probably more correct to return an PTR_ERR of the return
value from hashmap__new.

Thanks,
Ian

>
>         return 0;

> --
> 2.25.1
>
