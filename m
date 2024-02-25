Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694B91B800
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Feb 2024 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708887072; cv=none; b=f/aCQ1kJTY7FpN/9Th9NPcn6JJau2TbbhfZsG2FYxNchVntTCvriuQDMCGCxvODfGGTOfymcj9+PAwLjop/psuNx3ks4znbdDlOj170+kVwr+u1wnhoTVa6rWBmovF4BUIzLRirOSKfrI8FXDRLPt1BeZuScq6VDkRXOAraOBjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708887072; c=relaxed/simple;
	bh=GcjXzUspWJyHWnXifYzzK/sflMFCO8s+VX1t10MLqac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fMkPov+L/t7ifqNGUCIqdhmkNsnLF65OVM37wnFkaZn7fi5agC6/yn/47f45WjPzcyd59JP4Kb6mjfmfSkFw8eKUER1Fw+ihtaZ6TOmFhFe8BR0w1ivpPKoAHp4QGMZbiPg21WprSl8UfjRM56MK3hvCLDZD/lhHGZYUCtTUV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8yCu0fr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8yCu0fr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc744f54d0so165645ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Feb 2024 10:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708887071; x=1709491871; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7KE24MU9eBDBjtTNbfc43uuaCFDb+3UMGms8jPvzDQ=;
        b=d8yCu0frenTOD+F9N7YYvm6/YatnRt6BJy0ft7ukkD+ibLUjghcBSK8UCExwF2aPAw
         WsAPuRFtayq4z/IxkinNvNLzPXqybsNC6PDHn5AG0MqqS+1pnjbuyt6PV7rrozGSx87K
         wG5gotrtq/ei3kEX+RGgZKIDYxk/TzxpnAuWFRQTEtpgR62ODYg3GsMFh/gsXkBiLvfG
         0J92vH5gjIcUI7A25ooeI5QnLNWgMhCzBIt6ERmp+LcMpNXsXpD4Gg5UXz0/nMQspm7L
         mIvhAlmqBWu4QP9PFH1ZdhE+YQxFF5ZHyt3LPQDWi2NceL0AauNo+a9f/wL9YfUdOZIx
         neOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708887071; x=1709491871;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7KE24MU9eBDBjtTNbfc43uuaCFDb+3UMGms8jPvzDQ=;
        b=CKbmqO4WhwKbrT1P5YJBe+hJkNclD5y0Ip22uz/bESFcERzye1bIqKM0TcM4nFJVTZ
         aJLAB21pXSZEMKUUeKDYjILNnCp5HwUO2CDvdl4/yRa0LwVOqYfFRBcHUpXVlBuzAiLo
         TSSH5mbcH/aWkE4d8hifSMobs2oZ/n8EJ3brYSDwt/wwoxiiqH31dqRV6NAr+LWUtU0Y
         yaT18o83MZQ6aRnFZ4n9hGfw/Ku2qCPR2sxGtQ3t4KRf2e5TmznzQ/iYthiHTXGL+6Gw
         wCDIh9IE/WmqOIobb7L2+AYeiNINvFFhDWLvgG56csFODkQQEIQkVe5OeaPpbQBUap7U
         CJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUFhdYyMAbfdCZC+DzGaamr296ScwDYHg4pPNw+FyciRZQQSMjuDGwA9a9gZDW3wGlXaMH7eikxToRAR1UrCVvE7txriV4o6eEKeFk2O2JqWQ==
X-Gm-Message-State: AOJu0Ywvt6nlLSyP53V6YiwtPBMxgE7SBkp4uKRp5tfcs9jLZDpr52Ui
	OGUAw/LEZ5H4uxk+UHehuRptrUeN9vYwiN0bJJ1rB21cXvjAOFzgKHmgxcXFH/bLojBQxJ2E90r
	TNAn/tBwn1hkNAEIR2N0NB/Zq9urvJNQN9tG9GWrtyu9aKY4yK8em
X-Google-Smtp-Source: AGHT+IHlyeuRMm9XjLl4GPQEhwwJdCgz/3HCmZEfXLKbYFWdnA6DoDHqOg/2Z0w5L+na/YNYO5L72bfgxGPFrVwl8Sw=
X-Received: by 2002:a17:903:410c:b0:1db:90e9:43dd with SMTP id
 r12-20020a170903410c00b001db90e943ddmr237497pld.22.1708887070453; Sun, 25 Feb
 2024 10:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com>
In-Reply-To: <20240214063708.972376-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 25 Feb 2024 10:50:55 -0800
Message-ID: <CAP-5=fUhK9FaP4c5sSsM_DdNB+MipEvDDwO1e-n9fK5GLn87wA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Thread memory improvements and fixes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> The next 6 patches from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> now the initial maps fixes have landed:
> https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/
>
> Separate out and reimplement threads to use a hashmap for lower memory
> consumption and faster look up. The fixes a regression in memory usage
> where reference count checking switched to using non-invasive tree
> nodes.  Reduce threads default size by 32 times and improve locking
> discipline. Also, fix regressions where tids had become unordered to
> make `perf report --tasks` and `perf trace --summary` output easier to
> read.
>
> Ian Rogers (6):
>   perf report: Sort child tasks by tid
>   perf trace: Ignore thread hashing in summary
>   perf machine: Move fprintf to for_each loop and a callback
>   perf threads: Move threads to its own files
>   perf threads: Switch from rbtree to hashmap
>   perf threads: Reduce table size from 256 to 8
>
>  tools/perf/builtin-report.c           | 203 ++++++++-------
>  tools/perf/builtin-trace.c            |  41 +--
>  tools/perf/util/Build                 |   1 +
>  tools/perf/util/bpf_lock_contention.c |   8 +-
>  tools/perf/util/machine.c             | 344 +++++++-------------------
>  tools/perf/util/machine.h             |  30 +--
>  tools/perf/util/rb_resort.h           |   5 -
>  tools/perf/util/thread.c              |   2 +-
>  tools/perf/util/thread.h              |   6 -
>  tools/perf/util/threads.c             | 186 ++++++++++++++
>  tools/perf/util/threads.h             |  35 +++
>  11 files changed, 464 insertions(+), 397 deletions(-)
>  create mode 100644 tools/perf/util/threads.c
>  create mode 100644 tools/perf/util/threads.h

Arnaldo/Namhyung, anything outstanding that needs addressing in a v2?
I'm looking for reviewed-by/acked-by tags :-)

Thanks,
Ian

> --
> 2.43.0.687.g38aa6559b0-goog
>
