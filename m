Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4988DB6;
	Mon,  4 Dec 2023 16:07:15 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-286d8f3a08bso347253a91.1;
        Mon, 04 Dec 2023 16:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734835; x=1702339635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXxRUBMltgF34LwxAb3e3DHyHstq0fsBeAaJoMUOcWA=;
        b=W5OjHSKrJZvyCWnBljCl7adCsjXiDAbHaUgHvbDbbjMuQRRAovyc42z+Ta2XNxQKqm
         KkDBcw7PdJrM7AAH7fkvBeLWZh/gg93ZxaypK5Q5cqTItkKxaQX93QzQBx7VdwIcRTWV
         uEhGwXHfMXJIyRqRyi9odp0EThnZ+87xbOJ/NIGIVZqSwIdqsfkbEYzX4l8pKpJ3W+fz
         ugeCAk3gBn2ztxipmxdO4cBJTNXypmWTAlDhqw7uJueMJ7VArpAtuQB/OjHkIF9YrjTw
         tWxPxpFOQXj05Tgvi7XtFdrT/DyXBpRh3PIWXqotvsUOKpl2+mUao96gcMcTiZ1o2374
         VREA==
X-Gm-Message-State: AOJu0YxnxNYEv7zM8HqW8iDXrWCjP8zwSK5Dz3V7ZoGbo9R0RIblSgq9
	wzn/fqerstGFL55TxQanzgeSd5YYK7bq2R/0TB4=
X-Google-Smtp-Source: AGHT+IF9/LPawIP1YEm8gK6QD87oU95Do+mmLsroe4YfoU40ZSlR8NL53iMJJDPh0qLKlSxqzcsrKTO+zZ8NrAQx8ok=
X-Received: by 2002:a17:90b:3509:b0:27c:f309:f381 with SMTP id
 ls9-20020a17090b350900b0027cf309f381mr444092pjb.6.1701734834681; Mon, 04 Dec
 2023 16:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-21-irogers@google.com>
In-Reply-To: <20231127220902.1315692-21-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 4 Dec 2023 16:07:03 -0800
Message-ID: <CAM9d7cjVreWV_8QW27YKpmTHSfbPq17rBAhwxa-AcsVHHa5psA@mail.gmail.com>
Subject: Re: [PATCH v5 20/50] perf maps: Rename clone to copy from
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 2:10=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Rename maps__clone to maps__copy_from to be more intention revealing
> of its behavior. Pass the underlying maps rather than the thread.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
