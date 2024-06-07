Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B29134B2
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Jun 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781005; cv=none; b=olgIE93QmfWYqJkNQXhHK4hDkiVLnTiI16SAh97kkU4GTdwOdBH6BPTBJ8brntHT5qM0NVFihl82i0vLPNfDoqNc1zccwrLtjE30aoauD1Snk5V7nBaUFC+K4CABkPCgfvVRCHTHa7cEgypqOHzfrdmTj1rEuMTMfqtv5qlK1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781005; c=relaxed/simple;
	bh=p2lF+OviYBBW5AoVLpk3he9hABgq5Fw9ltxH6jMjt1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFg+JX76D+ahKBRWj1jXVNamvClXu2xN90Xy+oMciGusRLZTNwOC37WCp+yE5Lqt6HvD2I9KfJx+Y7wMO898UEHvpIsJxoD7SE7R3gs9KxKkuNvYAyUF2onU4rbNM2MtmGYIVBVGCceVTWh1bJlOhUiBgAm/9z5sdYAdcV68wgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFFjKqqj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFFjKqqj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f66ad03847so7015ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Jun 2024 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717781003; x=1718385803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W7eNzUkVsvxh0fs7QApe4zLHB8YHFiMurfzjOn05Cc=;
        b=mFFjKqqj7c6ktQUv0mgMm9nhOdnSWwj2EJsUhW7h83aXZusS6gV69WduC7AVHDf1Ap
         dlqpHxge5CinWpu0qZKDXuPMK0Oj37Pg/SeDWcCld//2oi+/QDw3Gc+2T2IX1suxt+6S
         PiFgxPpgiOnya/SY90TFXNWkazXg3w/7i//dLzYuAjxSuEy1+BZ6U2YZVAArAzIVVnC9
         RmeDEMUhSUq4VZeHnGzsiZ2Qdgh1DJLRz0yLA3Z/H/xCaBieGCQ9oaN7zsJKcTjBqFyY
         rEqvHNKV64IeXuuwfMAlQansLlhsMqiGqBDtzljM6zRhmwBKUystlE7t6IJ1/UjIOkBi
         5oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781003; x=1718385803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W7eNzUkVsvxh0fs7QApe4zLHB8YHFiMurfzjOn05Cc=;
        b=hzmfHoOqpCXI/atHUwypSvdGkPKh1DNcqBAOadKfYI5vQcmuayaHLbx0d/YnQACn6O
         lSFEdNq46wxW9a51opFWIWYZNsgIeTmvARZL2c7U5pc4NvTR73Z23aClUSqDKV2po27r
         ink9boz6dVhHeWH2Rb+JiVZD8a8NuO4eFKr/h84y5i/iXHl9rsL4C3YVlnbkmeqP3Ie8
         Aa5zyyrCE0TwalAvGMVtj9+b8YDUgAg30fTQAGRbq9m8K4JqhC31UbZhNsSLHRFPPaya
         mhvDaTAlsaWTADDImIMnYzAqwhBf5hSoI0QegaxJaLU9iklnF4VaDjItdTPPsJN6RusC
         8VPg==
X-Forwarded-Encrypted: i=1; AJvYcCUeNZTgYqbytwWTjuxtfvo5DU8Qb1saN1WtM5FP7tt7GwacEauZ7bSpyYtbXyZtc/lRKt1GFTtttsLSuNXHanbaJH/4ez0RuUA92VyXnUfHjg==
X-Gm-Message-State: AOJu0Yz0uYeQqUdH/xpn+qv9wgWnLc62pzBaSXFLqEkL3GjUpX9qpmm1
	bl/ZMcTmaf7gH0z0TiOnZPz4Xe0w1reUTgq8NqM1lqyQ8O3Yixya2z9y51MmBatjB4YG6jmaH1e
	i39IFb4rSZyXpxKNtnJX4XpFSg6LWpjwzdtPz
X-Google-Smtp-Source: AGHT+IF1kBumIybHOnEycCWnTnGC0ewzKueFu/6w+DPgOcUa8Oae8IA/SWiwu846ZjxfYxHaSpC5xnVHoTfKDKov8ws=
X-Received: by 2002:a17:902:6b03:b0:1e0:f525:a831 with SMTP id
 d9443c01a7336-1f6ba65584cmr7839045ad.28.1717781003038; Fri, 07 Jun 2024
 10:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Jun 2024 10:23:11 -0700
Message-ID: <CAP-5=fVCXW1FEBra5aFLJm48f0-b4a+oTugTZt+VYEv1EySBKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools/perf: Fix the nrcpus in perf bench futex to
 enable the run when all CPU's are not online
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:44=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Perf bench futex fails as below when attempted to run on
> on a powerpc system:
>
>  ./perf bench futex all
>  Running futex/hash benchmark...
> Run summary [PID 626307]: 80 threads, each operating on 1024 [private] fu=
texes for 10 secs.
>
> perf: pthread_create: No such file or directory
>
> In the setup where this perf bench was ran, difference was that
> partition had 640 CPU's, but not all CPUs were online. 80 CPUs
> were online. While blocking the threads with futex_wait, code
> sets the affinity using cpumask. The cpumask size used is 80
> which is picked from "nrcpus =3D perf_cpu_map__nr(cpu)". Here the
> benchmark reports fail while setting affinity for cpu number which
> is greater than 80 or higher, because it attempts to set a bit
> position which is not allocated on the cpumask. Fix this by changing
> the size of cpumask to number of possible cpus and not the number
> of online cpus.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/bench/futex-hash.c          | 2 +-
>  tools/perf/bench/futex-lock-pi.c       | 2 +-
>  tools/perf/bench/futex-requeue.c       | 2 +-
>  tools/perf/bench/futex-wake-parallel.c | 2 +-
>  tools/perf/bench/futex-wake.c          | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.=
c
> index 0c69d20efa32..b472eded521b 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -174,7 +174,7 @@ int bench_futex_hash(int argc, const char **argv)
>         pthread_attr_init(&thread_attr);
>         gettimeofday(&bench__start, NULL);
>
> -       nrcpus =3D perf_cpu_map__nr(cpu);
> +       nrcpus =3D cpu__max_cpu().cpu;
>         cpuset =3D CPU_ALLOC(nrcpus);
>         BUG_ON(!cpuset);
>         size =3D CPU_ALLOC_SIZE(nrcpus);
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lo=
ck-pi.c
> index 7a4973346180..0416120c091b 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -122,7 +122,7 @@ static void create_threads(struct worker *w, struct p=
erf_cpu_map *cpu)
>  {
>         cpu_set_t *cpuset;
>         unsigned int i;
> -       int nrcpus =3D  perf_cpu_map__nr(cpu);
> +       int nrcpus =3D  cpu__max_cpu().cpu;
>         size_t size;
>
>         threads_starting =3D params.nthreads;
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-re=
queue.c
> index d9ad736c1a3e..aad5bfc4fe18 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -125,7 +125,7 @@ static void block_threads(pthread_t *w, struct perf_c=
pu_map *cpu)
>  {
>         cpu_set_t *cpuset;
>         unsigned int i;
> -       int nrcpus =3D perf_cpu_map__nr(cpu);
> +       int nrcpus =3D cpu__max_cpu().cpu;
>         size_t size;
>
>         threads_starting =3D params.nthreads;
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/fu=
tex-wake-parallel.c
> index b66df553e561..90a5b91bf139 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -149,7 +149,7 @@ static void block_threads(pthread_t *w, struct perf_c=
pu_map *cpu)
>  {
>         cpu_set_t *cpuset;
>         unsigned int i;
> -       int nrcpus =3D perf_cpu_map__nr(cpu);
> +       int nrcpus =3D cpu__max_cpu().cpu;
>         size_t size;
>
>         threads_starting =3D params.nthreads;
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.=
c
> index 690fd6d3da13..49b3c89b0b35 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -100,7 +100,7 @@ static void block_threads(pthread_t *w, struct perf_c=
pu_map *cpu)
>         cpu_set_t *cpuset;
>         unsigned int i;
>         size_t size;
> -       int nrcpus =3D perf_cpu_map__nr(cpu);
> +       int nrcpus =3D cpu__max_cpu().cpu;
>         threads_starting =3D params.nthreads;
>
>         cpuset =3D CPU_ALLOC(nrcpus);
> --
> 2.43.0
>
