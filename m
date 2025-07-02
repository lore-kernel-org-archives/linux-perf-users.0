Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B92F7D0E;
	Wed,  2 Jul 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482438; cv=none; b=uorV4CHkPJ3aKmWuGraYdw1177hr9U/DvKcqHmZF28/2OV2IaGEe+W6WdAW958iqCHtV9CG99xgOPbKwt74xb5oQZ6ZibpEi3NV6bzyHKq2FP8kd6/hlqBUrhFM0H37IOIep3TttrCFYbB9LoEvB92NI4aUURjCpeoiRayI+lMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482438; c=relaxed/simple;
	bh=sWVfMaKLsECjIyi5MUgKTM26UVwF4aLhRuw9374xhxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2wbFYJiika3mP3YBhrwOpeRGPcnfteWUjOEwuCg29wpnZFj1+GDzKDlXgN59rhVGZs9GoApYiorFFYLUs0W+OLevGgtBNpnkMWzJidfhqNBGARSPe17W6j/RJPiZ9DoAwu5hvi6zBpIDr9tWoJ0c4Y8A4cQGB2xM2xoozJDweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCjgBl3i; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCjgBl3i"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5315ebfda19so1667190e0c.1;
        Wed, 02 Jul 2025 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751482435; x=1752087235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGpr20X06c4IYo1szuAw6hcwGxTmHbpUqGh7ovFyqx4=;
        b=iCjgBl3i/cB40u/qIsnEdp4/Z+ReveL717OnrbZ4O0oGIDKLvJJJ0lqw+c/+mjJynQ
         mMvSaRc05GEFHFtyL6gIYv/nscog79y+IZUuxrE03ob10hFfaFApQ5UzBHINRdf04LOu
         9t51p0Pt/GTIPCcQ2DRKVAxB+j0i+cMQ8nzQhkvNjCF/5duDS38Sp88eDP4Q/QdyDQGI
         rcoa+YqkgHLhT6bqOi5xTTMTkWHIG4u5QVwGQLfiys8N/edXnnQ2ri7Ijn4qW979nvRn
         s9NIpb7Z898H0sVJHdx1VZt+qowztp6gCOkmB4R/SvmMgVQ0QT1I1OFpw28G2UmsYu+0
         GrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751482435; x=1752087235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGpr20X06c4IYo1szuAw6hcwGxTmHbpUqGh7ovFyqx4=;
        b=hbYXFOS2fnMRdaweuJb2KMFdlrgkDcmzjCdw391ii370/r3g8ffHZCw+jDEZOsPRCB
         m+EQ1yqXROmemrSWLfvZ5j2yv4XjS+NxzuOuxnaPy41mQi/rlt79oRWqeuCSCqjsYN3c
         q7dI4xy5t1vCf5ow0W36QWUqgf+TI1jRmq8/njXUvU78MuTj6Ow1KjbHCMFQotiK8bfB
         j6OnobgU3aQVP3Iy7u/CkpArRnBVWLvTT8CIS2HuILGc5s6o8Nfd/8CiW0Tkz2RO0nOk
         l/teb7szssROH0D0m601oQz5kd3szalIQgU2vjmdZt+t5Nv2N8CRSREwUQVDNjxZpdkS
         PusA==
X-Forwarded-Encrypted: i=1; AJvYcCUTm7dbOpuGHKzWDq4UMOYA0ZzG+4ICcGh03kNVQL0AqQnMTanvLH4r+VtV+AKv5vU85fLNnidF4Ll0IQk=@vger.kernel.org, AJvYcCXR5X3qpCVCDI5m/9TR5XUMBXmNeAgtt4lXmCJsuvdOde30kcBPyfKF3vb7XjQvMXwb+SNq4+RY0WDM3kmKjISc3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGMUEMImbO50HPtNMM9h1qz9TI2QX7BHgOGuyeW9T2t/BEUNg
	bMmZAQ8O4BrkeQVZPcJ7+Eq2OE8l8pzGAAq+B4/yLTucB/MVIkQwNHf9QyTsPmBcUeIFYKwoyid
	lh8Q2YDCFavrqKQDHuOY/nDy9Y6PKj98=
X-Gm-Gg: ASbGncuOUf2pTHEK7eBUyWI5u4Wmrd8xqOMNDPXz8bhS57kDbSgeVK0okYcrAtuKRxs
	2q5YxBNILTRPO0977F3MkKDiRPqaooeElxE79GtwsraWuhcXVFBYp4fiswkVEANM80tOOJ7XI5I
	ZGS2YqSij+NVG2by/h02Sbz93htmrYqwFKLdMZzZ6L3Sk=
X-Google-Smtp-Source: AGHT+IGQcNbkNCL1zSuxVw3ayQxDPwY4K6hVoovbfKHpavfr6RyQNOABf7c8aYnbDaPOxGOpHCrKfzNVskqnsSbi53g=
X-Received: by 2002:a05:6122:553:b0:531:2d3a:32aa with SMTP id
 71dfb90a1353d-53466603979mr626634e0c.0.1751482435572; Wed, 02 Jul 2025
 11:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618215843.109941-1-usmanakinyemi202@gmail.com>
In-Reply-To: <20250618215843.109941-1-usmanakinyemi202@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 3 Jul 2025 00:23:44 +0530
X-Gm-Features: Ac12FXwVWPAC1aru0ELPnfULxHDKrh4sVJoMhmHfgf5DdxsrpMCb4mBVcWpGxi0
Message-ID: <CAPSxiM_hKOdMkpsogs8dhX3S=Fz42noOFM1KFTYmaBBwK6g23w@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Replace strncpy() with memcpy() for vendor string
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@linaro.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 3:28=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> strncpy() is unsafe for fixed-size binary data as
> it may not NUL-terminate and is deprecated for such
> usage. Since we're copying raw CPUID register values,
> memcpy() is the correct and safe choice.
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  tools/perf/arch/x86/util/header.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util=
/header.c
> index 412977f8aa83..43ba55627817 100644
> --- a/tools/perf/arch/x86/util/header.c
> +++ b/tools/perf/arch/x86/util/header.c
> @@ -16,9 +16,9 @@ void get_cpuid_0(char *vendor, unsigned int *lvl)
>         unsigned int b, c, d;
>
>         cpuid(0, 0, lvl, &b, &c, &d);
> -       strncpy(&vendor[0], (char *)(&b), 4);
> -       strncpy(&vendor[4], (char *)(&d), 4);
> -       strncpy(&vendor[8], (char *)(&c), 4);
> +       memcpy(&vendor[0], (char *)(&b), 4);
> +       memcpy(&vendor[4], (char *)(&d), 4);
> +       memcpy(&vendor[8], (char *)(&c), 4);
>         vendor[12] =3D '\0';
>  }
>
Hello,

I am just bringing attention to this patch.

I have not received any comments about it.

Thank you.
Usman Akinyemi.
> --
> 2.49.0
>

On Thu, Jun 19, 2025 at 3:28=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> strncpy() is unsafe for fixed-size binary data as
> it may not NUL-terminate and is deprecated for such
> usage. Since we're copying raw CPUID register values,
> memcpy() is the correct and safe choice.
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  tools/perf/arch/x86/util/header.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util=
/header.c
> index 412977f8aa83..43ba55627817 100644
> --- a/tools/perf/arch/x86/util/header.c
> +++ b/tools/perf/arch/x86/util/header.c
> @@ -16,9 +16,9 @@ void get_cpuid_0(char *vendor, unsigned int *lvl)
>         unsigned int b, c, d;
>
>         cpuid(0, 0, lvl, &b, &c, &d);
> -       strncpy(&vendor[0], (char *)(&b), 4);
> -       strncpy(&vendor[4], (char *)(&d), 4);
> -       strncpy(&vendor[8], (char *)(&c), 4);
> +       memcpy(&vendor[0], (char *)(&b), 4);
> +       memcpy(&vendor[4], (char *)(&d), 4);
> +       memcpy(&vendor[8], (char *)(&c), 4);
>         vendor[12] =3D '\0';
>  }
>
> --
> 2.49.0
>
