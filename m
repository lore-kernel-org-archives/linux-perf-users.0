Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B85204F72
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459054; cv=none; b=BLANF1zaCyDuk1jXBDoTErvbjP+RvRNEVYbdKd2gJA0o7vD9AJGD6vz8vB46TramqQTD2nzPIatC2FrzdsLvCjzQf8AuJLE3fDHjOyPtL/BcEynst4a/jbWRdJXhqDm45oxUeIYJ/VDzDsZzIhU0K57rKFt3oU/PDGioJHOzlTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459054; c=relaxed/simple;
	bh=fdRNTTqF11Tm74qGwMIRyPMOb9yj8YJ0xMrUNLj2sC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuUCUb9Q8AV9hz+3VPmFA0jxo0cBbmcICISv2N/7PHsBqmH+bc4MDeUdE7GbGfxok5bFB5THSnYNuts3ESDB/2rFVBQ8JM9xJ7U3aw+J41lcvxFjAGWql/j1zUX2tUXxzisbLxUxguMA7ALCpDbsMqRF755JVoSCymzO0oYopqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bI6qH3I1; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bI6qH3I1"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a814c54742so8635ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 13:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736459050; x=1737063850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq5Pq28Ma4ZMRli7h4+jQsL1coppaz0Y7A7E/RNNvqI=;
        b=bI6qH3I1GYi3VCFgee3Tgu4H2FHtGKD+TdLtkrbu1R9d++zfLDAGlLxcIFSrL7Xe12
         3S3uRd6ei2NSIsKxYAWLOJ1kLDWXbrvI8CFL2ZNDIMC8GC0o8HK5VLqKIS1SWCbHaw87
         F2J64V7e1v22kc28PdP4Ybxu+FKSFHYPZiqjT6cLQ70P1Oz5VZLNVZvrKrDYP3urgKHF
         0foOjpjr8l+Me7tGprckeh6Ernl+1vfYpiyg0StamMtgbCIjYGq9f8K5VzZIfDkuDjsy
         o/KMaWQNWGuKRvx7ziIca+g2oVFyE1iEopL4H0qeZKySKVpHYu7FPCYWiIm4T9utIVt2
         aMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736459050; x=1737063850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq5Pq28Ma4ZMRli7h4+jQsL1coppaz0Y7A7E/RNNvqI=;
        b=Ev7UjL/KeiDxOxUv8/8Oaq6hsO31+JNv147Z5Cs7kQi1faUwdCpguDrTvDoYIQSfwr
         dFmcao1XWgMh/EXp3zgd3/9FYUGVwq/KQ6zRPRs4gOItQycOlREpjZIF5mcRgL51Ij1Q
         8GWMAPpzwtfXmSVFDJxiwmqdrnwJ4PyXeYN6EwIySgN3FTPBXzVqqY170wDhFJJO4CoN
         UIBq+ftXXlGkuzJIbtgk7KCJIIVgl77NNxWOTvS2W79vnvMIQSFicEzk0l+fyxd2EmsW
         OL2Hj8vXGqDJgPGqr0yh2SOLYe46RKvozamrnAx+8Ud+01DRxSaXYgREwDgejjvYLd8k
         ckhA==
X-Forwarded-Encrypted: i=1; AJvYcCXUsZZzQmYKccOmv/jOC0QhXzaxp02ffutg9PdLjn2rRr+8HlcvBMXYlm4FLAuuJF+ULXhkU4vGKN5aPaiNkTmr@vger.kernel.org
X-Gm-Message-State: AOJu0YycCC58L5DFYXJCJ1DFcseYBW3EzgzpR28y9Gw9EH15B0vbMcIG
	W2Vv3Ogq/RrQgWvzCdGpprIarSaqfGAOBuA39R5CZZIM8Q6xESJMZ35KnsWgYO5/1PHhh1eie1w
	IHpbqXx2O4BiMCNOrTYUxzB5arZ0/qRKjETd+
X-Gm-Gg: ASbGncsEaQ5VPziPEpZcTNmHgilXDrjvU362tESdt9l1Z8HsYPkootuC7G4Ld0RJmvi
	a55uhiUA+t2ADCwbS2dGkxPvCxtIQfb0uC6j5ZF+TFcipAkpy/K2WO0dVtL3y0Lg/UQvq2w==
X-Google-Smtp-Source: AGHT+IFenZyG1rVDZu8wEn51G8UENe6KuYRmo7nxFXrLory2Xh733iS6bSVwtEEERtgMuWsRrOesOaa1Ykqvn8hptKo=
X-Received: by 2002:a05:6e02:178f:b0:3ce:3d5b:bde3 with SMTP id
 e9e14a558f8ab-3ce58877bd5mr117655ab.3.1736459049901; Thu, 09 Jan 2025
 13:44:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115161600.228994-1-james.clark@linaro.org>
 <CAP-5=fUq1JLCVLQerQbK+itNg2RZaP9zCo9RUTgKoGqTQi3yYQ@mail.gmail.com>
 <ZzjyVgnEUOYknN1k@x1> <CAP-5=fUDnBii8T2hH3o+J=DXMe7xxHXP7Kno5fz4OjBestObwg@mail.gmail.com>
 <8a89ba95-22cb-4e69-a776-3c927e80f5df@linux.intel.com>
In-Reply-To: <8a89ba95-22cb-4e69-a776-3c927e80f5df@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Jan 2025 13:43:58 -0800
X-Gm-Features: AbW1kvYUPXCDZe31oN4aUOqTNJrOnGNDcz2_ylSz1orlUruX7CihfwKwAytWPlY
Message-ID: <CAP-5=fUYYgo5W26FoZ40FvkT9Nf8g1uQdEz_u5zB9=DvYds1LA@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Make leader sampling test work without branch event
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 1:04=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 12/21/2024 3:08 PM, Ian Rogers wrote:
> > On Sat, Nov 16, 2024 at 11:28=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> >> On Fri, Nov 15, 2024 at 10:54:43AM -0800, Ian Rogers wrote:
> >>> On Fri, Nov 15, 2024 at 8:16=E2=80=AFAM James Clark <james.clark@lina=
ro.org> wrote:
> >>>> Arm a57 only has speculative branch events so this test fails there.=
 The
> >>>> test doesn't depend on branch instructions so change it to instructi=
ons
> >>>> which is pretty much guaranteed to be everywhere. The
> >>>> test_branch_counter() test above already tests for the existence of =
the
> >>>> branches event and skips if its not present.
> >>>>
> >>>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>> Reviewed-by: Ian Rogers <irogers@google.com>
> >> Thanks, applied to perf-tools-next,
> > Rebasing on perf-tools-next I see this failing on my Intel Tigerlake
> > laptop. An example script output for:
> > ```
> >  perf record -o "${perfdata}" -e "{instructions,instructions}:Su"
> > ```
> > is:
> > ```
> >             perf  352917 49604.160314:          3 instructions:
> > 7f155caca323 [unknown]
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.160314:          3 instructions:
> > 7f155caca323 [unknown]
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.160317:         18 instructions:
> > 7f155cacaf3d _dl_start+0x3d
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.160317:         18 instructions:
> > 7f155cacaf3d _dl_start+0x3d
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.160319:          3 instructions:
> > 7f155cacaf44 _dl_start+0x44
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.160319:          3 instructions:
> > 7f155cacaf44 _dl_start+0x44
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.161099:        120 instructions:
> > ffffffff8ce00080 [unknown] ([unknown])
> >             perf  352917 49604.161099:     181013 instructions:
> > ffffffff8ce00080 [unknown] ([unknown])
> >             perf  352917 49604.161115:       8811 instructions:
> > 7f155cad22d0 strcmp+0x8b0
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.161115:       8811 instructions:
> > 7f155cad22d0 strcmp+0x8b0
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.161130:      10483 instructions:
> > 7f155caba508 _dl_new_object+0x198
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.161130:      10483 instructions:
> > 7f155caba508 _dl_new_object+0x198
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.165156:     177355 instructions:
> > 7f155cab90a4 _dl_lookup_symbol_x+0x44
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >             perf  352917 49604.165156:   13313598 instructions:
> > 7f155cab90a4 _dl_lookup_symbol_x+0x44
> > (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> > ...
> > ```
> >
> > Dapeng/Kan, any thoughts why the counts don't match for instructions
> > but did for branches?
>
>
> That looks strange,  what's your kernel version and perf-tool version? I
> just tried the latest perf-tools-next branch, but I don't see this issue.

It seems to have cleared up for me. I'll speak up again if I can get a
reproduction.

Thanks,
Ian
