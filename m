Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C317E3
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jan 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705730968; cv=none; b=CcAourztOjCI4/kreVKYp5I7pzGqf/VLUwx0hWkmVC/s5Iqul60HARvdrwynRpEHbA/Oh/jd45tAsK2mazcLKovePEb9pGF5oFZXl4jD46Lt26l8Q08ilX2y1p3BrYiH+cSoAn8UQsUSHyJLcRv03gTMpIdf+Jc3q71hyZGwsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705730968; c=relaxed/simple;
	bh=/sFV2h+bdopGqXwAbHSprshDUjsvNBZLXaDaFOj36LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyDPyQVYkmlXDK1t5gCgXTWjJfLwSbOvihhrjWsBZOFaVovdYgoSUjMvHGiaWNd0MYq2WLj+MwvEQXassB+fSE7PrM/gZ1q7lKkFE0MjJ1e/wHbmhHxLXyc6cbKrfrd/q1F/nfZo+lQ4IMazFpqUWYpO4+IS5moDNRB1ZADdc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0D+lB00v; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0D+lB00v"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4298fa85baeso68011cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2024 22:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705730964; x=1706335764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhNlK+JQLQHesBMvW3n62OoJt8v0x6O0uKXTvgDlIjE=;
        b=0D+lB00vuqIOlIFoJh7R3FVHcYGV3etGEwqPNXuyXiKBCBxS4lJUFDnOqrUrIV9muR
         2CeSisSZoKESiFKbFWJ+MC0wSNoayOBcvLDdvMQfLM7fubXti6dj0r3F9sSiDGsreHzk
         mm0xV/OFdtoDi77+XSaqefUgPisBrBeV8WpEocqLeUtLiWWm+ZieLs0wIZU1VxXZ9POL
         vPxJHO+1DP+OIQPWebB6RowFTggA5Jk5sA5aKdvzpFAYemHwinQ1OctC76zcpTDEsKre
         XI/pGcqMuKQT2OZpIBvDDkW2WplAOBbKpU4BuLsP1uitlv7wZF/AZOAWUpRtYkc8wXS/
         Y+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705730964; x=1706335764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhNlK+JQLQHesBMvW3n62OoJt8v0x6O0uKXTvgDlIjE=;
        b=ugrD6QurCPxgma5bFrW7LAlzjovORxEH9pRbTMATYAHKlMwVN7+kJgwpQT3FPx/Xn3
         BruXoLj0qRBrbSOhAhDqN9chAPYHWmd+ePmGyif93ZvwxSpB9D/sO/26Pmqk02ksKa5r
         yHrGynaU+mIYpBxcJM4wzHmWTBIYuVFSloqdnDULXT0kelef79pd5Q2qCKf1OyxCVkKZ
         qg+F/LVrntlUAnCcpMR2JeDNGG5Abc6SFB1qMrgR+dKH1x1W8HBCcbnFf5P/iuJcwvFD
         TYzG7jdyDXp4Jtzykj1D4ZLUS19OzDDBvgJi/nY9JhlSQVnlccTSCNEcqRcKEUAarSO0
         mh0A==
X-Gm-Message-State: AOJu0YwE36XVgXgDab4G46bPX6rDUwOF1iGf4At5EfEKzUhdxw+oYM2d
	0Xg5sU9ex3K3N11qe6X/VbNyCKeSSJTxwz9h3hWLGmcXvQGR
X-Google-Smtp-Source: AGHT+IGnfOWpHiTvOFGye2heWhER/hXbZ1yM58x5lyWtxxBqB1kQm4vmyoxlBhmkye7BGdU0z4wFT2ODijVrgLCGSE0=
X-Received: by 2002:a05:622a:6092:b0:42a:2e9a:2841 with SMTP id
 hf18-20020a05622a609200b0042a2e9a2841mr22012qtb.1.1705730964503; Fri, 19 Jan
 2024 22:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZYbm5L7tw7bdpDpE@kernel.org>
In-Reply-To: <ZYbm5L7tw7bdpDpE@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Jan 2024 22:09:10 -0800
Message-ID: <CAP-5=fWVQ-7ijjK3-w1q+k2WYVNHbAcejb-xY0ptbjRw476VKA@mail.gmail.com>
Subject: Re: perf test hybrid failing on 14700K
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 5:55=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi Kan,
>
> I noticed the following problem, are you able to reproduce it?
>
> Happy solstice!
>
> - Arnaldo

Hi Arnaldo,

I'm seeing a test failure on Alderlake in perf-tools-next and wondered
if it was on your radar:
```
 32: Session topology                                                :
--- start ---
test child forked, pid 539222
templ file: /tmp/perf-test-HMet21
Using CPUID GenuineIntel-6-97-2
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 config                           0x800000000
 disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 4
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 config                           0x400000000
 disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 5
non matching sample_type
FAILED tests/topology.c:73 can't get session
test child finished with -1
---- end ----
Session topology: FAILED!
```

The code is hitting this line in evlist__valid_sample_type as
core.nr_entries is 2 on hybrid not 1:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/evlist.c?h=3Dperf-tools-next#n1215
this causes perf_session__open to fail:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/session.c?h=3Dperf-tools-next#n129

Thanks,
Ian
