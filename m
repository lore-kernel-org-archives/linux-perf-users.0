Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26D1DA53
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Nov 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476959; cv=none; b=lsKxmJ6jagTn4Yh4OTLvg3OwumkmTg066qIwqCnmCZChyfbBQ5tcpygwaCwHnpTIQyV8r0PLsDVA07YLvX5Hw6I1oq5Kr+Cxodc+8F4b7VrNbpisOY1xWu0qAK5I9RdDfjUfmfwhrFpXOHdSlhQ1TKhw+yg2B7YDgdRtjXtjsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476959; c=relaxed/simple;
	bh=3GKBrVny2p2TifcSB3WctuIjIC7hYHaEm5aSo9o2juE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5WQzLmGwDNhP9kDTRCd8aI67tuB9VRHmeu5cWY73r8+ApmTc3LXuFgoxgoZ61Bn7BkIfztOPC5UJG+D+YRZGPH7m/bSaKgBhEtgvwpGp4rpYDPQi5S2zShvUYOKYJZZO3Ur/OZ2DYKED3lNqTeuFKuN4p45Px7HBuLAX5M627g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZbqLSuQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZbqLSuQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca4877690so115415ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2024 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730476957; x=1731081757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2rpfAEpsLtKNOAU374yYtxAN0UepXKdz1kTy844WGM=;
        b=YZbqLSuQ7VL2dYVVVC026T5yLpQq9P5/whM6gIX5UBhY4A82hnZbpXyZ+JwVj3Icjs
         YmUNTAlOz9f2Dg1ZGEstJJURRAlx1gmJziqsQ0UuKkHd7L64BS/1Utdt6BEX2cfS/Fcz
         Oz+uQO+GW2kr7kwS0otaIVWiS+Un6zO6Z/+lpP7IzjDp+qTAw+HW3KAVCuVL8Crb1gpg
         NhuAKleIEVYmncJ8qARyKdb/aZX9IlhSbVtQfpLNlF1vliNc/AA7o1lCmaCOr6mFYND5
         VzRzOcrzSgS99a78WEpe0/qo27y9t/7wYvwwtB9nAqA8XVPoOLKL2jyy1YD7G/i0nJX5
         bv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730476957; x=1731081757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2rpfAEpsLtKNOAU374yYtxAN0UepXKdz1kTy844WGM=;
        b=uyHPpzwtiO4iNkYf2yyVev4dBHLUpYIBrQfYqnnr4jLJnVjfgcxnuBllCBEERoeIAT
         fpbPrqqIJzbh7yaRoK12fvPyG+FQXJrtf0U5Y3gKLlTUgUflaNfelhgZ6pCot0Sm9S+F
         VIBzeD0TgeJv38uw6sWxHvoiyK+uLLAuXUwDUPqTPuCs1JXvgpQtTw7tUFkcOx1G6Opg
         kRtoOdnrKp6Aq1jbIO/Ig8eeyyTCkx43upzXDDRhVZxRjLgarAdWPBi2HYqTQ7yB0IM/
         waM5kqfDyzFbDMz1rYfr0ZwWNwgqaY4U4slon8zOaH3/jvtEnw656WSYhZsC7AxrWJJM
         Zwyg==
X-Forwarded-Encrypted: i=1; AJvYcCWQwJfcO/zjDQLTnEbkU23APh4B402oaDQ7bgn7knz015oZ1YJ4qs/ouKESKNcTDi1WPLViEcioFigHQLH6xhBh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5gUAFBcn4MwAe8NBsZFaMm45V7QPeFiB9bhUte8gufnWbnmo
	MAZC5gKVmdxnfun6ZDqgA5UJBSEZ+bb6OPtMYGVhTgwkGEwF/3YHGZycz2fq5QwFEQL1G0foVPE
	IpJrRIwVo+E3PhSwoDY6/BV9+tjpHxqtAK2lr
X-Gm-Gg: ASbGnctQ11pXBXJGf1VyU7d4geF5WZ/47Lu/2ny0eJKQFPR02Szu93parnrfrl2FLTR
	fd2HbjX61SkGR3rkdH3VdskZO3IdeqqgL
X-Google-Smtp-Source: AGHT+IGM2L33nn/G3uhGQLPmrXLjceVs08q5vkjwS9HQF1fX7xGb7+zd7WkPYP+bgCq5nmPeNJB3l50fp+eNvrgmDb0=
X-Received: by 2002:a17:903:246:b0:20c:568f:37c7 with SMTP id
 d9443c01a7336-211055b58femr4605115ad.17.1730476957085; Fri, 01 Nov 2024
 09:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com> <20241031223948.4179222-2-ctshao@google.com>
In-Reply-To: <20241031223948.4179222-2-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 Nov 2024 09:02:22 -0700
Message-ID: <CAP-5=fVaD8GLhMmM=d4DqHnT24ZDHPAWU56mzSF5OXY=pTO3UA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: Reveal PMU type in fdinfo
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, Kan <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 3:39=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> It gives useful info on knowing which PMUs are reserved by this process.
> Also add extra attributes which would be useful.
>
> ```
> Testing cycles
> $ ./perf stat -e cycles &
> $ cat /proc/`pidof perf`/fdinfo/3
> pos:    0
> flags:  02000002
> mnt_id: 16
> ino:    3081
> perf_event-orig_type:   0

nit: I think this should be:
perf_event-type:   0
this output was from an earlier version.

> perf_event-attr.config1:        0
> perf_event-attr.config2:        0
> perf_event-attr.config3:        0
>
> Testing L1-dcache-load-misses//
> $ ./perf stat -e L1-dcache-load-misses &
> $ cat /proc/`pidof perf`/fdinfo/3
> pos:    0
> flags:  02000002
> mnt_id: 16
> ino:    1072
> perf_event-attr.type:   3
> perf_event-attr.config: 65536
> perf_event-attr.config1:        0
> perf_event-attr.config2:        0
> perf_event-attr.config3:        0
> ```
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  kernel/events/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cdd09769e6c56..e0891c376fd9d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8,6 +8,7 @@
>   *  Copyright  =C2=A9  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.co=
m>
>   */
>
> +#include "linux/seq_file.h"

nit: I think you should use angle < > rather than quotes on the
include for consistency.

Thanks,
Ian

>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/cpu.h>
> @@ -6820,6 +6821,17 @@ static int perf_fasync(int fd, struct file *filp, =
int on)
>         return 0;
>  }
>
> +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +       struct perf_event *event =3D f->private_data;
> +
> +       seq_printf(m, "perf_event-attr.type:\t%u\n", event->orig_type);
> +       seq_printf(m, "perf_event-attr.config:\t%llu\n", event->attr.conf=
ig);
> +       seq_printf(m, "perf_event-attr.config1:\t%llu\n", event->attr.con=
fig1);
> +       seq_printf(m, "perf_event-attr.config2:\t%llu\n", event->attr.con=
fig2);
> +       seq_printf(m, "perf_event-attr.config3:\t%llu\n", event->attr.con=
fig3);
> +}
> +
>  static const struct file_operations perf_fops =3D {
>         .release                =3D perf_release,
>         .read                   =3D perf_read,
> @@ -6828,6 +6840,7 @@ static const struct file_operations perf_fops =3D {
>         .compat_ioctl           =3D perf_compat_ioctl,
>         .mmap                   =3D perf_mmap,
>         .fasync                 =3D perf_fasync,
> +       .show_fdinfo            =3D perf_show_fdinfo,
>  };
>
>  /*
> --
> 2.47.0.163.g1226f6d8fa-goog
>
