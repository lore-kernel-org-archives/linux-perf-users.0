Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B892B10DF;
	Thu, 30 Nov 2023 14:12:20 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c21e185df5so1162233a12.1;
        Thu, 30 Nov 2023 14:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701382340; x=1701987140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z2BEAePLu01GRPlfECCRaK8cq/hBNpwuCocumn+ug4=;
        b=VjrD9LBGRx0AT73T4mgniuqfUKmBSH4mqWGmUblO+7mXJJ6OX1F/dLSo7++qotgAau
         KFoDVwPNDkVPPLiFqdPKcaF21ZPgK+zJDmL0LnvKOPEnbHicz2+/g8WKokZ3Tg+GLPz+
         9KJ0WJIAJb8MG8eWdi1tXu/iKHh9JyxVDKm4X7bZkKC/GCj4LZgBWZui5TGBzZoZo4Am
         E+GbwgvqcPZfhD1Q5F1FwksbVueQyEj6aGpESI81BQ6LTWb1/bnyBLlThwgW2zePfwat
         jiRr4uuitRSu3KWpmDoZw4K/fchPWBVrxNyKsgbKKC9C95JmqFHbgInicRqrbzfbYq48
         4NlA==
X-Gm-Message-State: AOJu0Yy7Q0mU1NhRmxBZCcKdCKAAQR3+tipeT9eQeUk8HKU0uFoStifZ
	EzQ93GKJKP2g+rwlb0BtAf4avqiSxxutbjqaFFY=
X-Google-Smtp-Source: AGHT+IHUrfUhc1KjoJM0sgOBbQJ/V0+8OJ0d1ll3lqAXcHNTp5BImJQJGhsViHMJJr60vBWw6pSedfARAoFCeE4+AQ8=
X-Received: by 2002:a17:90a:f3cc:b0:280:25e8:f7b4 with SMTP id
 ha12-20020a17090af3cc00b0028025e8f7b4mr24694263pjb.15.1701382340064; Thu, 30
 Nov 2023 14:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWkEeqdmCHMLhLr2@kernel.org>
In-Reply-To: <ZWkEeqdmCHMLhLr2@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 30 Nov 2023 14:12:08 -0800
Message-ID: <CAM9d7chi4OQRZRpbNnHFwJ6Esfr+P3b6FQBmHiqU9HXcp8+HLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it isn't
 available in busybox
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, Nov 30, 2023 at 1:54=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Namhyung reported:
>
>   I'm seeing a build error on my Alpine linux image which uses busybox +
>   musl libc:
>
>     In file included from trace/beauty/arch_errno_names.c:1,
>                      from builtin-trace.c:899:
>     /build/trace/beauty/generated/arch_errno_name_array.c: In function 'a=
rch_syscalls__strerrno':
>     /build/trace/beauty/generated/arch_errno_name_array.c:142:49: error: =
unused parameter 'arch' [-Werror=3Dunused-parameter]
>       142 | const char *arch_syscalls__strerrno(const char *arch, int err=
)
>
>   It looks like busybox find command doesn't have -printf option
>
>     find: unrecognized: -printf
>     , Yesterday 9:16=E2=80=AFPM
>     ,
>     BusyBox v1.36.1 (2023-07-27 17:12:24 UTC) multi-call binary.
>
>     Usage: find [-HL] [PATH]... [OPTIONS] [ACTIONS]
>
>     Search for files and perform actions on them.
>     First failed action stops processing of current file.
>     Defaults: PATH is current directory, action is '-print'
>
> So just remove it and pipe find's entry to a basename loop to produce
> the same result.
>
> Fixes: 0337cf74ccf2a434 ("perf util: Introduce architecture specific errn=
o/name mapping")
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks for the fix!

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/trace/beauty/arch_errno_names.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/tra=
ce/beauty/arch_errno_names.sh
> index cc09dcaa891e04bb..3ec8781344db13ba 100755
> --- a/tools/perf/trace/beauty/arch_errno_names.sh
> +++ b/tools/perf/trace/beauty/arch_errno_names.sh
> @@ -76,7 +76,7 @@ EoHEADER
>
>  # Create list of architectures that have a specific errno.h.
>  archlist=3D""
> -for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -print=
f "%f\n" | sort -r); do
> +for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d | whil=
e read arch ; do basename $arch ; done | sort -r); do
>         test -f $toolsdir/arch/$arch/include/uapi/asm/errno.h && archlist=
=3D"$archlist $arch"
>  done
>
> --
> 2.41.0
>
