Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406D169381;
	Wed,  5 Jun 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571569; cv=none; b=htBTAQLs8ms1maXPuD77pA4NIoAVp8RFXYrgWUVMTJ8ubAFiNWU4KXN2sY0Zlu2UWXSbSH+ywVdcXCGIS1NU/77i7xhZDih5dgbyhHqguq+b5y/Mn2BnZBCB7YJyl4ZE4g8INp+e0hX3gEnvl3S0vXmiUANFwDqUEQXh7M2Db8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571569; c=relaxed/simple;
	bh=z4AquIlgWDEkWPBadYynuGitiEkZf7rVRIOm76Qo36s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkR/JWOzrSh36+XBkHCyW86AnQ0Pxeen27iyc1QEakRop3G5N6dGmnu8Pv+we0q0YOdQ9DpX6QwDmB54A/SWcq5hX4IZPFOcNMXP3C+KAqJzF0FBBAhjrXjXneDsopIpV6ORYoU004VYm+ssB8txVXFMCeGz0QsTWkvg6RAK9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmxKmoEs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmxKmoEs"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68b5f18fc5so442519566b.1;
        Wed, 05 Jun 2024 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717571566; x=1718176366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DWcMOXoonO165FoCGi6lVgjsd12bqTBfFwJcQ9yZaE=;
        b=GmxKmoEs5bhHOU49+JbJu7AggNXHJ7f7XXIq/AielS+NTXunu9jpaF3seqtuvqszgi
         ee3qSDi84jIZpZY6QB3axcgYU82yynJjAiEZc6Q4CUYCgrut/Ll607nCZZwtlxAwzpa2
         Ear6MtHm8Y/aAPoItbE77rZi42xI7i/0gnls4ibvBsb3v4k3D+wF5ICHQlSnlboDQMKR
         eexI8MG3LOzwVUi2Uvopi6yyH9sMYTMC16nwBLqGhG7lwQbHRF9SnfG5aJ3DSxjlkAML
         8bwjD0t1E5WS1s8ZezMB9iKgDNcLD2Cl+pDYAo1P32AEu5ueeRZqRPUTeQGFXatTJdxv
         GWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571566; x=1718176366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DWcMOXoonO165FoCGi6lVgjsd12bqTBfFwJcQ9yZaE=;
        b=rkybld/cEO0TXg/Gg1+x9llsFK7SyZfOV+gWRhZoS3i4/KJM5RE39jttQb0lLI0sK8
         /v7AqBMd887hMAWm/rm41BQFMGlkaNGDU3Q+4O2O2SV9mnP5w9UFPG0u/d/GSYtB9TSb
         PhvrrTtrmuuV3HKRGU1fJlGYKTrHsrrx/Vna9PjjQESG1T1DB8NA7OUeqeDr1AQ3hwdt
         SelOj+O0W32zMejsiWx2f/03w5phMGcPiE2SwuS0DrpOSGgkBA7pDTe30H5ybKsGobMs
         bbpziQIGT8/Ga+VDRs9YDd89IN7edgEtCCeAbSN50U2yaqml3L+OH5uMdO2ZEgsgsKSn
         aXvA==
X-Forwarded-Encrypted: i=1; AJvYcCWn1YohZ2WwbqVdqjQJJICEvTlq66XrxNITsY7X8bOVmejL+CBLU3SoxruQiVr6+hhbeLRRdByVYDlByWMuNSJVJZi11GD9bUDeZiDrsYv2lUJeE1cw4KQ8Hgjdf0yBUsG+dYMExiOhXDGuugAovg==
X-Gm-Message-State: AOJu0Yyl5uoDAjwTYeTa91N/mMGkD2d2QeQqPq5DJjmNGsHACgQD8bps
	R+9Dh9Xv6ZubOc1P5If8W8eOxL++ZSX3bDn1D4zix1uLNNH/kuA0
X-Google-Smtp-Source: AGHT+IFYKnveG9DBX//L1ic3dpu56BfTWuatZPfhxkZzxumDTDnf9nb9iOU5LO8GzJQXuL8FaS3bqA==
X-Received: by 2002:a17:906:a184:b0:a5a:15b6:25ab with SMTP id a640c23a62f3a-a69a0022d7dmr103627066b.61.1717571565637;
        Wed, 05 Jun 2024 00:12:45 -0700 (PDT)
Received: from gmail.com (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a690605d07asm418212766b.130.2024.06.05.00.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:12:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 5 Jun 2024 09:12:43 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
Message-ID: <ZmAP6-bCX8TN0oSB@gmail.com>
References: <ZjssGrj+abyC6mYP@gmail.com>
 <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com>
 <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
 <ZkJK3x3zQ9a4wp8E@gmail.com>
 <CAP-5=fUh+GoqERAF-qf8zx4kwq2uzwR2Ugop5XOkPexYGAqF3A@mail.gmail.com>
 <CAP-5=fWXDPfNqLz6DHYe9+dev_e6X5TcTe_xzOOz27yDkT7o7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWXDPfNqLz6DHYe9+dev_e6X5TcTe_xzOOz27yDkT7o7A@mail.gmail.com>


* Ian Rogers <irogers@google.com> wrote:

> It is working at v6.9 for me

Did you try to interrupt the build with Ctrl-C, to trigger the failure as I 
suggested?

Your logs are showing full builds AFAICS.

Thanks,

	Ingo
