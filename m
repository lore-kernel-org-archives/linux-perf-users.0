Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E52FFDDF
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409130; cv=none; b=NsCT25VVbAgvvbKz8nUhbkaIBkLh5HjOqR9PXPyeEkkE90PhzutaMP573YwC5wykHutArt+Lye9sFBURfjeTrBsr7Z/2/87Oz5y7F217jAid0qSfsiWmz7EC/hRVJn+JfJ08O0m74Dq9xBP7g6UFyIfLkfYTvuHhIznnzVrrhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409130; c=relaxed/simple;
	bh=32lRufTYnwk4scMEBjeejLUX2d69j2nhVcq2eFWIIeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpegGOccNq+JtXgEnPCJWnmcbue1kcgZtWyu7/UsGFOliXlS8Yjr5KfJIO8EE0I7nlHQK1+YjPbD7ti80Hcem6d1edwoigVfEQgZFPph4wYpFgjt9CpkYTWHa+5zE2VSC4NVK7tkVKrV1mpS50ln+PoI73xCFTu2iPI4fiWzaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngnm/owm; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngnm/owm"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-57e03279bfeso5948560e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 19:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760409127; x=1761013927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kpMx6Gjet7nKP07SM+sqlYQ6GtvDlp5N+73woleb1k=;
        b=Ngnm/owmUj70VhxtpidJD5S3MW/a+aUxjcvob8HsTwRMVcaGrFoZ+Zb7kiv6AdfvML
         0aPWnDBTD7a1SbWHKsOnBYGbwkNgH3ez9ikl8nG0PTwcXpfC5IpCi8ibs5fGzt20lEL8
         WTmjooJTzTRiTwbgKG3vTrM444nNG2950kUFF3rQQXU1w3z+9CrOJ1+VbKAhc123CMOf
         JkAGeBFc5ijKL/7fi+x/vYLizB9+bq4GZ1J1Xlv1/UVifKFLRNodYq1e5J+UElO/o9iw
         iDSD0tOJ1CFVwA43VE72qQLsY/QUY9dOphJY1tOEvZvXW9FgQYPcqYuuLdx3+0T+R8lk
         H5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409127; x=1761013927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kpMx6Gjet7nKP07SM+sqlYQ6GtvDlp5N+73woleb1k=;
        b=i1ygaAar5NFrDf0KsZgeBg4l0rpCkFhDboKpyNowPI1DPCmAybe+anG0creglgkHc7
         Lyq/ROwLfyEajemwVLSj05SleiU1JSlzXXg2wSuvPNDFueS4mcND0Yhh6rabi144uCLR
         8X9baCAnxr4ImZd3NczqthjDr63AufS8vdi6XWidNTbDA6QvrBohmgWKD+U75cHwwua2
         R8SiONCidhgjIEYa1j7uFTxZ2toBfSjQcnEc0datn0ZgTaPUQUp8Q1RDPS36mfOW+48Q
         yysy2tGORv3hyeSnEY+R4w0jaElvYAEDRrdbQI1LyDY6Pmsnpwb8VU11gwRNvaKSPZzb
         EUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW92Tj0M0Sn6JUht7o/x+cNumd64cUzmZG8Jf0iVlbOVEfyuFimRQfD+5eI8ABi8WoMX442JM1QjtZffOVu57FA@vger.kernel.org
X-Gm-Message-State: AOJu0YzFSOfqmm0ZOddhpuFhKoUaiWU+LL4IxBR1yJciic/swlDnes/7
	b8FLhic2+ZQO8kdbr3xYy8GW3388NzvYxqezEDYODl6NhKMsuzQfHahMIPaap4PPMZkGOpINBbC
	3AeAA+C9cAsBidnYGgkIDTUCwrBp+LNA=
X-Gm-Gg: ASbGncuI0k1p5XasfYepw924N/YxeLCSgrnAdDqVeLv1zhaVHACR7bYCR/WmB/ab1Gk
	LtvtJ99ymx47KmjnBNOSk/0cMQ1YcIFSRSZ4wpns8MguuUFwbvftpW8Osh5jY/axc1LGJX5dsS7
	3NOcAHzrCCDmoxMlc5BU7VyjW6LALr91TY2jaw50mjL54SOzhMAJrUXdqVhUG1SfmsFihLGJc42
	R4P0QtPK5vEBaix86RgieyO4lWlqb9kL9O0GA==
X-Google-Smtp-Source: AGHT+IHQusxdWeRHZYbBZ9vABXO5dhI+bXI14JVFmyQnE/YsgKmEe88OEptKtBUFLVN8//gXdt//HQR4B7VrOADpeXQ=
X-Received: by 2002:a05:6512:63c9:20b0:590:94ed:e90d with SMTP id
 2adb3069b0e04-59094edecfdmr2849904e87.26.1760409126769; Mon, 13 Oct 2025
 19:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com> <20251013161429.GE77665@e132581.arm.com>
In-Reply-To: <20251013161429.GE77665@e132581.arm.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 14 Oct 2025 10:31:55 +0800
X-Gm-Features: AS18NWC-wvfYofXPsxQqarb6UBBvBraZgfl_EzfccyeC5jMwPnSbhHxDNniWClc
Message-ID: <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Leo Yan <leo.yan@arm.com>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo,
Thank you for your reply.

On Tue, Oct 14, 2025 at 12:14=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Mon, Oct 13, 2025 at 08:46:01AM -0700, Ian Rogers wrote:
> > On Mon, Oct 13, 2025 at 1:08=E2=80=AFAM hupu <hupu.gm@gmail.com> wrote:
> > >
> > > Hi Maintainer,
> > >
> > > I encountered some issues while cross-compiling perf (ARCH=3Darm64),
> > > particularly when enabling the BPF option. During the build, Clang
> > > fails to compile BPF programs due to missing header files. The
> > > relevant error messages are as follows:
> >
> > Thanks for reporting this issue! There has been some recent work in
> > this area by Leo:
> > https://lore.kernel.org/lkml/20251006-perf_build_android_ndk-v3-0-43055=
90795b2@arm.com/
> > The patches are in Linux v6.18-rc1. Perhaps you could try repeating
> > your build with this tree and reporting issues?
>
> I am not 100% sure, could you execute install kernel headers and then
> build perf ?
>
>   make headers_install
>

I am currently building perf for arm64 in an Ubuntu environment using
a cross toolchain, rather than compiling the entire perf directly with
Clang. Clang is only invoked during the build process when the BPF
option is enabled =E2=80=94 as shown below where bpf is detected as on:

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                               libpython: [ OFF ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ OFF ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]


I have already run the following command and successfully installed
the related headers, but the same error still occurs when building
perf. I am not sure if I also need to specify additional parameters
during the build process to ensure these headers can be found
correctly?

    make ARCH=3Darm64 headers_install

Please let me know if you need any more details or testing.


Thanks,
hupu
