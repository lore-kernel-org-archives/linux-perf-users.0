Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B4210F6
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpC5rsHp"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D823D46
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 11:28:30 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c4ed8eef16so3178809b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699903710; x=1700508510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6zAXSnrAERC5bkOosNQUecD7gKE0Mvf1RD8tBnHIyA=;
        b=ZpC5rsHp1/S97FcbzsmivWb7hUbuJbL/zDohoivP5klisRHlFMnSOrYR2MWCm2L2/B
         qr/EyFttS00d81oy5oQkRLPr0dRJfGkRTbU5UkqmBOrrT0wabYdzscr1DFrBHBrWG4bU
         z1rKW4lJZac/jw9UvvBlLb28oWAGX4lHQ5V76O+JdF+IUf+GctsczkiAV4J/N7RI2/yz
         1lO8/kaUxW2562QE5i1tle9WPpJ/QnMa+mYeRHtLiroCgBGxZV9yHY2LcbKcA3vmlqiB
         Smzbz3IqiLZHYU2tF+Axq05wBAZNTVh6dc5etZlHmfnMqyrQglNhe2fPTBy8mPraS1SJ
         BXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903710; x=1700508510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6zAXSnrAERC5bkOosNQUecD7gKE0Mvf1RD8tBnHIyA=;
        b=wJ0QQEN9BjrRcgxpZ8lF1AFh5LaE9vfNwCljksiky9ZpPcX6HY4Yc1gc1TqqcbudvE
         Z2HdWCtDHcmFyE9E3HFr2+j9HFUkxZFMAtFg0JFBHntBFZht0wCOeQAPmcZ7VB3bol9a
         1CYKNwZ7pAVKr56ewM+B94lGis+UmS8BU3kHqrh1C40vjnRMVuj+WrNhYpfVF8iOzcoX
         nDnheXgeSqXy/hG/JzYx6jyt3ryKB+CszOo4tKS1EnF9oOMuRIAj7jKnhA6b+s7ZGyHo
         aYA1xDwipBeTwYqCE77wHvG87efCAOO4pfx5ZtBQQW3CZ5nkKUpPKmtaW32vGK0rxJ6l
         DDhw==
X-Gm-Message-State: AOJu0YwK8jB4gNroFW2afSwbNpCiQgAxLeFFOPdWYbUQsIeB6kC100ZS
	aLjLr6BaBOC9QyU0XoyXEDgLsAJbU4VtWRllb34kug==
X-Google-Smtp-Source: AGHT+IGr0HRXbgLk/YXcNfzDC/qE+X2UVnJ6UfBcxb8aJ/lod2vZNkPsoWbu7+KbvKjyq7oBnYToSfstL9LwRfepiRc=
X-Received: by 2002:a05:6a00:391a:b0:6bc:f819:fcf0 with SMTP id
 fh26-20020a056a00391a00b006bcf819fcf0mr8928964pfb.1.1699903709845; Mon, 13
 Nov 2023 11:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102150620.940538-1-namhyung@kernel.org>
In-Reply-To: <20231102150620.940538-1-namhyung@kernel.org>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Mon, 13 Nov 2023 13:28:18 -0600
Message-ID: <CAEUSe78g5XUpQ19t4LbeGK4v_PZNTDZ=wjRM325Bm8haiUCoXA@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.7
To: Namhyung Kim <namhyung@kernel.org>, Yang Jihong <yangjihong1@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Thu, 2 Nov 2023 at 09:06, Namhyung Kim <namhyung@kernel.org> wrote:
> Hi Linus,
>
> Please consider pulling the latest perf tools changes.
>
> Thanks,
> Namhyung
[...]
> Yang Jihong (29):
>       perf evlist: Add perf_evlist__go_system_wide() helper
>       perf evlist: Add evlist__findnew_tracking_event() helper
>       perf record: Move setting tracking events before record__init_threa=
d_masks()
>       perf record: Track sideband events for all CPUs when tracing select=
ed CPUs
>       perf test: Add test case for record sideband events
>       perf test: Add perf_event_attr test for record dummy event
>       perf kwork: Fix incorrect and missing free atom in work_push_atom()
>       perf kwork: Add the supported subcommands to the document
>       perf kwork: Set ordered_events to true in 'struct perf_tool'
>       perf kwork: Add `kwork` and `src_type` to work_init() for 'struct k=
work_class'
>       perf kwork: Overwrite original atom in the list when a new atom is =
pushed.
>       perf kwork: Set default events list if not specified in setup_event=
_list()
>       perf kwork: Add sched record support
>       perf kwork: Add `root` parameter to work_sort()
>       perf kwork top: Introduce new top utility
[...]

We have found some build regressions on yesterday's 6.7-rc1:
-----8<-----
  builtin-kwork.c: In function 'top_print_work':
  builtin-kwork.c:1646:28: error: format '%ld' expects argument of
type 'long int', but argument 3 has type 'u64' {aka 'long long
unsigned int'} [-Werror=3Dformat=3D]
   1646 |         ret +=3D printf(" %*ld ", PRINT_PID_WIDTH, work->id);
        |                         ~~~^                     ~~~~~~~~
        |                            |                         |
        |                            long int                  u64
{aka long long unsigned int}
        |                         %*lld
  cc1: all warnings being treated as errors
  make[3]: *** [/builds/linux/tools/build/Makefile.build:106:
/home/tuxbuild/.cache/tuxmake/builds/1/build/builtin-kwork.o] Error 1
----->8-----

This is when building for Arm (32-bits) and i386. Bisection points to
commit 55c40e505234 ("perf kwork top: Introduce new top utility").

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

To reproduce locally,
  tuxmake \
    --runtime podman \
    --target-arch arm \
    --toolchain gcc-13 \
    --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2Y6I5B=
lgre1fELnAgUTZxqjByvv/config
\
    debugkernel dtbs dtbs-legacy headers kernel modules perf

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
