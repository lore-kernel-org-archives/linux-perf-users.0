Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF220CCE9
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413746; cv=none; b=f5t6iUHD/+KzLkXMIfEP3qnToA47mCvoH+X1ReCUn5dQ6BbKVjyzDY2CEq2ixv871vh4HV5OA7IsKtkwGBONs9OoNcXq58tuvP7qXiof6Kxh76ki+GuXsP6g0+6IfbkKuMkJ2+JDZN4OaWf0kOSkHyhAUEu3aStxhWQkBldQuSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413746; c=relaxed/simple;
	bh=+zuhLaxH9MmxnkDZXqnMzRfjUJivSeLI1ztnsjHJ5mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hzNxKaoD7ft22buGlgfhBGJLQRZqFOQasjgyx9wRGh+55KWcVcFYOI1VoeKrUoA5lBIVRskB5dYws+9HGGu/2anQkrRTqSz3sW5Vm+/we4WQAqKwktnpvjyp9/BeRd+8E4NUCDAHJgz/inWebTdhr+CQGLVIO/NmJlu+RAjDFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UmQzCTiE; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UmQzCTiE"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a376e3acfbso31155ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Oct 2024 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728413743; x=1729018543; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnBCtRlvEx3ZKIt/UV9o5i8b/79eZCcmuHkTA48mAfs=;
        b=UmQzCTiEgO+WyYpkvO0JaqcyOl2G1S1fPdT0jO1Mjf/awX8uOars1PL1mdh2ZdCBYu
         XO1jqqaThNm08ZW0/aOdVJWXLStKRJLCNXnVimYcb79SUJ+RU6IodBzYx0lBvQTgoUBg
         kW33VNO7njYfTY6AguoQ6s1KX00ajrTyMYBFPWUFAAsR9fqk8G/o6+pdEU0qze0CXTsG
         +qpJ0BcYJNWgkJ8/36i3+a2DKax/nFYqZrrSv4N7AZvjNiObM8FvOVkJexYvsGWTXMnm
         h8yE8tgIWY51hVAOwGOAch4N/PfcnjPJiSSUBdxJ+MAoWyjVscvIsHz+XBUxU9HdmKPm
         bqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728413743; x=1729018543;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnBCtRlvEx3ZKIt/UV9o5i8b/79eZCcmuHkTA48mAfs=;
        b=Z18xDPh1B1CbRpcfgt4n8lVMZmtym7SjjBXzJaiRBrgBVDbHzlgYUiZPWxvJQBjViX
         vvqLDu80n/rzOCbtpLo4wkgejayZ8adYDUg4X4xoiWm9efNinWGjh8VBkJ6Dk8YZnoRD
         KfKlQM/S05vOfULFs/Q/Qa+xTumdEpDfaa15VprqyBRc/nfpqB5ZSO+NmCYDI22Y3DAf
         qU9P+IJWqMX5vLUAFOMm0SmoVzY3FpRsEL8U5SolCa60hSTKrN5IWrPU2qiPcgI79y7A
         pGpAIB68CjI62FHuBi6/Yi9/U4Uih7LV2pVCMhNa8juZBn6WP+WH6EKVg/kaZVzMXpZw
         pNzA==
X-Forwarded-Encrypted: i=1; AJvYcCU2lsQkRQvrg3TYDMZjSdlGv0pOUOgWeOZPtgvrmK6uvYolVdzQQjAEyFN/rl5E0wp1XSwxk9od+r5cLr9qtqb7@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYaBQArUD03YCIt8SbD1ydaJSJTvhAicBECWFdhjX8JftmUdY
	VtTF/aDZRv0Duc46pTVhboIQnbNHUTEYLlGAHXRpi5lQcUfnLi4Dur7SdNHj8Yqerb5ufQFbfid
	epdyb+HT+aTANsZYwDVOGfcqQddn7Dv0tpboO
X-Google-Smtp-Source: AGHT+IH/0K+Hh1kTZmNc2d0CWTKQ0Np/4Ebdm2nSCPe2jK8tHK1iZNr8MYgQ36taTxrkopLBhO7nNhPZkGx5VNN7Ih8=
X-Received: by 2002:a05:6e02:1fe3:b0:3a3:690e:ba29 with SMTP id
 e9e14a558f8ab-3a396fec592mr467335ab.28.1728413742524; Tue, 08 Oct 2024
 11:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001171950.233723-1-irogers@google.com>
In-Reply-To: <20241001171950.233723-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 11:55:29 -0700
Message-ID: <CAP-5=fWExR7ae=dgiAG8BCtDN0XDwnzy9=SBbE0cy5S1Luw-4A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Make a "Setup struct perf_event_attr" a shell test
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:19=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> The path detection for "Setup struct perf_event_attr" test is brittle
> and leads to the test frequently not running. Running shell tests is
> reasonably robust, so make the test a shell test. Move the test files
> to reflect this.

Ping.

I think this is worthwhile cleanup for the attributes test. It should
avoid problems like:
https://lore.kernel.org/lkml/ZroNTkdA8XDFaDks@x1/

Thanks,
Ian

> Ian Rogers (3):
>   perf test: Add a shell wrapper for "Setup struct perf_event_attr"
>   perf test: Remove C test wrapper for attr.py
>   perf test: Move attr files into shell directory where they are used
>
>  tools/perf/Makefile.perf                      |   5 +-
>  tools/perf/perf.c                             |   2 -
>  tools/perf/tests/Build                        |   1 -
>  tools/perf/tests/attr.c                       | 218 ------------------
>  tools/perf/tests/builtin-test.c               |   1 -
>  tools/perf/tests/shell/attr.sh                |  22 ++
>  tools/perf/tests/{ =3D> shell}/attr/README      |   0
>  tools/perf/tests/{ =3D> shell}/attr/base-record |   0
>  .../tests/{ =3D> shell}/attr/base-record-spe    |   0
>  tools/perf/tests/{ =3D> shell}/attr/base-stat   |   0
>  .../tests/{ =3D> shell}/attr/system-wide-dummy  |   0
>  .../tests/{ =3D> shell}/attr/test-record-C0     |   0
>  .../tests/{ =3D> shell}/attr/test-record-basic  |   0
>  .../{ =3D> shell}/attr/test-record-branch-any   |   0
>  .../attr/test-record-branch-filter-any        |   0
>  .../attr/test-record-branch-filter-any_call   |   0
>  .../attr/test-record-branch-filter-any_ret    |   0
>  .../attr/test-record-branch-filter-hv         |   0
>  .../attr/test-record-branch-filter-ind_call   |   0
>  .../attr/test-record-branch-filter-k          |   0
>  .../attr/test-record-branch-filter-u          |   0
>  .../tests/{ =3D> shell}/attr/test-record-count  |   0
>  .../tests/{ =3D> shell}/attr/test-record-data   |   0
>  .../{ =3D> shell}/attr/test-record-dummy-C0     |   0
>  .../tests/{ =3D> shell}/attr/test-record-freq   |   0
>  .../attr/test-record-graph-default            |   0
>  .../attr/test-record-graph-default-aarch64    |   0
>  .../{ =3D> shell}/attr/test-record-graph-dwarf  |   0
>  .../{ =3D> shell}/attr/test-record-graph-fp     |   0
>  .../attr/test-record-graph-fp-aarch64         |   0
>  .../attr/test-record-group-sampling           |   0
>  .../tests/{ =3D> shell}/attr/test-record-group1 |   0
>  .../tests/{ =3D> shell}/attr/test-record-group2 |   0
>  .../{ =3D> shell}/attr/test-record-no-buffering |   0
>  .../{ =3D> shell}/attr/test-record-no-inherit   |   0
>  .../{ =3D> shell}/attr/test-record-no-samples   |   0
>  .../tests/{ =3D> shell}/attr/test-record-period |   0
>  .../{ =3D> shell}/attr/test-record-pfm-period   |   0
>  .../tests/{ =3D> shell}/attr/test-record-raw    |   0
>  .../{ =3D> shell}/attr/test-record-spe-period   |   0
>  .../attr/test-record-spe-period-term          |   0
>  .../attr/test-record-spe-physical-address     |   0
>  .../attr/test-record-user-regs-no-sve-aarch64 |   0
>  .../test-record-user-regs-old-sve-aarch64     |   0
>  .../attr/test-record-user-regs-sve-aarch64    |   0
>  .../perf/tests/{ =3D> shell}/attr/test-stat-C0  |   0
>  .../tests/{ =3D> shell}/attr/test-stat-basic    |   0
>  .../tests/{ =3D> shell}/attr/test-stat-default  |   0
>  .../{ =3D> shell}/attr/test-stat-detailed-1     |   0
>  .../{ =3D> shell}/attr/test-stat-detailed-2     |   0
>  .../{ =3D> shell}/attr/test-stat-detailed-3     |   0
>  .../tests/{ =3D> shell}/attr/test-stat-group1   |   0
>  .../{ =3D> shell}/attr/test-stat-no-inherit     |   0
>  tools/perf/tests/{ =3D> shell/lib}/attr.py      |   0
>  tools/perf/tests/tests.h                      |   1 -
>  tools/perf/util/evsel.c                       | 122 +++++++++-
>  tools/perf/util/util.h                        |   7 -
>  57 files changed, 142 insertions(+), 237 deletions(-)
>  delete mode 100644 tools/perf/tests/attr.c
>  create mode 100755 tools/perf/tests/shell/attr.sh
>  rename tools/perf/tests/{ =3D> shell}/attr/README (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/base-record (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/base-record-spe (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/base-stat (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/system-wide-dummy (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-C0 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-basic (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-any (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter-any=
 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter-any=
_call (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter-any=
_ret (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter-hv =
(100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter-ind=
_call (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter-k (=
100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter-u (=
100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-count (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-data (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-dummy-C0 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-freq (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-default (10=
0%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-default-aar=
ch64 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-dwarf (100%=
)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-fp (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-fp-aarch64 =
(100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-group-sampling (1=
00%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-group1 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-group2 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-no-buffering (100=
%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-no-inherit (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-no-samples (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-period (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-pfm-period (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-raw (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-spe-period (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-spe-period-term (=
100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-spe-physical-addr=
ess (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-user-regs-no-sve-=
aarch64 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-user-regs-old-sve=
-aarch64 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-record-user-regs-sve-aar=
ch64 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-C0 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-basic (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-default (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-detailed-1 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-detailed-2 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-detailed-3 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-group1 (100%)
>  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-no-inherit (100%)
>  rename tools/perf/tests/{ =3D> shell/lib}/attr.py (100%)
>
> --
> 2.46.1.824.gd892dcdcdd-goog
>
