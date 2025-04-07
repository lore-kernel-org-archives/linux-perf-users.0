Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A951725A62F
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050246; cv=none; b=g5B8neSm2o8mSTx68nyVc+JOqwNdLNCl8AW2bved9CtAjHc9lfMmEgZAWykgxs8mQWJjReZY1yBfgOcAlNeQ9J2nO+BrCcOhkWz9RH/hzBuNXSkReautUv9OIPdueC/xB0V5yQ7ARNJa15HLBgMvOD5WKzHu2kN77tUokuwQnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050246; c=relaxed/simple;
	bh=ozD/jfCHUFU7Jgh/dJZb576t5FUpKRz97HCHop3jHvo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t88TRXeH1sRguYhq7mIR+dY9aN6nucXeOoDxcOtzLwIV6t6x6rBe31P/XDmdlj+K+UjBBAShuDt3P7oH3HbUbml5L9NgtSVP6gOw0/s3OvJK7oZTm/D50wEXBlFtnyzioX8fa2gZOh7gq/N7fsagrUQs08JehD4zvSpD2r+6WZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pw04qhAk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pw04qhAk"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264c9d0295so26455ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744050244; x=1744655044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ozD/jfCHUFU7Jgh/dJZb576t5FUpKRz97HCHop3jHvo=;
        b=Pw04qhAkv+GkMMnSb9ZT8/u3tWAq4Pid/j6onY78Kkk9tqiAQQTrQc2EeiTHyzQaKR
         YVYebHYGvZPgSrL0kOpLGQEtzOBiPkKPsEUZ/qICgebuqgMED4JkY44OpKmycTgzErKQ
         +RiPNQG6+MJdD45+VG1+5tlgJO76PAuX1CnLRSjluOI163DDXSDv8z1I72+aRWE8BF4O
         us3GLHbSkIfUa1Nry0cMby8Pgi249H7O0bfgkPEtuPrqJE+NgMQpD9Sef2bAZY5OvwnO
         YI4eFm+UzLIwjbK952MApt5V0s8O+k7J621ktSZ3V6Rbdrb7aapoy0HBV5Co4i+AFzKl
         sJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744050244; x=1744655044;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozD/jfCHUFU7Jgh/dJZb576t5FUpKRz97HCHop3jHvo=;
        b=fWRLfprFcT4F6FfmGL98Ci/B9ghMOA2kiujVds+u7KlZsNzZI4HrO+wozTY+ersPiO
         sGgRn8bqWh3MuPQpVeSkKQLTPjaIiDQLs1TcwORbEp5hk/oINHUZ7+N1D7JLfMPyhpKc
         NuVZODd2mNP0h8Qu3mZjkqBYHpQrI4xV/RbmdtRVINVKQ0gBrxxo00zyH4HzebeBvWqT
         Jp2/b83mPg58XxHR8TllXxt/XyQ21v1YQSmeBh5oiAnkfZvQqXRg+5pL4x4PCkwr6EC7
         Qj+7hsWQe5FMs8zHmNmJ/ihed/T9R4ybl9O1SUVYcOZWE10vmIfFBlQyoeY0ozExYqqk
         V9Vg==
X-Gm-Message-State: AOJu0Yyt26Sr5wPG7si/EPfEVZ54Opb4xOOqdtwmQmc7O17WIPzHSlWU
	myKJrF5tcbnh3FH/YhXPOx6S3bWvPwh++oFCFjU2iqRjQEjNHjXrO84kOviLSsrfrM2p9/A+PqQ
	RmIINgCQzQsKfLeRUZwevTZuhNyQnQ0QL7lzqvCwLAhsUkjbWjp1A
X-Gm-Gg: ASbGncsDro/WFszQyzvA7HafSoL/5RrFFqZ+YX8ldZJPcnohTxl+eSm3Ycgj8gqr82b
	Je9EPRs+HZPq97GBApQ11Nmo38V79bkFD6HFxCaj71rY3ss3f04NtPJ3E/uy3aAVshYriQnk/0a
	9zv21ykFZC3LvpHqn6kf/OGnmv5EWU4ApbLlvXOWC0lTFBm43QIFYIsas=
X-Google-Smtp-Source: AGHT+IEpSnbUGvC5a6Pk/hGzx/MU/SDl8B64zM7Ffsi+OkN9R4bkwhtA9wvijrNxifYXwFY+V0gwfuA+7PJ7Og29WbI=
X-Received: by 2002:a17:903:17c3:b0:21f:9f4:4a03 with SMTP id
 d9443c01a7336-22ab6a82401mr120505ad.21.1744050243587; Mon, 07 Apr 2025
 11:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Apr 2025 11:23:52 -0700
X-Gm-Features: ATxdqUHeFK-Y8HIt8TNcWlnlRF9MMFm69Sm3WaBjxmgXGwbyLrNtTD6sguPocBA
Message-ID: <CAP-5=fX=hnn7egfAj+gyBeQAo24CQ1_mb7Dx-NfWaue8NMugnA@mail.gmail.com>
Subject: Leader sampling and topdown events
To: "Liang, Kan" <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm trying to understand why the following succeeds:
```
$ perf record -e '{slots,instructions,topdown-retiring}:S' -a sleep 0.1
WARNING: events were regrouped to match PMUs
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 3.077 MB perf.data (496 samples) ]
```
As per the test case in:
https://lore.kernel.org/all/20240913084712.13861-6-dapeng1.mi@linux.intel.com/
But without the instructions event it fails:
```
$ perf record -e '{slots,topdown-retiring}:S' -a sleep 0.1
WARNING: events were regrouped to match PMUs
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (cpu_core/topdown-retiring/).
"dmesg | grep -i perf" may provide additional information.
```
With the (not merged) patch:
https://lore.kernel.org/lkml/20250402201549.4090305-6-irogers@google.com/
The groups being programmed are:
```
$ perf record -v -e '{slots,topdown-retiring}:S' -a sleep 0.1
Using CPUID GenuineIntel-6-B7-1
slots -> cpu_core/slots/
topdown-retiring -> cpu_atom/topdown-retiring/
topdown-retiring -> cpu_core/topdown-retiring/
WARNING: events were regrouped to match PMUs
evlist after sorting/fixing:
'cpu_atom/topdown-retiring/,{cpu_core/slots/,cpu_core/topdown-retiring/}'
DEBUGINFOD_URLS=
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (cpu_core/topdown-retiring/).
"dmesg | grep -i perf" may provide additional information.
```
Given we only want to read the topdown-retiring event with leader
sampling, what's the significance of the instructions event? `perf
stat` doesn't require it.

Thanks,
Ian
