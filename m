Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C04F888
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Feb 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436705; cv=none; b=qGaf6zvrWrHan/a89r3vozE1aaM0tqPjwYf0nyE2mRKycplKdEFq/jtSjhafpiZehcCkuxiX96Cqs0UhJy784bjKfy56ROfEnrJsNqixNNBVNILW5fEStjvbDg6koyiUnOEUVbgLHAVnj08YYGXJVzq3YQiq3s0X6RG2hMtidM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436705; c=relaxed/simple;
	bh=zR+4+DAvu/7unZvLW/5g+yHqoNSJlJGh6yPlaVLnEHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+lkQ893PQ/JEhhi98L7OZ5FHk+8aXaKxfthCJFkHaXWCRPk4nIech4ZeC1BLkF8SJ9f7uVJSId8Yzr/l+skuNRoNnip9UktJlliXQwA1MnvIjgTXXmW7uR3km2xz78+CU37OMp9sGcTXTMbqeiFa6ryl+Iz3NJlDq3euWm6QzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso250632a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Feb 2024 15:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707436703; x=1708041503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOB5pCJawefIENm+CkpwYkD1NlOslXrwjD4QFpaxSjk=;
        b=wCUBXp0p1zWnndxour+VWBwnnxMVDI12suI/ytxF8/CCP3YLSO5xxHZmfheRUk+cq6
         zP5pPyww9dmXGyOBTMzXEqOV4ZkXZOCAt2z0t9A3Gxhe/E9fUCTSbihnWgvBqM8jKNFl
         90X6F7Gu12y27pgV6SiMYd6SyWEObHuyQSiSryHjyvUWWNyqvoTwyFCn6Cm1MHQ/pIDs
         Is0YDvVnaxZD+YqXbQGwQl55XQ5CVNeTTw0sa1Fzv4P1hyijjA+0+GRIOj+mcb2CuQgp
         eOIclysGcYBRJzW1dvna+MqUnGNo9Hv0rqUhtXGwOPfpFJ8+nErdZWJlRQUIfsnjC0lb
         9OeQ==
X-Gm-Message-State: AOJu0YzCVNdEP00Og5kt+8Nsjew/3kOkalYD3ZrJ0QvUBd/wkoxomu/O
	OW/nY45A5Dv6ZgNDHBjKGpUpTgfuucuaFVHG/1F7Jrkm+ek+K1UNygjdF/Ma8gdIIdVu1ZCgtqj
	I4qFNys+NyqNyFN9S/Pj/rNFAZY8=
X-Google-Smtp-Source: AGHT+IHwLHA2HUK4gQBkmnzLCqC2n5Ob7mlx7Za/IDiMtL5/TlWsxqARU1daEtKq/DK7tDoGZygYLhsSC1mdm5tfwoY=
X-Received: by 2002:a17:90a:e018:b0:297:5d4:d849 with SMTP id
 u24-20020a17090ae01800b0029705d4d849mr893928pjy.7.1707436702965; Thu, 08 Feb
 2024 15:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208032518.25830-1-yangyicong@huawei.com>
In-Reply-To: <20240208032518.25830-1-yangyicong@huawei.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 8 Feb 2024 15:58:11 -0800
Message-ID: <CAM9d7cga2rzcpUCa+5sZKQ3g_nC5=5XhSdkX1bRCQQUJca8uSw@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Enable iostat mode for HiSilicon PCIe PMU
To: Yicong Yang <yangyicong@huawei.com>
Cc: will@kernel.org, john.g.garry@oracle.com, james.clark@arm.com, 
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, jonathan.cameron@huawei.com, 
	hejunhao3@huawei.com, prime.zeng@hisilicon.com, yangyicong@hisilicon.com, 
	linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 7, 2024 at 7:29=E2=80=AFPM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> Some HiSilicon platforms provide PCIe PMU devices for monitoring the
> throughput and latency of PCIe traffic. With the support of PCIe PMU
> we can enable the perf iostat mode.

Hmm.. so it only works for HiSilicon.  What if users run it on a different
platform?  I think ARM should care about this.

Thanks,
Namhyung


>
> The HiSilicon PCIe PMU can support measuring the throughput of certain
> TLP types and of certain root port. Totally 6 metrics are provided in
> the unit of MB:
>
> - Inbound MWR: The memory write TLPs from the devices downstream the root=
 port
> - Inbound MRD: The memory read TLPs from the devices downstream the root =
port
> - Inbound CPL: The completion TLPs from the devices downstream the root p=
ort
> - Outbound MWR: The memory write TLPs from the CPU to the downstream devi=
ces
> - Outbound MRD: The memory read TLPs from the CPU to the downstream devic=
es
> - Outbound CPL: The completions TLPs from the CPU to the downstream devic=
es
>
> Since the PMU measures the throughput in DWords. So we need to calculate
> the throughput in MB like:
>   Count * 4B / 1024 / 1024
>
> Some of the display of the `perf iostat` will be like:
> [root@localhost tmp]# ./perf iostat list
> hisi_pcie0_core2<0000:40:00.0>
> hisi_pcie2_core2<0000:5f:00.0>
> hisi_pcie0_core1<0000:16:00.0>
> hisi_pcie0_core1<0000:16:04.0>
> [root@localhost tmp]# ./perf iostat --timeout 10000
>
>  Performance counter stats for 'system wide':
>
>     port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound C=
PL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
> 0000:40:00.0                    0                    0                   =
 0                    0                    0                    0
> 0000:5f:00.0                    0                    0                   =
 0                    0                    0                    0
> 0000:16:00.0             16272.99               366.58                   =
 0                15.09                    0             16156.85
> 0000:16:04.0                    0                    0                   =
 0                    0                    0                    0
>
>       10.008227512 seconds time elapsed
>
> [root@localhost tmp]# ./perf iostat 0000:16:00.0 -- fio -name=3Dread
> -numjobs=3D30 -filename=3D/dev/nvme0n1 -rw=3Drw -iodepth=3D128 -direct=3D=
1 -sync=3D0
> -norandommap -group_reporting -runtime=3D10 -time_based -bs=3D64k
>
>  Performance counter stats for 'system wide':
>
>     port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound C=
PL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
> 0000:40:00.0                    0                    0                   =
 0                    0                    0                    0
> 0000:5f:00.0                    0                    0                   =
 0                    0                    0                    0
> 0000:16:00.0             16314.30               371.22                   =
 0                15.21                    0             16362.20
> 0000:16:04.0                    0                    0                   =
 0                    0                    0                    0
>
>       10.168561767 seconds time elapsed
>
>        0.465373000 seconds user
>        1.952948000 seconds sys
>
> More information of the HiSilicon PCIe PMU can be found at
> Documentation/admin-guide/perf/hisi-pcie-pmu.rst.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
