Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7534104E
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047671; cv=pass; b=ldenJbM8d4syrh+SZqNlef5F/NvkG1hvLlawmiHBafha7omwFMFgkol8BArCnXIxXcVJr5HH85dw1vipFjl+mEaKB6IbHNAPU6hl20zkQsgP9tl0Zc7XtU6V5GswHPTn49u3rdHdigHIPSFY+JpiCvOWwoqGhZuNiOJhjBvQ0eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047671; c=relaxed/simple;
	bh=n7kyBO58HIKubWTU0+UEyTIJTUA0l1RvR3vOdTguO64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TkRffuE06HQp09iL0kDgY3nyKNnYeeQs+6FZ2Z+PnUZC+6lMf6V4JqRaMUsEtq87rVnBloyNIwfhu52JEl2wqthellc1PPU9+cJ2qZGZmBsUXmykPNgWAKP515rX1ZkvAhqN9CwSe/oTCTloX/Hg3Acq4j4BqwoblTtLuhS8BZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjUUqU5k; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjUUqU5k"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1270f10a774so2613c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 16:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774047669; cv=none;
        d=google.com; s=arc-20240605;
        b=OsqtZVUfU8iutgYna/ToxYvlraz2I3f1Q50Wunl9Wn7MoA9oF7PuA3zJEscpIx7n4f
         4JMxLNeoxxiTHHxjB+D9Q17hRsnew528Otfd67NxVGI+LUmaN4TSUv8fDcIRONGM4z7O
         ouy75ztB+zyRyyxmzy/JLOn5AN40nstk1yHJS//GRZb1ryNHwCQuzeBT5zaHI81IdHk2
         7bUSfmmYqWZxxPx+cmjcpr8Mh9ysYNZcZngWaV9LFouEBSxU33h/YFpcFUfGsVElBbKc
         dGuAU4QCtrqz680tzVRWU1r/fT6Xt+2Et5wxyx7KSuIHsec32F606ocpH8i/4KEQVf6w
         PmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mDG9J5g4i5hOxeHv8jjkmz5wh55Ivyt4W0wY0Uts2kA=;
        fh=N4pFhtGqCcS6VpeB5DEZ2fG3ADe1+HRBbc97wiFj2BY=;
        b=aN/h6y/3G7WujIaF0jpj9wbOzPs3ki/1DKUBeEPGPQEHKobiU+CA/i27bTVLgtzkX3
         njobQMk90Lt7v9ir/PCgikqeoRZz3MJWEDhDmL6KRiHR1K26qXFQOQS2Ovv98jRVKpgv
         9ZfcABqAVpZhYGTyA4d8YIz+XOktcgPSrBH9VcVMt4g96pDnVkumez4MRxDUuL3HG0Hs
         N8UdWxrNMmJud5GpuiNOGNx5dkn02+DiFxCz3B2j8mW7P5dIyWCnwty3yZ9P5ghPQqJo
         5emaixKzgoSmyJPW20aEOeI+fELA0WmolvO1BqamY2txcDCjh6oLVRGUo7cUTKv6FNf+
         OL/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774047669; x=1774652469; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDG9J5g4i5hOxeHv8jjkmz5wh55Ivyt4W0wY0Uts2kA=;
        b=tjUUqU5krcQbGxmhY5/1q+s+RvJVXXgt3uLCkO/jWdqqENTzjg9RqE4iFq9o9wCxNM
         wWoHOrf0oJzZubZqxqBJRwU3IQlbmggCuYi7Ovyf8JL+XpVDPYkNh53a+pLd69LtnVDG
         iMIgXm/9It8L45tF+9Eb5Hq2x/4OQ5gB+D7buhOHiIbxX5uKfGVh2LM14ua1aVSuEDnh
         xJ53KnSOa6Dwzjo7QLoR0ipAqvKXVeUjPbJDP3hD5ffGuXyVm+FM6I4mKwx8OhDMOIQB
         BZTieUfPD50CXrQh1X8CiQC5DuRqI01Nx2A6HNJaU60SJOj2aBO3/BG+pja1APU0eCD1
         MmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047669; x=1774652469;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mDG9J5g4i5hOxeHv8jjkmz5wh55Ivyt4W0wY0Uts2kA=;
        b=ergjoaXAYKsPLLKmZM2Z31/O4WLBcG/EXRiOxMDDsWPM3OZyrv7dXjJWQjrDoQA/0M
         +pG6spbQAARc1ag2wj4D7TRdHG4Niwu/oY3IzS8KXh90JAGrxRMGICEH9jXOuNGRPkI+
         XuxjCr3wr85s/pyv7tMud+H8xnROqhDP0k6w+ZLLyhiyYxKPL6J7NomDy2U1xwSLDVx2
         mrEhOtuOvmz1SNw4y9SUWp3yf8HYx0K9RQE6jk/CQMrarAoo7vbHNM8Z+Oichhs9kMY1
         Dx8v+v3s8AJDTMSu8Q32hZd3AW8yRKQKlFBzF9vgpUQI11PtTd1wZGZhq5Pek5ComoM4
         WmCw==
X-Forwarded-Encrypted: i=1; AJvYcCWiofePc+/ZpiKv433XnKblE7M17tmhUOu62Z1Bs/CAbrCLKePSeJO58FzYB2KxxMlAVU9p04Pp9rWEyv4xmVuD@vger.kernel.org
X-Gm-Message-State: AOJu0YxWC1TKoyqD60FpWNtkopB3nlmUGNR8N1pk1RLI3jKkm5DS+oXF
	QEUnMqA0abh20jMmrdAKxD8spMcUapU69MwBPcA2liDW/36K38PNT5E4DKgTO8hJi6Gphd8cUBy
	v0aMzeJ6zJolC9KKzYORc8qA1nAobqPTFALnNKwmy
X-Gm-Gg: ATEYQzyf6W88z6J6ZIba+wx6+pST+MzsE4hHbwO2LKh/X0YR63zgTbv7Sya0XRhxBy5
	88fAu5EvpAb4SssIkfG24uaxqiu/JZupgo3m4uoij/bf92Zbf/ts/mJeq9Pw1kQXYoQbF2pOLTK
	hjFSP3PN+615EXiSr86tc1YoTRpjaObLGmwynG7nYUODNdWNhruEOQbk9YC+hGVYX5GKdQu/0vA
	hdnbCFPpfHT8+0BwqYAZpNqA9gPtCWCckcx6O1m1kP7nrgvNhE7QutNMUBEeSmHiO9G6jC6pMGK
	gK6zrfha
X-Received: by 2002:a05:7022:4a1:b0:124:748c:2ba5 with SMTP id
 a92af1059eb24-12a7ba03f6dmr15388c88.13.1774047668658; Fri, 20 Mar 2026
 16:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306191908.2065682-1-irogers@google.com>
In-Reply-To: <20260306191908.2065682-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Mar 2026 16:00:56 -0700
X-Gm-Features: AaiRm53a1-dufHxe_IOaBWYVOfSBTUwQ94luTPETlfjxDyMeKXUPSJEAHBNkqig
Message-ID: <CAP-5=fUWOKFwHZKYUv3ntxaPb1aFEEmSdo4npfe9oG3EPn7qBA@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Add -funsigned-char to default CFLAGS
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:19=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") made
> chars unsigned by default in the Linux kernel. To avoid similar kinds
> of bugs and warnings, make unsigned chars the default for the perf tool.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a8dc72cfe48e..3820bdf73f43 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -349,6 +349,7 @@ CORE_CFLAGS +=3D -fno-omit-frame-pointer
>  CORE_CFLAGS +=3D -Wall
>  CORE_CFLAGS +=3D -Wextra
>  CORE_CFLAGS +=3D -std=3Dgnu11
> +CORE_CFLAGS +=3D -funsigned-char
>
>  CXXFLAGS +=3D -std=3Dgnu++17 -fno-exceptions -fno-rtti
>  CXXFLAGS +=3D -Wall
> --
> 2.53.0.473.g4a7958ca14-goog
>
