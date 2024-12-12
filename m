Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0A14B088
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977549; cv=none; b=PWENRn6y7NT/e1AB4YeX21JrrhDJFQlUsrwyHnHJU1qhQk11+ERCSLSCiwykzKshZb4OyGAOJIWUipwuvfLn67wfiDkOkXSVOaTwn/BzVmwaAW6sAjGeEX03VTMA1Tn4SqWm3PYUWn7AQ+7G2qfLf8Z2eLh1zR3MumaNCWkMQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977549; c=relaxed/simple;
	bh=7Qvs01/BejNv9rHlb5ktozEHtjnwpusW63FoyHDxM/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2GRa5UBO2Q2vZNDxmKfyQ3X78FAYwf6FzzmZL/icgGkmgI5vweueEWx4PU4ZGHDv1jh7jLH9ZWmsEoiLPlN8Md7x966h2fR+cQSdiSDrjnB7vVZxCYOYMa9kdhUdBs+7PNdeZzBHb0dVZw8PwBovaSYBZoh0Gz7oBpbw9l4XGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYaq0Zam; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYaq0Zam"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso53125ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 20:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733977547; x=1734582347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrGgTd6oD7cu/uVCzqBxXlqwiU4sXdR14b9ViH7/yCU=;
        b=BYaq0ZamKoz9moI1Mvw9I1H0NbkOGpeWkc5Bwq8yCtrElHU5euI/MuknheJMKUMwFo
         CSD7vCM3M03WRYphmDbZn8coqVwE+dY7VLJlv1UQd/Gbzgd9sHTr0/7RZZiTnz9CeNmx
         qaKM0j2nWoU8hsteZVk0xnLNKj3fONu48qWrwPgryA8OZA5w8D4+JAJAZ6o2AB+ZXQPX
         nFdTF+zRZZiqwzeHlOH96BT9oEMcmXF6cgqHRvCt/+RKaF08fdSyCeRD6tY0N+YwN0Kp
         3YuQ0mnDWBAygcW594tCf3ipO67ffk2Jh8sTs6TNI9Zc2sD9v5iMZIfMl4dBEO7JPtBK
         L5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733977547; x=1734582347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrGgTd6oD7cu/uVCzqBxXlqwiU4sXdR14b9ViH7/yCU=;
        b=dIis08ik1l9ZDu8Ie2IWWSWUMszhfdONSSKtHVt/a2p9WTxgT0xg4UKZAsjLCff00U
         089AZMLagd2dsbdTGmSOanNCsjnk+NiewCgoheMh8tE6/KJN98dCjOQvw4N43YgtnyH3
         JVt/DRUHncPm0dhuT2NWEg7nRpksEAXMUAJUO1stujBgE3X28EEScJLwLw7cn7+Fz1l5
         4YUmjAsbXjdeoMcMCmbC0PM/ieG2xxTbZkeTvherTIa3BFf+Zv4DcrwBul/WpBtPSNCE
         sa79zmB/2offigJMPfaV6V57TqS+U0LldvhniJtL0I5VTOYiNikR/PFeEHIeN2gTuduH
         08jg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5pZ8z9YlzIz+6Fp54yCTDI0KWa7KYQ0ejL/JVpPxw26Pmt4JX2zuCzW3OsTxdFn6wieqmpJdIYK0XuDeWu3m@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8UdiDUpnS2ITxKms/lhD+9/zvqbIcjpX4fB6Ft/4D04++O6H
	9xS7IcHhVXIu0Cx+nB3LPhhjYMxoqbu8QTT0FZhHJgzjKqAE3M0ji6x8s+3NU1DIajaznmwY7+K
	+KNjJrhHHJ2cEEhVdUZI+sylQdyusjSJYBET8
X-Gm-Gg: ASbGncveIfVJrEfcT9TdH4xZZZk0fMpILThslL6cSEWxk1dsSF/QkO9nD13sHY9KHdL
	hQDaPtViXjL6MM6rYMdnVjCWyMlx1SSMjHUtw6bE=
X-Google-Smtp-Source: AGHT+IFeac093aPHT58jDw2lyM0tERSxKFUNRS9QFs4KAEwE6D1MsO2nfZhs5ws67/hHOLSlvk1Aj9wt3HeqrSYPjWY=
X-Received: by 2002:a05:6e02:80c:b0:3a7:c733:1c63 with SMTP id
 e9e14a558f8ab-3acd78fe2e4mr1009635ab.5.1733977546297; Wed, 11 Dec 2024
 20:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211224509.797827-1-acme@kernel.org> <20241211224509.797827-3-acme@kernel.org>
In-Reply-To: <20241211224509.797827-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Dec 2024 20:25:35 -0800
Message-ID: <CAP-5=fWqBrw1SuY8ue2X_xOv=yStPANM9NGUBkeo+_s2O=bKTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools build feature: Don't set feature-libcap=1 if
 libcap-devel isn't available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	James Clark <james.clark@linaro.org>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:45=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> libcap isn't tested in the tools/build/feature/test-all.c fast path
> feature detection process, so don't set it as available if test-all
> manages to build.
>
> There are other users of this feature detection mechanism, and they
> explicitely ask for libcap to be tested, so are not affected by this
> patch, for instance, with this patch in place:
>
>   $ make -C tools/bpf/bpftool/ clean
>   <SNIP>
>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpfto=
ol'
>   =E2=AC=A2 [acme@toolbox perf-tools-next]$ make -C tools/bpf/bpftool/
>   make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpft=
ool'
>
>   Auto-detecting system features:
>   ...                         clang-bpf-co-re: [ on  ]
>   ...                                    llvm: [ on  ]
>   ...                                  libcap: [ on  ]
>   ...                                  libbfd: [ on  ]
>   ...                             libelf-zstd: [ on  ]
>   <SNIP>
>     LINK    bpftool
>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpfto=
ol'
>   $
>   $ sudo rpm -e libcap-devel
>   $ make -C tools/bpf/bpftool/
>   <SNIP>
>   make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpft=
ool'
>
>   Auto-detecting system features:
>   ...                         clang-bpf-co-re: [ on  ]
>   ...                                    llvm: [ on  ]
>   ...                                  libcap: [ OFF ]
>   ...                                  libbfd: [ on  ]
>   ...                             libelf-zstd: [ on  ]
>
>   $
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
