Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA4221540
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020697; cv=pass; b=IEVCmQFXLq4ZDq3dQ5bBbM1TZBQAABax3Y6rXnNWDrVVjHkYlYDqj1UnwiCRv5iCqnZi/BMPKkC2l2cUYKkE1X5AP2EDW+OtNJrl38iTRT1G6f8tEksPz7LkSNsZl6ZTS1KyAcwFugkpnEaIwMjUtFcATutkjSka4Pe/QfdMD8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020697; c=relaxed/simple;
	bh=NExYYvMQXYabIJQSIpyY9rMk19Fh9IsrXDXuKdr8RWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBWVH+lq2+nlSxBxGiISuMQD9oRcqEB5MOYk17JT6qy47hLyjQYqpdxnlbQll+VCVrvFnT1cXVfrPsBBYGLKDe8A6CyeQbEw14/mCySgtKOzOVWX56tq9APZ+jbqwhIZHMvV97S5xEntQZANMhNSs8o7wY/xXr4Brg9/YkPb7X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZ3HR0yc; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZ3HR0yc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf22c18ad3so541365ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 08:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781020695; cv=none;
        d=google.com; s=arc-20240605;
        b=hDxpX32w7RIWkUjHqhuxxuXlr3eKQIj1TI7d19x/Ma12fgq86w67OdQOm5YfYrKgXE
         htPOx4B2ba2PCba2N5UbGmMxG6TOe7GzHF3/63XLAuYxTxbAtg7po0rfQGRxlp9kig0p
         l1cXQASF54f5IEee37E0ZZZtndHwcNwISZKgD240v7yer6AbOMEAW7EULxWADwXsNZcj
         fQDNlJDakrJ1dwl+Vb3jkUD7sB4rC439ki3fxDYUbgQTz9fJ2BTITIcVF30Xr5SdSpdJ
         gq6TlFLLQmN/3KdTqTdCH8ZLHk7x476UrLGGM8ZGumWMfZmfKY5FEJ6oZ+eaCS8HjhfT
         meOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=63pvwgUH62eoVa5jR8UFtgct68h98QQKXSIypLdsri8=;
        fh=ph4LVg+Rg8dJ4J6+4KyRk3zKB+5igdegpRD8Y8YI/yE=;
        b=GGemPH+sjLjrdK3dhhyxKJWHKKhJSrzgyxWAQmTdFjzu3aKvUfbvfhl6UOJ2DcNOom
         WUGcJo1ClvZehsP01XhsRuWlUriyfhTAuAAvjTNu+XnTYvjX1wpJ2FfbfGk60G0WE5PR
         rQAl9ZbJnuRHGOoV72Lsyo+RxL4WwGqmeLGrBkWUx9Wa4BVHSZDf4vI3nQTWqWL7ngEm
         QJNzP4KeM9RXxmti+vR3Z7e2GUJOimWK458SMs5R2k8y5okrIDCPa2IjUeNCzNlPI9gQ
         r68a+ynrvgmhVfCylZB9dveBJMq0kwDdU61CeiYm/pv3DMX5kOVTu3JeF4wtzFb7G4LT
         Y1Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781020695; x=1781625495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63pvwgUH62eoVa5jR8UFtgct68h98QQKXSIypLdsri8=;
        b=LZ3HR0ycvo+Juw1s5mYiIlKqo8AUchiHIuYTNqrrqJCERPhmDiHOwn//so1LVG6Wye
         HDM6AaFWRGpDq86662LjAhdYwGMDsBIsFByhWhsfDjTXKovYtZV161CLOAIER/zYAzsp
         hExRJdLn+//Da5vqChNIA1wvv8I+V5ewZh6lcYxGPscejq1TAbyCcGcUIQxV90xr9yj3
         T1MlyIHQp5mN6d6hI2jYmFqkwHsUQhTGD2zxNfMgw2vTA614V5ro2uZgn3PUAEFX+9KW
         ExjX6KuWLUFGXZM8zMFK8fXoyV9ntfGXBVNdmTx0a1FGGp3aKJ/W/ZoXSGOI+FCdC+0J
         6pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020695; x=1781625495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63pvwgUH62eoVa5jR8UFtgct68h98QQKXSIypLdsri8=;
        b=Yd25hReql4IWbagvNApSSnZG6Swc8SAxqM7QkFGWb2VMFQoCk9Tllovd75igRWjLUP
         ypJxhs66qgX7yUjAHfC+6vqPnizcYhT05y4AY5ScR8oNm0d/KHwhcZ3UuJJ+7Lpfi7Wo
         J2WhnhrwynPz2aoLtCbkleCRv5pNNWst4l1QWxRbZlxnS1M5FrwQoXYmF3OhTMwiM92n
         OkzlTk7E+nKautNHsRE+i22G7DJmVfYLvoc4Ty1JezJAg0TTcuVNQWiW4lT+FNuKaQkT
         L8gfz9qSP4vJ09fos3LUwonDP6eu/LKDCKoLzJqnEzAAk75xkyIpFX4dMapWl51WUI8X
         kV6A==
X-Forwarded-Encrypted: i=1; AFNElJ+wMnQadAshsS8cvASPqzAtfBV9pkmT2HB0ZI8kafihIgQazBADEdB0H30LwWoUqx5U/5BvcbNXN6NHQX7uZXBi@vger.kernel.org
X-Gm-Message-State: AOJu0YzxX9FpBFNvYGMWGAZo0gFvVpYi3dGpzklWiuLSU21fluKeofx0
	34DwiWySPIV+GRdWRl+3rd9rYfx89zCpZA2UI8mSfgXUHaheldU5tyofUz/wmho61uRQPRMK2oA
	+V7+1b0lGl8FsuSSza68/9u+S12jst7dB9M8CZW4e
X-Gm-Gg: Acq92OFFt/j5vcag4H/R4Ym78vtm1/ucJ7N3TzubEZ8YOx8B9E3asqkjF/wSexbAWbW
	YaMuIiEOToIiis2syTim7L7a3ArzGy9QsIc1X5P6GpT3OjemS/v+jjdYmNYK4J+czkXuRu9Vp5d
	U8Ovmi8E+lLLxLL/MHQAUXFsdKZGD/d6na2U7E74SJYG9hC0ZDaRsZ3VogSTn8NkEpwtok2CTCo
	geuMf+/bDlvpl5Vm0jAoCMmgPZR6qTXHQOz46Rw9zrB3eNGqq59PY+X5V/NQ2aBSkZFoCdPk/AC
	D3gOe70E1+qspEwOTLdbztPIfm6zFjfxVzBoEG8dm6VBMYZ/
X-Received: by 2002:a17:902:c948:b0:2bd:508b:f3ab with SMTP id
 d9443c01a7336-2c1eb5075ddmr8243965ad.15.1781020694866; Tue, 09 Jun 2026
 08:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602181349.3969429-1-ctshao@google.com> <20260602181349.3969429-2-ctshao@google.com>
In-Reply-To: <20260602181349.3969429-2-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Jun 2026 08:58:03 -0700
X-Gm-Features: AVVi8Cejx1JMzkPGy0b5FBGhBq9itc7hhMEpXKLpZCIygclM1frHm6adSaXP8_o
Message-ID: <CAP-5=fVwLO29i5SoLjOBhPqqUMTiy-z52Wm1mbeBF_941Jbx9Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] perf evsel: Find process with busy PMUs for EBUSY
To: Chun-Tse Shao <ctshao@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:13=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> w=
rote:
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
>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview

Arnaldo, as the kernel piece of this landed (thanks Peter!) could we
land the tool part too?

Thanks,
Ian

> ---
> v8:
>   - Fix a boundary mismatch bug in strncmp when matching anon_inode
>     symlinks.
>   - Switch to thread-safe strtok_r to prevent use-after-free or static
>     state corruption.
>   - Expand the stack-allocated fdinfo parsing buffer from 256 bytes to
>     1024 bytes to completely prevent truncation before the PMU type is
>     parsed.
>   - Open proc files (fdinfo and cmdline) with O_NONBLOCK to prevent
>     malicious or slow mounts from hanging the perf session indefinitely.
>   - Match EBUSY conflicting processes using the physical PMU type
>     (pmu_type) instead of the requested event type, ensuring legacy/raw
>     events are correctly resolved.
> ---
>  tools/perf/util/evsel.c | 99 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 77 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 34c03f47a913..a6b1005db5e8 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -4104,8 +4104,11 @@ static bool find_process(const char *name)
>         return ret ? false : true;
>  }
>
> -static int dump_perf_event_processes(char *msg, size_t size)
> +static int dump_perf_event_processes(const struct evsel *evsel,
> +                                    char *msg, size_t size)
>  {
> +       const struct perf_event_attr *failed_attr =3D &evsel->core.attr;
> +       u32 target_pmu_type =3D evsel->pmu ? evsel->pmu->type : UINT32_MA=
X;
>         DIR *proc_dir;
>         struct dirent *proc_entry;
>         int printed =3D 0;
> @@ -4136,6 +4139,8 @@ static int dump_perf_event_processes(char *msg, siz=
e_t size)
>                         continue;
>                 }
>                 while ((fd_entry =3D readdir(fd_dir)) !=3D NULL) {
> +                       const char *target_lnk =3D "anon_inode:[perf_even=
t]";
> +                       size_t target_lnk_len =3D sizeof("anon_inode:[per=
f_event]") - 1;
>                         ssize_t link_size;
>
>                         if (fd_entry->d_type !=3D DT_LNK)
> @@ -4144,30 +4149,78 @@ static int dump_perf_event_processes(char *msg, s=
ize_t size)
>                         if (link_size < 0)
>                                 continue;
>                         /* Take care as readlink doesn't null terminate t=
he string. */
> -                       if (!strncmp(buf, "anon_inode:[perf_event]", link=
_size)) {
> -                               int cmdline_fd;
> -                               ssize_t cmdline_size;
> -
> -                               scnprintf(buf, sizeof(buf), "%s/cmdline",=
 proc_entry->d_name);
> -                               cmdline_fd =3D openat(dirfd(proc_dir), bu=
f, O_RDONLY);
> -                               if (cmdline_fd =3D=3D -1)
> +                       if (link_size =3D=3D (ssize_t)target_lnk_len &&
> +                           !strncmp(buf, target_lnk, target_lnk_len)) {
> +                               char fdinfo_buf[1024];
> +                               int fdinfo_fd;
> +                               ssize_t fdinfo_size;
> +                               char *line;
> +                               char *saveptr;
> +                               u32 perf_event_type =3D UINT32_MAX;
> +                               u32 pmu_type =3D UINT32_MAX;
> +
> +                               /* Let's check the PMU type reserved by t=
his process */
> +                               scnprintf(buf, sizeof(buf), "%s/fdinfo/%s=
",
> +                                         proc_entry->d_name, fd_entry->d=
_name);
> +                               fdinfo_fd =3D openat(dirfd(proc_dir), buf=
, O_RDONLY);
> +                               if (fdinfo_fd =3D=3D -1)
>                                         continue;
> -                               cmdline_size =3D read(cmdline_fd, buf, si=
zeof(buf) - 1);
> -                               close(cmdline_fd);
> -                               if (cmdline_size < 0)
> +                               fdinfo_size =3D read(fdinfo_fd, fdinfo_bu=
f, sizeof(fdinfo_buf) - 1);
> +                               close(fdinfo_fd);
> +                               if (fdinfo_size < 0)
>                                         continue;
> -                               buf[cmdline_size] =3D '\0';
> -                               for (ssize_t i =3D 0; i < cmdline_size; i=
++) {
> -                                       if (buf[i] =3D=3D '\0')
> -                                               buf[i] =3D ' ';
> +                               fdinfo_buf[fdinfo_size] =3D '\0';
> +
> +                               line =3D strtok_r(fdinfo_buf, "\n", &save=
ptr);
> +                               while (line) {
> +                                       if (sscanf(line,
> +                                                  "perf_event_attr.type:=
\t%u",
> +                                                  &perf_event_type) =3D=
=3D 1) {
> +                                               /* continue parsing */
> +                                       } else if (sscanf(line,
> +                                                         "pmu_type:\t%u"=
,
> +                                                         &pmu_type) =3D=
=3D 1) {
> +                                               /* continue parsing */
> +                                       }
> +                                       line =3D strtok_r(NULL, "\n", &sa=
veptr);
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
> +                                   pmu_type =3D=3D failed_attr->type ||
> +                                   (target_pmu_type !=3D UINT32_MAX &&
> +                                    pmu_type =3D=3D target_pmu_type) ||
> +                                   (perf_event_type =3D=3D UINT32_MAX &&
> +                                    pmu_type =3D=3D UINT32_MAX)) {
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
> +                                               else if (!isprint((unsign=
ed char)buf[i]))
> +                                                       buf[i] =3D '.';
> +                                       }
> +                                       if (printed =3D=3D 0)
> +                                               printed +=3D scnprintf(ms=
g, size,
> +                                                                    "Pos=
sible processes:\n");
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
> @@ -4285,7 +4338,9 @@ int evsel__open_strerror(struct evsel *evsel, struc=
t target *target,
>                         msg, size,
>                         "The PMU %s counters are busy and in use by anoth=
er process.\n",
>                         evsel->pmu ? evsel->pmu->name : "");
> -               return printed + dump_perf_event_processes(msg + printed,=
 size - printed);
> +               return printed + dump_perf_event_processes(evsel,
> +                                                          msg + printed,
> +                                                          size - printed=
);
>                 break;
>         case EINVAL:
>                 if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_=
SIZE && perf_missing_features.code_page_size)
> --
> 2.54.0.1013.g208068f2d8-goog
>
