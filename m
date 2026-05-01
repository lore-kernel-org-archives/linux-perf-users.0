Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F353A4F59
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777642817; cv=pass; b=mMQVLGPEK+Yfx//t7aYy4btlVzz9IdJRAscrWpb6b/oyuGpAuv1jzQ2ZXSZ3g3B19Uf1LRH0cjHwOXnmJHciwZsLzTE1ILWdI7MHiOyIyfl+H2vWEjqQxOcIZcQFiAjiSpeh7kZ5PG/tzcpGuBK/il06eg0pBozjB2DF3IvxtIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777642817; c=relaxed/simple;
	bh=bSMItHUSqyuonkXZywO+4m/0VNJXCvRKOglvuSTS+E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loWOcUuAbSj/epPnRAWk7lK4fqmB+tmpBId8eyLx6mDyXJIWjnDPMmsK9nQi9oEahOCQGXiQLjRRg6XcMafRBQOuweMlAUXlGkX0zW2HJBO8RUI9MzslvTWLAY5JchS8j3hVbtKrXEDBQCKvlk/jcA5f3nN7SchSfEwDpKm+Z/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jL38ALlD; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jL38ALlD"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8d0945b3so7090c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 06:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777642815; cv=none;
        d=google.com; s=arc-20240605;
        b=ezJ4p+QdjacMP5fKE92RiwR2R22P4iq9wdQTu+pHAmVfmE96q2oRPeY20Q+MbsKsSR
         U0VCQf7ueEYxNJyfgtqGozXT9ZMMt7irrJMIB6b0shyw8urOOux3IrDTvZyjigeNS96j
         IuibzCtQjA4ng8E3bc3ILGhofSqedoEbOpfK/FJb+ZDM3kF3PNxQPKILiz+/waPl99Vc
         i74xizb3b3jmcLzpbbAJSFcmLvLoPPdioRoo5plejVoIUkTIrOe6JK/H0m7HcGOnDCSi
         pCCpz/PeGYwJVnEgJuYKrpneHxHonDLXmMrVCwgZHAjPcOodZ1xl/0xVCikIl4bWP6eu
         6dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uWwF5SlHc78cVQoxvPA+rRHxESIlao2hdxw6t7Rnvow=;
        fh=u0RnvooMtrX3Igl20x+zgPk5bD1/gK27YWypyZq2j0w=;
        b=hYrd6HPW1gLXeenXY/TT/wNr/1NUzsH06zX4+Gola5wOOUSR01+05ycdj1/a9rjriR
         bMuI6ajJ4BfsOkh1Km87va/YwxSkqyw0hr8xjnoQFbRL+LYHGqXaVGKdAiBWOOgEp0aF
         Hd7jqM/ZrzeK5WSPK4sV+AcUSkBiLHgD4r0nmAghMpADRAHN8rugM/ivjO0nPgMqbOII
         yjTt2U5+KbxdglcoUmMYpr5XkeNNDmUPTdz6IeyRgx0DwDiWujPL2JVkX1lLAZWI/WKp
         7EGT1R4ZOMqnEFQ8WXpwwNcqLjScEYYbGK/W/WEWBMtHEnHYjJIPkIm4apggskk+EU/8
         soOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777642815; x=1778247615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWwF5SlHc78cVQoxvPA+rRHxESIlao2hdxw6t7Rnvow=;
        b=jL38ALlDPLGWX/BditohtLFTRv2c3YWhpCxB8+nufHNl4pQ8thWnhMZAAQie+Ealau
         coTg+P6T3C1/EvW0/zc+ci2v47LvON0aBDzAldUHlRvzmgVXbhZuDWK7KUVyoHKZbFsv
         DsrOg1sLzCrYN8kGzciWXY8s3NNtKN3ZY832LqPmEwiN6Bu9lz94fmFiXQ45AkfO28Pj
         GcuhavUsW+THAchI7oJ8UGCUlW3Y5EUoqd1TwH0qfDUuiDuXqjaXwNwguH+umyuuoYX8
         vjYhwEtB2G/gDmmEdt+QZZYslZ3AI8I4KgULaWfLkUriTdLsdvH6S5H69+yVKTjj5SAT
         Js8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777642815; x=1778247615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWwF5SlHc78cVQoxvPA+rRHxESIlao2hdxw6t7Rnvow=;
        b=eJLg7A/RtOBk8IStpw1H+kMlX2jVWxarfxOTPnmjkE4gxzJvaJe0VQcgEz1OIWGDl+
         9m+f+YarH36lbMU7MqP+aj3TwcjcpQeSk9fsjiAgnvCXL3jsikE5WW+3GxscTQA6wZU3
         hM6CMESx0ETw4/X3SUdy+czSbSVHkzXjoGRIDmbBG3mbwNNni5+xVbA2wmZkM9WstplU
         Hcmxv+baCXmUmdS+JId7Znze8gg1S71ApEH3tKXoGU14yv/cI7m5HJt3VE6lvknR4WPB
         Sc6mC5o0l/fsLBxn6VyfowTiE974e4tSL5mB5uBCfKRGdoOe9ybXXRNBPYRBiGXYdjY+
         EPpA==
X-Forwarded-Encrypted: i=1; AFNElJ+dJAjfPUGyFJG6gPWDceu2plUxnjch+pFpuLzfGAGuddaoJe1U0W12M31YXkpuw4qHrROnbZqKeawSWWGJBKnv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxig7nAVubsIxTCMUF48f2yl/1kulcM5fGXJk7xE0wZwmDLy1Xr
	H1om7E4UiBGGXDX99BLrLZ5xLvn5M4N8WVfOF1+TUR0Z6aONktWozroRWUO6sSIbZo6DuQRTrnH
	yJXluvWhebN0M+LLyDArDwlqkUPDGzB2WXvBOsahI
X-Gm-Gg: AeBDieuBbgDZejsRkqGmCaWb6Ryvhi+dhZ4yyGlO2rgx0U+mJGNY2dEviqhPKEYMzgO
	sSCGaNreQdzl+YoYd3GbZxcPnlXVgSdb5pjakS/SKl4nqSDV5Wcwn6IQe/Tum/GnC+Pl3P8wUrH
	v4C1ZYiSMjv0KzHdNJN9nESfm3WB210D8BAWuiXFe2GtJkhEwUU2rPSzLuHZmUryf3ZlP9Rflfg
	flU2+FzxQrK6DDj/jOf/tkUnCBUtqtGN33fiRTU254nFH530BZ0B/1iLLEl8TGGQc3HQLmY+W/u
	p2KHkgmIqpG60PgeYNn+1K6eq0uFeg==
X-Received: by 2002:a05:7022:6b9d:b0:12d:c9c8:a75a with SMTP id
 a92af1059eb24-12df7b91788mr144088c88.0.1777642814302; Fri, 01 May 2026
 06:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413024805.1316480-2-irogers@google.com> <177751952104.2274119.14762312333480941665.git-patchwork-notify@kernel.org>
In-Reply-To: <177751952104.2274119.14762312333480941665.git-patchwork-notify@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 May 2026 06:40:01 -0700
X-Gm-Features: AVHnY4KQG76L9-eiDfSTD9th9EISToR4aG1cbsq7cW-9DamRRCiSLZEy-fBzqqY
Message-ID: <CAP-5=fVLcfx6_T-o7mJ650K3SX+N+T3YYOY+ibZKJGT8V56NVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] perf unwind: Refactor get_entries to allow dynamic
 libdw/libunwind selection
To: namhyung@kernel.org
Cc: linux-riscv@lists.infradead.org, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 8:26=E2=80=AFPM <patchwork-bot+linux-riscv@kernel.o=
rg> wrote:
>
> Hello:
>
> This series was applied to riscv/linux.git (fixes)
> by Namhyung Kim <namhyung@kernel.org>:

Hi,

Will these patches merge into the v7.1-rc series and then back into
perf-tools-next? I don't see them in perf-tools-next:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/libunwind?h=3Dperf-tools-next

Normally changes like this go from perf-tools-next to perf-tools and
then into Linus' tree.

Thanks,
Ian


> On Sun, 12 Apr 2026 19:47:58 -0700 you wrote:
> > Currently, both libdw and libunwind define 'unwind__get_entries'. This
> > causes a duplicate symbol build failure when both are compiled into
> > perf.
> >
> > This commit refactors the DWARF unwind post-processing to be
> > configurable at runtime via the .perfconfig file option
> > 'unwind.style', or using the argument '--unwind-style' in the commands
> > 'perf report', 'perf script' and 'perf inject', in a similar manner to
> > the addr2line or the disassembler style.
> >
> > [...]
>
> Here is the summary with links:
>   - [v4,1/8] perf unwind: Refactor get_entries to allow dynamic libdw/lib=
unwind selection
>     (no matching commit)
>   - [v4,2/8] perf build loongarch: Remove reference to missing file
>     https://git.kernel.org/riscv/c/841dbf4871c5
>   - [v4,3/8] tools build: Deduplicate test-libunwind for different archit=
ectures
>     (no matching commit)
>   - [v4,4/8] perf build: Be more programmatic when setting up libunwind v=
ariables
>     (no matching commit)
>   - [v4,5/8] perf unwind-libunwind: Make libunwind register reading cross=
 platform
>     (no matching commit)
>   - [v4,6/8] perf unwind-libunwind: Move flush/finish access out of local
>     (no matching commit)
>   - [v4,7/8] perf unwind-libunwind: Remove libunwind-local
>     (no matching commit)
>   - [v4,8/8] perf unwind-libunwind: Add RISC-V libunwind support
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
