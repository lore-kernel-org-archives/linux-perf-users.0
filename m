Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E32153EA
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553106; cv=none; b=FDInBNA9T/2LQJ+JjtHqgclGu0Wtog/KiBjZkIgbaejAj1HesHwELEfeH2FVrf3gAzcCZwLtxMQ8w41xKrem5MaEU9ZLLsX06UEw0eU2uWSBsHeb6OInAzLoS+wSqB/skvWp0AI6ku+khCawiNRW8PeqywN6Zl1RYpvFu9SLt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553106; c=relaxed/simple;
	bh=LYW0ZhtipP8/Xrm5uhsXRZP/OVbkLl1LZ2Jg3g4P1H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEnEVRAr/Xj/XXsdtqRSM+kGsrgxC51bnFq1GJ6UOClWZvVWqhn4BMXO6inI038YZSioXMtDUhbd1Q6ExR3qGlwus299ydOlQDkbiwTM+pVN1WlEXKUysZKpEqVzD1CCrcv3DGWQW+ql59FeP5fIlFjjm+Lz8m3tc7h6cTwuGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=120B0Mcs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="120B0Mcs"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-242d3be6484so22395ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755553104; x=1756157904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhcnYV/5AHS3NB+DMqIzrtFHNwBfjNUqELn1LyD2twE=;
        b=120B0McstSfrZBgMI/1zm9sZY2sbjRe3unZc0WJxNDvkmGRGgaJFCr3sYk/2yANnfr
         YnqFboVG1Fvu9fuFANJ/r6kzW9btNSssDmEN747yRTLDTFLBOZfJs4/QL+xGp0qu3wdX
         g7sIilOzI17ouC5x9poh2sIygagfNjV+aT4gxltXh2tnlMF2InmKpzXLY09snGlMBGxD
         JxSAqfTAv4k57/sp/oZ2X5RBoX8goz1JaVY4OqsscC5PZKYxE7u6woATWPQnCVODEX3T
         WMNOb9lSv648xA6KBz4qcJJkjHXxRUn14X/gJIsC0A48Jv/Wo0UlyGZ3/JGpdNDm+4u3
         qEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755553104; x=1756157904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhcnYV/5AHS3NB+DMqIzrtFHNwBfjNUqELn1LyD2twE=;
        b=sw6V70nVkVdShCkdddM7YLNmsO/ADn5Q6XHXPbst+AdAgNV8VIW0Ld/XE9eu69wEFP
         +YvAty3Ux3TAuF+c0NdgYDfNXAxJ5K1z1AbzUPHEAWkY5nLKmOrXjq12YPANgmGYrJ4p
         /apGrznWbOo3zsTw1d3LWAAQ0AcOHIzxPDTsQKzwa+XsVQ0f0dpaCwp5WEBlYHmxtQhd
         vgaO9EEUhnQsqr5PhFnz1mRxs3TlpzMB/nbZZCjXIloZhCa5p1aGOsTy41oO1HbGTCCL
         yDK14iFuRswdM8LuhFN+o5Vv7MGt3+hHyI0LGTU2reZqCJnTDWLuCva/sb+GmCOjGClu
         ZzuA==
X-Forwarded-Encrypted: i=1; AJvYcCV6eAqfckCyM8ej2/QdeKE+LAHpntTSMuz5IG1FXbwd61k/D6AaGmYG+QXY+G1Wkrr4s60EEp5nwdPFvnAacx9g@vger.kernel.org
X-Gm-Message-State: AOJu0YzHavHVPMS/eTcJ5n51eZzrxi4+rkAHntfAGed4oFiZaNB+EA/w
	IIzcp/IvmknRkEnREZrHAtXhl2HFaGO59x7vX19wmDtaYT4qfVFRDC22ziAqQigPDy0lnKvkbPS
	91Bud+HAD3KvkkgLjN+evaMObxB8bvAvSW7DWum5Q
X-Gm-Gg: ASbGncutl9SjkMkFVj9QHqu9/NDm8bqvGEq/J1xsV+2iSr6Rf2R7nb3cQvUAuUrHbmY
	c6nhWiOb2rpnlnVKMK+ztp8a0gubVfPgiOozfhCYn8ZWGozhAYUyY3460NI67Im8YyLf3omwaWR
	7ulTzmU1jEvxm176gYgA8rD623MH+RQYMkqbWvfF0Xcyt5W5HxGR9V4t0ohPbzwp76XHxq+AeZO
	HUp1SUYnCFiD8LxoKWXElMrOLKXRo0bKfc62LvIAHJhtDwGVIa7wQgpHYyAJjFp
X-Google-Smtp-Source: AGHT+IFaPStKx7Mcyop16UEyKf81Np/31IArgVU8rjtYukefbi25th3TnORg7zv7GIxSUmdTI4omVi8T7VE7JEU+ue4=
X-Received: by 2002:a17:902:e54a:b0:234:afcf:d9e8 with SMTP id
 d9443c01a7336-245e063558dmr255405ad.7.1755553103628; Mon, 18 Aug 2025
 14:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
In-Reply-To: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 14:38:10 -0700
X-Gm-Features: Ac12FXxBq0slTx-nhWhlPHvSkVKp7BttdmbVWzZNF5teiKp6roW3gq1-CISAxIc
Message-ID: <CAP-5=fXdFQCgeF5DRH=-cUErz2opU98H6u1cTTO3ZPJ7SMQfMw@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf test: Extend branch stack sampling test for
 arm64 BRBE
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Adam Young <admiyo@os.amperecomputing.com>, 
	Will Deacon <will@kernel.org>, German Gomez <german.gomez@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:39=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Refactor and add some extra tests for all platforms which were useful
> when developing and testing the BRBE (Branch Buffer Extension) driver
> [1]. Then lastly extend the test for new features which are BRBE
> specific.
>
> Tested on the Arm FVP RevC model [2] and Intel Raptor Lake.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D58074a0fce66
> [2]: https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20P=
latforms
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> James Clark (3):
>       perf test: Refactor brstack test
>       perf test: Add syscall and address tests to brstack test
>       perf test: Extend branch stack sampling test for Arm64 BRBE
>
>  tools/perf/tests/builtin-test.c        |   1 +
>  tools/perf/tests/shell/test_brstack.sh | 106 +++++++++++++++++++++++++++=
+++---
>  tools/perf/tests/tests.h               |   1 +
>  tools/perf/tests/workloads/Build       |   2 +
>  tools/perf/tests/workloads/traploop.c  |  31 ++++++++++
>  5 files changed, 132 insertions(+), 9 deletions(-)
> ---
> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
> change-id: 20250811-james-brbe-test-f5a20dffd734
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
