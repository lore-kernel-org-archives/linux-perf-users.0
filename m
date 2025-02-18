Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3A1E8332
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907167; cv=none; b=P/+Qq/IaO9NtUl+J4Im+SdQzI5Fs0t7j6ApnkwOPQlW5STWXObGeMGyvaPByFcWpQKXp6nQ6uNOjT9I5QaD7mwN7ajtkv5HFYVChZQtc8PVBsevzdHfp+hg05sCBjnCtmpIMLvJSQZMQ2LXrrSyFEjXvj32IU6xIIUIOy/dUPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907167; c=relaxed/simple;
	bh=OKg/vspZ1Pfm2scqsi+vbvKuo5N6IB7CpAe1dGcrZ/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyDnRv9yt4wVpmw1LTg6XE0T8uBb5Lgc3gVxMPoGeUovnh293tXv1l1eRCmCx6J8P4bAbdDWEXlzq1qsKhxpN6TVRJFDKAkT4D9QHEkOTfgTgGZdJuSBQfIWTNJ9pfuUwu7fBctvi/x9DIzticE1m99hG6LUvb8sBHTBammzmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pW41pafg; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pW41pafg"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so614685ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 11:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739907165; x=1740511965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooa4Gr2vptHfgJIcnxNWosHyuLVSNNAjrC96CjjiTTM=;
        b=pW41pafgI7MBRiepMAheYan+s7F1OwPC+d/WgDUs1OxdcTZGbZm3FvQMT4VvU0g7p/
         d4n30I6kM8kE5YyNFslPvwr8tjCxeQor41OLVk/a68EuDRINSzq36neploSQqROMEKvs
         xE1YgL2YignvUvYR9bpJLUl9Zs/mgApuKjqaUYANhTz/pDWYcuVfqcGPXUYda96/Ways
         yWD+bOCYDPxeQaL1fsn3wCH+WW3aPufqJbF4zhiK2eJXPU/ox1ODEV+p54jQsu+dBPVI
         3Z+bUEe+7UyDNkzGkiSq2PG0arzIomL0XuUmsTuIyrADHI59TmgRwCK2FZrFrJsdE2j6
         sExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907165; x=1740511965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ooa4Gr2vptHfgJIcnxNWosHyuLVSNNAjrC96CjjiTTM=;
        b=ptzj/fnRlNt1B23+JdM3CRgcJY0f++Wv3WVqwP8xQk/Ww0XJuJ7g9v0skDz79pHmSH
         muw8M7Ko4CKYoGEsITi/Na22ErBC/qWNG5fFUPBtxOm7iLnXe2sOv3CmD0OBePr1EteY
         fWO/BU2io4bsR4+aEKMIOadSqmjQQ69AUh/Lh0nzxQH1ETcM1KbX0JqgkP+CE7fVeh+Q
         fI43ceLnWFZAY56Phv6b50MkuPLYKBzlnl3gYH1eTRulpaqBGYFy2uDm1Np2HUR91oYP
         fkhtcbJ/inWtJ7pYSYgbMnm+/P0A2lH0i/WYSWQNRr735c8SxlMVC6g4oRZFNY/R/U8H
         +jGw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1piHyCXWBFjOR7QBKG+qehbBYcNFpD3CWghFgW9eTMmIISyWIXnxVzjWmegksp2R+QDUc8fQpEdnfzaKGV4J@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+fjnzC92xHOx6VsDJ3u/aK3z7houoelwbSlUqDF6BVtDDciF
	pQFoz35Gh8UW4ZAUYrOv4RWmr1vjlWJjM5XQezRRY21gefzVBe/3NvvpXCmojtzIwbR2sL3IaxI
	BDsB/MTWPkZJ/LQOWnBue/zVnAhwToxcoKDH5
X-Gm-Gg: ASbGnctzNkiLdNgkY9i84siql6A3zYB54JJd/aZNj/pmxjoqczhS107RK4364NpWied
	l1iIkIaxdEiwdcdqfKPvfFD2nA8K73jkLKMY+f0SGQKkAA/x0jaK3+rk9MRdxMCiEafLNGJoDMo
	LspTe9vVSHfo1iD58t3nuBvICU
X-Google-Smtp-Source: AGHT+IEfTwsWcFCTwDnc/V7zN6ysPIDX3sfVxtdpYeKil4GEoDzJsTyfI98He7DJmryqH6XCyrbXhCHq8rzf6fIekmY=
X-Received: by 2002:a05:6e02:1fc3:b0:3d1:7948:faa2 with SMTP id
 e9e14a558f8ab-3d2b659147cmr214465ab.7.1739907165084; Tue, 18 Feb 2025
 11:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213230009.1450907-1-howardchu95@gmail.com>
 <20250213230009.1450907-11-howardchu95@gmail.com> <CAH0uvohY6fBaJvMZNi-fcHEW1Dw7Zp5Q_+ZxNgcaaFary-3sWw@mail.gmail.com>
In-Reply-To: <CAH0uvohY6fBaJvMZNi-fcHEW1Dw7Zp5Q_+ZxNgcaaFary-3sWw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Feb 2025 11:32:33 -0800
X-Gm-Features: AWEUYZmlcbrhdtnqBx4nDEFcPghfTNjaARpHHQeifLksN1EV1XK28ErudeI7wD8
Message-ID: <CAP-5=fXae_851WezB5rNkv6cp2DfAWobJ-cbehKy3eiFe8F9Ow@mail.gmail.com>
Subject: Re: [PATCH v15 10/10] perf test: Add direct off-cpu test
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 3:04=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello,
>
> On Thu, Feb 13, 2025 at 3:00=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Why is there a --off-cpu-thresh 2000?
> >
> > We collect an off-cpu period __ONLY ONCE__, either in direct sample for=
m,
> > or in accumulated form (in BPF stack trace map).
> >
> > If I don't add --off-cpu-thresh 2000, the sample in the original test
> > goes into the ring buffer instead of the BPF stack trace map.
> >
> > Additionally, when using -e dummy, the ring buffer is not open, causing
> > us to lose a sample.
>
> Just noticed that this commit message is wrong, should be:
> """
> Add tests for direct off-cpu samples and --off-cpu-thresh option.
> """

Tested-by: Ian Rogers <irogers@google.com>
```
121: perf record offcpu profiling tests                              : Ok
```
I'd be tempted to keep the comments about why 2000 next to the actual
code rather than in the commit message. In the code the value is 12000
and not 2000 though?

Thanks,
Ian
