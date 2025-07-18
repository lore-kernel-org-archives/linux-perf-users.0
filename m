Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3C2BD012;
	Fri, 18 Jul 2025 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834454; cv=none; b=KqqhWbmC+n+JKtoRF/WPnNNXKnAD7gcEo+dmTWRh7Xv8SZpP6hl4bxXWhvtmAvuwvViJ55fI7FxEei78yqljIbEaaYPcqP3tRCIohyz1vFrBdtcrEYKH8d6Kkhbz98Xt+6+FcWxdk4g6fioY8j2pJKwB4zV0hkg59OFMb3fZhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834454; c=relaxed/simple;
	bh=34kp88JqtvOHUN1Ruw4Qwe4Ve5+ySa4ozJpDYO/g4bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifByyIpR+CFjY+fqWQEhJdwyDFzsBbNp6rfON3vgTnw+yZaGyF7e8sLarl7+nNxaxvWda+v8kmEP6R9IPjKCcFpsIPP/+Nv2uvCTXKJKEayvfsO8tQ77ThkRhfwlEHtwrbgBufTOj6HQgnb+ACW1HHLKuMcFDyLdJzKZPrhuSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfzLOpU7; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfzLOpU7"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8d713e64c5so1472799276.0;
        Fri, 18 Jul 2025 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752834452; x=1753439252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x8KYMoPHOU/KGMTKlJp4QdTDljWUFg5i2cxTvc6SMc=;
        b=cfzLOpU74Dq10upz+KeaYP0VDlMNDoxA83YT81l1mgT/GLtTmWcQLyhOUq51j+RQA4
         l1E0sXvYe8DZL6A3rCMuHfteaLDUtOcbho+LN3QQzbKuh/06VT5DR6tFqJSnsvBZAcrd
         9jPFUrtOc2JmjSnFDkBQ0YiwBBxrYLJNFGCLbf6TuQnrY+V8EP3jQzPM4fS9+L/xfX3V
         AzqRO5OPLdMPpfTI1npKZuwZbjBa05y32EUd1Og/PjyuTVfS2bapZBcIeWELJ0ORYcmK
         LIs1KizX3kmAzTsn7BAqJkYfqAnv9fQEhP+4ySAZ07uNvcM0Jdq60osmsX+oVqwGxt+E
         XmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834452; x=1753439252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1x8KYMoPHOU/KGMTKlJp4QdTDljWUFg5i2cxTvc6SMc=;
        b=ooZ+PGSwBA14vNJ7mitj61CTyvUnvQTKFzmhpNxHlFY/o4oQHOpYxo1Ir4tYcjGLvd
         GMndvFMjMogpgyrxPdd6FDceIXzOvNxJsPfvrxhXyUL9s27HIRYIW0RUg6nwvtwxg3m4
         YMV9uUUgQPhTm8r1IdAPp15F2HAJndsSOG/pd82RQXwtzjwY37Nj2zOyeJGb1LkXlZuU
         jYJJp2V2eKs1gAmoRn5XAh3212K8gyCHVvZs0Ne4p0o3ulWbs0cv7WvmGFMSdPSk4ZfZ
         90TNTUeodeWeHjd1Ksyo39knP55a0tSTcQ6euI4OOUavCfau1P8a3S9jXqPgF0V+ftQt
         mKrA==
X-Forwarded-Encrypted: i=1; AJvYcCWnc8FmStaV8rM/RFZ3/9otO2R0GST60zWsd4JQd4/qyWtKIgizutxaieoyCzNUhaKs3MAamVcdWDkrqK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpfu3fP8wrM4N/Q/QEqCg/TBfDpl1dsHZ3SLRW1aTXnnDLUOjQ
	Nm8E19WEaxkF5MjtHZdlY74EJCCsRe7DQbjHDxgJHsc0zHPVTKm0t5QRA6Ps9tKO1x1DKdPaZu1
	Z2n6w/7zZp3k3xf7LAwqMrwpSs1bnJ8Yc6w==
X-Gm-Gg: ASbGnct9L8pdn+POCz+KrGBtpTrMEHMyfOGk5nf6QUDdW01Ez7Iw6DC8Opv1Ph5HwtS
	xoRYPzF0vNPPO1bxYXn+pYjgoO/gdJa4powM87LA1Wzo/qx3pTi+VtuEsE1SFpv9Ui+Drq80e7e
	1qH2pHF8N8xGplHLXNjDrTJlIukn9ZjHJDmhpx7/wfzCl6I7kGahyE9fdvIEeeGGVgpmGGGBGIy
	OHG8fIU
X-Google-Smtp-Source: AGHT+IHbR0TgrZnHWoh6mc9uul5rXSlPg9jvMrr3O/Uj9MClMiXC9JDrYVKVApD3TRnHdcHCmHq6uDJ+bvpNQuMqzr4=
X-Received: by 2002:a05:690c:38b:b0:708:cd31:88a9 with SMTP id
 00721157ae682-71952350c3amr27819927b3.37.1752834451459; Fri, 18 Jul 2025
 03:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGjUpI1yNjEhSiAq@brak3rDesk>
In-Reply-To: <aGjUpI1yNjEhSiAq@brak3rDesk>
From: Rujra Bhatt <braker.noob.kernel@gmail.com>
Date: Fri, 18 Jul 2025 15:57:20 +0530
X-Gm-Features: Ac12FXxoU6aFudyIJiyv4FHEoGIyv9QfAgoxU9dgMhQNxFSC-pmiUNMnb69ONhU
Message-ID: <CAG+54DZQC+-6E-P3D4BUtVujNegL1qKpcB5SGh28+rX5hrHFiw@mail.gmail.com>
Subject: Re: [PATCH] arc:kernel:perf_event.c : replaced sprintf with sysfs_emit()
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, vgupta@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 5, 2025 at 1:00=E2=80=AFPM Rujra Bhatt <braker.noob.kernel@gmai=
l.com> wrote:
>
> Replaced sprintf() with sysfs_emit() in sysfs*_show() function in
> perf_event.c file to follow the kernel's guidelines from
> documentation/filesystems/sysfs.rst
> This will improve consistency, safety, and makes it easier to maintain
> and update in future.
>
> Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
> ---
>  arch/arc/kernel/perf_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
> index ed6d4f0cd621..424ec072c441 100644
> --- a/arch/arc/kernel/perf_event.c
> +++ b/arch/arc/kernel/perf_event.c
> @@ -648,7 +648,7 @@ static ssize_t arc_pmu_events_sysfs_show(struct devic=
e *dev,
>         struct perf_pmu_events_attr *pmu_attr;
>
>         pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr=
);
> -       return sprintf(page, "event=3D0x%04llx\n", pmu_attr->id);
> +       return sysfs_emit(page, "event=3D0x%04llx\n", pmu_attr->id);
>  }
>
>  /*
> --
> 2.43.0
>

Gentle reminder for the replacement of sprintf() with the sysfs_emit(), kin=
dly
review it.

Thanking you,
regards,
Rujra Bhatt
