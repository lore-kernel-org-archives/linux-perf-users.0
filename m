Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FC24A066
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226299; cv=none; b=B8USEu8/X9bu+n0/qXVR788YUxc37Og3Sxri/gJGJ2L2BcuY8qFbRvRz8hXG4pZDP05f1INMsRHmYsuGGSZ7wlAojmfaZMhujtCrgRfbjxSvkzsGgktXTo2Aa7IsipdFPbid/JoKFdeXTG1kDsaxfjV6aH/xy/Pkfx1Vc5OlrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226299; c=relaxed/simple;
	bh=B7c2Y4z7IK0bBAMEZDkwYzdnnQzcprBQKAjnqLj21q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpXisL5FyRJb2bQd+ka4EmWqILvbvWLS4aNvg7+zDqBlkpppfquitVq2+d5SMW7zLHo+eqB3YbBxg/px1AX1CYGhmu3PUXNUoEuLKWf5tVTOx+vw2fXXUtnSAmClbGm40lZ9emH01aEomH98LeSN/ti6gtqv9h7xSWmgmJquo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZbCAX+1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZbCAX+1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225489a0ae6so34895ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742226297; x=1742831097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5OlWZyikCPnAOFdTXmrFoSKCph7ASBwIJqix8Eg/aE=;
        b=dZbCAX+1sLjbXQTIk9r0UdbgZYRaprOx0pfAcMLf1Ls7dZ3mU88gwgLywjE9lWHaOf
         bN5CfVG2u0Mglv5N33m/y0cq/ABBP9YvKNQKBcVF1ehdKkmJfwS7pMqWjZ9mD+B88dcg
         XsLXEe03ZIwE1EkYUJWfFspOzUGhI+868fI8ra8YchkMBywLEGp81SEQybi/58A181Sy
         qRQ61mqr9crNT2wJy3gc5NHrrnhTPCaQrcOskLWvlZoMWXI21yrQeUSNfcM2sF4t0vGu
         oXL31eT+9qkbDEC7rPEbicIkxQBY2nMoNME8KYorF4yrXepBqIRPiv6riEtRDCLp3gOP
         3mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226297; x=1742831097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5OlWZyikCPnAOFdTXmrFoSKCph7ASBwIJqix8Eg/aE=;
        b=rtMTu6c4DA/LBP9Tl8Lc3XNf6APjBJ9d9H3wi3NNNiIx77c9jz70OzJUaKmjpqP34V
         mTUfU0aCrmuRo4FiC6HLnkpKZCq63qPbtTG6bp1y7ME9O2rNV/u6CIiUrN63T63d/uLg
         UWpgpqVCGL7PxNBkkx8j7ivDvcpdPvrjRAl+TmYU9BRb7AIZHGNjY7ifV2t65ZHR2D/d
         zMZNTj1FBHpOZ5GKAaorMXXgH56fD6OAZoFaG0S/wTo259oqG96HWFBaY89ua0kyao80
         a7EXLVD8p9XMJFuBqnzL/FIhjP8qedbFIp+GCWvMqrYD+2V7vKMIXVNpmDrUsnm7iUzq
         Tnxg==
X-Forwarded-Encrypted: i=1; AJvYcCUlkGLxUANkgks/TB7Un2pirpvz+imi/DuVBp6i/8IprPzi1rEWPZVtsWvD+LACt0zgwRjPx0LE3PNlPGdlVevC@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvDO/RMF2VWhAmpjQ9ee+thOCFp3UxjzZRg1l4XOvbZr63tUF
	L9QAJzbwoqBh6P5Y2cB5q8pCnM4gd5F6J4vt5AUsBJNafioBJXJgSjAJoiNgQkjgbvcHIdV7pVD
	l103vE/rQxfw9r8g9kmvChZLSDUv4tDmjVJsw
X-Gm-Gg: ASbGncttXU5pEU2lDTr2U+Am7ZduBDFRMSatgygMOybgFsehA52/k2DNYWcWRZgv37i
	0KBgpuRXp5eKhNnwY+oyAFih6JcitAH6RZbQnmHFdwfK4sVdom7P8lzfl160uKIvuGMmJkGUjSu
	XUM3fv3UPT8zYGqGKKQPc8O3tKtLsF6EguaanViuQIyODyBR/ZI1ZR8x/KfJKV44OVpA==
X-Google-Smtp-Source: AGHT+IGb0tr+WMR0R2Hjk0TLnVrUU7IZXnn3I3kas5Z1APzQmiaDhx10WNGGrH2KC7JMGKhAtZ+1THBL+g9PhbnHb/Y=
X-Received: by 2002:a17:903:1ca:b0:21f:56e5:daee with SMTP id
 d9443c01a7336-225f3c14a1dmr4314055ad.6.1742226296645; Mon, 17 Mar 2025
 08:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314031013.94480-1-yangfeng59949@163.com>
In-Reply-To: <20250314031013.94480-1-yangfeng59949@163.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 08:44:45 -0700
X-Gm-Features: AQ5f1JqBFu4brBFu6Z-rnLiPVDfXVpZSM1gOcQjfzmMkaZh_omo7Liv21m0A-X0
Message-ID: <CAP-5=fUPz9R60Lay=k-0k5Q8C9AdStAMycOgsKqA5MJ_o7Ag3Q@mail.gmail.com>
Subject: Re: [PATCH] perf kwork: Remove unreachable judgments
To: Feng Yang <yangfeng59949@163.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 8:10=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> When s2[i] =3D '\0', if s1[i] !=3D '\0', it will be judged by ret,
> and if s1[i] =3D '\0', it will be judegd by !s1[i].
> So in reality, s2 [i] will never make a judgment

Sgtm. Out of curiosity, was this tripping a compiler warning? If so,
could you provide the details?

Thanks,
Ian

> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/perf/util/bpf_skel/kwork_trace.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/kwork_trace.bpf.c b/tools/perf/util=
/bpf_skel/kwork_trace.bpf.c
> index cbd79bc4b330..9ce9c8dddc4b 100644
> --- a/tools/perf/util/bpf_skel/kwork_trace.bpf.c
> +++ b/tools/perf/util/bpf_skel/kwork_trace.bpf.c
> @@ -80,7 +80,7 @@ static __always_inline int local_strncmp(const char *s1=
,
>
>         for (i =3D 0; i < sz; i++) {
>                 ret =3D (unsigned char)s1[i] - (unsigned char)s2[i];
> -               if (ret || !s1[i] || !s2[i])
> +               if (ret || !s1[i])
>                         break;
>         }
>
> --
> 2.43.0
>
