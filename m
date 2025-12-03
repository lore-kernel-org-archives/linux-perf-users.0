Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E130AACE
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784060; cv=none; b=XAyqGrsUKv24xwrQ3zjCgsVGB7LSTE9PFFHZ/OJzF7VmU7WjOga8hgbSThleErjbTwOQDQ/kO834mcvMBzIY2skGG+Xze7VK82gJKixfB71vbfxBmKf+vni1mI+TBPl+8aJtdYUnySc1FbgYbzJUOQ+FXgH0r9nF71pCDnd9nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784060; c=relaxed/simple;
	bh=Pc6xvFlwmaCjugWWe4xk4KsKLNHMNjEQeFdvIKSQLwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsN2F+RYunQr2vL+iB8XT3MvveWHevTZxKzuCo0al13zZneJe9/9vnP94Tytr21sEF31HH40zCSSNC6dekuduiYeig2XZTyoyK9A+aQXuIOCMLwKU/uzuInsU8f7aOYyCKTlzX9SbJeh6/pdHOXSKCft3hrwcPKimPQapKOKVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpXwZlP6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpXwZlP6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295c64cb951so3635ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 09:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764784057; x=1765388857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zketBcmCOGwEm95hzUcYAuVUG0MvF0RePBexEv2FpWc=;
        b=qpXwZlP6n9QCMeTngOXwR+Hyficpvmu2hq2H+pAl+ljKlaVbhpC3xpKtKFdVu38ucX
         w+MO/Dxsktk6/TAerlZdtqB7c9KFhzDAgTw7lSNEax03Ur6gNIagmYDUQg241Rw5x2MG
         zsYdQNwSrzxWB+yGoAvdqgAWbGcVYRn6Px5fiXK2kUhi1E1Z/CqlhlKMZwKP9sSdtHNa
         NyjXWdGrOfuaAKL1dgbPAZmaylkzxFj3g7CjPOoM2AoYIbuVmI9BV4Rk4DB1PEyHywU0
         tzTntXjZWsMCs8OIg1g4GEUAAHpTBXwycHWfZcnYIBNC69Qiao4doyM4YY6ZRDQj6Z57
         Z+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764784057; x=1765388857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zketBcmCOGwEm95hzUcYAuVUG0MvF0RePBexEv2FpWc=;
        b=UqWluNRYO//Ouj5nSRidUeo8EAWaRgzjo4P9D+8LYFBEOrE/GQrD+b1dUJZom8qDID
         vg1wl13g/qy5QAV79Zu4JsR/ZO85mAENSpmlDbGeOWVYdIPjQXEY0SmwnYSDB2IIihrl
         APgpLi7ntbLd26fH1Nq2BDzb2HiAKSvr7nHbiceKGT7IbRv1PxIgETGxgxNyIDFIp3OO
         tk4tOb3GeZk8ZgvBFrxM3NsUuYn7Pqq/sNrfATnOK5QoXMbmw9kTzpW0N55h124JJGNn
         +cASl8U4N+zVI1pllrHhDtzoRNiMLyeAd/zXl5r1B0ysx/8gCXhnTtWm5WiMewHl7oA4
         bbNQ==
X-Gm-Message-State: AOJu0Yz39Tvt6M6xE0M1qItUdYG9sjz2vkxrn/+bWkOQJm8/Nhjy0sWW
	he23Fl9abvh3ADRnU5LsAx+j6KHOvsl42r7mQ1iinc2k1H+ZsPJnq/a95l7nF4SKPLhvdfpQ1eY
	F0IYcU1rJVpdN5ryI4+IRfRz1cdx1E1vx8Z6VM3jT8+xDvv641O8ZSXnNlOk=
X-Gm-Gg: ASbGncvj3aiO4coRd+PRpRCuBxj4fnOrrYQIm0puXyS2qe1kNxLBoxgYlP++jqQDPd3
	oy3y9yt5NuZeyaU4dJlhg1q8N+UcOJHhiXxtmPNwdarPTBtmXbZ8jXP5LFBQZv7TOUu8DHeacKq
	eViSCf5vR99pQlHTVK0V0eumUZhl78ZkZ61/V/eujOpsUXmIR/ognP5LwxxZRtD1M/wsDL5RNWN
	LBVuJz7pLrm50B14H+RFcw1xDNCnYdC33z9U/XEdXcw3RWOohxsMg7Wb4l77VAJAd4Kqbt4
X-Google-Smtp-Source: AGHT+IFsJbB7WWS/r/KblQTZ8h1j8uib9Zb/NE7hb13l4mJABBZPItbobl8jw1qh6CeGqevtWB/DyPqtpmegNBWGasg=
X-Received: by 2002:a17:902:f54a:b0:29a:70f:1a03 with SMTP id
 d9443c01a7336-29d66728188mr3715865ad.20.1764784056848; Wed, 03 Dec 2025
 09:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94313b82-888b-4f42-9fb0-4585f9e90080@linux.ibm.com>
In-Reply-To: <94313b82-888b-4f42-9fb0-4585f9e90080@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 09:47:24 -0800
X-Gm-Features: AWmQ_bnGgyao-AfK5vGhD-nHqOGMtRWORfxQfaMnBZFJ2iKoMjxoQBUiMnXFXWo
Message-ID: <CAP-5=fXFJJOCDqdCXi4hT65o9g0GH+xwnUT3Qq-OErra51kKFA@mail.gmail.com>
Subject: Re: perf stat dumps core when CPU offline
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 5:20=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Hi all,
>
> Is this a known issue? Trying to do a perf stat on a CPU which is offline=
.
>
> # echo 1 > /sys/devices/system/cpu/cpu1/online
> # perf stat -C1 -e cycles -- true
>
>  Performance counter stats for 'CPU(s) 1':
>
>            123,965      cycles
>
>        0.000356838 seconds time elapsed
>
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> # perf stat -C1 -e cycles -- true
> WARNING: A requested CPU in '1' is not supported by PMU 'cpum_cf' (CPUs 0=
,2-7) for event 'cycles'
> Segmentation fault         (core dumped) perf stat -C1 -e cycles -- true
> #
>
> This happens on linux-next and linux.
>
> Thanks a lot

Hi Thomas,

sorry for the issue! I ran a similar test and got the segmentation
fault. gdb showed the issue was similar to a bug with `perf stat
--null` and testing those fixes gave me:
```
$ cat /sys/devices/system/cpu/cpu8/online
0
$ perf stat -C8 -e cycles -- true
WARNING: A requested CPU in '8' is not supported by PMU 'cpu' (CPUs
0-7) for event 'cycles'
Error:
No supported events found.
The sys_perf_event_open() syscall returned with 0 (Success) for event
(cpu/unknown-hardware/).
"dmesg | grep -i perf" may provide additional information.
```

Not a great error message but hopefully when:
https://lore.kernel.org/lkml/20251201230904.290733-1-irogers@google.com/
lands this will be resolved.

I think we can test this behavior as the only thing required is a CPU
that's not in the cpumask, any very large numbered CPU will do that. I
also think the error message of "Success" is confusing, we should
probably just drop that message if the errno is 0. I'll add these two
patches to that existing series.

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
>
