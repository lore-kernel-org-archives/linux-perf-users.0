Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F225B690
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211746; cv=none; b=sgLJbgn8SwYoBpkzfsSOxtQ4zYlTskHiYkh4eE6XChP9HL98i4PKpuBWFhzAk1qzSAkhtPiRVcGbL95PdlWClfbwZoxOo7T2AsJthULGD13ygorH2kivtSKep1EYMBKYtJKm4yjwuZVi6AemssgL0gEx4zYWgxCHttrajFgeCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211746; c=relaxed/simple;
	bh=IcdrIqs90CcLCAGhFUsmvv1jkxcaZyMPFUeEij+QgGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nhNvAl4HV2UL5NLnlSWum0vHm8LcNfzVVg5m0hBSVmd4LkqP3azmdaPp/p0mi+yF8QtFYxEc19n2YldkEZUoTzZkNVdOiJKXgldY5us45Mh0xsM4/wXgJhE9p/Kq6TbANx5UqFALv8K3LuQvK/UB5Crm9PIx/gn9EUtHJx0V70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1olh1jz; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1olh1jz"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so5515ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 10:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739211743; x=1739816543; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcdrIqs90CcLCAGhFUsmvv1jkxcaZyMPFUeEij+QgGg=;
        b=b1olh1jzEupzU/TXA4iKTVqgf6+0E7yYWLgFM6zHR4n16dH78YZ83whPBcdbsqpTLB
         hXKq6pWb0LEq8PCN1LRR6lA2p7i8yw1FpFQsSFlqDWme2rsi4Nf0y7AWVpeWBmKTr5YI
         Ic5LLI/PWhjIIhRc6GMHnHEE9yIJjIGa+eLMKy77bR2UGCGBz+vRVvKKJPbWCVqTlQ9O
         fKX/GEMTOH9ky3QLZqzyu3MUzIzW6D+knSZuk4wzWDc75JD+ev0skfcRnGBfzjBFRo3+
         fuMfxZYL9gt5TlKLo/QY/5XaEqeTRtyWr+Q0smWjjb9/IjzB6lG1ST96rSeX+jUmOM1k
         +6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211743; x=1739816543;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcdrIqs90CcLCAGhFUsmvv1jkxcaZyMPFUeEij+QgGg=;
        b=mMl84gzo6zHJxyhRVqwS2kci3wyE4SLa9QsitDGmUelzqzbSDq7JZc19+eMNATupG/
         8vlJjyC6YX9l62AWbhD4q37iBsR5HWdFzLA2kUiNEdOcJJ9Nl/vDLebefgCwrOakxRLK
         0tTJwBQp6NzEkpU6Jl4JJ/RZ6xtFhktSp/lcLNGoh39iw58ClIEVGUAZt3tZRifICZ2B
         bLSKRSxQ+fAPJbu8v+PnrctAhyH9eYXmFJVr7UMB4nMDVOPwn4kNjotBra/90gEP9iVE
         9CvEvs10w4XnAwykU0zBJcvkN6wSdFEZayBr9nwgtBKVsTawNDR8nM5AW1IaRLpatj+s
         SLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXauHmyUQVDUVUfh09/hu/aaEqlL4jS/Tr9EkoV00tHC/VazSS63IoXa3pm+PIVHCVVHoRizSXzPNARcpHqRAIh@vger.kernel.org
X-Gm-Message-State: AOJu0YxeT5L7ZZIEqWfyh1SJkqnBfN+e+oKOKZC6/Kg/fpE4okk4cGAE
	2nK9SXRvVnBFMg2/03wKWUkRhDT0V04eFuXGmN+jD7kOk5lAPnPl/DGVE5xhS5dxGby/m1JqWws
	dicSb3aSLV3cAGsfAIfkcoaZUo8a74WqvcaH4
X-Gm-Gg: ASbGnctxtROQpnSALgckF+SZxS3UI0glDFdww4+3tTNHu0/Cqb41EmQlWGnRvZzHxcE
	6QDh0VEboGyBq/qzK/faUZRYGOPGJgc2tjxGCelAruiW6DCDNZDQ2xEltfFbMioJfQutB/RG9tB
	cPSaYJIAKCurAmcsYNdwMD0T/Y
X-Google-Smtp-Source: AGHT+IFTAuNfiw/XhQoBcYu+J9Hya4qnn2jHdbkYvCPw3zBjIRxktXB1NTEFecewpM4GA6NHDMZjZHi5G1f5cYQe1Cg=
X-Received: by 2002:a05:6e02:2491:b0:3d0:62be:12c3 with SMTP id
 e9e14a558f8ab-3d14efbfcd0mr7274625ab.1.1739211743085; Mon, 10 Feb 2025
 10:22:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106215443.198633-1-irogers@google.com>
In-Reply-To: <20250106215443.198633-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 10:22:12 -0800
X-Gm-Features: AWEUYZmXHIPhU1yc2AP2lYcBo-6OHxpX8oMootUclJA7tttmBpiUKue4uJ9MEFM
Message-ID: <CAP-5=fWvsy74obPj7Fs2ghUHNVu1A5ywkpjOU6ibC7vvWu2b0w@mail.gmail.com>
Subject: Re: [PATCH v1] tools build: Fix a number of Wconversion warnings
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 1:54=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> There's some expressed interest in having the compiler flag
> -Wconversion detect at build time certain kinds of potential problems:
> https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/
>
> As feature detection passes -Wconversion from CFLAGS when set, the
> feature detection compile tests need to not fail because of
> -Wconversion as the failure will be interpretted as a missing
> feature. Switch various types to avoid the -Wconversion issue, the
> exact meaning of the code is unimportant as it is typically looking
> for header file definitions.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. Also:
Reviewed-by: James Clark <james.clark@linaro.org>
Would be nice to be cleaner wrt compiler warnings.

Thanks,
Ian
