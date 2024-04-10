Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F3177986
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766557; cv=none; b=dCxrXonrEhYg1llj7giEmfNg+Y3SWRYibssihbHUZo2RoRu+3qxG/64U7gGkfwSNSoMapG+dqjXu1MO/hv2aJVLiF0DQGYkjvLB20fL9LF7Ph515Jor9Q+YlpwfCbv+b0XRGlBy60lU8MU78UAf2uR3gHG2LggA0U5X/6xvHKyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766557; c=relaxed/simple;
	bh=c7/YycqgVy2m8nKCbgF/qoxGf/L67OHl4PRnam+VepE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHCEbRaSR4NYvJR+4VcbDH4YyLN4XNhvVFykeYOBE3v+jqipGbScJR77WxUZn6srsW6Hk9sCGCPxnuGjnWLMlMesskcLNMxwKog/zqAVqV/nrl4nvNvaXW4Qq00mkmgxfvLRUvvJDAWZ3BHH0TmbQGwQ0YZf56ALea9HxXKW1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctuW726J; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctuW726J"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a3a4c9d11so177455ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712766555; x=1713371355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54EjqRfmjYGMgdcBMrDuq0O++H86LcfrhBJL4buY5JE=;
        b=ctuW726JUFaG2KcAQsQeZfy7stF9bx4XEywSVidF/RHUiJDFXXbtB7Y8VwAPNq6PH2
         syEbZ2sc+0AWjbzu5DAAhi+GUdVB8rxvcrgS4hh42lptfyLMXA7nAYUniCu/64pmQaRh
         vpegwB8nWpacMItC98Bf4pyewc+HerjVCNDuS9yST9TpGmhaNPUeL11zE0m+Ub70WvEO
         g1UYZtOglVh43zQLBva4gJXsrFVXuCiRq8El7bYnpqbnPs8RiaqFtDJqvJx83oXVai/K
         uMMNwyc3DYxq+NcHAuwZ3GCVoZGvhARnFjScevaXSbIVor2gL4cDwLPLRfaZOrh5FTew
         MwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712766555; x=1713371355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54EjqRfmjYGMgdcBMrDuq0O++H86LcfrhBJL4buY5JE=;
        b=ptRiSfPZK3cRDP0M+cQnsMhBRkIUrPk1CaZ+MZW8xRjiiib0X82BsXBU+8otgDdz5e
         P5nxAV20rFD+jB4WEQ4RAXxoElCQAvWZEvysUwBJG4UG0FcbF40XXvn+kgbl9enq7PDW
         XLRM67cyXhu8VnD5X2lRvYDq2ZtOS1S0LZSLCTPIzqET6gjsMvm4QOMQSredYxtAVgzN
         tqAJViEmFyeu30yZCbkVYGHX1d7hSNEWExr6qnNBY3yIj+GCdPs/JkC4AJ37v8KqgkLj
         ebYQ626309Nx/7qZzC2ytno5J6K08LEsAI3f1vxaEcp02XuAofbK6VHrk1PPNmv2Blhz
         5lSA==
X-Forwarded-Encrypted: i=1; AJvYcCXHjKxpC+v1tI+lAPmD/QEEX8zTEZnE9Yia8MZXthJ7AVJMG/Ig4uNYBI06V5fZVozp//RFokNuXldsuECQaks3LG8B8KDOns8YRufaXpgVKw==
X-Gm-Message-State: AOJu0Ywh6lPoDaIZvOf2n5B0x4ey2tGTVXc/tk+uNahf8s80rW0TiSqT
	REn1yCrmqAENbpFDgFPpzb70CuVIsQJ0IxXPD6/pWrjhBzTkMo7Ep7gSYOlaBXQ5xO4vC4UswIE
	1I2QVql0xdvu20jS9/fOnfGSiZu4ECgMUQieB
X-Google-Smtp-Source: AGHT+IG6/h/HVI3jX1nRW3EOsPwOe5MMpa0OD4JZUGwmkmBPfQdwzoz7yzNT+wPwcMZYHuK/XI2P9ivEwYGmt4NjIek=
X-Received: by 2002:a92:c70d:0:b0:36a:112b:b6f9 with SMTP id
 a13-20020a92c70d000000b0036a112bb6f9mr251978ilp.2.1712766554854; Wed, 10 Apr
 2024 09:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409235000.1893969-1-namhyung@kernel.org>
In-Reply-To: <20240409235000.1893969-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Apr 2024 09:29:01 -0700
Message-ID: <CAP-5=fXGBUikHNRt6rVxLzOw6UFkaWizZ-_iDAx6aX=EVEXH8w@mail.gmail.com>
Subject: Re: [PATCHSET 0/6] perf annotate: Add TUI support for data type
 profiling (v1)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> This is to support interactive TUI browser for type annotation.
>
> Like the normal (code) annotation, it should be able to display the data =
type
> annotation.  Now `perf annotate --data-type` will show the result in TUI =
by
> default if it's enabled.  Also `perf report -s type` can show the same ou=
tput
> using a menu item.
>
> It's still in a very early stage and supports the basic functionalities o=
nly.
> I'll work on more features like in the normal annotation browser later.
>
> The code is also available at 'perf/annotate-data-tui-v1' branch at
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (6):
>   perf annotate: Show progress of sample processing
>   perf annotate-data: Add hist_entry__annotate_data_tty()
>   perf annotate-data: Add hist_entry__annotate_data_tui()
>   perf annotate-data: Support event group display in TUI
>   perf report: Add a menu item to annotate data type in TUI
>   perf report: Do not collect sample histogram unnecessarily

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/builtin-annotate.c          | 149 ++++--------
>  tools/perf/builtin-report.c            |   7 +-
>  tools/perf/ui/browsers/Build           |   1 +
>  tools/perf/ui/browsers/annotate-data.c | 312 +++++++++++++++++++++++++
>  tools/perf/ui/browsers/hists.c         |  31 +++
>  tools/perf/util/annotate-data.c        | 113 +++++++++
>  tools/perf/util/annotate-data.h        |   6 +
>  tools/perf/util/annotate.c             |   7 +
>  8 files changed, 515 insertions(+), 111 deletions(-)
>  create mode 100644 tools/perf/ui/browsers/annotate-data.c
>
>
> base-commit: 9c3e9af74326978ba6f4432bb038e6c80f4f56fd
> --
> 2.44.0.478.gd926399ef9-goog
>
