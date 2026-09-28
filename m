Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C113F4E021E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608260; cv=pass; b=FlEXoEFENiO2OWbmWPD+ZTbx01t+cxlRKXBiIz/uZKH9/g4JAscDcJXohRREfoGvyruZMcgGelzXD6k3Kr5eIy1Zihk2GEketbPuEV0PYXtq95D8Bchz27E+ce62JSpGvY5aG3O1U0rbP/LZZLYnkd03YEnZgxHnK7Mj4ZmzZJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608260; c=relaxed/simple;
	bh=pZqLigY/V58vxv0vplszd649EomfRBfgLWrDqFBPRrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYk2wmUakRcgfg4PCoy268aFWR5DfIdH+e9LyNaTCLfFzVoADevG9r9MfWT8552vCS9ac+jvETxOM2oL95ZgUB2zW6RlRkwBpREtrTus6/78TVHHhv+21ujdpkdNgmb+lzLKoo5NtIlhEkeWgjdD2LusKq20PTuih2DRwEj5oXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLg1q/z0; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLg1q/z0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so81795ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608258; cv=none;
        d=google.com; s=arc-20260327;
        b=GBrpD9tI2BT8txHLhqyt/e22MPnEmzoPuk2VUnqyD030wclHcy7I86grEABfxk5Hd5
         kuAeRcaAJDmrAG1ZGRyFtuyMxx6iyn50+RrfmuA2pT728x5WNjmKCeH6XFmMHDQpR+D1
         MHmdI2fWdxPn9IhvvPNaMzTr8XiWMRzx/eWeJTrVsMyvhxhHvzjEx3OKenCkeqkZItEr
         ay+zPvF3keVAuud0VxAX3/Yo2haOQOlH3VjuANi8gsB14A5I4clT+Vni0Ba8upysmToq
         04I11MckD4Zw5Jvndnod6uY3gWftsdKTz4UI6dZlmAyEQzgqkdLE+T+0aJsZIWYf1OsC
         rICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T7/zoEBFh3/uOoeMjRxiTHNfdp81+5Ohw65fQALeP0M=;
        fh=NHge9rDPIbUzkJrPesRO2CW38gFcN9Gt813604YiL3o=;
        b=LImoOWPmtvfmqxadm5f2PsWd8bJZBCakCE3u/9QS3U99zqb6PirsSGM90/PlPWMXPC
         +SGgARTIUie0gQU+JSkwaEbSZJzNUv7AH/W178yKVdzcpPZb9KH+HzXD3sEwWtF9FGJQ
         IOG4Dd9qlZA9eZlHx81pkNleOwheMGw2lHjHYSnnNUv9yy8svvQv/m0pI9BbKUp6bPKp
         WHWcrEbmnoo8403R2pqZeJYj+7IDFsjQLcUwz15AddX7AtGjTr5PlqbI/xRM+OqffXz4
         F/gpEkhoIFWb7hlkfrhXaMzbQtRTvE8dxX5e3GLIzg/xZxUEXsGNnKEHMCu7pn4n5djq
         I57w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790608258; x=1791213058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T7/zoEBFh3/uOoeMjRxiTHNfdp81+5Ohw65fQALeP0M=;
        b=CLg1q/z0cqy53j6YyJvGfZ/ghKbvh6w6wfGtvgb03GrdxDXgjchQV7BJ6LFzAv/K6h
         hqWyiA+SqBHrOBnGe+hBX6GLtTCatxYaATIBR4jxMAh+hczOkABJnVoBcLcZtqkgkfjt
         uF8lnsSRpEHfQuUNVSnecKOYPc5fHt7nSbZBcPPFUB9iyTZaFl9xxDNS5/DY2/aEquYF
         5etWcEI1rkbeNYkYi2ZT3gqeMIlvqUkIqwKWqCglxF8I2m8CCLZlwNrwI8SFhhhRFm5R
         TX0xxSxz6bNQYnq9LaGC0rzNyzQnzjHuQsf5JbN8FBgk5gL0FV/ucRXhi/fpY25G6CHX
         RZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608258; x=1791213058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T7/zoEBFh3/uOoeMjRxiTHNfdp81+5Ohw65fQALeP0M=;
        b=eWt8pTetK/DNIR8B9/lwhIyVO/p6fpj6ac+Vh70XKrz/CBhVq2+AOeesZCxvm2WT3p
         bs8P2fSFpiYB1K2dbYZQ/zUeRzZBSNZXgu3wF367SMoxReYkZM6lgk9DDF9gD0kX0mf7
         2lbPf63pqf24C5ZwDwU1J2zI7ZLO033rCNw1lYJHxA7oHqoOA07G54NYJLPufNdE25aH
         Y6vH9dvH8Nt6XQNh76CrpL5xd4dmlJ5x9wNMxDdIrPJZs9gZIsZug383cMPXUKwvyjR2
         /ciMaUSQURdlVW18CeXSintnHhNcMs/VomM2nJ1vhuZnzHle6OjFhlEsIn2T3YKhLZi7
         pNeg==
X-Forwarded-Encrypted: i=1; AKwUvBxnChCSZD4TRb0J9Hxp5zA2cr+wwo2FFTjq+V9+rS+rGwvn/eumHQaVXMA+UlUvB40Fx42kftptQCsNSxmoJknj@vger.kernel.org
X-Gm-Message-State: AFq9FYIBZX9UtfUbQq1COa9YAYTa0+V/X2O7aNVpOCsegXNaE/str14K
	wi0XkZXZZg/fJ7gCL337s6AlIqpN5FjkyNEK3MVBq0j2rsQFKf4OaDzbJaK5eBXENjcYvXA49DW
	AuxDeynQqvJ40B+62I8GpUC/jSsh/qJmiPvcIIWCJ
X-Gm-Gg: AYBFou0mA97UgRXyouch3giljks38vgnU5nZf7DrR1Lk/SxvhNssrxO23Au/3wHF+RI
	oNAYL2ni/dhW6MvvubnEYhyB6Vzw65bjtEPXA91W0qz4XWZpv1VHlgsydiuDHT0BKp2uHEftVXb
	bgzwxf05zpjNqWkTOUVq5itbAdc2/pkIcZvQCdKNz5K05MVs2XpRp+23xFlupT42Xq9fdwXC98n
	Zaj36nr3IVRhEdopJvpj56/iOOfRLqufyCwqays0YwAiEUoKzhiRAk2u/p2ROX1kmAcOQCa9Beh
	vIBKsC3CPIWdxUR1SFjht0srAAcZijHKjcEdhyb9Q1FkEirdUWJ0OvZOjg+lWmIl9foWr5OGKY/
	V8T2dfrXz
X-Received: by 2002:a17:903:4b0c:b0:2dd:3a08:d47b with SMTP id
 d9443c01a7336-2dfa9776406mr6317755ad.13.1790608257368; Mon, 28 Sep 2026
 08:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-perf-orphan-args-v1-1-8cacf784621e@bootlin.com> <8bc8b276-bc4e-4a6d-b770-5b02c79946d4@linaro.org>
In-Reply-To: <8bc8b276-bc4e-4a6d-b770-5b02c79946d4@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 08:10:45 -0700
X-Gm-Features: AclHuK-kAXBX9fdC7SCFH8-ZLHfC94yfr3nfW-yKnzc1gR_zZi6raeAWaByfbbw
Message-ID: <CAP-5=fW8As_PsV1JQtm1yx4pOwgX+znBL3xDR_0eA_hApHOwyw@mail.gmail.com>
Subject: Re: [PATCH] perf build: Improve fix for "argument list too long" error
To: James Clark <james.clark@linaro.org>
Cc: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Markus Mayer <mmayer@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:15=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 28/09/2026 09:55, Beno=C3=AEt Monin wrote:
> > The orphaned pmu-events JSON files are passed to the shell via
> > `echo "$^"`, which puts the whole list into a single argument. With
> > a long enough output directory path and enough files, exec'ing
> > /bin/sh fails with:
> >
> >    make[5]: /bin/sh: Argument list too long
> >    make[5]: *** [pmu-events/Build:228: prune_orphans] Error 127
> >
> > This only happens with out-of-tree builds, when setting O=3D to a
> > relatively long path.
> >
> > To reproduce, build once with JEVENTS_ARCH=3Dall, then rebuild with
> > a smaller JEVENTS_ARCH without cleaning first, so the leftover files
> > become orphans. Using nds32 (which leaves ~1100 orphans), an output
> > path of only ~70 characters is already enough to trigger it:
> >
> >    OUT=3D/any/long/path (at least 70 characters)
> >    make -C tools/perf JEVENTS_ARCH=3Dall   O=3D$OUT -j$(nproc)
> >    make -C tools/perf JEVENTS_ARCH=3Dnds32 O=3D$OUT -j$(nproc)
> >
> > Express the orphan file list as paths relative to $(OUT_DIR) by
> > stripping the common prefix and restoring it with printf, the same
> > approach used in scripts/Makefile.clean, so the shell arguments stay
> > short.
> >
> > Fixes: b6712d91f8f5 ("perf build: Prevent "argument list too long" erro=
r")
> > Suggested-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> > Tested-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
