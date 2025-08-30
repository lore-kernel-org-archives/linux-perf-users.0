Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A578F52
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Aug 2025 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756531171; cv=none; b=gfuoJ+K61A12IB2LYgb7pJ95DmglAqyQeEHb/7nTVWQO2Owctd+BZhzt5nbtJVdtOC2Gy7zuFXI7K9s1NUBpRNa3m1ouNkCwxat0PCBJp7JJEyNCRheNHTMYYnPSdeSQA7wkw2D9TDQohWO/aoSC+SpvJD2YLCImMUfQXqR4soQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756531171; c=relaxed/simple;
	bh=fE+9JJqLH4AQ9yTHjvttQQsxKEwxCv6Db6kes/Tc860=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJ4BmRLfPE16rG90eMWwo7EB/jVa4VLJqSg4Ei/ikKNVwYUu+XXA+Q8/AR4VP6GIdq2N5h6mbfvaZra08Chn0Y37C8iFbCsBSvo3cpMKoGFOG7g96XyjC/Y2XQws0aG4iyv7+yy8ydyr/msWnWtVfGH6lOskj5Ji7ENMH6OYxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L8egTAxP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8egTAxP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24936b6f321so44015ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 22:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756531169; x=1757135969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppN7OhUjuwHgBU0fuTlsVS0risiTxfXqL+QgvTWau90=;
        b=L8egTAxPr0WIy5pNuc5gQUltr/T9ORnc5hnVMhBXpZFNQ0qhwQQA5daPw+FlOV48F9
         0sBQLQGDuweO3lfPQL2YWzN1taO8CENYldjfmwM7zlLSETevk0ifYgPgznhbTxQbCymN
         9H5zxyZO+fRGYmKcJtUPF7kPe4OOTTrOdgzaIxRfiiHv5YT4rbl0uFpiaK/vFcUauQNl
         D1oJgwhFpCDC29ArB3+m601FesF2qo4oJl5rCOkuBmlMAFxAsJYqP+MgguBEG0gRGp3V
         iii1v7UsYPm1GfrlY5qkKsBBzn9eaUq8vVeOHsq9xHwr8jczBicdyZfLfVuRTEOwYDRF
         NmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756531169; x=1757135969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppN7OhUjuwHgBU0fuTlsVS0risiTxfXqL+QgvTWau90=;
        b=Yrc3yQRPdKqCOjGVRvyMxAtWVMvA6L3UGqC7Ok+gzNaShWXycvy/OjeoOKwCroisrG
         B1lpwqkyIRHzhz4lI6IqAPh/TsGlIjTFDebooEoQObfMErMtgAsKrwltqqzNiuXQtQ+f
         pDrRVTg0C11BZRFy/OxyulvwDLLcX/e2T1urmKSkffSad8dCCU+Ahi0ubz4bFZ5Y8rB5
         pszsBbjOApfBMQyBM2+JeB24NCvzbWcwJyy/AF/I+0TdzyR0LdCo0i98uISlwOH+9n5n
         PRIYpaRHWSZsaqtx1KYhAHeeQbvUdwIZ5MJO7WBllqXP5UtMe84xMzkCwr6/VPx27VOC
         39pw==
X-Forwarded-Encrypted: i=1; AJvYcCWfwB4ioKXyy3RZGKeqCKdSraV2oh08Z4IW9VfxItW+XedCetb3NndYQXStfLJ50MCu81L/Fxe9NkpOoj7ApykP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2/mg8PIwksc0rmXmOT5vMNWNhjB8JsRr9ob7RpmFIJoen8y8
	AMVhlegmOdBX6lXnDlwiF6x9puBbzXFYNlWKUSHsfL6jieQi6f+weea0dDsnhY/+AclZKM5xs53
	sWrmh1DrP+B4YxdKKKT6LA9jwFc8g28FXH4V6P1XZ
X-Gm-Gg: ASbGncvi3Ru+DinqokSOCx0SuBbaznPOvktAVomXGrH7BPv8+dnwSJdYxmb92gbEDmc
	Mzis2AhyxVPERtKvydtrOb7ywTQ7jZFv8RZ++zQKlpZdiVNRHzL8mEuUUxPqMogac/YHVdk7VBN
	vS2PR+rUfDzQaUwWnZNsYMscOBtJ1/bEYevrLghlwoOkVb53v+lGBydXG9ElEhu/bCUcfsIoFMj
	TB7f6yrGP99Ukw=
X-Google-Smtp-Source: AGHT+IGxJC9u3UnyTAxH/e5Fi0JDjKy84Qim0fFYobeDU62gk8OfykmppY/rr47My6krEuZYmNTSezladEhD1cMLYmA=
X-Received: by 2002:a17:902:dac6:b0:240:640a:c564 with SMTP id
 d9443c01a7336-2493e7c6cb6mr2055445ad.3.1756531168997; Fri, 29 Aug 2025
 22:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603203701.520541-1-blakejones@google.com> <174915723301.3244853.343931856692302765.git-patchwork-notify@kernel.org>
In-Reply-To: <174915723301.3244853.343931856692302765.git-patchwork-notify@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 29 Aug 2025 22:19:17 -0700
X-Gm-Features: Ac12FXwkB-c6nRSHHpBV2DQ1VDfQ04aGKYqJraiFmYlTg8c4hP6BoccqgTTCdoM
Message-ID: <CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Blake Jones <blakejones@google.com>, namhyung@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 2:00=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Tue,  3 Jun 2025 13:37:00 -0700 you wrote:
> > The BTF dumper code currently displays arrays of characters as just tha=
t -
> > arrays, with each character formatted individually. Sometimes this is w=
hat
> > makes sense, but it's nice to be able to treat that array as a string.
> >
> > This change adds a special case to the btf_dump functionality to allow
> > 0-terminated arrays of single-byte integer values to be printed as
> > character strings. Characters for which isprint() returns false are
> > printed as hex-escaped values. This is enabled when the new ".emit_stri=
ngs"
> > is set to 1 in the btf_dump_type_data_opts structure.
> >
> > [...]
>
> Here is the summary with links:
>   - [v3,1/2] libbpf: add support for printing BTF character arrays as str=
ings
>     https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4
>   - [v3,2/2] Tests for the ".emit_strings" functionality in the BTF dumpe=
r.
>     https://git.kernel.org/bpf/bpf-next/c/a570f386f3d1
>
> You are awesome, thank you!

I believe this patch is responsible for segvs occurring in v6.17 in
various perf tests when the perf tests run in parallel. There's lots
of BPF things happening in parallel in the test but the failures are
happening in a shell and I did get to attach a debugger. I've not seen
this problem earlier as the patches weren't in the perf-tools-next
tree. Through bisection I was able to blame the patch and I came up
with this minimal fix:
```
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..71e198b30c5f 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -326,10 +326,10 @@ struct btf_dump_type_data_opts {
       bool compact;           /* no newlines/indentation */
       bool skip_names;        /* skip member/type names */
       bool emit_zeroes;       /* show 0-valued fields */
-       bool emit_strings;      /* print char arrays as strings */
+       //bool emit_strings;    /* print char arrays as strings */
       size_t :0;
};
-#define btf_dump_type_data_opts__last_field emit_strings
+#define btf_dump_type_data_opts__last_field emit_zeroes

LIBBPF_API int
btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index f09f25eccf3c..c7b5a376642f 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2599,7 +2599,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u3=
2 id,
       d->typed_dump->compact =3D OPTS_GET(opts, compact, false);
       d->typed_dump->skip_names =3D OPTS_GET(opts, skip_names, false);
       d->typed_dump->emit_zeroes =3D OPTS_GET(opts, emit_zeroes, false);
-       d->typed_dump->emit_strings =3D OPTS_GET(opts, emit_strings, false)=
;
+       d->typed_dump->emit_strings =3D true; // OPTS_GET(opts,
emit_strings, false);

       ret =3D btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);


```
So I think the problem relates to modifying struct
btf_dump_type_data_opts. Given I'm statically linking libbpf into perf
I'm not sure on the exact route of the segv, no doubt this report will
be enough for someone else to figure it out.

Given this is a regression what should the fix be?

Thanks,
Ian
