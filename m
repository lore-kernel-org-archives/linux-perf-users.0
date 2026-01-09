Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1486353
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Jan 2026 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768000679; cv=pass; b=NkSTi9FueXl7FKPjJydmhLBbYFWneB9AKKEOCF5nZl38j05MQVdmcuJ9WTKk3vHz+Ly6L8epQyLvWvPubms3FKjAxmwzaJEvEi81Na6TjY6BVir3NMZ9m94Aqzr3HZ60Yfbk1UcYgjAqizi/sKNqB/LDRj1Wh1L4sugpmS8XKX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768000679; c=relaxed/simple;
	bh=oPtdJd2fKK+34cOoKL9+d4kdQOdJcnSEb5m1ESRbOSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqZ0k3vXw/8SVX18MQ7hTPcM538avWqM4z60S+FShi74BXJ1c6/OXlnz2QlINNRfObX1ihcCpFcpZDszgA8MezeY/8IWq6Fo6u7aBIpsg6TDnTScm0X1g33hTWaH0Kr5xtRqjRmryF4M20qG7Jjs6NcJWESrjgo1sMzuos9iW7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NR4bQSD; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NR4bQSD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a1462573caso30065ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Jan 2026 15:17:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768000678; cv=none;
        d=google.com; s=arc-20240605;
        b=M0iWzDJRv2XqkdB3cpuSKoWct2J94c3K3fg9XxRhN9v5ZvcPD9ryGdIQMbnjLUyBVj
         b6PUDGPQz4qOMAKZITTlEGaAS69k6ww8Yc7cHwVN7BPcXIB9Ty6drSOdV6HWzskiY1NT
         maEif4mohPlTkLBlzDX9xHAsO6nsoe8yHG65kSuodFIRt1eR3ixG4rpsXkdB88xVhKX9
         R4OrsMOu8UfyzNbUZa9vHz+xkWyRTYaf8wFmSa78r/NaoF4aOFA7IBfehRIC6YXAaq53
         VWE0zSodLQDI+PrrdWLWnFQHgfZg11BO4+A7mxe1wiiYifzs6BijT+y86+9viGIEjlh/
         yPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmWqKpMi5peVsetBONlvhcjSplbH7Y/Hv9pFqCTdVIo=;
        fh=Nr2yKvkvjVTke9HdnEpg2fZaKdCetOYvW2IlY8oMbhw=;
        b=iFgXUAeF9OcSGFpvF4k9vBFq2V/jSJHaG8ZKPfqIoXnWokj3NTSEtoIq/Ih8ES/w8H
         Kieo75Hq9LvMx8/p5OXWkdfh3cXjkgBzb4OQbxcJW9N8DIoYkDRbme/dm7U078GRWRqJ
         WyGPwlrrHx1jrhrB4mqQb6PbDjibEQVfrxDk4Yu3d/XrxroZkQ3eAqbLrROqC/6sRb2o
         5o4Wj6/kvbojnFYwD4V+dNoXMLtvxLO6/D/1MPue/A1a4C9vmJtzmwjGzKYbUd9PTQJi
         bdYSX1uYtU6p9dzUfSFWs3D+ldyTLSQ4NWS4LHvf3GZb0XA64nqR9nYoW9g41tQmS6Qy
         UE1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768000678; x=1768605478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmWqKpMi5peVsetBONlvhcjSplbH7Y/Hv9pFqCTdVIo=;
        b=2NR4bQSDibjeU4lrOpDe0FXLiIqIwK3z1V5uwECxUsReD+g6bbHv5EU+3J18WTUd5n
         UAf5so5kpuGcdnia0esKz9fo3LXQ4bPNp/1skcePXJcBG0kmDg3JXHIGEf7fbmhsDyP7
         TH+MGqOFMyJ9Tzh6DsFW6b6nxfkgAdZ65dTUBj5fOU2NGjj1TgVhXVVvoK7e3mgZYiEZ
         Ds6Po49dwG+E1/u4hIUzriQAvN11IIk4awRaPXMMrRHAquCGvqln4yWMjlUGKGq+YenY
         zRm4ZDY/yZW7l9HAlQGCM/p8SAti7fFCLwb3X/SidNPi1yuWSzYHp4oQ0zJLDLzYA+vd
         npsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768000678; x=1768605478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmWqKpMi5peVsetBONlvhcjSplbH7Y/Hv9pFqCTdVIo=;
        b=FBFCag9jg1nG6pogWLn9xKdFp4TqRh4DKR3ZnPC/LqRpsCJXTkm4PczbTonwOS9GfG
         sLITbTg1wuE9ZjoiSRznnGvVv/A0zJGO9BbZEZ/HjhalqoU9EG+mn+6JKNnVDWjHJL8T
         AaPUIhxZvDI8yOzuHAmSzHll7nC7ZlcAQtzY12uN2N4iUkl935O+PFEZJxPWBj/CWmb/
         dlfBbu45+kOGW0R4oF18xLW3ChpCcIfwrbtnZYnwBDdVGDw52/KjpvAkwuchcRbqVJ9T
         P+hnmNTLMKIkBkzPjy2fKOEjmSBG/xEmOc9TInB4wrpGVknd+8USREwExNecktuqIg6V
         FXAA==
X-Forwarded-Encrypted: i=1; AJvYcCV1w5Ub/p7Rk7URVxzDTfSwctT3YjvKpeoy58Exp2bzZyoyt+zL7xilLHY7kzi6kh5VFeCS6C2Em7DkvFXJYQSL@vger.kernel.org
X-Gm-Message-State: AOJu0YyXkAXOqUQ4Q+n0588BEecdpuMwXw5Gkr02SL3kPATw4osjfq7m
	WMycEv5zBR+Ie6v20DQlU4TQ8B/eozFB9QlPXYHsEX96CKf4Qky+JPHyr9lH/Ue9RsFTsKn8xZE
	JEgQB+AiZRGD+WXwVJ8ctaxoSH71P3QYjahbpFV4oT6ev9cgrnVKBmmtzGOU=
X-Gm-Gg: AY/fxX5SFWqaMaqGcI/GgGiHnj81lyyqSQStFIBItLlDjetJ4Orn1IrBjQPlx61ww1n
	7atLP9UpKCtgSHTZQ+nqjAyMLht9MwSaanUdMbTkYPrhaoV3bJ0vHquZvlOc8HcBbAiMmmQJ897
	nHMuqkv+cuX22nWNB47HDQj3ewI8E2Bm5BZVT7IyRf929bEWOCxGTFTnk8CvBZlVlMGvrwercNQ
	cpGjUJW8eVcXqtaK6W3aS7S82SOpJK/NFWFkztgBqcqnFJ4lPpJXhFJcisBoO6iiuQzE4HdCwuV
	K8Phta3YWiUOM+KL2P5ds3JM+g==
X-Received: by 2002:a17:903:3808:b0:29f:2f83:16d3 with SMTP id
 d9443c01a7336-2a414932fa5mr1151995ad.16.1768000677889; Fri, 09 Jan 2026
 15:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219011820.2505506-1-namhyung@kernel.org> <20251219011820.2505506-2-namhyung@kernel.org>
In-Reply-To: <20251219011820.2505506-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 9 Jan 2026 15:17:46 -0800
X-Gm-Features: AQt7F2oQF6OotVkYoqNOvT6cXdYhTgD1kD46BjBW5S8-FEQvowGNDBbjtFDpbB4
Message-ID: <CAP-5=fWaYs5HL2T=zHdr-W2h5j74UaCtxqa-FC9Dm_y+F+VpFQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf test: Use shelldir to refer perf source location
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It uses tools/perf/include which assumes it's running from the root of
> the linux kernel source tree.  But you can run perf from other places
> like tools/perf, then the include path won't match.  We can use the
> shelldir variable to locate the test script in the tree.
>
>   $ cd tools/perf
>
>   $ ./perf test dlfilter
>    63: dlfilter C API                                                  : =
Ok
>   101: perf script --dlfilter tests                                    : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/script_dlfilter.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests=
/shell/script_dlfilter.sh
> index 7895ab0309b29dd5..aaed92bb78285dfd 100755
> --- a/tools/perf/tests/shell/script_dlfilter.sh
> +++ b/tools/perf/tests/shell/script_dlfilter.sh
> @@ -68,7 +68,7 @@ test_dlfilter() {
>         fi
>
>         # Build the dlfilter
> -       if ! cc -c -I tools/perf/include -fpic -x c "${dlfilter_c}" -o "$=
{dlfilter_so}.o"
> +       if ! cc -c -I ${shelldir}/../../include -fpic -x c "${dlfilter_c}=
" -o "${dlfilter_so}.o"
>         then
>                 echo "Basic --dlfilter test [Skip - failed to build dlfil=
ter object]"
>                 err=3D2
> --
> 2.52.0.322.g1dd061c0dc-goog
>
