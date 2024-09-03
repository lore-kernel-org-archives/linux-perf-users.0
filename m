Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5A1AD27F;
	Tue,  3 Sep 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358191; cv=none; b=FDWTp9yZRoGI4meL4NZ2jHIfJgPfxbtsJcRAt7PCC9g6GGE4p6UxnbH4lttEfyJyuHhqf9Xfw57P5p6zSFWMN4jBAF7RBQbNb2h6ktW4Jfk5m49ECMvcPYTizIXZmhWpywDTsEQJ9d9VXvbtjx3v5V1tOL89poLcqWxHe3Jy76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358191; c=relaxed/simple;
	bh=hJhnW1J0MnYQwBnhBo37+19gPvvBs+Mh3HX/l9vRD9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faDner0a90s0cZsJHH9IKIP8fdUoZX5ATbchZNUKCRdPzCGibGQIC6vFZrpVmTljYtWmvBfuvDpwYLoGzVgO83LxWWJPXqtAgGfy2xSYtxxS2xfp9FClbM5Ek8Ppgsz4BQ0L1+S9XznUp+vUCV9STRO1goXPuAOJ+RIZurRNHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSdQ+8hu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSdQ+8hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEC0C4CEC5;
	Tue,  3 Sep 2024 10:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358191;
	bh=hJhnW1J0MnYQwBnhBo37+19gPvvBs+Mh3HX/l9vRD9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSdQ+8hu9Xi3EolQSfosP84baYa81R7/LGrCIpmdbjmWdd2L5iSeo6nChyA/6I3bO
	 vKhcAxWSPLxyNUV3R0GDX5bBEMyYsgKYWJi5EYJmTdooiPAJyhHBD4t1s5PZoDE+y9
	 fH0jbo7GuXc5zDkFEWZFetpi7imN+0mx8ioHAcz8vgS8333n2LHEdZXhp+ANYoodTE
	 URZilUMDr1jCcFtqLPmtmoBThLNU9MCIpbZsd6blOTs7x4/jtSF5L2jGnDp2zW6N1L
	 vBhKBg7BUJP43BW+GlQpBDxA8uXdIGVZPckvpyBw5V96pU1ME5Khmt9OEMidRftrdq
	 BnUB7+fl7nJdw==
Date: Tue, 3 Sep 2024 07:09:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Ztbga0xLyt1eaehi@x1>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
 <ZtRIla5pCqlMIKvN@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtRIla5pCqlMIKvN@google.com>

On Sun, Sep 01, 2024 at 12:57:25PM +0200, Steinar H. Gunderson wrote:
> On Tue, Jul 30, 2024 at 04:49:12PM -0300, Arnaldo Carvalho de Melo wrote:
> > Unfortunately it clashed with recent patches in the capstone related
> > codebase, IIRC Athira's for powerpc data-type profiling.
> > 
> > […]
> > 
> > I'll continue processing other patched and eventually try to fix this if
> > you're busy,
> 
> Hi,
> 
> Is there any movement in getting v10 merged? :-) I haven't heard back
> since I sent out the rebase

Test building is detecting some problems, I'll try to address them:

perfbuilder@number:~$ time dm
   1    13.50 almalinux:8                   : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-22) (GCC) 
    util/srcline.c: In function 'dso__free_a2l':
    util/srcline.c:184:20: error: parameter name omitted
     void dso__free_a2l(struct dso *)
                        ^~~~~~~~~~~~
    make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
   2    68.46 almalinux:9                   : FAIL clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9)
    util/srcline.c:184:32: error: omitting the parameter name in a function definition is a C2x extension [-Werror,-Wc2x-extensions]
      184 | void dso__free_a2l(struct dso *)
          |                                ^
    1 error generated.
    make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
   3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
    17.58 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC) 
    util/llvm-c-helpers.cpp: In function ‘char* make_symbol_relative_string(dso*, const char*, u64, u64)’:
    util/llvm-c-helpers.cpp:150:52: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
      150 |                 snprintf(buf, sizeof(buf), "%s+0x%lx",
          |                                                  ~~^
          |                                                    |
          |                                                    long unsigned int
          |                                                  %llx
      151 |                          demangled ? demangled : sym_name, addr - base_addr);
          |                                                            ~~~~~~~~~~~~~~~~
          |                                                                 |
          |                                                                 u64 {aka long long unsigned int}
    cc1plus: all warnings being treated as errors
    make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
   4    18.08 alpine:3.15                   : FAIL gcc version 10.3.1 20211027 (Alpine 10.3.1_git20211027) 
    util/srcline.c: In function 'dso__free_a2l':
    util/srcline.c:184:20: error: parameter name omitted
      184 | void dso__free_a2l(struct dso *)
          |                    ^~~~~~~~~~~~
    make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
