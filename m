Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73328B40E
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765404352; cv=pass; b=pjdTQBAPICNrLh5wjoBi0mi+//dKxNPd5zyEqGYRo6qiLqbp+VHxS2E5R5dWPbJcD06jX+t8zH0ZgOdzDuldSdkWt5fIci5lPLH7zuWADp32iWPjB5n+8Ljy9Mepb9VXaDO8zxm6Y93SBk0zZKCEgBfon9SJ2jJUtHtQkAbScc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765404352; c=relaxed/simple;
	bh=X7mLdXh9HHALivAROTOYT/CGe6d5nrMWaBxqEg/J1eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i92voEdPjpfNVLxHMdp0A4cXFFWvaZAGf2T4v67CgLogx+35pXKk9rXmCF2mMAt3ydt/o3bsXpVH5fPDtvh4P+Ev0hv48MoTrSitYrfCL0vKTZYHSUvpQLGcpopsd3HD0fBa+k3RMDq4gKcmCw3MGLyYcslVErCTwKKyM3B9pAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzZQSe3M; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzZQSe3M"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2980343d9d1so25475ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 14:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765404350; cv=none;
        d=google.com; s=arc-20240605;
        b=BgNU6P2uYlwr9WERC/UWcfg4OHXqOkQUIch01UZciaPD+1Pr+IfVmoBUGuV30Jw7vn
         UdytFgmL5Rdq1t+BPjy9IkajfgmfIlsoxsyZSzNLqj5JBq3RKb5bBvXX1zehoh/28pAP
         YnIg1rrw42wIHcbGH4Ac00A0sRBms1gLZeeYPe6tqVYiFM2Utqg7As2Uf+ySagwUZv3W
         zl7uhMIME6B7gHIWvcAGRSRviaw0ollnxN3hNixzzgrWUbSJKNlJxG+PnSrm/hA22u0f
         IJrFqB09/QokQn16Glsild2WJnPflHnfUOYCc6AzXqOerPoS0SqmZkMi0GKcghplFCBu
         Ds3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XHnMlFhdCW9cHtngXViVzt/Wegb+PJeSrYgWNUUWNH4=;
        fh=Vo7w9s4kkBIZD/4XQO9i6LmU618Wq3jfZPJXeEVhRYY=;
        b=Rcyqp84m0mA9lS4HWyFuV6DmE1j1/6zHwFjMr1nIbVGdZdFllDRfwAOO8GEsbtGtwx
         sjq7IXxI9f0FJMp25ayUiVfaetpvF3o2LiCL9dG0HymemvoLFj8zImhvxoeOVsHKceEw
         Mn+37W4/ml6+eQGZ/xfDTHJfBsouJbGyofg0o9Gy5AP8pAHQk92a34Mh8sfAorfkr3Qj
         87s7qmA8cYFt2AN25gsyrHU/Dt6PqJ8ZRoPJefrXYhoz16vH/8tShaEbYEOl40ocQoNb
         ISZ82l7FFi4HnYkTP056O5hJuTQ5IutvVGMDKmzbiKBhZSOrjYaIg4oVGi4k2G2Je8BV
         yYqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765404350; x=1766009150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHnMlFhdCW9cHtngXViVzt/Wegb+PJeSrYgWNUUWNH4=;
        b=RzZQSe3MJOZttrLsVMAm0WnFhvcGqoJ6vVoj+AJsx9kzy/4YR337zFOqqgDpH2ohhn
         ItfU5rDbSvlCKr+7tDoTQE75r66f5fnsSMTp/ZWlWMtSHsxIOvmB0C6rH7o2uu+xpcqj
         u3DxLBYNySMF/wbzAWWGfsFLqzZeYmJ3Qy8nWDxNfjQSP15TQJAbZaxOP4XeUrzkLTg+
         MwzwS0Td2TB/EQC0rxj9CntFTsJdfqKmjbI7jOGqcQiluHYQRGCvKJmAkSMUSVO5irjA
         oHBuo5l2suyQbhDERuqH5iNSAELZ49RcKVYn1clae/l1qBVP8Jv/v2IYLpAEOHSsVMdo
         fImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765404350; x=1766009150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XHnMlFhdCW9cHtngXViVzt/Wegb+PJeSrYgWNUUWNH4=;
        b=dDQ4ZJa87vMUqJlaiqb+hahVpgrpi+4qXcKyXkhVPEDjxBHZNHNTZy3PfqihLl4fL4
         ZUeYJ3moaHppYh0Ix3NeReGUAf93exQIKdFzzh1F9SC3Cb1X6mF/easzGRjwmyQtdc4D
         YyZcnirYmaxbFWG+Hj7gTbC5uPrEVWQOPlNJ75bUgAeNgV+S+g/4C5dBTU5nrZqlWqJP
         Ov7IJF+308TYpsJsI0Iwzh+yDunif/KheFUpZlpBwhW/MG8wt3voppvnQVGy10/cCUID
         wmId1ThAwc6BTK7IBb/hA7tGx5iDAjO7QJBhcHmOiZc0o/ltXbCU6GPPMocknPQMvv99
         P+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNujk7CYOdC/eFmbSBGZmKxADo3BeUNH7lSW814+RITANDmjAn1wevDYI4gNVDIfxVl2DjBCz7Uc64qieNhhT2@vger.kernel.org
X-Gm-Message-State: AOJu0YwUBmXOLVq6r6W1hr30Vbs8aGBIaQazPWoApY4K/ENBezKD02Fe
	Sdm8WWez4L88+8d/aZGxMuUn9UcJwc6gfj/9UUAJ2alkSyG6tvbeJjbZI2xsAlenJAyWBu0T59y
	31sGi2qbXJqAholg+rVbPY7Soh9znAvB+VNT5srpT
X-Gm-Gg: AY/fxX5UlLV6m8S/5Si53ctHRDZ0bhcPZeyArMpy6VIGaxW1QxpB2ocA35y799E9hrI
	LpjvfgAXSEHsKwa1RlbBFMR4TKybfRPU2C6X7ulFGZpZsHWNMrnbpEe69HHzKUQtmoewlwu5vJc
	DD5UqqCM3ermsYeYrwq5gKxU5I9MJg73y9YSFTZhX1Jm6ra1bmPU7PxM0eGpOk795UGw2/cPhM2
	dztC9+waVR+2xja4i1tNpXfcvViIxi7jE/rUEbDv4A0NRaMM37ftm5F65ze1z3f+C/cDo2y
X-Google-Smtp-Source: AGHT+IG1xhvS4QssgA+6PUtCI2o38uE0CxslGUYcTo5ISygULtUbI9qT5b+zyNgnqwaVwq0nkyKpMZW/XQnNps+zySw=
X-Received: by 2002:a17:902:ce0b:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-29eed4202aemr292255ad.7.1765404350069; Wed, 10 Dec 2025
 14:05:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210023327.1669863-1-namhyung@kernel.org> <20251210023327.1669863-2-namhyung@kernel.org>
In-Reply-To: <20251210023327.1669863-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Dec 2025 14:05:39 -0800
X-Gm-Features: AQt7F2orS1eiEhOOqPA3c3LM6fShC-GXk-1fklrRIHsR34N7_ex-p6-x9BqVgpY
Message-ID: <CAP-5=fVgmwWKYGK7=N_8eHMybGm-QmOQvWmFDsq0zfXwbFq8PA@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf report: Enable data-type profiling with -F
 option too
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 6:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> It checked -s/--sort options only.  As the sort keys can be setup using
> the -F/--fields option as well, it should enable data-type profiling
> with it too.
>
> The following two commands should have the same output.
>
>   $ perf report -s type
>
>   $ perf report -F overhead,type
>
> But there's another problem on this.  I'll handle it in the next commit.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-report.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index add6b1c2aaf04270..6c2b4f93ec78e579 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1727,7 +1727,8 @@ int cmd_report(int argc, const char **argv)
>                         sort_order =3D NULL;
>         }
>
> -       if (sort_order && strstr(sort_order, "type")) {
> +       if ((sort_order && strstr(sort_order, "type")) ||
> +           (field_order && strstr(field_order, "type"))) {
>                 report.data_type =3D true;
>                 annotate_opts.annotate_src =3D false;
>
> --
> 2.52.0.223.gf5cc29aaa4-goog
>
