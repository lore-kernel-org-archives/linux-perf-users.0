Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTiD8QGp"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCD6D66
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 11:14:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so9195e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701198851; x=1701803651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sQJEQO1lAXLUO7lOurIsnWNVY/yZ4K1PFUY114AiIg=;
        b=UTiD8QGp5Xp1eKjwifmVLLr7sxUtHpUEziO2Noc8x1Sa37ahGCzd70cf9mCLlsriYR
         HZD+A+nLCdmaZgOAt1LFCEdH0a3v4V5/yO8F5ej7JhiIyw4AJS+wSsRA1Eyw7RoNmHbS
         kEprG0pVuaaVo2AYOfUQIfypUCGP+UKZoRh2lSKEO06R8raWtHeTgJvRQCCmC9b+p6T3
         5id3cBOWTHJDTewr1W4SgT2jaTr6kna3vAlN3wTGnrJqg2ootaVfB373R/jCYusW81go
         3ib+Dg2t2i5xOP546YGZTw9JSZrLDP9pCGbzhpZDIACDYc9IVXsiZyG/jjKB0ZMFjimt
         nG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198851; x=1701803651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sQJEQO1lAXLUO7lOurIsnWNVY/yZ4K1PFUY114AiIg=;
        b=vCKroKu9rFvvTquQA2zmV6cF6ypVf6Tq4V2APb/TGzBX2fCM5vjPsikf2pn906IRpD
         1UkD4nj3m0S3g6uKOX0KtzZvbEoKmMuuZBxMiRCvlgyPcclyMxdbJ+26GSXsPqQt2zdM
         DN9r1mAxV4tPj17loBA318eKJSHO2BJM0JvDo9FRa2CCc2t5lkQJ3sg12igFYh1RleT0
         5pxEo3dQJEOswxUeCFpq7GXg2tH9edvH6GWIAYUNjdOoUQS5k7uvabFOOe6udB2bERpw
         cevdawOok3I7pPByiZFQAeXzcR0bpnPwjiDrMjZtY0XyPC/biANKJu7VVNImEkes+zz1
         iIcQ==
X-Gm-Message-State: AOJu0Yx6gvDpsKBpXhW2E9yc9sdPvxxcvNHuzATB/C/qeH24LROQYOMY
	+RCRoCOpdXcQu7dc/CXJ/FFUa2MTSVUcNVx0amZbcsolQKhmY+A5cqzPuQ==
X-Google-Smtp-Source: AGHT+IEuzdV2LP9iggW4NsbrWUCJTF1PKKYjnA9pmxZjCHha1l8TTtDbQbnJcZcnV6cuVeQyFQfWgediT0WIcK14cYo=
X-Received: by 2002:a05:600c:4f44:b0:408:3727:92c5 with SMTP id
 m4-20020a05600c4f4400b00408372792c5mr852331wmq.2.1701198850618; Tue, 28 Nov
 2023 11:14:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org>
In-Reply-To: <20231128175441.721579-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Nov 2023 11:13:55 -0800
Message-ID: <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> It used to have annotation_options for each command separately (for
> example, perf report, annotate, and top), but we can make it global as
> they never used together (with different settings).  This would save
> some memory for each symbol when annotation is enabled.
>
> This code is available at 'perf/annotate-option-v1' branch in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung

Thanks for doing this and I think it is progress. I think there is a
common problem with having things be an option rather than say part of
session. Having a global variable seems unfortunate but I'm not sure
if in all locations we have easy access to the session. The rough
structure with annotations as I understand it is:

session has machines
a machine has dsos
a dso has symbols
a symbol has an annotation

Annotation is something of unfortunate abstraction as it covers things
like an IPC per symbol (why hard code to just IPC?) and things like
source files and line numbers.

A recent success story where we got rid of a configuration variable
was by switching to lazy allocation with sorting by name for symbols
within a dso. If we could have a lazy allocation model with
annotations then maybe we can do away with large hammers like global
options.

Thanks,
Ian




> Namhyung Kim (8):
>   perf annotate: Introduce global annotation_options
>   perf report: Convert to the global annotation_options
>   perf top: Convert to the global annotation_options
>   perf annotate: Use global annotation_options
>   perf ui/browser/annotate: Use global annotation_options
>   perf annotate: Ensure init/exit for global options
>   perf annotate: Remove remaining usages of local annotation options
>   perf annotate: Get rid of local annotation options
>
>  tools/perf/builtin-annotate.c     |  43 +++++----
>  tools/perf/builtin-report.c       |  37 ++++----
>  tools/perf/builtin-top.c          |  45 +++++-----
>  tools/perf/ui/browsers/annotate.c |  85 ++++++++----------
>  tools/perf/ui/browsers/hists.c    |  34 +++----
>  tools/perf/ui/browsers/hists.h    |   2 -
>  tools/perf/util/annotate.c        | 142 +++++++++++++++---------------
>  tools/perf/util/annotate.h        |  38 ++++----
>  tools/perf/util/block-info.c      |   6 +-
>  tools/perf/util/block-info.h      |   3 +-
>  tools/perf/util/hist.h            |  25 ++----
>  tools/perf/util/top.h             |   1 -
>  12 files changed, 206 insertions(+), 255 deletions(-)
>
>
> base-commit: 757489991f7c08603395b85037a981c31719c92c
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
