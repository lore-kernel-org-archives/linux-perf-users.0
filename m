Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AC19995D;
	Thu, 22 Aug 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346766; cv=none; b=a7vbiJ1cjnBqEU4GRlRBnPiN6Rq7tdyE+tmS0gNPPCjDq52uKJ0vLJf1EFcu3vBlhRLk+YR6yeKqzChXRnji0hkPmzM+g7PfvtGBb7L33vB3WBPXSdjOBbYb3ayy+uvgfjstwuiUtufOVSPMSRFg4kDjJTlhDVuHNeUHWZMxNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346766; c=relaxed/simple;
	bh=5Kuz5r6O6ybAxLbOJKEYjD5BuDZKylHdvrJjA90RVis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwG9SYHW8lilzGizh/Ml3bYkuSsWUjMMH3fBW65fQES+L//jln5mivGHZWrXUFTv6ohfl4tOOJt+fx7rAU2OflMy/LB8o0H4ShOUM8io0BtcYa/Ki5ZMZlxA4iVM9jz4IAveQVbugyYW9cpzPH7QT/9dmdpBfvSQ2sgLDcHkdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o11WOgOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o11WOgOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B48C32782;
	Thu, 22 Aug 2024 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724346766;
	bh=5Kuz5r6O6ybAxLbOJKEYjD5BuDZKylHdvrJjA90RVis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o11WOgOzp52LmEZiVqP2LfRIox5pfMeD5ozCJUuwZS1h9SY0sb1ojEZnRskFH+8qP
	 cNilRjpBKZLeDpPs77Id2PrvrPvmpnCBJtIk1ymS7Tx3hO3v+1sTUHVKhw0Nb/rpSK
	 vAINhABHpuEdNLqIXwUIJFoNV1PzvpQD16EBDQrg7d/DJ0mfiD+zTpCPgvJkYW3vs3
	 on22holRETSTETzWBVFL3Es4TClUGxipyO1paolO58sihkbMfXNotDjGtMCNxJs0FI
	 IswZIMBEZ5WFe9YWb46a644Obhm4MkK/NxqSBVzHZahWecYQjkqLA7F7YzJGMpOGqx
	 Bb+HspRUCzZig==
Date: Thu, 22 Aug 2024 14:12:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
Message-ID: <ZsdxinrZP1kHINWT@x1>
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1>
 <ZsdUxxBrpbuYxtXN@x1>
 <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>

On Thu, Aug 22, 2024 at 07:02:52PM +0200, Sedat Dilek wrote:
> On Thu, Aug 22, 2024 at 5:10 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > +++ b/tools/perf/util/setup.py
> > @@ -17,7 +17,7 @@ src_feature_tests  = getenv('srctree') + '/tools/build/feature'

> >  def clang_has_option(option):
> >      cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> > -    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
> > +    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
> >  if cc_is_clang:
> >      from sysconfig import get_config_vars
> > @@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
> >  cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> >  if cc_is_clang:
> >      cflags += ["-Wno-unused-command-line-argument" ]
> > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > +        cflags += ["-Wno-cast-function-type-mismatch" ]
> >  else:
> >      cflags += ['-Wno-cast-function-type' ]
 
> I tried with your diff with SLIM LLVM toolchains 18 and 19.
 
> Both work - see attached build-logs.
 
> Yes, are right that LLVM/Clang v19 was first introducing:
 
> -Wcast-function-type-mismatch / -Wno-cast-function-type-mismatch
 
> [4] says for LLVM 18.1.8:
 
> -Wcast-function-type
> -Wcast-function-type-strict
 
> Feel free to add my Reported-by/Tested-by credentials if you sent a full patch.

Thanks for the report and test of the fix, I'll add both tags,

Best regards,

- Arnaldo
 
> Thanks.
> 
> BR,
> -Sedat-
> 
> [1] https://mirrors.edge.kernel.org/pub/tools/llvm/
> [2] https://mirrors.edge.kernel.org/pub/tools/llvm/files/llvm-18.1.8-x86_64.tar.xz
> [3] https://mirrors.edge.kernel.org/pub/tools/llvm/files/llvm-19.1.0-rc3-x86_64.tar.xz
> [4] https://releases.llvm.org/18.1.8/tools/clang/docs/DiagnosticsReference.html
> [5] https://clang.llvm.org/docs/DiagnosticsReference.html



