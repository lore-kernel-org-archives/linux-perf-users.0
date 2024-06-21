Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559F1E48B;
	Fri, 21 Jun 2024 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990137; cv=none; b=eI+tL7i7Mi9JkAcy9kFx8fd96k9GN9jSjNWrFHIekao0t2AhbVCDa6FcUPXdf8L6hwTGcfzW5Sb/6v6/u+r2Nn5tRXyvG81k3oPDEkdoNHu9mYS48KDiQONW0alam2xFc1C7A86JAPy5x3R799+mi9Odus0K8Prj4vNoisYl0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990137; c=relaxed/simple;
	bh=GI0GJgKBIiERfOQYBHTDUfFzXzuEJ+pmSQW0Cu2pXm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5tQrDhSH98hSMKgQzJ/1BvdKH/4o/kaMAcLpl16o+kYY5op01pqHxK8RwT2KV4nuSo7cgtyqzqFWGR2JWNqfnJjf+l8WekwwDlRaZUPOOKG0sf5JSZ0ijZ/juaSTjBbjnB8/VEJ7Cx4mVGM3zAZ+h527julDmpPVaig4rqXexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-718354c17e4so310525a12.1;
        Fri, 21 Jun 2024 10:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718990135; x=1719594935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVAQjp8TS5c6GzQwsHHuPOY6WYTEtq7JTDu5Ad8qMuA=;
        b=r2Mx8C14fhSSzMihsOGyBa+lBju8Yx/V+joss7fTwGeTkOmhy6bjkXoJQ1Mxq2oYYM
         oMgrDjOPWy2fqedHXf4N8tn4ybVnp1xOQa8OW3rs+QQk7RlEZjteQ4WO673mbHorQX3N
         T31rB9vaSH/ADt6kKXNhDtyIIq/2mbcTUCgfqcYR458qMvbXddOm73MgSEgdgtxDY877
         ovai1d49jOv4td1aK+Uq4LL1Zogk9nrG7aYa/unauBFBYC4gBBYJV5AE+t5W5EdFgPJm
         bq4XwVzk4dki7qUDvQ8bKerw+/0uFjXmMZMc19EAi4aaI6WBCh2xdcFQOQ9jdbB5+XZx
         VPfw==
X-Forwarded-Encrypted: i=1; AJvYcCWV1hijAaK5LDb3w8RkHba6Ct/bX6aGHHz3c850Bz2JMAMLRz3UjXxZKMVZT7iXrPEEemXUv0g40Ojr2VcrsDN/O/r93658SC3d8SK1g3PDlFUffvCmrCs8VmdDgfFIw1c261lOnOpK4BSsONTXcQ==
X-Gm-Message-State: AOJu0YwZBK5+fh9TuZIqakkS7Kzg9X4IG31SsMfLIFMvoY/gMabrCo5l
	b5bfLVMV68m8VKtYDpSCJp77x6hlClqlgxENrB9zcbPHLdhjv0kMwmqdeJ3IzqZJPElOlIAv32l
	tNoljnZ6DKBHeleCA/dMD+CtvE44=
X-Google-Smtp-Source: AGHT+IET1vx0cacqAbTrKWIpiU12krTDjYBbp0/drNWRI2hs6LEl+OTWhQf9AWjfXtIunqlf5KeI9C4sMJwfuSY/A+E=
X-Received: by 2002:a17:90b:104c:b0:2c7:6305:9905 with SMTP id
 98e67ed59e1d1-2c7b57ff1f9mr8906664a91.10.1718990135246; Fri, 21 Jun 2024
 10:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-6-howardchu95@gmail.com> <ZnWlWG0ScTa22s0O@google.com>
 <CAH0uvohaypdTV6Z7O5QSK+va_qnhZ6BP6oSJ89s1c1E0CjgxDA@mail.gmail.com>
In-Reply-To: <CAH0uvohaypdTV6Z7O5QSK+va_qnhZ6BP6oSJ89s1c1E0CjgxDA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 21 Jun 2024 10:15:24 -0700
Message-ID: <CAM9d7cgy4BBGuB=bLtsHTVTgsf6i5owhUEWeqMYJk8hQU1CGnQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] perf trace: Add test for enum augmentation
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 9:43=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Namhyung,
>
> On Sat, Jun 22, 2024 at 12:07=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > Hi Howard,
> >
> > On Wed, Jun 19, 2024 at 04:20:42PM +0800, Howard Chu wrote:
> > > Check for vmlinux's existence in sysfs as prerequisite.
> > >
> > > Add landlock_add_rule.c workload. Trace landlock_add_rule syscall to =
see
> > > if the output is desirable.
> >
> > Do you expect to add more things to the landlock workload?  I think we
> > could simply call it landlock.c and probably do other things according
> > to the argument, if needed (e.g. landlock add).
>
> Shortening the name is good, I'll change it, thanks. I think
> landlock_add_rule is the only syscall that we need currently, for it
> contains the only enum argument of all the syscalls. I'll look into
> how we can use these arguments, thank you.

If you don't plan to add something, let's call it landlock.c and forget
about the argument handling for now. :)

But please add a comment in the file that it's just to test BPF
handling of enum arguments.

Thanks,
Namhyung
