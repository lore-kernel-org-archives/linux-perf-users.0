Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA3153838
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749788; cv=none; b=noR4yLB4BYKFSqYv9kc1TlM2cYHv0fJuC0Fdd1SVjANeUwnqxs3PxyGN4ikWeosuGuiAGc64cQkXRNy9BkFuoXi81z1d3yaDRaaE3qerY5ouMORSHCoPhOWWBKvLy/wFKp+xPRTXv4Ui01R3ZvDoCUgG+wPGRJYd5kXkhT1V2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749788; c=relaxed/simple;
	bh=X4Nds+rNamt6o8AZtuKA3sluusWdlVXyP8txbmaaq2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUNQP5UXP9SrjjyUsvifQ+xC5ZF331Isfg4ehDRcTzKXsBtjgOVQfKR1C0g11oO7y6Q9iQuMY0kU7Gr3ILLhiLG+K2tSvkNIWSA4gk4KOlRKREH1Uip1W4YIJPgZW6Uy4JJYnW/jrE/WEZLEOPw7W7uPhQkaQ/AT7wgPPH8Jh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEi5Rp5h; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEi5Rp5h"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-38b3543541dso174745ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721749786; x=1722354586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4Nds+rNamt6o8AZtuKA3sluusWdlVXyP8txbmaaq2k=;
        b=GEi5Rp5hlu8rUR4ZQZ+tYk3kln1qTtfAFIsSKIScH3CbhoaM7neJwVFXmRr1QkKobW
         CQce6aq/5dVhTFD3E4zi4qY3JB9mfQdCJZvfK2ChqQ/KRsvs8CpVHryCg4Y4TSKtEs/c
         nup1JLvb1ReG2yE4X7AAKIvExRSxBQ2Sgar6ap2860nbd+oAWvV/svMZpHq0i3EQhZPl
         vnNhBE2BBs02mNTfjUGsfExJeQ2ZMqakDT5esMO/mvTpJq7D+vrIDcoWPSxn3E376LPL
         0Vkl+WwnQVMq5CdsJroIf5QtT8BxkxgapNji47xbyAzce4eI7zuenqoIMc6rdR/Z7JeN
         APaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721749786; x=1722354586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4Nds+rNamt6o8AZtuKA3sluusWdlVXyP8txbmaaq2k=;
        b=l3j1YCJBJ5ccZzbN0r9JzF2r0iAAm3RoxQDNobyJH5riKgor2xyXqiHBK2kzg5fab8
         LiGnuH7DWmzsYOEEnZKeph4K6WOJT7MLhiSn+YPAllqWvAdC7MrNpWlwj3DF01NyXlDe
         aBtD/0FfMWyYiowmTTWmXLqzGH9mbZDZMxmaXEeQq7mdhHaH6KLhZt7VIQ2DJcKTa7o9
         9bxKJpiSkBe/r6LW+uLzs2OohLV6d6R0ArT14x/D3/LKsTK1Y8sYrMPseV2ZMgL0Ubnk
         tdgWn3VMrXrS2wWPmgwdWbhbFwTrzabC6Q6wbbxVQ8EPUy0eZsJn8MkeWIA7WDV699pr
         2qfw==
X-Forwarded-Encrypted: i=1; AJvYcCUZYe00ll3BBooVgbToBiF9fPFeW0+24+VVMAk7O6pPQ2nQpmU8Ck2shqw3/KUvBanjAPW0Gc3UVw28jcc44QQt79A79IeGQrXXPbfbT8/ySw==
X-Gm-Message-State: AOJu0YxaQKx58UXBfZ25QRw6Z5qCQ91se5nycKB9MG2sBKXi1PpaR8gn
	A5gxyzi8uWyKPCd/P9Qmj1P+f493gqygjbbhrVljfexLe5rdSEE1dWP9Gk85L3TkKO6xqnBiSky
	zRLAc0Fw8g8UdNpEUr8DFjW+PHCIyzTG1tFhm
X-Google-Smtp-Source: AGHT+IFl0/VkX8PPNjlbtADQKyQ/N/HUEAfW/C+NwrwOVp90LbkPlP9cOIo2QjN4hq5sYZFANiFih58z927cWGi+zQU=
X-Received: by 2002:a05:6e02:18cd:b0:398:fc12:d70f with SMTP id
 e9e14a558f8ab-39931f3b179mr9948205ab.0.1721749786256; Tue, 23 Jul 2024
 08:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720074552.1915993-1-irogers@google.com> <20240720074552.1915993-2-irogers@google.com>
 <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org> <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
 <945e58b5-5012-45a8-933a-c1a192fd006e@linaro.org> <Zp_Ozo_Iyu1sgL9h@tassilo>
In-Reply-To: <Zp_Ozo_Iyu1sgL9h@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 08:49:34 -0700
Message-ID: <CAP-5=fXNvR-XaYAZrJKaX=nHU2FrmFKCYoX+UyEBv2=TNq4wcw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
To: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 8:40=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > Yeah I suppose it's strictly better now without the segfault. Could you=
 pull
> > in the test and update it to add -a? At least then that behavior will b=
e
> > locked down and we can extend it later without -a.
>
> Ian's patch really implements completely new functionality (supporting
> metrics over multiple groups). It isn't a regression fix, but completely
> redesigns the old "single group" feature.

I don't understand this, I don't understand "single group". I couldn't
understand the old logic using period. It is true in this patch and
others we've been trying to remove duplicated count values, such as
"saved_value" in shadow stats. Having a single value has led to things
being more robust, for example, counts getting reset in perf stat's
interval mode. The stat-display is still a mess, the stat-shadow code
is also still a mess with bugs in things like column header printing.
It won't get any better by having something as simple as a count
duplicated in at least 3 places.

> > I also tested Andi's V5 and still got the segfault.
>
> Yes the earlier versions worked, but they broke perf stat report.
> I think the right short term fix is to use V3 or so, but with a
> check that perf stat report isn't used.
>
> Then perhaps the new functionality of multiple groups can be considered
> over it.

I look forward to seeing the changes. I was trying to do a service
here as you were randomly jamming 0 in as an aggregation index and
hoping for some magic to come from it. The code here shows how things
can be wired up and it works, but just not in the way the original
stuff did because I didn't understand how the original stuff was
expecting to work. Feel free to ignore it and not see it merged.

Thanks,
Ian
