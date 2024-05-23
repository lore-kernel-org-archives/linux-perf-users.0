Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB12135A;
	Thu, 23 May 2024 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716436500; cv=none; b=kJeOylqySm+W/IMOcR4JcV65tAjcKjyHHPPL6Ne2QPkg7n4gkhWhE/B0/+KkUEgeMXrTqmuksd3QC+UYSKVvIq5NocWi60gyngTKPq9HWSvZQb4/zKYHHepdJ39zWIwKk2jBv2UDqyXU+LU/pHBzboka7l97T0a/RtNzOuPe19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716436500; c=relaxed/simple;
	bh=Go6SiNCfeJUdVgN3zYhSpMRnchcwKA0GJsce12HTHDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8HCAM2Bw3jDiOygJQUO/XwS7lgxst2qOcXFEtTMtHSkc7yog1cEpPC1n+/ofUWpYpdGFywpvqgNQDt6ZEC7k6waN07CQwRsRi0x/29OIb7RadZEeyx/qg/FBh38u8wXReEqs6lqCiOFQLs4LSf4nckHIfyFKR1KFEnlAbItvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b432be5cc9so1816689a91.3;
        Wed, 22 May 2024 20:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716436499; x=1717041299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRPbctajEJQ+OrarxkB0WxLHRGG7ia+xYS63j1TiSgA=;
        b=ED7DPr8Fe+ypSC2FSnF05sbTi9keBgpn7NlxJv1+KCWxWsUWrnQL/RFRjDC4q+9d9V
         BvERdd7dIX7/BFRkQ+/HAi5ft2pw4rtrcShEzf7qLlSb20wHqkJUCKu+SmuJ0CuY2xqQ
         ugJp00y134aKtmxGSN+xpwYrbRKH9+ncn+7g/oixHbOSgxlFk8Hp/wYLAURqdvYF93iM
         PmtuWtX92BhXlqhmGgcV2dU42ZBjC2r1pqfmzyDEgVJA2N61X2HdZFdmlYLKfq7C78Bf
         snxtwMtk5G/86gEDLU4OHdal+TmlKQ/sbh/nYNSzgzlAeh/5vLiDq1s9Ln7IHtKlU+0T
         wg4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIGWPAtGhs4W0CXJMlWF7FTdk8iG0hAAAcsSU7fRNS+4bbpcvxJGsrIATkcmnDqEGz8f1TKnoWqVuEgqFrnsY2oV0fmWwfSrOQuAFCKEC0AYmrIldaUMjwJ/BV1fFbxPrS/I9e4yjp4f2sst+9Gg==
X-Gm-Message-State: AOJu0Yzh3QqKMPz9mGKyZdqR+pgTwwhbYaZW0KsGpFh4/YBSTfvGEN9J
	HLpCRRw13hefOeKLh2pZzbTVKYgonC80oINauw4yYR6ygnqC415BUqvSc2gLcivXy7BDn9t8Map
	TYpQbsuF5+BLKzzRiEwJOrdbK1fk=
X-Google-Smtp-Source: AGHT+IFK5ohmi6tZVGwhysQN5wcEzJFUHFPo6ywFw/ZjY9EIIcTezXb1WrOpmsFzZjgIAv8sEYqZB88q3NTUzmFhsSs=
X-Received: by 2002:a17:90a:cb04:b0:2b2:7c52:e175 with SMTP id
 98e67ed59e1d1-2bd9f49cde3mr4257630a91.31.1716436498738; Wed, 22 May 2024
 20:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515060114.3268149-1-irogers@google.com>
In-Reply-To: <20240515060114.3268149-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 22 May 2024 20:54:47 -0700
Message-ID: <CAM9d7ci60-Enzz9LkU8X7aE6PCeanqS13dTg-ksfTbq4B=jcSg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Ian Rogers <irogers@google.com>
Cc: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:01=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> The mrvl_ddr_pmu is uncore and has a hexadecimal address
> suffix. Current PMU sorting/merging code assumes uncore PMU names
> start with uncore_ and have a decimal suffix. Add support for
> hexadecimal suffixes and add tests.
>
> v6. Add necessary fix in pmu.c to perf_pmu__match_ignoring_suffix that
>     also needs to ignore hex suffixes.
> v5. In pmus.h remove needless addition of #include list.h but add
>     stddef.h for size_t.
> v4. Workaround GCC build error by using unsigned types. Don't consider
>     short hex suffixes as suffixes (e.g. cpum_cf) and test this
>     behavior.
> v3. Rebase and move tests from pmus.c to the existing pmu.c.
>
> Ian Rogers (2):
>   perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
>   perf tests: Add some pmu core functionality tests

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/tests/pmu.c | 99 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.c  | 33 ++++++++------
>  tools/perf/util/pmus.c | 67 ++++++++++++++++------------
>  tools/perf/util/pmus.h |  7 ++-
>  4 files changed, 164 insertions(+), 42 deletions(-)
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
