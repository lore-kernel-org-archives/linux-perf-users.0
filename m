Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5794D8DA
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901572; cv=none; b=g3sxh6wVCYQETrsHHXCcEcLbawGtEqJd4EQKPr83Gji08bHWLxD9M+MsoPePfvwai9gAkJqYAnys88O2+uvbSevoFMUMg6eX/dkqMjVpjhWIiT3ej6tXKOETWeY8q8htEZS0eGak1wOP3t7wpGaw9tONZ3R/v1LCgIq6m/ZRpC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901572; c=relaxed/simple;
	bh=p8PHlMcU/4iuWXpyhjdwBHlCib0xBPg6mxHXlta9jbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f13HYU3Ne+fOtJqGLUXNEqh0XOqBG/q8oyQ/376hm1lMTOaPY3RujfltiMnTXTXwrL0sW/lJKzY1l8R2eLtPIgrYIfiRwmbcR8iO2ccoJ4XGnYhol/28ez+47VlqCeNBm1R+7hKTdtguLeEcVC2BULj2AVTuJMA7QK7Sw0Yc8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQt+mYg/; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQt+mYg/"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d3ad05f8eso7035ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Sep 2024 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725901570; x=1726506370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBnTDAYEC9QTzWNDw7caNJD5CpXdhvSAd1qYJUnxR7U=;
        b=qQt+mYg/SkPhH/1Wdw03GtKf/YS5gQYcxBAAaSEZMEsolTSU0zy42UZnOAV8nft6OZ
         5hRwyg/wo9S3VzSdYy7ZFZIg2as9FpNIYLh/7SkCDMirK1fdKm4l43MlH/LmI11UvRtA
         xscC2KIute9IKr85oB3XfL9ONNrezImPQXNZnIZyyKmphOvEbTJhIvDtybuPmGgnONQO
         6te1lOqb7b+5RRv5jaV++Rais1XdXZy9SrpU6GoEhdXAZied7flMQgGvSP9WQ7pwPQ0T
         UaQP1A2zgfK5RVKIjKoHMEHiqJOJ3OBTEhAPmwipmMgjSmSLQL1fY3Y++7l3vzTRCdxD
         TreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725901570; x=1726506370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBnTDAYEC9QTzWNDw7caNJD5CpXdhvSAd1qYJUnxR7U=;
        b=MpspUnjFfGEqZDMY82KyFJMZfgSjk8I0mZvreTI4dpydrvyXrYRUy+EbS5iSDecRyu
         Eoz/09K1IOTuIT62WivQHZqIWhSUkWUzSvCdIM+nO5NIvGjmQreoyk7nrlcUonpG3r+Z
         fSDC9jN+rhj5HWkM7lVWGwq+G5PA7gTt3bnJBAiPt8MqzXFknuC2kPRmMAkZoYct1Z93
         djQD1Ee28r0md5gGFEWdN15CUTWko0OoRmBBTunXKvauQfjVK5r7dInx9byeIFy2oVD0
         WnSLw/jPT/BsF6fL6qGhlCAXjXaZQPibFuN8LGuAUtd94+7vLehgVEbDANcIirxUK/uk
         5uWw==
X-Forwarded-Encrypted: i=1; AJvYcCXclNOVRXHwUZHZwAJF+bZRMCaKKd0CT/o/+etIi9Jo2tz2ZqolFEB79wp/m3xGmPTp0UPkpWO2WkpuEMoX2BdT@vger.kernel.org
X-Gm-Message-State: AOJu0YzWW0kcCyl/jNec1cx4ZSiWJVhPDFShmgBKTuM7ZaI7QcGgagKk
	KHGqk1DBIvJ+EEV7PkHbtP6PgTAAeV6UaccqWcWTkMPOHBWHTnPZUsdLTL3huZMkEJ3d56aswp4
	GsaKR/zHADjA5VUzG6NBmVpQHB5mq0S4dOgW6VgFctGepdwcn6/il
X-Google-Smtp-Source: AGHT+IGRn7vU9U4274lGR4Q3UHsE6SuaSPZ/mwqf3eoGvQukw+BUiGPf4QpV8fNONkqS+RsWuGguOXXEd9pfaChaAFQ=
X-Received: by 2002:a05:6e02:1a41:b0:3a0:46b4:6fe7 with SMTP id
 e9e14a558f8ab-3a057ed111cmr6482565ab.5.1725901570018; Mon, 09 Sep 2024
 10:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906195020.481841-1-acme@kernel.org> <20240906195020.481841-2-acme@kernel.org>
In-Reply-To: <20240906195020.481841-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Sep 2024 10:05:57 -0700
Message-ID: <CAP-5=fXjGYs=tpBgETK-P9U-CuXssytk9pSnTXpfphrmmOydWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf trace augmented_syscalls.bpf: Move the renameat
 augmenter to renameat2, temporarily
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:50=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> While trying to shape Howard Chu's generic BPF augmenter transition into
> the codebase I got stuck with the renameat2 syscall.
>
> Until I noticed that the attempt at reusing augmenters were making it
> use the 'openat' syscall augmenter, that collect just one string syscall
> arg, for the 'renameat2' syscall, that takes two strings.
>
> So, for the moment, just to help in this transition period, since
> 'renameat2' is what is used these days in the 'mv' utility, just make
> the BPF collector be associated with the more widely used syscall,
> hopefully the transition to Howard's generic BPF augmenter will cure
> this, so get this out of the way for now!

Should any of this be captured in a comment next to the code?

> So now we still have that odd "reuse", but for something we're not
> testing so won't get in the way anymore:
>
>   root@number:~# rm -f 987654 ; touch 123456 ; perf trace -vv -e rename* =
mv 123456 987654 |& grep renameat
>   Reusing "openat" BPF sys_enter augmenter for "renameat"
>        0.000 ( 0.079 ms): mv/1158612 renameat2(olddfd: CWD, oldname: "123=
456", newdfd: CWD, newname: "987654", flags: NOREPLACE) =3D 0
>   root@number:~#
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 0acbd74e8c760956..0f9bd2690d4e5295 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -260,8 +260,8 @@ int sys_enter_rename(struct syscall_enter_args *args)
>         return augmented__output(args, augmented_args, len);
>  }
>
> -SEC("tp/syscalls/sys_enter_renameat")
> -int sys_enter_renameat(struct syscall_enter_args *args)
> +SEC("tp/syscalls/sys_enter_renameat2")
> +int sys_enter_renameat2(struct syscall_enter_args *args)
>  {
>         struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
>         const void *oldpath_arg =3D (const void *)args->args[1],
> --
> 2.46.0
>
