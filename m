Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C33EBF32
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2026 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771380341; cv=none; b=GggYJMv4cndlKXXlSAiondWMF/tyfH1/HjZEMzKjEqm2K6vcgSI/J8sreiS0ci8y8EfSGk6uIcTR/y9Hm7JrCal8Xb8Tb3cg6Kq/BeFQZjjDYX6zN0/5tsJWClyM4HJWvMAumV/ROfHEZhJuD/90Xxs3sgsB2NCMV0+Kx67hjxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771380341; c=relaxed/simple;
	bh=FYfWd6LzeNGx9vaiS3lA072eM0HsQlknDj8PHzu/gMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbHFp/YC5eBhkSrlAkt53AllJFO6s6TxU6Q+ymWX79lUU1zeK84yrLAgw/CSSJzb1PY/Ef/UZHf/YJOJgg/XtH9BKqqvzJIa992CHQNyJ5Rg3eI7IGiPbaK+kLKbQzSBPQPJElPw4DqeUMSknMEM9lTcTGwiV9rp57uc9jLjWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlUfYq3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlUfYq3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF5AC4CEF7;
	Wed, 18 Feb 2026 02:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771380341;
	bh=FYfWd6LzeNGx9vaiS3lA072eM0HsQlknDj8PHzu/gMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlUfYq3QKJV4mdHHAD3/yD6umImypZj8xo3vWPDyW5fW7Y67kzvfSeHWgq3BFBEVL
	 JJUJ67rvLQkT0iF42iglds6BirhP81Qm6otDq0dgUOCIvZCY6VJJzkdm/jSo5IRzii
	 OFoHwLUiTCO7Dq9ec++mMSoyMfA2/qTOZyD2OReaZBRAR/yBZBrknRjP0Lixiohk/8
	 QC6Y5vtejWRMAJ0b6yl7RjdsD2RT5SGCbeWYlC4r3PtyoLfVVqvnoqEne/f98B3PkY
	 RtroeCm6zmG4haByYea33OgU5Fn5oTtTvnTQWBHz+POBMlpGAFabziNOO78z3VtTU2
	 dRbONE71vy4eA==
Date: Tue, 17 Feb 2026 18:05:39 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Noel Grandin <noelgrandin@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: why is 'perf record --call-graph' using addr2line?
Message-ID: <aZUec9wQyPawz4cW@google.com>
References: <CAFYHVnXddP=V-q=0Z3Na1FOBaQRT3RA55ruDY=O0pNpbaSc4jg@mail.gmail.com>
 <aYo334TnekI8UgpY@x1>
 <CAFYHVnV8h-ZcckoYKER127U5cYvvsye0iXfgQ2aA0ddr_ivrTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFYHVnV8h-ZcckoYKER127U5cYvvsye0iXfgQ2aA0ddr_ivrTA@mail.gmail.com>

Hello,

On Tue, Feb 17, 2026 at 01:47:02PM +0200, Noel Grandin wrote:
> On Mon, 9 Feb 2026 at 21:39, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Are you sure? addr2line can be used when using '-s srcline' or '-s
> > srcfile', but then in 'perf report', not on record.
> >
> 
> Yeah, that is what confused me too. I can see the addr2line
> sub-processes show up in ps.
> 
> For example, if I do ps -ef, I see stuff like:
> 
> noel     1259058  199773 10 13:45 pts/4    00:00:01
> /usr/lib/linux-tools/6.17.0-14-generic/perf record
> --call-graph=dwarf,32000 --pid=1258658
> noel     1259067 1259058 42 13:45 pts/4    00:00:01 addr2line -e
> /home/noel/.debug/.build-id/40/d2427b70abca4c5530fc6abe4b64acfe039146/elf
> -a -i -f
> noel     1259068 1259058  9 13:45 pts/4    00:00:00 addr2line -e
> /home/noel/.debug/.build-id/99/2e0e9c5b545f70d957da48ca4fa0062cc086c9/elf
> -a -i -f
> noel     1259069 1259058  2 13:45 pts/4    00:00:00 addr2line -e
> /home/noel/.debug/.build-id/71/9539027bc2d800b08810a3847206e283f8f347/elf
> -a -i -f
> noel     1259070 1259058 22 13:45 pts/4    00:00:00 addr2line -e
> /home/noel/.debug/.build-id/38/2eb792f7961162be41274fa3c1aae864f9cde7/elf
> -a -i -f
> noel     1259071 1259058 11 13:45 pts/4    00:00:00 addr2line -e
> /home/noel/.debug/.build-id/ed/fe3aec8836926683342a0efcb4d8e44eb8521a/elf
> -a -i -f
> noel     1259072 1259058 41 13:45 pts/4    00:00:00 addr2line -e
> /home/noel/.debug/.build-id/e8/fc08b1b0ce4130c26f40b13470d484fc2f6f55/elf
> -a -i -f
> noel     1259074 1259058  1 13:45 pts/4    00:00:00 addr2line -e
> /home/noel/.debug/.build-id/f4/8422093b1a8f666e0ef64ff6a3842d83206274/elf
> -a -i -f
> noel     1259075 1259058  2 13:45 pts/4    00:00:00 addr2line -e
> /home/noel/.debug/.build-id/55/43d41f3e8e476763d436e15d5a8e287d7ea677/elf
> -a -i -f
> noel     1259076 1259058  0 13:45 pts/4    00:00:00 addr2line -e
> /home/noel/.debug/.build-id/74/eaf539c3959f449ac8bd93ff882cd7b2990290/elf
> -a -i -f
> noel     1259077 1259058  5 13:45 pts/4    00:00:00 addr2line -e
> /home/noel/.debug/.build-id/8e/9fd827446c24067541ac5390e6f527fb5947bb/debug
> -a -i -f
> 
> > Can you give more details? Do you have anything in ~/.perfconfig, etc?
> 
> I do not have such a file.

That's ok and it means you don't have any specific config.

> 
> Note that in this case I am not doing system-wide profiling, just
> profiling a single process.

I think we turned on (since v6.17) the build-id collection on the
callstacks (commit 29be60c93d2d9300) at the end of perf record.
That may run addr2line to get inlined functions.

There's a recent change to use libdw to speed up inline function
processing.  But it's gonna take some time to land on the distro.

In the meantime, I think you can disable the build-ID entirely with -B
option.

Thanks,
Namhyung

