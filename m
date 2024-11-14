Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC771714D0
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599400; cv=none; b=FqHDwawgjoCYD/Zc5+H8WQwqIh+SIU8Wge0fZnTJ8d4A6N2Z7QxjCatKamHrBQx/RY6/CmY13YfqccIBz/7ppKSGRcz3a0oq3LKo8dqR/cgrrfjMJgi31vv65rqcl+XRfuOQ5B0tgpQonU+UgyR+Aj0zwHS/Ui5/3+AVsy8IxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599400; c=relaxed/simple;
	bh=ITP3dgO8v27WCLg+TdnhRJ+qx1xnVDzTEpIAdi4ehqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXKeOoCHA4/hAqVoLdEGiGCjoN6EZVAt3sOg47HobQ6Webua+GYSC7DW4UxiN//XizNT73+QLcFyLERV1WPZMtXha5C7PHMIaoJf2snxPz1W39x5RHeGTCog0Gv9DyKyOQMHMGG9aklozVrxdNpn8qgiQ3uVEjV7eVjpxbPfzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=znFBGdVW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="znFBGdVW"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460969c49f2so257061cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731599398; x=1732204198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzQOPO2gNiSOZfK9AM7O4nwO0nS7weWvcXidNlheCbc=;
        b=znFBGdVWqpcyuK9ch/AtVeb9OaYr1i9hKqTpXKIsYgCdVRTqmyjK0dCH1Yyuuafvv5
         DjEPEZh+3Bzyv2taP7PmBgEoeIjvM+SNmzDsv5N+2Ouy1nmkLzIN4nBnA1OZOPP2gxqP
         r1dJcf3g2UQXyYt2UlXLuR1PPGsaTpnSWTybBJITcDCHKxZvYIXnLR5UmBeDEvxSfmZq
         TwqMb9BuDDFAwVWvJtWQyEQZiycZ1Dii2Mroy5bB01zqTNQPUxF1BivZJ2nLh0jJVnna
         rPS8fBjkzd69fZq2M2mT5UmF5fwEdgjmxnXsvnabp0NB+8Lc1XJFztih7GKPwfPA69nt
         YlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731599398; x=1732204198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzQOPO2gNiSOZfK9AM7O4nwO0nS7weWvcXidNlheCbc=;
        b=SN1zBTjCArTPtldHNTkvzz1vsaCKslLjyVqlC+XDQ7EEWgWGWfeLAZE7XsQPwS9EJ6
         e2XOxIYF+/98CHIhDnI0bogFsUCUBjQl+UCDYbulzE06fC/H7gpFra17vrtj6jzLBvmi
         hYs0WskEE8rUUoGbjh/t8WsQuInCQ7IypcgmORRTlUutTbFl7/whZAiuOfpLmTp5FDxB
         Y6BiBbGGc7GDR69SFHDR1yqZkhf/QBUKl6mfnSjQqn8qrnRZwF8FLfLyFxdkf3dSmQkA
         OUeTtouTOcQRNJOT1fVsr92o9fN2lBE+VHMEMkWnNbKAElbk9wZmaXbb7kmUwuVY0HqV
         0lHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6XzkyCH4IHOUHpnLwUU4m/TzDPRM4Zfaa+cnJfuLFEZGeDjB4SjFkph2qoVoQkiIiL7sPYsZTz2zrA7tb80x@vger.kernel.org
X-Gm-Message-State: AOJu0YwAABoTJOkW/TIg/9v8hIxCAowhGNfH2xSnpDniyrbrunLZY9Xt
	4j2EDr65mpZsjgVsLCQgyHSmDq6D9viS4G+mpU6rVhjM29sw1AgeSAEW1vLssV9Ciitqkm3I5gK
	Q9uqLcIUX08HpL44rDNUoCwtw/UXKMVFx+xyY
X-Gm-Gg: ASbGncuIclXra16k22hG4S2OD+gkOcOp1Sfk3k6dNKDTDNVGKayNEqln4haEGPUsFtE
	pNxC6FnHvwRowRBB+UtQfk3BW4K0MomPVkAsmiLymqkwKEkb7ceR++AnzsDER0B4=
X-Google-Smtp-Source: AGHT+IG8vzd2WmRoXFEByvRRV4+tnhHmetbB8+jZZkCQhdzcVBJdCXZzk1XXejD85yLGOm5zcfK2v8k+0BiMQYw0vYA=
X-Received: by 2002:a05:622a:598a:b0:460:8444:d017 with SMTP id
 d75a77b69052e-4635f3c0097mr1169501cf.27.1731599397890; Thu, 14 Nov 2024
 07:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com> <20241106003007.2112584-2-ctshao@google.com>
In-Reply-To: <20241106003007.2112584-2-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Nov 2024 07:49:44 -0800
Message-ID: <CAP-5=fUc0YttVUMB9oAit3u5hzVGuK5rTLnP_dXD0kqt7QcO5g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> wr=
ote:
>
> It gives useful info on knowing which PMUs are reserved by this process.
> Also add config which would be useful.
> Testing cycles:
>
>   $ ./perf stat -e cycles &
>   $ cat /proc/`pidof perf`/fdinfo/3
>   pos:    0
>   flags:  02000002
>   mnt_id: 16
>   ino:    3081
>   perf_event_attr.type:   0
>   perf_event_attr.config: 0
>
> Testing L1-dcache-load-misses:
>
>   $ ./perf stat -e L1-dcache-load-misses &
>   $ cat /proc/`pidof perf`/fdinfo/3
>   pos:    0
>   flags:  02000002
>   mnt_id: 16
>   ino:    1072
>   perf_event_attr.type:   3
>   perf_event_attr.config: 65536
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> Change-Id: Ibea5618aaf00bae6f48a9b2a6e7798ab2b7f23ce
> ---
>  kernel/events/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cdd09769e6c56..398cac8b208b9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -55,6 +55,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/buildid.h>
>  #include <linux/task_work.h>
> +#include <linux/seq_file.h>
>
>  #include "internal.h"
>
> @@ -6820,6 +6821,14 @@ static int perf_fasync(int fd, struct file *filp, =
int on)
>         return 0;
>  }
>
> +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +       struct perf_event *event =3D f->private_data;
> +
> +       seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
> +       seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned long l=
ong)event->attr.config);

nit: is the cast necessary? I don't see __u64 listed on:
https://www.kernel.org/doc/Documentation/printk-formats.txt
so I'm unsure.

Thanks,
Ian

> +}
> +
>  static const struct file_operations perf_fops =3D {
>         .release                =3D perf_release,
>         .read                   =3D perf_read,
> @@ -6828,6 +6837,7 @@ static const struct file_operations perf_fops =3D {
>         .compat_ioctl           =3D perf_compat_ioctl,
>         .mmap                   =3D perf_mmap,
>         .fasync                 =3D perf_fasync,
> +       .show_fdinfo            =3D perf_show_fdinfo,
>  };
>
>  /*
> --
> 2.47.0.199.ga7371fff76-goog
>
