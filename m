Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453813D625
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891449; cv=none; b=eHc92fQycLL6azd0Y8YcsfO1DTMDmbLHuz+3WaizOX4bnPwaMn8vbrEmhqRptG9nJuRd78eC4xhsYli+ND8HRTzuS83MEk+Jz/MCiSafyxp319KY2f2cfoVtOOyiuyzuEJRC2+qru70+cFoLhrDOtNJ3LM9cCara6lAzZsMg2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891449; c=relaxed/simple;
	bh=WSAGnEZjHGG4iBk3XbD+eqNOLWiSQsNvNN9QMErGy0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlQiyrdK66RHRK7YWTITOewKDLtSoqJnC12xA0utwAK12LJgHX8DHXllmVoc1q6EMm28SFe2u5LyoZ9lcxGoGp1nEvRNZrXB05TMRtDO5mpUJ59Gq7xkQ7jRu8DCM5sSmN3J4wCrM6U5xejribzRpMO0tWP2U9M3I9n2yt7EdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttevJ6Qq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttevJ6Qq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e84a894335so5975ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713891446; x=1714496246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVQSZ6/UyLFVAhzq1SObZuwlgYS8Sd4w1atEPzTvjNY=;
        b=ttevJ6QqdVcdHCa33mNOZqlVHboGuSAFRZRkwxGav1uxAaxb+m6BQXinW17/mb2jEw
         Yi9ckqWyzTlzkOP4mPOAzgIHQFvzd43a8s+7l0Gmm5ILJR4cyKdX7JItnIrfoBrZKZD7
         8o6jMrp+bmez+fkMt5294ECYmcQTMKBxZV+1XnciA1JXE7qROJ/nCHYa6+N8J6YHMFi+
         2FdqPCmEKP5MuKuhmz/BAjRJPJ9BHoElRYIfyjJmGo4Ko859KksHhVUm5B6l2QiFCg9h
         QR7ulYY6y5Ciy4x46i98Fs2X421/Pc9dm9/wOvVG83HOZ+Z4QvaFSW+Lf9lkr9E/5tFX
         mZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891446; x=1714496246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVQSZ6/UyLFVAhzq1SObZuwlgYS8Sd4w1atEPzTvjNY=;
        b=kMSEYk5dsNUNNMcfFS4W+MHLxoi8tJbrfCKxhL7uDXWQ1t/YtPK/74lBsC7fKqVlKW
         EkFbA7HxmV1P+Fw6mtbmnyYt/TWNU9Wxrln2kc9RW4MZjQvZoT9rfalang5I2W/7TpTL
         14GC2/EB1LPqDhXCnFlVj/LeSDoJMe/ZihpZyzCPWwn2LUjZXYI0hMND50zkjOD7nPGV
         mZ6cqLUOGiOzEmqMeYuAeGwCCllmUA4Bj0E+FrOTgbshqP0KDYnLbgV0YLuK17IF3p8a
         TORKWcxLVI2vaMWeVBNWwvh8WhTiC7GxEoAN5bbCPWA6TahJzqcUPSVu9xnXQKtIKDh7
         BeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/HfTCb/+n//UM8O8zXEbrqw9iMYQoOe9f+GeQdMkHiFASStXTtttBPzanlmOJu98r+Ruc4ygLn+w8sVp/k9t0iG1LWixNmiSYHEjTY65sUQ==
X-Gm-Message-State: AOJu0YxIdMs2AOId0a6QozHg1Uoz6G5HaETOxx4HHl3XnIxIQEJTPdSt
	k/7HFh70gr65G2vBWL3+ShU9nJkpZB5RqEYZwdtfGcoOOqaH1UPDLCFBilZFwEUv7I7/1lk8W1T
	daZ+0CATbWtRK1Z4sxS/VFI2CAm+5hLoD1tYy
X-Google-Smtp-Source: AGHT+IFfhXBzjkICpFC3kVnh4AyEtnimBRCl1+VdVe/3VKPYqxFxw7KRNNruBgaAU7MtW19UNANYiNDZFxvo6tlgdSY=
X-Received: by 2002:a17:902:fc48:b0:1e3:e253:17e5 with SMTP id
 me8-20020a170902fc4800b001e3e25317e5mr234448plb.7.1713891445755; Tue, 23 Apr
 2024 09:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423020643.740029-1-namhyung@kernel.org>
In-Reply-To: <20240423020643.740029-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Apr 2024 09:57:12 -0700
Message-ID: <CAP-5=fUjDdy1GQCq_Z96x=bMXrxmqKojnysYsOnjBvO_nufjsQ@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix data type profiling on stdio
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 7:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The loop in hists__find_annotations() never set the 'nd' pointer to NULL
> and it makes stdio output repeating the last element forever.  I think
> it doesn't set to NULL for TUI to prevent it from exiting unexpectedly.
> But it should just set on stdio mode.
>
> Fixes: d001c7a7f473 ("perf annotate-data: Add hist_entry__annotate_data_t=
ui()")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Should we have a test to cover things like this?

Thanks,
Ian

> ---
>  tools/perf/builtin-annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index 6f7104f06c42..83812b9d5363 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -491,7 +491,7 @@ static void hists__find_annotations(struct hists *his=
ts,
>                                 return;
>                         }
>
> -                       if (next !=3D NULL)
> +                       if (use_browser =3D=3D 0 || next !=3D NULL)
>                                 nd =3D next;
>
>                         continue;
> --
> 2.44.0.769.g3c40516874-goog
>
