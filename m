Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA412F;
	Wed, 29 Nov 2023 16:01:53 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d001e4cf7cso3710995ad.2;
        Wed, 29 Nov 2023 16:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701302513; x=1701907313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3As+H3ba0cBEdpLgXC4M2L7j366iPfI/nKdLUEgmlU=;
        b=nqFU+2O5JNxryODpf7vQd8jhR9Y6zIDDY2XSXLdwVAt4jaQnuWwNQBxL2klplqarVW
         TdwW8s3ekyM6YVTNwxyGZd4a4b0iqUEjDhlo08IUqL92X5W9mCEx1nDrylTRDOIWJmHP
         59yfyTxRqTFVGGByHIVj38gQnGT1o1eA0m5a1TZrUt9CLa2HPwY2PzT1z/WyTBu0uiHr
         7B9Ks+/mSQAjGuPYX2vN04rCzodaFAnkBzhtlD77AGNyxJPPXYtqTeuz/+/CwmICT4yp
         lCZmsKzHuIWDgj54l5t2Tk+DhIR7SnDcVFvPKJe3+CUD4znqd9ZIoRln/EJFdd5CRy8j
         Wiig==
X-Gm-Message-State: AOJu0Yz/f8bRuoSa4CT/9/mSszO+k9KrkPsIwegz8Mil3Y4OdM9un+0a
	8LnBaGzY4eWqPCBbgji8y/4elS+Hq2fitlC5RSxEVta2Uwc=
X-Google-Smtp-Source: AGHT+IEc4tL3VRN6B47qi922MCt9p4QJOtKNJyJQi9ansNVakoZdDGjvhkxqK9FNDFb25GOPZrUzwv8Z4j4KTEY1NAk=
X-Received: by 2002:a17:902:ee95:b0:1cc:6dd5:59e8 with SMTP id
 a21-20020a170902ee9500b001cc6dd559e8mr17932368pld.26.1701302513109; Wed, 29
 Nov 2023 16:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <20231128175441.721579-7-namhyung@kernel.org>
 <CAP-5=fW3f_96=rWeYg-qpL2T9VjLKnqnmq8T4dvaixWEo-0NRA@mail.gmail.com>
In-Reply-To: <CAP-5=fW3f_96=rWeYg-qpL2T9VjLKnqnmq8T4dvaixWEo-0NRA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 29 Nov 2023 16:01:41 -0800
Message-ID: <CAM9d7cgw+A1nxSqA+fcSiBH972gF-yRNTiadQwZDvJXTGre6=w@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf annotate: Ensure init/exit for global options
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:21=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Nov 28, 2023 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Now it only cares about the global options so it can just handle it
> > without the argument.
>
> If annotate_opts were accessed by a function then you could
> pthread_once the initialization on the first call to get
> annotate_opts. Removing annotation_options__init/exit would remove
> some potential for error.

Currently all call sites (perf annotate, report and top) initialize the
options and check if it has conflicting options before running the
commands.  So I'm not sure if it needs pthread_once() for that.

Thanks,
Namhyung
