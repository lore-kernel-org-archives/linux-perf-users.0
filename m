Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C642E43E
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780202; cv=pass; b=EhmthuyAM4ups8s6Ynk6UpcnCzkEWTjiJrR6+/mQH1WX7a9L6gGHQOvwK8LiS+gNN0Aaq8LZ/PEIUN9sOHdfJq61FWEX7/jC1IQd/8T5L3DnzC8fjiQN0e9rlh5pDqz2J55xKlGas5BXXZfKo3C3mjg5KNwT8dj2G3VoD2rGzSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780202; c=relaxed/simple;
	bh=rGDiBI1hTmQAe8TZel7wAjTxXii3zITCQLFrCU6hdPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHXPWc7yIF2VHdb35AwEGTNnhOLZgZkYhvAIABiNApuU9mx27+xNfimyg7tmoLM2VvoGJCUNFQLGGl92I8Wh49t+hqVwzts6r0duen3M69woYdsfGYgA+FXUvFtAWG5rKLag6nXOoQTbRv2QP922rUDSTcz8B1pOdzs84eqlNzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFXflJXJ; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFXflJXJ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10ed63c0so34391cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 14:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787780200; cv=none;
        d=google.com; s=arc-20260327;
        b=ZvdM/rG89h4v4aGKgEXwVTljwSPIQaxJhgxDBRD2bkd62b4ZzQgM9K+EYFROWwVsTF
         ELle65GCdRAtzNIYq/BtvBFCwaiULQ1PWDpVdYM7GxhOXLeM7/eJreWvVlgPOx4SdDhn
         vDpjjnVwdJWgcE7QOldN0JizJpVtlvg5o30emt2HOTK2tNRdCbtKFSA2kYKcit7KalZZ
         w3AlFTxVdOP1Dbz798fjQgi7PxWHbJ1K72fSrTBzr3i21110WcoyGiJV7u2oJXS3SQAS
         i1wjTnF4K20iCBpggEkfdwp9zqS84oaKkKvw+dwrMtBoSCOFPgnkI3OgsIYDWSP/OOsX
         H9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z0zP6gLuNpu4QL0Erkk9UtNBxXAl9RvpxfVoRz9rMQM=;
        fh=y0dNFVl1BP0yNJM5A79Ph3u31FJYcoOGArpxeG3ob8s=;
        b=KWVD5aQYw/CO/uMBe46gdbLJNZ5WCH/h6CtmaoOoBV27+0cBZpZiH1mycZgqsjU9GU
         joyZUs7xq4auLzmZrFC/PkUCcHC3nm7+tK1qZAr3n1EQfi0igy5XSep/mSa/u+/i20fo
         DdgaVMObBGSoE8QenckTUtCZwvJNqi7/jN2fgY3ioXSUbkCMTdi8AU42MoU5WewE61E3
         m+bk5vJ8qqQr/Bwsbg5T+WQsBbF84QRp1wIWvN7GzQyGgMauk4y3nUqg+ovT8udlTxQj
         yO3LZA/Ir94M4QFYr3eBgJvPpzAR0Qbr3o0U8TN4Z3ZxWJ7iqW4jWMMP/umE/EhHuw4C
         CbHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787780200; x=1788385000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z0zP6gLuNpu4QL0Erkk9UtNBxXAl9RvpxfVoRz9rMQM=;
        b=ZFXflJXJeHo3Cdnamt0/0x69ZgzDcHUeSoBl391sP1AsIU1xdPGt+LMsLlwT4x+TwP
         fHU1MLWyYdMaoWIZiNahngrm+j3WX1VdbcwgYGGKR3nQDuDfR3saTtC6xPWC43RvBrnF
         IzaDVgF2b6ygG6AiXI0XXul0ZbREgFKHqNVG4UBH5VyPvsq+eJWvzJXL5t5WBe3fsA2q
         4aCTlGslJbsuu7jWrfX4kXuzN7TlIAVC8t3SNE4MIMwlTh39pwi9H4t5AYIUMjvFqmlc
         BvI0rZqAdWvdVNVtYi3K30j5LMSOZBG/zFZYG9KeZkc6M+WjGtjT6MONB9JIP8ZNvHLg
         zKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780200; x=1788385000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0zP6gLuNpu4QL0Erkk9UtNBxXAl9RvpxfVoRz9rMQM=;
        b=a6/WTckMFsFNRO51lXFSntffUDAIP46FdA7oMQb3J/rrs5wUDOmAuiOBlJ4sVwC9DV
         1cNoA8Yvxlh1vcYYPWPr+Pv2fAVK7DYg0CvgmcwWoiL7frAtoTv7dxg2GrASgxhIShd9
         GHIcUSIcrdLQbhXHh/rBeq0fU62Rvh2DoQUhdhKqvU/IEcs/qH5tqmtrjm9oJ8U2gPbv
         OdJ9SooD0eTYfCb/z5E4WHOcao3gQ4gIYrp/0F+iLmxqhCJzZikuZ1/PJFcgL8r4x5FH
         8HbDQ6YlLixWbO1MopcSz9T/B7KMnySiAf44YMTAZj1bfYiUgiWOsjlm24s7Sft1UDui
         KtPg==
X-Forwarded-Encrypted: i=1; AHgh+Rpws1Y8jSoiTcQLEZqTHiSYGUSaaHk68Y2sSLBu5Hr8geBHjU4mZowUxDxQngfJ68Z3RkCK0V6EuQ/uBj5CC3fU@vger.kernel.org
X-Gm-Message-State: AFuF++n598firvOjAZ+gaWiNFDnsjDx1DUm1zaInD0R9QWoNHKzExzxp
	1grYPR7tm3qXdYML8CzDO3NUOdZuJkg8w1uPc6SI3HOK1QAG7MYJ0Leo2tyqaTR1yYsTmJV8f2a
	THfytHdF/FhH5DDkSnwUVMsPePIJt8B6+5jhCMzLz
X-Gm-Gg: AR+sD12hhEg7T9VEmcqJMOFndq9wilEB3yZHoceyN58gGzItOJLQT7KpPvwDTAg1KfF
	8DfgCJIKJaWLLb8t3thoP5ugZZGleeMkzGwxcqztLcqrKcyVI16WKt0BTW+4tuPdjmBMEfnBm1i
	KolJsljbsbFucsFGQtjm2aI1QXV/EkT/McXPrM3iRgi9ce/Vy6q4xG/+0hm4LlWDnbIpjXEXqKH
	IuEwSlQa4Xco5/E+t53rw6lFOGm+9GMCVwTa4+ge4Wb9y/j84vu2rpS532HoggjO3fZ2vfJue7h
	MR8kcAMjd6klESm++TrJWKschfyyOfuV8m27S91A8El+ICFKcHhmciCSJ+UNfC272ouyu2HG72s
	=
X-Received: by 2002:ac8:7f0e:0:b0:52d:7a3c:8396 with SMTP id
 d75a77b69052e-52fa3408e15mr4818971cf.2.1787780199166; Wed, 26 Aug 2026
 14:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826185815.280451-1-namhyung@kernel.org>
In-Reply-To: <20260826185815.280451-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Aug 2026 14:36:27 -0700
X-Gm-Features: AcwNN1WIAgiebcfVe5AkEC9RjLkGmJJYeCWi8c_9v9UurgC1yqzh5xQ-RWDBHso
Message-ID: <CAP-5=fVfmWQaE45Y=pA1rE5JxQLKhfN82+yfRqQE7Hjrb8=aOQ@mail.gmail.com>
Subject: Re: [PATCH] perf ftrace latency: Do not read trace files when BPF is used
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:58=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> I've realized that it didn't set up the tracing files when BPF is used
> so poll() just returns immediately.  It ends up with calling poll()
> unnecessarily in a loop.
>
> BPF still needs the loop to wait for the target process exiting or a
> signal from users.  Let's sleep for 1 msec and check that.
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-ftrace.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 4f881a40c311ae52..e61b9de11e1e41c7 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1146,6 +1146,11 @@ static int __cmd_latency(struct perf_ftrace *ftrac=
e)
>
>         line[0] =3D '\0';
>         while (!done) {
> +               if (ftrace->target.use_bpf) {
> +                       usleep(1000);
> +                       continue;
> +               }
> +

To avoid the busy waiting could we:
```
// Globaly:
sem_t sig_sem;
...
// Prior to setting up the signal handler:
sem_init(&sig_sem, 0, 0);
...
// Here:
if (ftrace->target.use_bpf) {
   sem_wait(&sig_sem);
} else {
   while (!done) {
...
}
// In the signal handler:
if (ftrace->target.use_bpf) {
   sem_post(&sig_sem);
}
...
// After removing the signal handler:
sem_destroy(&sig_sem);
```

Thanks,
Ian

>                 if (poll(&pollfd, 1, -1) < 0)
>                         break;
>
> --
> 2.55.0.897.gb25b4bd76c-goog
>
