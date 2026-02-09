Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEFE38886A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658054; cv=pass; b=G1zVwylukHFMdmxbL7MjcpHmOcWXGWns0thZmd6VyMBmjCJU3obnVp6pz5C6HxVIHbyv7oWYLizbgTlImU9E68xp6TAUYMcsUvjsJrA208l7JbKlHGXvh1vs8gRNnLJRs8F2vt2bfwYWwK0Kc7Uhrc9hw3bZWbrwCS46qz6mwrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658054; c=relaxed/simple;
	bh=Z8II5FQDxkEoQwArhWEdkJIAdy/R1I/x1OaDxTdrQDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWiiN+zEK9/jnR11Mcs895kzOxCpOV4bveNBiHutT6HypDXV76yNLFg9nXvfD4OvjsgnR67pHty82OjVTsSd9yvj2uuFUTIYNsufgKEGzNWfaojZR8WuqzVojw4lO3LIaLTCun7JBhitctab4MfMmRcYWDAn/0RNkU8GKTe6ddk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zt6LBfyL; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zt6LBfyL"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a964077671so156085ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:27:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770658054; cv=none;
        d=google.com; s=arc-20240605;
        b=cuvucJWEKIV6wva7aOnxfn7/y7ajfYc2X8aSo7hyhFw4czvUn8cz3BjjEqWc6BN3ih
         oqEzEp9NHNpDQy0hvYcLvh3dZbngfZQBwtQ0SySAjnL39Y47KCw3vBHoFZkKy9ApLRDN
         oZDiDXVfVM7uVfB6g+7SS8lacGMAK9bBr0vzVsv/LW4CINGoEti8VCyYmQZAvKFnyW+B
         BeGU1ygjAGKiCaM3tUsTC+g4VFQOCKPtGjjTWoCP49iYjY5z1iJZF9IGA9/R87rHhNdR
         HNifYcbL4Wulz+eTQsN7U9SSwfjp7XQzaNfxjUVbapJ9RixoLIa35fAIXv2Kl3uuFXQK
         U4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=irtjkcjnW9qm0qn0VHGILyirTG2jAO2P/L2vAokTtBE=;
        fh=YAdKxfVIM8EeTizDItOFqmBcA21rBzUQCYljb55kxLE=;
        b=EdAOPCBpjVYfpFDQ5Yze2Yduij4UkDGm9SutfhyUsjLSVM5AkFSQjBlAdt0Sh3/wWV
         C9DVfcRxKSZmhXL3I4lecCBOWRkKMksClTzq/Yg3eSbskpTAbVYTzsayEDxtKN81nBl3
         oC5G8vuuRHEQ0N68NnIkSbLT/l+V2S4P4WoEQhYHFB4xPNipkCCSJn5d5huYTXIBoTv7
         W14cBR0q8q8mWLhW962WUGo+BAN22XRJEijcppKtFjJRRet7c0Y4TcXYkvJj4ZWtywaj
         gYRHkn2AwTk3FjkC+DIx/QNK2eT+0p+ic2RyLcPDUVkzjrxdqITe/soFlcuOnm9bQiOx
         AUQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658054; x=1771262854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irtjkcjnW9qm0qn0VHGILyirTG2jAO2P/L2vAokTtBE=;
        b=zt6LBfyL/6bmpYkZBAl4h5YO11tbGnPVpJUZGwm32WfAEaXnfhKJ84lsHzKT7oEY5i
         qv56NYY1lyS/lzY3loV/ud5gln/dw6BJQr3I6U3P2kzWGnBvVva4q6VqlNV9ewDF0QOU
         8a01raiWpC+Dr4KjckWGESizklFc5Dahb6RGS1GyBH6x3p63xNuYWnOOcOAMG74kPVr5
         y/X2C5N4sVHRz3UiOnkGrneany0dvQLxk37ljmxX4kJfEDpXnVrzLZJAmhtR0w4LrIF4
         VlhAE9ZcB4MuWaXsHQK7bFNXtTaMHYSWFSHDmwdI2As4YUj75vCmMXLpgvxVrMn0DmLL
         xqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658054; x=1771262854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irtjkcjnW9qm0qn0VHGILyirTG2jAO2P/L2vAokTtBE=;
        b=q7YTQMR51SRfC/enUMSRxgHv+yDmpynuMikUrHGg03Xdu0KF0TdTKkA+XAwWd4U97e
         lptu7rU580fAZIj3XjWul7Sa/RuZd50GEU9sXtFISY9RQOmz/LAbN/OVPV+ErRPfLgRp
         p4jylgbY+8A5CLQ7MBMpbr5Bnsf7jjW1S5r8duhwKDFURVVe8vcWQxwIkLRRsTNRzhyn
         g/d1xjsFUq3kzFRjfp374YUlSFqtsHz3u96i3yvIyUA8qOFEqDuaxIIUb+3phq0YzG9V
         fkHT2TS0aCB4vf+qwI5+dcCVoibszOyGhmS7Bag8VmwRDdTweGf2NTezEf83omLQKAUE
         0Y2A==
X-Gm-Message-State: AOJu0YwWbGCaCoWO9kI+KhD9dA+Gr07zsP2hu63TuF2JiMBUaSZldd4s
	4LsgzRnE6DXeanEjxRpF1WYM/4KGtdxjNeLirk3b+ekaMNliNFQK6sQK/ntUAfNb1IgShnLQI1d
	aLAjPVs+I23G5a36wsou0I4gzcBVgC08LoQ0OpqFD
X-Gm-Gg: AZuq6aKXjd4W0LLfN/j0UT90jiNryvTkr6vjCnJfqwn1Oey7wptXYZfKxmRoLczDBGX
	YhYH5sTf9G+rlfI4ojUbant6DmWu2IzBWVai5/6j7o+2J15bYj8QrWWBf30Ly/kQ4hfV+3FzNnK
	bmDnwTX2CGZINdKCn2t4EHPyc5WVGe6ehPaTAaO3orD2EK1OX2TcmNNMC6GoerZDKiAHTTAa8Og
	GH6JkoZgu3RRHELNHmB+2WcW52lOlgAmG+rK/z+y+AoV2XGj3OlYs6eZPsGPGkuTxThNxjM6lEW
	llH3LSi2QLNMKkcqmhcm5U89
X-Received: by 2002:a17:903:22c6:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-2a963182948mr5563615ad.7.1770658053707; Mon, 09 Feb 2026
 09:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209140533.194251-1-9erthalion6@gmail.com>
In-Reply-To: <20260209140533.194251-1-9erthalion6@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 09:27:22 -0800
X-Gm-Features: AZwV_QhS4VGOdDtZcYLXKHaSS0213gefkMcjZOrHAk-UhvX4kw-dyOBR1PJ7dzU
Message-ID: <CAP-5=fWJdM8wkSDWcShMt-i1OVxTV0rzdovqsCychb_NEj5Ogw@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests workload: Formatting for code_with_type.rs
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 6:05=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.co=
m> wrote:
>
> One part of the rust code for code_with_type workload wasn't properly
> formatted. Pass it through rustfmt to fix that.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602091357.oyRv6hgQ-lkp@i=
ntel.com/
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/workloads/code_with_type.rs | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/workloads/code_with_type.rs b/tools/perf/te=
sts/workloads/code_with_type.rs
> index 3b91e51919d..3dab39b22dd 100644
> --- a/tools/perf/tests/workloads/code_with_type.rs
> +++ b/tools/perf/tests/workloads/code_with_type.rs
> @@ -10,7 +10,11 @@ struct Buf {
>
>  #[no_mangle]
>  pub extern "C" fn test_rs(count: u32) {
> -    let mut b =3D  Buf { data1: 0, data2: String::from("data"), data3: 0=
};
> +    let mut b =3D Buf {
> +        data1: 0,
> +        data2: String::from("data"),
> +        data3: 0,
> +    };
>
>      for _ in 1..count {
>          b.data1 +=3D 1;
>
> base-commit: 335047109d7d488bf5ad32a4076e1a011994cd0e
> --
> 2.52.0
>
