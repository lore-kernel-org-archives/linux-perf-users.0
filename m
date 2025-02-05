Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716F25A647
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 04:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738731507; cv=none; b=LFDS94QEOwgUmWaXXUGhqAJa83vYfVSIDcbPM4ndXstWoUL7OSS/dX9RfUhTyhp2CBmdsqVENj5hVQsOn8W0pOMwiLiXkn7zlNAmUGxp0BWSgHHS5ZCmkqc7V3eiXSLaj+jwOvejdQUX0Qs4Noo5m2CqdHKcn/wzgpZjpI9L3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738731507; c=relaxed/simple;
	bh=9WFzx6J/v5Plw43RdCEUd6Vhg328nO/Nojg4b0wrzWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4llyLTzmirhZ2XkIcw112aS9RKcImzhd7VpOiVFh7AdmlrqAfljk/HtJVA1atYcbVW/Cz1rB2Gep5B7562sutj4Jq/oMyUVvBYgg6eFrbyD7VuYdWkybLQRV+3UZnW69VE1bvAHLn7wOiHh4kVWtNy6wQkXnxxE5XI1TY2Vw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHpxrkyj; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHpxrkyj"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d04e5bd797so96395ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 20:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738731504; x=1739336304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4hCTtW+UNQasE56z17WAMyt4tEPi3GvC0a1WQoJPkA=;
        b=eHpxrkyj4ExAp0uiYiEpnRnXThXcWccjcOpC8bA9Fa6xEcZwgMv5+FS3o9hF9ngeiW
         5iJiRFvXNAh/yRnNwjsD25OBuakS7kA5Mp+MkpAV2Hxs/w55TLBBf0joMAcw6BF3gG44
         T9vghv2yg3COWmfyYa6hDVh/tfHzTPDIOROvULULcWz2PGE5K0hPli+XrcSPt33+S804
         DXCTfZfF4n3sgyrwQrXuG0sOY1PWhUWjYrlwgGwDehnvQSbcZTW8p0Whib/B+D0sTCYs
         wUVuB1DUHyW9judx2Lg5xayE5pUE3lw4u8KAW7d96QkZeDCIcB7Ljt16Pc7JYdSqPmn5
         FxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738731504; x=1739336304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4hCTtW+UNQasE56z17WAMyt4tEPi3GvC0a1WQoJPkA=;
        b=a84U+aGw9E+Qovq06Sz4VbMDlA7o22SyUMXMOKlqT44sEoiCxRnnBoWvwkxp7QKhJP
         lAhsu4QDOgLI066ItuFe00gkj8y32MaUCb9RmtjQ8dDxquwFdZPqf7VlbU8rQPckGlFf
         uTeQgzAVYg3jjBXEP/padwG00FuzFDGvDw9La/FYhmk7YYAgdKudef9h5AkDaedV9peH
         ervLkvOpJIeqqg9gkCiR6LWU7WwvKqQlU1SbzvyLALAafpZ1bEu4blKNcjQd3oHgPGB5
         dz3UUJghCklTi398lx2Kyr30k3jU0X4Np2ixJLwK5fuSW3Mq8JkVeZ1dk5JfVCKmmJoO
         GKqw==
X-Forwarded-Encrypted: i=1; AJvYcCXJMAkUiqTTEQZxR0RmCjU5HKQ83wkXtfIK2NP38QAdT4+3eVZz8GpcNh6rOLi9kpmG1ycnWgfkccGNPeDfVIJV@vger.kernel.org
X-Gm-Message-State: AOJu0YzANDqRkiFfjHSbbgK5yNvj3d8qEsHf5SjC9ICUfnH14d+HvZ20
	GHAeCMiIj2bcv31Ew50/hjbP3Dq3IhTY7vj7tovvNRukNAQB+0XZiqjqucqTe1IgIBt4WOYN5ZK
	0UE6K6M3KdEEvpv0E69IQATsA+NC1Kd6lzjuA
X-Gm-Gg: ASbGncvq2OtBbDzH8yXT3k+arZ3aCEGq9lABo5MZ8OfCzF3SsdzC+YvfHBoxOjutjc6
	cemu4RrcCQqDYW6cGLFmiCcSyqT7YQ7sh1xrJOslC9TqUU5XmMTHysrlyzjVjhTM6Nc+fHp3Eng
	==
X-Google-Smtp-Source: AGHT+IF7DCtlwiws+AUFDCWEi3ZzJPfywo536Jiu42HJH2ResZCuFJd3GpfNEGoINBVZsPY6DKofge8JxcTbg6yh2Rk=
X-Received: by 2002:a05:6e02:1a01:b0:3cf:fcc5:793c with SMTP id
 e9e14a558f8ab-3d03fbedef4mr6698925ab.16.1738731503647; Tue, 04 Feb 2025
 20:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204213259.127939-1-irogers@google.com> <CAP-5=fXpuND+kNe16CJMETkMOW+__eQpB8No0ra5gyEcfqCCKQ@mail.gmail.com>
 <d44036481022c27d83ce0faf8c7f77042baedb34.camel@intel.com>
In-Reply-To: <d44036481022c27d83ce0faf8c7f77042baedb34.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 20:58:12 -0800
X-Gm-Features: AWEUYZnSgAq-mLU5zO-rhdGZGS5UNLRNVu_ntvMGNswSGB_r4g5_i1RrsiHp-8w
Message-ID: <CAP-5=fV8EcxVZR0Be6wb57_VvssE9FYFBTmbd415CqmidGWT7g@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Intel vendor events and TMA 5.01 metrics
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "Baker, Edward" <edward.baker@intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"Biggers, Caleb" <caleb.biggers@intel.com>, "mpetlan@redhat.com" <mpetlan@redhat.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "Alt, Samantha" <samantha.alt@intel.com>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 8:28=E2=80=AFPM Falcon, Thomas <thomas.falcon@intel.=
com> wrote:
>
> On Tue, 2025-02-04 at 13:35 -0800, Ian Rogers wrote:
> > On Tue, Feb 4, 2025 at 1:33=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > Update the Intel vendor events to the latest.
> > > Update the metrics to TMA 5.01.
> > > Add Arrowlake and Clearwaterforest support.
> > > Add metrics for LNL and GNR.
> > > Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
> > >
> > > The perf json was generated using the script:
> > > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.p=
y
> > > with the generated json being in:
> > > https://github.com/intel/perfmon/tree/main/scripts/perf
> > >
> > > Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> > > <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>
> > > and
> > > Weilin Wang <weilin.wang@intel.com> for helping get this patch
> > > series
> > > together.
> > >
> > > v4: Fix TSC events on hybrid mistakenly specifying the core PMU
> > >     inhibiting the use of the msr PMU.
> > > v3: Fixes for hybrid metrics that were missing PMU. Update to the
> > >     latest events.
> > > v2: Fix hybrid and Co-authored-by tag issues reported by
> > >     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition
> > > of
> > >     Clearwaterforest.
> >
> > Sorry, forgot to add Thomas again.
> > https://lore.kernel.org/lkml/20250204213259.127939-1-irogers@google.com=
/
>
> Hi, I'm seeing some warnings like this and the all metrics test is
> skipped:
>
> Testing tma_info_inst_mix_iparith
> FP issues
> Cannot resolve IDs for tma_info_inst_mix_iparith:
> cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ +
> cpu_core@FP_ARITH_INST_RETIRED.VECTOR@)
> Testing tma_info_inst_mix_iparith_avx128
> FP issues
> Cannot resolve IDs for tma_info_inst_mix_iparith_avx128:
> cpu_core@INST_RETIRED.ANY@ /
> (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ +
> cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@)
> Testing tma_info_inst_mix_iparith_avx256
> FP issues
> Cannot resolve IDs for tma_info_inst_mix_iparith_avx256:
> cpu_core@INST_RETIRED.ANY@ /
> (cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@ +
> cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@)
> Testing tma_info_inst_mix_iparith_scalar_dp
> FP issues
> Cannot resolve IDs for tma_info_inst_mix_iparith_scalar_dp:
> cpu_core@INST_RETIRED.ANY@ /
> cpu_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@
> Testing tma_info_inst_mix_iparith_scalar_sp
> FP issues
> Cannot resolve IDs for tma_info_inst_mix_iparith_scalar_sp:
> cpu_core@INST_RETIRED.ANY@ /
> cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@

Thanks Tom, we've gone from a fail to skip - so progress! I think it
actually isn't something to worry about. These metrics are measuring
vector and floating point things. We run a workload, when testing the
metrics, that doesn't have floating point and vector operations. This
causes issues with metrics for these instructions as the counters
don't count anything. Because of this I added some logic to just skip
when we see these failures:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat_all_metrics.sh?h=3Dperf-tools-next#n51
but a better fix would be to have a workload with FP and AMX operations.

You could test these metrics work manually, by running something like:
$ perf stat -M tma_info_inst_mix_iparith <benchmark>
where <benchmark> would need to contain FP or AMX instructions.

Thanks,
Ian
