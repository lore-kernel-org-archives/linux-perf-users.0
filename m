Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B571720
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428457; cv=none; b=LyD5Brw6pPJrZ1ndnC90x1GOfTCLdivZgiRq9ynd2wX8yZRNHu9AmA8BTuzk6WdDauNnAdLUNTqyv5zOHxawraIIs0RRPQsUzuNJ+KaHZs9w5vVsjvEhCGVdFvcLUQuCUj+7fEd8xUC6MsXqNwWzHNylTykKdtDUsczCOcOu4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428457; c=relaxed/simple;
	bh=MScNp1nP9nUSyVDewm9QpHPiKVaNJLVtYQ3J+Fa+oLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koYXKTJyipCHap9+FVL69Pzq2JQvDr6a+05eZTRcVpV9cZmVSwgHDWNstzh3cEw79ls/DEeVk7+KzNMcVYORyoReqWdDjaEqZzo+73UqPsWrFv7mEt8WeVplgrOL+9ZISJHCdOVCymImTsHycWqKAdgBByw0NT6zFBmx4r6bIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orsBiZjG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orsBiZjG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dee917abd5so20645ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710428455; x=1711033255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH8RANQQT2jsR2s4b+7SiD1gGhZ0rPFRwfusn0ZxoXM=;
        b=orsBiZjG4oWGofKj5l6SgPXuubZ4futxm+vlAxg7Kp1aCPT8H1WAU1eQLxHDHldxff
         NyQHL0GzMJ9xug1TFCvVgJZzuJ7vVWcq4IdkIiR4VX0guy1wfSyVJjGDlb3AxSeP33BI
         zAxB0dCjDyhF0HYnXH3YlF1LsioPuOWnN0MSU3MDN2l1mETpxjQBHSmQyHS6H4C1gs/a
         j/ECyq2rTKp2KkkpKlmzyeueHeUiLWOFwYG9zi6iJHsA9orMo1a/Juz1FOgCw0PWp2rK
         4TfLYUOAn6aUoUsbkCGRGeNfSbzX0/DM8mXCIHJdfCQnVmxGyX6SENyucpMrTi0RCUR+
         VmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428455; x=1711033255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH8RANQQT2jsR2s4b+7SiD1gGhZ0rPFRwfusn0ZxoXM=;
        b=eK80fBKgumHDbNti74SqQ1WGZ8vqD2s/EsAhf2DnrIE+9+cdzDXiO0WAj5DJIOc2yv
         crzZtwA3xgjvHtDosz1LJrqE6aCj6kqL4wZ6W0vszGxwNToLWeoH8jXIkkFsI2HMXbKp
         aphEhaMyJ782HS4lsPMkrZmp7flUk1FFIy2N1mRLIWWRZgJuqQ7tAmukRnFEath5Y5+F
         A82YqnjxpNqHntJQ+DRhHZwxOgJXkhlM3eM3AZdbfpPaGiYGIy9JOL16r9uLzHGiFuDk
         Dv8vqO0IOWHEOPWMJXsiGXICbMoI5qzgcBR9AhDEzLr8ICb/P6hxKC6vVFBC/D8vt/0O
         B3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZQrELNrE3ANJg/aNcYjFcUh0RaDvGbBAq3uoyvsmyjiM5bJR3YXsvCJq3ZtDNKjZGiIQdiDXrD+b/ZoNcQBbOa/tLQIlIPZubNk1xXngw2w==
X-Gm-Message-State: AOJu0YwYXE3i+oMrf/SFaM7O+jYFZRy00nu/dRLfx1wqiK8y84N+yVCA
	pIKdEqQtJ4leau7RzIiWb+0XVd6XQmEfvEOjnYKd6TrAAGyuD0n1Q74HhK7H7jqQFBlMVtMa9ja
	Xy2XBOORPW/DPHJYc9VYXWcNL+2M5svw+IJpg
X-Google-Smtp-Source: AGHT+IEKpRXqG3a2vfe//6ITfZ7EAT+S4pM5b3IxGmmn6yNhIkazGMPT4qAGhWlGcQS+ZphOOFIgY1VsjYM7e8DbreU=
X-Received: by 2002:a17:902:bcca:b0:1dc:dfd0:f3da with SMTP id
 o10-20020a170902bcca00b001dcdfd0f3damr211253pls.28.1710428455163; Thu, 14 Mar
 2024 08:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314144320.743217-1-acme@kernel.org>
In-Reply-To: <20240314144320.743217-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Mar 2024 08:00:38 -0700
Message-ID: <CAP-5=fX=UmW2iAQNfYcBG89Bv9LmLUtSmPOOH+3LN=r396sO1g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Move some more header copies to tools/perf/trace/beauty/
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 7:43=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi,
>
>         Move a few more files that is used just by scrappers.

Thanks Arnaldo! A nit, could you change s/scrapp/scrap/g in the commit
messages - scrapping is throwing away, you mean scraping :-)

Ian

> - Arnaldo
>
> Arnaldo Carvalho de Melo (3):
>   perf beauty: Move uapi/linux/usbdevice_fs.h copy out of the directory
>     used to build perf
>   perf beauty: Move uapi/sound/asound.h copy out of the directory used
>     to build perf
>   perf beauty: Move arch/x86/include/asm/irq_vectors.h copy out of the
>     directory used to build perf
>
>  tools/perf/Makefile.perf                      | 19 +++++++++++--------
>  tools/perf/check-headers.sh                   |  6 +++---
>  .../arch/x86/include/asm/irq_vectors.h        |  0
>  .../beauty}/include/uapi/linux/usbdevice_fs.h |  0
>  .../trace/beauty}/include/uapi/sound/asound.h |  0
>  tools/perf/trace/beauty/sndrv_ctl_ioctl.sh    |  4 ++--
>  tools/perf/trace/beauty/sndrv_pcm_ioctl.sh    |  4 ++--
>  .../beauty/tracepoints/x86_irq_vectors.sh     |  6 +++---
>  tools/perf/trace/beauty/usbdevfs_ioctl.sh     |  6 +++---
>  9 files changed, 24 insertions(+), 21 deletions(-)
>  rename tools/{ =3D> perf/trace/beauty}/arch/x86/include/asm/irq_vectors.=
h (100%)
>  rename tools/{ =3D> perf/trace/beauty}/include/uapi/linux/usbdevice_fs.h=
 (100%)
>  rename tools/{ =3D> perf/trace/beauty}/include/uapi/sound/asound.h (100%=
)
>
> --
> 2.43.2
>
