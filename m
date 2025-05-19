Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE471C5F09;
	Mon, 19 May 2025 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682882; cv=none; b=Mxaf7aRP9HAkIC/49JfeMHMqIwiWMExyIsGIrEYppjPQdVS6vydLH41wZiym07CEhQMc4PCkaMzSNAK4BYv+1Crxy9jh7Rbu52YkKMEC4XGY0UoDYQjq32CC0u+LMlNHTUlQCqTSxsxv/vA0Qp/Q7h5Rh6PLath/XDu43JDT8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682882; c=relaxed/simple;
	bh=J/lwxIGutpbFGhKxDXy9adQ3buGYYRjY+k3yyOE2b6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfdHLzmfN+b/O4bZr6kECd4nCHZgKM5cz4gXTQrKfUC2XeZZe9KbQvAKo7+43tMS7mtqvgPz+QOuNAS18aK3JY0ejPGwS/94j2qim0pW2SIbFpxYyG/6lsTbfzqKr0ocjdEU2qdZRsjy+zgObTkPKDp4NiPzrfRy/nLu3ne7nqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAiZBhrm; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAiZBhrm"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70427fb838cso43858917b3.2;
        Mon, 19 May 2025 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747682880; x=1748287680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoV1+Lw5ibts/6EFMn7/BLTkQ8dTt57TVCoKSoS91Ww=;
        b=hAiZBhrmfc6igG5kHIwIUbkVWv/cOnV+SKUsecncsLqTVhQgZE22XLG+YacnxUhzXN
         DKd1E52/L2zurMs/P8HRItEbbWN6BqGf55Klha6+/xZCpBVDLZ0Xwo/qQvm3IZyztFO6
         lMLDiDYCOrovgOA5ai7EQtYkkmPtPvyo2MGMxeZnX9BDehaa/Tady7Sf9O3y9cxnAoHP
         /baRKEMcFPntUSaAx3tzOGRIAeifuvx7Q4IR/C0gVT55l4uCXR4tfjhUJ/YVSA3tZmTQ
         D2jrdy//Bf5bDFJU7jGQXzLrx3YOaBzZ0OzX0phao6pQYs0SHW/Sd6eIaFaWryOkZAIl
         3hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747682880; x=1748287680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoV1+Lw5ibts/6EFMn7/BLTkQ8dTt57TVCoKSoS91Ww=;
        b=f2mXHiAdVc76A3/kcI7N008o5Z3OYaXx1eDg2DUgAbg5h+ERNiWjN4W0sYfo/SjbJy
         QPMAmK1tksJTfgh8lnEZu1Sb/NDhntQSQFSTr9ul6ZO5Lmybn4Q7izwmnHQ1+uWja0w+
         hBw5KQeikLOmDs1Y0WJ3Cb9FjVYZSk01o6xQRiG7Mhqfp3VFmXt+462yuOiiuj2BALlI
         t2mIUuweHCinLdLV6ccr2FgANQeokbShsJeXMV7xF5O8Sb1RsGcv2h2T8zYAVwMEEhWt
         E+rfEYkJOop05tWj9JDJOwZeBHYOmoY28kZRAHUmAh2IfFVMce9UGXHeSYEiHHkWxNsp
         6lTA==
X-Forwarded-Encrypted: i=1; AJvYcCW5nr3ry04uqCpXstGUprA0Mh8IG7kTFPDS7YMImwZZefGN4oD1/FRZVKHDl5JhrEEVDF5lpSS04o1DWu0gbBVa4w==@vger.kernel.org, AJvYcCWY8DpHw7TQGHCjnBZMUmFXd+TThSm3vFOktt8FdTI3iqGXiYvlKQA78EEQo76Zt/B86lqkkYPiIfaYvnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfL118kosHqUEVH0i7RQY6r8OfWo/38IH/u0cFXVL1eSaG7r/h
	C4QTQTzM3RTyBeb8sUW5p8wFi5jYX2asTnXyKTcYWen9/CE0ty8vToSDH9ZJF/x9EDw5PtQKIe5
	XoO3zVjO8WcM2lEAV3WWFDGB9V6zxmuk=
X-Gm-Gg: ASbGncvRE3/5g1bUZghcjl+6Fmf63whfVa1Ayy25+vH3hmXFjbbPzm7KHVeIBhv4F/s
	eLzMIozOZwKQBf030IkRxblHYvSPyvq64PQt4D/IfncPfanYeVfi4Hiu1zZeuJlzsD0m5q6YbSO
	FDEpYRj1jb1rU/S79dLxBDjdpqWB6JZoM=
X-Google-Smtp-Source: AGHT+IHG33w5ybR7ZRFLvWBmnxjW08sw/GjRIOleTLgAqVjUiXOQX5Pt6R7kC+RWcHmyqbzzTbm/gc0KinaqqVwlrOY=
X-Received: by 2002:a05:690c:6908:b0:70d:e044:8e4e with SMTP id
 00721157ae682-70de044e21fmr8487077b3.8.1747682880001; Mon, 19 May 2025
 12:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518190957.58932-1-howardchu95@gmail.com> <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
 <CAH0uvog3kt=QR1T6uXMBmecDWsh-8UWKXukJ-rRk3in7fud4Eg@mail.gmail.com> <CAP-5=fU_UUKmu0gTmODXCG5JUK6MRFOTFU+LCJTfA5yTP+aomA@mail.gmail.com>
In-Reply-To: <CAP-5=fU_UUKmu0gTmODXCG5JUK6MRFOTFU+LCJTfA5yTP+aomA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 19 May 2025 12:27:48 -0700
X-Gm-Features: AX0GCFuPZtHWgRTm1OIkMixlaXcNMNMkHI5tKZ81phwvlgrcvmv5hwEpwvVOnzk
Message-ID: <CAH0uvogRdA15hhyq=9SmJiHWwoARBEBdAh3PA9pOXVbBBo5ODg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] perf test trace: Reduce test failures and make
 error messages verbose
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Mon, May 19, 2025 at 10:00=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>

<SNIP>

> ```
> --- start ---
> test child forked, pid 279547
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> Testing perf trace's buffer augmentation
> Testing perf trace's struct augmentation
> BTF struct augmentation test failed, output:
> sleep/279619 clock_nanosleep(0, 0, {1,1,}, 0x7ffcd47b6450) =3D 0

Thank you so much for testing it :)

My bad, I have just realized this is because of the data in the
timespec, nothing to do with libbpf... The tv_nsec has a value of 1. I
think the 'sleep' on your machine has a different implementation. On
my machine, the second member has a value of 0, see below:
~~~
$ sudo /tmp/perf/perf trace -e clock_nanosleep -- sleep 1
     0.000 (1000.196 ms): sleep/54261 clock_nanosleep(rqtp: { .tv_sec:
1, .tv_nsec: 0 }, rmtp: 0x7ffe13529550) =3D 0

$ strace -e clock_nanosleep -- sleep 1
clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D1, tv_nsec=3D0}, 0x7fff859365a=
0) =3D 0
+++ exited with 0 +++
~~~

Can you please run any of the commands above and see what
happens(please change the perf executable path)? If you get 'rqtp: {
.tv_sec: 1, .tv_nsec: 1 }' then I will just make the regex less
strict, because it differs between different 'sleep' implementations
instead of having anything to do with perf itself.

Thanks,
Howard
