Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9E156F20
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770514255; cv=pass; b=CCWR9NF/m/P9GtAwjMah6tOec00E/j/5HBLTCXrwvMD3nwlAJb6DNiASN49dLR0lqpyc77d6oYSnx1KOOJG08bkScHsNE1qzyyJZ4dkHTT98Pn6vMrehB54aVMR/lkV61GMr8jsur/FPd9RKck8JLPzClrOrxh197U3OPlGZ8A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770514255; c=relaxed/simple;
	bh=SJznve9q0RFCzEPXWMXNglZ096a+2EbpXbrBMYsoGsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ib9if7ljd2wbnNgRoDAIu6WnhIUGH4lXewr0FOKRMm8uvfyK64X6LpZxDXI6l5hA98uS536EyQBuWldpSlnIWyYdY9HbDhGgN5UUXozwAoiRH0/dJxK944IyLAaK3/1zxkGx+uvhIvIS+FJIQUA3OhDSOn/DsLsUZ6w6qfHoDtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYnR3HPS; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYnR3HPS"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a964077671so51915ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 17:30:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770514254; cv=none;
        d=google.com; s=arc-20240605;
        b=ijM2YCOFlBbJkRo4LhAO6iM0nfMs2dtfVwhUHX13Pl4Oo0HFLVjgkAQfic8/tlsPVB
         BOiNHxLI/thYGYmvh9kEYLDY+M65HFWfn3iok473W6jR6CXXruUHev45JvX3KzuZHYyI
         +cHCz6F+KMz61Jbbq4RLGzAQC5k0jgLHg8yyNiqXx1S2pWbYOrW7tW92OgcnnCqPSvK0
         JGDqtxC3z4zcr7T/YfM9g8N90IM7rTN0u5Wi+oKQtgDfq9ujnQlcLwKvwYrJFwIosRKA
         Lv+YROWZJ5/gwAw1vWqbaQtDsZPTHmqTKgDAfL+ni7U9nunrOi8le/73aATKQKNeByOg
         DchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SFTFd+ntCHXWKupR0DlGEpVCJHWA7XjSDK3TIMVORtk=;
        fh=JYEBXZNthwtnD7OqzhVthfpdTzZbFXpnllj1/S1b0vY=;
        b=WNQrZQDBzLqqY+HcaxMOCfUUhO7hMuz6qwHHXLOQ7Zll83MGhL/IYTD8ogIsJBlsSL
         paDlMwjj7PX5FIKKgyifM8runAuLaxjeYnEh34V38YulAoIrLu4BbmP+MrwksAOu/mmG
         R10s8Tmg2ddn/zT2evqVCMsFLZrkp88fiqEdzfjENFe+KBg6ANOiWnpPMConGosZLzL2
         suUPk6FogEoeo3WNZYDcLCX7FPa9gVvrQlhc8e20IP1EpYy0dpd1rFupVjGhTSWapjLn
         Uw8xyuTzd97iPYhtffNXKpzMXNUTs2c831I1yLsJxPgLqpQCSC+vaQLiJwrD4mM+wxh4
         i3yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770514254; x=1771119054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFTFd+ntCHXWKupR0DlGEpVCJHWA7XjSDK3TIMVORtk=;
        b=eYnR3HPSpdvVZHNbMqbFRlAf9/xhpV62mcP9rVY4YfTo9tFC4X01rqE+mrWHJokrv4
         ZP9z/LSQv7ceyYYhMFqTZqkGNoT0/rP33dHljfElYyWqEo8KDfcDAfZT1KDHSw1uUcaJ
         eUM9TmB4zXOAfyGOUTrA7IZfmKvj23vsVggZf6LZohbICS/H4N91Xerm7IuWVC+XVcy9
         rmmq+b0xv0MbFMWcBqsFS8awnOoLIDqga0k8mMqedNroZhtv2ahtChmZVteCJfNkb62O
         OqsVoSuQhcU3e1Ep64soHKx3sqLZnIZbtBw0gEtcj2I06ukwIyDNvWrI8rHa13zHW74s
         XQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770514254; x=1771119054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFTFd+ntCHXWKupR0DlGEpVCJHWA7XjSDK3TIMVORtk=;
        b=kRxkrGSOGPk9rh0Eqa2KMD7+1XTWc94nO4OjkxRtqGFU/DoPYgyB36j+X6Ssa8w7K9
         LCSuiHkvlt1xjiBv3Xs9tGMvVhspZBwfcC0FWe2hGzCnrtGIKYEnr6q+NWSr0BgOUgMR
         wAr42fxfuWLCGhqhO8aJpS7+Oti35kqgI4OifdiYFCYXZ062eOxh78L1CpsZXP8QavXu
         AqM8DVQo7zv7f/TjS4o3c6nOBd152mITCrU3vKW0fntAs3RrPywv+bMogWw5ttV7q4+I
         x0Eamqkz0sawryygUL1aXr3ei75Eqey8O+JvkvgiP1L/fsStaeGe7CSSoO27J5v0ol1W
         52ag==
X-Forwarded-Encrypted: i=1; AJvYcCWFp6JqUfMjtkaGxAaGCF/tR0YtADU8uP8gSinIefzfzK+EajqomFi5S3W4AnsT+f2JQu22W8Dr6mNUtjm7Syvi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+4bp6jcffmhnE/gFYm8espSNL/QXiYeKgFI+lDigAkwDmI7G
	4fxFtfPoDdcuV96EXlVZtKs7GGu9jJZr8eAAtf/0msC56ktrv+T8ZIOOV5dfWG7UtFRyMdy+eis
	ZDYwlpfnC3XtNkx2dtVTdyVYY80sMUgmWEIBzE8tT
X-Gm-Gg: AZuq6aLyTXYQgHd0KGm52eCJ1bnh5DhJh1BgmTjdkPfAMkrfio7CkH29AdIPc9K7EUn
	gAla7urXbcuLv1az0haMxkmaseFUltLkMzO1C7EKYroLbmCjI031OaAyYruyppbPibwrDlxwNct
	j0Z+dfbFUJLD6bXglhEwbDLfviUBW71FZFSyvyD9gVPSjtEbas18iE3OEXAQWe96BamCPHOSwNR
	phPQdzGVCfAu9gE6QQhSbPJrlEr9llrbSB8sCdOxrMt3vKDE0UgFv7PaJwFmebSBM5cmDvz
X-Received: by 2002:a17:902:f546:b0:2a3:2844:98cd with SMTP id
 d9443c01a7336-2a961e2ed8bmr2705245ad.8.1770514253794; Sat, 07 Feb 2026
 17:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203230733.1474840-1-ctshao@google.com> <CAP-5=fXL0Dw5v4VoNJhQ78adCHhvPQLzyjsophXx-j-FXGwuWg@mail.gmail.com>
 <aYZaT4eZCGHDMAui@x1>
In-Reply-To: <aYZaT4eZCGHDMAui@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 7 Feb 2026 17:30:42 -0800
X-Gm-Features: AZwV_QjH6F6_nEGrp7Ekw-bwsXqqDM10fIECZfLiiGbA2pmXZtwP4n1mhvNdDi8
Message-ID: <CAP-5=fXH1tP_x22_YXi3F3POjjTxc8216o6=F+19XSYEWGwgOA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Ensure metrics are displayed even with failed events
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, kan.liang@linux.intel.com, yang.lee@linux.alibaba.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:17=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Feb 03, 2026 at 03:41:30PM -0800, Ian Rogers wrote:
> > On Tue, Feb 3, 2026 at 3:07=E2=80=AFPM Chun-Tse Shao <ctshao@google.com=
> wrote:
>
> > >   $ ./perf stat -M CPUs_utilized -a --metric-only -j -- sleep 1
> > >   {"CPUs  CPUs_utilized" : "none"}
>
> > > Signed-off-by: ctshao@google.com
>
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks, applied to perf-tools-next,

I've started seeing this test failure following this change:
```
$ perf test -v 59
--- start ---
test child forked, pid 2316256
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
Using CPUID GenuineIntel-6-8D-1
found event inst_retired.any
found event cpu_clk_unhalted.thread
Parsing metric events
'{inst_retired.any/metric-id=3Dinst_retired.any/,cpu_clk_unhalted.thread/me=
tric-id=3Dcpu_clk_unhalted.thread/}:W'
Matched metric-id inst_retired.any to inst_retired.any
Matched metric-id cpu_clk_unhalted.thread to cpu_clk_unhalted.thread
FAILED tests/parse-metric.c:142 IPC failed, wrong ratio
FAILED tests/parse-metric.c:293 IPC failed
---- end(-1) ----
 59: Parse and process metrics                                       : FAIL=
ED!
```

The following fixes it for me:
```
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metri=
c.c
index 6bbc209a5c6a..7c7f489a5eb0 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -41,6 +41,8 @@ static void load_runtime_stat(struct evlist *evlist,
struct value *vals)
               count =3D find_value(evsel->name, vals);
               evsel->supported =3D true;
               evsel->stats->aggr->counts.val =3D count;
+               evsel->stats->aggr->counts.ena =3D 1;
+               evsel->stats->aggr->counts.run =3D 1;
       }
}

```
I'll mail it out as a fix.

Thanks,
Ian

> - Arnaldo
