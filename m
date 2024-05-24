Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179046542
	for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582178; cv=none; b=VsY1ekD3Rd4D3HYDf+rTlcmW0TwiXu2c9RtMphKnqWW9St1hQm4v6fdYw0ApqtfrFvQ0xSMVKMCU4TtiJCv3QoG6+vbSoTIuCgm0T5NMEvZXo8WR/BtSBu80P5OAM8QShLCLONZiPSXG0r7A6StCHm1BukgHNTCoCdG0ac20BoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582178; c=relaxed/simple;
	bh=DN5DiwrRd5qbw3sclKQ+zjoZIjY62xjvwfTAj7+2NkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAbnyYyix5qVYZzxQnVdYEQrVFsnzWueQbURMRGFPh6J9zWczn9kfwUdl7KH3BeMLSH2k3e2GYJwWo2IRGSLBo+WhMg7nAKrF9KAPDQ7WZtJdMU0cZqF3+ZGW16qRq43wMPXmNqCzjAXjDDV1wsBak4UPIsyr4cMa7DF3QRw60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJaLqKif; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJaLqKif"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43dfa9a98d2so8731cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716582175; x=1717186975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+IQkIDsWv6TAoxlWNpgArjw1bM2St+LuCkqXoQSIsY=;
        b=QJaLqKif2mVg0g3Xd1/jW0UV2qDjoIfbjuU73axBV2gHhOMI7qwbq60LITDZgIOecS
         +5mFpnmXvzLyrBmAGH2UTyh6TrPE/xEI5+RoV9MuEHPsBk5XyCykZ58SEs43eo7lQ6FY
         kh1eLU7okNrNFyrhVwo+RNa1T/k7Is0Rt3MT7H/BQIaXG3qnY2Z3yUZBsUgyuiiWkL6F
         U5iPZwCmRWS01tmqGWJ1q0Njnn4miB1PfLuOAf+egbI3xdzYhJOVtqs6JVSjESvQpWmW
         6ybKtSSLefGtJoTaEopFSOY14riW5JLiHtlDyGEUc1s5tVjc7EeDX+0V87UpoeGOrN6l
         3kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716582175; x=1717186975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+IQkIDsWv6TAoxlWNpgArjw1bM2St+LuCkqXoQSIsY=;
        b=Ag/b/GS90RlYjdO05cR3tu429nseoTUj9i/eKR+J0fL/Q9l8OxmCqydlJthr6Px4RK
         bxOYbSwq7X8YB/l0oJ+Vnn6rJc/ZyieonQDJKFLa12aAxKvN9sWDyx1IpXLBITvrRkLB
         tHKJLFY7hFncEar1Iatc9RKU1pWjFfoNYukLJcLOgl9AV+myV56J9OLrSy/KkWKTCpUr
         ADhKGV6PU4esiIB20C/aBbqiPeWdy+QCkJL6AX8bG4NXEESB3W4VSxtNvGt6khke2c6B
         mW0PPF4MV/+sHQ8A0YCcS7LTh8o9HFdCAeGqvfiQCz9546tfUT9WtHdEe0ze6giCONay
         z4nw==
X-Forwarded-Encrypted: i=1; AJvYcCX0+TxAVn5KP+mFpvPGew6qwDbHRRz8urWuSBw0Gw65xhyBzZML1uPh/Itoc9hEh5wiepGI7Jx/B885CallwW2kMwL7qQ1Wb7vkXzuxFZE1zg==
X-Gm-Message-State: AOJu0YxpxYKSIqZc5VuBI2j6f+ZJVJ5QQa0/XrZskbQAk2YoM4Veb7D2
	phTrimgmARRkBaD55sRRfWX3+M4oi1GKotRdQTVxpVxDqP0oci5zAwUR3zRZt9spt1xmk1XM5z7
	7ZEqFRys5WJCKLcs+aPh7Qi7I5kmCPQvAhvco
X-Google-Smtp-Source: AGHT+IFFPcfGdxOrdcHvod/jp84idSmv6cCfzgRiNBHd0VVYzw2Z7nXtwv8+I08eWG4GLmUC40YrJO4Via/IOcXVrWE=
X-Received: by 2002:a05:622a:2507:b0:43e:143f:d184 with SMTP id
 d75a77b69052e-43fb9f9acb5mr651011cf.20.1716582175215; Fri, 24 May 2024
 13:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521010439.321264-1-irogers@google.com> <CAM9d7cibAi-Xnr5HTCT6HB0sat=w5qicDrr+pcMuUF0OfNQRPQ@mail.gmail.com>
 <ZlDVLBQ84O7fN9K4@google.com>
In-Reply-To: <ZlDVLBQ84O7fN9K4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 May 2024 13:22:43 -0700
Message-ID: <CAP-5=fU7V9F2vq=E=vHyD2E=ijx61UCsE=oywd3mTG7mnO3ttA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Use BPF filters for a "perf top -u" workaround
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 10:58=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, May 22, 2024 at 09:38:57PM -0700, Namhyung Kim wrote:
> > On Mon, May 20, 2024 at 6:04=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Allow uid and gid to be terms in BPF filters by first breaking the
> > > connection between filter terms and PERF_SAMPLE_xx values. Calculate
> > > the uid and gid using the bpf_get_current_uid_gid helper, rather than
> > > from a value in the sample. Allow filters to be passed to perf top, t=
his allows:
> > >
> > > $ perf top -e cycles:P --filter "uid =3D=3D $(id -u)"
> > >
> > > to work as a "perf top -u" workaround, as "perf top -u" usually fails
> > > due to processes/threads terminating between the /proc scan and the
> > > perf_event_open.
> > >
> > > v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
> > >     using a shift as requested by Namhyung.
> > >
> > > Ian Rogers (3):
> > >   perf bpf filter: Give terms their own enum
> > >   perf bpf filter: Add uid and gid terms
> > >   perf top: Allow filters on events
>
> Hmm.. I'm seeing this.
>
>   $ make build-test
>   ...
>   cd . && make GEN_VMLINUX_H=3D1 FEATURES_DUMP=3D/home/namhyung/project/l=
inux/tools/perf/BUILD_TEST_FEATURE_DUMP -j64 O=3D/tmp/tmp.EeXFOfLPt5 DESTDI=
R=3D/tmp/tmp.Y0eiZKvc9D
>   ...
>     CLANG   /tmp/tmp.EeXFOfLPt5/util/bpf_skel/.tmp/sample_filter.bpf.o
>   In file included from util/bpf_skel/sample_filter.bpf.c:8:
>   In file included from util/bpf_skel/sample-filter.h:4:
>   /home/namhyung/project/linux/tools/include/uapi/linux/perf_event.h:29:6=
: error: redefinition of 'perf_type_id'
>   enum perf_type_id {
>        ^
>   /tmp/tmp.EeXFOfLPt5/util/bpf_skel/.tmp/../vmlinux.h:54086:6: note: prev=
ious definition is here
>   enum perf_type_id {
>        ^
>   In file included from util/bpf_skel/sample_filter.bpf.c:8:
>   In file included from util/bpf_skel/sample-filter.h:4:
>   /home/namhyung/project/linux/tools/include/uapi/linux/perf_event.h:30:2=
: error: redefinition of enumerator 'PERF_TYPE_HARDWARE'
>           PERF_TYPE_HARDWARE                      =3D 0,
>           ^
>   /tmp/tmp.EeXFOfLPt5/util/bpf_skel/.tmp/../vmlinux.h:54087:2: note: prev=
ious definition is here
>           PERF_TYPE_HARDWARE =3D 0,
>           ^
>   ...
>   make[3]: *** [Makefile.perf:264: sub-make] Error 2
>   make[2]: *** [Makefile:70: all] Error 2
>   make[1]: *** [tests/make:340: make_gen_vmlinux_h_O] Error 1
>   make: *** [Makefile:103: build-test] Error 2

IIRC this only exists for the sake of asserts. I can move the asserts
to placate the generated vmlinux.h. I'll send a v3.

Thanks,
Ian

> Thanks,
> Namhyung
>
