Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D147CC71
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060827; cv=pass; b=oU9iBuEkDLUhg9hggZhHfMANv3a1nAxMGm922IonHhHTZC+9WAFrqDrKudLEMNoPppDTxBGuDeu6xfFvFLNem01UnxKVM1g7wfxpn7gWC/yiVrd9CjY0FQxbSLnc39dKItBzq8Ht92EBYTWeEtvbTgAv8GyJMKcbmfkWhvH9WEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060827; c=relaxed/simple;
	bh=PVEwyQhpZ43VPdWZA/9xRWrTsKqlw2cVGq5u7vcumf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtbcbLno8xX01/9wMRjhSGbrv/uIbzg6mLJe9LkPbhV0c2v/6N/XD7U5XHBKgvfec6Sj72OrTf6od45ok4nDvKrq0MaoQr4vPssrJY1sptAtTf1SX3vwQXVi+c8UKDHSBfxkuB9j5Yx2WpG9yDoCevhlsAV/nkmrLFLOhSMFRTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAto2ig/; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAto2ig/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2591757fbso254135ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775060824; cv=none;
        d=google.com; s=arc-20240605;
        b=SM3V4HbWui6W5wGNcq97PsNBU5NZJwk4lMWt5eGWCU/SbvbSFerNVxiGnRRxTNmNs1
         YBZuq1rKn5Jw68ZBkEifUO8mQd9Jb/PDLInMIEpTTKJ1WlGluxLBVGTp5aqZ69yJ81Zp
         v5bdSFGOK7KQq8ZTJPv+gDtNjaW03G24QIQOuGP7UZdjQtVDDJZz3R8EWufiBzdJmnpy
         5IegWNvM1i2X6+vRBrRtszMnozokyQJIxX/PAwdYbxN7NskuZgeB7swvSE+H15Hl42RP
         HetvchCL3Mf/xP6tJPOTXDGUxccJx0DmM8SjbawyYw60Rcu2ZsmbTCgDuxzc4taN6k7y
         bPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oIvY14sTT3ST+enS4Ze2qWtxGseKcs4uU7SXIZ5EU/k=;
        fh=ByH0JbSLqQ+Q3txLZPwY4uE5q+Hw6Nb3SYcHyqErdj4=;
        b=MCuiy38aMfEmoH8E9zyi0ragnjITfdD8W+LsVy2kXvPsQ7Xd42TwpCFFZeKlKy6nTS
         pwaRz6UPSUQ+ViTuI4Cd8fqaSSvXqm4AWIVWAf5BMZOo1zMvjldA3NRMFeeU7T92Rgk3
         vF/Nd6eHv0RLf6YA0aQkrI9GFEW2TcZZnEwjJnAsAdLfelj2mwHbMc6AuTBal2S9CQ08
         2hYlyNjTkmaOSuaq1DRNgYsAdzXE0xm69UcfD9GJkDFjmj+kliI4qO5pL+TBMNkOLDq8
         N+rL6jB5ND2QEEE1DhqqmAQic9iK5NElPICH81HvOAjaCaxAuUmznWp2hravTp78f+k4
         iqgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060824; x=1775665624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIvY14sTT3ST+enS4Ze2qWtxGseKcs4uU7SXIZ5EU/k=;
        b=KAto2ig/BqucVBC+cEDgrrZoSi3AQpxOR30fF6qSoyLUUfGOF8C2qVTM58HcvBkifS
         T/vhRgTgtx23FrzyDkXQbpMDUvxw5nB1tN3muKKLOgQcKZAxdUiVLi5qI0GqL+7t4hCu
         D258N0VcopI1j/mBG/YdNLaMQtSCSgfI3Jaw+otsDReASYipbFcvq242nqmJUmC3hRR+
         /ls5M+9KM4CdNCc+89bTZ7U7lwB5Hj1oMqDHxaMz988EVHg76iMHtFn2ghzSFJCsVKRH
         sRip+PfnMwd4bFmRe6Co/KywY97jrOZvMPa62xcPWxJexA5elBvoYu8sLHOT87JZQwSc
         tOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060824; x=1775665624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oIvY14sTT3ST+enS4Ze2qWtxGseKcs4uU7SXIZ5EU/k=;
        b=a1w0yQSSDdoPjsPaiKuTEubEdlmRGcHbtuCifSyxm9en/LZlhNGzZsuLSQ8PcYAWPS
         i9Q+Rna2HUIQMl+5J8T0zFoLYQSVy7O82yOZN8q1IO+pucZHzBoM47WQbt63pCLcN1oQ
         IDo28YmjTpooJPZeAslOGPBhVigcTTxhgzEisueyFUxatHjlFMbVdpLw4r54ZS/PUgbo
         ZHs4eJFxdC36j1csuOjtwxHr+8sepDGDAP25darAwnekGQC9RGA2j1iT4x/qKvWsMIcB
         Ys1e9nxu2UYWu3qEsiIb6UwcrfONNXvwjVapF3N14FJ8DX6Ma38wMC1EikNJEX3LLYLk
         1oug==
X-Forwarded-Encrypted: i=1; AJvYcCWPgspOR8zsA5ekCI+uWJ/tUAHM/dQTMVIX0XLE+qp36cFVTKIoae49505CvpAZCOsFlhHpNm2ziyKvCO29F+pS@vger.kernel.org
X-Gm-Message-State: AOJu0YwAmjIsTMndrAx46xtNeLqLMYOp1bPPcSNYUNRYqSx9fNdT1d8I
	4m5c2UmQA++uJlN3SInuEAYUMaaRsick4rkvuw6UXGq/Y9PHr3TcNP0mvsId2lxryGoE1fSGr+a
	uPHWxjZQKlTd6VXa2e8IRMACEfzlG1qswc1RSnjTk
X-Gm-Gg: ATEYQzwM3vHKtlriaipgyl23Gl2GL1sObGRTSlSknef41/LU9dDvnFnKmZN2WhBinZL
	Iri9u93R0qI6qfJsBseFU3aH6lrDen9dJHnVzQdzqX0ZlvN36BO+SYQTRJqeqWYVa1OOR3GjwSY
	Ks2GaHZqIOrY9sbZ6v98mnXGjcWpZexkUbGpm19aWgpMuIpWFIYCcg0K8ktuKz+4S85lKWehWO1
	qyeLDBAMJeXP1kK33pOrLspvX08QJhldTL49FORcpvDwwnoXocMsJcNrKMgw7QeBpK746vwbyDr
	io+P8TfcQ9lgdV+QDhVwc+rvwCsnEqsDRc68H3T6VEZ+CKE=
X-Received: by 2002:a17:902:f787:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2b2753a6fcemr94535ad.16.1775060822991; Wed, 01 Apr 2026
 09:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401064114.141066-1-swapnil.sapkal@amd.com> <20260401064114.141066-2-swapnil.sapkal@amd.com>
In-Reply-To: <20260401064114.141066-2-swapnil.sapkal@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 09:26:51 -0700
X-Gm-Features: AQROBzADRZrhKPOV8aXGljfCZNSgApJalzZ11vuhPeeaxRPCmQJKw71LCF2RJys
Message-ID: <CAP-5=fWY7X6Zo2xFXHbPtU2Dob=eHguzbkzowHjqyBzsse2+-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf sched stats: Fix SIGCHLD race in schedstat_record()
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, james.clark@linaro.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	gautham.shenoy@amd.com, ravi.bangoria@amd.com, KPrateek.Nayak@amd.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:42=E2=80=AFPM Swapnil Sapkal <swapnil.sapkal@amd=
.com> wrote:
>
> When a very short-lived workload is used with 'perf sched stats record',
> the child process can exit and deliver SIGCHLD between
> evlist__start_workload() and pause(). Since pause() only returns when a
> signal is received while suspended, and the SIGCHLD has already been
> delivered and handled by then, pause() blocks indefinitely.
>
> Fix this by blocking SIGCHLD before starting the workload and replacing
> pause() with sigsuspend(). sigsuspend() atomically unblocks SIGCHLD and
> suspends the process, ensuring no signal is lost regardless of how
> quickly the child exits.
>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

Thanks Swapnil! In the Sashiko reviews there were some nits about
clean up on error paths but also 1 about signals potentially being
masked in the perf workload:
https://sashiko.dev/#/patchset/20260401064114.141066-1-swapnil.sapkal%40amd=
.com
Could you take a look?

Ian

> ---
>  tools/perf/builtin-sched.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 3f509cfdd58c..eb3702d98fd1 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3807,6 +3807,7 @@ const char *output_name;
>  static int perf_sched__schedstat_record(struct perf_sched *sched,
>                                         int argc, const char **argv)
>  {
> +       sigset_t sigchld_mask, oldmask;
>         struct perf_session *session;
>         struct target target =3D {};
>         struct evlist *evlist;
> @@ -3822,6 +3823,15 @@ static int perf_sched__schedstat_record(struct per=
f_sched *sched,
>         signal(SIGCHLD, sighandler);
>         signal(SIGTERM, sighandler);
>
> +       /*
> +        * Block SIGCHLD early so that a short-lived workload cannot deli=
ver
> +        * the signal before we are ready to wait for it. sigsuspend() be=
low
> +        * will atomically unblock it.
> +        */
> +       sigemptyset(&sigchld_mask);
> +       sigaddset(&sigchld_mask, SIGCHLD);
> +       sigprocmask(SIG_BLOCK, &sigchld_mask, &oldmask);
> +
>         evlist =3D evlist__new();
>         if (!evlist)
>                 return -ENOMEM;
> @@ -3902,8 +3912,15 @@ static int perf_sched__schedstat_record(struct per=
f_sched *sched,
>         if (argc)
>                 evlist__start_workload(evlist);
>
> -       /* wait for signal */
> -       pause();
> +       /*
> +        * Use sigsuspend() instead of pause() to avoid a race where a
> +        * short-lived workload exits and delivers SIGCHLD before pause()
> +        * is entered, causing it to block indefinitely. sigsuspend()
> +        * atomically unblocks SIGCHLD (blocked above) and suspends,
> +        * ensuring no signal is lost.
> +        */
> +       sigsuspend(&oldmask);
> +       sigprocmask(SIG_SETMASK, &oldmask, NULL);
>
>         if (reset) {
>                 err =3D disable_sched_schedstat();
> --
> 2.43.0
>
