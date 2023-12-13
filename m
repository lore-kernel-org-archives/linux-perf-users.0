Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE6CF5;
	Wed, 13 Dec 2023 14:07:15 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ce831cbba6so4346445b3a.2;
        Wed, 13 Dec 2023 14:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505235; x=1703110035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF84qvQF+jKoq1M1NI49RnbH9CqQ4Hru8EABSTtyapU=;
        b=nbhSKYymGhY3JvL5kKAyYrILxLMp7tNndtTFSOdQO800+XhmBfqHfcZ/+nfhNXD5d3
         qBvNGMykcrpQKwciEh7G9bCSRtrOWcqkMmuU2NbwYg9WjUtu3FKNViAXhEALeZEaehpN
         adfJbI3lTQQtePdYsDbggr1PnF+CUfpBBIKNQwqKStf54bVNoeQiQWk57LbjYMQH+KnI
         juZv/jxWHgRIaFjuK8rHhY2JFzJkbNNblEa/Wipvu+CgBr5XoET7V1X/ikvSsWZVKpye
         KHI19+5+cLQDSv0fmwXRFgvz/hvES7POhi51nUnjIOMRM0WYqa/sr/xYVYdmopH7DjBM
         N/dg==
X-Gm-Message-State: AOJu0YwfhR4dMIq5S0JmjAOUC7MDeHV+unwfIT7ppNYQBavNlDtIMn6R
	frGpodRJ3dYhSmVMLwVKknxVrXcnFd2Za99dg5g=
X-Google-Smtp-Source: AGHT+IE4fpAh5MRfkBwR4G2EsuGiPpoQeclq+TFz1vKJ79Qrtc1dEmQiSBBHzIFIDWUev4rbxa1zoee6r87xm0H/Q7g=
X-Received: by 2002:a05:6a20:7a81:b0:187:b14f:a2a with SMTP id
 u1-20020a056a207a8100b00187b14f0a2amr4572950pzh.20.1702505234919; Wed, 13 Dec
 2023 14:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212070547.612536-1-namhyung@kernel.org> <CAP-5=fV5sA1ga5UfvHW_=Ep25b-TzsLJ8Atqk3KePKOx-fk9TQ@mail.gmail.com>
 <CAFjbc8Gt1GpLWjDf1jdhnb6fhVx246Tik+_TFXarGEqiZUY5BQ@mail.gmail.com>
In-Reply-To: <CAFjbc8Gt1GpLWjDf1jdhnb6fhVx246Tik+_TFXarGEqiZUY5BQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 13 Dec 2023 14:07:03 -0800
Message-ID: <CAM9d7chSAJS+ro65eG9-A6G5xdgt0JTzJkYAnzqrW28EQ-zGug@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf tools: Random fixes for DWARF unwind
To: Pablo Galindo Salgado <pablogsal@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, 
	Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 4:54=E2=80=AFPM Pablo Galindo Salgado
<pablogsal@gmail.com> wrote:
>
> > It'd be great if we could do similar for CPython.
>
> We (the CPython team) plan to release the perf jitdump support for
> Python 3.13 (around next October) so you will need to build from
> source or wait until is officially released for that test.

Okay, I hope we can have all the fixes asap and most distros ship
the latest version by then.

Thanks,
Namhyung
