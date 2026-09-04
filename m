Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E774F052E
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536066; cv=pass; b=pcMT1oGFg4XvE2+/ecSHOMY11Q6QKtRj6FA5kSLBgfleMVgdidV94yExhomT7THvw1Wu9ktvifOgVu5uPHV8PbbX7hMZcOtrhe6N517oi9pC8StR8OOTMam6MR188OuviNHUeu6LBMTI5VwpMHqPUIexT/A/HHngFF68pFst1pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536066; c=relaxed/simple;
	bh=FzVf3j0DElpuxBm+UFR84uBp4/6OPZNVJ6LWKu6fr+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQhOH5cnPQlUJ8oFWd5Hrcktta+WTjErO6xpSVq93Btfc5QZmGD8+Qhs70OzPqUU+I8iq7FhZueqcPopVGNYOyoP2pdsUlCRliRdRSosB4MAmI9hJG5LhvOKDsZqOVxf5L5HDUzhnZmxUqFvEJRUvJAgQIJ6AZE26Usg30k10qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xnc/zpZM; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xnc/zpZM"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so243081cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Sep 2026 08:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788536064; cv=none;
        d=google.com; s=arc-20260327;
        b=jJCymu6x2f8K6imPuqtEK5DsnmaZScxkvd3zUjlqFk41KGz2sgyeZ3cyvpuXVaKU23
         pwPWCanDpUfptN/qOz6h+RQig/SUVRrIFpt4jxAHKRq71t45R2yWjiu3VHawkPExHlVv
         j+LPdxdCjt7H5O9C1KbKm6MVTcCFl4vwH+YHaycLyDp49GNyLPxShCBri7OkpK8R/sv6
         ipzfX4esM+Zv0t6AqvJSwAp/92c8Snc8+djIIQanT0v+ZUYqanO2Ha5JETPtqfX3/7TQ
         Fp21PHgxbBt8mS5KDTA9zBT/MSr3M8OBwJiNh0S3iqdWAq/7xw4AO+7I7M5xsIA3/+Tw
         mg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lwu3BnDRwXYFAITY0rwPd5C8ikLKwVXNsQBsrH3pHvo=;
        fh=/E+ca5PSWU79IGJ2K1iAjYBVddKol5bUddkeWN3volQ=;
        b=HMwqFu+ZP93jR3A/o8T0LmtfhK0FtlElrKaKLNqGzptdRqMAgiC87AMnM+mkOm13gv
         ejfxwtboaRXkGN8yXQQxU2wUmNMXSGZXQyOvz6DIAQiQ1UtZazWkx69ZawDWYJw3xF8P
         +QE30ti0AAwXByIEN2Wp/uWzvE0i5Jpwa2vNnYd2aOFzJB0leFSURrYR6FBbRcli1N9N
         IIClBSWM5miRQ+KQHh2a5DV4yuuHeNBDBp5xHCneuD7WURfFUxiqysNGTifC7m3LGeZ5
         w5VOw0LHi7AGp0gR3BbKZAC4MqegGIzx3msE5NCv6sAJnN4aNG3ZZR36PdyH8T3Hfnb8
         DO7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788536064; x=1789140864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lwu3BnDRwXYFAITY0rwPd5C8ikLKwVXNsQBsrH3pHvo=;
        b=Xnc/zpZM1HzEoTQ3cI/tBYsqVVG2Ohizys7WP3pCQfQNwBzCRkyu3crgSw0USw+e//
         f8gEpjew722TgDFigxVsCdvoSfJTwZno9746jXirMRFh4QoCDlIbCN7/sD3E+9T6XMuc
         OF6RyQyyKDPTzGhcrlx2+aQmVZkvaFt2DtIDF3P/3qudcPC1zy7L4AmArBHz+iEemTGq
         R1+h5Rxg1mfcx308w4YIjSfr725LevFGXuc2QXf6VGmP8zQki73z1CojNNco660KpTcL
         sOmtpiJn2GvGVDfALeCFUHA1ArZKHSAoQU3cK3IoCgjPiyJTK6gyH6L+RYyTT/PTe0R8
         ksLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536064; x=1789140864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwu3BnDRwXYFAITY0rwPd5C8ikLKwVXNsQBsrH3pHvo=;
        b=ZXmVMLD9wyXifVlaenW8AMbYLzJYU5EUlqFTTtLW14sMG5EeVafOHeTVrcKxrT3Gko
         MLniURK9gcvxUqBwv5KofY4+cDmW1aENuMJg5XuGVeNOfH2Dh8pRcqyT9fTCF9WkOigX
         /sUEW5/772ctNwLEslOW/a0V/qfgGe3Y73FGmmZ6H66/QBc/dGH3anOYohftZrAT9cuN
         vB36RO7+W7q3p/vvkM3foRlxhMBoyUswtJi2vryWAWGRUKLnZOtmWXWbPjmrnBqvPOYD
         VUqK14CpFVZkB7IAd0/vEx0O1FqvEuo1q4Gog80doEtLfGBPU/wWJlyrVEV6Do7lDQXd
         IbtQ==
X-Forwarded-Encrypted: i=1; AKwUvByD6JS84qcjmQ5iCKnzA1ga8Wz96tCy5mDDWa36d+C6QWRfhStg1oaMUfMQWlzF+2Bi5uE93ZM4RJZjKGW/8g/e@vger.kernel.org
X-Gm-Message-State: AFuF++kq/yxlv2657nKDNTsn7yZS2xIyG3jS0yThm3+t9JbPsdlNLI7r
	Yxt7sr4reSNWSEGSRUm1brzWgI8os6Xv2TereSLrHNewMpdTGt/73TIQCkqCNgx7kjlygDA/wPc
	oRbRR86heSMSz6BMt7fUyw8gS3zAkkq4ze/qHn7ia
X-Gm-Gg: AYBFou2Lp5rP+z9MXY18MIcHy0s/ij+N6brJ0zZqh9JCr7V+4SiKq0AoFWtDmNuXx8l
	QVxe5nB8e0A5Y7K3pH0qQ17LaDCuYM5BXRKji+xUwYd7A4W2KO8Qe9bnmfq+8pBhXP4WekPeB0z
	jg1YxRsQ6k4145tEJAUzDFEnvjQX4qOYDVFfl967Az1l/d5J3aHW4r6qvl90f9nh5gQ9jlFpi+f
	73Usiv8U5WS3SvCsyOZ71InKZyHdIX+nX0FanBuScj7HHPnNeL69Lc56X4/L4wCeRW70K0oY1oM
	p9VGCzijMZiEtt2oIgy9d6D+aXF6WbcnRsNipbCZvfQfEW9Pbgja5WlG0lKPxi5M6f+7PPwIJ/c
	=
X-Received: by 2002:a05:622a:2307:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-5305583dc85mr14566791cf.4.1788536063097; Fri, 04 Sep 2026
 08:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com>
In-Reply-To: <20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 4 Sep 2026 08:34:11 -0700
X-Gm-Features: AcwNN1X8l7vZteLsC6B1Tn-ATbiYvd-I2Xq0o5cYs2PrOkgmh6Tezl23AbEdnMI
Message-ID: <CAP-5=fX1uKg8AncsP5BVFtchgns5TquOTB10-mR5ury2CaH0sg@mail.gmail.com>
Subject: Re: [PATCH] perf evlist: don't restrict uncore events to PMU CPUs
To: Nia Su <nia.su@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:45=E2=80=AFAM Nia Su <nia.su@sifive.com> wrote:
>
> The PMU CPU map has different semantics for core and uncore PMUs.
>
> For core PMUs, pmu_cpus contains the CPUs on which the event can be
> opened. Intersect the user-requested CPU map with the PMU CPU map to
> reject CPUs unsupported by the PMU.
>
> For uncore PMUs, pmu_cpus is just the default CPU to open the event on,
> not the set of CPUs it can only be opened on.

This isn't quite true. On a dual socket Intel machine, `pmu_cpus` will
contain a CPU to open the event on per-socket.

> The user-requested CPU may
> override the default and be used directly, and the driver can redirect
> the event to the appropriate control CPU.

Agreed.

> Currently, __perf_evlist__propagate_maps() intersects the user-requested
> CPU map with pmu_cpus for all PMUs. If the user-requested CPU is not in
> pmu_cpus, the intersection becomes empty and the evsel is removed before
> perf_event_open() is called.

Could you give a command line example of the perf tool doing this? I
ask because I'm surprised the uncore specifying a CPU behavior has
been broken. As well as `perf record -C` there is also a somewhat
newer cpu event qualifier.

> Skip the intersection when evsel->requires_cpu is true, which is set for
> uncore PMUs. is_pmu_core is also false for other non-core PMUs, so
> gating on it would have loosened this check for them too. Core PMUs
> continue to be restricted to their PMU CPU map.
>
> requires_cpu can also be set for BPF counters regardless of PMU type,
> but only when has_user_cpus is false, so this guard has no effect there
> today.

So the separation between libperf and perf is frustrating, and libperf
lacks the necessary PMU abstraction. Using requires_cpu as a proxy for
an uncore PMU test is okay, but it would be better if we had a boolean
flag especially for this. Given this, a comment should be added saying
that requires_cpu is used as a proxy for an uncore PMU. The real
meaning of requires_cpu is that the event doesn't support
perf_event_open with a thread.

Thanks,
Ian

> Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with thr=
eads/processes")
>
> Assisted-by: Claude Sonnet 5
> Signed-off-by: Nia Su <nia.su@sifive.com>
> ---
>  tools/lib/perf/evlist.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 1f210dadd666ff818a23712ab95acaa659ccf8dc..a1064175f12ba655a9f7fe42e=
7c7e4c49ae60423 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -80,7 +80,8 @@ static void __perf_evlist__propagate_maps(struct perf_e=
vlist *evlist,
>         }
>
>         /* Ensure cpus only references valid PMU CPUs. */
> -       if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
> +       if (!evsel->requires_cpu &&
> +           !perf_cpu_map__has_any_cpu(evsel->cpus) &&
>             !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
>                 struct perf_cpu_map *tmp =3D perf_cpu_map__intersect(evse=
l->pmu_cpus, evsel->cpus);
>
>
> ---
> base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
> change-id: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80
>
> --
>
