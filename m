Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C327978C
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Oct 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235748; cv=none; b=VVFSY1Lt32r1Dzz9w+cAgeDs4fTY92iPpeZ0XYI4GfgGjBWPl+VmvJzaBwrR87UjV7wrTz5VsQQl6P3WKDx5DBEcNnlUOKObEwps7WnNYFQbg90ujiotlSC/8ysI7p82G3rzo2WSct5+bPmHE4vfhCUsKZsRck1hXL7BuWfxsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235748; c=relaxed/simple;
	bh=iicqHqIRyiknDU8aj031heEdaLM9JecB5tKouPwEMLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+WSwZMdSJ2DW9bElJb2mi1VaUfFSkleTojpfY6/kTq0YbeDrKt4fYC2aHAKcsBvkLKMWex5kjfk+qXIhz4VWRaPWTar8VThWER/Vmaw6e+v2zUg2IyCcxK808/I7Da4TpVFBJh6B/LVx6ccKxHBvTZ9oQigfqRCBLWfqCWL5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RC/JNjOg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RC/JNjOg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eeafd4882so226595ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Oct 2025 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761235745; x=1761840545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DD2FrCR3h7s6+/jsUTtH0YJbnzDwL7eNDOT6HMeIno=;
        b=RC/JNjOgm05YAUJPBXCD9Dfg7J5D+NfWFiOYy0tM2iQtTLKe0f8SVPLPenMX6qMTub
         pQ91uEAdlp+l0B8AkdzG74TYyf2HBozh9rpnCRfKUfo14xWS9hKgqzu7O7O20+OgurUa
         ZZhT+vtzL5JFPrAk5RZ7dkMLd4mm+kKRkSnxBDqaUbAENU8r4Ozml6fcx88iqevBTs/9
         KkpdEnxIb7BK2dgDXtgDO9BYVeMx2AOczyRtct6QFowgPrCCHp+Ki8J24reDOYPWzQ02
         PDliRe5DY4j/vt63eeTSlHTLiG6tiUWLFM8m2Nab6RkHL1vtgE9lLBi2WKJIlIdE1NN7
         rkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761235745; x=1761840545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DD2FrCR3h7s6+/jsUTtH0YJbnzDwL7eNDOT6HMeIno=;
        b=XRpek/YguppRmWsqEGg5zGYWXTXHGF6oKqTC4jV6rJLd8X19zk8xeQN6QtZ5G+VExP
         TygO9UV/XeeJ2+/mZqRnixgFc+UyTQJIbAXrkXBvL6bfkjmQXd/m9ipjlx7s5uDCfsAC
         yZtmaNZFowEW2PG6LbLwYAFfu1TCjdu//yKIyGOzi4R0IM+tOS+lHzmmO5qXvSBa2jTQ
         S4s4fFvY6mc5/PYAFUNNHOw0F6A7x6NboqZC2zmObVrr8vCv8Qp2oXmbME7mQXSxIv29
         Vly7eqSMR0YMzEEkSCex1yPMXh+dv0Z627e1sx66Bef2WzAkFoECw9PyRDJWAFMOD7nJ
         wxKA==
X-Forwarded-Encrypted: i=1; AJvYcCUN6TRcGW9vgXK/GP1L5CGwgGynz23XWrEeznI2PW/uHJw1OsKwRko5vvM9iG9xlPEtUwfUpN++8FAvAZURtQBg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GIXR1ffZAHuJ5pxdp6fIXIIWYYDERxzwPm93+3xHlgC+Iwh4
	MPwcVQLWInzLVlwioK+sX7VS1tToVsPCUdmd78tcvhmD4Mb4N4gnQGwnZR/RRJFGxtpxr2+CDHV
	HfonnoCuANV5fWSy1OXn9oscOSYJzMhJDQflCeuwR
X-Gm-Gg: ASbGncvCkoJaU9oGWS3Xy0SHKdEZAwjo8s1xf6YYn31iX+OEXFK/SJfCOuQiP9nMQwj
	fqEH/OOe7Gl9q3Zvja0rReUFQzNTP7UEorZIkxDHWUgC2TRp7UaQwAknUnFwcG9ncSkouIV6NT/
	iXF8nOManjLDN3fd+DdcPQi7t8MRXuR+VyUABEfqVl+4xXgLoDGoK+XeUPIiJ+1cdIc+psR5Fos
	/r/dwklb19T1otqKd1D1yvIw41RR8j+L9ihnuEpAM67kzvAa6Ukw6glfw7+iYSMv7qgm4D7vXfn
	GC8QEiALtH6VZAU=
X-Google-Smtp-Source: AGHT+IFm2MFLeK85YermsOMu5zYpTpjbtEK4xI00o5TLBfizVMtB0lHY5AA/2uze9+mJDbIqCwZ3M48UjYiYnpTrzDk=
X-Received: by 2002:a17:903:1c2:b0:290:dc44:d6fa with SMTP id
 d9443c01a7336-29487303b51mr523455ad.16.1761235744060; Thu, 23 Oct 2025
 09:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Oct 2025 09:08:52 -0700
X-Gm-Features: AS18NWDd7pnd6R6MJu2L_vLKwKGtCotRaE8bGYrXMIICN6v6EliIOYkLKsl-DF8
Message-ID: <CAP-5=fWupb62_QKM3bZO9K9yeJqC2H-bdi6dQNM7zAsLTJoDow@mail.gmail.com>
Subject: Re: [PATCH] perf record: skip synthesize event when open evsel failed
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org, 
	james.clark@arm.com, leo.yan@linaro.org, mingo@redhat.com, 
	baolin.wang@linux.alibaba.com, acme@kernel.org, mark.rutland@arm.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 6:50=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
> When using perf record with the `--overwrite` option, a segmentation faul=
t
> occurs if an event fails to open. For example:
>
>   perf record -e cycles-ct -F 1000 -a --overwrite
>   Error:
>   cycles-ct:H: PMU Hardware doesn't support sampling/overflow-interrupts.=
 Try 'perf stat'
>   perf: Segmentation fault
>       #0 0x6466b6 in dump_stack debug.c:366
>       #1 0x646729 in sighandler_dump_stack debug.c:378
>       #2 0x453fd1 in sigsegv_handler builtin-record.c:722
>       #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
>       #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-events.c=
:1862
>       #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-events.c:1=
943
>       #6 0x458090 in record__synthesize builtin-record.c:2075
>       #7 0x45a85a in __cmd_record builtin-record.c:2888
>       #8 0x45deb6 in cmd_record builtin-record.c:4374
>       #9 0x4e5e33 in run_builtin perf.c:349
>       #10 0x4e60bf in handle_internal_command perf.c:401
>       #11 0x4e6215 in run_argv perf.c:448
>       #12 0x4e653a in main perf.c:555
>       #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
>       #14 0x43a3ee in _start ??:0
>
> The --overwrite option implies --tail-synthesize, which collects non-samp=
le
> events reflecting the system status when recording finishes. However, whe=
n
> evsel opening fails (e.g., unsupported event 'cycles-ct'), session->evlis=
t
> is not initialized and remains NULL. The code unconditionally calls
> record__synthesize() in the error path, which iterates through the NULL
> evlist pointer and causes a segfault.
>
> To fix it, move the record__synthesize() call inside the error check bloc=
k, so
> it's only called when there was no error during recording, ensuring that =
evlist
> is properly initialized.
>
> Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

This looks great! I wonder if we can add a test, perhaps here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next#n435
something like:
```
$ perf record -e foobar -F 1000 -a --overwrite -o /dev/null -- sleep 0.1
```
in a new test subsection for test_overwrite? foobar would be an event
that we could assume isn't present. Could you help with a test
covering the problems you've uncovered and perhaps related flags?

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index d76f01956e33..b1fb87016d5a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2883,11 +2883,11 @@ static int __cmd_record(struct record *rec, int a=
rgc, const char **argv)
>                 rec->bytes_written +=3D off_cpu_write(rec->session);
>
>         record__read_lost_samples(rec);
> -       record__synthesize(rec, true);
>         /* this will be recalculated during process_buildids() */
>         rec->samples =3D 0;
>
>         if (!err) {
> +               record__synthesize(rec, true);
>                 if (!rec->timestamp_filename) {
>                         record__finish_output(rec);
>                 } else {
> --
> 2.39.3
>
