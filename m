Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3178472;
	Tue,  3 Sep 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372944; cv=none; b=Daje4awQWivqlXIwfkGQfuglGv3M7lGYhhnO51sO7w916LrYxmowSu+IMXpd44NUoqpswW5UuUWO6Oi0xAuKsyJa93NeySuZ4UI/a2fObDp76UuHHS6VvcnZ0Z5o3ogzqKHyYMz//V/rdikaMKR/gNkTT4jpu99nDAFBsIUu+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372944; c=relaxed/simple;
	bh=xgIzu2IIi47LprKHZ6JLiwt4UHRjX45IhiHl7pIkjQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+AN0LDxaQlv1C2jv3VfWWl1shb1Tk1EFeolu7TQrY0FPxgpeTE8QPsF+O/oMOu92AMDANQQMm1P3b0Sp7XEttM/2L7enknbS0yRgN7LjSX7kHARhcMcbif7C883CwO8T7QafGURdsmkjt3Ds/RvHvORvnfAaKEDAUWO1ARbw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfTxP2Hj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfTxP2Hj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACF0C4CEC4;
	Tue,  3 Sep 2024 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725372944;
	bh=xgIzu2IIi47LprKHZ6JLiwt4UHRjX45IhiHl7pIkjQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfTxP2HjYa9XCGRevMuGZ0DuQyaMn/UExOOLwlQikVVxtaAT8N93H2fUJxqAz96Sg
	 AQh+4z1qOUws5Ww0pr6C+ztlaVrpxxa4IvuxsuAyfAHo/bAGdHJKMIQ0nuXzq2G/1n
	 BF9DdDIduGYYe8HwpOpUSDDXeTAsBwDWXVi9/MTpq8X17bjd2M8TCNjunkdVO3okuL
	 0xaW8fg3pyH6h9AXS1SK14OfGE/CB0sLjq6kF/nk63Mtjj7GNMFnG2TDeONdJwR4Un
	 ImtvuIM8lVJFqHVBLj0gvXLkA/bsGpQJmdaYzczes4nYguLAukDn49O2ey2/kbx01G
	 kiTVs5JCm0Rig==
Date: Tue, 3 Sep 2024 11:15:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZtcaC5WOTj-fh_Px@x1>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
 <ZtRIla5pCqlMIKvN@google.com>
 <Ztbga0xLyt1eaehi@x1>
 <ZtcWwANOWyXEnGdC@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtcWwANOWyXEnGdC@x1>

On Tue, Sep 03, 2024 at 11:01:36AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 03, 2024 at 07:09:47AM -0300, Arnaldo Carvalho de Melo wrote:
> >    3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
> > WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
> >     17.58 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC) 
> >     util/llvm-c-helpers.cpp: In function ‘char* make_symbol_relative_string(dso*, const char*, u64, u64)’:
> >     util/llvm-c-helpers.cpp:150:52: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
> >       150 |                 snprintf(buf, sizeof(buf), "%s+0x%lx",
> >           |                                                  ~~^
> >           |                                                    |
> >           |                                                    long unsigned int
> >           |                                                  %llx
> >       151 |                          demangled ? demangled : sym_name, addr - base_addr);
> >           |                                                            ~~~~~~~~~~~~~~~~
> >           |                                                                 |
> >           |                                                                 u64 {aka long long unsigned int}
> >     cc1plus: all warnings being treated as errors
> >     make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
> 
> The one above is fixed by the patch at the end, that I already added to
> the cset where the problem was being introduced.
> 
> Now there is something a bit more tricky, we'll have to add a feature
> check to see if the libllvm has what is needed if this appears in some
> distro we still want to support, since alpine 3.16 has what is needed
> I'll take the opportunity to drop test building on alpine 3.15.

Or, as I'll do with debian:11, just remove llvm-dev and not build the
features it enables:

  17    13.79 debian:11                     : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6) 
    util/llvm-c-helpers.cpp: In function 'char* llvm_name_for_code(dso*, const char*, u64)':
    util/llvm-c-helpers.cpp:178:21: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
      178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
          |                     ^~~~~~~~~~~~
    util/llvm-c-helpers.cpp:178:49: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
      178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
          |                                                 ^~~~~~~~~~~~
    make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
