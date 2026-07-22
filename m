Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB578175A7D
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679245; cv=pass; b=XG/b+wtTTiyZ8X7l9zMa2rV1OwueHXQE0FG4sCx2tw5qI/Of7xQk7M+GvdqJnV+3BD/Lq+BDA4K/yIC9UEsgD6lklyeLhbSz5qvD/1SBW3Y72mIm18VKf8e2GlEazivZ3xhDNTf1exbxtgPBt6ALqTYThmdJRzdGhU1aY12nwCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679245; c=relaxed/simple;
	bh=C/D8WWprjznvdaRlddcoRXpEBfCjvDBz8OjRRAs8T0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvZjzXyJv10rvDeani76/E7H0nyr2/0p6OaDHEdUTQK/DRpQz6AUeip/1c6xxq+36fuHs9U1IQb2mWA7lJ+MiVdDFLzaMBEhmWYJ64cwhDmx6SaOWG9rHA8Ia3KCvtA2bGtbcmTVVG7wo/QTaCDsCRo46ygchvXvX5J7dFvxV58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhhMmEfC; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhhMmEfC"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c01c79467so1228111cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 17:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784679241; cv=none;
        d=google.com; s=arc-20260327;
        b=oGu7BPJvdPi/Fq8/lBShNmfDVIZ+bxf+NcU6nM6B15B7rl1IVX9yOIUJDD8r3VhHI9
         Td1Qk2Y2qh3NNPCUTwqJQ67ghnMW3A5SIYGsu/QC2KckwXURSEhbqSXjyB0vxhHcTScv
         ib+D6sTGhGeXztYjHOsXWldM12IIVW071k7eBEJzqBSlAzwn99nZeeTstD5Qa5d2IXJm
         JBYSZGMBCLfuNk4ULkDoUPujmDkes0nWCzhpgHS1OThIZfW5CXSv190mHYrKonGHBm4V
         b99K11YHtb93RJXkskMGszoRx28lbEaA37DMPVeKITvPZ7W6OUpAuriwdyF1Gx7YOWZC
         FfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Baqs4xKjOl8I56h16MWHmHxhJBnVX78TVT8v47MT4ko=;
        fh=yq1hPWWEl/5NM4sUs7pPnYfFVsqBmYngKcDCA+jYCQA=;
        b=cz0CWb6od6v5S5RVlq6ktk92eTDGq9Gnxfnlm8ZJf1BJqXYCxMfadnBxrDUZSWBmlR
         ZKs1k5y9ZlDiDpUJ7LsfzzKiqebqZMuhDcfsoqGyOYDb2W5FsK5b6injK7J797PlRjHe
         OyknFd9jxEZqSwjjVRwvUIWiYBgdq4gcxwE0rftknAInrbtwg3PizFFWol9jMblP6Jne
         HJ3oWGirTX6twbiauBR7jaEkYozcpCerM20juekr4ynIeFQ7JpZISMlseqTbu0Pj8Bq5
         wrmPjtJbdsy00lPhKgu5+J2lqGpNIPc/Z0BNprIPFfJbT3sfK8GsP2Muo6pPWOhBzOvD
         aVuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679241; x=1785284041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Baqs4xKjOl8I56h16MWHmHxhJBnVX78TVT8v47MT4ko=;
        b=FhhMmEfCAXKJZvX9FgyrZ8sKt9ZcELy1c9vv/JiJSZ+WM026b6WMUAD7DA9unTlipu
         DXMcUEQQI5zOGGkxH1fO1jSsr0tw90PcOy7NLmb1pNUE5Vde8ZqlXv3zy6Z79PE8+MEg
         +NPA8o7+KTQyUW7ZN4f5r4sUY9lK92mh6RTumes6bVihLLCR+3F7w3b+0gkj4XDpA2MU
         P+wV1ltqX5F9ho4oWpQ6kloOsMJG5NA0MSNePWHhno3WTdmoENsoSYgAhkJrf8mXiNCr
         uUZ6Z0HvPqCSK7mPtWbEXBy01dYctniOK310tJxvKJiIhJxI/wvnJhw0oc0DfALLXU2L
         Atiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679241; x=1785284041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Baqs4xKjOl8I56h16MWHmHxhJBnVX78TVT8v47MT4ko=;
        b=VnQu4hsWwjFbx3glOLZq0T4PkxBOGAwbsl8Or0maQIG6aDqn90hQ9AYYDKhoOByEyV
         fsWMjzl28pzZgRXSsCqwDCQeAsvcDOQmJY621g7g0mrOMJfUVazkKNPfXaEdprUCkaD/
         sXDlD5ugkpfpqM9eknBjYSoELV3QNbnox5LUimYTdZYsus9yBQ2mNGRIkn9KGcy+ILEn
         iDSZTM1iubQtU9zZ7pdMP56ThNETugYv+3mGkw64vQdTLUq7AlNSuyz0b90BhBpdYjC+
         huG57667GlVNP2KO9tzFGBopnH9PnhnVqtqOP6o6nxLjd+v8Dwl2+Ryzo/FrEB6jCzOM
         SYFw==
X-Forwarded-Encrypted: i=1; AHgh+Roak5kzj5Ag6Z3rsrW99n0b86Ov5XvTbXQALSxaArJHZFbhoba7cOKCQVfrGzeEF4r/aGx8BFCkPQh/KW1Y2ZsT@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8LmamGDD02tD6DAe8zy2hOnY6SLWXh3DSESOe472Ug76r5rh
	Lp4g8WR1Zkg2fPDIVFNEjWt51BCj4SzbkVgd2JQfbebY5kh26vFk+8cLhg8Ait7IXB6yziAqjKh
	ddtpu+N5gR0Sn55rc0DhivNhF3ixOKarnRJP5THEQ
X-Gm-Gg: AR+sD10qJLs9s6W6FrHXkpgkBRS0DChtxIjuiGC1tBl9MbG2iRNLeEIEVHl6x57Yaji
	iyPpzuwwyHJpUPdPFcXB32krzWYj4/uZ2wsUHamvBv+dGyNBtJZHNM3PUsIYIbB8SU9k1gTsxMw
	/0dqWpY+5oZGH7GQkKXDfBKm0dy+eE4Exg8sGLL3RdUzT+wnTj+2D9oXdM2xX3zIHm9YUJxt1B9
	sJegawDvTCjQVQivSMkINTx/k2yBqtP/FC+f92sVFTL0RhO6tvtpRYzrjt/ghvgICcmrh0uAw==
X-Received: by 2002:ac8:5d14:0:b0:526:d7ae:8eb1 with SMTP id
 d75a77b69052e-527efb1cb7bmr2327671cf.21.1784679240814; Tue, 21 Jul 2026
 17:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721230952.267754-1-irogers@google.com> <20260721235254.294053-1-irogers@google.com>
In-Reply-To: <20260721235254.294053-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 21 Jul 2026 17:13:49 -0700
X-Gm-Features: AUfX_mwcN44tVa0AqakKgrTPtgNnWQ-6x_OClX6H3v4uyA9-9O-xWpU7ZO7DRi8
Message-ID: <CAP-5=fVnix8Ho6gtciofu3eCoe-UnKPmyaaPf42B4tLTt7xR1w@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] perf: Fix and optimize maps parsing, boundaries,
 and bounds safety
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 4:52=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> It turns out that PATH_MAX is respected by system calls but isn't
> respected by file paths in /proc/pid/maps and /proc/pid/smaps. In the
> kernel "//toolong" is placed in the filename of mmap/mmap2 events
> where the filename is longer than PATH_MAX, do the same in the
> mmap/mmap2 synthesis code to avoid overrunning the event buffer -
> note, the filename buffer is bounds checked but this makes the
> synthesis more similar to the kernel approach. With Gemini's help try
> to address other correctness and overrun issues.
>
> V7 addresses security review feedback:
> - Adds a standalone patch (Patch 3/5) to fix a pre-existing stack
>   buffer overflow in perf_event__synthesize_cgroup(). Eliminates
>   in-place null padding mutation of the path stack buffer, calculates
>   aligned path_len using PERF_ALIGN, clamps raw_path_len to account
>   for machine->id_hdr_size, and uses strlcpy with combined memset for
>   alignment and sample ID header padding.
>
> V6 addresses review feedback:
> - Ensures Patch 2 leaves module synthesis callbacks completely
>   untouched, preserving the pre-existing build ID clearing logic in
>   baseline.
> - Patch 4 explicitly clears PERF_RECORD_MISC_MMAP_BUILD_ID, build_id, and
>   reserved union padding members in module synthesis callbacks to guarant=
ee
>   no stale Build-ID state leaks between module synthesis iterations.
>
> V5 addresses technical review feedback:
> - Clamps pathname buffer sizes in read_proc_maps_line() and module
>   synthesis callbacks by subtracting machine->id_hdr_size.
> - Casts member array memset destination pointers to
>   (char *)event + offsetof(...) across all synthesis handlers.
> - Restricts max_filename_len in perf_event__synthesize_mmap2_build_id()
>   to the minimum of filename array capacity and union payload space.
>
> V4 addresses review feedback:
> - Ensures io__drain_line()'s do-while loop is committed directly in
>   Patch 2.
>
> V3 addresses review feedback:
> - Updates io__drain_line() loop condition from a while loop to a
>   do-while loop.
>
> V2 addresses community review feedback:
> - Corrects read_proc_maps_line() and io__drain_line() to safely handle
>   already consumed newlines.
> - Restores early exit block for timeouts so TIMEOUT flag is emitted
>   to tools.
> - Removes unused assignment to avoid promoting warnings to build errors.
>
> Ian Rogers (5):
>   perf find-map: Remove PATH_MAX 128-byte stack array restriction
>   perf synthetic-events: Fix line synchronization, bounds, and
>     truncation bugs in proc maps reader
>   perf synthetic-events: Fix stack buffer overflow and bounds in cgroup
>     synthesis
>   perf synthetic-events: Fix bounds, stale state, and misc flags in
>     kernel module synthesis
>   perf synthetic-events: Fix bounds and union member access in mmap2
>     build_id synthesis

So while Sashiko is reporting yet more pre-existing issues, I'm going
to stop here. The changes in these patches have no issues:
https://sashiko.dev/#/patchset/20260721235254.294053-1-irogers%40google.com

Thanks,
Ian

>  tools/perf/util/find-map.c         |  10 +-
>  tools/perf/util/synthetic-events.c | 309 ++++++++++++++++++++---------
>  2 files changed, 223 insertions(+), 96 deletions(-)
>
> --
> 2.55.0.229.g6434b31f56-goog
>
