Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CBFAF;
	Mon,  4 Dec 2023 14:55:21 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c5fb06b131so1662585a12.0;
        Mon, 04 Dec 2023 14:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701730521; x=1702335321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVV07nHBbObR6oNHhv6jwsG37mtIP+qloEPUmn0BS1A=;
        b=pA8cavX8/zxZIFONo7Y3GRI/XSStKLtSvjZbynCjtDZKnfA3PZFn463cyFzBCgCux+
         ybSUtmo+O0lPSKEhWSwUDUojv+5N1X+0War0OA0q4R3KdZ/7zKBC1BxyANjDuxhSZqui
         bOgu9CQST9ehwSID2xDDX+OiAIqMc2NfYiUGhenacWfUt3p5EEFIB3xv9dr4GdTiHGN/
         guNkkNL+RdqB3GZCJrHV/Y3mCwvSKtJe2jHxotYZAqel8gzUO/g93bHX5o8rOibpR2Cy
         8CwFS5hrBjZe6ZR347CDC5BVa8q6IMo7uRSPAKtPMbbJCC9O+cbqtSPmG+lMTMRJ+7BO
         9glg==
X-Gm-Message-State: AOJu0YxfT/3ZmLEK1dj6z4yAH1k4RYwKfDX03XCk1vj6C/tDcDfwghCO
	+PiHUvf7O75rkBqxj6jHXC7YF1xxBveuDDKxuKI=
X-Google-Smtp-Source: AGHT+IEyn163f762KzwHyqTvW9xd4qFjmx8CNWLqgB/utcwWYiWsBs6ivx7fTh8di0JlF+3XY+jLKGt9wBT8Bj6hY2I=
X-Received: by 2002:a05:6a20:7f98:b0:188:290d:17dc with SMTP id
 d24-20020a056a207f9800b00188290d17dcmr2592869pzj.60.1701730520632; Mon, 04
 Dec 2023 14:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121000420.368075-1-irogers@google.com> <CAP-5=fUTuBjF8HJZAvXHkM4FjL05gjDcevKUruEXJHYRUhXygA@mail.gmail.com>
In-Reply-To: <CAP-5=fUTuBjF8HJZAvXHkM4FjL05gjDcevKUruEXJHYRUhXygA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 4 Dec 2023 14:55:09 -0800
Message-ID: <CAM9d7chSL5_OmWMoM8ya-6Pm3rptT+GQqXDAYPnb-nmL1cVXYw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] perf evsel: Fallback to task-clock when not system wide
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 8:02=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Mon, Nov 20, 2023 at 4:04=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > When the cycles event isn't available evsel will fallback to the
> > cpu-clock software event. task-clock is similar to cpu-clock but only
> > runs when the process is running. Falling back to cpu-clock when not
> > system wide leads to confusion, by falling back to task-clock it is
> > hoped the confusion is less.
> >
> > Pass the target to determine if task-clock is more appropriate. Update
> > a nearby comment and debug string for the change.
> >
> > ---
> > v2. Use target__has_cpu as suggested by Namhyung.
> > https://lpc.events/event/17/contributions/1556/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
