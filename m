Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF44374C9
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl22Q7FW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF95C433CC;
	Wed,  8 Nov 2023 23:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699484609;
	bh=nmaljvz0PnnRaP8W7sX81UDwg5XIwLqZI1EBeujjgIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hl22Q7FWtf3y0NQcWPokcYaGOs9Rzp0XhSFS3Vz9gj0qoInDtkTu3FsfUZ9bPndyY
	 pjQB22z7vCX+t9BYUocqOyPSTppCyQttpADUsnIk7miGzpDMjrW/iu9wWCQG+MIKwi
	 h0SS7rlcefX0qWlmLvOexdPRIyxO8t8mGwvSQduPGa2HTYjmznul1M24hgHAI8QlqX
	 e/AXFRWoVDl3QvL9mvmbFc7UqC2WEmkV31+csE+yo4Eaz1bjO/F4HpZCnLSHLITmfi
	 CVZdZYIxDW8OeJsiiWaE4rX+afegxhB2a3bcpRqLXuYezsG5byW9FQ7Qb5cdNeeGxf
	 O6+h9znWGewZQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-507be298d2aso273027e87.1;
        Wed, 08 Nov 2023 15:03:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yy6IZxGNA4dFrg4MmftUa+ae/sakNePx63UcjhnJosRG8adbW8W
	FDQuB2Jya1+CKVe9Jj+S0o1AMV7dn5j6RKCkcGw=
X-Google-Smtp-Source: AGHT+IFTADxY+4prtXvEX3F8f2PZC2sZeoqhH9Kzi4yYj3yj5hc+Qo+8YRNgyXu99HvcAMkxuuLBqR7217UazajGNx8=
X-Received: by 2002:a19:5f4d:0:b0:509:4a02:49f7 with SMTP id
 a13-20020a195f4d000000b005094a0249f7mr153lfj.44.1699484607851; Wed, 08 Nov
 2023 15:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-13-irogers@google.com>
 <ZUuz/8EC0orXCffn@kernel.org>
In-Reply-To: <ZUuz/8EC0orXCffn@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 8 Nov 2023 15:03:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4ftvoUFnNfcZgBg7=SeaHmev7roFnix=+c+zSq3LawFQ@mail.gmail.com>
Message-ID: <CAPhsuW4ftvoUFnNfcZgBg7=SeaHmev7roFnix=+c+zSq3LawFQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/53] perf bpf: Don't synthesize BPF events when disabled
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Song Liu <songliubraving@fb.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nick Terrell <terrelln@fb.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 8:15=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Thu, Nov 02, 2023 at 10:56:54AM -0700, Ian Rogers escreveu:
> > If BPF sideband events are disabled on the command line, don't
> > synthesize BPF events too.
>
>
> Interesting, in 71184c6ab7e60fd5 ("perf record: Replace option
> --bpf-event with --no-bpf-event") we checked that, but only down at
> perf_event__synthesize_one_bpf_prog(), where we have:
>
>         if (!opts->no_bpf_event) {
>                 /* Synthesize PERF_RECORD_BPF_EVENT */
>                 *bpf_event =3D (struct perf_record_bpf_event)
>
>
> So we better remove that, now redundant check? I'll apply your patch as
> is and then we can remove that other check.
>
> Song, can I have your Acked-by or Reviewed-by, please?
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>

Good catch!

Acked-by: Song Liu <song@kernel.org>
