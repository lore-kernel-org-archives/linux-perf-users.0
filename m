Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245018C015
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599534; cv=none; b=bcaj8ANajgNOl77TBMNYTFvQEcO6b8kXUGumGeLxh+LPplCyU89VhGMixNaq3mJiDpIqyt6AdJZJ5z0+uKxfX3DRdj2sGHaL9QBiaz7OSGzzWked/G0cFuE8kQ1QzwT+bbCBQcqxVgL+yMijqZoRiAi2KUrGnXPW66HlDk3w7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599534; c=relaxed/simple;
	bh=v1RiomMiWVqeQ0xSIyrfA4rsENMHKQjxihGO/VInIns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff/bQjHcCO+a2VIOPKTkuNn7hoiPo87TAQAvrUQVA2BRXWhExzPHW3xXf7L0wFjMzRfCEGQpPZX0pJo/uvq2wv8mbFPCWIiPJlORACCHV1K+g73XpfYWMIRvJ7nJdtvhhjduOUnzfDlyuWm/mre/2ZwKHnkTxw886s8z/K7rnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/uIc2Pu; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/uIc2Pu"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a71ef98bc4so119455ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731599532; x=1732204332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktgKdwX1j+4Opkivi2DSjE8sDLzSzC2KukaMkHYqosU=;
        b=n/uIc2Pu6r/An4+qHX9t3Epor5bPFhvMcohHxnZf3E9AJ2Rg+QHyVSx7LCbhrwtB+x
         r1A5fH2Te7jHlnodjykwyoOoaRet/i+jC+K8DHBKmAD0Hi6C9xpCLaWRGVqAhS5/lfHT
         8tc4EF/2iA5GVcZYc+RpPj/u8+P+WVoxtoYHFW3ygrCtYdt0q+q184OdY1ijc7QQrvrN
         t8xdnuz0ZR2bvjh7Q9yVZyhslQ8irTkolG0v/aDZtfOSrrPNpou8ilMJMOXMD4Cd5UGR
         s6r60LdS8I1jZ4tdBK1B7AL97aBbRP0Tqb/jFHfcWcPYoMG5GTPR28YJqKvTQkiEAsXi
         aASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731599532; x=1732204332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktgKdwX1j+4Opkivi2DSjE8sDLzSzC2KukaMkHYqosU=;
        b=g+CVzWhhjVR1GvPjGk1hIP+xm6fspiq1oDQR8IaeOHyyawQrxiKns+6h5FR/ss9bFm
         PmvajgEl/Od+AMM4GeMs2HVwh3u5w99tx4oiL0Aq79GTlEMT8ao68nS4+KULAKmia4Gv
         heSnhofuqhbVsWOTOoAClK6Y8rRjxHEqfFl8pSG8WV/9LTnMqTUpqRJSa4R+meroHKyh
         qgitfAlQmpCo2/mn+7FmtFtZSt9TF7pZVRHVGWm38Do1fCxEK/6TzcgOeTsw4HxHbldE
         aQAyQ/8Ug3XgrK4Ym1mSUWStVbKOWamtqhJQTDovY8WLu4dwSq+6JgiDyxXJCJwTP/h+
         m2wA==
X-Forwarded-Encrypted: i=1; AJvYcCXqD6l9StO2f5oB0vmXcoQT9Yijz3aslr4u2aGFvISpQP6ZU3gtcP8HoIqoZ24KPeWhaX0fL2wFyJFT3EDdTDhz@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrGf3QqCsE3xqOSpvEM1HRADkN0quPRjgoEISK4ATM3v3tiqh
	E/vyUGxk8bDBqEFlgMpnyYW3Yr2miRR9rIy66FbeOt/QkBN0W8nWWA/eR59hXridKC2wdkiuDl/
	Us0CCFXDk02ykzKGCD5dzYvgmgHOzTdWNe7hk
X-Gm-Gg: ASbGncu+eQVPCuK5wMf67Q5dpen4J9qwGuHRgEIpMw9gbl5z5URafC4vY6MfLLTP0Jg
	1sFsj/ccwYtZDTz4HV7j5Z3TPE8iz0qLZlprgWCs/3T2YvDEYLaiaQWkeK6Furb0=
X-Google-Smtp-Source: AGHT+IE8ou8Ygo56/ExTa5P+XtsMh75yKL6Jwd6AM/SdzEaQiK9oNtsAvUaqrHkm2YT+XDF+hFAsSS+8xs5Ra6Kd4hA=
X-Received: by 2002:a05:6e02:219b:b0:3a6:f43d:a24e with SMTP id
 e9e14a558f8ab-3a71e6e2cb2mr4141345ab.10.1731599532040; Thu, 14 Nov 2024
 07:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com> <20241106003007.2112584-3-ctshao@google.com>
In-Reply-To: <20241106003007.2112584-3-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Nov 2024 07:51:59 -0800
Message-ID: <CAP-5=fUk7ZSpHwwN98_YVFbKxGQSSbe+kLsCTiuS6mKkS+c3tA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf evsel: Find process with busy PMUs for EBUSY
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
> It parses fdinfo with PMU type, comparing with the event which failed to
> open, and report the processes causing EBUSY error.
>
> Testing cycles and intel_pt//
>
>   $ ./perf stat -e cycles &
>   [1] 55569
>   $ ./perf stat -e intel_pt// &
>   [2] 55683
>   $ ./perf stat -e intel_pt//
>   Error:
>   The PMU intel_pt counters are busy and in use by another process.
>   Possible processes:
>   55683 ./perf stat -e intel_pt//
>
> Only perf with intel_pt was reported.

I think this looks really nice!

> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Change-Id: Ic51a36ea3b2fd245663d7db78f35496bb4199d73
> ---
>  tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
>  1 file changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d001ecfa26bf7..5400b795d9233 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3286,7 +3286,8 @@ static bool find_process(const char *name)
>         return ret ? false : true;
>  }
>
> -static int dump_perf_event_processes(char *msg, size_t size)
> +static int dump_perf_event_processes(const struct perf_event_attr *faile=
d_attr,
> +                                    char *msg, size_t size)
>  {
>         DIR *proc_dir;
>         struct dirent *proc_entry;
> @@ -3327,29 +3328,61 @@ static int dump_perf_event_processes(char *msg, s=
ize_t size)
>                                 continue;
>                         /* Take care as readlink doesn't null terminate t=
he string. */
>                         if (!strncmp(buf, "anon_inode:[perf_event]", link=
_size)) {
> -                               int cmdline_fd;
> -                               ssize_t cmdline_size;
> -
> -                               scnprintf(buf, sizeof(buf), "%s/cmdline",=
 proc_entry->d_name);
> -                               cmdline_fd =3D openat(dirfd(proc_dir), bu=
f, O_RDONLY);
> -                               if (cmdline_fd =3D=3D -1)
> -                                       continue;
> -                               cmdline_size =3D read(cmdline_fd, buf, si=
zeof(buf) - 1);
> -                               close(cmdline_fd);
> -                               if (cmdline_size < 0)
> +                               int fdinfo_fd;
> +                               ssize_t fdinfo_size;
> +                               char *line;
> +                               u32 perf_event_type =3D UINT32_MAX;
> +
> +                               /* Let's check the PMU type reserved by t=
his process */
> +                               scnprintf(buf, sizeof(buf), "%s/fdinfo/%s=
",
> +                                         proc_entry->d_name, fd_entry->d=
_name);
> +                               fdinfo_fd =3D openat(dirfd(proc_dir), buf=
, O_RDONLY);
> +                               fdinfo_size =3D read(fdinfo_fd, buf, size=
of(buf) - 1);
> +                               if (fdinfo_size < 0)
>                                         continue;
> -                               buf[cmdline_size] =3D '\0';
> -                               for (ssize_t i =3D 0; i < cmdline_size; i=
++) {
> -                                       if (buf[i] =3D=3D '\0')
> -                                               buf[i] =3D ' ';
> +                               buf[fdinfo_size] =3D '\0';
> +
> +                               line =3D strtok(buf, "\n");
> +                               while (line !=3D NULL) {
> +                                       if (sscanf(line,
> +                                                  "perf_event_attr.type:=
\t%u",
> +                                                  &perf_event_type) =3D=
=3D 1)
> +                                               break;
> +                                       line =3D strtok(NULL, "\n");
>                                 }
>
> -                               if (printed =3D=3D 0)
> -                                       printed +=3D scnprintf(msg, size,=
 "Possible processes:\n");
> -
> -                               printed +=3D scnprintf(msg + printed, siz=
e - printed,
> -                                               "%s %s\n", proc_entry->d_=
name, buf);
> -                               break;
> +                               /* Report the process which reserves the =
conflicted PMU. */
> +                               /* If fdinfo does not contain PMU type, r=
eport it too. */
> +                               if (perf_event_type =3D=3D failed_attr->t=
ype ||
> +                                   perf_event_type =3D=3D UINT32_MAX) {
> +                                       int cmdline_fd;
> +                                       ssize_t cmdline_size;
> +
> +                                       scnprintf(buf, sizeof(buf),
> +                                                 "%s/cmdline",
> +                                                 proc_entry->d_name);
> +                                       cmdline_fd =3D openat(dirfd(proc_=
dir), buf, O_RDONLY);
> +                                       if (cmdline_fd =3D=3D -1)
> +                                               continue;
> +                                       cmdline_size =3D read(cmdline_fd,=
 buf, sizeof(buf) - 1);
> +                                       close(cmdline_fd);
> +                                       if (cmdline_size < 0)
> +                                               continue;
> +                                       buf[cmdline_size] =3D '\0';
> +                                       for (ssize_t i =3D 0; i < cmdline=
_size; i++) {
> +                                               if (buf[i] =3D=3D '\0')
> +                                                       buf[i] =3D ' ';
> +                                       }
> +
> +                                       if (printed =3D=3D 0)
> +                                               printed +=3D scnprintf(
> +                                                       msg, size,
> +                                                       "Possible process=
es:\n");
> +
> +                                       printed +=3D scnprintf(msg + prin=
ted, size - printed,
> +                                                       "%s %s\n", proc_e=
ntry->d_name, buf);
> +                                       break;
> +                               }
>                         }
>                 }
>                 closedir(fd_dir);
> @@ -3458,7 +3491,9 @@ int evsel__open_strerror(struct evsel *evsel, struc=
t target *target,
>                         msg, size,
>                         "The PMU %s counters are busy and in use by anoth=
er process.\n",
>                         evsel->pmu ? evsel->pmu->name : "");
> -               return printed + dump_perf_event_processes(msg + printed,=
 size - printed);
> +               return printed + dump_perf_event_processes(&evsel->core.a=
ttr,
> +                                                          msg + printed,
> +                                                          size - printed=
);
>                 break;
>         case EINVAL:
>                 if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_=
SIZE && perf_missing_features.code_page_size)
> --
> 2.47.0.199.ga7371fff76-goog
>
