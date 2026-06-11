Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8138C2C3
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215645; cv=pass; b=X9q9CglKBPwgQ/mZOtLPvQvnowb4fRqs4fAK1HJuymqANyTQLNy5ivnZfPpPTAMIwSVp91vm/RIOmp9YhSApZ4PNUQHQY09GW6KVWmFQ3yk39HNU2dMmeZn2nEpDcFQsTE+CJvL2cb3yta3L8xs+MI4VG5sD0HoeV4WB0xcksY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215645; c=relaxed/simple;
	bh=h2/MxG17S9dCxFv/rie96oQWMUkjAs0Q6OxhaL68j8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwZzB3z3/LRVTlpQ9VAr/MV3iheFLiLxWRT2rHrKRE7TzPvWlpqtPUWD8lAcaC18aINjv6aP1VRewI3QoQNOJQkwsyknlALdRjMTnAN2Ul3HIvZe0kGWgKTiFsxWXNKJGqDXZFkbV1zxikdysF4r9Z0y09SIYccCuHlAPmif2Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+4Cv2ZW; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+4Cv2ZW"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1370417c01cso395315c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781215642; cv=none;
        d=google.com; s=arc-20240605;
        b=jBXNTJb1mNjJnK/IKRP0HsVgtMlfCHbKUY12A2UrjOyTNeZpnBCuy3nUUNjQr4T/st
         fcpREJFn/7oE5LLhpQHuNUpcz6dJim38DAJTB2ujAfKlOAcwq4Vh54L+GwCFdaNU8JkN
         jFkd1DJAcJygIWFwdR3NR2p1DJ1jTzJOxDsuounUPIEPVFor0GhvjSfINM4Yzb5ji/2E
         S4rzlrB/+iDKL1hb091Gr/QMvhsY5UDXcS26cSeLm46XQC/unz1Kl57zTStbXYyQwrNx
         HxO9GbAmYC6drR/sx7Zps0C18JvLeXLm8Ahf4vosZgMTvSLJg0dYO30xKFE6LcH2eQGZ
         LPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TvjVDTcc2WKsaWPyJBHWN4IzcPg3xyq/hNdDNapGPLU=;
        fh=q4i1QdncwdfNErAow4MJPRZuLzXXzaKrn5r+02Nu6Xg=;
        b=LQjxm/Q8whhFZ9faGJ+Fixiwo33tXeem1ILZFd2XqRyZui8ymJkA0fdWOftSDrcMtC
         ZEB19g6OMm0/Jw1b3QCY6AopTD1xH8i/7Pdw003stVHz8UCN/PMAb+PS9yUVSVWLjVe3
         rlJWw7FdjHm7GVoh4jOkHIqRPQWjUFDSoB/NO11OQfaz/RTUaX0vxitPeJWUPHpDJJlR
         i4MFV6d7lOkeVepqamlImun5vF8rnGBlAn9gHoC4zdA0nYRlKk0UaNUYTBeUwu9t+JBy
         xzTYFCixJd9Xi2/Ug2p35+eJT8OBulS36YmgmjAnawB7mOIBdKZ7qFW4Vt/Mbr67NHIB
         GDyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781215642; x=1781820442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvjVDTcc2WKsaWPyJBHWN4IzcPg3xyq/hNdDNapGPLU=;
        b=M+4Cv2ZWb6dKAuZFp/90NMzRyJKRWXz1PkHcq1csY83lglyc6AV8RfJkOkpcVJzoTo
         8r96hhA/Ax0A9YNGlS/C/mA0w7XhiAyUEgB/GGXWFdu/zGPNndAx/ZWA/fSv1M3Rlg55
         ZxcSSse0tKrlS95dR3LvdWB8nW9BKGEQYIQKEunCbsgHq/ANS1/kObP+5zgQVl8L1G+2
         7W9WRShY502NT9gXprztjqHpm5sFjEB1bUJkfnqkxLMunrCplPHt1zFw1tYok8HYKo8p
         tha6Oow1mPg/kdyKV42NNatlYp1nryBJgd/EPHnKaRVfS5hnM5rbpFMltgymHhCI2fBe
         cmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781215642; x=1781820442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TvjVDTcc2WKsaWPyJBHWN4IzcPg3xyq/hNdDNapGPLU=;
        b=bMLlh+fK81SjToFYxL5R2hfzutLVnMl18hr3F6cSdn9KCP/DZYOLLqwFPXq8HzgfDA
         WTgUxoAvoTDZEAqc6fadoEcSP6rWPqquhMEXzyYbSaAWBMEyV+okBSo9SSOFZN6n2kSm
         Sdpe6hg1klN3op9vhWJYTKH80Dufvx8rcBUnee/CBaXO6bJUG1LKMkN4yBLwTqUfnl5b
         /bXdejwsqMwpYv3NxoeZDTe7dJqySqJw+iEH5EZ5EIl7OPJ2Q5R8d48ZA4YzFmBrY+Nt
         wvXLRX8oBznTH2m5qAAMrb94QxItdTr6e/JLVujTULIhiOcdF+xa19BZ769F2Cy+eUUS
         nEpw==
X-Forwarded-Encrypted: i=1; AFNElJ+5j3E3Xh3x/lUndziRqIp0tXSHcihCh8qRQKGdbjZdwGVt/I0knRzn1q28zocjagNXmsSRkULarKkg5zZPkRZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7qDau1zIMf/rMAktc8DqtaQTQ8th6kquRB94/G5KuyQ9ZGfb
	2F0cjNX103etKLhIldrjJNkQAW4aKsNpJyI9cF2JTh0qiIxasfmJl92K6IvTYSVPRXUDISDU8q/
	pbopm9fborUMAeTvhMTqGoFX0G5d4ZSNKzOzk0AsX
X-Gm-Gg: Acq92OFnbe9Czzr5Q0iYh9WxEteZTj2wO4FcRj1CgY2nFirpXvLfCNrhuM9HudrbE4T
	YS6DSZNiOsoem2aEC9nSpDMt3NwHGvDdDSqOaIN4FssPcRDv3j8of6IfC+qOqtppnP0Cd1FBWsV
	Bd47gk3SKuVpaVeeWJUi58l7CKKJJ85VQy3TsEZgru6qSzAk/sYldzdiY3Ls1U0HZD7y+MztPtg
	cEjVHl2l6U1IpE7a71OF/Od/G8o0hxXkR9EvrVRi+LxAOqw9g8kajtQP4QpAcA/hR6RnjQaZ2Nh
	ii6P7Eh1iRqQlFk3bL0Tpgqqb3D6Fpug2ViKlA==
X-Received: by 2002:a05:7022:629d:b0:134:feba:401 with SMTP id
 a92af1059eb24-1384bbe9fedmr63439c88.37.1781215640540; Thu, 11 Jun 2026
 15:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610173501.3557522-1-ctshao@google.com>
In-Reply-To: <20260610173501.3557522-1-ctshao@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 11 Jun 2026 15:07:09 -0700
X-Gm-Features: AVVi8CeqA1viPVUOZpBb_S-GDTfJs2QfVRFAPZ3T3f90XRLEsFQ16F6Y16XsXGU
Message-ID: <CAJpZYjWoHtRJyh-o9FJ0TioUyWPK_CvSj8FOTZFD3FQ0FjLtBA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix false NMI watchdog warning in aggregation modes
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:35=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> =
wrote:
>
> In aggregation modes (e.g. --per-socket, --per-die, etc.), a
> counter might not be scheduled or counted on specific aggregate
> groups if it was not assigned to the CPUs belonging to those
> groups. However, the printout() check triggers the
> "print_free_counters_hint" logic unconditionally for any
> supported counter with a missing count. This results in a false
> "Some events weren't counted. Try disabling the NMI watchdog"
> warning.
>
> This warning was originally introduced in commit 02d492e5dcb7
> ("perf stat: Issue a HW watchdog disable hint").
>
> To fix this, add the helper evsel__should_run_on_aggr() to
> verify if the counter was supposed to run on the aggregate CPU
> ID before triggering the hint. Additionally, correctly handle
> per-thread/per-process execution (which uses a dummy CPU map
> with a single -1 entry) by immediately returning true,
> ensuring legitimate warnings are still reported.
>
> Example before/after:
>
> $ perf stat -M lpm_miss_lat --metric-only --per-socket -a -- sleep 1
>
> Before:
>  Performance counter stats for 'system wide':
>
>        ns  lpm_miss_lat_rem ns  lpm_miss_lat_loc
> S0      126                202.3               207.9
> S1      126                231.9               259.3
>
>        1.006029831 seconds time elapsed
>
> Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
>
> After:
>  Performance counter stats for 'system wide':
>
>        ns  lpm_miss_lat_rem ns  lpm_miss_lat_loc
> S0      126                202.3               207.9
> S1      126                231.9               259.3
>
>        1.006029831 seconds time elapsed
>
> Assisted-by: Gemini:gemini-next
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/util/stat-display.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 2b69d238858c..e50557964916 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -792,6 +792,28 @@ static bool evlist__has_hybrid_pmus(struct evlist *e=
vlist)
>         return false;
>  }
>
> +static bool evsel__should_run_on_aggr(struct perf_stat_config *config,
> +                                     struct evsel *counter,
> +                                     const struct aggr_cpu_id *id)
> +{
> +       struct perf_cpu cpu;
> +       unsigned int idx;
> +
> +       if (!config->aggr_map || !config->aggr_get_id)
> +               return true;
> +
> +       perf_cpu_map__for_each_cpu(cpu, idx, counter->core.cpus) {
> +               struct aggr_cpu_id own_id;
> +
> +               if (cpu.cpu < 0)
> +                       return true;
> +
> +               own_id =3D config->aggr_get_id(config, cpu);
> +               if (aggr_cpu_id__equal(id, &own_id))
> +                       return true;
> +       }
> +       return false;
> +}
>  static void printout(struct perf_stat_config *config, struct outstate *o=
s,
>                      double uval, u64 run, u64 ena, double noise, int agg=
r_idx)
>  {
> @@ -822,7 +844,8 @@ static void printout(struct perf_stat_config *config,=
 struct outstate *os,
>
>                 if (counter->supported) {
>                         if (!evlist__has_hybrid_pmus(counter->evlist)) {

Had an offline discussion with Ian, and it turns out the NMI watchdog
only uses core events. Therefore, we can simply exclude uncore events
from triggering the watchdog hint. Core PMU events do not trigger this
false warning in aggregation modes because they are active across all
cores.
v2: https://lore.kernel.org/20260611215632.562900-1-ctshao@google.com/T/#u

Thanks,
CT

> -                               config->print_free_counters_hint =3D 1;
> +                               if (evsel__should_run_on_aggr(config, cou=
nter, &os->id))
> +                                       config->print_free_counters_hint =
=3D 1;
>                         }
>                 }
>         }
> --
> 2.54.0.1099.g489fc7bff1-goog
>
