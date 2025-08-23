Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB29393DD4;
	Sat, 23 Aug 2025 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755926379; cv=none; b=Q7kr6AQvvrFogoahtr+/TCIvJmHmmFdCvmFFQrZg+Es+38GjYztWiD4r80Wxb8dHRxDQ2XVjM7zFKKcEpBMxavgRg7hcclqyAmcrsEhtOHCeMNZ0J1r5RPXLEJ3GI/B7AwDfEYxQ2ERB2TS/EljNVUeFVdqfzes1xIB8s0hFE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755926379; c=relaxed/simple;
	bh=9L9XJlvI8Kg1zPH6WONbcsKB4nlgTOt5Oso/+cZfgiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIkEp50oJVvetaJKjwc1JV4BIcqIuvdPb9ZNi7zgwL5DK0dRm9lgAP3lkrH9SO8Y1ClQ84NCqQ0LwcQD58mS3JgiijbXiiTOSxtUmZF1VFV9OlQ963SbYxLUv2mCExMU6kwdjz2Yc6qMrjo0gWjO6dLdpEJjKIpfh3i1Mkc2ddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UroTVF+M; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UroTVF+M"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcac45so23699037b3.0;
        Fri, 22 Aug 2025 22:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755926377; x=1756531177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkbhqTDpf6gzSCID1jPd9w2grt5fM6fD+3Q4DeorwC8=;
        b=UroTVF+MhkdWMEpVgZpC+XR5Nl+mudXregmH4pPsmIyBLvNDOR0Eogkg88jlwuPUr+
         z28MwakxqHNVquZkg9wKQsypC9qc5WfSmrOurYI5MaJvrNQwm6eVI8UM7tsl88EGyrwe
         703ruLZaS+ZmM1TfTakYCakZnYAJEOzn+VSk/4xkxFXjJCObpPsmqLFpMWATZ+lBliJ/
         sZuSX51vMJr3aVckQ6YlnHAQruHsskJCFCbaktesmU7W02WcHZOUSRQL8Jrb7UkB1fPS
         +rSnHbByeMXNQXRMAhKboYN0t3ozDfNyg+6bqjJ5EbTWg0sKb7GF17PsilVBP3gKiLqZ
         rCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755926377; x=1756531177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkbhqTDpf6gzSCID1jPd9w2grt5fM6fD+3Q4DeorwC8=;
        b=dQaKYpZrSu36Kvt9yc3RJ7AnDc9dli7QZo6j+FtmNJa+Stnkb9TDxvhVlu1a1o818r
         tIFHVglmxRP+VzPzA90TZmwxhCqvHffBRy4KF/eSPbK0+JHl5pp8EblEuauEKLPVB1IB
         k6M6yo4YVp3Y+mVWEOYcwFGQ8R6cjc1euC6BhtSuyB7hh4nIPbXeMEQzlsBTb2JCQpIV
         4DRjC7Ohj7pMqWttoimj/SBoNs75LO+QXufHN2p8yfPcW128LKlMP37kEkYgsOAPgcHC
         LnmPQiBc00J8WrCXuwMMrQWYRvg+Jxey3jesL7SZogTdhQs38HanKxlG8aNDi9yfY++L
         fZzw==
X-Forwarded-Encrypted: i=1; AJvYcCUCopGL0mXpH4RO2gjp4g0WC31LLBHToOj0u487UxnXIGUdHDe/7RAMvVXd3DxmiekZAo4BqSdSukAEJAk=@vger.kernel.org, AJvYcCWrAqJnv1OoQ9/4QmTI6L7wwxsB5GTOWS0inn0r41bwXZ+g0JtBe90U3kA/thRjKdlW7Pu/pFa/aRKxfPW4QRdLgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyd40VhebOi4XPzGs9f34EGNtelE/0bCdCPC5Tc7Y0zzh/dWuk
	vrZo1BLBep9GZsjaE8YJ00/KzIj9JIA9E8suXghIrWkQQ7t1MpalHdiPp3kxQ6fLcSGV8HjpJ6O
	Q2lh4jAv1jh1HiJyOqoqX9ziAL6gAGyM6/F6I+vM=
X-Gm-Gg: ASbGncv3sIS2KhuPEZARBX0Cz1rTPeOBSuoS3k2/iCHcWCb4PRyZfHoyPTt/D6RDazG
	W12iowaYjucdOcdsL9D6Xir66ifGZRg9ODAbUw/iHnXMYHCU7jV8VWW9HfS1WGm0CPN6MS+9wrD
	NNWDffAbLvEPIoLfM6lQ8+/Iu49B8yzPnoxD0FsfcqI1AN6TqOqik4iibQ99tzdeRKOfQ9z5Mc3
	BOwW0nh7YHaDOIl3i/efeV8bfPGoC1HhcH+XXI5
X-Google-Smtp-Source: AGHT+IEx4zvdNIZtTls1pWePM1S/KeF0vNPh1f2D1OmJzRXp0O1GrTvyKsX/hBzRw/VhQo8Gy5IJ8y6yEJuZADrOgr4=
X-Received: by 2002:a05:690c:b1e:b0:71c:8de:8846 with SMTP id
 00721157ae682-71fdc2a890dmr46741907b3.6.1755926376866; Fri, 22 Aug 2025
 22:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821003220.1051711-1-namhyung@kernel.org>
In-Reply-To: <20250821003220.1051711-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 22 Aug 2025 22:19:26 -0700
X-Gm-Features: Ac12FXy47lJ3NEdvQ4jygIlB0LiiUKA0gXBv00pIDnrihruGMoskXciUPSoKzUc
Message-ID: <CAH0uvoj7s3V7qby7BxQ9Eby4G562MMsFtbonLJ2L3SF1N7CDng@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Add --max-summary option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Wed, Aug 20, 2025 at 5:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The --max-summary option is to limit the number of output lines for
> syscall summary stats.  The max applies to each entries like thread and
> cgroups.  For total summary, it will just print up to the given number.
>
> For example,
>
>   $ sudo perf trace -as --max-summary 3 sleep 0.1
>
>    ThreadPoolServi (1011651), 114 events, 14.8%
>
>      syscall            calls  errors  total       min       avg       ma=
x       stddev
>                                        (msec)    (msec)    (msec)    (mse=
c)        (%)
>      --------------- --------  ------ -------- --------- --------- ------=
---     ------
>      epoll_wait            38      0    95.589     0.000     2.515    11.=
153     28.98%
>      futex                  9      0     0.040     0.002     0.004     0.=
014     28.63%
>      read                  10      0     0.037     0.003     0.004     0.=
005      4.67%
>
>    sleep (1050529), 250 events, 32.4%
>
>      syscall            calls  errors  total       min       avg       ma=
x       stddev
>                                        (msec)    (msec)    (msec)    (mse=
c)        (%)
>      --------------- --------  ------ -------- --------- --------- ------=
---     ------
>      clock_nanosleep        1      0   100.156   100.156   100.156   100.=
156      0.00%
>      execve                 4      3     1.020     0.005     0.255     0.=
989     95.93%
>      openat                36     17     0.416     0.003     0.012     0.=
029     10.58%
>
>    ...
>
> And this is for per-cgroup summary using BPF.
>
>   $ sudo perf trace -as --max-summary 3 --summary-mode=3Dcgroup --bpf-sum=
mary sleep 0.1
>
>    cgroup /user.slice/user-657345.slice/user@657345.service/session.slice=
/org.gnome.Shell@x11.service, 12 events
>
>      syscall            calls  errors  total       min       avg       ma=
x       stddev
>                                        (msec)    (msec)    (msec)    (mse=
c)        (%)
>      --------------- --------  ------ -------- --------- --------- ------=
---     ------
>      recvmsg                8      7     0.016     0.001     0.002     0.=
006     39.73%
>      ppoll                  1      0     0.014     0.014     0.014     0.=
014      0.00%
>      write                  2      0     0.010     0.002     0.005     0.=
008     61.02%
>
>    cgroup /user.slice/user-657345.slice/session-4.scope, 73 events
>
>      syscall            calls  errors  total       min       avg       ma=
x       stddev
>                                        (msec)    (msec)    (msec)    (mse=
c)        (%)
>      --------------- --------  ------ -------- --------- --------- ------=
---     ------
>      epoll_wait             8      0    13.461     0.010     1.683    12.=
235     89.66%
>      ioctl                 20      0     0.204     0.001     0.010     0.=
113     54.01%
>      writev                11      0     0.164     0.004     0.015     0.=
042     20.34%
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Haowei
