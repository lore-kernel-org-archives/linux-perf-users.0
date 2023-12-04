Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E445E109;
	Mon,  4 Dec 2023 15:41:53 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-286d6c95b8cso461309a91.0;
        Mon, 04 Dec 2023 15:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733313; x=1702338113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsivNpyhvKBjOi0cttxLeFHb89rKI5lSMUTbQhmQ2io=;
        b=ngv9gIh/YFdMyyqhj7TbFR5yRGYyRKtr5/DjhhtKf37asWLgp+1Yv7aycqYMd0obBx
         MhjZ4ApIRnqLFOdkVWT1UROLP9ADpPwAlrACO+UQLu7t81CJF8hKaCaqWdvBtSoqke6z
         olW9R/OyhKpXbA91AgoZ/G8UKFQIRdkVlXB6wczYeMyTrqkOY1M6foINsjwWqi86zxTc
         M07f/aBfCNhWUUPEDsy674NdCQM/bv5+y9E3+XfSHmJdHCK0zZGMGX071MFGx0ezWdYc
         315EwC5SLX41lEOV03DlKjZ6zLAWIFxle9efedKaufDNfbz1rN/UQkTXKbc3pcqu6JeR
         vS+A==
X-Gm-Message-State: AOJu0YwrnZ/50CKK0+L24Lm/K6Dh061ak4rlApL14034OeBSOeE7pMdt
	EnnjJejBQiLpa/lhfzUp7P0jHWX7obm/evB8J38=
X-Google-Smtp-Source: AGHT+IFR7+Ts/jYhVDpr3SYBHbOWhXQq6XQFg6NbA2gxpr7J9usPQAUNfmk2B0GzEi2lF5w2rtazusketNQw/ZmQL8A=
X-Received: by 2002:a17:90a:3ec2:b0:286:54d3:3a1b with SMTP id
 k60-20020a17090a3ec200b0028654d33a1bmr390567pjc.35.1701733313096; Mon, 04 Dec
 2023 15:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-15-irogers@google.com>
In-Reply-To: <20231127220902.1315692-15-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 4 Dec 2023 15:41:42 -0800
Message-ID: <CAM9d7cjbZgKHJ472Gwz=6C-htWDiPQGWbq7how0zcUuwYxxQmQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/50] perf thread: Add missing RC_CHK_EQUAL
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
> Comparing pointers without RC_CHK_ACCESS means the indirect object
> will be compared rather than the underlying maps when REFCNT_CHECKING
> is enabled. Fix by adding missing RC_CHK_EQUAL.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
