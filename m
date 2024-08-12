Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC83194143
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495453; cv=none; b=ajwsn/3Tui+KrZDGLRzIBqs0223eYNbRX8e4X22vkUlmz6dIvZuY4f3q/wMUwBWEAWoGbn8oF7i0RlG2S79ulgx7ReaioZwqIq2zsI5KIekyKAABXzw7hBjcpEFCorpN1yOksFGhDhc4W/oPTcVq16afPydyeSWLDBvCrfG985A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495453; c=relaxed/simple;
	bh=OKt4cWE0ZR9fy32NKqDd7AWgvE7+np3QM+thgHcpW2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxFNgubkDxyPirGi7kv9xWqRt01ahz80uHjnHANXvWF6P17K7wSg18dYyjudBHRyZIBORyVobwNkRuUaREXjwUUEKZx6stsm0IGF0+puUGkCrESjzK5bmyNNMaOwYeMmphDCSfl4WtZn/DyUAhUWXfDZCY9wlhPDWoHe8usSlzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22fXSgrr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22fXSgrr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fed726aefcso6935ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495452; x=1724100252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKt4cWE0ZR9fy32NKqDd7AWgvE7+np3QM+thgHcpW2c=;
        b=22fXSgrrupdFxpH+x/JHVhqg7qke2JazogrGOB9wfg9fdF/YU2pY0F9JC4I/tcrffP
         m8cBZr9gYXS7JeFlvzVeuGPzGlySgpVw28IsZFWlXrNvx8O1cQdBObJ/2pHbhRTX5+Ze
         Htd3O04eX9GgmgWlrpJE0CkpsNTRmheupF9R3Im5n5Wf1g3D3J7JfGX0YQiT9pH7zeG+
         HqEUhi5i4FMQqgbN35LfcBSTjJszruEIE+hsJd7v2zCWiCHZca8R2tjiX5Dg5vOvMgZ8
         IKcXkLrbJZflO8iOO7WqPDOYZUjtphVzEMVKfhcKjwtZalAQrK4KKKw7i78Zd7TCulTi
         +RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495452; x=1724100252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKt4cWE0ZR9fy32NKqDd7AWgvE7+np3QM+thgHcpW2c=;
        b=IxXlLX5oBqvq8DAjcpChaERpqPmsEfnLvx4OagLS9ADlOcVHQGe6prHlbCST0ZgbnS
         Zy7DUnGm8whrEZZy7Pu5P/6hLEddck0RpOcG4lQFGlY98/M9BKI8GW1c7HiKdQN6HwIj
         BTv46dPMT/NMfYh3AZc+WjQa/QHHvYxDJcgphjhNGouNGmyT4GoHf3z22trep+GtTUM0
         CPC9u+vxv56QVBiVZfAdfoT5xwkgG9AWJs0JiG87vgWkWKlZ86uq85q6kEbyMxf/MX/z
         81c1YdIgsMFnHJltMVNR0dc0Vjeqq+kuJMjd9nZpKD6b5YolKgCnTdRa/LLk1FM9tqob
         C58Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpgIX8fR3Q+HZUOZpZGX2YbsXGwdEsqMdLgEIF4xx3eZLzMazhxP2tAJ4Y1M72KtBuAIcXn2t+/Yv3OtsY8W6YWuDFskQjksVomeDIbfPlQQ==
X-Gm-Message-State: AOJu0Yy3Gu6AgSWsBP8IpvDBnK0UniMkJxVPWXlZdDCSvr8TBP6e/p+H
	1I/wrih26v89DJzU42MRk7bf4d8uTt9Rm94tsyEwBsCuVofAwbcuNLDGof5N43Rdp2HO3i4uQY5
	0qjf5qNoznB3IGK1QvtEstej4wddEMTaAONF0
X-Google-Smtp-Source: AGHT+IGE5Tl+Gga3w/4KldporNOqhqhFglC+AC11EJZLS4naKh298Ze5RefiDxOY9/Atd5BoSplPlMUPy3fALcvgfUU=
X-Received: by 2002:a17:903:11cc:b0:1fd:67c2:f982 with SMTP id
 d9443c01a7336-201ccb368d3mr410965ad.2.1723495451258; Mon, 12 Aug 2024
 13:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801031249.176913-1-irogers@google.com> <Zq0kL-lyCqkM3P4G@google.com>
In-Reply-To: <Zq0kL-lyCqkM3P4G@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Aug 2024 13:43:59 -0700
Message-ID: <CAP-5=fUy6sx5ZMs6L1we2tpaq1iyUz4GW_ps7c7xE1zqjVzvgg@mail.gmail.com>
Subject: Re: [PATCH v1] perf inject: Inject build ids for entire call chain
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 11:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Wed, Jul 31, 2024 at 08:12:49PM -0700, Ian Rogers wrote:
> > The DSO build id is injected when the dso is first encountered but the
> > checking for first encountered only looks at the sample->ip not the
> > entire callchain. Use the callchain logic to ensure all build ids are
> > inserted.
> >
> > Add a for_each callback style API to callchain with
> > sample__for_each_callchain_node. Possibly in the future such an API
> > can avoid the overhead of constructing the call chain list.
> >
> > Fixes: 454c407ec17a ("perf: add perf-inject builtin")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Ping.

Thanks,
Ian
