Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C825A655
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262589; cv=none; b=euYib7Q1DzTd37F9LRtMwK4FkQgMJJp2JGAIKvRXNdlmzm/q7gGkYlQvzBxXlHTt0IBVBiKxzwVfBpi61CHHmjURXkLj9ijFk34+0xRehFmFrF79DfNI8hoPZhJQEq+uL9g8aOjuM0wnTQvxOpwiD3PjQi3o0okN300YJ4E5D0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262589; c=relaxed/simple;
	bh=Z9NHbEqAoo94vhfduf5skwK10qz90lPKQlXG0FCrBLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ex+sng1GETBcwuFVD0/QBuWKE0414qVMluI6+hsWNBb/WqtwmNT9ZITsdBmaXj0GhykVKUufiXHpdGLksld5e3SkO8abB1wV/Gw5XGQqAljwmpQjUq1hQ9llnuqIe8w5vQ2EnqvNxPTNWigo9/kR34RIbgmeeLEvPfo4+Mf8/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jb18FxTH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jb18FxTH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27d67abd215so52515ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759262587; x=1759867387; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0cT1RAs6oKsEjGjLNXsHeYyU8Or78p3qoc3PSshpCM=;
        b=Jb18FxTHLaYpEN1s7P5WAfEO5aH53W0v31Dt4ty5vYscZpWNtk8DSIEsnyCX9nJOUG
         z9iZ4wO34buTmCgq7nxNvzLXS0PoZS9h48xWcLqa4MetqK3YUzVc54GK60m3NxJop5T7
         VH4o1vxrho5NreqoJya/4NKfZZIG6LP8i4bJT+2dvcZIAlH/cQ97fqenLy2GvMyUx74x
         6QoKaoZRtnOzvAsoEXDuH90GLg5L4u7EcZv4b9CxvGW1KIv345WhYdX4QOyjCIq2hOqu
         kYgLEf+a8AkE5e8YOC54QpKqTKb9OpXK0MEB215aMixBxuGi1uw7baQBTz/31ujoxurY
         SCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262587; x=1759867387;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0cT1RAs6oKsEjGjLNXsHeYyU8Or78p3qoc3PSshpCM=;
        b=k7+UnKz+n6UcpPYnCX0fYTULQMJwhGjxgKEGDhMNeubUF6fxrFVPL8EEllNJqQv3Gh
         u3c+QOAe6XKqM7fQenftiJl3+VQB/B+VV7cggJxrvcA0Ww9rmdG9X9OMf3D7/EUzY7k0
         rk5TJX9Cl8p85SUrPHtRJTLRd/dWpvqQphVv9hiiNy8pgy3vpBmgI7U1S1ooFkRxhGFv
         IyZQI6IFZQI3jAllndF1ZFf1N4T6f9lExa15Sd/WgDJo6oHBnCWFJdtMviaUwgGTrv7K
         f/1giTmWDDWzcN5GY+BI20EuSDj0PEV3mZeBKin7LGfq/Ff1THGsrvn811jft+5O2vMW
         Z32w==
X-Forwarded-Encrypted: i=1; AJvYcCVOb0vB+EW402TB2SiixDTNUkoitd73n7japST4ZWpt1+3fvTmo7kVzKUdBFoFZNs9+ad7OhctX8LHwYfNupfow@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6DEOIrw9K/Hf4tWaZJgZAYG60hYMdAoEFM6avGvfbe6uEOUn
	s9T684W9bXGAExuO6G3/sYH7IqGguNql8dw6TIP7kjdfSBb0+VF/Pm8AOFDMPaXFovIPlMdd5Gj
	N5fxpZSiYBg1EbYaviXfLerLIcOweHUN3HsQtKskm
X-Gm-Gg: ASbGncu7izi+1k1la78dcvl2PavuGlI9qVRtN8DL58tY1XRU7mM3GoB9U/AptOZBKon
	pOtwXluPso3yhHuz2pciLLhtP+RCvSUzUxFB3vQK2Hi5VuJlIWNaDwbmbON2I7aMB/+H4XKXTf6
	CaiJbwR4gxEh57V+1llrZ/r/Gu/CzilO5hHfijQizCk9+09IH4leYG5cNKJPIAR2rWIPHhffnyR
	v7fbHpxAGPnFa2CCo4sh35ODfTTl157HqzF0A5PbZzLv5q7uRmR6IZ2QxRzWynmGtAW
X-Google-Smtp-Source: AGHT+IFa4zuETd9i+m/UdKS6kqS6S1OjhAGhOjt5CRjx+tasF9kSrsO82VkEwg6Zmh0mEdptxRvU9NQQwtYqO3qzab0=
X-Received: by 2002:a17:903:4b0c:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-28e80054ba7mr983905ad.16.1759262587055; Tue, 30 Sep 2025
 13:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903184248.695267-1-irogers@google.com>
In-Reply-To: <20250903184248.695267-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 13:02:55 -0700
X-Gm-Features: AS18NWB7QPcjHfrAVgePWCrCMWuylVtQSOkipi84bsIK402pvy6HcqR_3pBSwRE
Message-ID: <CAP-5=fV-3d1EzYfZq6s9M2NrLFFVOrWOTx_k5tByScA4Sfqq-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:42=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> The 'import perf' test needs to set up a path to the python module as
> well as to know the python command to invoke. These are hard coded at
> build time to be build a directory and the python used in the build,
> which is less than desirable. Avoid the hard coded values by reusing
> the existing shell script python setup and determine a potential built
> python module via the path of the perf executable.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/python-use.sh | 36 ++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100755 tools/perf/tests/shell/python-use.sh
>
> diff --git a/tools/perf/tests/shell/python-use.sh b/tools/perf/tests/shel=
l/python-use.sh
> new file mode 100755
> index 000000000000..fd2ee5390060
> --- /dev/null
> +++ b/tools/perf/tests/shell/python-use.sh
> @@ -0,0 +1,36 @@
> +#!/bin/bash
> +# 'import perf' in python
> +# SPDX-License-Identifier: GPL-2.0
> +# Just test if we can load the python binding.
> +set -e
> +
> +shelldir=3D$(dirname "$0")
> +# shellcheck source=3Dlib/setup_python.sh
> +. "${shelldir}"/lib/setup_python.sh
> +
> +MODULE_DIR=3D$(dirname "$(which perf)")/python
> +
> +if [ -d "$MODULE_DIR" ]
> +then
> +    CMD=3D$(cat <<EOF
> +import sys
> +sys.path.insert(0, '$MODULE_DIR')
> +import perf
> +print('success!')
> +EOF
> +    )
> +else
> +    CMD=3D$(cat <<EOF
> +import perf
> +print('success!')
> +EOF
> +    )
> +fi
> +
> +echo -e "Testing 'import perf' with:\n$CMD"
> +
> +if ! echo "$CMD" | $PYTHON | grep -q "success!"
> +then
> +  exit 1
> +fi
> +exit 0
> --
> 2.51.0.338.gd7d06c2dae-goog
>
