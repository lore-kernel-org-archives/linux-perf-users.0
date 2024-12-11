Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1670195;
	Wed, 11 Dec 2024 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955094; cv=none; b=lnKYH6VOUU6wOzBdOLm+FgGPPJBe5WvkX8E+27VFWuu4/6oYzmUV6T81zCE+TRF0MO3DLlhcAqexhJF4o9Yjn1ZHMIo1cmfjp0HPJ/YNnSQjMXt7xP4Wn7DcgOvZFbdrYzqTRzHhNS0I73qttfHcu383afyp4Dljtf2kEd8YgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955094; c=relaxed/simple;
	bh=A1CP0y8qufsTH63rfAbY1UQ1Ic6oDiVPgvXlnvvzgaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6gD0uvaQmT16cLpkMCXDHXfL8vsnA90Y/UjePxw8lgNcsGp8F0RLWBSIHcmAsRDjn6E0ULQZ/WR7mQKPSrsLdrryRlYCp8+dQeFHFsNFXDg399KiWjXaUWjgmM1FkZtQwjudVaAmEBd8WJj7bCYdSSFhbANuUi47W9ri7KrHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cweY9EX4; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cweY9EX4"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ef66a7ac14so11992257b3.0;
        Wed, 11 Dec 2024 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955092; x=1734559892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrWVKhbzfs4twWa/I2no+Z1ykCjI6Rc4hMwetgQg/E0=;
        b=cweY9EX4QBhQKqP1x+p0+g6MV6hqgcqt3ABI3kD4b29d7tdGjqryrOh1YA77YRSugB
         WejZa6aa+BcJv9J7XzzV9q4Ki/klUUAQxfhSt+Uzi0mOdpT9B87pvwiCJyyyEtc++JAD
         3YBmqNXBfPD8YMQ2TPcjZAOGuWuTFY3MQM/nPGKk5UpWLHs9zoWsbXbBzc43KJu44uro
         mjjP9ucbI3LYW5ZTgijJtmFG7/BCHInB92LX0MpM6lpvksiB4BB6fbj3TktLJEt5aJSA
         O4887J2SLd7CUJpW3AcezXANaAr94w7d+weTBLnfReJ4nAxYUvQ1AIB3KqV4n+KmDtvx
         MdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955092; x=1734559892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrWVKhbzfs4twWa/I2no+Z1ykCjI6Rc4hMwetgQg/E0=;
        b=aihTxgyhkD0q683e9Pn5jlAzdEI1CsLXxZUeHEi/TIZwbHsqu/qsM+qoODgtVL9jzA
         J1k8bEZ4BB6HHG9gKozMiRQnGZ3RvbHEz7+enwsOJIFwo3xs4f1fEQhnR/ccmMJUgZz4
         vmkl+86BBKCVKL3egcbZbLCOMdRKy6M14MaMq3OM4Z3m5yn/iZPBkRQiPeypaVwJWWar
         vXX1lfk2dTGm9/HKJniEdsLH5ZxAM2M+WfTgFA5Glce89BBVBNlmFOTZJ1peBQztVngU
         zrIOgbYVCDZrBn7aOXwmMbN/UZsuc2ekhU/YkQG9sqeqd2d+V2d3e41FaJnNUlUlfLN8
         czcA==
X-Forwarded-Encrypted: i=1; AJvYcCVv1Hz4wWpVYA43blToHVvCISxZXw9V8sYux7Z71qj6mWqTnuFfhLMhZJtSfKvrT5bJG9r1qwweMiSJkaA=@vger.kernel.org, AJvYcCWnR+7fTweTykTwx96CSj/8zKQZRGljVmyBlqgvcnouQXBv6qxttPqJC6WBJ7PFxm/TbcCRY+KBBk0pzcV5oIbaSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/NAxWyrc9c2jvNOEHK+k7BZ4R+yOeUQ5AS0kzTqrsFCwH+1Ol
	OQCRIkM+cMqRL8h45ODQG/+ZgVY4hqx7qF65XqKqm3H8zQEXkueHWz5XS0HXm4QYuP8syzlH529
	1fT4pkOTdNeBxihQHneL0OTgH8WyNdvOL
X-Gm-Gg: ASbGnctDjGFMpueRy/ZhFovNepcwkblZs5TxXS3teLwzdy+hhCJAwNGMieU5+p8xV7L
	TuMKCmVqa2/r8hj6k6afPp+FZg3+YpGewVg==
X-Google-Smtp-Source: AGHT+IFxjVI5K/wxmDSwhx3r/bS4cmQcwEylrVCOJcSTQZv6a2cmMDO9NGwoykUYLpuZMtoZl4jEN7Q6PyBiPK2XhMw=
X-Received: by 2002:a05:690c:3391:b0:6ee:8515:6730 with SMTP id
 00721157ae682-6f1cd5c77f8mr8378887b3.17.1733955091883; Wed, 11 Dec 2024
 14:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126223257.22465-1-howardchu95@gmail.com> <20241126223257.22465-2-howardchu95@gmail.com>
 <Z1jBDHeEnPrsL7DQ@google.com>
In-Reply-To: <Z1jBDHeEnPrsL7DQ@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 11 Dec 2024 14:11:22 -0800
Message-ID: <CAH0uvogDJN8YhDx4QMDTakUZohv7yAa_UreMCRg+RiZuTNhgJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf trace: Add tests for BTF general augmentation
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Tue, Dec 10, 2024 at 2:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Tue, Nov 26, 2024 at 02:32:56PM -0800, Howard Chu wrote:
> > Currently, we only have perf trace augmentation tests for enum
> > arguments. This patch adds tests for more general syscall arguments,
> > such as struct pointers, strings, and buffers.
> >
> > These tests utilize the perf config system to configure the perf trace
> > output, as suggested by Arnaldo Carvalho de Melo <acme@kernel.org>
> >
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/tests/shell/trace_btf_general.sh | 81 +++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
> >
> > diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/t=
ests/shell/trace_btf_general.sh
> > new file mode 100755
> > index 000000000000..903310b355c4
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/trace_btf_general.sh
> > @@ -0,0 +1,81 @@
> > +#!/bin/bash
> > +# perf trace BTF general tests
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +err=3D0
> > +set -e
> > +
> > +. "$(dirname $0)"/lib/probe.sh
> > +skip_if_no_perf_trace || exit 2
>
> The kernel might not have BPF/BTF support.  I think you can check if
> /sys/kernel/btf/vmlinux is there and skip the test if not.

My bad, I will add the check to it.

Thanks,
Howard
