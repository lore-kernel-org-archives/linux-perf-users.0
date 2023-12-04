Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24238A
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTCCKf09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3ADC433C7;
	Mon,  4 Dec 2023 00:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701649223;
	bh=jN0j9ar53DPBkbPIY/WzZ0rVB4D5j0DTPQkQgAhv1Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTCCKf09O9j91TYXdKlEAM+62UocB0yXW7t8Pyli3nWp4i2FBiX0GVrdYRGQ8+kGo
	 qaEGYukiSiOg70GaNxcGsNzKOp6ZlyoB0Fj/Jl29Uu/cccCUf19Du1WwljCwkFftw5
	 h3Ceavt7uOgRAXuCWI/0Zh2Dj8MjnXWzJ1KaQkGB9PDDoAvAQgMjsk90pGWYCvqVVj
	 ZjbNwXIAa5gJ4008C1+zj1Vv2YSZqhTiy5zNqDjwBrMhQdwkFR9i8AnUe5RFvIRT6P
	 kg9s3//LyARTHthHhAnD2CKi9ERCalQfO24U73v3A3/jY2rrGrGX9dQq7N0nw/rvrX
	 B+TomCH81wGkg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 4805540094; Sun,  3 Dec 2023 21:20:20 -0300 (-03)
Date: Sun, 3 Dec 2023 21:20:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v7 0/4] Introduce perf check subcommand
Message-ID: <ZW0bRAi4Yo76TG4c@kernel.org>
References: <20231116213435.382484-1-adityag@linux.ibm.com>
 <ebgef776v5uvigu2mqkj5mba36cewrhrxzo63fbczrcvyqexlt@nebkf5roy2gv>
 <ZWiPPtwhWHAFfpX8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWiPPtwhWHAFfpX8@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 30, 2023 at 10:33:50AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 29, 2023 at 12:39:43PM +0530, Aditya Gupta escreveu:
> > Hi Arnaldo,
> > Can we get this moving if the series looks good ?
> 
> I'm testing and applying it now.

tomorrow I'll check this:

   3    28.84 alpine:3.15                   : FAIL gcc version 10.3.1 20211027 (Alpine 10.3.1_git20211027)
    builtin-check.c: In function 'cmd_check':
    builtin-check.c:132:3: error: 'strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
      132 |   strncpy(feature_list, check.feature, strlen(check.feature)+1);
          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    builtin-check.c:132:40: note: length computed here
      132 |   strncpy(feature_list, check.feature, strlen(check.feature)+1);
          |                                        ^~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
   4   133.95 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
   5   114.96 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
   6   107.25 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_git20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
   7   120.58 alpine:edge                   : Ok   gcc (Alpine 13.1.1_git20230722) 13.1.1 20230722 , Alpine clang version 16.0.6 flex 2.6.4
   8    82.73 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-17) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2) flex 2.5.37
   9    96.52 amazonlinux:2023              : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn2023.0.1) flex 2.6.4
  10    95.74 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
  11   114.54 archlinux:base                : Ok   gcc (GCC) 13.2.1 20230801 , clang version 16.0.6 flex 2.6.4
  12   110.57 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-21) , clang version 16.0.6 (Red Hat 16.0.6-2.module_el8+588+6f71ce7b) flex 2.6.1
  13   111.24 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 13.2.1 20231115 releases/gcc-13.2.0-463-g5d6f62c9b2 , clang version 16.0.6 flex 2.6.4
  14    74.64 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1 flex 2.6.4
  15    16.72 debian:11                     : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
        inlined from 'cmd_check' at builtin-check.c:132:3:
    /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error: '__builtin_strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
      106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    builtin-check.c: In function 'cmd_check':
    builtin-check.c:132:40: note: length computed here
      132 |   strncpy(feature_list, check.feature, strlen(check.feature)+1);
          |                                        ^~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
      CC      /tmp/build/perf/builtin-sched.o
      CC      /tmp/build/perf/builtin-timechart.o
      CC      /tmp/build/perf/builtin-trace.o
      CC      /tmp/build/perf/trace/beauty/clone.o
    In file included from /usr/include/string.h:495,
                     from /git/perf-6.6.0-rc1/tools/include/linux/bitmap.h:5,
                     from util/header.h:10,
                     from builtin-check.c:5:
    In function 'strncpy',
        inlined from 'cmd_check' at builtin-check.c:132:3:
    /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error: '__builtin_strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
      106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    builtin-check.c: In function 'cmd_check':
    builtin-check.c:132:40: note: length computed here
  16    86.95 debian:12                     : Ok   gcc (Debian 12.2.0-14) 12.2.0 , Debian clang version 14.0.6 flex 2.6.4
  17    87.12 debian:experimental           : Ok   gcc (Debian 13.2.0-6) 13.2.0 , Debian clang version 16.0.6 (17) flex 2.6.4
  18    29.86 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 13.2.0-6) 13.2.0  flex 2.6.4
  19    22.37 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 12.3.0-6) 12.3.0  flex 2.6.4
  20    22.58 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 12.3.0-6) 12.3.0  flex 2.6.4
  21    22.42 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 12.3.0-6) 12.3.0  flex 2.6.4
  22   111.30 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-3) , clang version 13.0.1 (Fedora 13.0.1-1.fc35) flex 2.6.4
  23   107.56 fedora:37                     : Ok   gcc (GCC) 12.3.1 20230508 (Red Hat 12.3.1-1) , clang version 15.0.7 (Fedora 15.0.7-2.fc37) flex 2.6.4
  24   100.41 fedora:38                     : Ok   gcc (GCC) 13.2.1 20231011 (Red Hat 13.2.1-4) , clang version 16.0.6 (Fedora 16.0.6-3.fc38) flex 2.6.4
  25    95.37 fedora:39                     : Ok   gcc (GCC) 13.2.1 20231011 (Red Hat 13.2.1-4) , clang version 17.0.3 (Fedora 17.0.3-1.fc39) flex 2.6.4
  26    95.00 fedora:40                     : Ok   gcc (GCC) 13.2.1 20231110 (Red Hat 13.2.1-5) , clang version 17.0.4 (Fedora 17.0.4-1.fc40) flex 2.6.4
  27    95.18 fedora:rawhide                : Ok   gcc (GCC) 13.2.1 20231110 (Red Hat 13.2.1-5) , clang version 17.0.4 (Fedora 17.0.4-1.fc40) flex 2.6.4
  28   109.86 gentoo:stage3                 : Ok   gcc (Gentoo 13.2.1_p20230826 p7) 13.2.1 20230826 , clang version 16.0.6 flex 2.6.4
  29   106.38 manjaro:base                  : Ok   gcc (GCC) 13.2.1 20230801 , clang version 16.0.6 flex 2.6.4
  30   132.00 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 15.0.7 flex 2.6.4
  31   133.47 opensuse:15.5                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 15.0.7 flex 2.6.4
  32   132.04 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 13.2.1 20230912 [revision b96e66fd4ef3e36983969fb8cdd1956f551a074b] , clang version 17.0.1 flex 2.6.4
  33   108.39 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-18.0.6) , clang version 15.0.7 (Red Hat 15.0.7-1.0.1.module+el8.8.0+20962+7ae483cf) flex 2.6.1
  34   108.26 oraclelinux:9                 : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4.3.0.4) , clang version 15.0.7 (Red Hat 15.0.7-2.0.1.el9) flex 2.6.4
  35   109.41 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-18) , clang version 15.0.7 (Red Hat 15.0.7-1.module+el8.8.0+1144+0a4e73bd) flex 2.6.1
  36   109.50 rockylinux:9                  : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.7 (Red Hat 15.0.7-2.el9) flex 2.6.4
  37    24.52 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  38    13.41 ubuntu:18.04-x-arm64          : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
  39    23.79 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  40    25.25 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  41    25.39 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  42    39.03 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  43    22.10 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  44    24.20 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  45    22.30 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  flex 2.6.4
  46    16.57 ubuntu:20.04                  : FAIL gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.2)
        inlined from 'cmd_check' at builtin-check.c:132:3:
    /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error: '__builtin_strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
      106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    builtin-check.c: In function 'cmd_check':
    builtin-check.c:132:40: note: length computed here
      132 |   strncpy(feature_list, check.feature, strlen(check.feature)+1);
          |                                        ^~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
      MKDIR   /tmp/build/perf/ui/
      MKDIR   /tmp/build/perf/tests/
      CC      /tmp/build/perf/ui/setup.o
      CC      /tmp/build/perf/tests/builtin-test.o
    In file included from /usr/include/string.h:495,
                     from /git/perf-6.6.0-rc1/tools/include/linux/bitmap.h:5,
                     from util/header.h:10,
                     from builtin-check.c:5:
    In function 'strncpy',
        inlined from 'cmd_check' at builtin-check.c:132:3:
    /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error: '__builtin_strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
      106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    builtin-check.c: In function 'cmd_check':
    builtin-check.c:132:40: note: length computed here
  47    99.20 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0 , Ubuntu clang version 14.0.0-1ubuntu1.1 flex 2.6.4
  48    94.57 ubuntu:23.04                  : Ok   gcc (Ubuntu 12.3.0-1ubuntu1~23.04) 12.3.0 , Ubuntu clang version 15.0.7 flex 2.6.4
  49    94.24 ubuntu:23.10                  : Ok   gcc (Ubuntu 13.2.0-4ubuntu3) 13.2.0 , Ubuntu clang version 16.0.6 (15) flex 2.6.4
