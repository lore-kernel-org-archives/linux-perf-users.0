Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134DC1DE2A6
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Dec 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734764934; cv=none; b=T4R3kyNBPHUr6uiwX4fNnjRI9C78LTagYj2XhfV6pJMTGoSLakmRNk5I4QoA0AIYrMZPVoaOCE5vyRdYpP4xixomBggGOIcot2pKwRpF5tUkG9Fz1Ihyo23WaanW0LwFE9zPMy9Tl3CY2lPbz8rJxWEhC3GVRrYjOVYTT9qxq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734764934; c=relaxed/simple;
	bh=l7sdnc4zJqQvgRPH8NdWf6Pjl0zpUdwLlJB1LhETfyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGXvoI+hZn8kv+xlGMThH4I9nN+FJNsR/PbeA0ycpy2tdY14IHYcq1qb0Bk7W3puNUAy309QyQI0IuhVzSnlY7iNRwbTTwPYOye7GXlWEPZDCc6pjX2huvh0ZLqbH5oagCrp0fBTE6xUwW9MOMbe4X1KnXIOarJk5Agkfhvlr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yz9jFYTD; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yz9jFYTD"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a814c54742so300065ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 23:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734764932; x=1735369732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZbb5p0xPzeHHPObuSqGw/aRNG60itRHYe1Sf3RQxIU=;
        b=yz9jFYTDUkKKInnRcFNr5PjtduDK/GN1m42YFNtqtZh+6oI5AkNz2QJ/HnpkOSXLBP
         kqqU+I7CWc0TSwv/QiRrC9g6Gm4Grz6fM/+WVsc5HQgDRlqhln6JXnDkA+EWrZjBI03c
         ogjop12+le/wX2q8DaZNuqUwNcqVonVCqpzBRN6EDi0b3PzFhNhT9+oDqSRnUyECai07
         cXQiO9mY/HDSAYXnkNdYEznoO0MJ0I50aF7tmUHyqUfWMFBZOnm3iAmNgGbaInbofFHX
         vHo6LVDEiElDpug/XBkpcpegmN/awW96tlV7q0mjXgHeafFxHY2OJXh90Yf+K0YKzMjR
         LShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734764932; x=1735369732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZbb5p0xPzeHHPObuSqGw/aRNG60itRHYe1Sf3RQxIU=;
        b=e9YB8g+Od+Id6AVNYPZFd7KnHat4XAkTNs5xcw0HRGp1fTSakvfWTIMvXAmBR+wzfi
         zWKAy1UCJwfjIAnEDSh7VX3CqZkzbLF8B8NUH+40VYM8vG9t96BtaXLmOOQTTOS+yjWx
         0Ebm2AfF6Keqcrhc+MdNsojJGJ2PBwdt7ocRtT4VpAH/tcObTSnBJAnjTPx8rVjnTgfE
         aHs8Bc/+qZVP6dYhj9C3P2wmyUmwWXKYnRa/AwdkYYZAqZiRqYizMhdhjg3fcx2YZpLj
         lQ4KPNfrK2IU7mBPti/FpWC4NCzgTQMHUIDACZ+IIfuVgqg4njxaLX+vSiN67rI5yLN7
         hNyQ==
X-Gm-Message-State: AOJu0YyBbr5Rn4RxE96SqetYUviCKNoo/HCWAy7+x1BdCefggHA2uFUv
	ACyP004PlcgiiVyLe6jnHoJmGhfCh/kLksFTNxvHTOJeVY8Ut+NzcVQMlBtsjQWRq9OvGYwAeN8
	r7h79GVVhgP0cIZx52yRjA+3RIK0U+5kgrKo8
X-Gm-Gg: ASbGncskKvGv9aqdr/QzzKWxoIO+x08ZHyQR6KTuXB4q4hFyY18IEGZ+Yo+i+wgt78c
	aIyA41kfilx8qpF4CC4jMGfNdzeiN1ot6pL0jUpo=
X-Google-Smtp-Source: AGHT+IFIp6EP3Zo1j7yKUa/9N0SCgITUMrVQG+PhRggHWpRCYPUhCTmBaRTOPWsFoHlGXooBmJl1hvpxlZf18kANErQ=
X-Received: by 2002:a92:dd08:0:b0:3a7:cd62:7a81 with SMTP id
 e9e14a558f8ab-3c2db92c6c1mr4606135ab.0.1734764932062; Fri, 20 Dec 2024
 23:08:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115161600.228994-1-james.clark@linaro.org>
 <CAP-5=fUq1JLCVLQerQbK+itNg2RZaP9zCo9RUTgKoGqTQi3yYQ@mail.gmail.com> <ZzjyVgnEUOYknN1k@x1>
In-Reply-To: <ZzjyVgnEUOYknN1k@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Dec 2024 23:08:40 -0800
Message-ID: <CAP-5=fUDnBii8T2hH3o+J=DXMe7xxHXP7Kno5fz4OjBestObwg@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Make leader sampling test work without branch event
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 11:28=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Nov 15, 2024 at 10:54:43AM -0800, Ian Rogers wrote:
> > On Fri, Nov 15, 2024 at 8:16=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> > >
> > > Arm a57 only has speculative branch events so this test fails there. =
The
> > > test doesn't depend on branch instructions so change it to instructio=
ns
> > > which is pretty much guaranteed to be everywhere. The
> > > test_branch_counter() test above already tests for the existence of t=
he
> > > branches event and skips if its not present.
> > >
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks, applied to perf-tools-next,

Rebasing on perf-tools-next I see this failing on my Intel Tigerlake
laptop. An example script output for:
```
 perf record -o "${perfdata}" -e "{instructions,instructions}:Su"
```
is:
```
            perf  352917 49604.160314:          3 instructions:
7f155caca323 [unknown]
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.160314:          3 instructions:
7f155caca323 [unknown]
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.160317:         18 instructions:
7f155cacaf3d _dl_start+0x3d
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.160317:         18 instructions:
7f155cacaf3d _dl_start+0x3d
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.160319:          3 instructions:
7f155cacaf44 _dl_start+0x44
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.160319:          3 instructions:
7f155cacaf44 _dl_start+0x44
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.161099:        120 instructions:
ffffffff8ce00080 [unknown] ([unknown])
            perf  352917 49604.161099:     181013 instructions:
ffffffff8ce00080 [unknown] ([unknown])
            perf  352917 49604.161115:       8811 instructions:
7f155cad22d0 strcmp+0x8b0
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.161115:       8811 instructions:
7f155cad22d0 strcmp+0x8b0
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.161130:      10483 instructions:
7f155caba508 _dl_new_object+0x198
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.161130:      10483 instructions:
7f155caba508 _dl_new_object+0x198
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.165156:     177355 instructions:
7f155cab90a4 _dl_lookup_symbol_x+0x44
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
            perf  352917 49604.165156:   13313598 instructions:
7f155cab90a4 _dl_lookup_symbol_x+0x44
(/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
...
```

Dapeng/Kan, any thoughts why the counts don't match for instructions
but did for branches?

Thanks,
Ian
