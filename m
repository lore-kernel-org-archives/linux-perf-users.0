Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC384355801
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067716; cv=none; b=mcL6nxCxg8tp+vCtnDbxaW1BOOjq2bJDfuzlPyQxxrZCnN3IRtIpITd8nj88E7WNHSSD1vQrgJttH3Tmz0EE2sEb776K5vTcjhAOGIvmtFGAit0jxx6S0ITIs2ajCe4RY5M1L7P8BM37a/I4QxtKlK5bGURXCw1LxBP/hma0km0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067716; c=relaxed/simple;
	bh=LgeXmUFyk3qaIqo0Rp774eDhtGk8Ghfak1JKFfApf4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGqJ8M2DobMch7bKIifet+XBfsz+eGY+ar6rsWHYa47jZYcUY1dMawAlOJW2DlKvmfEdhytMl0q0lH3sSqm/ezgq/+Dwyj6pKgmQJ3g9zGDL7PM+X6hNefh2iUoluUSDaPGjSTOnxxefi6rP8xoEGF4sBUeeoXzAkro3ftlbX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdbfwjWV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdbfwjWV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4711b95226dso47540035e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067712; x=1761672512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVHCV64PvtiReRqCpWYpH2m/B54XBvjNGhPUP38ZlYQ=;
        b=LdbfwjWV1/rW+erJxWyI9N15vGetIDsU3fA+YV+HltklPWb/WK4BZrRLplpkTxt3in
         uoyeWFTnf1P6DTgzkotmSmoJodXGCi+7ZCWjNNWqk7yUZxD8T3GOHQKV7ZfENVdqXSsy
         iyUmzAXshrw5SoEAUSg+1tC56MU7qcww1TpmSDKIIPA1nedCV+r1+7sDjpQMZw1sCtaX
         ZfrKHVWKv+m6CKRZzj5TBw9vgsZXsC+k/062iX7Tz3l27KT/iDT+w3ZKk1MYu1Bk6Dod
         ylSux0j/+xkfH2q1np0t4OQDHvIRc2NcU4WfzLe34A9zb0upJb3LzmHdB1rXwAx0L2p5
         hdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067712; x=1761672512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVHCV64PvtiReRqCpWYpH2m/B54XBvjNGhPUP38ZlYQ=;
        b=f8b+Erkf7975W+tn1ISV7NUORJCi0sSiEP2KOJA3s942433L7DSGYMHCJtkg6RB37N
         rpYqxeYgJs0A/3+2EcgrQAmEdYm3yYTME7huUAWhcNJaVgMVqdf8khCkeGjTydQ9NbE1
         cuE6nXcHccsX9oTq7LyfDs9rghX6zs9+S8x2ACfvIvyzstVu2hOTKIB8TCm+JmQcJxy/
         UijywH1VEGcdiVhZR2a2NfThPUhKEwaAa5knNDbutN4F51BOtjdEa5cB0+4TPbh/fWcl
         SvDoLuhg11swc6sSdT3BtsoE8XZkYDltvIch6ao/SAlb4f5rGldyb4lGMiy72VJhCHK0
         mODA==
X-Forwarded-Encrypted: i=1; AJvYcCXMOFInT4IzT0iFykqEljT/uyVadYHktJC/RmGHSiQryD2uzEncVONvNru+V1QW19TKm14Y6QqFocjUPUFggjce@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCp0lDccsN8R7b59gFrz17HSVCQ9mUdEu3qe67xD8qvdWmB+H
	nXZ0KCPjttEXF/biAuk4RLjkSyMuDcmqbgUe4pdfNVIqCPVYQGIJNyLGvWrRCcnBL9Un5B8Tnar
	TDs3YDtp9eoKWN6OaIjDHiybRdi7KeM0=
X-Gm-Gg: ASbGncs+Dslww9lyDJmCz8xoh7EpAfpzXj98L2qPFqAU59c2iq5cerzK21tGXT/HLrm
	POY3Y+3HpIYW4qlmuz0JNs6gBricIN95xSol/NSE1J5TjxjsQlhDzLxKXmj7ua2HuDQNPlWRncS
	GA1DGP8Sj8x0aemkl3KxdVIcvPgkBm11dK4DdaS8AzTpVbCuATajePUl2Sdx+0rI/VfuEDGrimy
	xyn99BNQQ30aC8KIX7INcCuk0W5gRiynq07sgpxxyChZ1vtHRzHcdlD/uygXJU+J7LXHPaFlr7C
X-Google-Smtp-Source: AGHT+IHFn7gR7IuAx4widloDDlPnBPo9AwHt/0RV6fPlW05wXxkH+rY61gYgiE7K+aWrKofOe680pbjuspBOkxZnkh0=
X-Received: by 2002:a05:600c:1493:b0:471:1c48:7c5a with SMTP id
 5b1f17b1804b1-4711c487d74mr87072565e9.9.1761067712035; Tue, 21 Oct 2025
 10:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021160633.3046301-1-chen.dylane@linux.dev> <20251021160633.3046301-3-chen.dylane@linux.dev>
In-Reply-To: <20251021160633.3046301-3-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 10:28:18 -0700
X-Gm-Features: AS18NWBjnzTPARuhNgmAxCmDQioPAWs9SH3Yg-doGNGp6Bbr_qslNv97F3cxhhg
Message-ID: <CAADnVQJ2BrLy1FVEQmnN33ZqNZn0Nge1n6V89=p4NptjQNyHog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Use per-cpu BPF callchain entry to
 save callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 9:07=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. Drawing on the per-cpu design of bpf_bprintf_buffers,
> per-cpu BPF callchain entry is used here.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 98 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 94e46b7f340..97028d39df1 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -31,6 +31,52 @@ struct bpf_stack_map {
>         struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>  };
>
> +struct bpf_perf_callchain_entry {
> +       u64 nr;
> +       u64 ip[PERF_MAX_STACK_DEPTH];
> +};
> +
> +#define MAX_PERF_CALLCHAIN_PREEMPT 3
> +static DEFINE_PER_CPU(struct bpf_perf_callchain_entry[MAX_PERF_CALLCHAIN=
_PREEMPT],
> +                     bpf_perf_callchain_entries);
> +static DEFINE_PER_CPU(int, bpf_perf_callchain_preempt_cnt);

This is too much extra memory. Above adds 1k * 3 * num_cpus.
Let's reuse perf callchains.
Especially since they're controlled by perf_event_max_stack sysctl.
See Peter's suggestion in v3.
And for the future don't respin so quickly.
