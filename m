Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D293BF300
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952575; cv=pass; b=uZ5aUxir2Nw0ZFaT2V//H6GHEFpsTtBdgLTefOBnACAfKOSwMDUPHBGJcj4ZvfvMqR2B5jmwzTl3JDJmuWOOSv8p/Mvo2L46k50JroBCD3hwrZ1l834tSrG26h7ORn1lczbIcDMEDNF9vUwkRYYPhMmMzYWE4qN7G5OsLaRakiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952575; c=relaxed/simple;
	bh=SldJ3HjHbTz02h7U7rX/22P8ZHHq7Suyfnmg2OIMe3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YadKlYO6pa3SDobQjewo58XUy34jFdqY6HkFU/vr9capYBJNKZQ/eQAzIblXwaF7UtK1hywcslHycURrZwBLhmzzKmc3iRCO1a/kWdSR18NbgwbH8fOqVjpsq6dGcCOiTuKxsNNvEpabCjvOZX3cmPsQ0jMctR9cF4scdOeUGWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KuLv0Z/9; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KuLv0Z/9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a1462573caso32315ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 15:42:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768952574; cv=none;
        d=google.com; s=arc-20240605;
        b=FuL3MC1DLxmmSMU4ijRxo7kaou3hyMxIPBc/rb5Y/isnMzoHAYuszwyB2uNsjECSx9
         gFvbR3kfJAGLi/PVUWt9KyG1IQalw2Lq5MKav0NKc3FFUCWhOYX1LBtMUGeIKpTn9y7N
         oyyEu2K99Z25kXurkDdFSnEr70uZo+4SkYn09RQ2jPSQjt/+1pfy6OA1BruFL074mdkM
         kf03X/g79BiA5Wa5u0+dFWBE/oiA8cGJs2BGCYXfV4Aalm4moDlgo6K4eixD2l7Tyid7
         eKNnZVCKP0JtSz0yOREYtW5G6eKFoJLGbDhOQuFH2yX24s4rtoDXNGWa/+0hfpMc4Cfr
         i9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=brFb5VILNgoYRJ/7g+e7d1bEif9GKKs/wY7a7RPGr98=;
        fh=yPj+w9kLMVUsWCHD1+xiz2fhPzNQSZI2+vKAmNvBQ4M=;
        b=bJcHWMAbyhzt0w7m2l2Th8Bbj+1f9XmBztNhIDskeu66Rc6WMd7LOAYHNwgdSDnAFT
         rdFZsVoO/PBz7b9p5SGY6TnsVO3i/Lm5L9V6voIwb1jJkPMlUt47/ofPkwxvnaZDLP/w
         v11CYuI3sXm9pWjfkeW5IEW62siBugZoccN2CNb991xO6RgknC4wkM2IaNxaNFzWrG8X
         5elz0OvK4ERlzyCdSq3xi86flGb0CGqL0OIdW2TAieOMV7DkXsoXD9O5KSYeMP+MWCYe
         2r7tjyVFTDVpA8BKNOGayL2FrAhWMpT4ZFi9/oBMXD8UNYCMWxaDASTwcOJLILFyoyTY
         lk1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768952574; x=1769557374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brFb5VILNgoYRJ/7g+e7d1bEif9GKKs/wY7a7RPGr98=;
        b=KuLv0Z/9e7XEMauys7YnSDO83RXXu1vpMEO+HfMZdpb1LNK2xmOZReCJ48I568WGPN
         KN9iMl5FjliUf+NdC/DVMgVJhTFYBd3rWbAyHz01FBHGAtTFuUZyyzIxBFCG9J9h2j4I
         RXPrL/S1DUudQr8Mmk8+h3oDD75fs0E+GsVkwgSUZGkLBXptKK4RYiTjnzrovAogjTFM
         Aysg68GEGZTAHwxKUmBS6cb4iHcdloaNrjMu8PmCzZi0CoZpOxWhTR7dd0vzQLTemOG/
         A3X5qlMif/Hq4PCpDpbaORZHX8oK1aJeuaerD8Ipe5So3LHJeXEdX3Xcj6Sy5HHoovyG
         ZNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768952574; x=1769557374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=brFb5VILNgoYRJ/7g+e7d1bEif9GKKs/wY7a7RPGr98=;
        b=Rram1yxhbbGbdXth3Wju0JpIESwxjIWKZH+tX1vuYf3ZkjYYiV8/O/shI1yBv3gNyF
         kAm9HCiYhZXH2ataEgIMZas4AEKHbYsqXqgefuk5vpUnqVR6GknTGXfHUPmr8t+DTp47
         DA7V5LSM/bp6Xup1Y5McStrqUINiC3Wnm4mU3D/zWZlRD9+zF7EvEUZKY+Gc/t0YV+ul
         4rM3Ka1EJ0aJ1xCjOmvGlQeA96s0cQ3Bn3EHo93plkplyorPsXnVC5QgcYth8tf4cNGc
         s+DRA8Yg1f9k6myKCDWtJ66SUqV0waeqBzSXQv9SEbwaCS2I/mH/vhKLaUXjq7xgyd0Q
         jZgw==
X-Forwarded-Encrypted: i=1; AJvYcCVdQJRY55dMx61TKRhsEl8bhDE7RDaDpmjKcoP9oJ4iJPkJTlkOU6bWxfJIfAWgLS+SouoD6DYZETFen0xnAiu3@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9rxTv+T5xXAxLlUmWU8MLc//eXIKj1+4B6nwdSctlWTQYCze
	x1GAU0uylGuskkrpAXf0dK88gvxwnL8IwTMzKuKdAWJxFSoLoFeD06GShcg5V0B1eRvP7vXlwcR
	3227STxkctU8Y0dfoOFj3V89DNIHCkgTk0nJnv9gH
X-Gm-Gg: AZuq6aLZZm4dg/Bg7C3dctYkMaQcv4GYm57EGIudFlq9y3X8KARsUDjddmmI5TFJ0Fg
	joGahApZB62MRuDcCzNatLhrI4mjutW5NbgHR2GIERFTxma4qg1TiXpSF2bpJ/zuLI/2GTUdmoL
	ueSI2JNgSN2rxUnEddbWDcEVRuNI2Qy6d7bNBDPUwZmJcDwZTqXDAyHgGm6ZgeOip492t7rxo9L
	4vBMocGkavxvc8L2puw/1/QCyhXf8l80T5QOLVkVUeTaHrPgWIj+Da1g1kxHtDHQ68Fk4kvDh03
	VvaZB1A42pEnuMw+FLEL+OUJog==
X-Received: by 2002:a17:902:fc86:b0:29f:f71:a3b9 with SMTP id
 d9443c01a7336-2a7a243e352mr723295ad.5.1768952573592; Tue, 20 Jan 2026
 15:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120220900.366451-1-acme@kernel.org>
In-Reply-To: <20260120220900.366451-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 15:42:42 -0800
X-Gm-Features: AZwV_Qg4sT8BhTIHAEvM9NZlSvB350VA7byBaUawlxZECK3pKwZkCGlBp1M7L9g
Message-ID: <CAP-5=fXK-owoydNf0_AYFhNPnxAgoy5G9smQ6+LtbrUh6W2wDQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fixes for gcc 16.0.1
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 2:11=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi,
>
>         A bunch of fixes for recent gcc versions,
>
> - Arnaldo

Reviewed-by: Ian Rogers <irogers@google.com>

These look like the least bad resolutions to the new warnings, thanks!
Ian

> Arnaldo Carvalho de Melo (4):
>   perf tests sw-clock: Mark the volatile tmp variable as __maybe_unused
>   perf trace: Deal with compiler const checks
>   perf list: Don't write to const memory
>   perf list: Signal changing const memory is ok
>
>  tools/perf/builtin-trace.c     |  2 +-
>  tools/perf/tests/sw-clock.c    |  3 ++-
>  tools/perf/util/print-events.c | 15 ++++++---------
>  3 files changed, 9 insertions(+), 11 deletions(-)
>
> --
> 2.52.0
>
