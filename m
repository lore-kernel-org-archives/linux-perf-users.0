Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879773C942B
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168147; cv=pass; b=gqbtiDNPG+ViN7IeGeZ3UqymY+GaZShjZ48dwHoWMoTM7TwAwNJBedjvwREtnSB3/2nISFLUW66eplKt5aITsKHoRas+H6uvq/mKNnivHcy2O7clcA/X+AlZMlYVv8RyF6LI8JOi+4IsU/mTayCXitMphZLe1Qd6F1Rpq8ETxWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168147; c=relaxed/simple;
	bh=lZjP7RmcrvxIsNJkkCNEwskG2ICrFcj24keHPNhI87Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr0xbu+NJLcNPl+8pP1t9SwkVIgg5loK9fdOpxGpLy/cVHDGBcMYJn72ddUsc1tKzqpn2LchOHqxTkHl8F3dSLEeYZB44uLBBbPSGE1uClKdU4XuT+yTblX7Gd3tcOXxDASMaiTaaBd1dfJOkB9HncmPGqyTmI+Pf+JFbAlKO0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRExFOVN; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRExFOVN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so97745ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 08:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778168144; cv=none;
        d=google.com; s=arc-20240605;
        b=JGjb0kjJuyxfCfg6CvtBChdfO2RCJ/fYiMeCSZQwpbfQonsjZCwAPEGW1hcuk1hzGf
         xBj2n9LdRzCp45C8qSGN+Uz2jPTfg6w7E3H1D/1jx9Mb2c6MA2cbAZxVX0qgl7nZcZKZ
         XmS8ypIdkaGcp0DmRfNZJJ4bnn32pJUsIZEvC1vEpFPg/QMhjSQgoUCBiOAZ/MZ4egz4
         RIdeO7YRjoekTku4IXQfpUEG9r745pGNQPkan5tliCgvmV/C0ACw4jv7I41PvqoVFdd3
         KaVlhqV7kzyxelNNsWxpF3qgXczNIBBZcj15R1x87HiSZHPT7oK4eH8Xkx5duHMwsU35
         SKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hl3OPaa+HqsVW3wENlJ/AzITxIxhv+o3/IRQF7Ihs4o=;
        fh=Hoj5HtZTJSF+iiTU3Auq8u5khz8Xdwrnh8ePdpiUkOM=;
        b=V8rYWjgKXTXmdBDi/9W6Qn8D79lKmByg/BTivVeyu0KdeL8mPsUI9pOP4JE6HCmlBz
         0AUI01+iOmRNJbjkQny1Ci7hGD6Ogf/OrblzjwZG+C38ILrDk8lUYqNSkCaqk72gRp2H
         Yj7PcArtN2j1OSmOwWI2vzRDUDFKOVP4gTJ4lT8qO72G2akyEC5mvxHnF39tTkAAXaxD
         J4h4rIo9IOrt9fhr2dVtgpIXOZBexZKdpgmpMtUguVuPBqoQRJLamfnIWcQUsjzSaK7h
         iqLYZ9/I8uLFulF68XlkOtzr4+K3nhBPSe4EanB1YqHJB4EF6otdvlWBOsh3fGGlzimr
         ebkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778168144; x=1778772944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl3OPaa+HqsVW3wENlJ/AzITxIxhv+o3/IRQF7Ihs4o=;
        b=nRExFOVNy1m+zmQmPb+c2nNyvMsPmUyeg74dzUopYAFBM8iM1d/u9h1780kGmu0uK1
         KEINwhMYyutgUlE1JElECsqKWu2Y6uSFJYdHHildwqHDiCeHWOAgJrgrUQwKx2NiXtbl
         PwB/ouw8kGlqYBEdkOTxGaLnRbxR7yW/GRb6xOnM+Qyr2Ax2kNmpRfeORyCjqEs9gJzm
         pLKxlz+T2IMBFYQa48b0GLQ7G9Ftlui04jy579DTjgOjgwxYI8Yxrw0arTvwueBY6nZP
         drtsyOgI+TnD4+L7enIDIBGogoI0KefBkbT2KY+yvu674ON1gXSwQUiVRGzdZ2pAN+GW
         uTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168144; x=1778772944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hl3OPaa+HqsVW3wENlJ/AzITxIxhv+o3/IRQF7Ihs4o=;
        b=gN8DJIpWXOOvC2fciJEZjDgT45bk+DHfa9lSXVsIx695zWuCwZywZtXj37LMBzJZOd
         Fy8N8yqhWZpsq9oVdKz3ldXmXBleFM67G6jOxQyAzoa7+Hg82T/6NtQ5J0bhinOc70Yk
         AXvmWb2dQydHy+FhrBQsW+5Yo1yP+yQ1jzVXYEjypM9aq53s5T/d+frVU4DFw1+LtZPH
         +GWLoqHDILcRC1NuKnTneiUlOQdd7yMdPQcwYrlzf5EG1K3zfksF4r0i4qPmaC1iWBOU
         +fuCzLLNuu//tRaqgPOQgG2h1JrtQrI/JebH+N6SpLn21wORTN6CKnWaK8TBlTIoyk9k
         0dUw==
X-Forwarded-Encrypted: i=1; AFNElJ9EP+bFteGZkIiKI1q9rKYfyJ/8K/u22MjyIp5I5cP/qewADZH9DMmLtgp7OgqGml+FW2PB824TVK8j5ZRdbhlw@vger.kernel.org
X-Gm-Message-State: AOJu0YylLJ3ndBERC4Dw48ddxzNndWwbRstY9SQQQKuA/Unru4VHzqlt
	yPM50hbvVfgMPiPtkGjN/YNstaCW8ZyI/8pKl6xy/yjwIqOb6MCajNu5fU28ugrXEVEDE7pQVFJ
	VgnHnrAvEXzVOm3TDQe3MqDbKxMQkbp1kqaAnT8h1
X-Gm-Gg: Acq92OHSG1PW/eNMMAO9/haG9KOkiCmL5Fh/+DtdKbG4n4+FmEXuBv2n8W4F6x3k+5B
	CHJNthPVYqKe/WyVwE0M96yuZ7wxPgNWe3jnzZdsudVaKqt91Dwg1f5hGYFU5L0ENr5wN9AgJTs
	q4hc6lmcu0sF0ipbhm2g0CUcr4qUe9tfUb90X9+40dp4jxkfnm6PBHv3x9LMEupn2FK01H0OuuS
	kYEx+g9YVHS41yNl7i2jfI9J8WH3pLvql6mnXbS0Zk3fQz+gPt6wHAs5sDUFY94ah6GW21M1rD3
	raQJMWice2+3gQBU8H/oKTApOa2cR3OiRQKGnyGyZVVBQHclzIRGOE+mOGPjh8aYDlFMbg==
X-Received: by 2002:a17:903:f84:b0:2b0:b458:2dc3 with SMTP id
 d9443c01a7336-2bae5b14ae2mr373815ad.21.1778168143999; Thu, 07 May 2026
 08:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507063737.3542950-1-wangyushan12@huawei.com> <20260507063737.3542950-4-wangyushan12@huawei.com>
In-Reply-To: <20260507063737.3542950-4-wangyushan12@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 May 2026 08:35:31 -0700
X-Gm-Features: AVHnY4I9DKnPTVL3K0VhIs7W11tZTlL6bzHpAZiuhFaMk_dPdRFxYtcZFku_Z1A
Message-ID: <CAP-5=fV5WiyB3mghvns1ZW6ewS0=CP4nx+f_ggLgECkqv7VWww@mail.gmail.com>
Subject: Re: [RFT PATCH v2 3/7] perf-x86: iostat: Move iostat arch-specific
 implementation to util
To: Yushan Wang <wangyushan12@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@arm.com, 
	john.g.garry@oracle.com, will@kernel.org, mike.leach@arm.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, jic23@kernel.org, leo.yan@linux.dev, 
	robin.murphy@arm.com, linuxarm@huawei.com, hejunhao3@huawei.com, 
	prime.zeng@hisilicon.com, fanghao11@huawei.com, wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 11:37=E2=80=AFPM Yushan Wang <wangyushan12@huawei.co=
m> wrote:
>
> To support cross-platform iostat capabilities, like record/report on
> different platforms, architecture-specific implementation of iostat
> should be moved out of arch directory to get built. Build scripts are
> changed accordingly.
>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> ---
>  tools/perf/arch/x86/util/Build                           | 1 -
>  tools/perf/util/Build                                    | 1 +
>  tools/perf/{arch/x86/util/iostat.c =3D> util/x86-iostat.c} | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/perf/{arch/x86/util/iostat.c =3D> util/x86-iostat.c} (100%)

To avoid cluttering up tools/perf/util, would it make sense to create
a "tools/perf/util/iostat-arch" directory similar to  annotate-arch,
dwarf-regs-arch, kvm-stat-arch and perf-regs-arch?

Thanks,
Ian

> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Bu=
ild
> index b94c91984c66..358541beaa0f 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -7,7 +7,6 @@ perf-util-y +=3D event.o
>  perf-util-y +=3D evlist.o
>  perf-util-y +=3D mem-events.o
>  perf-util-y +=3D evsel.o
> -perf-util-y +=3D iostat.o
>
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 70cc91d00804..c7e5ada3800d 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -127,6 +127,7 @@ perf-util-y +=3D thread-stack.o
>  perf-util-y +=3D spark.o
>  perf-util-y +=3D topdown.o
>  perf-util-y +=3D iostat.o
> +perf-util-y +=3D x86-iostat.o
>  perf-util-y +=3D stream.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
>  perf-util-y +=3D kvm-stat-arch/
> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/util/x86-iost=
at.c
> similarity index 100%
> rename from tools/perf/arch/x86/util/iostat.c
> rename to tools/perf/util/x86-iostat.c
> --
> 2.33.0
>
