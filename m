Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C647C15B159
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809212; cv=none; b=FjAVzKhcbq1iRZS6LEgiX0gviH9z+FIK9fmIZMntiKEKdRvpaLFoLZuoefWSvHa2bnZ+MEsb8CvJ3LXZHCeLENPKdHqyxipY75FgborT7YhNEjCgnQDqRVNZ4XpiZSn3d42s0OXiBIa7xbA29iZW424dclXGWL4iESCgsppbTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809212; c=relaxed/simple;
	bh=Z+XgYM30VQnHp7z+uSPBDIaP8spUZThYi3RbwOOKqL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIqWQCpLd857443SO4+olkQPpQcpJfUlQ2bTtzlOc3ZLzeEynlY20yVvNhxM6oZC5TvQAbL6bpqbTdru6SVNOgZ0K/qhYDUmD36oTW0gylHOuZDzvu9h4aXc8mhxe4nXjVDZyToPNUmZenRqRY+xsaFohT7OYlM3iu0qEM6Md5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GVWIDGy; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GVWIDGy"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36c6056f7bdso107815ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715809210; x=1716414010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d83dhT+S2lh1yIex2/6qztxlK0GAg9WvVm+H2kk0ds=;
        b=2GVWIDGyQW7rtdLvLBUG/T7AgFUFCST9wQnNV2EsE4GeNiRx6uWSwREJmnhR4w01Va
         w6sTc6/zddzMX1EC4vXQH6apQyLxyfEoBNDAhoF8B+2v5ijUuuHAKgSExVrPY+MES8IO
         SlN7/GflvqhV2z25L4Wx9BlO9gBYYE18jrEqQ4T9wrUwmnq+/fREETJtEAaJcO8EJG4b
         NCB9HvecTXSRVj1MEluTBb/VoJE+YsftHcFKM9Kx6od91TvcWiqe2CJJ00TlYK/Fk7H8
         UILvDe7pOSZx4mZTXVEKKa4NRr7Q3ro0Hx26gulfzECGnft/Dub/Dej0EoSvnoLhXGwX
         u3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809210; x=1716414010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6d83dhT+S2lh1yIex2/6qztxlK0GAg9WvVm+H2kk0ds=;
        b=IL9OC2YkhCN844MeLDJmVyptVnRXGk9j80uQAwPsUqkDjWagx9Z2M/puSEhafuAmFw
         QpDGp9Ek5741BUWQAenxjJQ4cFPyEPRre1NXMvsJNE94YN3N6JhT9BuztSChQbXbi1sM
         JjpSg+gVVFCuvaLYmK3+hXVkEdfarlGbpcnF+htOlpe+2OM5O63gGi5hLYKr7C0rkgiI
         benhGw2z/0u5H2cG1zenewaIUlvOxvJN6XYUlsBT7Zh2vAIHmPpzbsKW8pyKXgvVrj8o
         /6V7lBSoV9F9/GKPti3363xnJOv4STlInjEBVdYtIk4RHcRa9boCzWBfZL2FFdf9U1Uv
         OWQA==
X-Forwarded-Encrypted: i=1; AJvYcCVZl2trl+9RjHnZapMkj8rARUaw+4aLSrMmN5al4X+SdxEb4pjGkCpyW8HW88JiGWyDPNFLHsb8i4U4RQub5jHr57kAOK4w96hWCwUtLxw1Fg==
X-Gm-Message-State: AOJu0Yx4J9hhbSRGG+K2KJxnyL1QRr11LSnQ9pyDeohjryoMQsOYZm2o
	8CXe5P1Kjyct+fE/RxDhHjEauy+Lq7nIVIk6RHe5B3Dn4iyBns8pmWCxSSBy3uK+6eF3MQwI2gf
	bGyQMf67x8Odm0kwuem4w93jVRk2Y8WDQ5pkW
X-Google-Smtp-Source: AGHT+IEePRaQH68ZHbSj+Ympv+TQCUiCPrMZ8748+iyv/Bh0uQTh1RJELLvOOnVp8tL/LP0Z/Hqgkb85Pgy0Pk2o3v8=
X-Received: by 2002:a05:6e02:681:b0:36a:3d4d:7149 with SMTP id
 e9e14a558f8ab-36ccb88f31fmr12244885ab.8.1715809209884; Wed, 15 May 2024
 14:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515211045.377080-1-leo.yan@arm.com>
In-Reply-To: <20240515211045.377080-1-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 May 2024 14:39:58 -0700
Message-ID: <CAP-5=fVh-i5cCdW9MJ5AeN2k5Os2W6fifSCMi3gi6qMt_cdDPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf maps: Improve the kcore maps merging
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 2:11=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> This patch series follows up on the patch [1] to improve the sorting and
> merging of kcore maps.
>
> Since the kcore maps are not sorted, merging them into the kernel maps
> causes difficulty, e.g. some kcore maps might be ignored. This is why
> the dso__load_kcore() function handles the kernel text section
> particularly for replacement a complete kernel section.
>
> This patch sorts the kcore maps and ensures the subset region is placed
> ahead of the superset region in the list. With this change, merging
> these maps becomes easier - no need the special handling for the kernel
> text section.
>
> This patch series is based on the latest acme's perf-tool-next branch
> and tested on Arm64 Hikey960 board.
>
> [1] https://lore.kernel.org/linux-perf-users/438f8725-ef3f-462f-90e2-840c=
ab478ee5@arm.com/T/#m7c86a69d43103cd0cb446b0993e47c36df0f40f2

Thanks Leo, testing this change on perf-tools-next with an x86 debian
laptop I see:
```
$ perf test 24 -v
24: Object code reading:
--- start ---
test child forked, pid 3407499
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for vmlinux.
symsrc__init: cannot get elf header.
overlapping maps in [kernel.kallsyms] (disable tui for more info)
Using /proc/kcore for kernel data
Using /proc/kallsyms for symbols
Parsing event 'cycles'
Using CPUID GenuineIntel-6-8D-1
mmap size 528384B
Reading object code for memory address: 0xfffffffface8d64a
File is: /proc/kcore
On file address is: 0xfffffffface8d64a
dso__data_read_offset failed
---- end(-1) ----
24: Object code reading                                             : FAILE=
D!
```
The test passes without the changes. Let me know if you need me to dig deep=
er.

Thanks,
Ian

> Leo Yan (2):
>   perf maps: Sort kcore maps
>   perf maps: Remove the replacement of kernel map
>
>  tools/perf/util/symbol.c | 117 +++++++++++++++++++--------------------
>  1 file changed, 57 insertions(+), 60 deletions(-)
>
> --
> 2.34.1
>
