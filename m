Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639227FB37
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956119; cv=pass; b=MokD4Oy6SCNw1yJnZuE5FSZMGYrRo8GAGwjU2DZdN+U4zeY1v1Apc9mQxASd/WIAHGuPyklEiYm9nL4s/nyM0XSrvQ0CWd3e5CWNnCf9n8K6Dv6NGlTcsdBBe8zZsxsf/NXN0p5vZEnczRaYF1z4Am7eI0AinzbJmYJ2vrbek8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956119; c=relaxed/simple;
	bh=ha1ZUgXYddzc+l78GUKK0qumdW1cZlvgwVLhvLF3l58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNG/TXf5LJ3Mh5PgSCv+B3mYhn590fKYQ7yqErN/yevFOdjguI8motgGhKMa6ejQa7aLRnMnUh1lTLAB/mi8a+k8gLiYgmENjub/dR3RIfY046RQUuk4kBEbnIzQHpu8lCRmWVes71+4YXBEC7yPywWgjafRpWHnLzvWMpaxuGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JT0d/x3Z; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JT0d/x3Z"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf22c18ad3so447655ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 15:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780956117; cv=none;
        d=google.com; s=arc-20240605;
        b=AeLRovJBVnQg1sc+thPNLJ0KQ/Z5lPqe/2xstlqlL4LUdhKTcN3Q0zkUXjgQIMHCL7
         6r53SrpoCX3sxjhYYg++9n99oAQ5CltIQgTXvb5Kvc+P4Ll1CHUWoT+hYNwmw1CSavq/
         byihq9IOcALuaeBPI5QjfWJK37i/6OCnHSzxmiT7Xmbr+z4MT3fLeHQn18KDuAn/2B55
         uCICcLynRWSuzt4ZT2K4ZvYJPxntxWa49Z48oEnJTI6nsLaBMlHRWxonT+f5RLadMNBw
         sgPEzsD7vr/RBwahPo6fUj4J43RkKYE3Yd+Uw1bdcskkoJAKGKMCXyESKfDh6OmXd1nI
         CL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1n2fXkM3WsAVSHsoL5qEogmvVMifLWFatPpta/Q9lGM=;
        fh=n1/7YbWv0+oMh8Z3GcMzKFS0J9LA79Sl5b6WDx0wApA=;
        b=j/jvYaU9xYQgXMw+fq3/QQrTlUFTFo/NRDQEDgi7TKNRJ5nMUFuz0n5l5R6xbOpn6E
         PDJVC8nzd0LAFkbYp/03OU2ZOsJ+qht+EjqGivP9qgzaEYjpaAAHG/3x0XaS4yoxAhg2
         ZdkivmtPy9FYsXAbVPDNXK6ut5nI3mFrnsbEQkmW2W7DCJ1gjrjwwrYwjRBobyzFp+La
         ZQd95WwJclChOVcK6YeJmu3TgeCR3o/w6XSa3dJE0id53PavmAQ6SJ5LjSWy4beIVrko
         /mjGhF45WZFpsriDE0Usld0aKoRTS/E5p5Z2lwhywurITlJ5BJpCWyOhV2R4fyNIlnrJ
         rdCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780956117; x=1781560917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n2fXkM3WsAVSHsoL5qEogmvVMifLWFatPpta/Q9lGM=;
        b=JT0d/x3Znq6mD7bmUC4mrGkJCGxfqsppNh/wXdVT9k1FuUZPZJvIG/pF5ycA5OsDfj
         U34kWpXw1B9cbsQYs7qM5Qf8w6KX18jGcvAlZxoyFzRnFGhjzVpNIIzoAwAnI1l0BOKE
         25MSBHQIh46z/Y012C4ayQv/Kd5JK/6dyxC9FDI8RyYHYtUgCKFOUl7LA4Bct3xL+1nx
         w3eWqO2i7r6Ab+oc2gXYRs9ytvgO/agVI+nflHBnqR89N/lFOliNbhaxML5/rVUweA1i
         cIt6N2z8wUj7zbSPmQNfBGxBeamhxxlKwanBKgN4AQ6rUQmha4uSInMr9Zh+OrBcG8k6
         AqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956117; x=1781560917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1n2fXkM3WsAVSHsoL5qEogmvVMifLWFatPpta/Q9lGM=;
        b=d6VDuxwmqchHQvTr115qFzGodSWmy+3+SvjKCkXVrRstrMj7tViVkDon8mpevFuJXH
         nC8xVtCYFVYBWHnIpPR7MJVJxUF5+UQvUUq93hGbRIV40+YNuLYtFf6CYbATRjpSkimt
         j4kcnwPNSCTu7ZNBDC+PY04XpQfNzwdOaKa9MvY0ciAjYCtw0X/XMqV6YODo5cQDW4MS
         lZhN8donEmNMscTmgyoQC/yrCIKl0M2q2zIQAnCAEtcJdgO+Fb7dOK8fJ42x5S2UuCfu
         IN+ogQefoLNCIc5Da8fp3LBeA1JNpCoePHxky8RdM+WAXNP6LVz24QjtH/Uqu0KHCCaM
         HBfg==
X-Forwarded-Encrypted: i=1; AFNElJ+htRLzTuh9Imh85J3VukE4MgZHx6aO24HtTJkZbq3MFnOepWSIH1n80VzU6iGbv58nFHg/1/aFWv75qhNgPQLg@vger.kernel.org
X-Gm-Message-State: AOJu0YwyyeQ9bjK1dgk2oTtGntehJ8E2mNCNjyOWgRdMYX0t/YgeFKi3
	Zr4IFkf+KdOwXxe8/nAVhMWPnpjmvOapM11B0ACakt1nOnTAy4H3EHz8a0kKkz29XfqrS6oVYeV
	b1RFhjvnOWb+3FHXF31qNmZ+N4j9JN2OV8JoXIMDp
X-Gm-Gg: Acq92OFgunQnrIWJKKha3ZV6j71hZRzilifmvvuy5xIrQRqbtWKGlDXAwa0lV1sQA9G
	RW7++46BRrjwHnVFObF0gr9G6WUsN/QeqrjC3js1mBRt51UBqr7VC7ERkP2ZyYJgoFLgFHfLE2/
	4rTIwVnX9l4Qx/jH3GjlnKxngtpaS6+5ly1RNyvCom6v5xrxSkeegPXQ4DmoQ1S6fmSXqgKJkt8
	h3PzcA3tFkDf+eQEvi8OBsFqbllqAEidyIYALL82MRZG7Vd4Q+YZYhBfAJxuMNlgC1UScyvD+Fi
	y+ekFSdCVBUk5wdY4bvn4xddy3iWUJSAdAI1EJXVsKED8/zN
X-Received: by 2002:a17:902:ccc8:b0:2c0:bf57:8746 with SMTP id
 d9443c01a7336-2c1eb6276dbmr6717215ad.18.1780956116933; Mon, 08 Jun 2026
 15:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-1-acme@kernel.org> <20260608201753.1979464-9-acme@kernel.org>
In-Reply-To: <20260608201753.1979464-9-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 15:01:45 -0700
X-Gm-Features: AVVi8CcDtvU8Otk2UwkYpefyqDOqIZWxxBQCMYMYkr8oc9MAciW29I71oSF2rq4
Message-ID: <CAP-5=fV8XFdE0TQ5Fih2UqppFcCAN0G-V=fNbZ0UWwr2p-Wabg@mail.gmail.com>
Subject: Re: [PATCH 08/11] perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Song Liu <song@kernel.org>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Both functions accumulate formatted output via ret +=3D snprintf(buf + re=
t,
> size - ret, ...).  If the buffer is too small and snprintf() returns more
> than the remaining space, ret exceeds size and the next 'size - ret'
> underflows, causing snprintf() to write past the buffer end.
>
> Switch to scnprintf() which returns the actual number of bytes written,
> making the accumulation safe.
>
> Fixes: 7b612e291a5affb1 ("perf tools: Synthesize PERF_RECORD_* for loaded=
 BPF programs")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Song Liu <song@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf-event.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index a27945c279efb779..2c09842469f1f28c 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -36,7 +36,7 @@ static int snprintf_hex(char *buf, size_t size, unsigne=
d char *data, size_t len)
>         size_t i;
>
>         for (i =3D 0; i < len; i++)
> -               ret +=3D snprintf(buf + ret, size - ret, "%02x", data[i])=
;
> +               ret +=3D scnprintf(buf + ret, size - ret, "%02x", data[i]=
);
>         return ret;
>  }
>
> @@ -140,7 +140,7 @@ static int synthesize_bpf_prog_name(char *buf, int si=
ze,
>         const struct btf_type *t;
>         int name_len;
>
> -       name_len =3D snprintf(buf, size, "bpf_prog_");
> +       name_len =3D scnprintf(buf, size, "bpf_prog_");
>         name_len +=3D snprintf_hex(buf + name_len, size - name_len,
>                                  prog_tags[sub_id], BPF_TAG_SIZE);
>         if (btf) {
> @@ -153,9 +153,10 @@ static int synthesize_bpf_prog_name(char *buf, int s=
ize,
>                         short_name =3D info->name;
>         } else
>                 short_name =3D "F";
> -       if (short_name)
> -               name_len +=3D snprintf(buf + name_len, size - name_len,
> -                                    "_%s", short_name);
> +       if (short_name) {
> +               name_len +=3D scnprintf(buf + name_len, size - name_len,
> +                                     "_%s", short_name);
> +       }
>         return name_len;
>  }
>
> --
> 2.54.0
>
