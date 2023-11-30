Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB9D50;
	Wed, 29 Nov 2023 18:16:41 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c21e185df5so394977a12.1;
        Wed, 29 Nov 2023 18:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701310601; x=1701915401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VLuQtpdBc32KjxQOcjqDfowfS2XJTyc1MGIgZJtNMg=;
        b=kNDsS4nySjH3LJ0FdpxULxEkVwk2YzWNPwGoQNlWnsEc3KBf4OmzTkhWof/m9dZaBT
         apIZ/O6hna9RQvC9mXSg3k3d1f+igCp+zNbowv6MS8QO1bLSuVfQXNp/rMvNO3jgXDaX
         S5GndEMQPiM8Mi5NHNXJQRlRlzvg2JqOHgnKfg9FKuI0Xyt+XiZkrtUqr5uDsOqhSHA3
         +9Rhd5YvOtC+K6Uz9PQs5G1h3PccxGZ1L4wro/MYNeOMUck30dDl4EwlOyIwP+8a8oPi
         iF0vVdJWS1ne2FTwOsZjwGTT5KNaZpHACc6Bolrt36l4TFzk1G1PeAD1rFkORw4dwo9H
         4wmA==
X-Gm-Message-State: AOJu0YyJbk0DUIBhVsX2B3105c7BCRaV229l3jPncR8wY1NNhcVWo2iz
	XgJkGFfS9716CQtLXiuWQCecbB8u4qvZg3Gtzuc=
X-Google-Smtp-Source: AGHT+IFc99F048eopfGGkgAVArdOb2xa84JCR/S9okjBZCgS5cbT/5lCnhrv7ynQHOv2BqxNnwYu5+mWJR103p2CBL8=
X-Received: by 2002:a17:90b:3808:b0:25e:a8ab:9157 with SMTP id
 mq8-20020a17090b380800b0025ea8ab9157mr20010117pjb.22.1701310600944; Wed, 29
 Nov 2023 18:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-10-irogers@google.com>
In-Reply-To: <20231127220902.1315692-10-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 29 Nov 2023 18:16:29 -0800
Message-ID: <CAM9d7ch_Nw4mjjGVSc_DzaA+XhosjcjnKeG4MMxN8zu33eBPPA@mail.gmail.com>
Subject: Re: [PATCH v5 09/50] perf pmu: Switch to io_dir__readdir
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

On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Avoid DIR allocations when scanning sysfs by using io_dir for the
> readdir implementation, that allocates about 1kb on the stack.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
