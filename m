Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD93016E0
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852461; cv=pass; b=OmPZtoBS9AFwTfEysh9fBhdcy00EQAb6a9+aIdcRA4shmQBNbAJfpcSi5lz6Nl1G5pXnaa2rRHd1PzwG3piVOIcD507TUKgqtblEnYdD04f0MHum8xQvs87xcTDxVxfd8/hwgAqiTLgR708QtNWAZWJzBwdMa4ELItBnJjbF2lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852461; c=relaxed/simple;
	bh=dM8nixRfEKG3+uiQMF3Bep4o9STdJLCGvBzTzb8HBMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF6mcWkS4O1ZOstfGiz2kDsC2kj+Ge/+FveTs/dc95IojJg+vkfCAe8RKd4MoRKhaXQYZ3UutkUuQ/Mbja51/Dmq13A00H6cnZ9wi4Y7D5GYOHl9H3ReXc/4ia+XDa+PN+3K0U5c7DnS9IFxj27x8iKElU2SC06IZCrCTGTkkEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tod0PpoV; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tod0PpoV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aeab6ff148so107985ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 09:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773852459; cv=none;
        d=google.com; s=arc-20240605;
        b=Hx8FS1L9Z5Zs7Ij4pjAndPxS19WWX6M/svOCpZj+uDOV4QsrBUGDU1SV2Gc+MRDjW+
         zVpdO/+GIOxsJGFG+nT1jsZt051UVj+eRNknIYiVXSg7XQo8a1E6usOGrXmxc8OLaXnV
         pbjDPEDUzymYu36BtqcWhrQZMuSFt2hYw9qOphJMyd6IxN7+9OQSeccLRB6V4753JAmc
         FwMEqtnIGoVZ3oHrqPkm8hU6Vqi301trbr9I3IgXYhwBD0lOi8o1yet83OfXH1c9wXv+
         NjaKDbWDBI1RsZD/BySV/ZjFVqgxJTMNkErSIgiwC8KOCC/Q/3g0/By2WAl6VpRVEr61
         rdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngHI+QZtVdSZjTh6hDhddl0Er/Mmy0N23+A38zRXieM=;
        fh=8/HnyjLoj/S6B+QB/+BlmToB/p6yPdL3vJO/6vHpbSI=;
        b=kDNWjANdHahXiND3vaDK+OzEO8mEgLi/bYWZC56uUsHgq+0xnP69CTkjzqxlBehY2k
         yZ2HTN76AS/RYH0nYpd9u8b/2vfQQC5/bOvUdD03ugqyOdzEzMOseJN581TafpVMqbIZ
         OUGf1ty5Xwqzrvm4O7OK0wcQrhl8Ae+KFyZzQOU7le1EogoyFskJLW0GKGu1+YQuWzHQ
         QQJSGyPCbtyzdGa2e5ef1NkFoqmJCIo7nr0nYp5GtAS/PRvMYXHXGJTRYaD3nZ+I0yoN
         rCLbrSzSstjmjggnGUDLIfsmFf98q/5JjLtRPAA11dp9jB0cwF/icCrgGW97+saAV5Oz
         irVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773852459; x=1774457259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngHI+QZtVdSZjTh6hDhddl0Er/Mmy0N23+A38zRXieM=;
        b=tod0PpoVSEV/5WirEvStdOSaJd4kVorWJJ1Tctpg4kfRFh8JldtAvj4AdOydZpTF+g
         HHIrMDLo62YdOKreQXYVIUwP1PfD7LHZb3nBFDIyXtJlzBUssBm5R+YxQnx35imKWpaY
         ezykvr+nyOj2Lw5Ihm87ue3PONMvca/fWo9EGYAl92SKNWYTZFj57d4j1AHtzUWBE+JH
         feCQ0bS2XA4Q6muLQgDUPN0awwpmxXStiiUkMrengJCm6weiMycKF+8sBVkEWbB2bi2y
         gaIyMwokj8SQSKU+d5KrStyiTFsUhb1tljCpO3i/10Idh5NyiB6FStnsDCF7pbqLFKFO
         l3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852459; x=1774457259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngHI+QZtVdSZjTh6hDhddl0Er/Mmy0N23+A38zRXieM=;
        b=rxOXaqL35d2WXRex3TKjqEU4IeFEcAj3bxYS5lmQarSWCA+Qu6NDSwbodtuNT6Baao
         3qoESpYAeZpjGmW5/UMbMYxFTX2XEPIpP4m5VRemqLJj1Uv1BGhmu+6qLMtOO9oMaveD
         cLFeaFKHsFcUApyXCWPQw9AbnapNBBP+q/s/Kk5WCQKlNJPD1NMWR8xkiFHwQAsMmDi0
         CA1G4QZF5fgotdqwtV0N75oOtqnioCufJ9q7yeZ9PbwPE7oEflrhJXuQc2Q9xkNxaLQk
         U65PKqmwv+hYmpIf46QaIHhl/vR3c0hlAisLwmGlCrDXBXfidydxRSfIMAriwOwI5AME
         rhsg==
X-Forwarded-Encrypted: i=1; AJvYcCXzD2I2bhJK24y1JIABpRygGFq1tbznFPTBJBNaYrvyqzXFeY0uIjuUYtZP5QMBsam2E4RadzTsx5ZWo9TYylgi@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZRZaZ0G6yqHvklWbuEUkAvOIljIq32lbu4JzSHoNV3AOEOEm
	g0VkMO9MYc/xdZVk8CxzNHSEwD8eIiKyTIw+1ts0y10lCdq/IV45O/yYzfmdK8TKneo2IbZ/WNW
	rSigKsRG0FFoyBhdrfdOjoq64Pecb2+Pq16L0pryk
X-Gm-Gg: ATEYQzwjoyB65wXGKlvk3XXd/6B7UPU0cZhvu2uzkSvkM2f1eClwNaSJqednXemlOS2
	hd5cymkcccK3sZUHMdqWmyw5XlcIJ76lEwz9QD6BGIzENqvj3wgefoJGVNYbVbwd5H76kcsJxlP
	7YqGQN+dj/UwAhpdKDqex+ybQxEulvA9ZhUuam2+Kz6dBMijsuITa4btm6IELNsBk39t3q2f6PB
	CLbI6UOWS5kLPXeJJRXvnqO8eAl8l3C796J/IToTNtX568CFgqucNWpRXhAsiv/wKm1g3ufg4y3
	kM/0Y51I1zHtInO2FMc=
X-Received: by 2002:a17:903:2f84:b0:2b0:5ba3:2416 with SMTP id
 d9443c01a7336-2b06f851d75mr2854145ad.7.1773852458407; Wed, 18 Mar 2026
 09:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318071501.17339-1-namhyung@kernel.org>
In-Reply-To: <20260318071501.17339-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 09:47:26 -0700
X-Gm-Features: AaiRm53KEIEak4oQ6BZCLZSfNoHPIFu3b9Bs7x8jnOCrl0KBobRzQWsywI2_TiU
Message-ID: <CAP-5=fW9ZcCFvAgg_Y_O9HzVTHtpyN0TNUvbrFVgm1YZEEjXuw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Fix perf stat --bpf-counters on hybrid machines
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 12:15=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The test constantly fails on my Intel hybrid machine.  The issue was it
> has two events in the output even if I only gave it one event.
>
>   $ perf stat -e instructions -- perf test -w sqrtloop
>
>    Performance counter stats for 'perf test -w sqrtloop':
>
>          910,856,421      cpu_atom/instructions/                         =
                         (28.05%)
>       14,852,865,997      cpu_core/instructions/                         =
                         (96.79%)
>
>          1.014313341 seconds time elapsed
>
>          1.004114000 seconds user
>          0.008174000 seconds sys
>
> Let's modify the awk script to add the values for each line and print
> the total.  The variable 'i' has a number of input lines that have valid
> output and variable 'c' has the sum of actual counter values.  That way
> it should work on any platforms.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2) handle '<not counted>' and '<not supported>'.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

>  tools/perf/tests/shell/stat_bpf_counters.sh | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tes=
ts/shell/stat_bpf_counters.sh
> index f43e28a136d3c9bc..8b42585f45025d5c 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -41,8 +41,14 @@ check_counts()
>  test_bpf_counters()
>  {
>         printf "Testing --bpf-counters "
> -       base_instructions=3D$(perf stat --no-big-num -e instructions -- $=
workload 2>&1 | awk '/instructions/ {print $1}')
> -       bpf_instructions=3D$(perf stat --no-big-num --bpf-counters -e ins=
tructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
> +       base_instructions=3D$(perf stat --no-big-num -e instructions -- $=
workload 2>&1 | \
> +                               awk -v i=3D0 -v c=3D0 '/instructions/ { \
> +                                       if ($1 !=3D "<not") { i++; c +=3D=
 $1 } \
> +                               } END { if (i > 0) print c; else print "<=
not" }')
> +       bpf_instructions=3D$(perf stat --no-big-num --bpf-counters -e ins=
tructions -- $workload  2>&1 | \
> +                               awk -v i=3D0 -v c=3D0 '/instructions/ { \
> +                                       if ($1 !=3D "<not") { i++; c +=3D=
 $1 } \
> +                               } END { if (i > 0) print c; else print "<=
not" }')
>         check_counts $base_instructions $bpf_instructions
>         compare_number $base_instructions $bpf_instructions
>         echo "[Success]"
> @@ -52,8 +58,14 @@ test_bpf_modifier()
>  {
>         printf "Testing bpf event modifier "
>         stat_output=3D$(perf stat --no-big-num -e instructions/name=3Dbas=
e_instructions/,instructions/name=3Dbpf_instructions/b -- $workload 2>&1)
> -       base_instructions=3D$(echo "$stat_output"| awk '/base_instruction=
s/ {print $1}')
> -       bpf_instructions=3D$(echo "$stat_output"| awk '/bpf_instructions/=
 {print $1}')
> +       base_instructions=3D$(echo "$stat_output"| \
> +                               awk -v i=3D0 -v c=3D0 '/base_instructions=
/ { \
> +                                       if ($1 !=3D "<not") { i++; c +=3D=
 $1 } \
> +                               } END { if (i > 0) print c; else print "<=
not" }')
> +       bpf_instructions=3D$(echo "$stat_output"| \
> +                               awk -v i=3D0 -v c=3D0 '/bpf_instructions/=
 { \
> +                                       if ($1 !=3D "<not") { i++; c +=3D=
 $1 } \
> +                               } END { if (i > 0) print c; else print "<=
not" }')
>         check_counts $base_instructions $bpf_instructions
>         compare_number $base_instructions $bpf_instructions
>         echo "[Success]"
> --
> 2.53.0
>
