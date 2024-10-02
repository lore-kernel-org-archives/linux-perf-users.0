Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD01D172E;
	Wed,  2 Oct 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891038; cv=none; b=idwSfOO3Ajbm7LNPLZVKjYQyMlDonTjN0UG1YSCe6FIFC0eq+MY8c0CIwljuKQwvpj8JdYuKFJXq8SVYEi+GyCrpsodLM8ZlyLRwX/+5BWhfTS6RTerb1EkoX79jvoiXD/Kg+uWCGrkqREylm9wV2nsvctv16bGbfMI6XJEcCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891038; c=relaxed/simple;
	bh=PJNAUcg7OLBFNK/15Us5YK0Mv0mVklI4QNyGcNuskIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmgYwbJiaFT/imPltGyU+5nAqYol+OZ3LHyvqLEghpViC6skyorwbBRzZrW+NZHAdKR74DmMFJZppzLwsVSwBD+S+JWcnkMf5EGcE7IBqcjzHiky7YcaZYYt5w5Jbu/c5Rf6OwZn2TCVRu6EUpLNLdCgWUNkX7qrNUd92oX+9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K35faHdi; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K35faHdi"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db299608e7so3052a12.1;
        Wed, 02 Oct 2024 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727891036; x=1728495836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqshjRv9gYieJZex7WtLrqj/ddhTwpdfYr0Z+Ky3CFI=;
        b=K35faHdiPeag8S8AuELNRbkGi6Bwd6Jq06s5IhcZuYEe6uYyvixAaV+50kxbyLdo42
         NC/OWa/zPd00OYOZhc+Qkdicrsu6A1itjOGKSpVpS1uBr6HUVMkUK6LY7RcH2vQ68XCO
         7mJTpAmCpf3VDA7IsMKGsEQiD0tVXZo3rdsvAY4NAiyee0st3rf43vyudGUR6swA7saQ
         3z0KWadG87cwe61SQkRoZdNnAx0Dy0r0NTXOShYkttHPh7BpXVaIs3fBBxyA7XSyBMYl
         c17jtCJEWLTzcVT4PkrQnkp09OjPvB8qRDxBu47d4fps4x9xcl/SHMqGLvRyrcwjdnxC
         PPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727891036; x=1728495836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqshjRv9gYieJZex7WtLrqj/ddhTwpdfYr0Z+Ky3CFI=;
        b=RdQP/C6xojXJByZ//6Dxs21xXgNPWzy/nmmfuoA2XVgowkIluSWf4zY4+fDJqBK07c
         IYXmn13qZInTa4C/r+yWKvvP7ncmu/dLEjNhZi/638tgZT4PSuiRsZ2Eu4UYN0QNq9j/
         sfYKslestKRbwhB9gdUvbUCK+fy/IQ/fCbyHOMEzsMgVzR3CvwL71gr/BgjSuFWJ1uXR
         vrLjVSFhhKf/U46YXPXoj++28ONdki+tUM/JW85C7M9ONTTJxkdlpd1ngykJJ45xRdmF
         H6jszjVijhkcuvuWbBmKSKU7dHrykVF+PwWWQmgL834JDqu49PFSbOT+kpuxoaFUAytW
         jJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaDXjyJy6I87RxZFHfuksIQlVqyZaOddaXARKlnuX43fyRD/+wlC8ccE5I+K0jNkU/CSmqXwl66qDAQG2djcmbbA==@vger.kernel.org, AJvYcCXgeKhHEWZNqUDvZjrXWgFM7XqfSk1rUUMXR/rWfHZab2rq+6vF3+R+e2E9/h/f5fSb/+X1GLIwFl/6KK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDk6sNdlGATP0Gxv85Qo7SCfO1hEhWHSzVftklwlrAT+6yRJ/J
	UociAJpZV0HHmb4oE2Gonco5UbkGLuAEupDLug8cZOdnM03OPyO8y8E5H1WaBaYuU+an2+9K+1L
	bqTD9YNlTyz4U4Hx1TYgqwtGilC0=
X-Google-Smtp-Source: AGHT+IEI5HghPPr/Tk/tXzbCnur1xXHIBMsMpGWiW1BpscJZ8vF4sOGu1BxaYxLFO6DGxgROPyhuWxzFPk78yICp90o=
X-Received: by 2002:a05:6a21:6e4a:b0:1cf:4326:5602 with SMTP id
 adf61e73a8af0-1d5e2d4a229mr5621235637.36.1727891036148; Wed, 02 Oct 2024
 10:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924003720.617258-1-irogers@google.com> <20240924003720.617258-3-irogers@google.com>
In-Reply-To: <20240924003720.617258-3-irogers@google.com>
From: Namhyung Kim <namhyung@gmail.com>
Date: Wed, 2 Oct 2024 10:43:43 -0700
Message-ID: <CAM9d7cjDeGF6rO8+DJQdG+tELO2ueqqvkFU-rCFETQm9KJ4JmA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf probe: Fix libdw memory leak
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 5:37=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Add missing dwarf_cfi_end to free memory associated with probe_finder
> cfi_eh or cfi_dbg. This addresses leak sanitizer issues seen in:
> tools/perf/tests/shell/test_uprobe_from_different_cu.sh
>
> Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_frame =
sections for probe location")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/probe-finder.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finde=
r.c
> index 630e16c54ed5..78f34fa0c391 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1379,6 +1379,11 @@ int debuginfo__find_trace_events(struct debuginfo =
*dbg,
>         if (ret >=3D 0 && tf.pf.skip_empty_arg)
>                 ret =3D fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
>
> +#if _ELFUTILS_PREREQ(0, 142)
> +       dwarf_cfi_end(tf.pf.cfi_eh);
> +       dwarf_cfi_end(tf.pf.cfi_dbg);
> +#endif

This is causing another problem.  Now vfs_getname tests are
failing because perf probe aborts.

Thanks,
Namhyung

> +
>         if (ret < 0 || tf.ntevs =3D=3D 0) {
>                 for (i =3D 0; i < tf.ntevs; i++)
>                         clear_probe_trace_event(&tf.tevs[i]);
> --
> 2.46.0.792.g87dc391469-goog
>
