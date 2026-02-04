Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584A352F80
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 05:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181741; cv=pass; b=fmahFz9HQHqquxAtW/JCswvYOCCzMJIZ8gMl5bbByGNWYfs5axpgJXE7QY9Om3OqDd8jySs9XmsmikGzjghxR4QWWJcBqF43EpZMYLcSVNsmcv3iMowljFR3A4CqMnOnivKAU5Op/RB1dbO75QNCoXq2vBFj+4EMk1nPWc20poI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181741; c=relaxed/simple;
	bh=3WtR/JoslbkDTu8jZFlNNyT9kwORKPJ9Rm5CRxvjTvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLyrGPkHB5JXLe7Qi0bK9KjEpouEFa7iQnrEXlKA7tZF5zHNWq8ogCCVFW+HzMi1iXHuJxiWEIy4uhblyW4ICE+Bj6axFfnwGpdnkjAsUPqRtoGHx8hfsNcB38ISSlzwK5NswZ0JzmxzFxHN1jrvQMuDcYA1P4qvoyK6MmkCk1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wy6UB/WZ; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wy6UB/WZ"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124aa03ceb4so2389c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 21:09:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770181740; cv=none;
        d=google.com; s=arc-20240605;
        b=QYRyHBEIKQlzp3j6dwmCUlCgMeTX61FOZOPdalnyRh9sC7e4WA+8s9QCd4k9xC0XCf
         8e0LwvqKxNtcn9ITy28GQmFvRt4JkZWgSmstAJquzV/h+yydfw9qouxbCRHivx1pOJ0w
         If9Rm1E9awcSALmg4LExoz1WKONBSVKZXOiOlHFb4yqar7qRtvye3Mhdg+AYEy8WY+PM
         GWGTGpEN5cyU1Zv+X5qbFiai2yVLWsEYO65AWpuJCQNq7Tame6rKlt47T9oUBaFbsvz7
         DY0TsnDS4ttq3fYNvLjA0EOPaaCqlLoVzRP8Z19oNBHlTtSH+Rado8bFZ7hYR4zAZ3lo
         rcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmr2v46ieQwzKyMq2KvLQuS/V3QU7SUrqdd2PkLi5/c=;
        fh=ZJJDmG5Q+ssS5dIfYzuk58JztFl6Ii2EP0Z/HVdOCFI=;
        b=BfvRc4BG4+o3+NsKZjQnBps4Uy8P5TRMREojugvQJ6DZZ64LFgE1QVv0I8LrJjEu11
         qY+drU2VjUzVdoDUUObmmQnTuaCI0FyFjZSGSRifhogRWASgaxV9tbjvZ2nmFQqF1Ybr
         Q2S0vwUjXjAp+m5exaaoMs6H6ladTVfg2K915ZdEJwFiMgLsfm4bjJTE8gMvnSLADgOc
         l1VGm2p+E0f44QcZkKPXmWoo+3d23E8wYJkxzITZZ0kGzbFwZjdAeLcWWETNUbXf6MfK
         1QNhGYnVHQylET7NEiIZICl6WXVeBQ3FAMsGYNdKO12s/g6nCmysh/ZHjIzbUBbMzJ3y
         419A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770181740; x=1770786540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmr2v46ieQwzKyMq2KvLQuS/V3QU7SUrqdd2PkLi5/c=;
        b=wy6UB/WZS9pLOII1IzSR849Kxw+5iQb6JKP1fWIETkgDoYg1w6x+tHht9o17OEn70P
         XzG6U4ZVHtGrVsJhAXo/NVPpBp5kAMFqm3suILw+xxQjHdn2bzdYSwcJ7/Y9Y91tP3sm
         3qgR+w+bOLQOHJRa8YJjEUncU8KBUH3l/qk16Wg8Dk95kGZUQJZXGlCYRod2AVJO+2T3
         8eUAjNr3fPiX5Juz80jOk9UoKoPUbdJGyQNqfAcOJkrKaVqz2dwbZWAyo5GzdoNNMPeF
         QnIFUYdB/WQrRTBuvKJpyfKc2//7uJ37UHUz+eRTCXkelQEG8z+GD8FDosZvpYdT2RJr
         ZBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770181740; x=1770786540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmr2v46ieQwzKyMq2KvLQuS/V3QU7SUrqdd2PkLi5/c=;
        b=OeDmP23GAHlGHmTG1xrFokfaBuS+TbSTKuIIiNhzicFrvFx+4o76LtM3+8vui8SWQI
         i4sRyVUlOw8f5Z38nEjj3RSPSj87cDwMVbuJlC7UARKY14fK3/X59CjjzIJXdSWwFWNA
         IsZT3ana0J9ogHGleuFketmah4CA2HmZPkpAzix8k37a42jXSG+oJyZRZdNYGisZtGRE
         7OXfmh5NKgfiJ6KzrRKVrXkqZRncBQNnRG3O02ox9b1JbbvVNA6qw27hJEUx9bTli7g+
         HFhwN2bH+2ovvW2uhTkpw16Iaur7To5xccYh1BlubvVOY8j9S1svtjWdQxj0ut89pJAZ
         Eb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuNNi2moCkt6CySiLzl0M6qUbkhg5hQqS7Qe5oRMOn/ax+62zFhWzXcLoiEpxfKxQN6pTcTihWJYAGuLyl2GTZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCDUm/+elUar49zq5yOpLscb0AxsLPMnxTBW/lgzGNyTuSNj3
	vesSq0yodD7hzGV6NoLuskqbkqvQYv1bo8OB35tSJpVR37UdrxWuxQJDoS3/YpsYx8zNrnL11ne
	YQEGnLQ/Lv/KzFj+iL4Ne5twiRlSlCvcn9LxgwFdN
X-Gm-Gg: AZuq6aJp97EVQj/48GSdNvZRFJ1LA3Vj+KXqdsNB87hjw83FzDMtgvSpHRpJejQq9U/
	3p5eBQ5nCLnjCzEjBdKj8OIhojAby31OgmEKqLq0+qB+OUrVO4VzE70HSZ2iIJXJibcnJid/VXS
	p6+vtx7GRCNKF/FVATH/FAzPc8mQhUUJfhrIpXMpcYn0A23WtpqT4Rvb1eT8O42w/FpODo+cr+t
	gveNkDNODjXNIJRvljHZgC3rNpFfVoVrvv7e25XJkJdEashbI+ZinuM3fJygY5Rg6sXpURW
X-Received: by 2002:a05:7022:4593:b0:119:e56b:c1d5 with SMTP id
 a92af1059eb24-126f4dedea1mr83561c88.0.1770181739545; Tue, 03 Feb 2026
 21:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203141608.14128-1-qzhao@redhat.com>
In-Reply-To: <20260203141608.14128-1-qzhao@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Feb 2026 21:08:47 -0800
X-Gm-Features: AZwV_QigJUEi_-AiY_Bd-ATJjRDGxwtiIwK5CzrhtamFItGNoB1kixnN_mlCWFk
Message-ID: <CAP-5=fXNCM=XviuagrAmFKx+VjeoMjck0ZE1Ydw6Wd86Mza2-A@mail.gmail.com>
Subject: Re: [PATCH v2] perf tests: mmap: skip rdpmc tests when sysfs disabled
To: Qiao Zhao <qzhao@redhat.com>
Cc: james.clark@linaro.org, linux-perf-users@vger.kernel.org, 
	leo.yan@linux.dev, namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org, 
	vincent.weaver@maine.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 6:16=E2=80=AFAM Qiao Zhao <qzhao@redhat.com> wrote:
>
> Some architectures control user-space rdpmc access via sysfs or sysctl,
> for example /proc/sys/kernel/perf_user_access on arm64/riscv or the
> rdpmc attribute under event_source devices on x86_64.
>
> The mmap-based rdpmc tests currently assume rdpmc availability purely
> based on perf_event configuration, which leads to false failures when
> the system globally disables rdpmc access.
>
> Introduce a helper to detect rdpmc availability via sysfs and skip
> user space counter reading tests when rdpmc is disabled by the system.
>
> The check is only applied to USER_READ_ENABLED tests. User-read disabled
> tests continue to run unconditionally, as they validate perf_event mmap
> semantics independent of rdpmc availability.
>
> Additionally, tighten the unsupported rdpmc check to require a valid
> counter index, avoiding false failures when cap_user_rdpmc is set but
> no counter is assigned.
>
> v1->v2
> - Check rdpmc availability via sysfs before running USER_READ_ENABLED tes=
ts
> - Handle both perf_user_access and rdpmc sysfs interfaces
> - Avoid false failures when cap_user_rdpmc is set but no counter index ex=
ists
>
> Testing:
> - arm64: rdpmc disabled by perf_user_access (tests correctly skipped)
> - x86_64: no behavior change compared to v1
>
> Signed-off-by: Qiao Zhao <qzhao@redhat.com>

On x86:
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/mmap-basic.c | 45 +++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.=
c
> index 3313c236104e..67d6d83dbedb 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -220,6 +220,37 @@ static enum user_read_state set_user_read(struct per=
f_pmu *pmu, enum user_read_s
>         return old_user_read;
>  }
>
> +static bool rdpmc_sysfs_enabled(struct perf_pmu *pmu)
> +{
> +       char buf[8];
> +       int events_fd, fd;
> +       ssize_t len;
> +
> +       /* ARM/RISC-V style or similar */
> +       fd =3D open("/proc/sys/kernel/perf_user_access", O_RDONLY);
> +       if (fd > 0) {
> +               len =3D read(fd, buf, sizeof(buf));
> +               close(fd);
> +               if (len > 0)
> +                       return buf[0] =3D=3D '1';
> +       }
> +
> +       /* x86_64 style rdpmc file or similar */
> +       events_fd =3D perf_pmu__event_source_devices_fd();
> +       if (events_fd >=3D 0) {
> +               fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc=
", O_RDONLY);
> +               close(events_fd);
> +               if (fd >=3D 0) {
> +                       len =3D read(fd, buf, sizeof(buf));
> +                       close(fd);
> +                       if (len > 0)
> +                               return buf[0] =3D=3D '1';
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static int test_stat_user_read(u64 event, enum user_read_state enabled)
>  {
>         struct perf_pmu *pmu =3D NULL;
> @@ -247,7 +278,7 @@ static int test_stat_user_read(u64 event, enum user_r=
ead_state enabled)
>                 struct perf_evsel *evsel =3D NULL;
>                 int err;
>                 struct perf_event_mmap_page *pc;
> -               bool mapped =3D false, opened =3D false, rdpmc_supported;
> +               bool mapped =3D false, opened =3D false, rdpmc_supported,=
 sysfs_enabled;
>                 struct perf_counts_values counts =3D { .val =3D 0 };
>
>
> @@ -300,6 +331,16 @@ static int test_stat_user_read(u64 event, enum user_=
read_state enabled)
>                 else
>                         rdpmc_supported =3D (enabled =3D=3D USER_READ_ENA=
BLED);
>
> +               if (enabled =3D=3D USER_READ_ENABLED) {
> +                       sysfs_enabled =3D rdpmc_sysfs_enabled(pmu);
> +                       if (!sysfs_enabled) {
> +                               pr_debug("User space counter reading for =
PMU %s [Skip rdpmc disabled by sysfs]\n",
> +                                       pmu->name);
> +                               ret =3D TEST_SKIP;
> +                               goto cleanup;
> +                       }
> +               }
> +
>                 if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index=
)) {
>                         pr_err("User space counter reading for PMU %s [Fa=
iled unexpected supported counter access %d %d]\n",
>                                 pmu->name, pc->cap_user_rdpmc, pc->index)=
;
> @@ -307,7 +348,7 @@ static int test_stat_user_read(u64 event, enum user_r=
ead_state enabled)
>                         goto cleanup;
>                 }
>
> -               if (!rdpmc_supported && pc->cap_user_rdpmc) {
> +               if (!rdpmc_supported && pc->cap_user_rdpmc && pc->index) =
{
>                         pr_err("User space counter reading for PMU %s [Fa=
iled unexpected unsupported counter access %d]\n",
>                                 pmu->name, pc->cap_user_rdpmc);
>                         ret =3D TEST_FAIL;
> --
> 2.49.0
>
