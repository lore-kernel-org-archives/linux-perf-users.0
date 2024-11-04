Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD591F5846
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752687; cv=none; b=I4+yGDm3DAg4Sxjlifyexvbe30SRRdOWIqmdRP4IOc3XBaF+y1a3TDB/JVa9oh/Ve+ZNzN9L42uxduTNEtQ0V+gtZqd7CjBGPUJ2sXAGahl/kUx7SjXTXuOCXJ0BKLoFyUAUWxqek68n2qro3VE8jMmVTaUN9JJoDiWE1nZ98Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752687; c=relaxed/simple;
	bh=EKafFQrcHqow9XPVbJXW8QnhNB4BpZ5ghDQ4nVOgs4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8Dk7THX8tposaewFxw98UUhDg6FufasGf9pEHIwoKsemzyMuHoKwxfjUax+UwYjYH92rt7H1yfT78Hn5JeaGQ3yUg4i6Iq0x18Ic3HS2QjP+Z1iOf50XVQNuZqhJVm52RdE9E4IiZ9tKcVqOjURFMxSWDFGet9c9kXsfoSj4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHzGnAyB; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHzGnAyB"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so31445ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730752684; x=1731357484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVs9awL5pwovmY2hQCH3pAdF4ZPipMvKa1BaDejQHMc=;
        b=vHzGnAyBAD023s+j7k7i5d/wSAnTq5UhCYwiEVwplKHYTYOXJpo/QV+olSmNIoVE4t
         yrb7aNmfJAUTJHQmExqLl1G8XdHooN9WSn5WGnFmTIdTY/OPXay0E02/HsQ5fW6cxlIW
         NlIf+WYIzxtt8OSdKvy1S0bzypgv+Uje3GHwZS1vwSpbbA1NidxensmejeWXvgtSUa11
         YLFdC9u7pCC9J0SXBqKEc1XWlya5SsAXfqmEzcQaCZqv05yUfScDIlBQRZUCi47+7X1c
         Bi/v0I/lrUSUmEI4RhQLZ52KoFo7mKiYQ7cY7m5dy5WTIvFKadWjBT8hoDH53SJAdR6c
         vmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752684; x=1731357484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVs9awL5pwovmY2hQCH3pAdF4ZPipMvKa1BaDejQHMc=;
        b=JMRGutopDhbg5b1hQzVr+N8cPpYp6u3icatypf1HqZub/Vk3KjuUh0XW5Xqw5i1FXB
         gWCoPO0NURARY+AP8Kc07wZ8SaA/vz86wfUUxoff1zqLtaCi2hGiOjdjgIjli91H3DHy
         VYONW/imyMpgOTsx1JuYaXV6kLtxM2JtMpznVbK7HXRaPy/DO8rJ5Uldh+o4e7oVQWOp
         s47ScnYDs8WxDiamVmQSrOixUSGD0gCBHAU4W7qfinmNmaRKF0Z8ZW/AGVHfm40oBG4m
         X+Xb1qXKxUV2MhbtgQDKBbzBJQwFlnhGKZ/bzDQCJygxvs8Rcuom+Uecu+ZhXMfzkin9
         qH8A==
X-Forwarded-Encrypted: i=1; AJvYcCWIrmWG9PyauTq2G0fQHVcUzGf+zMfI4LPTjgV0VClkcLhzF60ZbWp0wcWT8yDgT87ltIdObe493sJUx7r1L8q/@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTo4mxv5y2Mjr0ymN/eNrAEHTuMQlnOH2LTyaViRPUZ2TfUpj
	ktMPcFYhmgSfiNGNUnVksOeDhVKWtu/mjldjYyEglncNxeXzfy9kO1GmlMvbFSgUwVpoV38xzVK
	gfLGx4f6SqvmRtVyNW3JVc76L2PC/xN3PIKSu
X-Gm-Gg: ASbGncuapNKPSUe45k/58DWXHucgIDDykt45jstdev5nh8fU2wgp7GuYA9H/DS1GCBp
	15LX/ctM657DcPWADLLQTbWeFQ+fS24+gIUojh5u2ugTcaMfiR1oujZuwuq2ojw==
X-Google-Smtp-Source: AGHT+IEEd3WZqMqGwi0DOclLDdNE3GFZvePWwxu3+r9Hp4UUKKAxQnCVELnwD/+bq1Kic9iZOf6yhkkcdiQhPEr5Zrs=
X-Received: by 2002:a05:6e02:1a0b:b0:3a6:b3b0:5696 with SMTP id
 e9e14a558f8ab-3a6daa9633cmr605255ab.7.1730752683770; Mon, 04 Nov 2024
 12:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyjbksKYnV22zmz-@x1>
In-Reply-To: <ZyjbksKYnV22zmz-@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:37:52 -0800
Message-ID: <CAP-5=fXNis590NMNfS=7nuJ3DoiB4ojvWtv1xvTVvnz7DFXG4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests: Remove dangling CFLAGS for removed attr.o object
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Thomas Richter <tmricht@linux.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ze Gao <zegao2021@gmail.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 6:35=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Since the C test wrapper for attr.py was removed we don't have an attr.o
> object for that CFLAGS_attr.o to apply for, remove it.
>
> Fixes: 3a447031f5fc21c4 ("perf test: Remove C test wrapper for attr.py")
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Leo Yan <leo.yan@linux.dev>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Cc: Weilin Wang <weilin.wang@intel.com>
> Cc: Ze Gao <zegao2021@gmail.com>
> Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/Build | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 03cbdf7c50a09be4..01ed9335db4dba4e 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -72,7 +72,6 @@ ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powe=
rpc))
>  perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
>  endif
>
> -CFLAGS_attr.o         +=3D -DBINDIR=3D"BUILD_STR($(bindir_SQ))" -DPYTHON=
=3D"BUILD_STR($(PYTHON_WORD))"
>  CFLAGS_python-use.o   +=3D -DPYTHONPATH=3D"BUILD_STR($(OUTPUT)python)" -=
DPYTHON=3D"BUILD_STR($(PYTHON_WORD))"
>  CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
>
> --
> 2.47.0
>
