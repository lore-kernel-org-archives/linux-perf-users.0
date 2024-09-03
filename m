Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3714A06;
	Tue,  3 Sep 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372100; cv=none; b=E4DLiCMgEM20VieWrm4KS+gm2muBtzjdKYSXACwuUwNi6O4+Lnb8spORQOwkvvLGQVU3lDoetqp0kkSDtFaHbnD8WgUpuQ9guW4l5D6tPoXZVBBRmmf5SUT0xUEAdI1f+zGz473qf2auOyJ7aXAfuEeVQhh3uYOz4Xo6TxnskbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372100; c=relaxed/simple;
	bh=dTT0S78Dc3nmmCLqO9HMGM+dRiCO5S/9a1tMC3Cf8NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIz7aCJIEG5qcc2aRrXvzdfkG4JxPXFoipxPwHUchgTXBz7cRXXqlxAbvktC8l+3Tcvk2M+yAQiepEZ6yE2sWGofHpZYVC98NqizFit7z+sdYoSfdDy0+vUfokBNYNGon1BKWSp/0G15SXoCYNacZxdxwLkNx8l6paF+FVZtM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOT0nQb+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOT0nQb+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D55C4CEC4;
	Tue,  3 Sep 2024 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725372100;
	bh=dTT0S78Dc3nmmCLqO9HMGM+dRiCO5S/9a1tMC3Cf8NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOT0nQb+f7ZhkPA8azVACOmw/NHVd7277EoXhHMIDpkOd6DqGe6JU/AZAETCOyLn0
	 SCcY9I4/erLsjJfsJpmMezUjhCFZy5MbxOYg7snazr6lk5qYTa2ngLs5mIHmEGSTbG
	 bc9ICPG5+D7xdWR8KThOAPS2dirkinw1ubudO8qEBFdMttvPIYGvQclF+Xm7t1py4D
	 fRitzSddYyUg1ohXsbDxmQbSGN8iBgUuBoualrwW1zBVLZtllcOwxOayvxsrMy6evh
	 rTT3lWlo5CNWGhAC4XTfWmzBwfGU3dWCm32H6i0MknjAkr+aTJGcsB3rUEqp8015Hw
	 yTkHL/kkapZxA==
Date: Tue, 3 Sep 2024 11:01:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZtcWwANOWyXEnGdC@x1>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
 <ZtRIla5pCqlMIKvN@google.com>
 <Ztbga0xLyt1eaehi@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ztbga0xLyt1eaehi@x1>

On Tue, Sep 03, 2024 at 07:09:47AM -0300, Arnaldo Carvalho de Melo wrote:
>    3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
> WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
>     17.58 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC) 
>     util/llvm-c-helpers.cpp: In function ‘char* make_symbol_relative_string(dso*, const char*, u64, u64)’:
>     util/llvm-c-helpers.cpp:150:52: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
>       150 |                 snprintf(buf, sizeof(buf), "%s+0x%lx",
>           |                                                  ~~^
>           |                                                    |
>           |                                                    long unsigned int
>           |                                                  %llx
>       151 |                          demangled ? demangled : sym_name, addr - base_addr);
>           |                                                            ~~~~~~~~~~~~~~~~
>           |                                                                 |
>           |                                                                 u64 {aka long long unsigned int}
>     cc1plus: all warnings being treated as errors
>     make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2

The one above is fixed by the patch at the end, that I already added to
the cset where the problem was being introduced.

Now there is something a bit more tricky, we'll have to add a feature
check to see if the libllvm has what is needed if this appears in some
distro we still want to support, since alpine 3.16 has what is needed
I'll take the opportunity to drop test building on alpine 3.15.

FYI, so far:

perfbuilder@number:~$ time dm
   1   101.42 almalinux:8       : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-22) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8.10.0+3757+fc27b834) flex 2.6.1
   2    89.34 almalinux:9       : Ok   gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9) flex 2.6.4
   3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
   104.86 almalinux:9-i386      : Ok   gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9) flex 2.6.4
   4    16.20 alpine:3.15                   : FAIL gcc version 10.3.1 20211027 (Alpine 10.3.1_git20211027) 
    util/llvm-c-helpers.cpp: In function 'char* llvm_name_for_code(dso*, const char*, u64)':
    util/llvm-c-helpers.cpp:178:21: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
      178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
          |                     ^~~~~~~~~~~~
    util/llvm-c-helpers.cpp:178:49: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
      178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
          |                                                 ^~~~~~~~~~~~
    make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
   5   119.65 alpine:3.16       : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
   6    98.62 alpine:3.17       : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
   7   101.00 alpine:3.18       : Ok   gcc (Alpine 12.2.1_git20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
   8   106.74 alpine:3.19       : Ok   gcc (Alpine 13.2.1_git20231014) 13.2.1 20231014 , Alpine clang version 17.0.5 flex 2.6.4
   9   103.22 alpine:3.20       : Ok   gcc (Alpine 13.2.1_git20240309) 13.2.1 20240309 , Alpine clang version 17.0.6 flex 2.6.4
  10   109.79 alpine:edge       : Ok   gcc (Alpine 14.2.0) 14.2.0 , Alpine clang version 18.1.8 flex 2.6.4
  11    87.75 amazonlinux:2023  : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn2023.0.1) flex 2.6.4

- Arnaldo

diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
index 4070e2d5682fd674..663bcaba2041fc25 100644
--- a/tools/perf/util/llvm-c-helpers.cpp
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -11,6 +11,7 @@
 #include <llvm/Support/TargetSelect.h>
 #pragma GCC diagnostic pop
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <linux/compiler.h>
@@ -147,7 +148,7 @@ make_symbol_relative_string(struct dso *dso, const char *sym_name,
 	char *demangled = dso__demangle_sym(dso, 0, sym_name);
 	if (base_addr && base_addr != addr) {
 		char buf[256];
-		snprintf(buf, sizeof(buf), "%s+0x%lx",
+		snprintf(buf, sizeof(buf), "%s+0x%" PRIx64,
 			 demangled ? demangled : sym_name, addr - base_addr);
 		free(demangled);
 		return strdup(buf);
