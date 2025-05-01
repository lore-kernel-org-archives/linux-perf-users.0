Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01218DB16
	for <linux-perf-users@vger.kernel.org>; Thu,  1 May 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115496; cv=none; b=XLQ00ZWigwqpVOBl8i1C/IZ/WWLsdiE2zIt8BgsY0/je0Db/40h66MYG1emewyKpez/w8dRIysSPXP8O1/7/EBqslqiDMGqJ7mPOc7GBKSk7/1R8Hq7tYD3dEtWDC0GslDH87okMeGGmlloJ0fT8pYwQyz0Z9hE0KJ48urJZMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115496; c=relaxed/simple;
	bh=82VYoGanBHmMKD+zKutqvwq+pxtO6cUO1QPjiyXbmg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNknXywMhqwr2aN6POiiotHnimPsoBWeYoYXSKCtPL+gwE9CwHyxE0OpSSQhHYuoxZ0w1pmaIrF04QFN1N0+lrHMe/cDtBi/f7DDoo1GQ9W1BNpqu0IJTZH/bPMwOxYg+TBypEKM96YriAVtWNKZSsc++E1Qp7gXfrKVtVjHQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFd4qPEc; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFd4qPEc"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d8c4222fc9so211595ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 May 2025 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746115494; x=1746720294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw9w2gM7Za/XAYHcqHX5DQhreqsNkxW8bgiGG9Upjus=;
        b=jFd4qPEc/tzaBxdRnH7AXXl+mSWyLYv0Bir6u5i2RJIMscT8xczqVQ4nX8hYCJBrKl
         NZIJFyLu8baMil2kB59FlyouyaSOch2vZ71WBKrw72pZX0VYQXc9GWlQGy+v1AtCTd+U
         5m/XMPFwp4hBI9cpfvkTunecDO7iw8BFFOskstoNFbKLxs63E+BiERI8X4VsJvZ3cCsz
         moszuKlBRa0IIEtJpGcwzyEgmK+ODG61wKGjRpjVe6Z82IFUDgmnJf7IbSeneG7/za+2
         CqTqWgGn5Ct291PGi+BO4xmbRRiCrRvIycOvkMBNSbe+4sCXVDB4UPrgvD7+aDtc4IwJ
         IpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746115494; x=1746720294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dw9w2gM7Za/XAYHcqHX5DQhreqsNkxW8bgiGG9Upjus=;
        b=RTNgLVQyKg5b+09rpwiv5uk5ajpPK/eWV3S/FaTmLw9Whj3/oage0oKKj8AFYWjD/2
         EKWSXeln33q/aIimbb+RY1IkEW8lh3cg/w3TuwvbOQnivOPsmSONy924vOfau5JOxOVD
         mjxTqv5XicfMHMbtKK6xf1b384och1osTeRzCrAJAPJ7QeKLkiOBT/3zVfeSudxH8P/F
         xgMqt9GwwdgTzCJ1BQX171ur+c6Iwwu4YPE7kQL/tDg04l2fr0h179IYuTHtS5LyaENJ
         AqJsaJoUCz4wek3d87vem+atR+Wj5yTAo7CPrSCcck2s3cC++4rxm/Ynzi3QuA983/8L
         RZsA==
X-Forwarded-Encrypted: i=1; AJvYcCWYJrO91cUwfnPGxxUnUF6rI3GaFBEPIwNBkB9hDkbMQcbeZEFSdOW47TR2PAmqBemmz+jaVR7NjqfEunvZuDKO@vger.kernel.org
X-Gm-Message-State: AOJu0YzOeVFqDueLx+ik7mdcFdVKMNpzy91nw6QK35UPqTBEERi7Vwz0
	c+wO1RzecAlqJKXEKELXsYXDbuPtJyETs3WPbOA8bwpxd7bNqOlEh7uJq5DCQZrnDPcFs3Acxbr
	tIb41ABWKPAafSR5ZSrIAe8rjSXlSo/8TYjRq
X-Gm-Gg: ASbGncvWMXkHaHN7b1M4JEYpWIddeRSzdRcDTyl/+oLJMhwU3RRNa92BNDKj1d5QKQL
	VUz4QBFk87N4voEqrR5JWquiTuDiBlKEOKPKRzKsz36MccNJrMhp4HMTZiC9/a5oQgZj8MGubo5
	QXTCQSgaWOUeX/Ns6toUy20jcUzNqB1G+AOk+ll9Liif/9YrFP2QU=
X-Google-Smtp-Source: AGHT+IFsDgSlGJBGSU3EmVMTwCk+Q9hVho2Lgb0k963xjGE2WEJiBEwDTf5Ex5Kh8AXqpui1LdLUci71cTD8ung2gRY=
X-Received: by 2002:a05:6e02:1d93:b0:3d5:e202:6f05 with SMTP id
 e9e14a558f8ab-3d96f2f41a3mr3525725ab.18.1746115494129; Thu, 01 May 2025
 09:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501093633.578010-1-gautam@linux.ibm.com> <20250501093633.578010-5-gautam@linux.ibm.com>
In-Reply-To: <20250501093633.578010-5-gautam@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 May 2025 09:04:43 -0700
X-Gm-Features: ATxdqUEs-So4unwD5FSM6EjUg_ZEy2zCiZhayjjAQfBNeZneWkbdLMCrzPsrSQ4
Message-ID: <CAP-5=fW2--aUG9=14R8fqSEJQN-D3PATTwU15czWVsQidA51bA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf python: Add counting.py as example for counting
 perf events
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 2:37=E2=80=AFAM Gautam Menghani <gautam@linux.ibm.co=
m> wrote:
>
> Add counting.py - a python version of counting.c to demonstrate
> measuring and reading of counts for given perf events.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  tools/perf/python/counting.py | 41 +++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100755 tools/perf/python/counting.py
>
> diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.p=
y
> new file mode 100755
> index 000000000000..0c58907bd8bf
> --- /dev/null
> +++ b/tools/perf/python/counting.py
> @@ -0,0 +1,41 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# -*- python -*-
> +# -*- coding: utf-8 -*-
> +
> +import perf
> +
> +def main():
> +        cpus =3D perf.cpu_map()
> +        thread_map =3D perf.thread_map(-1)
> +        evlist =3D perf.evlist(cpus, thread_map)
> +
> +        evsel1 =3D perf.evsel(type =3D perf.TYPE_SOFTWARE,
> +                 config =3D perf.COUNT_SW_CPU_CLOCK,
> +                 read_format =3D perf.FORMAT_TOTAL_TIME_ENABLED | perf.F=
ORMAT_TOTAL_TIME_RUNNING,
> +                 disabled=3D1)
> +        evlist.add(evsel1)
> +
> +        evsel2 =3D perf.evsel(type =3D perf.TYPE_SOFTWARE,
> +                 config =3D perf.COUNT_SW_TASK_CLOCK,
> +                 read_format =3D perf.FORMAT_TOTAL_TIME_ENABLED | perf.F=
ORMAT_TOTAL_TIME_RUNNING,
> +                 disabled=3D1)
> +        evlist.add(evsel2)

Nice example! Would this be better as:
```
    cpus    =3D perf.cpu_map()
    threads =3D perf.thread_map(-1)
    evlist =3D perf.parse_events("cpu-clock,task-clock", cpus, threads)
```
If you run `perf stat -vv -e 'cpu-clock,task-clock' .. ` you can
double check the perf event attribute bits. For example in
tracepoint.py we remove the SAMPLE_IP:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/python/tracepoint.py?h=3Dperf-tools-next#n27

> +
> +        evlist.open()
> +        evlist.enable()
> +
> +        count =3D 100000
> +        while count > 0:
> +            count -=3D 1
> +
> +        evlist.disable()
> +        evsel =3D evlist.next(None)
> +        while evsel !=3D None:
> +            counts =3D evsel.read(0, 0)

Rather than just reading on the first CPU and thread, perhaps change
to iterate over the cpus and threads? Something like:
```
    for evsel in evlist:
        for cpu in cpus:
            for thread in threads:
                counts =3D evsel.read(cpu, thread)
                print(f"For {evsel} read val=3D{counts.val}
enable=3D{counts.ena} run =3D{counts.run}")
```

Thanks,
Ian

> +            print(counts.val, counts.ena, counts.run)
> +            evsel =3D evlist.next(evsel)
> +        evlist.close()
> +
> +if __name__ =3D=3D '__main__':
> +    main()
> --
> 2.49.0
>
