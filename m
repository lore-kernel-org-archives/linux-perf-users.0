Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425F23F400;
	Thu, 13 Feb 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452249; cv=none; b=OqPR/rvGTIEVGSWNFHhC424VS23bh118o1Jy4kF4hmGvmb9ptZNK0Nmw+jD39oJrqEyydNDr1Rp8PTX5id/MjIfeGk9p2tbRuFITdbPERZgOaNRlUOUCoITvFtJ+kBq4gbh9KIKNQ7l3y1NUn7or7SFp/RAp46+BQ+LYL6Q/wCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452249; c=relaxed/simple;
	bh=nST1KX2AtNlKcazAzA5bZyVqvZfjm3Kpn0TvSiraDaE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QenheQ6KzN8BHzsevjQLTUvPYK4AiKWVB2JiQW4Ih9p3gG63S2wfJHH7PypT5P/irGdmR7KjKNjEVPyo81y+ZqMUdoBrg5vcJRNNhIOVtEuWdW2UfVx6PybiclLIf8h8e93U+rhFnNcvwwjCrELn2Vd32tQTbshk1saVtgj/3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvLFSxC6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvLFSxC6"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so561625a12.3;
        Thu, 13 Feb 2025 05:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739452246; x=1740057046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a8p9IzEFHA6CvD9gtJ08mmZSSOlXbN8UwMCHkPFBaKU=;
        b=jvLFSxC6UCdzINh6QtV92Ffsz+X/NEJJ7JQYeaE10NKdzZj8zx2OesJzHU6MWl4tMh
         7nepGIcrH3I0Ryc0gWsCEVs2aLUHgbBxR6ShJokQwNdevlDYSowVsCgIYzPNu0o1ypv/
         +P6vl/qJUKb2b3dZJ2JkZXVeOST5JwDaRNtRlcYoZ0yhBOuwtHrNM3gFuGEyvdZGK2Ai
         rIvLXNarsuOBJnt5PWdR9enyyqLSwykaSfMMThj48r5uDsQnxOfCJEUX6TwfA6inCgZ1
         UGzRn0IU/VvnNOwXs4k3cqLzcMAaWyhT0mJGJHFCVOekhTO3iCP7iFq2E4ZJNw+pczcv
         evUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452246; x=1740057046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8p9IzEFHA6CvD9gtJ08mmZSSOlXbN8UwMCHkPFBaKU=;
        b=PoVqRHblmPwCF2bE4pD4APA1D7PBy6dwurGccdER/fUhdCNd+7w5RTeDRM24OSFxqw
         zXdOFNRbRoMbX1VQ/Jjk2h2I+lfZ5sPsa03ZCr3RboVxx2SSdlKwo6WsZFier15QR01c
         nPOV3TD4AoaK2xCTYrzXxMwNX/eYBT9qkgoDhdu5p4ljd9PB5gPxiBbcEfEHZEWHDD0r
         yfWCO7q1lG0LgBnSS0kQFsu5x9xDRn1NyJDRR/O8XWEk15xao4YgUAGvjvpwyKaleNqV
         8t+uK5n5gZdsotkN35FBakJY9mg/t0cSa884hD74bOSeCs3sUl013uBdI+YxkyhhpjyI
         z5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCViu02uQwwLYnqYuIeQotZl8iPXgr2NwZ1PqqaAoAAxeGY2Ddun1lyXAttGEy5AS8s65d4jbFj7ZrA/+ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9zoHuWfrRoyiCHGNLfas7f03e7cdfQKAF0DVLwjJDLPS6SfI
	We51l4REaajSLs66YrPVCVhrUELteCRL3coyZ494kLWnTUtQtkix8bxEUvgi7eeCmdUEEuq0jO3
	OTlPON3DXCxy+aRjozFZhU7uTnMk=
X-Gm-Gg: ASbGncu/wgubvjRPU30N2wr1jXj6jigHnQjwAqT1YfeWeAjQ6ahG96u8Oj9IuRdn8QI
	KWY/IAygeRom6ghZUXBTlYUDEjl+CK1D8P/j/fn4oPj4n9XbOSiHFCmpsKQil4kLSmPaVCXtQow
	==
X-Google-Smtp-Source: AGHT+IG81x/h/nYYexjAldTSTTTyF/WQXnBTuMvGWRyQJuvAe08Q3WhAcuCQ5y4KXjSBrhkjiKvGkHZvk+nwt44i0MQ=
X-Received: by 2002:a05:6402:2807:b0:5dc:da2f:9cda with SMTP id
 4fb4d7f45d1cf-5deade07f66mr6394075a12.27.1739452245642; Thu, 13 Feb 2025
 05:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Date: Thu, 13 Feb 2025 14:10:34 +0100
X-Gm-Features: AWEUYZkF1odEy8t_F7_NujJ3u-A-NDf2mNGsq9trTka2jWc78NOOPB6oY7gbzLE
Message-ID: <CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com>
Subject: perf: Question about machine__create_extra_kernel_maps and trampoline symbols
To: Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm investigating performance issues with perf's kallsyms parsing. Running
`perf record -g perf trace -a --max-events 1` on an x86_64 Ubuntu 24.10 on =
a VM
(perf version 6.11) showed that about 61% of time was spent in
'kallsyms__parse'.
Total execution time was 370 ms. When running latest version from
tmp.perf-tools-next
It's 530ms total and 38% in 'kallsyms__parse' because the old version
doesn't have
bpf skeletons enabled.
During regular execution this function is called three times:

1. In machine__get_running_kernel_start - searching for _text
2. In machine__get_running_kernel_start - searching for _edata
3. In machine__create_extra_kernel_maps - which is the focus of my question

Regarding the third call (implemented in tools/perf/arch/x86/util/machine.c=
),
I notice it searches for:
- _entry_trampoline
- __entry_SYSCALL_64_trampoline

I'm puzzled by the dynamic allocation in add_extra_kernel_map, which seems =
to
expect multiple __entry_SYSCALL_64_trampoline symbols. This functionality w=
as
introduced in:
https://lore.kernel.org/all/1526986485-6562-1-git-send-email-adrian.hunter@=
intel.com/

I've attempted to trigger the trampoline logic in two ways:

1. Using the example provided (uname_x_n.c), which only recorded these symb=
ols:
   - entry_SYSCALL_64_after_hwframe
   - entry_SYSCALL_64
   - entry_SYSCALL_64_safe_stack

2. Setting kprobes and kretprobes to try to make the kernel create these sp=
ecial
   trampoline symbols, but this approach also didn't work.

Questions for the perf developer community:
1. Is there a reliable way to trigger this trampoline logic in perf? I'd li=
ke to
   create a perf test for this functionality.
2. If machine__create_extra_kernel_maps is obsolete (since it's
x86_64-specific),
   could we remove it to reduce /proc/kallsyms parsing time by at least 50%=
?

I'm working on a patch to simplify machine__create_kernel_maps to call
kallsyms__parse only once. However, I would appreciate guidance from those =
more
familiar with perf.

Side note: Could exposing the kernel's lookup_symbol_name function
(from kernel/kallsyms.c) to userspace eliminate the need for reading
/proc/kallsyms?

Best regards,
Krzysztof =C5=81opatowski
