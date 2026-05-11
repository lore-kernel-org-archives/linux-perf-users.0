Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150847B42C
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523748; cv=pass; b=QPndRY+FEZUtfGtdmqs2CSe8TVTOuPliZDbLEtRXYSG5+K0K433L8yt4lERkASg9tmfIGqtcNsk5tXly+J1z5tNG657JsKRyC+mIolMGNCAsWoT0PFzHDST6z/pew9NRwQgeLAZBmJvnsnEzp3uSXr74JCFgfiju79SeqGAdCvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523748; c=relaxed/simple;
	bh=wYVAlFQtmiFz2qH7X3ZJjrwKGWkW1EPsk3fHd01+JvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWMU1dkanNIwJUy+SbBY/XdrMS1XJeK3BO9yEvMxD8/PJl3+e9VFLYNQQjJZMnXFf5hHKygNuYx5Ac3RxvXaRP/OFuDAIyPN5nB8BH0YMpQTsHVO2qOOltekHl0trhF5muP/kN2umgnbc6x4m8qpsLjAx5nlvm01R2a0WKGye8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZ6asChP; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZ6asChP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b46da8c48eso3185ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 11:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778523747; cv=none;
        d=google.com; s=arc-20240605;
        b=XWhzZviOXAv+FS/qbnJ6fzs9odNlqmDR1riyQGu0Q2NlqS1mG0QW6r3iJUa4hU+gyW
         fHBt5ne7cSTvDkbBXuCQb/6XaFTwR3PS+DFa/nuXOQrv801TCToPKyVB4lFUHmAjvEPW
         GRwq1DBP5a/FBsGpWXJ7XWr1UxqJBDKFozUceCrk/S4cOe56JrAarJmhwY5LzIewcA62
         BbofUdEqp9xyolalm5mIoMD3IsvKmFM3U8NRtwcb4k3uBOqpnt403oh1TACZj3jyuUDm
         O8GLIbs6R8sDYftQ3uHerUnUTB+CQ7z8hbXqaWcsyZ0TZ61t99uRpPBm+cJJPLNPj4yw
         xeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZLIRz0NwHR3NnqATUTMjZdPNjAg8JVum3ByMqOI0yC0=;
        fh=yS+4oLO6K6kGXZW1tLNIdUigWCD3c+xPTqyx0Yy9ivo=;
        b=CiLo2HqYEEhRq4NybDosqjBlyS17Vlj7kk9cRLtfwKNVgrescdV7qxHlyrPmW/EbK9
         ggFz5pm4uouGBmYEy9NSVHrmrDc077NOHefRy/5iZvnXXINNvXEbXOekRCMpgmSUv1Zs
         msPSdVjTVLvIGUSPjLOsvNH8RjkJMS8m2LPlqMZWUgBDZnnlTQhScvSWbgbThz8p8XHf
         vhahaENbNWeIwEm/qhuSpKh1Toqs/LZ9DaLUFkGfpt0iFWMuWww4PTnj2BTwc17p4MuN
         52SBpSiXImqHfIcEiEqtBoonTkeACFQh6plH1jJZ/5AWdYlACoI8D00awhCUuI3Xgw9Y
         LYzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778523747; x=1779128547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLIRz0NwHR3NnqATUTMjZdPNjAg8JVum3ByMqOI0yC0=;
        b=QZ6asChP1pwudlP852zB/3QKw1GQdWIAfU1Dsm2KmB7tKif4MlbYfMBZACz9tygVnL
         dBoQ18WviOmKZIZDKBKBwKOqjrqlG49FutHgtgh7KQUlHsYPEuLCwg+BHQRVUwsjN/34
         vBPe/HOsaErsv/Bfua4X7ybXmec39w5WBNKCQW5WxGoa3FNRm3xxERhWunfnpEM1jqmd
         8bPqvUDSZenQlHfoU8qIS8C8VDuVZwlDAd+OytUaLRyyDP/lpvCrULFcin2GDu2wxkUV
         XiY9OfElZDmL3eIp18MBDQ+JJsU4NmhqCZKuJbLCjDeAVYj5U82q32HKtwuR1FQG6l1P
         Jjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523747; x=1779128547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZLIRz0NwHR3NnqATUTMjZdPNjAg8JVum3ByMqOI0yC0=;
        b=hp0o30NZu+3eaSCCxoAOsyN5ophz9ReY2Vyo83Jtm7NT0WHsZLKHRWvOYGZM20TpjG
         HT8mJZWMq2+KqEOGCIj0G14BBdxLepsT7qhzstg+cJCBD6BE2aitVaQF6csM6KqIIALa
         n26jDDejzuxErgzC1R78p0NHr5jQme5ChYTDZACraEXQV8ijtB8IvHDmJg9w6sPOVyvL
         IUDRU3ORTnJuo7WMOiFMijzyFkTWOzA358HudHjSidJfjsFx36QGc6wh45alFmhsngAJ
         obEv7/CSXnxTOh/usy09qHgW/MgwkGMBf7WK9nlWSwct11scf1AOHroDEcr69fRJPDLU
         Uxxg==
X-Forwarded-Encrypted: i=1; AFNElJ+Y9xzorq9hPLp5ZO/FuWAioTHFtCg3i+wPsDa3VSSAjpPo3SlZH6ObHmDAEaPJk2u0OebpX2l1emdVJ8t7PmUY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt05YPFpeBej3eMCv9u83nv5uYgw1MQoToj0CZ/aiK/DrNqcoD
	pf6A6iK+pYe24n2+tSZUCAY0rynDCDPjNWJjTa0rH7FcLtXYNYhcXZk7shOpPyjnY3nUURRZd5w
	qPDzdB/Nmzka3JZOzQxcAsznslaG1cJNoUt2AM7+8
X-Gm-Gg: Acq92OGeODuORlYKehg0FUbgzMBBqxebj/Yb43m032KceD6u3IDsDNfcTjCU9rVVGUG
	yCcDES2EpAYNHUknxJw9gp49kCaSnbeC5b3Mr/TVz0Xb70o0LJbQuQhsuP4y7xvtgbmoefyGHkk
	eSiXaBV1TxqIibmK2LsZgqLPt2sKlNigLq7A/C+Belmr2KsFf87yez0qWeuDeByxbmDlUvr7LHn
	8Ts7u0ab8Uqv7wNB5EUl64SdDBbdhtIxpJ9jLoWAOQDvkT4/wpNSCEGggnUtxHJ41VEi8nt4miU
	CeZBNWk7UEJGXQfJ32IvGdeshqhqNQNM1RoGZbg52RAb8qpeD+3niZOW9/g=
X-Received: by 2002:a17:902:fc84:b0:2b0:be7d:a25e with SMTP id
 d9443c01a7336-2bcfeafb836mr502945ad.18.1778523746071; Mon, 11 May 2026
 11:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510202346.49853-1-namhyung@kernel.org>
In-Reply-To: <20260510202346.49853-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 May 2026 11:22:13 -0700
X-Gm-Features: AVHnY4Kpg8_PzF6GO7RgKmRuYXncioUyp10BuszlgAbdMvABbYiCw2dHdSJvmL4
Message-ID: <CAP-5=fV7QanW0cu8KBOR5LmCuAEa+eZdSOussQx=dZMkeGb=9Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] perf build: Update kernel headers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 1:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This is to update copy of kernel headers for v7.1.  I've updated ones
> in the tools/perf/trace/beauty/ and left others which seem not to
> affect perf syscall beautifiers.  This is suggested by Linus to avoid
> unnecessary builds of objtool and the kernel.
>
> There are AMD IBS changes that are directly related to perf, but I
> think Ravi is working on it with other Zen6 changes.  So I didn't
> include it here.
>
> Due to the header file changes, some beautifier scripts for perf trace
> are updated too.  This was detected by Sashiko.
>
> Also I removed the header difference output in the default perf build
> and added a new make target to check it explicitly.
>
> Thanks,
> Namhyung

There were some issues with sashiko and the reviews are still pending:
https://sashiko.dev/#/patchset/20260510202346.49853-1-namhyung%40kernel.org

Manually looking through the changes they all LGTM so for the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Namhyung Kim (7):
>   perf trace: Sync linux/socket.h with the kernel source
>   perf trace: Sync uapi/linux/fs.h with the kernel source
>   perf trace: Sync uapi/linux/mount.h with the kernel source
>   perf trace: Sync uapi/linux/sched.h with the kernel source
>   perf build: Add make check-headers target
>   perf trace: Add beautifier script for fsmount flags
>   perf trace: Update beautifier script for clone flags
>
>  tools/perf/Makefile                           |  5 ++++-
>  tools/perf/Makefile.perf                      |  9 +++++++-
>  tools/perf/builtin-trace.c                    |  9 +++-----
>  tools/perf/trace/beauty/beauty.h              |  3 +++
>  tools/perf/trace/beauty/clone.sh              |  4 ++++
>  tools/perf/trace/beauty/fsmount.c             | 18 ++++++++++++++-
>  tools/perf/trace/beauty/fsmount.sh            | 11 +++-------
>  tools/perf/trace/beauty/fsmount_attr.sh       | 22 +++++++++++++++++++
>  .../perf/trace/beauty/include/linux/socket.h  |  2 +-
>  .../perf/trace/beauty/include/uapi/linux/fs.h | 12 ++++++++++
>  .../trace/beauty/include/uapi/linux/mount.h   |  1 +
>  .../trace/beauty/include/uapi/linux/sched.h   | 17 ++++++++++++--
>  12 files changed, 93 insertions(+), 20 deletions(-)
>  create mode 100644 tools/perf/trace/beauty/fsmount_attr.sh
>
> --
> 2.54.0
>
