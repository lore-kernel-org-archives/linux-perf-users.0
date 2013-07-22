From: Oliver Yang <yangoliver@gmail.com>
Subject: Re: [PATCH] Fix build failures of python/perf.so.
Date: Tue, 23 Jul 2013 02:40:14 +0800
Message-ID: <51ED7C8E.1080701@gmail.com>
References: <1374493559-11139-1-git-send-email-yangoliver@gmail.com> <20130722150242.GB2157@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52910 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629Ab3GVSkU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 14:40:20 -0400
In-Reply-To: <20130722150242.GB2157@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

=E4=BA=8E 7/22/2013 11:02 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 22, 2013 at 07:45:59PM +0800, Oliver Yang escreveu:
>> If gcc and python are not under the standard path, it could cause
>> the build failure of perf.so.
>=20
> How can just adding the prefix to the compiler like that fix somethin=
g?

Sorry for causing the confusions. I sent out a wrong patch.

The one I want to send out was,

 $(OUTPUT)python/perf.so: $(PYRF_OBJS)
-       $(QUIET_GEN)CFLAGS=3D'$(BASIC_CFLAGS)' $(PYTHON_WORD) util/setu=
p.py \
+       $(QUIET_GEN)PATH=3D'$(CROSS_COMPILE)' CFLAGS=3D'$(BASIC_CFLAGS)=
'
$(PYTHON_WORD) util/setup.py \
          --quiet build_ext; \
        mkdir -p $(OUTPUT)python && \
        cp $(PYTHON_EXTBUILD_LIB)perf.so $(OUTPUT)python/


But I realized that our customized env had a naming conflicts with
perf makefile. In our customized top level makefile, we defined
'CROSS_COMPILE' as the location of compiler, which is under a
non-standard path.

If without this fix, when we use the python from a non-standard
location, it will try to find gcc under the directory defined by
$PATH. But we do want to specify the gcc location which matched with
our specified python version.

Here is the original error messages, the gcc matched with python was
not under the directory defined by $PATH,

CFLAGS=3D'-Iutil/include -Iarch/x86/include -DLIBELF_NO_MMAP
-DNO_NEWT_SUPPORT -DNO_LIBPERL -DHAVE_CPLUS_DEMANGLE -DNO_STRLCPY'
'/nfs/tools/usr/bin/python' util/setup.py \
  --quiet build_ext; \
mkdir -p python && \
cp python_ext_build/lib/perf.so python/
unable to execute gcc: Not a directory
error: command 'gcc' failed with exit status 1
cp: cannot stat `python_ext_build/lib/perf.so': No such file or directo=
ry
make: *** [python/perf.so] Error 1

>=20
> Looking at the references to CROSS_COMPILE in tools/perf/Makefile:
>=20
> -----------------------------------
>=20
> # Define CROSS_COMPILE as prefix name of compiler if you want
> # cross-builds.
>=20
> <SNIP>
>=20
> CC =3D $(CROSS_COMPILE)gcc
> AR =3D $(CROSS_COMPILE)ar
>=20
> -----------------------------------
>=20
> Can you provide the make command line you're using that makes it work
> for you with this patch?

I just export CROSS_COMPILE with a directory contained with right gcc
version. Now I realize that this patch is NOT correct, and it just
happened to work.

Thanks for your comments. Sorry again.
