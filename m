Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556AC134B6
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354853; cv=none; b=uN5pGToZEhlpUuXrSAQBZ5RvnTrzybrxlKIRUAXjW2I6WuGsOU8OARJWxtPloSzCjJfFq1r2ZiokUmr6Xmb8Ee3p5tv0Q4cxKGyWDF5umLvaamGcPg0nKPKUL6UL3ic+sX6zLY2Do8O1eIvuOKbJqVa/Sjn/fOpoUx6DSsU3bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354853; c=relaxed/simple;
	bh=fyJKuZVK0pU5Fqrwlw0rK18hA89S7OCk8Zi/KbuJDu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trmjqBrWRoaVHfo0c8Mm3hxJzLB5YceZ1ePTlM5PtluXlN55xh7eyj3GP1seDeRO5WtixcBDNzy8BNPoWKkcLOvky3oKCMVe8tfbKTorunTirTC/RW0OR+MeBoN/k4d8nFOGCO+xn5PH+eB35kZUXaliKHsLMZzi4RPh74yDWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hforSMyS; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hforSMyS"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so179675ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 05:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727354851; x=1727959651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0YaFbmNZZQ27EGzEPqm3xDYI+YQcc7orYNQOKUIa6A=;
        b=hforSMySCYG+QYOm7PwSRP7tpcLKiHTDPQS4QvpSBLtvy3dmWm2vRp4rXCuohYTRNV
         HKM8/ANPvUmRtIPw/5oInl2oK2vejyu9uuwjaQKxXuibx3pWb5LUCpmCTEZ/ivl3eFmk
         YptOESiXEEJPqmj3TrMExRZTPLKcGWb8CpFCKLU9FhhOY7zZIAhpdJkhsVgwFtFl4Lhr
         cuyi07JAxRd4iqYYlWxoFw1qqPmdpM9MnPA+4EatwsFJmhRuEsYhNT6tLSozwZSpWsUG
         lNO5lqzXRW9dBzP023pUWu4k19ECB9+d/Y8K0+uXWCe2ODnLfSY6nx9r1W7yiEYl6Wjk
         VcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354851; x=1727959651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0YaFbmNZZQ27EGzEPqm3xDYI+YQcc7orYNQOKUIa6A=;
        b=QwRCLGwipxWsd3XSQrOdFnuhDBheHlYVhL6cnWz5vw6F1qZYcbmp8OXt68qiRlbNd3
         vimq7nXzh0mFAxHRvbZfG3yJhzth4USBHQ6KGGa7Dr9+U2fNDRtu5wqta96qCDfBniYD
         3ehy5nUnSnSnFOHTLvg/uZNr6t+dG3ekDKYiNOgAtlQUwMo7MI6qFz1R5VPg714qvRe0
         qv0fRluCWpemr4jq8B6ZPQwqV+Snu7axZ+8u49AU4oDdrm6yPvVemrPBwUGBM5OkSIq1
         wEECreMU8WFkUZRZ05XUFPX2T0z7YVmPPTMaJ02YME6NJtfYRA0LQzIvscUVdL0lytuP
         e4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXqMpBnQYlTzI47H5YMCfEnL1rP5uqhNwtqBPvfQxNC62MHgLXU25LfOc7yqedIkgWb6tBJy/EFmOrVVRK85lYl@vger.kernel.org
X-Gm-Message-State: AOJu0YwbYYY1eGxkvPZjzk+BaUU9Z7njik2ZFN7sBe+uwdqHjW2mF5+6
	TMKgh/umAry+Pj2Ll596o6WA4a3LCre2uqQgheWF/hSqEkM4VG9a9jSCmEAQex3lozwHQj0SMzx
	sLzqpTzf4njiN/m/s0wius8szYGoInwKpr74y
X-Google-Smtp-Source: AGHT+IFMqRnqwjKxa87XgLmW7djRVdBS3k0K+n7Ne06XPBn+bzv5sGNN+Zof85NBIEtS+boDmLekH2h0LRsTzu1U784=
X-Received: by 2002:a05:6e02:1c08:b0:3a0:b597:3e30 with SMTP id
 e9e14a558f8ab-3a295eb02ebmr4428815ab.8.1727354851210; Thu, 26 Sep 2024
 05:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-12-irogers@google.com>
 <ZvTUo_nbr_gKaJrs@google.com>
In-Reply-To: <ZvTUo_nbr_gKaJrs@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 05:47:16 -0700
Message-ID: <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > The name dwarf can imply libunwind support, whereas
> > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> > make it clearer there is a libdw connection.
>
> While it only covers libdw, I think the idea of this macro is whether
> the arch has register mappings defined in DWARF standard.  So I think
> it's better to keep the name for this case.

How can the dwarf standard exist for an arch but not define registers?

Thanks,
Ian
