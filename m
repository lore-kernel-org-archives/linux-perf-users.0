Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEDC4A1E
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446770; cv=none; b=cPN5I79aX0NjU6oEYkHwsp7ru4/o/QPh9XXaR8dEvn21so/ixZKGw1Zy4J8XtweZTbasbz4UksIKVxURTujSSE/TAqlm+Rihm5ECh4s3j+ePi3ezJbg2WfwZBrPfZJTQLvjhFpIT3VuJa36Hh/fmMC2qWeZ/ipofuSRtwzoDPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446770; c=relaxed/simple;
	bh=hfq5eDNioKtLkWHINnwuIrPBC9aQyX4oQ59oQWB1fDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGnVAhIHazGacsHFNhR/y6kJNJ1sTRwY3YppM0APCZQAbUShMO0ceoDsIP+11yefY3Mu0jeQq99xHSB2zOZ6eJdt1P4ieJD+3PW5wD6KbZF+K1IZmLxVim4ozqFvBDk6mP7/rzviCMkznlKRWAZK6VTwhVlFiSlLIFzaFbdjnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JU0PPyRl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JU0PPyRl"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220e0575f5bso79255ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 17:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740446769; x=1741051569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgxndzGjlSlaXDyh3XBK97TDI3RlMhgPpDRBr5d4hMQ=;
        b=JU0PPyRlYoMp5hQIKp+hvJkENpcAPpFSLvtwlaqnzMWnoLiezocMOQicVWGwokIMwv
         jfZv8T3ObrcrNfsRRkvdOvM+ZFBQmHUsrSO5qwX7GYPpH4iijF6N1oPKQvtiS4qNFY8C
         rODQwR76Y28NFD+wah2TZ2sDrLfLGmXlagShpZcU+YebllSiSL5s07Tv4uh+Y4kf23BE
         UEXHCp7m3Nis1rb5G8E/WMJLfiGU9dZDAHtWtJ3/a5QKW+6ZVJz70b+IRRPgHCtAn2qv
         i8+TLCrdw8BNvTvmf7Hrh9Jl9Z0i7DfpAUSfTVl8PHo6SrvZNqplijsT6TW+XvwGy/O5
         oZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740446769; x=1741051569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgxndzGjlSlaXDyh3XBK97TDI3RlMhgPpDRBr5d4hMQ=;
        b=GqgnEFNcRIcCnTNZQVdH2kisHlZYH63N5lcK6iK/tP/juYOM3OWsxD9sDBg+808lXf
         3BWdVEhd/dZalJ14CCEsc9z5CsP/xbbHvBA4aPSSbCOIg8inpzS0xdgnokqnKShL7CKe
         WzvA+Kx/ljoCet4g6vRHG3YTRcfUca2gtpgbpAtDApS7aLxY14XMTsLDM1UGW3SguIE4
         P/LohgL8tMD2FfDipOb7mRKLzrT/hO87mjedthMIBO3ltIZDQBLrqy0SLGKTelHnrv7M
         oM5gApsJuZJhCO6wJ8a/iAyzuGvc4OT0wCeqxbp4C0EWw5JFW2txlEkvhYPbHvjXeqSA
         eqNA==
X-Forwarded-Encrypted: i=1; AJvYcCUjvTx9uHb/csnNMvZ0KmOc0FTDwXDNfMJjycn34J/Wkb35rlUFAt6pP74Mo+v9pi2td0mWLU5giJziTGvOPLNB@vger.kernel.org
X-Gm-Message-State: AOJu0YxjevgaEzmSsXWfD+ejM4LiiwLqz7CN3SV7b+q/mMDq4A6xQ4O/
	Tuz596y/OvmK+Ah3FRu87r28z/RdIMa0EKWwL/N5U2eRayOBR76qDm5xk3UtpCZRRPcaR131Gp0
	vckxayzbMXMfZt1qLB1GTV6zq4FIHfJcm8nyI
X-Gm-Gg: ASbGnctd4fh/9bxKTAD+dAW4GIdiikB3ZcOIgluU6PKZ/LpDV84bRuq2zL4pqnuIv0L
	8PmbHfIljJGH9iFZSDnPSMrdQGUVBYpxMpgITxG1C6AwPLG/aoDAeAnZDBWlntYr5agIhClwHZR
	KuTnjlCE3Y
X-Google-Smtp-Source: AGHT+IEu/ac0Ot7cbDh2jJe/F41X9Vert1eIl6k/q+sXL9pVLRZb34FeW/KFffe09nTG6uJTb8mY28cNyXJPD6b/pU4=
X-Received: by 2002:a17:903:1d1:b0:21f:3c4a:136f with SMTP id
 d9443c01a7336-22307aab649mr1697915ad.28.1740446768416; Mon, 24 Feb 2025
 17:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com> <Z70OqFzD2JcbhFtL@google.com>
 <Z70PHtvzjHDLx42A@google.com>
In-Reply-To: <Z70PHtvzjHDLx42A@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 17:25:57 -0800
X-Gm-Features: AWEUYZlPfIbadQ9TYnETkNFQse6dMCgB4ETEKljJtCoXZLlUEI-WeE_kLBiuHmw
Message-ID: <CAP-5=fU68UPSQUDtT860myabmYu9i4Dt5gJhtLCq2XinDjEToQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add io_dir to avoid memory overhead from opendir
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 24, 2025 at 04:28:24PM -0800, Namhyung Kim wrote:
> > Hi Ian,
> >
> > On Fri, Feb 21, 2025 at 10:10:05PM -0800, Ian Rogers wrote:
> > > glibc's opendir allocates a minimum of 32kb, when called recursively
> > > for a directory tree the memory consumption can add up - nearly 300kb
> > > during perf start-up when processing modules. Add a stack allocated
> > > variant of readdir sized a little more than 1kb
> >
> > It's still small and hard to verify.  I've run the following command
> > before and after the change but didn't see a difference.
> >
> >   $ sudo time -f %Mk ./perf record -a true
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 1.757 MB perf.data (563 samples) ]
> >   74724k
> >
> > According to man time(1), %M is for max RSS.
>
> But anyway, it looks ok and build is fine now.

Thanks for the testing! So doing a regular build I could repeat what
you saw - basically the opendir isn't contributing to maxrss as the
BPF handling and so gets lost. Doing a minimal static build, that
loses BPF support, things were clearer but not as good as I'd
originally measured, 10880k reduced to 10696k - a 184k saving (raw
data below). Perhaps opendir got better or perhaps there are fewer
kernel modules. I tried heaptrack but unfortunately it wasn't able to
instrument the allocations in glibc's allocdir function (it reported
0). Originally heaptrack showing opendir allocations were significant
for `perf record` was what led me to this code. At the moment BPF
event synthesis and topdown event checking look particularly
expensive.

Thanks,
Ian

Before:
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (107 samples) ]
10880k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (106 samples) ]
10880k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (109 samples) ]
10880k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (102 samples) ]
10880k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (106 samples) ]
11008k

After:
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.473 MB perf.data (106 samples) ]
10820k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.473 MB perf.data (109 samples) ]
10696k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.473 MB perf.data (98 samples) ]
10696k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (98 samples) ]
10696k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.490 MB perf.data (110 samples) ]
10696k
