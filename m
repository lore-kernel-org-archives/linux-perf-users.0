Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8772BF3C9
	for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944612; cv=none; b=o2oS1QWO0NQQyhtI26ZzFDf4G80QSTazSf66omi0jZ/XPncKpTC2q0sMn3BHGB2dNd35Ih/+U4DC+bOaQoWbkv8hHOI2ZCjRTjyExKWBEdfNT+60rDAjx89KNBp6FCwxJv7ukhBhVlMRAEV6l3hvBvWXCnI7kbvBjcbw5BC1A1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944612; c=relaxed/simple;
	bh=uw9HYp7TY+y8RJAkMxxO3mIxoLQxok6Z5rtlhqEMtzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpuU/IEOD6AuwoOmmyW8rFTsFZziEounnBdp210CwN0/8rWSMvL7nSrykRuKSlRfdWGz5JpHuWqenblkMLB/U7pUzVOBfYH3PrtUo2BGC3ERyNlaIXwiiCfiO29xa08gbAmLAv5QvnXWtV/33CTGtG0jtHRYjf0LvAtdqVSuhPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eD1TjFOP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eD1TjFOP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231f61dc510so46595ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 13:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747944609; x=1748549409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw9HYp7TY+y8RJAkMxxO3mIxoLQxok6Z5rtlhqEMtzA=;
        b=eD1TjFOPkjSwBVHXOIHu76jvAcFSaXXMXMXz2HL9y/4ezxy3cb3qPBTibsfEjVuYgJ
         cGWALBcfHDy+D+dn7e8Wkai5YMUGyqXdpm+cT7kl6ImiCE3TRmGjrdANxBtCLG8XflCA
         BV1Jjxe+1pT5Y8IaHz3pzqaIfsPVE35Qn0FA2q3e8JNBUcW26RoTkQ0xTpuhwLUcB65p
         x1a8HlvchAwJ4o7yqjv/ObZ/dq+6uEUPW0suT00Qgb6aSO59sd3eKaP8nfrzVV7vqgpo
         13Op0nlDZulKS+8UN63TLdZMNEOq8tVMkxdYYJaojJBdz7UB+FqgPOv4+gBEbzMKCOl4
         IjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747944609; x=1748549409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uw9HYp7TY+y8RJAkMxxO3mIxoLQxok6Z5rtlhqEMtzA=;
        b=CR8g3Ac5T+WeJyLYzD9ANFq4ydh1pti9iFzIcSIyLa89KBweop0Uoo7/cMe3OU93hh
         TBk/eswQrWGtOMwEGqTGm18XOkdZjUYus6GOYWLJ+1shbYB7O2HICeV6l1nKndVWRMbH
         p2HEVA5gkwUahac62JAveJ2y/aPcZMTN3LGk/TEPe/zPFXKIIWlynHki5GuvNCFQKTOT
         WrO+WZZa+XbC1n6AfWzR4XQ3qwFVCzBXniuFe1GN7f0HNYrqunhSH34Gm1DlwWTu1dXc
         4aM8HLo3/X7O57prCOb/YAIe4TAjXD2ZLu17tKCwhG8V5gCt7/YKi4vFTzT/1K93PXHc
         iHaw==
X-Forwarded-Encrypted: i=1; AJvYcCWsvTgkq8uB0UlgUKh82UEH61cr31vqM88TFPXeu9qEHU9uWr46syyIkT6Loz2cN5aGXWb+c5n1FfU7BteMaXWE@vger.kernel.org
X-Gm-Message-State: AOJu0YySmiw6Zl6hLJDznFztL3zTs7WevpWmdRHxCOwijLiTkSqzfvKs
	njXVyvoWEz/NjnIa4SbjZDpJVFCI5md5ZAVtHSKqw68IwADaR50z1lFsNXlFGsOuTF4d7DiuA2+
	qgOmh5p1aJ9O5tdplEMDtLRW2u2CLki1XnDXV1dZi
X-Gm-Gg: ASbGncvXHGaC7NA3kOL/aDF6zZv2ybM4+UzRfSgZfP2S4o1xFvSksm8+otH+6sNOKWt
	0jGU+D0UPGZguwaCrIpZpoM50E4RkgL5d0paDP5wLel+oXX3Pp6VDnsb/6xN4r0LoZurkuZIpgB
	ysa+IIYMU4WsNbS8f2OEzl6GIHivf2TF1ewaDn8YicOXPyZSrnEbRoo3UxsijL9AYertJQjO4WK
	e9cmDvPwXM=
X-Google-Smtp-Source: AGHT+IG4FGsVqHi6rXN0E0dPwqX5wRsFdCXEIotJn97oIcWC4dLCcVTQiIBGn9UbqgH9et/oSpeWPLDEyduIif4u4cA=
X-Received: by 2002:a17:903:41ca:b0:216:4d90:47af with SMTP id
 d9443c01a7336-233f2ee4e98mr119985ad.29.1747944609372; Thu, 22 May 2025
 13:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522171044.1075583-1-namhyung@kernel.org>
In-Reply-To: <20250522171044.1075583-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 May 2025 13:09:56 -0700
X-Gm-Features: AX0GCFtaaENpG6rhZsQXbUSYKKSuPuamXi8st3_wtE7GATXAz04cGZxz0L4ToMs
Message-ID: <CAP-5=fXDaKueO9HE-Gr3Q7R6qm2EjwnL845nh7R2OU+DCfrhyA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf test: Support arch-specific shell tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 10:10=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> This is a preparation for shell tests belong to an arch.

I keep repeating that I don't like arch and I think ideally we'd be
getting rid of the C arch tests. I just sent out a patch doing this
for 1 test:
https://lore.kernel.org/lkml/20250521165317.713463-2-irogers@google.com/
We should be able to make perf, tests, etc. dependent on a PMU rather
than an architecture. This means that running perf built for ARM will
be able to do things running on an instruction emulator on x86. It
means the tool, the kernel APIs, etc. are generic and new
architectures like RISC-V can test things. It means cross-platform
(record on 1 machine type, report on another) can work without
tripping over load bearing architecture ifdefs. It means that we
benefit from more testing on generic pieces of code on all
architectures - like sample parsing. We can always strcmp the PMU name
or the architecture at runtime.

Structure wise we could have:
tools/perf/pmu/ibs_op/tests/
tools/perf/pmu/ibs_op/tests/shell

It feels noisy compared to just having the shell test in
tools/perf/tests/shell skip when the PMU isn't present. There are also
things like library dependencies that aren't clear when we have >1
directory. I'd prefer if new testing followed the existing model
rather than this.

Thanks,
Ian
