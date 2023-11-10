Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC713C69D
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADAAA9
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 15:01:52 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1cc316ccc38so21990215ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 15:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699657312; x=1700262112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9ySl/MqGDBnekD4XYj8T3tf5C5pSiAs1FP+YrxHnLM=;
        b=XcGZGQJqPelJlNuQ5/o4f6qy1JJTNk8Id6tR/lvf1Aoo1yTDHY8lKaFB6qfd+bA6vo
         fAuIbBY5u0BxaWvvIyy+CUOVQvVXobaqhHVIsZpMqci7oDc/fZo3fCnUACt1XuAbigsH
         lHO9KuUnSuGafWpzXXJMlmozcegKUZL2H2PtIeOCTK6z1NeaoKgpWaZaMWs4v07edLgg
         yWX7Xm6pVDsn8S8+758MFGev8+m+55+p0+mKuhMTuH6CG68pHFPYKy+Sk8fyj9gjqVcm
         sK5GyIvWpp1XpqQcaOAEtMioqJiuOyYzKydcV83MKzICp47x1xHOOOWxHQhy5fJ5WuvM
         5nVA==
X-Gm-Message-State: AOJu0YxGIFesO+Pg2G5n5RpcI0WdsXos0RQZPr0FRKfkpLY3tWibKGZk
	dP+F0G0Yl0xgLnk0W9oOpvb1Vg+Q10igzYTtAmw=
X-Google-Smtp-Source: AGHT+IGqBeeWrPzGcEbZOdQrOvp3pxV8YsrSQMpjp3JoU+KPt8NHo11d7Aye+TYJEvxpf9RlYXAVd/FWBKbmvRPlhYw=
X-Received: by 2002:a17:902:d508:b0:1cc:b460:e6cc with SMTP id
 b8-20020a170902d50800b001ccb460e6ccmr792323plg.12.1699657311916; Fri, 10 Nov
 2023 15:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <de597d7c-848e-4a35-887a-4cdefa23ecd2@cern.ch> <ZU5TZiXMUZ4VLOO+@kernel.org>
 <ZU5rHB4DCiBqlKtC@kernel.org>
In-Reply-To: <ZU5rHB4DCiBqlKtC@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 10 Nov 2023 15:01:40 -0800
Message-ID: <CAM9d7cjRBWnFoSkR+Gu8fN_0G6PDLMHRq3rim_Aksdwh8tWBmQ@mail.gmail.com>
Subject: Re: long BPF stack traces Re: Broken stack traces with
 --call-graph=fp and a multi-threaded app due to page faults?
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Maksymilian Graczyk <maksymilian.graczyk@cern.ch>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	linux-perf-users@vger.kernel.org, syclops-project <syclops-project@cern.ch>, 
	Guilherme Amadio <guilherme.amadio@cern.ch>, Stephan Hageboeck <stephan.hageboeck@cern.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 10, 2023 at 9:40=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Nov 10, 2023 at 12:59:34PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Wed, Nov 08, 2023 at 11:46:03AM +0100, Maksymilian Graczyk escreveu:
> > > Alongside sampling-based profiling, I run syscall profiling with a se=
parate
> > > "perf record" instance attached to the same PID.
>
> > > When I debug the kernel using kgdb, I see more-or-less the following
> > > behaviour happening in the stack traversal loop in perf_callchain_use=
r() in
> > > arch/x86/events/core.c for the same thread being profiled:
>
> > > 1. The first sample goes fine, the entire stack is traversed.
> > > 2. The second sample breaks at some point inside my program, with a p=
age
> > > fault due to page not present.
> > > 3. The third sample breaks at another *earlier* point inside my progr=
am,
> > > with a page fault due to page not present.
> > > 4. The fourth sample breaks at another *later* point inside my progra=
m, with
> > > a page fault due to page not present.
>
> > Namhyung, Jiri: ideas? I have to stop this analysis now, will continue =
later.
>
> Would https://lore.kernel.org/all/20220225234339.2386398-7-haoluo@google.=
com/
> this come into play, i.e. we would need to use a sleepable tp_btf (see
> below about __get_user(frame.next_frame...) page faulting) in
> tools/perf/util/bpf_skel/off_cpu.bpf.c, here:
>
> [acme@quaco perf-tools-next]$ grep tp_btf tools/perf/util/bpf_skel/off_cp=
u.bpf.c
> SEC("tp_btf/task_newtask")
> SEC("tp_btf/sched_switch")
> [acme@quaco perf-tools-next]$
>
> But Hao's patch (CCed here) doesn't seem to have made its way to
> tools/lib/bpf/, Hao, why this hasn't made into libbpf?
>
> +       SEC_DEF("tp_btf.s/",            TRACING, BPF_TRACE_RAW_TP, SEC_AT=
TACH_BTF | SEC_SLEEPABLE, attach_trace),
>

IIUC it's not just a BPF problem, Maksymilian said it still failed to get
the stack trace without --off-cpu.  As it's in the NMI context, it cannot
handle faults in the perf overflow handler.  So things like the proposed
sframe unwinder (I really need to go review it) would be needed.

Thanks,
Namhyung
