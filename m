Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEK5wg55"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F36CB
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 11:07:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf09be81bso284e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 11:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701716865; x=1702321665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5vT+APsCg/FSnZpn7O3Zjrf90SobvyinAQOiMG7ovE=;
        b=BEK5wg55zv/26SDQVThLidaR3OyBNLeewBTEyZRSvwL6nGdtFeKH1R4X1HAXhBU7y7
         KMV1FmUcLPPygZlFgHcOHdFwH/i86PvQlFIc0q4cXv57pC+5eJmbv3RmYPgvsHvPDMj0
         rRBFf4yOKIuUCB8L6ym44bnYuv8D3hMpekRSd1Y8lQRICQyqk1CTwoqL+ZIRrqWZ5FiT
         qDsNdFkBts+7pHbm+AjYMSdcIX2ER2nGe+Mom32/I03hJCe02LteZ0/4mh7l7nX9r5tI
         M5PWxKhjf6z3TGtpfe9ymtfeRhmdUecEETeKcw5u4SQM65llCCzHRtxH1qtc7rbRYEAv
         pEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716865; x=1702321665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5vT+APsCg/FSnZpn7O3Zjrf90SobvyinAQOiMG7ovE=;
        b=OVPgzk0CvuawwO4qSvdQzs9BKSEv+iJDXL2ut/DyYD5bh8t/QSoqbMqLFnL5F41vhV
         uDXBNPAdq0UCcFqB3LPoafyX61PE9rfTNRM7AiUiYwcVos8JtWVAtJBNePGqQO0qBQuE
         NNse70lLTvluJssfMPFJS45L0RhIdTeFvaPtY/N7tZ1DtQ/Vypxse8k8QpZ5Pz2fxIfh
         WiZICI7ShaYT8Syt9d39anB+CQlOJS9GwcDXPfNOr259cVppUr5tRIl/63OVUBAa+0ss
         9LmSfKe/yezgMB0xfHNjjP+eb6DKomX9rP9xqcM4gDWuEbMnhLbGBg72z+4Cs+/yfcUN
         AQBA==
X-Gm-Message-State: AOJu0YwTJU420TlWIm3lntb15WWgjogwfMuWoKoooGLCD8H9nOt3HHVU
	8VB5TXtedkwFwyMO6CxXkcm7AIELVXbvioNvoIPicA==
X-Google-Smtp-Source: AGHT+IHA5w0Z03xioU+ynWPCd+l8I8tcc2/QWPNYlKSj00tvSmrlzBmx02FNAGzxpNIvbZ4Sr/LO/nzLLiUbp3mEG1A=
X-Received: by 2002:a05:6512:1153:b0:504:7b50:ec9a with SMTP id
 m19-20020a056512115300b005047b50ec9amr324664lfg.1.1701716864963; Mon, 04 Dec
 2023 11:07:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201021550.1109196-1-ilkka@os.amperecomputing.com> <20231201021550.1109196-4-ilkka@os.amperecomputing.com>
In-Reply-To: <20231201021550.1109196-4-ilkka@os.amperecomputing.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 11:07:33 -0800
Message-ID: <CAP-5=fUEsLQ+kqh4eo_5mcrEe_tHJ=t4CAxd7Um7aD8T+t4yTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf vendor events arm64: AmpereOneX: Add core PMU
 events and metrics
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 6:16=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> Add JSON files for AmpereOneX core PMU events and metrics.
>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
