Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201411E480
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jan 2025 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737770331; cv=none; b=XkKQ3qcCgMSk2+ib17mqUFj+DE1DNLE+ZRL4+6cr68iAeWb1cT31PasGGX4q/Amq4hB4sN0wLqFNt8/KXJqEmFlHcHTU/RVPGE30jBzuj619L6POuNk9UU9VMbt2KtfhX9eAiUprDxQIbyRAXasdqzVt71ANBVmf3KaJPY/VRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737770331; c=relaxed/simple;
	bh=Sinl0CIUn208n4x6aQdLWlnD2N3YXpOyld5g9UMNjPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sutX821YGMuUSoF9nEqxdKeDOvQuHZfH8XaOjVpfHT+lTBodEkuQjPuZQ39RSseuXCC45s22eEtkWitMLWVdqZszgyrVrzNOSwm7cZxXdOrvaX5FBNhCNPiNcNH6UUVdBm+i5+gnnt2pfyv8qI36ZD9URvNeyJUcgb9jGGcaREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AChwHSG8; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AChwHSG8"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so56605ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 17:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737770329; x=1738375129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OpSipsOpsfsItjnlAcpF/+olCgjvh2BR9vXXSAw1qg=;
        b=AChwHSG8Oos7ftRkawbQDk4RhvmJgAARpsOkmygM/XAu8BLOiegE839cZusPtioq02
         zQ3ktbqkfBVUhY0u/B9fGfI0ZqrUYkBRvdtNsxbZPRJc0JoFUHWIKDCjOy5Zo2K6OmD+
         RqUjBjQ2J7slE9wD+GV9JDF3JdeiwhDOYYuAJLDVVcewtIny5UapPakDlpD8jrZExMKd
         8dZR/gtUCF/+BrIqEW7yIPAyUYWN9AIB6EHmVMu50680HZSdOBi1k3D9h3i/CqJzM6Ss
         Mjk0NNWJKbgULSqjNOn24F4o8U7d3TPHFqOG5t5glBbtehNJLBrhiAy24mMpxQyuZ4fz
         rs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737770329; x=1738375129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OpSipsOpsfsItjnlAcpF/+olCgjvh2BR9vXXSAw1qg=;
        b=pKXnyLMt9beJue8BLNPDEeAFNo9RcZ/2HOKYOBNLa4kpPEEsqvUZGaTCV5MVPNJbGw
         uO0GvCd/LvxvJDhrT3RCp8hL4wPo8ZqhETHjdDE7Ls7D14WVaZVkPzLhccCrMicd34uK
         brlOgadnqLgxzqN9x7pUFcBQWgZbzuEcWvalLgm1xQ4BRhdZwbc7Mk5slr7MmmN/OLxC
         zhnzKKPtbO2XKdtgjQBsdZdUGxkqCArjtokh5urQn8Qdj89W+epdmnwoq7+sS2YErdeC
         WPo0KfOY/WXThZdrQOWluAD7bFyjNNwnG9XKL13bAN3AuQDdxr+7W1Cbk5e2HaEkh0v2
         AwDw==
X-Forwarded-Encrypted: i=1; AJvYcCW3wVp3nFt4s8lm+WajYi4vMjSJXFQW2geFB9D4v+q5jKck8OHlWKZ3JhEc510ZXRdUWiX/oY+6UiITmmivLkYN@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCFLQHHVVBqkaHq12joETeX31kT5Qivo+TNXXmMnEoBz7Jk+3
	c+K+mK5X3kjkivqzxS3Q57NihjF6iOvVeQ3QFMp/iGGj32upQrKZL0ojjmBl4/Yjwsay6IwfxfV
	59GCLU3pc2qnI9xLhVm1VzfsbjEj50YTR0i77
X-Gm-Gg: ASbGncv9AZ8HnxV5HhN6QszdP96xejn34zA/CB60WSNQMMe8CdOzQqmfRsOsxqzpDcZ
	nEDk52wN/wK/KTs5gy49WMjMMtC7wQh2ZSA6ZzEnwti1iJNPV/4oVmrMcCY0QXiU=
X-Google-Smtp-Source: AGHT+IE40+8rscSR1lW7koRG3jKZzuq9i8i76IBBBd9DqbU1ii8pX1HByFvmgjBDUc8UUkLfMEramyytAproBNI6ds8=
X-Received: by 2002:a05:6e02:12a1:b0:3cf:c9b6:290d with SMTP id
 e9e14a558f8ab-3cfd14fdfeamr1276675ab.16.1737770329066; Fri, 24 Jan 2025
 17:58:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com> <20241025172303.77538-2-irogers@google.com>
 <Z5Qi5olV2yy2-TJ8@google.com>
In-Reply-To: <Z5Qi5olV2yy2-TJ8@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 Jan 2025 17:58:37 -0800
X-Gm-Features: AWEUYZmw7UDHyKfRYhWTTZfMisfPINpFEx6SPXwOzmxsfZO8IKD4UVE4yPVJ3RU
Message-ID: <CAP-5=fXP8ZbVKBr6wetdP0AJZrz-MmtyigHOjZanA-wNUcTfRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] tools/build: Don't pass test log files to linker
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 3:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Oct 25, 2024 at 10:22:58AM -0700, Ian Rogers wrote:
> > Separate test log files from object files. Depend on test log output
> > but don't pass to the linker.
>
> I don't know why $(obj-y) contains log files in the first place.  It's
> supposed to have .o files only, right?

There's context here:
https://lore.kernel.org/all/20231129213428.2227448-1-irogers@google.com/
$(obj-y) is the set of the dependencies from Build files, generally
directories or .o files. Perf added the test logs as the alternative
is to duplicate all the directory scanning and other logic for a
$(test-y) but it isn't clear how you'd even name targets for a test in
the Build files. Rather than reinvent Makefile.build the choice was
made to work with what we had.

Thanks,
Ian
