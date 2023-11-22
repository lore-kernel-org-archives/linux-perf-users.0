Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9A383;
	Wed, 22 Nov 2023 09:35:46 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so5373753a12.2;
        Wed, 22 Nov 2023 09:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700674546; x=1701279346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q64HA3g4BGidyi1Zr+WVLkIHIT41U29VcqcT8ARi/uk=;
        b=DrdgQ7IKvz+bPnZEvLDHhdnG0itjzpurjDxVJtpwaumeS3vVAiieCTw07q9mlMFtXy
         91IYJkGXyojZv5ghASMTIak81fAnn/vAQ9mLu8IODyV4SBw5bQaOAEthVEGIZ0BLJxUL
         oJ83t8Oimkp/2zEW4tNQHQcuedGU+jTioCR7qJIajAMThF89zDhtJEC1hlW4gTVE+9pr
         N18N1taxKHfvo9unPh20yiM2HrwMhbQgOrAuLcnwgL1+7QH5k/skBy+fqU9rCpqDx7hr
         9CQw4GCPq5m6b/lvavUJcKl8A3CEE8MBQ/9lNkeB4OISZ6qUqdtIFNlroH+8Mt89Fk6i
         UXMg==
X-Gm-Message-State: AOJu0Yz8MetPc7WU7ZNE9OpA1dAIBaTAPeC4JE8D5A9K8odTP2YmIbwj
	4soECjwFjEWWj2I05fVyuvTco+K+0wlF/n+TxAzif5q1
X-Google-Smtp-Source: AGHT+IFPO4nw6FY753XdB3sG7l4+V/22wueWCO3IWWkbzq0KklEGGmFX9XQ6ULvObN3vYH3DtqFCawvx232Q0wHhBr4=
X-Received: by 2002:a17:90b:4d8b:b0:27e:277:3015 with SMTP id
 oj11-20020a17090b4d8b00b0027e02773015mr3423032pjb.16.1700674545824; Wed, 22
 Nov 2023 09:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV4vUuxBILOC3j73@kernel.org>
In-Reply-To: <ZV4vUuxBILOC3j73@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 22 Nov 2023 09:35:34 -0800
Message-ID: <CAM9d7chCfEfCdopCiEeumeGU2191eJrLQQeUJL_OGY-a4fFtOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: Disable __packed attribute compiler warning
 due to -Werror=attributes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 8:41=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Namhyung, I had to cherry pick this from perf-tools-next as I noticed it
> was also failing when trying to build perf-tools/tmp.perf-tools + your
> header sync series + Ian's ARM files missing in MANIFEST for the
> detached tarball build.
>
> With these patches I managed to complete 'make -C tools/perf build-test'
> + 'perf test' + my suite of perf build containers.

Hmm.. ok.  I will cherry-pick it to perf-tools.

Thanks,
Namhyung

> ----
>
> Noticed on several perf tools cross build test containers:
>
>   [perfbuilder@five ~]$ grep FAIL ~/dm.log/summary
>     19    10.18 debian:experimental-x-mips    : FAIL gcc version 12.3.0 (=
Debian 12.3.0-6)
>     20    11.21 debian:experimental-x-mips64  : FAIL gcc version 12.3.0 (=
Debian 12.3.0-6)
>     21    11.30 debian:experimental-x-mipsel  : FAIL gcc version 12.3.0 (=
Debian 12.3.0-6)
>     37    12.07 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (U=
buntu/Linaro 7.5.0-3ubuntu1~18.04)
>     42    11.91 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (U=
buntu 7.5.0-3ubuntu1~18.04)
>     44    13.17 ubuntu:18.04-x-sh4            : FAIL gcc version 7.5.0 (U=
buntu 7.5.0-3ubuntu1~18.04)
>     45    12.09 ubuntu:18.04-x-sparc64        : FAIL gcc version 7.5.0 (U=
buntu 7.5.0-3ubuntu1~18.04)
>   [perfbuilder@five ~]$
>
>   In file included from util/intel-pt-decoder/intel-pt-pkt-decoder.c:10:
>   /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h: In function =
'get_unaligned_le16':
>   /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:13:29: error:=
 packed attribute causes inefficient alignment for 'x' [-Werror=3Dattribute=
s]
>      13 |         const struct { type x; } __packed *__pptr =3D (typeof(_=
_pptr))(ptr);      \
>         |                             ^
>   /tmp/perf-6.6.0-rc1/tools/include/asm-generic/unaligned.h:27:28: note: =
in expansion of macro '__get_unaligned_t'
>      27 |         return le16_to_cpu(__get_unaligned_t(__le16, p));
>         |                            ^~~~~~~~~~~~~~~~~
>
> This comes from the kernel, where the -Wattributes and -Wpacked isn't
> used, -Wpacked is already disabled, do it for the attributes as well.
>
> Fixes: a91c987254651443 ("perf tools: Add get_unaligned_leNN()")
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/7c5b626c-1de9-4c12-a781-e44985b4a797@i=
ntel.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/include/asm-generic/unaligned.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-ge=
neric/unaligned.h
> index 156743d399aed223..2fd551915c2025ee 100644
> --- a/tools/include/asm-generic/unaligned.h
> +++ b/tools/include/asm-generic/unaligned.h
> @@ -8,6 +8,7 @@
>   */
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wpacked"
> +#pragma GCC diagnostic ignored "-Wattributes"
>
>  #define __get_unaligned_t(type, ptr) ({                                 =
               \
>         const struct { type x; } __packed *__pptr =3D (typeof(__pptr))(pt=
r);      \
> --
> 2.41.0
>
