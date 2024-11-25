Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A921AC453
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Nov 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555514; cv=none; b=fYCeYu9qH8Lv3Bw2BgW3cJVSxpp92q6kzuQuW3jZ85WLKznlvVBRZLMwPgq59CqqgATFjofz5K4RmgJ/1M0YcJxEcsbSKtO1+CdJB5cC45cMJb/U5hQz2vL9nOKv9bUpoohjWfGXXEplnRPEbqJpxE7woUSE4uaCjwRbXPdpsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555514; c=relaxed/simple;
	bh=cXXDgeSD+jw2KeY52OCLTmje8zKuhvYJUpZ0cZ7dS6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ft6E4hm/saGo/CoTysOiWDR6lu5VGLaGxTWbQ031/dCIIDhqQPuRe4ge/gu2uQCThc2h8TGSexpfMxuxNfffPDUyxcee4qypGjR9A3Kiha9aUwT6i7LRI/SSdkxgDFQJMHia9lc2OTdMUplsdQkOIsMMn7cJ9IKiTRjP0yJGKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yi58SlaA; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yi58SlaA"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A91ECC0004;
	Mon, 25 Nov 2024 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732555509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKKtIUCM+nujwXWpeqVUGKqdJOI1jPhgTplYDzhZXLs=;
	b=Yi58SlaAPjSPmUfOjKPZcePHEC/Q5W2sUupTltLX19URNueBsn8nhALKdDBAPiQOIUAjMg
	0gG8uKMnpBR6c3x/uAIH5qSXknEbs8uCqsZSlHfbl452ivk3qo0TPHvoxWUH+619+oPdwC
	HRSgiPuGym7Un5x9Yst+X+DhsoFI35S0ykRmL6LQ/ODaoWo3AYkGdAY57c/RQMLI1B4di3
	6NhQwKURe2WW4AwJlqqtj0STmkcypYjDFyiDOMSqLrsADKgOQgQd/njowFDJ04uAVmy62I
	2SOQE5qugup/1m9sUXmU7Y0/FScqtlY3F6v+uGCK1cwzgz0I9EWOFYqlq7opXg==
Date: Mon, 25 Nov 2024 18:25:06 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: namhyung@kernel.org, linux-perf-users@vger.kernel.org, "Yann E. MORIN"
 <yann.morin.1998@free.fr>, "buildroot@buildroot.org"
 <buildroot@buildroot.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 1/4] Create source symlink in perf object dir
Message-ID: <20241125182506.38af9907@booty>
In-Reply-To: <20240807231823.898979-1-ak@linux.intel.com>
References: <20240807231823.898979-1-ak@linux.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Andi,

+cc Yann and the Buildroot mailing list (see the end of this report).

On Wed,  7 Aug 2024 16:18:20 -0700
Andi Kleen <ak@linux.intel.com> wrote:

> Create a source symlink to the original source in the objdir.
> This is similar to what the main kernel build script does.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Makefile.perf | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 175e4c7898f0..d46892d8223b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -163,6 +163,8 @@ ifneq ($(OUTPUT),)
>  # for flex/bison parsers.
>  VPATH += $(OUTPUT)
>  export VPATH
> +# create symlink to the original source
> +SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)

I found that since this patch got applied in 890a1961c812 (v6.12-rc1)
building perf fails silently in some cases.

The cases I have tested:
 - make <FLAGS> -C tools/perf                       -> OK
 - make <FLAGS> -C tools/perf O=/my/out/of/tree/dir -> OK
 - make <FLAGS> -C tools/perf O=tools/perf          -> fails

The failure in the third case is silent: make exits with a return value
of 0, but there is no perf executable created.

Even 'make <FLAGS> -C tools/perf install' exits returning 0, but no
executable is installed. However the following lines are output during
'make install', which are a sign of this issue happening:

  install: omitting directory '/home/murray/w/bootlin/linux/tools/perf/perf'
  ln: failed to access '/tmp/aaa/usr/bin/perf': No such file or directory

I realize 'O=tools/perf' is "useless" in the sense that the same result
would be obtained by not setting 'O' at all. However I also believe it
is expected that O=tools/perf should work equally to not setting 'O',
and as such there is a regression.

Also, right now the Buildroot embedded Linux build system builds perf
by always passing O=$(LINUX_DIR)/tools/perf/, thus it is currently
broken for kernels 6.12-rc1 and later.

Below is the test script I wrote to automate my testing. It is a bit
more complex than expected because it needs to hide a different bug,
which would otherwise mask the one being reported here. A slightly
different version of this script was used to automate 'git bisect'.

-------------------------8<-------------------------

#!/bin/sh

# Usage:
#   build-perf-report          Build with O=tools/perf
#   build-perf-report <DIR>    Build with O=<DIR>

set -eu

# Default to O=tools/perf
OUT_DIR=${1:-tools/perf}

echo "Output dir: ${OUT_DIR}"

# This is the toolchain I initially used to reproduce the issue:
# https://toolchains.bootlin.com/downloads/releases/toolchains/aarch64/tarballs/aarch64--glibc--stable-2024.02-1.tar.bz2
#
# However commenting the two lines for a native build is equally
# reproducing the problem on my x86_64 Ubuntu 22.04 host
export ARCH=arm64
export CROSS_COMPILE="ccache ${HOME}/x-tools/aarch64--glibc--stable-2024.02-1/bin/aarch64-linux-"

LINUX_MAKE_FLAGS="\
    GIT_DIR=. \
    KCFLAGS=-Wno-attribute-alias \
    WERROR=0 \
    REGENERATE_PARSERS=1 \
    DESTDIR=/tmp/aaa \
    prefix=/usr \
    NO_GTK2=1 \
    NO_LIBPERL=1 \
    NO_LIBPYTHON=1 \
    NO_LIBBIONIC=1 \
    NO_LIBTRACEEVENT=1 \
    NO_NEWT=1 \
    NO_SLANG=1 \
    NO_LIBAUDIT=1 \
    NO_LIBUNWIND=1 \
    NO_LIBNUMA=1 \
    NO_LIBELF=1 \
    NO_DWARF=1 \
    NO_DEMANGLE=1 \
    NO_LIBCRYPTO=1 \
    NO_ZLIB=1 \
    NO_LZMA=1 \
    -C tools/perf O=${OUT_DIR}
"

echo "Kernel version: $(git describe)"

# Revert (without committing) 13d675aea6cac5bb4619ef9e3fdd90129fe6d139
# which introduces a different build failure (fixed by a later commit)
# masking the issue being examined
git checkout -- .
git show 13d675aea6cac5bb4619ef9e3fdd90129fe6d139 | git apply || :

# Clean the DESTDIR
rm -fr /tmp/aaa/

git clean -xdfq
make defconfig

# If building out of tree, create an empty build dir
if [ ${OUT_DIR} != "tools/perf" ]; then
    rm -fr ${OUT_DIR}
    mkdir -p ${OUT_DIR}
fi

make ${LINUX_MAKE_FLAGS}
make ${LINUX_MAKE_FLAGS} install

# remove the fix added above
git checkout -- .

echo "-------------------------------------------------------"
echo "perf files in O (${OUT_DIR}):"
find ${OUT_DIR} -name perf -not -type d  | xargs file
echo "-------------------------------------------------------"
echo "perf executable in DESTDIR:"
find /tmp/aaa/ -name perf -not -type d | xargs file | grep 'executable'
echo "-------------------------------------------------------"

-------------------------8<-------------------------

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
