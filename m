Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6522E3365;
	Wed,  5 Mar 2025 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204741; cv=none; b=NEVcVMEXB+LojwMm+znPnMCc67lRey6QiJuMWxWGfdAxDjeOZ2ZEErqPvO6rh5sJPPbpiZ5AMcWXcNB2yQfwWUB6Yo4c8d2Sbs2Czd/wlzfem1vI+IwWLGpS9C81Fi+Vokzs1FExNmywb5ABOWMwrfX45dqFlp7HEtNpBi5/Rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204741; c=relaxed/simple;
	bh=rgWUhepNWVcyfwGSqjFipmjHMd/7q124bJ0FeQo2L/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzhcxuYptPabBQsWsvETiDw0260x9yIQ+OWkdMBKN9fdBnKcluiGKGIdrhhPw0+n8V+pZIhU0A0pyEB+qWgVkn4bzoobcEajYSaXotsVMu+ofnOMq9fxicWgis5rI5HVWh4vemZIdK/xeFz8EG6XmDvp6sFOdyJmw4/BjJfuPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzG/xID6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzG/xID6"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feb9078888so12435343a91.3;
        Wed, 05 Mar 2025 11:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204739; x=1741809539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1PVaYBpq9076U3IWZXvGpb8FBXofDXNAhkbJyruFPI=;
        b=KzG/xID63yprQEA8UprCojeOTDqG4jp67ner65I9Y0ItaBqaq+75YEacu1VkucPMi4
         32o+sFrO487CVQFfhKiNDSFaFNl96EH7O0GI2AAf+ErR/xHjCorl+uzSGSLu4suIOJ1i
         eGJvpyT+jrfPs1RVtWF94XhC7+Xf0ikEVPgzV3thyNb54OjEQVdFTmK0wtjUpjNBCbrH
         ZVoqW968f3rtg7BRm3ypvVZlz+A8tkWxuqHzZKIOEJAVFs+HpWZ/GNlFwH6nr66g91k3
         pAHtZXCfY1GR5S9gjwLAR7GQKsOaN90BLhamObDRvqqXCnFF1yq/vDENJeSiEsNJb9fK
         uEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204739; x=1741809539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1PVaYBpq9076U3IWZXvGpb8FBXofDXNAhkbJyruFPI=;
        b=Bs3HkHrwjv2P+HFKIUIVUJo5XlrqCcHEtfo4E5aKu8sRXdo+N3r1/Xk9B42evJIHYN
         EQvVZpcc/V86Bcs1cObHG83Us35q/QdyB3SDqRRdzoE94owLjeRQLxyvcDQke3QR4liF
         OPE5cxgWzH+StWQMIcqh2T9kVrnpeABjWBSZwgt2qXKz0SZvRe/1oeFjLuGk0ejf3zIp
         xTPmxPV3L/h3Th92kRZwD0VqQl/4fQiogo47Ppyy7Y+/GjR61N2WH6hM6Hu52vhYWCZ7
         dlf1lWkALSTHqSKQdbkMxy52qRhGPg8AnAVOlLKKc3HsBCLxShRXCXo5lYfstyM68nqF
         HFOA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9XIJ5xKSo/sjsKx2/1cSStRTuhQkbl/DdYqau8m4rV06NUKghshC9OOCvTvqOkiHkrdr6oFMQV/Z0t1byr6/Lg==@vger.kernel.org, AJvYcCUqynC72Nh7xvjnuqHSWrXRVyqwMjNzmXfoSDFfDFe+dZRnMVkchXlJR2vodLSxcDu1h8qobWOmH8P3HPQoCPetRfUe@vger.kernel.org, AJvYcCXqhoHoq74tvp1qWdKlh6ThfH6rmE3VES0WSP1KojTII7hHewpI24JlPP22lcif6hs6dCk3LCfKv9K6mnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2Y1EPrnIIIFVsG80POudDFQTJ0HJGNVjq8Iv+IOMtBxkAiG9
	MuK3p5krAiR0KtqsUHuRVvRlrXLsU6Wu0Pe3PtqwQ+iILef3OhLGB9KSCS2Mmv8dZTpuy8DAWb1
	kK8YDXDEOwbp+7Pc6B0ssz9vsmkY=
X-Gm-Gg: ASbGncvMCL19Lac8aHPjz1u0Zp5sv9kbSBNqnSmG2a7T2c6lwNjq5xa3+PozgQrOl4y
	gdLE6jMkul66kth6som1RnD/xsu62BOC6gDW2/myjlT2P48YWZtKRmM3w38A2hZlduBI+YvtKKP
	yI+9o/Sz6qhwVyk6K8MjytJOE8
X-Google-Smtp-Source: AGHT+IFfV/6qDYoZwPNJLCBtJE8ZyU4iJr7//K16BTPN6XDyLemrI4fIv4EKbuBvHlLWUWsZ7sQslXNBrtC5L25iHmI=
X-Received: by 2002:a17:90b:3d12:b0:2ff:5ed8:83d1 with SMTP id
 98e67ed59e1d1-2ff5ed8d53fmr1796280a91.19.1741204739474; Wed, 05 Mar 2025
 11:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304154846.1937958-1-david@redhat.com> <20250305152055.GB28112@redhat.com>
 <CAEf4BzbyFy0eQHLac3zR8GiGDOUqYoTGAWDbFaeou903OGOTpg@mail.gmail.com> <62f93f79-a8d4-44a5-b276-3ac5af4ab25c@redhat.com>
In-Reply-To: <62f93f79-a8d4-44a5-b276-3ac5af4ab25c@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Mar 2025 11:58:46 -0800
X-Gm-Features: AQ5f1JpNR9XR0Xgny3rOP3g1v3FV71Th_LHZWcRds0Sk3eNMx_5PJFuIV4e0zaU
Message-ID: <CAEf4BzZcc6D3u5ATQmpkBt=8EhNuG7Xaibywx=hXcXTp346uFA@mail.gmail.com>
Subject: Re: [PATCH -next v1 0/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
To: David Hildenbrand <david@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Tong Tiangen <tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:47=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 05.03.25 20:43, Andrii Nakryiko wrote:
> > On Wed, Mar 5, 2025 at 7:22=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> =
wrote:
> >>
> >> On 03/04, David Hildenbrand wrote:
> >>>
> >>> Currently, uprobe_write_opcode() implements COW-breaking manually, wh=
ich is
> >>> really far from ideal.
> >>
> >> To say at least ;)
> >>
> >> David, thanks for doing this. I'll try to read 3/3 tomorrow, but I don=
't
> >> think I can really help. Let me repeat, this code was written many yea=
rs
> >> ago, I forgot everything, and today my understanding of mm/ is very po=
or.
> >> But I'll try anyway.
> >>
> >>> Are there any uprobe tests / benchmarks that are worth running?
> >>
> >> All I know about uprobe tests is that bpf people run a lot of tests wh=
ich
> >> use uprobes.
> >>
> >> Andrii, Jiri, what you advise?
> >>
> >
> > We do have a bunch of tests within BPF selftests:
> >
> > cd tools/testing/selftest/bpf && make -j$(nproc) && sudo ./test_progs -=
t uprobe
>
> I stumbled over them, but was so far not successful in building them in
> my test VM (did not try too hard, though). Will try harder now that I
> know that it actually tests uprobe properly :)

If you have decently recent Clang and pahole, then just make sure you
have kernel built before you build selftests. So above instructions
are more like:

1. cd <linux-repo>
2. cat tools/testing/selftests/bpf/{config, config.<your_arch>} >> .config
3. make -j$(nproc) # build kernel with that adjusted config
4. cd tools/testing/selftests/bpf
5. make -j$(nproc) # build BPF selftests
6. sudo ./test_progs -t uprobe # run selftests with "uprobe" in their name

>
> >
> > I also built an uprobe-stress tool to validate uprobe optimizations I
> > was doing, this one is the most stand-alone thing to use for testing,
> > please consider checking that. You can find it at [0], and see also
> > [1] and [2] where  I was helping Peter to build it from sources, so
> > that might be useful for you as well, if you run into problems with
> > building. Running something like `sudo ./uprobe-stress -a10 -t5 -m5
> > -f3` would hammer on this quite a bit.
>
> Thanks, I'll play with that as well.
>
> >
> > I'm just about to leave on a short vacation, so won't have time to go
> > over patches, but I plan to look at them when I'm back next week.
> >
> >    [0] https://github.com/libbpf/libbpf-bootstrap/tree/uprobe-stress
> >    [1] https://lore.kernel.org/linux-trace-kernel/CAEf4BzZ+ygwfk8FKn5AS=
_Ny=3DigvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com/
> >    [2] https://lore.kernel.org/linux-trace-kernel/CAEf4BzZqKCR-EQz6LTi-=
YvFY4RnYb_NnQXtwgZCv6aUo7gjkHg@mail.gmail.com
> >
> >> Oleg.
> >>
> >
>
>
> --
> Cheers,
>
> David / dhildenb
>
