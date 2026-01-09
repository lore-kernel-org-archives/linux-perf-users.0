Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E8320CDF
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Jan 2026 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768002004; cv=pass; b=BleF4UXVF7lnPi9Mab0hAd5tUyeV37Qf+YHoj0x3RvASK3b4Y5LneeYYDI4eUn5LBYSJCn3T62MUuzrjhYgtaxk6QwNiJL+c/fllqedaPLcI2aB4v6aO3enPllFivDpcs+2lxK1k/NLDVef1ccusRaeJ7CUBuYBgHLeikNkqTS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768002004; c=relaxed/simple;
	bh=N4G0aFrwYd7429XmKGPsQHX9Qt1/V/kQOJ3e+ZMsxOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7ZJu8A/OQo6JPYkX2HJOVNbQ6CWlJmYnM2sRTTE8jwlLlbnXBpaxkAk3rpTz8oihocNFJetdyHwjcQMC/VZOZHyQH1IDfTle5J2rRscItlIESlHnKS6WSuTY3Bwzl6D7PaLFWSbIr0oPbEV9jMzMXr/WIZYdwDWo7poE3obpow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEUWkj/l; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEUWkj/l"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a1462573caso30965ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Jan 2026 15:40:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768002002; cv=none;
        d=google.com; s=arc-20240605;
        b=d0IJuEhK3NvGydwgxyoCNZ7h9GCyG/FB85zhkXOzp76a9XC9xDL+IudpU9I4BAHvT5
         8Wtz/vFfNPBPh3yqXhS+ciR2vZY9VPo76DSjsHbJskaht2vv4LcQgEdmAf5LwxPNZ7Ax
         Djn13xEBjH59ibTJoEt+cgULn0MjGvipQ4EcfjhW3VPkgqcjA2fMILKFS/XTPgrpzTI5
         OxuRLcOMojgJwcecFPupRRtYsft3nOepEoZdMDWAaq0ZU9W9KSYH3zLziFCVilT0AIOJ
         AKOp83okEePDTAeyfcwSrcV7KKlGlrPxopXdUtiIN/79gZ5X94/3dVKonZ8KhLRvCykP
         Ys8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zK0gF/2tgGxlMlK3d5jpZ5wGFlUtK5+N2SQ0I05OBvE=;
        fh=Rn5aXzacGzmq7qh05BvaZpZD7WCmzYMmxSz7e9aJIl4=;
        b=SzcLOJQwHyhxMo99ZwlzNLEqGTmuA/4yT+eDvjNlWm+A3ndKP4QX8RjWxqpS+5j1dy
         y+X2MIIlLE0mnjR1u3MNJT7PDc/gENQdDyBcjN83vPjdp8hZbA3qgeKz7KImchZ7LB6t
         D4dRsiQJTtFJw3iVUZbNn/4k6bNqocRmTC6ogNuBeqrwiRShJX/HbEPXMdR2oq4vunDH
         P+NHltqxactHG5xMAkUgwz/HnXcUl9z4CLAFIbKaMTlUXhMyTVNqjn7pYfkMelfloKS6
         Uk4ZtdGRrURXhsgijDKpf9RBlMFPhgwGppfvpPA2kvFesUxBRCjRAiCC0bWkygoqxLaO
         4FUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768002002; x=1768606802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK0gF/2tgGxlMlK3d5jpZ5wGFlUtK5+N2SQ0I05OBvE=;
        b=nEUWkj/lRq1H564eyGymovwRK2f/ncIAmtY2BmJZfDnC5gi/aomXTJ5py7a3ne1Cel
         AtuC3PxhppIU8M2VZsU6WaxSQDVYzO0HMS6BaKv4AIGx3ephKhF/IU6q3ByYG9BGPFrJ
         fwlrHAI9bEqu0QzwlXCaNVXxiv8TQEi0auvLXKuelWRzljCcmVj8zMaeuueLRA1nRBlW
         hZSSf1QFd2G6sZC+frZjN+LGHMqSNsROj8AR1Gx5FZGcK4ovqsj6K0iYG3Xxc+6GJu55
         BHdf7eHHcYYmL3bxJvAmN/LEG6JGJzLsiy3Wl50y7Od2pdGI25bm+zmaD66dgvcaezBZ
         7sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768002002; x=1768606802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zK0gF/2tgGxlMlK3d5jpZ5wGFlUtK5+N2SQ0I05OBvE=;
        b=O0iOfrVpuxqZWBqz6SGpGGRF7zTAIoFfF20GC1+EwqiVn2wckSvNuqGJfGtbTK6NJk
         OUFlDIiONdFSnFaozdVScgIVfH+s7KiGFXkxfd75rgVNts5rtQPeA37WKorQD7qYFHE+
         jU5AFAnPwwikyhGCA4/C8UvcLHNreguItsXvagLzNcO4aNXgKi0ouS6wWY/O/XrZkswr
         L1eByFKh8/grj0PnwA1XxRngmfQp08OPXiNcXYjuWHu1QjcyRBPyK8PjL0ioEP9P6xNJ
         ru3YN9V9X0zqFXPEQ9swZE7nHD3zHpFwfDT5txvOjpZ5ZCJSpo3kr/DKYYcREnFD2FbF
         NE1g==
X-Forwarded-Encrypted: i=1; AJvYcCXItpNvu2qVxj+V0E0Xy4XJeWoamWpXADFh7fufEm8VSVSjQP4AI1t2Fg1tyb64Nrek9tzGX+5nODZawWIrrQtr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6o3+DsQZgOZNM+Vn77Aj9G+QLvVnlNaN5d74Fm1OJ1Cb2De1Y
	S0jaaq+KggQWHIf8fROB/CL9yOotc6naEcjcsKjrMQ1qNHe+zA4OTeg6V+3+cR1DAHQRnH7BRVN
	9yIvELz4Y6XOi0CNGdKWAzI/katpmP1PnsADNaLkJ
X-Gm-Gg: AY/fxX7stbI++5wTCzFBhq9a1vP8SobxG8gxqkdhf+ti8FbmB9Br0kgbdD0tYp5LUSP
	1ExygAj5TDS0sS95O34mICIcLioy8IZKuWOACzuX6A1Yi3W+9LBryg2q0t/jQ9yCGz+vxCkmjE+
	tE8Vvlw2xDsgqlAj8ZVZjAlbH5hnEzvsFlRf7ZPhzBY+QfFGUTiz97dzueATIXGBIru8yds435/
	OJh9AhtMr36+YSDWtt2CgyEBCsS/JBw5is8m0qIg/lIveozuyJ+5F58yq3f20nHw3m54dn1EtK1
	H5NtnR/5C/JnOt+2cCBto5R8sQ==
X-Received: by 2002:a17:903:2410:b0:299:c368:6b1f with SMTP id
 d9443c01a7336-2a414956869mr1154525ad.18.1768002001948; Fri, 09 Jan 2026
 15:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219011820.2505506-1-namhyung@kernel.org> <20251219011820.2505506-4-namhyung@kernel.org>
In-Reply-To: <20251219011820.2505506-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 9 Jan 2026 15:39:50 -0800
X-Gm-Features: AQt7F2p07S54FKC8J9KFsCSL25u7WddbM0hQyPcVydtLawZjggn5hyizuUfwm1c
Message-ID: <CAP-5=fVO+EK-vaEfvxbmmtReNJJNYpx31W62E_FLBDpMe5a3Lw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf test: Do not skip when some metric-group tests succeed
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I think the return value of SKIP (2) should be used when it skipped the
> entire test suite rather than a few of them.  While the FAIL should be
> reserved if any of test failed.

The same feedback as the last patch:
https://lore.kernel.org/lkml/CAP-5=3DfVDYu+GLspYQNEHk7_X8-FE-OaEF0OaG+vfWrr=
YH9ZcoQ@mail.gmail.com/

Thanks,
Ian

>   $ perf test -vv 109
>   109: perf all metricgroups test:
>   --- start ---
>   test child forked, pid 2493003
>   Testing Backend
>   Testing Bad
>   Testing BadSpec
>   Testing BigFootprint
>   Testing BrMispredicts
>   Testing Branches
>   Testing BvBC
>   Testing BvBO
>   Testing BvCB
>   Testing BvFB
>   Testing BvIO
>   Testing BvMB
>   Testing BvML
>   Testing BvMP
>   Testing BvMS
>   Testing BvMT
>   Testing BvOB
>   Testing BvUW
>   Testing CacheHits
>   Testing CacheMisses
>   Testing CodeGen
>   Testing Compute
>   Testing Cor
>   Testing DSB
>   Testing DSBmiss
>   Testing DataSharing
>   Testing Default
>   Testing Default2
>   Testing Default3
>   Testing Default4
>   Ignoring failures in Default4 that may contain unsupported legacy event=
s
>   Testing Fed
>   Testing FetchBW
>   Testing FetchLat
>   Testing Flops
>   Testing FpScalar
>   Testing FpVector
>   Testing Frontend
>   Testing HPC
>   Testing IcMiss
>   Testing InsType
>   Testing LSD
>   Testing LockCont
>   Testing MachineClears
>   Testing Machine_Clears
>   Testing Mem
>   Testing MemOffcore
>   Testing MemoryBW
>   Testing MemoryBound
>   Testing MemoryLat
>   Testing MemoryTLB
>   Testing Memory_BW
>   Testing Memory_Lat
>   Testing MicroSeq
>   Testing OS
>   Testing Offcore
>   Testing PGO
>   Testing Pipeline
>   Testing PortsUtil
>   Testing Power
>   Testing Prefetches
>   Testing Ret
>   Testing Retire
>   Testing SMT
>   Testing Snoop
>   Testing SoC
>   Testing Summary
>   Testing TmaL1
>   Testing TmaL2
>   Testing TmaL3mem
>   Testing TopdownL1
>   Testing TopdownL2
>   Testing TopdownL3
>   Testing TopdownL4
>   Testing TopdownL5
>   Testing TopdownL6
>   Testing smi
>   Testing tma_L1_group
>   Testing tma_L2_group
>   Testing tma_L3_group
>   Testing tma_L4_group
>   Testing tma_L5_group
>   Testing tma_L6_group
>   Testing tma_alu_op_utilization_group
>   Testing tma_assists_group
>   Testing tma_backend_bound_group
>   Testing tma_bad_speculation_group
>   Testing tma_branch_mispredicts_group
>   Testing tma_branch_resteers_group
>   Testing tma_code_stlb_miss_group
>   Testing tma_core_bound_group
>   Testing tma_divider_group
>   Testing tma_dram_bound_group
>   Testing tma_dtlb_load_group
>   Testing tma_dtlb_store_group
>   Testing tma_fetch_bandwidth_group
>   Testing tma_fetch_latency_group
>   Testing tma_fp_arith_group
>   Testing tma_fp_vector_group
>   Testing tma_frontend_bound_group
>   Testing tma_heavy_operations_group
>   Testing tma_icache_misses_group
>   Testing tma_issue2P
>   Testing tma_issueBM
>   Testing tma_issueBW
>   Testing tma_issueComp
>   Testing tma_issueD0
>   Testing tma_issueFB
>   Testing tma_issueFL
>   Testing tma_issueL1
>   Testing tma_issueLat
>   Testing tma_issueMC
>   Testing tma_issueMS
>   Testing tma_issueMV
>   Testing tma_issueRFO
>   Testing tma_issueSL
>   Testing tma_issueSO
>   Testing tma_issueSmSt
>   Testing tma_issueSpSt
>   Testing tma_issueSyncxn
>   Testing tma_issueTLB
>   Testing tma_itlb_misses_group
>   Testing tma_l1_bound_group
>   Testing tma_l2_bound_group
>   Testing tma_l3_bound_group
>   Testing tma_light_operations_group
>   Testing tma_load_stlb_miss_group
>   Testing tma_machine_clears_group
>   Testing tma_memory_bound_group
>   Testing tma_microcode_sequencer_group
>   Testing tma_mite_group
>   Testing tma_other_light_ops_group
>   Testing tma_ports_utilization_group
>   Testing tma_ports_utilized_0_group
>   Testing tma_ports_utilized_3m_group
>   Testing tma_retiring_group
>   Testing tma_serializing_operation_group
>   Testing tma_store_bound_group
>   Testing tma_store_stlb_miss_group
>   Testing transaction
>   ---- end(0) ----
>   109: perf all metricgroups test                                      : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  .../perf/tests/shell/stat_all_metricgroups.sh | 26 ++++++++++++-------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf=
/tests/shell/stat_all_metricgroups.sh
> index 1400880ec01f8267..81bc7070b5ab0d5c 100755
> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> @@ -12,31 +12,32 @@ if ParanoidAndNotRoot 0
>  then
>    system_wide_flag=3D""
>  fi
> -err=3D0
> +
> +err=3D3
> +skip=3D0
>  for m in $(perf list --raw-dump metricgroups)
>  do
>    echo "Testing $m"
>    result=3D$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
>    result_err=3D$?
> -  if [[ $result_err -gt 0 ]]
> +  if [[ $result_err -eq 0 ]]
>    then
> +    if [[ "$err" -ne 1 ]]
> +    then
> +      err=3D0
> +    fi
> +  else
>      if [[ "$result" =3D~ \
>            "Access to performance monitoring and observability operations=
 is limited" ]]
>      then
>        echo "Permission failure"
>        echo $result
> -      if [[ $err -eq 0 ]]
> -      then
> -        err=3D2 # Skip
> -      fi
> +      skip=3D1
>      elif [[ "$result" =3D~ "in per-thread mode, enable system wide" ]]
>      then
>        echo "Permissions - need system wide mode"
>        echo $result
> -      if [[ $err -eq 0 ]]
> -      then
> -        err=3D2 # Skip
> -      fi
> +      skip=3D1
>      elif [[ "$m" =3D=3D @(Default2|Default3|Default4) ]]
>      then
>        echo "Ignoring failures in $m that may contain unsupported legacy =
events"
> @@ -48,4 +49,9 @@ do
>    fi
>  done
>
> +if [[ "$err" -eq 3 && "$skip" -eq 1 ]]
> +then
> +  err=3D2
> +fi
> +
>  exit $err
> --
> 2.52.0.322.g1dd061c0dc-goog
>
