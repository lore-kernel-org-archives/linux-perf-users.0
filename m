Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832F1F37B9;
	Fri, 31 Jan 2025 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738356087; cv=none; b=oOBstEcHuSwVg65zZG1KHhueqZ4AvAzm6CVrRBHBhipVbF4IvFWX6CWzPQug+n8iuZpfSfOQ5gcHbF6MxJTh47wQTwquLmn4GmLjdbpinuUk9phHxjW5PF/ZQG5dEHxjEYNgcNV9fvJbz4IvhmGc1aafmdt3sIQcWt8+hz6rAFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738356087; c=relaxed/simple;
	bh=T56hHME+s4l3JGPnRkWuFu5+rVZe4vwr68GJHupz4Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsPCyccPAUEqprpXMCuh2cRxq8jOS4t42oAz/l48bDPTqqleSiWZiueMjrVzhpi10smT9N7L7BvxQNLXRQWytT/WCCg/LBlCThZEimm1uM4goGaVoNbxnF4uWhg4b750Ul6OfzudSj4ds4Zwc+4Jt1JAzuDH+4cdoKUUpIG6qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVWwHYz9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVWwHYz9"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f6cc13d103so10346897b3.0;
        Fri, 31 Jan 2025 12:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738356085; x=1738960885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZDmQ9DZ4bDsxoBK6DzuqHEe8zHAyvfJAig+1wU30fk=;
        b=dVWwHYz91dSIkcUNx8dZXS8LaT4OhEV1mmItdcrnYI57G1FLU6I7TY6tb7fYLr839X
         Ty+UeSBxrLd2kQNO6hgi4tOXaVnqYRNjwPzzqnpSDVuGZFTdGeKkFIifD3WM+381ZWsi
         v5tEnCpbCkUeBwtRnKECZeWRvF1/KklBNWHDsqskP6UrYWeFFDQcs3P4QNPetNc+cEOs
         2Soi+pTUKWW0q0JpG1Qt3+KvNRdsPPbZeUUilxNUa1QPF/2WttQw9nkHSAIAi9xuZumn
         BRvSm2AL7AJsP0rrp+HXW21KBDYwa5V3PnX6hsHjHGPiDqx0dKwgY+adcSb0vXyktGYk
         TGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738356085; x=1738960885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZDmQ9DZ4bDsxoBK6DzuqHEe8zHAyvfJAig+1wU30fk=;
        b=svmE2Q3vCk2443zKRjR884hy+7ZZxhmIrIKbq4nXXz7motO5GGiirslK6m1KD5DCWB
         VuuEYwtNKjoXr6OqBc3ciu8tj9df2FtZl/pjhOGhyl5g4c6Ht79/wosPnSa5xau/fHZl
         OHUENsZYf0PjDMUuzWy6lnkIweh+Dpt00jBddSV9fk7A2ANTci/uwqMvDOOhKFdcVGt4
         JdFtHOxWN6TyDFW58eLIX248A4GMqxAG8+5nw8NTyIHjKNRjtXwkvYH97wdCnhdkypBZ
         ryzNoOner+05Li03Dn/WNvQ2dqG0Dyo85jKolVVCCGEHlFXl4PCPn3GBIBh1aTebAMLB
         A6wg==
X-Forwarded-Encrypted: i=1; AJvYcCUBXHRZ49RjQ6Vv5LWw5O9CVUoPDgHDYHfbzydwIIUzTEDBLPP/f7BsVMSPrbxr9t22sBFR6cz6qsdInLQ=@vger.kernel.org, AJvYcCXEb1ELHlh+ETDw97jdTOe9b8GG3OCPQnVxR7kRHHC3AxJUBYVgB2AJqpQClumiVoyf0T0n0sE57n9iSASJO949/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3c86RJcJaGGY4I9xBvBRd0D/sOa/3zxm+gTyqdjgep3x6PIM
	Es695nlSxP8IEcRY4d70w4vIunS9N+iAFxd5MfAZTQFlVnN9rCrpDCA2qS/lkPJHpif2HgvjqV7
	U9C8USiENlG/Ku6xPtwH8OoTIxo4=
X-Gm-Gg: ASbGncv+vmfeX7f91QcaxuuyzncDnhpyAuw/icHxSIeSZ10PDLHHX/h3buBIkoNF2Jx
	XeQyfX+abjYmDN8s2PILd8rk7tO8YzlgkpCzMs2szZObpBDWTAKVYgqslO0D7yABrGQUTBp8=
X-Google-Smtp-Source: AGHT+IFoR9WyU52W4rsctDI7diSPf9JMY0U9tWkrumaFvznREZgah7y87+RlZLPQZU4NxtXD+v46+YLn+iFzDKvLsV4=
X-Received: by 2002:a05:690c:6185:b0:6f6:d149:d64a with SMTP id
 00721157ae682-6f7a84246f5mr112470567b3.27.1738356084787; Fri, 31 Jan 2025
 12:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130030525.1482498-1-namhyung@kernel.org>
In-Reply-To: <20250130030525.1482498-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 31 Jan 2025 12:41:14 -0800
X-Gm-Features: AWEUYZmmfiq-aWtkAxFDdX_X0s2IAIAjTjfIRovcOkOOQtexwyV-Z2876FWAcjw
Message-ID: <CAH0uvog9WWvBeMgnkdrr0=rP8y5Ea1P=a-TqbLEYYKSS25+wqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf trace: Add --summary-mode option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Wed, Jan 29, 2025 at 7:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> I've realized that perf trace shows system call summary at the end for
> each thread.  But sometimes users want to see the global whole system
> summary or statistics instead.
>
> So I've added --summary-mode option like below:
>
>     $ sudo ./perf trace -as --summary-mode=3Dtotal sleep 1
>
>      Summary of events:
>
>      total, 21580 events
>
>        syscall            calls  errors  total       min       avg       =
max       stddev
>                                          (msec)    (msec)    (msec)    (m=
sec)        (%)
>        --------------- --------  ------ -------- --------- --------- ----=
-----     ------
>        epoll_wait          1305      0 14716.712     0.000    11.277   55=
1.529      8.87%
>        futex               1256     89 13331.197     0.000    10.614   73=
3.722     15.49%
>        poll                 669      0  6806.618     0.000    10.174   45=
9.316     11.77%
>        ppoll                220      0  3968.797     0.000    18.040   51=
6.775     25.35%
>        clock_nanosleep        1      0  1000.027  1000.027  1000.027  100=
0.027      0.00%
>        epoll_pwait           21      0   592.783     0.000    28.228   52=
2.293     88.29%
>        nanosleep             16      0    60.515     0.000     3.782    1=
0.123     33.33%
>        ioctl                510      0     4.284     0.001     0.008     =
0.182      8.84%
>        recvmsg             1434    775     3.497     0.001     0.002     =
0.174      6.37%
>        write               1393      0     2.854     0.001     0.002     =
0.017      1.79%
>        read                1063    100     2.236     0.000     0.002     =
0.083      5.11%
>        ...
>
> Also it changes internal data structure to hash table to track
> statistics of syscalls.  And removes the rb_resort code.
>
> v2 changes)
> * Rebase to current perf-tools-next
> * Fix some style issues  (Howard)
> * Rename to --summary-mode  (Howard)

perf $ sudo ./perf trace -s -C 0 --summary-mode=3Dtotal
^C
 Summary of events:

 total, 185 events

   syscall            calls  errors  total       min       avg
max       stddev
                                     (msec)    (msec)    (msec)
(msec)        (%)
   --------------- --------  ------ -------- --------- ---------
---------     ------
   ppoll                 29      0   188.684     0.000     6.506
62.504     54.91%
   read                  20      0     0.415     0.002     0.021
0.345     82.16%
   write                 24      0     0.085     0.001     0.004
0.012     12.09%
   sendmsg                4      0     0.039     0.005     0.010
0.014     24.12%
   recvmsg                8      0     0.034     0.003     0.004
0.005      4.81%
   poll                   8      0     0.020     0.002     0.003
0.003      8.96%

The new option is working as expected, thank you.

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf trace: Allocate syscall stats only if summary is on
>   perf trace: Convert syscall_stats to hashmap
>   perf tools: Get rid of now-unused rb_resort.h
>   perf trace: Add --summary-mode option
>
>  tools/perf/Documentation/perf-trace.txt |   4 +
>  tools/perf/builtin-trace.c              | 252 +++++++++++++++++++-----
>  tools/perf/util/rb_resort.h             | 146 --------------
>  3 files changed, 208 insertions(+), 194 deletions(-)
>  delete mode 100644 tools/perf/util/rb_resort.h
>
> --
> 2.48.1.262.g85cc9f2d1e-goog
>
